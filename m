Return-Path: <netdev+bounces-172239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6BA50F1E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEFB189307A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14017266B57;
	Wed,  5 Mar 2025 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKJJyHlK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF326659A
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215155; cv=none; b=F7PiZUoQiizBkrGda77wD5KVjCSifZbBpHKpEmE98hmrRPg5WkJpK1DJmLBrflZa+sD0/brhGT9tRRVkEK6Eq7r812AWLRFWN45LMDHY10LLftNxhDq/719nbyP5ouNsXMr8Y6NOUYWBRZcjD4iKdthpLM3Dm//a47Z52OAsi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215155; c=relaxed/simple;
	bh=jO7kihAP+Sb7V3Z6IYHTsg0B4M7LBa82xyGfMD578qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I35tJLg70uFoaQ0tup1NtlXFalpQxqctFcH/1FjaRsjlRHCnnYfmjSx49BfozXaHSHyo2xbgB/yYB3KfyyFMI2BBmXkr2ZsQLgOcn4tSyYINOYMloRTk9KnjL79QI2U03LGyGcs60oyihkBV2D6oqHocHU2rxMCO7ETic0g26/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKJJyHlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E397C4CEE9;
	Wed,  5 Mar 2025 22:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215154;
	bh=jO7kihAP+Sb7V3Z6IYHTsg0B4M7LBa82xyGfMD578qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKJJyHlKzHXfEfb0IoIR4awyzU3FFHwSsLHCaeIkE8OzlVmJMOoQvN8kLFxMZiqly
	 9ukwKfMBXhcn26C9bh5zyxPmX7dbx372tSgaXeqtkN0nfLGsj3+SW2nFYKxQ3vS3aJ
	 wmjMwNOIho75B/K4RnmPQHKGUjqdRstswGROaW/QlvvZupJdP5hBdY9x23d3gP5/UB
	 XVv3r8feqvOUVsOomcnGp/dDHma97zlcvrrz8+2oTypsKB6PyV1cr66YR2cHfWSZTQ
	 mLV4F/pbBXqMapK5aeNEyjbqmjZT8r1g9veaHU2ssUhRf8Auueq6Jrcu4JStagC/h5
	 0dQhHYUcqHJ4A==
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
Subject: [PATCH net-next v3 06/10] eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
Date: Wed,  5 Mar 2025 14:52:11 -0800
Message-ID: <20250305225215.1567043-7-kuba@kernel.org>
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

bnxt_tpa_end() skips calling bnxt_gro_skb() if it determines that GRO
should not be performed. For ease of packet counting pass the gro bool
into bnxt_gro_skb(), this way we have a single point thru which all
packets coming out of bnxt_tpa_end() should pass.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - flatten it harder, so we can reuse on normal Rx
v2: https://lore.kernel.org/20250228012534.3460918-7-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d8a24a8bcfe8..dba4779f0925 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1735,6 +1735,7 @@ static struct sk_buff *bnxt_gro_func_5730x(struct bnxt_tpa_info *tpa_info,
 }
 
 static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
+					   bool gro,
 					   struct bnxt_tpa_info *tpa_info,
 					   struct rx_tpa_end_cmp *tpa_end,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
@@ -1743,9 +1744,9 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	int payload_off;
 	u16 segs;
 
-	segs = TPA_END_TPA_SEGS(tpa_end);
+	segs = gro ? TPA_END_TPA_SEGS(tpa_end) : 1;
 	if (segs == 1 || !IS_ENABLED(CONFIG_INET))
-		return skb;
+		goto non_gro;
 
 	NAPI_GRO_CB(skb)->count = segs;
 	skb_shinfo(skb)->gso_size =
@@ -1756,8 +1757,12 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	else
 		payload_off = TPA_END_PAYLOAD_OFF(tpa_end);
 	skb = bp->gro_func(tpa_info, payload_off, TPA_END_GRO_TS(tpa_end), skb);
-	if (likely(skb))
-		tcp_gro_complete(skb);
+	if (!skb)
+		goto non_gro;
+
+	tcp_gro_complete(skb);
+
+non_gro: /* note: skb may be null! */
 	return skb;
 }
 
@@ -1917,10 +1922,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 			(tpa_info->flags2 & RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3;
 	}
 
-	if (gro)
-		skb = bnxt_gro_skb(bp, tpa_info, tpa_end, tpa_end1, skb);
-
-	return skb;
+	return bnxt_gro_skb(bp, gro, tpa_info, tpa_end, tpa_end1, skb);
 }
 
 static void bnxt_tpa_agg(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-- 
2.48.1


