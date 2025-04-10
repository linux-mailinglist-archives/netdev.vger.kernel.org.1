Return-Path: <netdev+bounces-181258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF02A84339
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE59E19E8E99
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3128A40C;
	Thu, 10 Apr 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JYwnzj1z"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCC2853EC;
	Thu, 10 Apr 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288443; cv=none; b=df9IomnWl/Do4s188EUkeCWrIiqmOUCTHfNB9l9gA67FR5LEm67x4RIa9LoB1RHUGeW5/GgmySTxEmR9VKyuNy1koRhFXLP5GQuxTtpD4CV8gOLwwNLWlNGWA48bilxI6Wb1NciEwaDrnhpUqJ7TtRuv+Zrc9L+rTxEYLXFbUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288443; c=relaxed/simple;
	bh=3I121XF2fMBchfmtwI8JGkIY0Sv+AhGwwxBQpzUsKSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxk32/BeBFXnJKkGBfRW9qi21eh2F4GyRz2/Me9Js17Nj2LirmEPY0ZOYgIjZnPEF0xuqfXOYomC8t78iiej3120FQFCSoIsSI2OdVyCiSRqP17O5TcWuesoFGViQVg0xQWac9PDj0CuD3soFP1ipAHz0WhDNQ3VGHfZsjzBv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JYwnzj1z; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D97F14433A;
	Thu, 10 Apr 2025 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744288438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=836dXAW5BQEuD0IbtlpXEx1xy09kQKLZHvAT71eDZnY=;
	b=JYwnzj1zI3aDS1cak+ToJdFssF7eO483/rRSeVqeCaEmF7c+l2CP51HP800fW0o2y9Yq3y
	VwfQvJT3wAV1sjYbBE8TsUvp6sVSNvRvjzXlqRGbYVXVI+Ko7DRs68GSAXcoB5AtcesF3V
	wCBaVbJLcgpxI8enQaSv12Ijl5HkAQV6Tzbmj9Rb/wvJgONNm9Wch4Bn5NsshEAXbFKaXm
	OnoOtkcTZW4UOJ8fZd7H/3X7fObtZZwR+cj4D5nmdQ/mxryhnyUhlMDOBR/K7B4tYhKcrc
	BPkBsLnxO26K0eLf+uVUBn5YweiEZFE8Jm9ULSVDveTkcXr24DU+oLrzZdiy6g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v5 4/4] net: ethtool: pse-pd: Use per-PHY DUMP operations
Date: Thu, 10 Apr 2025 14:33:49 +0200
Message-ID: <20250410123350.174105-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410123350.174105-1-maxime.chevallier@bootlin.com>
References: <20250410123350.174105-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Leverage the per-phy ethnl DUMP helpers in case we have more that one
PSE PHY on the link.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index dd4eaa77dd8c..7186c465f429 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -1361,9 +1361,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PSE_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_default_start,
-		.dumpit	= ethnl_default_dumpit,
-		.done	= ethnl_default_done,
+		.start	= ethnl_perphy_start,
+		.dumpit	= ethnl_perphy_dumpit,
+		.done	= ethnl_perphy_done,
 		.policy = ethnl_pse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_pse_get_policy) - 1,
 	},
-- 
2.49.0


