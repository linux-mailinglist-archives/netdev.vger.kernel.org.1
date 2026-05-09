Return-Path: <netdev+bounces-286122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DqfLVP1/mlv0AAAu9opvQ
	(envelope-from <netdev+bounces-286122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A84FED74
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AADE3009B07
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB19939183B;
	Sat,  9 May 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITHbX4A1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEC39099B;
	Sat,  9 May 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316558; cv=none; b=rXOHc5q2/xvtfO4UMvDRhhkkJTZg5r2VD7cbW+zXKgCXV/HEkTd40f5rwo+AUhF4oyNdDZbZpsQH8mUbFh9qcaEcEI+syq3MEMf8HzpBskfvd9/4NPkn+3AZL7Ftx5QAl6PuIpKD5hunZ84T+ThRAa3U5UeRubvel/lOmW4d8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316558; c=relaxed/simple;
	bh=pl1Xx0tVbaiRgLP8g5tLwpo8SEPids2dO0V8E0zz0GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMNZEv6dIanCD9ExqLik3UEIrsW2u1PoGkQJLzGa9EzrkIA3sX5JyJFGnzou8g3qYkhdn5v22HxsnZYUbZ3MYSFZZKgIXG15To5jozapNEwHUbWJOORTeLUubCVDgnJGxqvzcwGPfo2FoI+EYJx4GIghTnCxwgCizhkTtkqelvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITHbX4A1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778316558; x=1809852558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pl1Xx0tVbaiRgLP8g5tLwpo8SEPids2dO0V8E0zz0GI=;
  b=ITHbX4A130gWJWqZ/w9vFKv1XF4uUpsT0A7Sab/c5rH8R3AEDRP82fL1
   wQwpHb+k7oQEg/Wbd+Na0ab0SY+1k8tB0eAIZ5Rc+mehOvd1+ebkpDfVd
   L0Z/EKEojSy0Qfxln/7Zc0LymiT7mjkYnSSgaolj6aTYZu/uhDozjpskP
   pCBxGNgvvcn3u1HY27p/oJUzE0KPJz7FXfbJpAVpSTwelOr8RfOIhLOCt
   Qq01F/MCc90iDp/5DjC6DPChz5fcqVoUmU15bWKpq3MjOoLn+a+33pbY4
   Z1Z5+pkWNF9EhWnEmIylnnKs+Wt+wGMxQnvgVkFiOxUXiFwvCEuAqXxV+
   g==;
X-CSE-ConnectionGUID: hxGurzUkSpaCylYvHJlUfQ==
X-CSE-MsgGUID: 8cijjAfNSwKOg35sX7Cm8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748774"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748774"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:49:17 -0700
X-CSE-ConnectionGUID: Wye7BAibSliCpwl/IiQ4sQ==
X-CSE-MsgGUID: zNJvn3aXSfK/gHS5eyzF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237088168"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2026 01:49:14 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	lorenzo@kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH RFC net-next 4/4] veth: use generic skb XDP handling
Date: Sat,  9 May 2026 10:48:58 +0200
Message-Id: <20260509084858.773921-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E9A84FED74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286122-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

veth currently runs XDP for skb-backed packets by constructing an
xdp_buff and then, for XDP_TX and XDP_REDIRECT, converting that
skb-backed xdp_buff into an xdp_frame. The backing memory is still
skb-owned, so veth has to pin the skb data and frags manually before
consuming the skb.

Use the generic skb XDP helper for skb-backed packets instead. This
keeps skb-backed packets on the skb generic XDP path: XDP_REDIRECT uses
xdp_do_generic_redirect() and XDP_TX uses generic_xdp_tx(). Packets that
already arrive as xdp_frames keep using the existing veth xdp_frame path.

veth still provides its own page_pool and xdp_rxq_info through struct
xdp_generic_ctx. It also keeps using struct veth_xdp_buff storage so
metadata kfuncs that need the skb continue to work after a possible skb
COW.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/veth.c | 179 +++++++++------------------------------------
 1 file changed, 36 insertions(+), 143 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e35df717e65e..4120a69f7e02 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -49,6 +49,10 @@ struct veth_stats {
 	u64	xdp_drops;
 	u64	xdp_tx;
 	u64	xdp_tx_err;
+	/* skb-backed XDP_TX is handled immediately by generic_xdp_tx().
+	 * xdp_frame XDP_TX is accounted from veth_xdp_flush_bq().
+	 */
+	u64 xdp_skb_tx;
 	u64	peer_tq_xdp_xmit;
 	u64	peer_tq_xdp_xmit_err;
 };
@@ -63,7 +67,6 @@ struct veth_rq {
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
 	struct net_device	*dev;
 	struct bpf_prog __rcu	*xdp_prog;
-	struct xdp_mem_info	xdp_mem;
 	struct veth_rq_stats	stats;
 	bool			rx_notify_masked;
 	struct ptr_ring		xdp_ring;
@@ -648,10 +651,15 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 	if (likely(xdp_prog)) {
 		struct veth_xdp_buff vxbuf;
 		struct xdp_buff *xdp = &vxbuf.xdp;
+		struct xdp_rxq_info rxq;
 		u32 act;
 
 		xdp_convert_frame_to_buff(frame, xdp);
-		xdp->rxq = &rq->xdp_rxq;
+
+		rxq = rq->xdp_rxq;
+		rxq.mem.type = frame->mem_type;
+		xdp->rxq = &rxq;
+
 		vxbuf.skb = NULL;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
@@ -663,19 +671,16 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			break;
 		case XDP_TX:
 			orig_frame = *frame;
-			xdp->rxq->mem.type = frame->mem_type;
 			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 				trace_xdp_exception(rq->dev, xdp_prog, act);
 				frame = &orig_frame;
 				stats->rx_drops++;
 				goto err_xdp;
 			}
-			stats->xdp_tx++;
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			orig_frame = *frame;
-			xdp->rxq->mem.type = frame->mem_type;
 			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 				frame = &orig_frame;
 				stats->rx_drops++;
@@ -735,69 +740,20 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
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
-static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
-					struct xdp_buff *xdp,
-					struct sk_buff **pskb)
-{
-	struct sk_buff *skb = *pskb;
-	u32 frame_sz;
-
-	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
-			goto drop;
-
-		skb = *pskb;
-	}
-
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = skb_end_pointer(skb) - skb->head;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
-	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
-			 skb_headlen(skb), true);
-
-	if (skb_is_nonlinear(skb)) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
-	*pskb = skb;
-
-	return 0;
-drop:
-	consume_skb(skb);
-	*pskb = NULL;
-
-	return -ENOMEM;
-}
-
 static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 					struct sk_buff *skb,
