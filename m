Return-Path: <netdev+bounces-170487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E4A48DE4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDB516E366
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E413CA8A;
	Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGPs7K3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F481386DA
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740705940; cv=none; b=Z53jVlFj2gis9cSy/JibwLoefBKNwXwrY8PhdOxDIm61oio4EEO9FHrha6tsoOCLdYnvOqA5ietRY45xRsmOMuxqtHJ0snpTNBOYUDwesZksdIXarGf3Dowhv1TBqDlqShNVgx+ARKoPMOwggpc9y9PhVdmaLWXqCw4Jx/B8n7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740705940; c=relaxed/simple;
	bh=aH8q+Hr9uIqQjzVxeElOymSaQH8idyelcpdRafozjfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El6enL2f159vYNLP/DIZ8VdEMvxZdDHY63ccHi08l+8xOVxorQCLhyBkEfUdqm5pOmN0hNkL6WQpT4tjfprEiFyfr8v1UadgSgKZWAKVaR8QR3X7KFdXNu9cTLv2P4yGljpZUYNcySvrqDwBmPzz8FiIT4S7rFSrnF5gR8sZHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGPs7K3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD43C4CEE7;
	Fri, 28 Feb 2025 01:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740705940;
	bh=aH8q+Hr9uIqQjzVxeElOymSaQH8idyelcpdRafozjfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGPs7K3phQof9h+TBfroY0Qt8RuU2zkYbwLXQKDv6A6j16I8xH0JTG8UxF8HaaLT1
	 bgTGpy+Tq/YXgCv+s7WjeitTbVCwDHWHkx3VnxQSlbZWpzeYQv7Tc7sGrTWJ8/MQ+b
	 SdCPy41zkA719jfMMZqhHnRR3L/Hmz0nqdOIED1Q2r0837TsojJNealK1hFpVMsZdA
	 jabpwV2JfXGxI4gpg4afQxQQHv51PyRLQuSnM7Ks+nfxOfeD+ncHvqmugT7PZhWj/j
	 kk8ggy3bcTOscmAG30YHpDOUNCUV6/JzxS/ZmkT7YalKBYFUZZx9oWj20Sb+MnQnq2
	 41jpYnyVI3PQA==
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
Subject: [PATCH net-next v2 6/9] eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
Date: Thu, 27 Feb 2025 17:25:31 -0800
Message-ID: <20250228012534.3460918-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228012534.3460918-1-kuba@kernel.org>
References: <20250228012534.3460918-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_tpa_end() skips calling bnxt_gro_skb() if it determines that GRO
should not be performed. For ease of packet counting pass the gro bool
into bnxt_gro_skb(), this way we have a single branch thru which all
non-GRO packets coming out of bnxt_tpa_end() should pass.

bnxt_gro_skb() is a static inline with a single caller, it will
be inlined so there is no concern about adding an extra call.

seg count will now be extracted every time, but tpa_end is touched
by bnxt_tpa_end(), the field extraction will make no practical
difference.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d8a24a8bcfe8..d4052bfcc4ff 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1735,6 +1735,7 @@ static struct sk_buff *bnxt_gro_func_5730x(struct bnxt_tpa_info *tpa_info,
 }
 
 static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
+					   bool gro,
 					   struct bnxt_tpa_info *tpa_info,
 					   struct rx_tpa_end_cmp *tpa_end,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
@@ -1744,7 +1745,7 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	u16 segs;
 
 	segs = TPA_END_TPA_SEGS(tpa_end);
-	if (segs == 1 || !IS_ENABLED(CONFIG_INET))
+	if (!gro || segs == 1 || !IS_ENABLED(CONFIG_INET))
 		return skb;
 
 	NAPI_GRO_CB(skb)->count = segs;
@@ -1917,10 +1918,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
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


