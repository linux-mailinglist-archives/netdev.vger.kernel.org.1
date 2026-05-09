Return-Path: <netdev+bounces-286121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAPhAh71/mlv0AAAu9opvQ
	(envelope-from <netdev+bounces-286121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C14624FED3F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8627300E018
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC5390CB4;
	Sat,  9 May 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTgPyOJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0C390C90;
	Sat,  9 May 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316555; cv=none; b=KSalWW34GE6fBo9f7qU9dfCInBQwLmyWJRylReT7y780D8eZk69fEHiT5GksDFKUDu/mF8ncB4PcYbOg0SB12E8FUbEwuOnp6N1j118EY0LSLtgSCTHJ2SFPfGmgvRs5uWQv7S/VJ/TKR1V+QmCYd8LgRm+zpDzG5DRnM5EI1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316555; c=relaxed/simple;
	bh=LN0jKrXg3HdIfy223OpmAeTGP/vvV3RkqsagP9h/lII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2xhX1CI6nOQp74N19wy7OBUmhsSZvs0qaeUEcIO+GXhZV54FP41cg2Z9M2i7iWbiPPpcO8UGGqwYvc4YiUMfJTTatliS71EMS2l4hMEC0z+zvv9d1RlLZDe34vKOwg9AKkcnmoy5ApuQyzq6CfpHlhBoiFvY8j3bXOZBdsbRQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTgPyOJ5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778316554; x=1809852554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LN0jKrXg3HdIfy223OpmAeTGP/vvV3RkqsagP9h/lII=;
  b=QTgPyOJ5pFf8cMnifLvkG/69vM+GKJgrMqL+RlOpgn6Rtek353Bydt2M
   Ne1P5IiXTklyyFkJNygeE9hNiVFWQ/7h+6K50GLzGE1dafnfIhP0v/XT2
   oCXZaoVsbtp0rpQ4zIr+B0tHAxM5zAxnWgAyS0H5detfNzzskUZVFEWvc
   +MuXuJKgxrv/va7Hc1p4U8bkeIy/b/m1BtbnnsNElwbWBQ0XG7gwrTHVW
   Vi2PSpUX7XZJ9recp6jgwGMheQHxiY1wqJ+Fj6Kn1PJehNPOyV8FTNhi5
   lSPVWW3vHwqJ6049be5qPWeP7y6aO84c8bg25jSA8LO76jiz9LnW+5q4H
   g==;
X-CSE-ConnectionGUID: 3RJuuS/5R++zVuHnDe3vMg==
X-CSE-MsgGUID: qqn92LZiQIG3HdDkPKYm9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748742"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748742"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:49:14 -0700
X-CSE-ConnectionGUID: HrN/dqarT7mRXaOUqmYkLQ==
X-CSE-MsgGUID: xAZCKKdGQna6s6adfEbegg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237088163"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2026 01:49:11 -0700
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
Subject: [PATCH RFC net-next 3/4] xdp: split generic XDP skb handling
Date: Sat,  9 May 2026 10:48:57 +0200
Message-Id: <20260509084858.773921-4-maciej.fijalkowski@intel.com>
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
X-Rspamd-Queue-Id: C14624FED3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286121-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

veth has its own page_pool and xdp_rxq_info and also embeds struct
xdp_buff into a larger context used by its metadata kfuncs. At the same
time, the skb-backed veth XDP path currently open-codes most of what
generic XDP already does and then converts skb-backed xdp_buffs into
xdp_frames for XDP_TX and XDP_REDIRECT.

Add a lower-level generic XDP helper, __do_xdp_generic(), that lets
callers provide a small context object. The context carries the
caller-provided xdp_buff storage, optional page_pool and optional
xdp_rxq_info, and returns the actual XDP action and redirect error to
the caller. A NULL page_pool keeps the existing behaviour and uses the
per-CPU system page_pool. A NULL xdp_rxq_info keeps deriving the rxq
from the skb device/rx queue.

This lets drivers such as veth preserve stats and redirect flush
decisions while using the generic skb XDP action handling.

Address also existing bpf_prog_run_generic_xdp() callsites
({cpu,dev}map) so they can keep on using netdev's xdp_rxq_info.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/linux/netdevice.h |  31 +++++++++++
 net/core/dev.c            | 106 ++++++++++++++++++++++++++++----------
 2 files changed, 111 insertions(+), 26 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 473b18b0bb63..7d7c88a33328 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4253,9 +4253,40 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 	dev_kfree_skb_any_reason(skb, SKB_CONSUMED);
 }
 
