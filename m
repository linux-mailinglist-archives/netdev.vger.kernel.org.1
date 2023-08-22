Return-Path: <netdev+bounces-29742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35677848E7
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D39328102F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F11DA2D;
	Tue, 22 Aug 2023 17:59:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A741D307
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:59:19 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 117CFC433CC;
	Tue, 22 Aug 2023 17:59:15 +0000 (UTC)
Subject: [PATCH net-next RFC v1 2/4] veth: use generic-XDP functions when
 dealing with SKBs
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, edumazet@google.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 22 Aug 2023 19:59:14 +0200
Message-ID: <169272715407.1975370.3989385869434330916.stgit@firesoul>
In-Reply-To: <169272709850.1975370.16698220879817216294.stgit@firesoul>
References: <169272709850.1975370.16698220879817216294.stgit@firesoul>
User-Agent: StGit/1.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The root-cause the realloc issue is that veth_xdp_rcv_skb() code path (that
handles SKBs like generic-XDP) is calling a native-XDP function
xdp_do_redirect(), instead of simply using xdp_do_generic_redirect() that can
handle SKBs.

The existing code tries to steal the packet-data from the SKB (and frees the SKB
itself). This cause issues as SKBs can have different memory models that are
incompatible with native-XDP call xdp_do_redirect(). For this reason the checks
in veth_convert_skb_to_xdp_buff() becomes more strict. This in turn makes this a
bad approach. Simply leveraging generic-XDP helpers e.g. generic_xdp_tx() and
xdp_do_generic_redirect() as this resolves the issue given netstack can handle
these different SKB memory models.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/veth.c |   69 ++++++++++++++++++++--------------------------------
 net/core/dev.c     |    1 +
 net/core/filter.c  |    1 +
 3 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index be7b62f57087..192547035194 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -713,19 +713,6 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	}
 }
 
-static void veth_xdp_get(struct xdp_buff *xdp)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	int i;
-
-	get_page(virt_to_page(xdp->data));
-	if (likely(!xdp_buff_has_frags(xdp)))
-		return;
-
-	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i]);
-}
-
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 					struct xdp_buff *xdp,
 					struct sk_buff **pskb)
@@ -837,7 +824,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	struct veth_xdp_buff vxbuf;
 	struct xdp_buff *xdp = &vxbuf.xdp;
 	u32 act, metalen;
-	int off;
+	int off, err;
 
 	skb_prepare_for_gro(skb);
 
@@ -860,30 +847,10 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 	switch (act) {
 	case XDP_PASS:
-		break;
 	case XDP_TX:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
-		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
-			trace_xdp_exception(rq->dev, xdp_prog, act);
-			stats->rx_drops++;
-			goto err_xdp;
-		}
-		stats->xdp_tx++;
-		rcu_read_unlock();
-		goto xdp_xmit;
 	case XDP_REDIRECT:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
-		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
-			stats->rx_drops++;
-			goto err_xdp;
-		}
-		stats->xdp_redirect++;
-		rcu_read_unlock();
-		goto xdp_xmit;
+		/* Postpone actions to after potential SKB geometry update */
+		break;
 	default:
 		bpf_warn_invalid_xdp_action(rq->dev, xdp_prog, act);
 		fallthrough;
@@ -894,7 +861,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		stats->xdp_drops++;
 		goto xdp_drop;
 	}
-	rcu_read_unlock();
 
 	/* check if bpf_xdp_adjust_head was used */
 	off = xdp->data - orig_data;
@@ -919,11 +885,32 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	else
 		skb->data_len = 0;
 
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	switch (act) {
+	case XDP_PASS:
+		/* This skb_pull's off mac_len, __skb_push'ed above */
+		skb->protocol = eth_type_trans(skb, rq->dev);
+		break;
+	case XDP_REDIRECT:
+		err = xdp_do_generic_redirect(rq->dev, skb, xdp, xdp_prog);
+		if (unlikely(err)) {
+			trace_xdp_exception(rq->dev, xdp_prog, act);
+			goto xdp_drop;
+		}
+		stats->xdp_redirect++;
+		rcu_read_unlock();
+		goto xdp_xmit;
+	case XDP_TX:
+		/* TODO: this can be optimized to be veth specific */
+		generic_xdp_tx(skb, xdp_prog);
+		stats->xdp_tx++;
+		rcu_read_unlock();
+		goto xdp_xmit;
+	}
+	rcu_read_unlock();
 out:
 	return skb;
 drop:
@@ -931,10 +918,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 xdp_drop:
 	rcu_read_unlock();
 	kfree_skb(skb);
-	return NULL;
-err_xdp:
-	rcu_read_unlock();
-	xdp_return_buff(xdp);
 xdp_xmit:
 	return NULL;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 17e6281e408c..1187bfced9ec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4987,6 +4987,7 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 		kfree_skb(skb);
 	}
 }
+EXPORT_SYMBOL_GPL(generic_xdp_tx);
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..a6fd7ba901ba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4443,6 +4443,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 	_trace_xdp_redirect_err(dev, xdp_prog, ri->tgt_index, err);
 	return err;
 }
+EXPORT_SYMBOL_GPL(xdp_do_generic_redirect);
 
 BPF_CALL_2(bpf_xdp_redirect, u32, ifindex, u64, flags)
 {



