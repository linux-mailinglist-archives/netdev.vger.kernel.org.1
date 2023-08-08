Return-Path: <netdev+bounces-25256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9F7737A4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 05:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA2B1C20E53
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E6D518;
	Tue,  8 Aug 2023 03:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25017F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 03:21:00 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB071E7
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:20:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bba54f7eefso40769775ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464857; x=1692069657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzvycUSp6fj3lhy6v0s47NdlhPCC8jzqygliYQ4HaF8=;
        b=NvVq2h/3LxshBlFB6gD30775uo3/1fXs1KQJKJFoXl/OGNxuF83Tu9AIGUcdDtSWix
         TbsEnaXloQxMxlKaCVptTVgdab0tdTLokOycU/saAgyxbajhxKhjG0JFKl+S2ntaQDEi
         H/BkS3UzYJXQTbydd1Fh8rJ28tHVdjdslTXSLoKRAaE6VlD7bwEbCCHTjH2Yl/CtlOgq
         qE8YFjdsbQs2aSzfcriCwjrjvYqmwhvsFV5aopNlV9BEMdlZ9Dcqo9riMIPW6sSi4gWL
         WHT5FQQxnzB4mD3NT1+4b1bHu+7RUbCzfXxMfDLL5kYnoz3Gbztq3ildDRlo8jDGdh0u
         QzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464857; x=1692069657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzvycUSp6fj3lhy6v0s47NdlhPCC8jzqygliYQ4HaF8=;
        b=EXxOWf7gr0YO4ZveNdz8rLCpGfZbC5shMJun/AF0Lfn7XJb0u6WssUp07xTlnzJTgy
         wcNQcb9SGO5Pmvp+VlJRzH44/BNRlNBvwx4fATbGUkc9zWUTe/GgrvKo0W2CUdPeclzZ
         deXKDaIbwNY1AawCmSTHATsf/c76L4ZfrL70UP5rxv4PV/AmtLFrPxmzMcy9kXjf2IIz
         M2zDBNg10apt3/gggn5bmFIVVbhg4LK2q1J9RxeN5uXbQC+rHDhSYWTHQLc/W35+Q5I7
         5w/yijleV6J5WxgQBsqXLc6k6tLBUJCpE4qskJC4mIK9ixW6jEMDzodDXgiV6O/cQPtc
         pPZQ==
X-Gm-Message-State: AOJu0YwHHrgZgavxMV50d3JQAnqnTdChIl/ztf/JOOtiCMsnZDAo+mG2
	rCzXcVwQ1RMEVJxJAxINuiH49Q==
X-Google-Smtp-Source: AGHT+IGczbp6+PgAEbO1oFEDSNGLeIH6sbO9lcpT91LZiAk8F7bvXkch/TPiWwysUhcrgcO4FE55Mg==
X-Received: by 2002:a17:902:6bc1:b0:1b6:6a14:3734 with SMTP id m1-20020a1709026bc100b001b66a143734mr8363404plt.29.1691464857325;
        Mon, 07 Aug 2023 20:20:57 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:56 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 5/9] veth: use send queue tx napi to xmit xsk tx desc
Date: Tue,  8 Aug 2023 11:19:09 +0800
Message-Id: <20230808031913.46965-6-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

use send queue tx napi to xmit xsk tx desc

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 230 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 25faba879505..28b891dd8dc9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -27,6 +27,8 @@
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
 #include <net/page_pool.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xdp.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -1061,6 +1063,141 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
+static struct sk_buff *veth_build_skb(void *head, int headroom, int len,
+				      int buflen)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(head, buflen);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
+{
+	struct veth_priv *priv, *peer_priv;
+	struct net_device *dev, *peer_dev;
+	struct veth_stats stats = {};
+	struct sk_buff *skb = NULL;
+	struct veth_rq *peer_rq;
+	struct xdp_desc desc;
+	int done = 0;
+
+	dev = sq->dev;
+	priv = netdev_priv(dev);
+	peer_dev = priv->peer;
+	peer_priv = netdev_priv(peer_dev);
+
+	/* todo: queue index must set before this */
+	peer_rq = &peer_priv->rq[sq->queue_index];
+
+	/* set xsk wake up flag, to do: where to disable */
+	if (xsk_uses_need_wakeup(xsk_pool))
+		xsk_set_tx_need_wakeup(xsk_pool);
+
+	while (budget-- > 0) {
+		unsigned int truesize = 0;
+		struct page *page;
+		void *vaddr;
+		void *addr;
+
+		if (!xsk_tx_peek_desc(xsk_pool, &desc))
+			break;
+
+		addr = xsk_buff_raw_get_data(xsk_pool, desc.addr);
+
+		/* can not hold all data in a page */
+		truesize =  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+		truesize += desc.len + xsk_pool->headroom;
+		if (truesize > PAGE_SIZE) {
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			stats.xdp_drops++;
+			break;
+		}
+
+		page = dev_alloc_page();
+		if (!page) {
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			stats.xdp_drops++;
+			break;
+		}
+		vaddr = page_to_virt(page);
+
+		memcpy(vaddr + xsk_pool->headroom, addr, desc.len);
+		xsk_tx_completed_addr(xsk_pool, desc.addr);
+
+		skb = veth_build_skb(vaddr, xsk_pool->headroom, desc.len, PAGE_SIZE);
+		if (!skb) {
+			put_page(page);
+			stats.xdp_drops++;
+			break;
+		}
+		skb->protocol = eth_type_trans(skb, peer_dev);
+		napi_gro_receive(&peer_rq->xdp_napi, skb);
+
+		stats.xdp_bytes += desc.len;
+		done++;
+	}
+
+	/* release, move consumer，and wakeup the producer */
+	if (done) {
+		napi_schedule(&peer_rq->xdp_napi);
+		xsk_tx_release(xsk_pool);
+	}
+
+	u64_stats_update_begin(&sq->stats.syncp);
+	sq->stats.vs.xdp_packets += done;
+	sq->stats.vs.xdp_bytes += stats.xdp_bytes;
+	sq->stats.vs.xdp_drops += stats.xdp_drops;
+	u64_stats_update_end(&sq->stats.syncp);
+
+	return done;
+}
+
+static int veth_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct veth_sq *sq = container_of(napi, struct veth_sq, xdp_napi);
+	struct xsk_buff_pool *pool;
+	int done = 0;
+
+	sq->xsk.last_cpu = smp_processor_id();
+
+	/* xmit for tx queue */
+	rcu_read_lock();
+	pool = rcu_dereference(sq->xsk.pool);
+	if (pool)
+		done  = veth_xsk_tx_xmit(sq, pool, budget);
+
+	rcu_read_unlock();
+
+	if (done < budget) {
+		/* if done < budget, the tx ring is no buffer */
+		napi_complete_done(napi, done);
+	}
+
+	return done;
+}
+
+static int veth_napi_add_tx(struct net_device *dev)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		struct veth_sq *sq = &priv->sq[i];
+
+		netif_napi_add(dev, &sq->xdp_napi, veth_poll_tx);
+		napi_enable(&sq->xdp_napi);
+	}
+
+	return 0;
+}
+
 static int veth_create_page_pool(struct veth_rq *rq)
 {
 	struct page_pool_params pp_params = {
@@ -1153,6 +1290,19 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 	}
 }
 
