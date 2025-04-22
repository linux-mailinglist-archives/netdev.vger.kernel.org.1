Return-Path: <netdev+bounces-184704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D93A96F7B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368141B63D25
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9828F51D;
	Tue, 22 Apr 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GnA761gx"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731719CC3A;
	Tue, 22 Apr 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333826; cv=none; b=iaku5KIpXJmM9Zv0GGxJtUigrteOunElua6d0Ot7/tP1dDc4kEOJUHXKQtP+n+d6zurzVem0kY2n/B/rpTs3j9TjUJjjUlMlRa7tHxokbQVTpMqSribvbr0vekRp+1I4XUWxY4EH1En7pEV0xAlU/5WwUR63/U/7OgRHkFZ7d4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333826; c=relaxed/simple;
	bh=qBwgkCpHN9Q04YuSGhWuzK10Z5HEXbmT0E79Rvlfp+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1lZXbZbAEm2kMPLslaAcJogpCoKW79IpRiWOO3FFfOoPPoBu/zGXrzIkJ+RcNhq+nYbew4ZU0vs0sfu1bDJATtyQEQE2zy6hxuYHkJT+4i0ntrEn4y8vwr6ufkOFjuYw/xs6HwrAFCV/966qeC/7LV9kqpNv9oEoUuxgveRxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GnA761gx; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5F9F43999;
	Tue, 22 Apr 2025 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745333821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql6bc9nNH1PttIfAUL8+OGVKCX015+qoAPz81pk3JPY=;
	b=GnA761gx0E+uHn9bLn/gHmLYjCjPFyQuT4rNi+P0M1E9QLcZJoVVhJx3FOHWBPN1if+hcU
	LiBHLcgg2lwFh4GvtPHpAQ7eFhqq3m70G4dF5wWPh9WHJcf6wEzpMsccUv1KIYnOKrxd+t
	hYC+WJSXAl8TYJe5fA5G+rNBxMxIcVSoNe6Fo2XstT13kOAtbKHTIPJSAd9q5Yy3xVC5Bo
	+e1UqBbqfzADKnU3f5ik4Y+Qt4KZNT1XHILxHPn+V99VDn8nToorp7CXjFkrOz6XnkF7A5
	ZYJqOJrkZEBsbM4XJbEBGkLZZ4Jl6HK35AhO8PLJyfUImLp4w2egaJLYAywQYA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 22 Apr 2025 16:56:34 +0200
Subject: [PATCH net-next v9 01/13] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-feature_poe_port_prio-v9-1-417fc007572d@bootlin.com>
References: <20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com>
In-Reply-To: <20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvnhhtp
 hhrohhjvggttheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce support for the ethnl_info_init_ntf helper function to enable
initialization of ethtool notifications outside of the netlink.c file.
This change allows for more flexible notification handling.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v4:
- Use the new helper in ethnl_default_notify function.

Changes in v2:
- new patch.
---
 net/ethtool/netlink.c | 7 ++++++-
 net/ethtool/netlink.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 977beeaaa2f9..4e8cdc070291 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -770,7 +770,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	int reply_len;
 	int ret;
 
-	genl_info_init_ntf(&info, &ethtool_genl_family, cmd);
+	ethnl_info_init_ntf(&info, cmd);
 
 	if (WARN_ONCE(cmd > ETHTOOL_MSG_KERNEL_MAX ||
 		      !ethnl_default_notify_ops[cmd],
@@ -840,6 +840,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 typedef void (*ethnl_notify_handler_t)(struct net_device *dev, unsigned int cmd,
 				       const void *data);
 
+void ethnl_info_init_ntf(struct genl_info *info, u8 cmd)
+{
+	genl_info_init_ntf(info, &ethtool_genl_family, cmd);
+}
+
 static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
 	[ETHTOOL_MSG_LINKINFO_NTF]	= ethnl_default_notify,
 	[ETHTOOL_MSG_LINKMODES_NTF]	= ethnl_default_notify,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ec6ab5443a6f..4d4ad3824bbb 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -323,6 +323,8 @@ struct ethnl_sock_priv {
 int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
 			enum ethnl_sock_type type);
 
+void ethnl_info_init_ntf(struct genl_info *info, u8 cmd);
+
 /**
  * struct ethnl_request_ops - unified handling of GET and SET requests
  * @request_cmd:      command id for request (GET)

-- 
2.34.1


