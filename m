Return-Path: <netdev+bounces-216939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F1B362E2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F7618846C4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62C34DCCA;
	Tue, 26 Aug 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="NzTaAwBd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XLQWyoiS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8334DCEC
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214234; cv=none; b=nI/E2PoT/YjgKY/HQJU5dPY0bHUz+eM63J8JQjKwIms+x/i+0rrI05AI4zqKfeNlB4oz5EIaRo7FvmKhCajeqw8bzvFUufXzwP6os7kAQSamK758SdGOx+2N6C2fA1T7USGWuvHTm3oh80y8V4mkdKqm2AHSyKeRv/bLdIXJc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214234; c=relaxed/simple;
	bh=sQIVbcLXGfJ8N+k5+EEn4Fom7/NBPEh4i2TJ20sO8Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6z17CDm8yEb4ZIh16MmHuYGuwVaYDZ6GnslDIkUyDZop/K3gHEajyjn1brS7wxsO9Xs4uPMyotIgtRWFyhCbA1ZPUi64QmWqH5nfkrkjP0saCgezKidsq81xiyzKNuR/+sJWgGf8jZ6JAQeQA5hY7jJtfrFGZv+WsU2gfZgK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=NzTaAwBd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XLQWyoiS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A3597A012E;
	Tue, 26 Aug 2025 09:17:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 26 Aug 2025 09:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214232; x=
	1756300632; bh=9zCQhtEa/0kVMC61qI+LG+B8tsTSqioc+uQP9rg9Jjo=; b=N
	zTaAwBdvMKY1dDeRt/pOFGDDJUALkT64F9jQ9iYVJDC9mUelKRZhyXr+owT5Xl8N
	k0ODqbJV8qNG+7EHS1cHjGKJzyM7aC1BWeatAVgGABTa4TIihXBCbZ2mte7dXkzB
	7S+XspANLfCt+V1eIa9ra6BcgTp0hXkSkLTau5D9YFJKTf8+LuUsk1lXn2AH8aR6
	WfMCX7IKweS2qp/GQC7Uz1toUgt/QCidSM+9D3k6xb343qoITYWdHWME6aM4fhcG
	pYnC1Y20wOi9EmdExb6M1gqcP4bCft02cXHMbPe97XQ+seHdA0v1nMAQguDxXYST
	CeXIrJsDk17s9iG2pIb8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214232; x=1756300632; bh=9
	zCQhtEa/0kVMC61qI+LG+B8tsTSqioc+uQP9rg9Jjo=; b=XLQWyoiSt51Ym6miY
	pXY90nFDL8kydjVm9zpBjsMVMy5xGrEDHZuqzuEcEwEiHl1NDXUa2SDScHwwfvQy
	RrOk2gK2Vh4ZpMBVGgalZIMO9ebv8O13K4IbsIpOs/YbJ3063GTFW0mNdv/mmjAR
	vQH4L1yjbFuy8EWwtn66dh/8t2rSkAtibhNMZnFgRu3O+JEGhXMEJy+jbGXJGeXS
	VP0ImwFft1dOsCtBTVyLRFFJ5qtG3g0SPGyTys1B0GhTpYc/eWka4Y9e+q/C9TET
	5bhMxBiGEKM3OO4P+pebrIFf2p/t5EjcNyPdOrGxciPuDWed/pivVIODUXq7T5BW
	B536A==
X-ME-Sender: <xms:17OtaJ9Myur6LPjlsOwr8VgUip9ZHm_hmeBLj_l0BNT0p9vG8ehkwQ>
    <xme:17OtaN5v1nGcQx-zruUk0gV_cvYEah_7RhfA_rm8NRZ3pz8kBZ_xmoBmNr486dJrJ
    43sj3tmoofdDrt2Ptk>
