Return-Path: <netdev+bounces-170000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D1A46D18
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC601887D36
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F525B697;
	Wed, 26 Feb 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYbgcr5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CE25B67F
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604221; cv=none; b=Qn8U3WK5Yd+j3F//AsBfIbpA226N+mkAKXYu2KAs3fuUKHeSCyCnGqYtms0g+DCAF7b8aTLcsAUbxQynfPErj7FOPNIPykVblQktXIRCjmI3p9idv7K4/GHE3bPpqBOPX9N80CJSbtM4pdtsSTxuJ1Yq6yvy0zz3U7n32x7ZEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604221; c=relaxed/simple;
	bh=3ehmKTaJ1QBeEkMfmsIqtL7Ih26KgFWgLF0Pb6G/cLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdqFGBWoqHrpYvn03a/ceD8bzbVNRtOH6J5nwJn5AEjh3u4gjAcEl0ONoh0w3WYhXcZv985+XXxGmQNy2QVqOSCdjPTBPJ1MsadsatXBnAjJ+mX+UfsegZURv+FbRUivVnhxZXP0LAwD9c7798rHq/HEcQEC3fgXNN/iGCMxof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYbgcr5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328DAC4CEEC;
	Wed, 26 Feb 2025 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740604220;
	bh=3ehmKTaJ1QBeEkMfmsIqtL7Ih26KgFWgLF0Pb6G/cLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYbgcr5/SLGcd73sI/Z0FLs51tTsKygdnLuVtMk25xSLI4rDKjS5DO4hFhQ6MutxV
	 rc3/4lkP66Qrp4TbZE2V4VeROj+1onGoJ+sKuQBZqleGwImRm0ZegGSGEcxgzSPJ7i
	 i3m7fHqd83vasUBEZ2VHMFzhvCnIOI/TZaH6336eWYTO02NBTbj6i5fI0Sud+0HObN
	 k2BXcaA7uHSIG5QrCWGFYklgjqOlXYlbViLNltoP/BakHvL9AtTkCFYZBCBKxXhR57
	 rse+yzh+BnZsSg5FWKb0nl0PKkymrnkJiZShwSB5AAWAS4oFbThj8Bo/I3HKVSbfDY
	 r1hk0vv2KIYkw==
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
Subject: [PATCH net-next 5/9] eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
Date: Wed, 26 Feb 2025 13:09:59 -0800
Message-ID: <20250226211003.2790916-6-kuba@kernel.org>
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

Use IS_ENABLED(CONFIG_INET) to make the code easier to refactor.
Now all packets which did not go thru GRO will exit in the same
branch.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 32a2fbc6615b..497bc81ecdb9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1740,12 +1740,11 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 					   struct rx_tpa_end_cmp_ext *tpa_end1,
 					   struct sk_buff *skb)
 {
-#ifdef CONFIG_INET
 	int payload_off;
 	u16 segs;
 
 	segs = TPA_END_TPA_SEGS(tpa_end);
-	if (segs == 1)
+	if (segs == 1 || !IS_ENABLED(CONFIG_INET))
 		return skb;
 
 	NAPI_GRO_CB(skb)->count = segs;
@@ -1759,7 +1758,6 @@ static inline struct sk_buff *bnxt_gro_skb(struct bnxt *bp,
 	skb = bp->gro_func(tpa_info, payload_off, TPA_END_GRO_TS(tpa_end), skb);
 	if (likely(skb))
 		tcp_gro_complete(skb);
-#endif
 	return skb;
 }
 
-- 
2.48.1