+static void veth_napi_del_tx(struct net_device *dev)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		struct veth_sq *sq = &priv->sq[i];
+
+		napi_disable(&sq->xdp_napi);
+		__netif_napi_del(&sq->xdp_napi);
+	}
+}
+
 static void veth_napi_del(struct net_device *dev)
 {
 	veth_napi_del_range(dev, 0, dev->real_num_rx_queues);
@@ -1360,7 +1510,7 @@ static void veth_set_xdp_features(struct net_device *dev)
 		struct veth_priv *priv_peer = netdev_priv(peer);
 		xdp_features_t val = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
-				     NETDEV_XDP_ACT_RX_SG;
+				     NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 		if (priv_peer->_xdp_prog || veth_gro_requested(peer))
 			val |= NETDEV_XDP_ACT_NDO_XMIT |
@@ -1737,11 +1887,89 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return err;
 }
 
+static int veth_xsk_pool_enable(struct net_device *dev, struct xsk_buff_pool *pool, u16 qid)
+{
+	struct veth_priv *peer_priv;
+	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer_dev = priv->peer;
+	int err = 0;
+
+	if (qid >= dev->real_num_tx_queues)
+		return -EINVAL;
+
+	if (!peer_dev)
+		return -EINVAL;
+
+	/* no dma, so we just skip dma skip in xsk zero copy */
+	pool->dma_check_skip = true;
+
+	peer_priv = netdev_priv(peer_dev);
+
+	/* enable peer tx xdp here, this side
+	 * xdp is enable by veth_xdp_set
+	 * to do: we need to check whther this side is already enable xdp
+	 * maybe it do not have xdp prog
+	 */
+	if (!(peer_priv->_xdp_prog) && (!veth_gro_requested(peer_dev))) {
+		/*  peer should enable napi*/
+		err = veth_napi_enable(peer_dev);
+		if (err)
+			return err;
+	}
+
+	/* Here is already protected by rtnl_lock, so rcu_assign_pointer
+	 * is safe.
+	 */
+	rcu_assign_pointer(priv->sq[qid].xsk.pool, pool);
+
+	veth_napi_add_tx(dev);
+
+	return err;
+}
+
+static int veth_xsk_pool_disable(struct net_device *dev, u16 qid)
+{
+	struct veth_priv *peer_priv;
+	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer_dev = priv->peer;
+	int err = 0;
+
+	if (qid >= dev->real_num_tx_queues)
+		return -EINVAL;
+
+	if (!peer_dev)
+		return -EINVAL;
+
+	peer_priv = netdev_priv(peer_dev);
+
+	/* to do: this may be failed */
+	if (!(peer_priv->_xdp_prog) && (!veth_gro_requested(peer_dev))) {
+		/*  disable peer napi */
+		veth_napi_del(peer_dev);
+	}
+
+	veth_napi_del_tx(dev);
+
+	rcu_assign_pointer(priv->sq[qid].xsk.pool, NULL);
+	return err;
+}
+
+/* this  is for setup xdp */
+static int veth_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	if (xdp->xsk.pool)
+		return veth_xsk_pool_enable(dev, xdp->xsk.pool, xdp->xsk.queue_id);
+	else
+		return veth_xsk_pool_disable(dev, xdp->xsk.queue_id);
+}
+
 static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return veth_xdp_set(dev, xdp->prog, xdp->extack);
+	case XDP_SETUP_XSK_POOL:
+		return veth_xsk_pool_setup(dev, xdp);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


