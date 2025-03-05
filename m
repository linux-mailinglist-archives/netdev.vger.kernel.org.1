Return-Path: <netdev+bounces-172236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB2A50F1B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBC18930A3
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A1209663;
	Wed,  5 Mar 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUpK3bJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAE208986
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215153; cv=none; b=ShQQDAejke+CupiaxXujLicsclODtokTraPpXimURYz4hTQiUx8XktsH6Dc6+G50t1sRxcLafayW1rHaGsjYNJj+P1pA4OQ1m+pwnINHCGIQgt+fdO21vbQN0Ok5fQYflfssH4tz8hOoQTEJangOTB75bdUdpw/NdgE/xwNb/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215153; c=relaxed/simple;
	bh=5FwXI0JHZeEs/jdTBFDkRhfXA548Trn5OFBR8o0iA4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d07h5DOxEVQBmabGju09vPu5wP48nGFBCmAA1+H+y+x4rhr3HqVIFo7aJmEoNw1kTK6zr9Zxqa+wwJLxyXKIkorxZEVAG4aAUfsmsH+wRp5oqfuwqsKijff0odrVp6YM9VTT5LcL20DvL7RDI7eVXKQ6QvjpX/6eug56j4Qp1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUpK3bJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89B3C4CEE9;
	Wed,  5 Mar 2025 22:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215153;
	bh=5FwXI0JHZeEs/jdTBFDkRhfXA548Trn5OFBR8o0iA4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUpK3bJbyd3xdLg378hU/WnIaOrKemac4a3I9bz4wmtMdMaLwBK8+fv5YVhe9R29I
	 Pg2VX44dUWpEk74jW8qwrnAia3yUthCBmu9JJwYdWxECxPjrEkwT61BCwzwXgebEsO
	 PrQflikhZS0TQ2RNmrir8Gv/zWBNyYoIU+Voczqk68dnCfc29K2aJKkhCl/RwT3xcb
	 bv4Lf7IBKIznDgFvSqqL1aiFDHkOrkXv99Gb/3H2lIpdd508pozFggLnu8L74iurU4
	 gTSuIXGqVWSqMA9mSCz5Yn20BaIlkpweJ9if1ox+tk7/Dg8OuScwxs01L1GT9weV/Y
	 P+5dbpN57zhyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 02/10] eth: bnxt: don't run xdp programs on fallback traffic
Date: Wed,  5 Mar 2025 14:52:07 -0800
Message-ID: <20250305225215.1567043-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305225215.1567043-1-kuba@kernel.org>
References: <20250305225215.1567043-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XDP program attached to the PF should not be executed
on the fallback traffic. Pass the desired dev to bnxt_rx_xdp()
and abort if the packet is for a representor. bnxt_rx_xdp()
has a lot of arguments already, so presumably adding one
more is okay.

Compile tested only.

Well behaved drivers (nfp) do not execute XDP on fallback
traffic, but perhaps this is a matter of opinion rather than
a hard rule, therefore I'm not considering this a fix.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - pass dev to bnxt_rx_xdp(), and skip just the BPF execution,
   to avoid unintentionally skipping the Tx ring handling
v1: https://lore.kernel.org/20250226211003.2790916-3-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 11 +++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  8 ++++++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 0122782400b8..752b6cf0022c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -17,7 +17,8 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   dma_addr_t mapping, u32 len,
 				   struct xdp_buff *xdp);
 void bnxt_tx_int_xdp(struct bnxt *bp, struct bnxt_napi *bnapi, int budget);
-bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
+bool bnxt_rx_xdp(struct bnxt *bp, struct net_device *dev,
+		 struct bnxt_rx_ring_info *rxr, u16 cons,
 		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event);
 int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f6a26f6f85bb..94bc9121d3f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2036,7 +2036,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
-	struct net_device *dev = bp->dev;
+	struct net_device *dev;
 	struct rx_cmp *rxcmp;
 	struct rx_cmp_ext *rxcmp1;
 	u32 tmp_raw_cons = *raw_cons;
@@ -2159,6 +2159,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	len = flags >> RX_CMP_LEN_SHIFT;
 	dma_addr = rx_buf->mapping;
 
+	dev = bp->dev;
+	if (cmp_type == CMP_TYPE_RX_L2_CMP)
+		dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
+
 	if (bnxt_xdp_attached(bp, rxr)) {
 		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
 		if (agg_bufs) {
@@ -2172,7 +2176,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, dev, rxr, cons, &xdp, data, &data_ptr, &len,
+				event)) {
 			rc = 1;
 			goto next_rx;
 		}
@@ -2239,8 +2244,6 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
 	}
 
-	if (cmp_type == CMP_TYPE_RX_L2_CMP)
-		dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
 	skb->protocol = eth_type_trans(skb, dev);
 
 	if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e6c64e4bd66c..aba49ddb0e66 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -221,7 +221,8 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
  * true    - packet consumed by XDP and new buffer is allocated.
  * false   - packet should be passed to the stack.
  */
-bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
+bool bnxt_rx_xdp(struct bnxt *bp, struct net_device *dev,
+		 struct bnxt_rx_ring_info *rxr, u16 cons,
 		 struct xdp_buff *xdp, struct page *page, u8 **data_ptr,
 		 unsigned int *len, u8 *event)
 {
@@ -246,7 +247,10 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 	/* BNXT_RX_PAGE_MODE(bp) when XDP enabled */
 	orig_data = xdp->data;
 
-	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	if (bp->dev == dev)
+		act = bpf_prog_run_xdp(xdp_prog, xdp);
+	else /* packet is for a VF representor */
+		act = XDP_PASS;
 
 	tx_avail = bnxt_tx_avail(bp, txr);
 	/* If the tx ring is not full, we must not update the rx producer yet
-- 
2.48.1


