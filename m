Return-Path: <netdev+bounces-172240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52328A50F1D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F35316BDA8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4F266EEA;
	Wed,  5 Mar 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT3OOD8j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5ED266B6E
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215155; cv=none; b=OGpJxpXd487V935y6u5eKduyS2QG4eskZaMDhlsR5jHKHeT93irZ0QD8m4B/rjs4Ya7Snq/3TWUmwDFKBpeS5Wutey4KyALg2pUAQ/3QsHsufW4y0GpymaDCQNGZq+GheEpk3Dcq8c1sgA1QBDx/+qqTSfdXyWouCrFLnd5X+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215155; c=relaxed/simple;
	bh=IY20lfkY+UNYlWGCZFCHdOtNVnxbujeCAbHCmOJ+44E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaDzABKLNAr6OhLCsm7srB6Fuo0Od6nIP3u66AcY3XkyDEVpwZxLTzVVeaxgwOYg02UQ6zEbVjxOriHKhFPbxoKlUGmKq/KJMFTMmxvLyWJFMKfFRSE3RgkWPuzXG2OvY8cLhmqpyZRwWZUXC63UpjJNvH/O++DRyrth3pnB9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT3OOD8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0FFC4CEEA;
	Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215155;
	bh=IY20lfkY+UNYlWGCZFCHdOtNVnxbujeCAbHCmOJ+44E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT3OOD8jKI7VdY+OAGk9+sE31vGyy32v0A1KgSyS4+mM7yY7A+gNF6MxNqN/SclhA
	 3LSA9kVlXOm5UrSvoe7pJ0dOc7vvWaVuTJunEZHpOtBTbKFirk9+kVg/jenvPODuuF
	 jjIRJkrYVEM1EB0pQG0jBO3hff66RmvHTaCHb8p3Gv8bTu6fV6eo3q1EMcO975iHBS
	 fZkOGA01CivkytgNc0E6I8JeMLd6jT9gIkB54XRMnMTj1YDmMkvoA4KDh7Oou5anFN
	 ztYTZpVShdMqy0qDDzXyC42Tzv4MwRIHijkhSk2+pTlc+TMoY3tezzwUkzhtxYVIKD
	 tBHWceMf1xAFQ==
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
Subject: [PATCH net-next v3 07/10] eth: bnxt: extract VLAN info early on
Date: Wed,  5 Mar 2025 14:52:12 -0800
Message-ID: <20250305225215.1567043-8-kuba@kernel.org>
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

Michael would like the SW stats to include VLAN bytes, perhaps
uniquely among ethernet drivers. To do this we need to extract
the VLAN info before we call XDP, so before skb is allocated.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 42 ++++++++++-------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index dba4779f0925..b0a9e3c6b377 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1966,45 +1966,36 @@ static bool bnxt_rx_ts_valid(struct bnxt *bp, u32 flags,
 	return true;
 }
 
-static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
-				    struct rx_cmp *rxcmp,
-				    struct rx_cmp_ext *rxcmp1)
+static u32
+bnxt_rx_vlan(u8 cmp_type, struct rx_cmp *rxcmp, struct rx_cmp_ext *rxcmp1)
 {
-	__be16 vlan_proto;
-	u16 vtag;
+	u16 vlan_proto = 0, vtag = 0;
 
 	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
 		__le32 flags2 = rxcmp1->rx_cmp_flags2;
 		u32 meta_data;
 
 		if (!(flags2 & cpu_to_le32(RX_CMP_FLAGS2_META_FORMAT_VLAN)))
-			return skb;
+			return 0;
 
 		meta_data = le32_to_cpu(rxcmp1->rx_cmp_meta_data);
 		vtag = meta_data & RX_CMP_FLAGS2_METADATA_TCI_MASK;
-		vlan_proto = htons(meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SFT);
-		if (eth_type_vlan(vlan_proto))
-			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
-		else
-			goto vlan_err;
+		vlan_proto = meta_data >> RX_CMP_FLAGS2_METADATA_TPID_SFT;
 	} else if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
 		if (RX_CMP_VLAN_VALID(rxcmp)) {
 			u32 tpid_sel = RX_CMP_VLAN_TPID_SEL(rxcmp);
 
 			if (tpid_sel == RX_CMP_METADATA1_TPID_8021Q)
-				vlan_proto = htons(ETH_P_8021Q);
+				vlan_proto = ETH_P_8021Q;
 			else if (tpid_sel == RX_CMP_METADATA1_TPID_8021AD)
-				vlan_proto = htons(ETH_P_8021AD);
+				vlan_proto = ETH_P_8021AD;
 			else
-				goto vlan_err;
+				vlan_proto = 0xffff;
 			vtag = RX_CMP_METADATA0_TCI(rxcmp1);
-			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
 		}
 	}
-	return skb;
-vlan_err:
-	dev_kfree_skb(skb);
-	return NULL;
+
+	return (u32)vlan_proto << 16 | vtag;
 }
 
 static enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
@@ -2049,6 +2040,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
 	u32 flags, misc;
+	u32 vlan_info;
 	u32 cmpl_ts;
 	void *data;
 	int rc = 0;
@@ -2163,6 +2155,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	if (cmp_type == CMP_TYPE_RX_L2_CMP)
 		dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
 
+	vlan_info = bnxt_rx_vlan(cmp_type, rxcmp, rxcmp1);
+	if (vlan_info && !eth_type_vlan(htons(vlan_info >> 16)))
+		goto next_rx;
+
 	if (bnxt_xdp_attached(bp, rxr)) {
 		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
 		if (agg_bufs) {
@@ -2246,11 +2242,9 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 	skb->protocol = eth_type_trans(skb, dev);
 
-	if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
-		skb = bnxt_rx_vlan(skb, cmp_type, rxcmp, rxcmp1);
-		if (!skb)
-			goto next_rx;
-	}
+	if (vlan_info && skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX)
+		__vlan_hwaccel_put_tag(skb, htons(vlan_info >> 16),
+				       vlan_info & 0xffff);
 
 	skb_checksum_none_assert(skb);
 	if (RX_CMP_L4_CS_OK(rxcmp1)) {
-- 
2.48.1