X-ME-Received: <xmr:17OtaI1eUe3Wj3tfUCQA1P3Vxb7wE1M9R0wcjYiaHePjzqjJB4Oe3po_Lw2z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:17OtaMBtWoBDK6Qtv1fBv9YKidUlqEdFJcOymZHiXcOvT3LyxnzHtw>
    <xmx:17OtaC0msy_pXfO1RDhpDBjBEXMY9w9fsVjkbWYZmjCgRs7TpcEUCw>
    <xmx:17OtaOthpFafkgbSNbUx4PZFNkNKR6kRK4v-cgMPe--ulylc3XF-yg>
    <xmx:17OtaK7KbFQj7z_N3yqEnXaKV36km-WNDlPPseeBAJ4vSf2vipVKHg>
    <xmx:2LOtaMgD0ZDT6JTCCCau2HuaUm64_0HDPdfzK4O3_SfHrAAVQZGKmQ6M>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:11 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 10/13] macsec: use NLA_POLICY_VALIDATE_FN to validate IFLA_MACSEC_CIPHER_SUITE
Date: Tue, 26 Aug 2025 15:16:28 +0200
Message-ID: <015e43ade9548c7682c9739087eba0853b3a1331.1756202772.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately, since the value of MACSEC_DEFAULT_CIPHER_ID doesn't fit
near the others, we can't use a simple range in the policy.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

v2: remove unused csid variable (spotted by Jakub Kicinski and kernel
    test robot)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9589e8f9a8c9..5680e4b78dda 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3757,11 +3757,13 @@ static const struct device_type macsec_type = {
 	.name = "macsec",
 };
 
+static int validate_cipher_suite(const struct nlattr *attr,
+				 struct netlink_ext_ack *extack);
 static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_SCI] = { .type = NLA_U64 },
 	[IFLA_MACSEC_PORT] = { .type = NLA_U16 },
 	[IFLA_MACSEC_ICV_LEN] = NLA_POLICY_RANGE(NLA_U8, MACSEC_MIN_ICV_LEN, MACSEC_STD_ICV_LEN),
-	[IFLA_MACSEC_CIPHER_SUITE] = { .type = NLA_U64 },
+	[IFLA_MACSEC_CIPHER_SUITE] = NLA_POLICY_VALIDATE_FN(NLA_U64, validate_cipher_suite),
 	[IFLA_MACSEC_WINDOW] = { .type = NLA_U32 },
 	[IFLA_MACSEC_ENCODING_SA] = { .type = NLA_U8 },
 	[IFLA_MACSEC_ENCRYPT] = { .type = NLA_U8 },
@@ -4225,10 +4227,24 @@ static int macsec_newlink(struct net_device *dev,
 	return err;
 }
 
+static int validate_cipher_suite(const struct nlattr *attr,
+				 struct netlink_ext_ack *extack)
+{
+	switch (nla_get_u64(attr)) {
+	case MACSEC_CIPHER_ID_GCM_AES_128:
+	case MACSEC_CIPHER_ID_GCM_AES_256:
+	case MACSEC_CIPHER_ID_GCM_AES_XPN_128:
+	case MACSEC_CIPHER_ID_GCM_AES_XPN_256:
+	case MACSEC_DEFAULT_CIPHER_ID:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
-	u64 csid = MACSEC_DEFAULT_CIPHER_ID;
 	u8 icv_len = MACSEC_DEFAULT_ICV_LEN;
 	int flag;
 	bool es, scb, sci;
@@ -4236,9 +4252,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
-	if (data[IFLA_MACSEC_CIPHER_SUITE])
-		csid = nla_get_u64(data[IFLA_MACSEC_CIPHER_SUITE]);
-
 	if (data[IFLA_MACSEC_ICV_LEN]) {
 		icv_len = nla_get_u8(data[IFLA_MACSEC_ICV_LEN]);
 		if (icv_len != MACSEC_DEFAULT_ICV_LEN) {
@@ -4254,17 +4267,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
-	switch (csid) {
-	case MACSEC_CIPHER_ID_GCM_AES_128:
-	case MACSEC_CIPHER_ID_GCM_AES_256:
-	case MACSEC_CIPHER_ID_GCM_AES_XPN_128:
-	case MACSEC_CIPHER_ID_GCM_AES_XPN_256:
-	case MACSEC_DEFAULT_CIPHER_ID:
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	if (data[IFLA_MACSEC_ENCODING_SA]) {
 		if (nla_get_u8(data[IFLA_MACSEC_ENCODING_SA]) >= MACSEC_NUM_AN)
 			return -EINVAL;
-- 
2.50.0


