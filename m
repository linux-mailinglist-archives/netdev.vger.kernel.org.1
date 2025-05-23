Return-Path: <netdev+bounces-192969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6EAC1E09
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A947B9FDC
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD9289372;
	Fri, 23 May 2025 07:56:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0D284B58
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986992; cv=none; b=EHT9ePSuPyDrd9xYlzQ4b8kyGFJfdayYmi+ygTxBEyIdL8nN0pAQbg3Gol/r1/8heoTYWVsUoBJrBxCNHTjs63fJhGAtYldBFO5AWI4BMsa0xVsnXPuznkTA2j4Tdm24goim3dK9v5ZJnX2uOo96QOoF//c9AgVocqcFolyQ3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986992; c=relaxed/simple;
	bh=HOBx0XegOo41jBVQww8Pu+sMoO3oXfVKrjAf+6jmK3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmNTze81Mb7r7J+mVOKjhQINXUoqePbDnWzx+IR25IDXl4r/4hYEkkjfGCW02mbApAIknWxWeH/4P247D54l+aI524zwMbJpX/DepwGviQeiD1BGKeJ9uCb1EuQkRQyySAt1mbN2Y1aIVL3HBUyk5XF1697AG8rrKwl8ojCrT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6C83C20891;
	Fri, 23 May 2025 09:56:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZIE1c_Do2mY; Fri, 23 May 2025 09:56:21 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 33A68208B0;
	Fri, 23 May 2025 09:56:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 33A68208B0
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:20 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3B3D83182AF4; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/12] xfrm: validate assignment of maximal possible SEQ number
Date: Fri, 23 May 2025 09:56:09 +0200
Message-ID: <20250523075611.3723340-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523075611.3723340-1-steffen.klassert@secunet.com>
References: <20250523075611.3723340-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

From: Leon Romanovsky <leonro@nvidia.com>

Users can set any seq/seq_hi/oseq/oseq_hi values. The XFRM core code
doesn't prevent from them to set even 0xFFFFFFFF, however this value
will cause for traffic drop.

Is is happening because SEQ numbers here mean that packet with such
number was processed and next number should be sent on the wire. In this
case, the next number will be 0, and it means overflow which causes to
(expected) packet drops.

While it can be considered as misconfiguration and handled by XFRM
datapath in the same manner as any other SEQ number, let's add
validation to easy for packet offloads implementations which need to
configure HW with next SEQ to send and not with current SEQ like it is
done in core code.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 52 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ae8e06573639..59f258daf830 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -178,11 +178,27 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay seq and seq_hi should be 0 for output SA");
 			return -EINVAL;
 		}
-		if (rs->oseq_hi && !(p->flags & XFRM_STATE_ESN)) {
-			NL_SET_ERR_MSG(
-				extack,
-				"Replay oseq_hi should be 0 in non-ESN mode for output SA");
-			return -EINVAL;
+
+		if (!(p->flags & XFRM_STATE_ESN)) {
+			if (rs->oseq_hi) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay oseq_hi should be 0 in non-ESN mode for output SA");
+				return -EINVAL;
+			}
+			if (rs->oseq == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay oseq should be less than 0xFFFFFFFF in non-ESN mode for output SA");
+				return -EINVAL;
+			}
+		} else {
+			if (rs->oseq == U32_MAX && rs->oseq_hi == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay oseq and oseq_hi should be less than 0xFFFFFFFF for output SA");
+				return -EINVAL;
+			}
 		}
 		if (rs->bmp_len) {
 			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
@@ -196,11 +212,27 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay oseq and oseq_hi should be 0 for input SA");
 			return -EINVAL;
 		}
-		if (rs->seq_hi && !(p->flags & XFRM_STATE_ESN)) {
-			NL_SET_ERR_MSG(
-				extack,
-				"Replay seq_hi should be 0 in non-ESN mode for input SA");
-			return -EINVAL;
+		if (!(p->flags & XFRM_STATE_ESN)) {
+			if (rs->seq_hi) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay seq_hi should be 0 in non-ESN mode for input SA");
+				return -EINVAL;
+			}
+
+			if (rs->seq == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay seq should be less than 0xFFFFFFFF in non-ESN mode for input SA");
+				return -EINVAL;
+			}
+		} else {
+			if (rs->seq == U32_MAX && rs->seq_hi == U32_MAX) {
+				NL_SET_ERR_MSG(
+					extack,
+					"Replay seq and seq_hi should be less than 0xFFFFFFFF for input SA");
+				return -EINVAL;
+			}
 		}
 	}
 
-- 
2.34.1


