Return-Path: <netdev+bounces-216936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B58B36306
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEED4649B0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9545534DCC2;
	Tue, 26 Aug 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SoWSdxzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYobFobF"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6133469E3
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214228; cv=none; b=fcy3xnL/cHE4NqnuReHMNQivlwFl0x+ZpDKZtAJwzDQfp6Cj6v47Hxn65fdzzOIEnHvJ6DffwKexu+1Dd1zqw3wuNSDfls3EgPhMm89Xe/j7c2ZKBTNyuN0MXrAiB6UOlcDkqJQSoTeG0SPHyS3KR9yvJoDui9aoLUY2ISsTu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214228; c=relaxed/simple;
	bh=V9SxF/JCrNpuLDoFwJLdRSG4T/ahVLTaqT7hjwCpEyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=criez9KEuTEQYUgSuT9Cd0KfE0KJvQJcM3QGp8R74tHC7+TJdFYYZAruvH38V8+ECxr4ggTHSDJUpMhss9WczqJDxNtQGT3XJsHoVjgYa7p39IuBxmtc8/3L6AwbPh2FjOckfwMu6WtpqSlrhYI0RzVe6x1DXqHynLTSbgwZl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SoWSdxzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYobFobF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C08A57A00AE;
	Tue, 26 Aug 2025 09:17:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 26 Aug 2025 09:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214225; x=
	1756300625; bh=96nKtgjHZ5X9gutZo7HtkHkXHYHiGFROWzPdrqoljP4=; b=S
	oWSdxzYdz8SKwRGFoBHp1S+UVFQN4DtKCWjaMwMiJxSMBwSY9OKcopvlXCZzRCNT
	o2KAEjFwYQuNZF+vCYBlD6xnfXO5BA1ZQvepxFchOV2whl6M2O5GGUqktnTDqISh
	/apSN0v1wsUyaIIvjsHe3TDU318+AL8lac0YhIDjCIN+2b3s+yIWz2nmXG74J6YP
	wQJMDix1s9RB5QQ5Yz1bszWrFNAWrMuks34tVqm19SPhX2+fm8rrMbPvhHRxjnFd
	sML8fWimKz+MYSywpFx86BKNejpuihpYeVW7Cw7NbDYQNc6K71uy6+rFqYwR4Uj9
	yXvFibJu03/Bg8kUsmE5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214225; x=1756300625; bh=9
	6nKtgjHZ5X9gutZo7HtkHkXHYHiGFROWzPdrqoljP4=; b=XYobFobFoAILwMnlt
	lasGnB2bMeq0H/PcfryHrOV/LDISnl7CIPN2eRWL4b7t6ZcpPHwFiD1sTTWBG/VP
	P2RrnApZovBL65XAKgBXdWQOMnIgJGaHmA6qAtpMyiBI6zfTRELV/Qk/4uUNcJYd
	KuPqMKQzu89az6HN7gkBUvImezVQZfZ6KXnQYf+DCI8AkA5ZRpm2r2FmpJAMbxy8
	qDbjy3ApOady0Xsk+B7T7QLsV0bJLrRJg/G5V84GK04GSZMRhvM0OWQr8bOTt0k6
	N5NnMLvOrevQM0ITggjbq59sW4AelYGiQbuJYZtETDbGWvP03aVsrRAtyL/4XFCR
	3QT6Q==
X-ME-Sender: <xms:0bOtaA3P7Ls_FAf96HGSpFr8wMaYffZ5VwFNAUDuSG6POQ9ovx3R8g>
    <xme:0bOtaLTMHiA-v1R3O08eG6Ondk6um1mIuznZSZWAR95xOOJXkbYPikZ-AF4AZOes5
    -qaX0l951puBpVwu1U>
X-ME-Received: <xmr:0bOtaKsp0U476KlejjuOX1uH0Rsk0JIYFkzzpUMPlNp-wKO0x_jhxtzV8cw6>
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
X-ME-Proxy: <xmx:0bOtaIbd6Bcj97FlOfKs29UZmIb97E3dV4LA3w8-v2ZPCIvJwb7NnA>
    <xmx:0bOtaHuhTG5YdqDkizYOdaYxGz8ChjKrWeJdm63iNks58s2GcECYrA>
    <xmx:0bOtaCH2rTLwVSj9oXINVv8H-N7efaYXJN18mHBcKN8_hkuGzcSWrw>
    <xmx:0bOtaKxpcRW-xdqLZzWdABum-Z4FMQUtbI5o81H60QwTaSoj36nfLA>
    <xmx:0bOtaDZVOzHxvYrqiMHz4TfhZw67O56N4SB_i6IGxR-Op3wrIN6TH2PG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:05 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 07/13] macsec: remove validate_add_rxsc
Date: Tue, 26 Aug 2025 15:16:25 +0200
Message-ID: <218147f2f11cab885abc86b779dcefcd3208a2f8.1756202772.git.sd@queasysnail.net>
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

It's not doing much anymore.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 83158dbc1628..ca47c9a95cf4 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1864,14 +1864,6 @@ static int macsec_add_rxsa(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static bool validate_add_rxsc(struct nlattr **attrs)
-{
-	if (!attrs[MACSEC_RXSC_ATTR_SCI])
-		return false;
-
-	return true;
-}
-
 static int macsec_add_rxsc(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_device *dev;
@@ -1889,7 +1881,7 @@ static int macsec_add_rxsc(struct sk_buff *skb, struct genl_info *info)
 	if (parse_rxsc_config(attrs, tb_rxsc))
 		return -EINVAL;
 
-	if (!validate_add_rxsc(tb_rxsc))
+	if (!tb_rxsc[MACSEC_RXSC_ATTR_SCI])
 		return -EINVAL;
 
 	rtnl_lock();
@@ -2487,7 +2479,7 @@ static int macsec_upd_rxsc(struct sk_buff *skb, struct genl_info *info)
 	if (parse_rxsc_config(attrs, tb_rxsc))
 		return -EINVAL;
 
-	if (!validate_add_rxsc(tb_rxsc))
+	if (!tb_rxsc[MACSEC_RXSC_ATTR_SCI])
 		return -EINVAL;
 
 	rtnl_lock();
-- 
2.50.0


