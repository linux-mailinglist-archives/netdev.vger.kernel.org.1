Return-Path: <netdev+bounces-216940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06935B36335
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6DA467FC8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECABF34A30B;
	Tue, 26 Aug 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ofa2KOwF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpdOaCrY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC534F461
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214237; cv=none; b=g45N4ivKu7Ul4rXFrOXgz1976GqcUD8ZbEi23tSLvfjNTbGTnrkRHtOYNSj2hJQioPvMWFUvaQNmj155Cp0hSIuVCrNKun323NvPpiSR/srVNOdX5HarLdFttJpd2UBdiu8D3QT8YEKl8lidVvRdcn+pVM2FMN3pblE9DS1it9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214237; c=relaxed/simple;
	bh=XLMWIpqXdqcRFjBaSwdCVeJm1S6kOzbh71xOIc8oTCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbmrzr6Vm0nqkuUPpBXUYMh/Du0lMh2gUbXSiTR0z5EFnnhl1sb7h9+Tx6RdeBQv8GzDv2yEVhVE5xPhDNvd47CkYosP+z0miQPCFoIjt/QRnVsrGi0lrgCNQbtlVnBBFsy0NiNEJ2Vwz4qM3u/P1ly2a46qy9M60qCO8g0WGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ofa2KOwF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DpdOaCrY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E7FE7A00AE;
	Tue, 26 Aug 2025 09:17:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 26 Aug 2025 09:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756214234; x=
	1756300634; bh=tWKxOyKezG7+Qv7netGITtgK5gdntMPrh2QFCUntRH8=; b=O
	fa2KOwFklmx/7tQyQ0l6NJ8d6k+BWeYuUKn0RqBs3ZhQyJ7EfCFL5hmiq3YjjJMM
	8e0EUXKCgzY2SqJOgQJPxrh4xEo0cEY3H9MTFdsb8suQboY3i5jyqIJZvB9GaG8G
	Sla46j5oQaJrs8v7nAy5TqTM/N6CYyCrD5vy6Rz+DeIxHzY09dsbu2aNQ4H4cKMX
	MiNiS5rP0AHRYZZ3OdS0h0gfwjHHu7DAQAISJp2O4iPyK4oSk2013Tq7fkxB3Ssq
	u312fsBIS7Lu5yi/8RvAoq5dlK/0vkkLX7QTxXt4M1B2AXwU0o4jhc3r2ZIeCy/w
	0bbObHj6wdzvNel4b9mcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756214234; x=1756300634; bh=t
	WKxOyKezG7+Qv7netGITtgK5gdntMPrh2QFCUntRH8=; b=DpdOaCrYGjQJLlORC
	3ELpGeWOqJXgLRsxBzvzjylTaANVXrnx9o6jeklXl3dNzZ9aFQvq7Pn1Bkz5weC2
	LNyux92w3fHqw91qzHzhQ7fzUEaNDXTn0Bwuadi/CxWvVDqsfPkYpH2Xdvlde3q9
	zc0JqoRFNKwOXS9j8V/lGDqVP/4O7Ms1dHDgBVGs80YhUUJvCN+RlpAtVCwA7Aie
	kmpFcE/8W08wuTj3GjAN+/h2xwfD6Xax+rjYPAKO1jwQbXbj0a5278KeNjHi6AzD
	bp44qdKZ+BkMHz8o2FuaNb2xkgQEk4ySuDHPlfnFCVw3HJQ4W9WE6PvpNxI/vwsd
	oQQJw==
X-ME-Sender: <xms:2rOtaPfD0gwj67ZynUFES79JPXSh_ZxpJxZaC9w9DcY8W83ioQq2KA>
    <xme:2rOtaFZQyt9i67Dy0-4SNjqF7-VqD-EBM7cK1rg5xAh0XmdqbwPuloVx3OzhYjRDF
    j3k2J2bbXymjeQf3MY>
X-ME-Received: <xmr:2rOtaKXBc9iNdLuOHm2Ce330goWBu0hoLXlg1PrkWJ6Gz2P1Z6bu4zRgl7Vu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:2rOtaPguJq2LlhWR6FwIDKtc8Ir06NU_hgrThCLkYAz_ASOQvzYqqw>
    <xmx:2rOtaAW7rAFnOutrBQK3WKNVI8InvIB-R_dsos0yjQbgkQhJ_-dPWg>
    <xmx:2rOtaOPRwoCiEv8HaZbf6KlF1FRhFVXNUe4Xkqd282xOZO6Fq50ztw>
    <xmx:2rOtaEZHm-SmBj1x2MMIIhDd9Cmb5YG8EdZ3b_1V3Sn98gpftCm0Jw>
    <xmx:2rOtaCAH4EwIveTgArkL5zrhZqAaKUTUingdKeP0N3YI6aLfWhWT4wOK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 09:17:13 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next v2 11/13] macsec: validate IFLA_MACSEC_VALIDATION with NLA_POLICY_MAX
Date: Tue, 26 Aug 2025 15:16:29 +0200
Message-ID: <629efe0b2150b30abc6472074018cbd521b46578.1756202772.git.sd@queasysnail.net>
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
 drivers/net/macsec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5680e4b78dda..dc17b91dce2d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3772,7 +3772,7 @@ static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_ES] = { .type = NLA_U8 },
 	[IFLA_MACSEC_SCB] = { .type = NLA_U8 },
 	[IFLA_MACSEC_REPLAY_PROTECT] = { .type = NLA_U8 },
-	[IFLA_MACSEC_VALIDATION] = { .type = NLA_U8 },
+	[IFLA_MACSEC_VALIDATION] = NLA_POLICY_MAX(NLA_U8, MACSEC_VALIDATE_MAX),
 	[IFLA_MACSEC_OFFLOAD] = NLA_POLICY_MAX(NLA_U8, MACSEC_OFFLOAD_MAX),
 };
 
@@ -4288,10 +4288,6 @@ static int macsec_validate_attr(struct nlattr *tb[], struct nlattr *data[],
 	if ((sci && (scb || es)) || (scb && es))
 		return -EINVAL;
 
-	if (data[IFLA_MACSEC_VALIDATION] &&
-	    nla_get_u8(data[IFLA_MACSEC_VALIDATION]) > MACSEC_VALIDATE_MAX)
-		return -EINVAL;
-
 	if ((data[IFLA_MACSEC_REPLAY_PROTECT] &&
 	     nla_get_u8(data[IFLA_MACSEC_REPLAY_PROTECT])) &&
 	    !data[IFLA_MACSEC_WINDOW])
-- 
2.50.0


