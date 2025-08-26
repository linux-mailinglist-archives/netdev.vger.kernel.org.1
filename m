Return-Path: <netdev+bounces-216942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB39B36312
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740958A7B09
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2534F463;
	Tue, 26 Aug 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="h/z153I+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RsigHyHt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FF34A30C
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214241; cv=none; b=sQN1eJBeWFGYo0g8okcOQE/SmyOKq5+qppxMLRyu89aR77p4fYtO1eRZhA808vjvvKaCvhW/TJ4yLRxkZbpT3HbxIabPbXFJI+d+K+WVwDp3qtW/HkDq+bbNRmcTiNqxEu+cBiSjFo/dkCHl6z+MZwKGvXMTGH3YaWB7GaTvvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214241; c=relaxed/simple;
	bh=ArPRkZVU39WclmH+vZtif16aAHnVm1nh0aE0rjqXz+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/DyL+ttFluqVJE4trJKgKSJK1lyoRdqK7ijqWYdrXbce5dipYL1tu0CEfjwW1siwOIgeHlXIzRjKv6qs9IaJgzw7BuOOCurFDYq0VBqzC2NY5mAXr3gq5slbROyLzRLYautpoG+tenCBBZJ40svtXF7cLMX1Y2O4EAQX18QFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=h/z153I+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsigHyHt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A0E5F1D0000B;
	Tue, 26 Aug 2025 09:17:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 Aug 2025 09:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214238; x=
	1756300638; bh=/uSCXiiRXTx/MNalBoTV5rFA+9Diuvf7wmGLZYRDXOQ=; b=h
	/z153I+FeQL5j4ogWxPjfsTl/r2TTRRxcADCnf4Y+7quTuReVUatOwkW8KaQMkbw
	5SayixOEmz3krcxV2e1l1a47vVA3ulklEmBEtpA1scIZtfsRa5j4DCkKgl7uREzK
	3i+7n/TtHE9iQJCDm0zxUheX86og2KkIJdIoOsiCyQAEOGu0kXm98eU/OQgdUUjJ
	B+n2PxvU7q0PVQPF3CmdDaGdSycmKEyh8N1myXxYbZHKEjFAQHf5bz8ooOqSgVdD
	padwGHzFcZJ3JXg6ex6EQldGJDEQJDDP3gb9EqaiN2lqNf/manr92cmRvlH/x84s
	AW31B+qDQttcS4au7wxBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214238; x=1756300638; bh=/
	uSCXiiRXTx/MNalBoTV5rFA+9Diuvf7wmGLZYRDXOQ=; b=RsigHyHt/Gqtu5+yV
	LsWGU1OaKPXUw6q409y2prBrlLzK5mryObcBCNvarb0YUKj5HDESzzTdZwlpTMGT
	HgDJXv4eQ1tStWLxWml0F54Yub8iBPa+ClzIyD85a+Hs71Do47bIpbw/h1uEubcm
	gBf4nNX+P6J1Pxf+RWDFXpBrQIQ6RSMOHTRPoAm676kjOAPdrOZiO/U8/IAdPuVa
	3Q69en08o21Do4EKSynrgAaO7hdKd0VXXHELoIyCx9rgCP9QOVEXGdbnS1NAnDFZ
	9JFWnLUdBeJkuIP3GIbsKsaTulpGH/P2cQP/ENWzYU3QPbLkDk6Taa5vJ7kKpzvL
	sKEww==
X-ME-Sender: <xms:3rOtaBze-IopSwElrfJQAl1dAjGoOswFLpTHo29ggQYbRguM0YkqrQ>
    <xme:3rOtaBewnAEfaLUoOM_3T_IcldQ8XCLvwiCc7pcaHd1eoRFCecaqY9VlrRraygQ0B
    MhQn3e7GhGmDEQrkt4>
X-ME-Received: <xmr:3rOtaNLs-eT2BoEjdxRpnVaObfW4IrC6mlh_MGYeA6sK6juQtxf0cnH7rmI_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpeeg
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:3rOtaCH_jGBOv8FbBUr1g64hlyLQXa-ZVhDrzvIht9eljnoFNSEsww>
    <xmx:3rOtaHoyRDdu83g7yjm_lNjexvZrMhRD24-TWAH3AFKzC6Z0vIE-Dw>
    <xmx:3rOtaLTMb_2OWoyfqE5uWpEqxzdowZ3RMwIeer5tWrqbwDQ84gEiJA>
    <xmx:3rOtaEPYRdoH5gRrXWbp-0YjtWn2XOGXYzmwmIvp6bkl4D6AXtREqQ>
    <xmx:3rOtaMUXXz5ZyVQm6gfBemAfR0ykTUHreSL0QxL02uJKiEzRS5tnZK94>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:18 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 13/13] macsec: replace custom check on IFLA_MACSEC_ENCODING_SA with NLA_POLICY_MAX
Date: Tue, 26 Aug 2025 15:16:31 +0200
Message-ID: <085bc642136cf3d267ddbb114e6f0c4a9247c797.1756202772.git.sd@queasysnail.net>
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

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 115cdf347643..316c5352ec2f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3765,7 +3765,7 @@ static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_ICV_LEN] = NLA_POLICY_RANGE(NLA_U8, MACSEC_MIN_ICV_LEN, MACSEC_STD_ICV_LEN),
 	[IFLA_MACSEC_CIPHER_SUITE] = NLA_POLICY_VALIDATE_FN(NLA_U64, validate_cipher_suite),
 	[IFLA_MACSEC_WINDOW] = { .type = NLA_U32 },
-	[IFLA_MACSEC_ENCODING_SA] = { .type = NLA_U8 },
+	[IFLA_MACSEC_ENCODING_SA] = NLA_POLICY_MAX(NLA_U8, MACSEC_NUM_AN - 1),
 	[IFLA_MACSEC_ENCRYPT] = NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_MACSEC_PROTECT] = NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_MACSEC_INC_SCI] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -4266,11 +4266,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
-	if (data[IFLA_MACSEC_ENCODING_SA]) {
-		if (nla_get_u8(data[IFLA_MACSEC_ENCODING_SA]) >= MACSEC_NUM_AN)
-			return -EINVAL;
-	}
-
 	es  = nla_get_u8_default(data[IFLA_MACSEC_ES], false);
 	sci = nla_get_u8_default(data[IFLA_MACSEC_INC_SCI], false);
 	scb = nla_get_u8_default(data[IFLA_MACSEC_SCB], false);
-- 
2.50.0


