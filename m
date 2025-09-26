Return-Path: <netdev+bounces-226593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B044BA2708
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4B11C03C22
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8142773FE;
	Fri, 26 Sep 2025 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="N+t0Qq/5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34521E091
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864645; cv=none; b=n8rsjRO0yd2YFwv/jIU1/leWbG7ekKcGpUR57U+lWnzxLNvXUcabnekj1K92Gppzis9JnBT8dREgwM/0AUM5sxEYCTfIRxEVri8OJNiFTrNlgUAn5iYIVo3XBBVqfqYUycQv61JyEVXD7GfJLCOC2bX3dvpKsK4mhG16T2PFpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864645; c=relaxed/simple;
	bh=e8j1xOYIY4wKg7OHrCKZ4ZZZ2fHLQmJEhrsqZCD0yl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxlI+zwWmwHB/QuepDWo9anmJXh45RP+33xwT5j3Ax+BEeGsmnAigZULKfgscnELI/y6SCy4zESOqJ0Q30BTKEQLB7tqMPYxiGBKwAw/liz4hYUUlbPm9A6z1rRMJ0oyyhyubvi/C1q0OOCM/ftmqISkB/NOMHHj/j4e7r4lSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=N+t0Qq/5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8505E208A2;
	Fri, 26 Sep 2025 07:30:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BRut1hz1UCm4; Fri, 26 Sep 2025 07:30:36 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EA539208B5;
	Fri, 26 Sep 2025 07:30:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EA539208B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758864636;
	bh=unmvt9ys5atahR+Z4soQ9iesE7BgRtk3RTP3vtMslJQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=N+t0Qq/5gUkH6A1dA6AWzhv7oSczmJWLSuPNdhYyBW7LppcocI5DWrP/G309LgAcL
	 3qJIMolfW5x8JcTpLHLTlneOEm5pZ7jIZRAxa91wvvpvhb6aQTRGvSF7dyefpsDz2i
	 XU+CTLNpHSzC+ZvaSH5m3o2Q34J9Xqe1Vb+ynqv0qw/zfnQKmadQOF68s7KVDrhhR8
	 GUCISFod2ZpFEoWYj70TJdILKFi7iq6njtc+atB87mLd3ZhB6/+0Km2kvn8fmpWQk9
	 XNTm98m88hWF/quLPU5AdYfNFFx8pDOMNIXq8N0cSitjsnoqb84WMiXwfWXPN90TGE
	 C9eGiNM3pWIxw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 07:30:35 +0200
Received: (nullmailer pid 2242264 invoked by uid 1000);
	Fri, 26 Sep 2025 05:30:33 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] xfrm: xfrm_user: use strscpy() for alg_name
Date: Fri, 26 Sep 2025 07:30:10 +0200
Message-ID: <20250926053025.2242061-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926053025.2242061-1-steffen.klassert@secunet.com>
References: <20250926053025.2242061-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Miguel García <miguelgarciaroman8@gmail.com>

Replace the strcpy() calls that copy the canonical algorithm name into
alg_name with strscpy() to avoid potential overflows and guarantee NULL
termination.

Destination is alg_name in xfrm_algo/xfrm_algo_auth/xfrm_algo_aead
(size CRYPTO_MAX_ALG_NAME).

Tested in QEMU (BusyBox/Alpine rootfs):
 - Added ESP AEAD (rfc4106(gcm(aes))) and classic ESP (sha256 + cbc(aes))
 - Verified canonical names via ip -d xfrm state
 - Checked IPComp negative (unknown algo) and deflate path

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 684239018bec..010c9e6638c0 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -593,7 +593,7 @@ static int attach_one_algo(struct xfrm_algo **algpp, u8 *props,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	*algpp = p;
 	return 0;
 }
@@ -620,7 +620,7 @@ static int attach_crypt(struct xfrm_state *x, struct nlattr *rta,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	x->ealg = p;
 	x->geniv = algo->uinfo.encr.geniv;
 	return 0;
@@ -649,7 +649,7 @@ static int attach_auth(struct xfrm_algo_auth **algpp, u8 *props,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	p->alg_key_len = ualg->alg_key_len;
 	p->alg_trunc_len = algo->uinfo.auth.icv_truncbits;
 	memcpy(p->alg_key, ualg->alg_key, (ualg->alg_key_len + 7) / 8);
@@ -684,7 +684,7 @@ static int attach_auth_trunc(struct xfrm_algo_auth **algpp, u8 *props,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	if (!p->alg_trunc_len)
 		p->alg_trunc_len = algo->uinfo.auth.icv_truncbits;
 
@@ -714,7 +714,7 @@ static int attach_aead(struct xfrm_state *x, struct nlattr *rta,
 	if (!p)
 		return -ENOMEM;
 
-	strcpy(p->alg_name, algo->name);
+	strscpy(p->alg_name, algo->name);
 	x->aead = p;
 	x->geniv = algo->uinfo.aead.geniv;
 	return 0;
-- 
2.43.0


