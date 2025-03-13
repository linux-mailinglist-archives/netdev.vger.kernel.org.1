Return-Path: <netdev+bounces-174703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479ACA5FF2A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29133BBA20
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3073E1F0990;
	Thu, 13 Mar 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZO+9Mhq/"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75A189915;
	Thu, 13 Mar 2025 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890417; cv=none; b=Lfc8gwQWDcv/vQSY/9Gniov9PbvV184IviCJ52fWxX4tJOc/6fBOnpHu8NfH/BlcANUO0Submc5EQhYu0qV2rkyEgQQUHEN33mvQ0nzs9UhiDingn65YBG+qyGa+KGMn0UKMeauyLii68uavHEMUHS7llm8xTSHqlgjnuVEga88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890417; c=relaxed/simple;
	bh=0uY8xIwbq9p0juSLdPgZBHcxHXa3T885RfgLDIXH6Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNn5b3V26oBjmC8MK7lj2GpgwWHTAqYScbA4219UWLQod1kWDZiTK3dHUqv9cgKbc7qaOxzDd1zXWXp4l9myXS801NKQIBbqOCeE89fDVpy6WEmtF5Zk+CT/4khjUaidPF7/uLDwuSJHt8i0tvgr989ysJ11zeXDkYdYK6S8zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZO+9Mhq/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE67020479;
	Thu, 13 Mar 2025 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741890413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QJeRvWt4UkHaBTliCWdYR/evWkKDG2k/rxh/t0R1Z8=;
	b=ZO+9Mhq/ztUPNYbtFp3WN5/7Vtyjww4NRp03XNiAZTw8W6doobPncAolknETfltZXEVsTr
	b2txe8uL8cVUnDIhrY1krFal571dtJpBFYEFJS2kBS0x+djQBlhBtcuEzT7dJHA8gQW0W0
	HAKBS3x99nOtcLCUb/DQCi4ASQ9BEDeLVPgVnt2WEwxOydIoXzuP6yXEPvstUsGWz0BUwE
	Ovsj8O2oHTfJvrpfKt3+OIdn2Ub/bq3IPkFzKrqPlcvtSQRYQMBG7C8/ZCg4gmioEAOEv1
	uAIxLUR4ybKswrAYbYh9tU9Bg6GPDw3Ywf55Y9JJ2YMCQYm3+U4tzHR2N9vtfA==
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
Subject: [PATCH net-next v3 2/7] net: ethtool: netlink: Rename ethnl_default_dump_one
Date: Thu, 13 Mar 2025 19:26:41 +0100
Message-ID: <20250313182647.250007-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313182647.250007-1-maxime.chevallier@bootlin.com>
References: <20250313182647.250007-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

As we work on getting more objects out of a per-netdev DUMP, rename
ethnl_default_dump_one() into ethnl_default_dump_one_dev(), making it
explicit that this dumps everything for one netdev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 7adede5e4ff1..644c202d284d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -540,9 +540,9 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
-				  const struct ethnl_dump_ctx *ctx,
-				  const struct genl_info *info)
+static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				      const struct ethnl_dump_ctx *ctx,
+				      const struct genl_info *info)
 {
 	void *ehdr;
 	int ret;
@@ -593,8 +593,8 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		/* Filtered DUMP request targeted to a single netdev. We already
 		 * hold a ref to the netdev from ->start()
 		 */
-		ret = ethnl_default_dump_one(skb, dev, ctx,
-					     genl_info_dump(cb));
+		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
+						 genl_info_dump(cb));
 		rcu_read_lock();
 		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
 
@@ -606,8 +606,8 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 			dev_hold(dev);
 			rcu_read_unlock();
 
-			ret = ethnl_default_dump_one(skb, dev, ctx,
-						     genl_info_dump(cb));
+			ret = ethnl_default_dump_one_dev(skb, dev, ctx,
+							 genl_info_dump(cb));
 
 			rcu_read_lock();
 			dev_put(dev);
-- 
2.48.1