-					struct veth_xdp_tx_bq *bq,
 					struct veth_stats *stats)
 {
-	void *orig_data, *orig_data_end;
 	struct bpf_prog *xdp_prog;
 	struct veth_xdp_buff vxbuf;
-	struct xdp_buff *xdp = &vxbuf.xdp;
-	u32 act, metalen;
-	int off;
+	struct xdp_generic_ctx ctx = {
+		.skb_cow_check = skb_needs_xdp_cow,
+		.page_pool = rq->page_pool,
+		.xdp_rxq = &rq->xdp_rxq,
+		.xdp_skb = &vxbuf.skb,
+		.xdp = &vxbuf.xdp,
+	};
+	int ret;
 
 	skb_prepare_for_gro(skb);
 
@@ -808,94 +764,33 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		goto out;
 	}
 
-	__skb_push(skb, skb->data - skb_mac_header(skb));
-	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
-		goto drop;
-	vxbuf.skb = skb;
-
-	orig_data = xdp->data;
-	orig_data_end = xdp->data_end;
-
-	act = bpf_prog_run_xdp(xdp_prog, xdp);
-
-	switch (act) {
+	ret = __do_xdp_generic(xdp_prog, &skb, &ctx);
+	switch (ctx.act) {
 	case XDP_PASS:
 		break;
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
+		if (!ctx.err)
+			stats->xdp_skb_tx++;
+		break;
 	case XDP_REDIRECT:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
-		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
+		if (ctx.err)
 			stats->rx_drops++;
-			goto err_xdp;
-		}
-		stats->xdp_redirect++;
-		rcu_read_unlock();
-		goto xdp_xmit;
+		else
+			stats->xdp_redirect++;
+		break;
 	default:
-		bpf_warn_invalid_xdp_action(rq->dev, xdp_prog, act);
-		fallthrough;
 	case XDP_ABORTED:
-		trace_xdp_exception(rq->dev, xdp_prog, act);
-		fallthrough;
 	case XDP_DROP:
 		stats->xdp_drops++;
-		goto xdp_drop;
+		break;
 	}
 	rcu_read_unlock();
 
