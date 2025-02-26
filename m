Return-Path: <netdev+bounces-169997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF3A46D15
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36297A3306
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885625A2AF;
	Wed, 26 Feb 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj6gWWTo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4125A2A4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604219; cv=none; b=Za2OCIsBzYbZS+vxScwCZEcknlDYBYUzVVdAtFc8l6bpeZes246mMo+fYCV7BwvRqsgxWmJrbeh5ImgfQZgHi8mW9K7TFXEOtetAWHIifGACeaF96BFrZ1vrxyrSBRfQnGhTjSPqG4J1W8YIZBHbxSVFsAlEYfM8qrUnDoicAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604219; c=relaxed/simple;
	bh=Vm4M2SQc2Re/GPyD7IcIEGvrg+2XSdudhWIjiH+/Tk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8U0PTM4qOb0lrfXgyC2ptkHjsi15iWjttYCVdcpJTLT3eV1Tz0SwXQWeo8vVdO9/MTs5vLDTAYBwsOwOwtYcgQqWh0wtsGoqRp1rAm3EWE0L5iyYn6dByyj7btwlLHhAhnu83PcGrArmwJpK9uJm5IeEK0b78RnwBcf4E/TQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj6gWWTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7F2C4CEE9;
	Wed, 26 Feb 2025 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604219;
	bh=Vm4M2SQc2Re/GPyD7IcIEGvrg+2XSdudhWIjiH+/Tk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mj6gWWToAChZK471tiHAoMskBee9dJmVToybxh0MW3KxRo9K/2JKD3AufW3Q9JawK
	 rwmcUyI/fUlU4JyBuDwMtHwIv7tofuSPur44hJm4O2jjd+UBkUfKW4OhQKWQjoQv8Q
	 ZqbxaaeNupDYfsyD193x+8m+IH/i4Is3LToomcrOXNIawISfqKfhm7n9F1cLfbUnUY
	 HDSSl1Y5HeOnVQBqhuTfM5ynPAuuSYNtvY1KyG1nSBXg58nardY/weydj4+FyGhhTQ
	 fK+DJmFz16QK1nxlZ9k08BIVBpustlsfC6tP0E2ZK8H16+zwir/zVJooUIYxBmpja5
	 s1w5Qdi+H6B9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/9] eth: bnxt: don't run xdp programs on fallback traffic
Date: Wed, 26 Feb 2025 13:09:56 -0800
Message-ID: <20250226211003.2790916-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211003.2790916-1-kuba@kernel.org>
References: <20250226211003.2790916-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XDP program attached to the PF should not be executed
on the fallback traffic. Compile tested only.

Well behaved drivers (nfp) do not execute XDP on fallback
traffic, but perhaps this is a matter of opinion rather than
a hard rule, therefore I'm not considering this a fix.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f6a26f6f85bb..53b689800e1c 100644
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
@@ -2171,7 +2175,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		xdp_active = true;
 	}
 
-	if (xdp_active) {
+	if (xdp_active && dev == bp->dev) {
 		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
@@ -2239,8 +2243,6 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
 	}
 
-	if (cmp_type == CMP_TYPE_RX_L2_CMP)
-		dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
 	skb->protocol = eth_type_trans(skb, dev);
 
 	if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
-- 
2.48.1


