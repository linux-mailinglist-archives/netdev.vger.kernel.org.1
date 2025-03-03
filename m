Return-Path: <netdev+bounces-171671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE33A4E1AD
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7CD882074
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8320A5D6;
	Tue,  4 Mar 2025 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ozlcNGP/"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C5253F2F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099085; cv=fail; b=ZzghnNkt8myfzbnXdfShnivjhkLP8gESKTnsWjDyMIXcpIWm6UqTQWCLzsXP4WAHwrep9boRjLOZvTfZejlmae0JZU/+PT5aPCyvR02AZmXV5FUin8ZFeEluozkwrA/FcwLE5YXTxbuFxnDVpWIN8ZAidqeISjg5EzpEKY6Qf4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099085; c=relaxed/simple;
	bh=9RqzNHECwJsMZn/eeVcH9WuUClLs28XFDnadDq93Rl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5EnYTOikbSgCR/kcOJb9YqyOXLcHgaUHqfMShRQJxD6ZQlNHYK4KCCivhewaxcvjWjCpFFQbPK86aziWPJGXsa8EnppwjH2uLIi2+zieYPOSXrjVzX3lNlrxqUp1AgAAcwK47P9OhKJKeGUieGk9Br1Yv9mJwrv8/YYBsUwJlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozlcNGP/ reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.196; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id BB5BB40CF130
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:38:01 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ozlcNGP/
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dYt5pc5zFx2m
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:37:22 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id A71A742735; Tue,  4 Mar 2025 17:37:10 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozlcNGP/
X-Envelope-From: <linux-kernel+bounces-541222-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozlcNGP/
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 22ED442E50
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:51 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id AF7253063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:50 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0FD3B19B7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B405B1F2C45;
	Mon,  3 Mar 2025 09:03:42 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA61EFF9A;
	Mon,  3 Mar 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992618; cv=none; b=SOkpcr4y7lxUuNXwCuPgsEjlSgv2raoLDbBregClsMZV7Ojq5MQm41K5+nw080jIU+Lsr62hscZZU5PBJlFeoHV+YMRkB7xkCEMLtVYGC7W41jz8DXn+MKAvpAGPcAWmxkUnjK2npm8ig7d8KElFwW38vv4ngkKFi+Ct+08K+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992618; c=relaxed/simple;
	bh=Xe5DtVc36aoeujGluGgUU94BaG2yMQDfaeDrNMgGBWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT2rlCNYxxguFvKDFszGsq3w0GqUxYv2JMUcKXGpN6viuggevIXftADvmf9FKOXVBJMN8SQyPIB58xMEEVPwzSC6InBqr0aJ3IZiywIK3hETDVbjQhJ7gZqETjNru4gNS8GhCoHdG/+w7sXAq3Alzro9ZLAWR2Wxqi85Agd1elI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozlcNGP/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4ED1D4453C;
	Mon,  3 Mar 2025 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nlXSi0W8T18XrNdXk/bylgWWVWE2JtetZpcNhMntQE=;
	b=ozlcNGP/ouUJ80B1R0MMogN2wGV50zUXMaU8OrDadyUhu++dPmXg70/tg5Xt7FYC8h1ewO
	6K9fq1WNu/ViMbEaaYYueha60K1Lu90czfwgxvUUVHl0e6BXaHgEzpM+eBQOxxiySwovKo
	h9IWRD7fucQ0e+YHkV+62qliZn2ScyIkBCYIEV8m/pDZsPi2cHtjq34G6O9f7NUf5wOHDz
	GmhmESN4fD9/Fu2XX9RDSxARDzQcHzOLL+TWDKfOTJ5BVzkeWeZPNPh+tLJnQbQ2CJiXvK
	x4dN3DQdoHvBd8w92cdw8wsBUZ5L5jG2jyjXatxqySfyXhekwDshy3kdJxURtA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v4 01/13] net: ethtool: Export the link_mode_params definitions
Date: Mon,  3 Mar 2025 10:03:07 +0100
Message-ID: <20250303090321.805785-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dYt5pc5zFx2m
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703844.72825@pjV5k6Y8o7rVe1gsp5k3DA
X-ITU-MailScanner-SpamCheck: not spam

link_mode_params contains a lookup table of all 802.3 link modes that
are currently supported with structured data about each mode's speed,
duplex, number of lanes and mediums.

As a preparation for a port representation, export that table for the
rest of the net stack to use.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes

 include/linux/ethtool.h | 8 ++++++++
 net/ethtool/common.c    | 1 +
 net/ethtool/common.h    | 7 -------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 7f222dccc7d1..8210ece94fa6 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -210,6 +210,14 @@ static inline u8 *ethtool_rxfh_context_key(struct et=
htool_rxfh_context *ctx)
=20
 void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
=20
+struct link_mode_info {
+	int                             speed;
+	u8                              lanes;
+	u8                              duplex;
+};
+
+extern const struct link_mode_info link_mode_params[];
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ac8b6107863e..c9d6302e88c9 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -423,6 +423,7 @@ const struct link_mode_info link_mode_params[] =3D {
 	__DEFINE_LINK_MODE_PARAMS(800000, VR4, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) =3D=3D __ETHTOOL_LINK_MODE_MA=
SK_NBITS);
+EXPORT_SYMBOL_GPL(link_mode_params);
=20
 const char netif_msg_class_names[][ETH_GSTRING_LEN] =3D {
 	[NETIF_MSG_DRV_BIT]		=3D "drv",
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index a1088c2441d0..b4683d286a5a 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -15,12 +15,6 @@
 #define __SOF_TIMESTAMPING_CNT (const_ilog2(SOF_TIMESTAMPING_LAST) + 1)
 #define __HWTSTAMP_FLAG_CNT (const_ilog2(HWTSTAMP_FLAG_LAST) + 1)
=20
-struct link_mode_info {
-	int				speed;
-	u8				lanes;
-	u8				duplex;
-};
-
 struct genl_info;
 struct hwtstamp_provider_desc;
=20
@@ -33,7 +27,6 @@ tunable_strings[__ETHTOOL_TUNABLE_COUNT][ETH_GSTRING_LE=
N];
 extern const char
 phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN];
 extern const char link_mode_names[][ETH_GSTRING_LEN];
-extern const struct link_mode_info link_mode_params[];
 extern const char netif_msg_class_names[][ETH_GSTRING_LEN];
 extern const char wol_mode_names[][ETH_GSTRING_LEN];
 extern const char sof_timestamping_names[][ETH_GSTRING_LEN];
--=20
2.48.1