-	/* check if bpf_xdp_adjust_head was used */
-	off = orig_data - xdp->data;
-	if (off > 0)
-		__skb_push(skb, off);
-	else if (off < 0)
-		__skb_pull(skb, -off);
-
-	skb_reset_mac_header(skb);
-
-	/* check if bpf_xdp_adjust_tail was used */
-	off = xdp->data_end - orig_data_end;
-	if (off != 0)
-		__skb_put(skb, off); /* positive on grow, negative on shrink */
-
-	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
-	 */
-	if (xdp_buff_has_frags(xdp))
-		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
-	else
-		skb->data_len = 0;
-
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
-	metalen = xdp->data - xdp->data_meta;
-	if (metalen)
-		skb_metadata_set(skb, metalen);
+	if (ret == XDP_PASS)
+		return skb;
+	return NULL;
 out:
 	return skb;
-drop:
-	stats->rx_drops++;
-xdp_drop:
-	rcu_read_unlock();
-	kfree_skb(skb);
-	return NULL;
-err_xdp:
-	rcu_read_unlock();
-	xdp_return_buff(xdp);
-xdp_xmit:
-	return NULL;
 }
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
@@ -931,7 +826,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct sk_buff *skb = ptr;
 
 			stats->xdp_bytes += skb->len;
-			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
+			skb = veth_xdp_rcv_skb(rq, skb, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
 					netif_receive_skb(skb);
@@ -947,7 +842,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 
 	u64_stats_update_begin(&rq->stats.syncp);
 	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
+	rq->stats.vs.xdp_tx += stats->xdp_skb_tx;
 	rq->stats.vs.xdp_bytes += stats->xdp_bytes;
+	rq->stats.vs.xdp_tx_err += stats->xdp_tx_err;
 	rq->stats.vs.xdp_drops += stats->xdp_drops;
 	rq->stats.vs.rx_drops += stats->rx_drops;
 	rq->stats.vs.xdp_packets += done;
@@ -979,7 +876,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
-	if (stats.xdp_tx > 0)
+	if (bq.count > 0)
 		veth_xdp_flush(rq, &bq);
 	xdp_clear_return_frame_no_direct();
 
@@ -1123,13 +1020,10 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 			goto err_rxq_reg;
 
 		err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
-						 MEM_TYPE_PAGE_SHARED,
+						 MEM_TYPE_PAGE_POOL_OR_SHARED,
 						 NULL);
 		if (err < 0)
 			goto err_reg_mem;
-
-		/* Save original mem info as it can be overwritten */
-		rq->xdp_mem = rq->xdp_rxq.mem;
 	}
 	return 0;
 
@@ -1156,7 +1050,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
-		rq->xdp_rxq.mem = rq->xdp_mem;
 		xdp_rxq_info_unreg(&rq->xdp_rxq);
 
 		if (delete_napi)
-- 
2.43.0