+struct page_pool;
+struct xdp_rxq_info;
+
+/**
+ * struct xdp_generic_ctx - caller context for skb-backed generic XDP
+ * @xdp: caller-provided xdp_buff storage
+ * @page_pool: optional page_pool used when skb COW is needed
+ * @xdp_rxq: optional rxq used to initialise @xdp
+ * @xdp_skb: optional pointer updated with the skb used for the XDP run
+ * @skb_cow_check: caller-selected skb COW predicate, required
+ * @act: actual XDP action returned by the program
+ * @err: redirect error, valid when @act is XDP_REDIRECT
+ *
+ * If @page_pool is NULL, the generic path uses the per-CPU system
+ * page_pool. If @xdp_rxq is NULL, the generic path derives the rxq
+ * from the skb device/rx-queue, preserving existing do_xdp_generic()
+ * behaviour.
+ */
+struct xdp_generic_ctx {
+	struct xdp_buff *xdp;
+	struct page_pool *page_pool;
+	struct xdp_rxq_info *xdp_rxq;
+	struct sk_buff **xdp_skb;
+	bool (*skb_cow_check)(const struct sk_buff *skb);
+	u32 act;
+	int err;
+};
+
+bool skb_needs_xdp_cow(const struct sk_buff *skb);
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog);
 int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
+int __do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb,
+		     struct xdp_generic_ctx *ctx);
 int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 09012cdea376..f6770ca6f1bd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5445,11 +5445,11 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 	return rxqueue;
 }
 
-u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
-			     const struct bpf_prog *xdp_prog)
+static u32 __bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+				      const struct bpf_prog *xdp_prog,
+				      struct xdp_rxq_info *xdp_rxq)
 {
 	void *orig_data, *orig_data_end, *hard_start;
-	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
 	u32 mac_len, frame_sz;
 	__be16 orig_eth_type;
@@ -5467,8 +5467,13 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
 	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
+	if (!xdp_rxq) {
+		struct netdev_rx_queue *rxqueue;
+
+		rxqueue = netif_get_rxqueue(skb);
+		xdp_rxq = &rxqueue->xdp_rxq;
+	}
+	xdp_init_buff(xdp, frame_sz, xdp_rxq);
 	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
 			 skb_headlen(skb) + mac_len, true);
 	if (skb_is_nonlinear(skb)) {
@@ -5547,15 +5552,27 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
+u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
+			     const struct bpf_prog *xdp_prog)
+{
+	return __bpf_prog_run_generic_xdp(skb, xdp, xdp_prog, NULL);
+}
+
 static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
+netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog,
+			struct page_pool *page_pool)
 {
 	struct sk_buff *skb = *pskb;
 	int err, hroom, troom;
 
-	local_lock_nested_bh(&system_page_pool.bh_lock);
-	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
-	local_unlock_nested_bh(&system_page_pool.bh_lock);
+	if (page_pool) {
+		err = skb_cow_data_for_xdp(page_pool, pskb, prog);
+	} else {
+		local_lock_nested_bh(&system_page_pool.bh_lock);
+		err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool),
+					   pskb, prog);
+		local_unlock_nested_bh(&system_page_pool.bh_lock);
+	}
 	if (!err)
 		return 0;
 
@@ -5573,9 +5590,29 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
 	return skb_linearize(skb);
 }
 
+bool skb_needs_xdp_cow(const struct sk_buff *skb)
+{
+	/* Keep this predicate aligned with the old veth skb->xdp_buff
+	 * conversion rules. A page_pool-backed COW is needed when the skb head
+	 * cannot be reused as-is, when frags need to be made page_pool backed,
+	 * or when the XDP headroom contract is not met.
+	 */
+	return skb_shared(skb) || skb_head_is_locked(skb) ||
+	       skb_shinfo(skb)->nr_frags ||
+	       skb_headroom(skb) < XDP_PACKET_HEADROOM;
+}
+EXPORT_SYMBOL_GPL(skb_needs_xdp_cow);
+
+static bool generic_skb_needs_xdp_cow(const struct sk_buff *skb)
+{
+	return skb_cloned(skb) || skb_is_nonlinear(skb) ||
+	       skb_headroom(skb) < XDP_PACKET_HEADROOM;
+}
+
 static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
-				     const struct bpf_prog *xdp_prog)
+				     const struct bpf_prog *xdp_prog,
+				     struct xdp_generic_ctx *ctx)
 {
 	struct sk_buff *skb = *pskb;
 	u32 mac_len, act = XDP_DROP;
@@ -5593,15 +5630,20 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 	mac_len = skb->data - skb_mac_header(skb);
 	__skb_push(skb, mac_len);
 
-	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
-	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
-		if (netif_skb_check_for_xdp(pskb, xdp_prog))
+	if (INDIRECT_CALL_2(ctx->skb_cow_check,
+			    generic_skb_needs_xdp_cow,
+			    skb_needs_xdp_cow,
+			    skb)) {
+		if (netif_skb_check_for_xdp(pskb, xdp_prog, ctx->page_pool))
 			goto do_drop;
 	}
 
 	__skb_pull(*pskb, mac_len);
 
-	act = bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
+	if (ctx->xdp_skb)
+		*ctx->xdp_skb = *pskb;
+
+	act = __bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog, ctx->xdp_rxq);
 	switch (act) {
 	case XDP_REDIRECT:
 	case XDP_TX:
@@ -5660,27 +5702,27 @@ int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+int __do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb,
+		     struct xdp_generic_ctx *ctx)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
-	if (xdp_prog) {
-		struct xdp_buff xdp;
-		u32 act;
-		int err;
+	ctx->act = XDP_PASS;
+	ctx->err = 0;
 
+	if (xdp_prog) {
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
-		if (act != XDP_PASS) {
-			switch (act) {
+		ctx->act = netif_receive_generic_xdp(pskb, ctx->xdp, xdp_prog, ctx);
+		if (ctx->act != XDP_PASS) {
+			switch (ctx->act) {
 			case XDP_REDIRECT:
-				err = xdp_do_generic_redirect((*pskb)->dev, *pskb,
-							      &xdp, xdp_prog);
-				if (err)
+				ctx->err = xdp_do_generic_redirect((*pskb)->dev, *pskb,
+								   ctx->xdp, xdp_prog);
+				if (ctx->err)
 					goto out_redir;
 				break;
 			case XDP_TX:
-				generic_xdp_tx(*pskb, xdp_prog);
+				ctx->err = generic_xdp_tx(*pskb, xdp_prog);
 				break;
 			}
 			bpf_net_ctx_clear(bpf_net_ctx);
@@ -5694,6 +5736,18 @@ int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
+EXPORT_SYMBOL_GPL(__do_xdp_generic);
+
+int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
+{
+	struct xdp_generic_ctx ctx = {};
+	struct xdp_buff xdp;
+
+	ctx.xdp = &xdp;
+	ctx.skb_cow_check = generic_skb_needs_xdp_cow;
+
+	return __do_xdp_generic(xdp_prog, pskb, &ctx);
+}
 EXPORT_SYMBOL_GPL(do_xdp_generic);
 
 static int netif_rx_internal(struct sk_buff *skb)
-- 
2.43.0


