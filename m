Return-Path: <netdev+bounces-171561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49385A4DA0F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8267A6F57
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC31FDE31;
	Tue,  4 Mar 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M6/J8YHw"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8B1FCF72;
	Tue,  4 Mar 2025 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083645; cv=none; b=Lhc8Nsot+2fOL3D9AWJtBfnh38WWunOQuY0arsDOqe6VEeHadEkkTrKf2NoEw0H+2YUrI7VUAqJsuBvYee2nQau/Z3I48vUST9cTpMOf3ltjH6QNT1+sTuo8XL87x0Zh7W3U2INzFdWTgf6GdBwK1Md41GRYtkRhGqR8dIzC7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083645; c=relaxed/simple;
	bh=L2bMPeWHFgEdKd8ZvyvnQ2vLOJYeJA5sTjadq4PBkM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdsbjYkL8FEdZiSfY91zi8YxaDpu2FdSjWuJL0TrYofjo9S4b3OTt1A7eWbpa3OKSe7TfT6U7ozPuhTKYCuSjjamKx/fiKQ2dgRl6WlDGMZ5Vp1rxS7/ZMb2YqK2N0p3iKGoQClhS9M1cz/ccOP1tOidf1SXEfstBHmBUhJln9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M6/J8YHw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8C044328A;
	Tue,  4 Mar 2025 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741083641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt/eBRlKorrLbLf7RCbtZsnBhCAzqAMtst+LAZYKub4=;
	b=M6/J8YHwCLJBU5Zi5RHhJsln/c0rznC1G8/rMdk0H2thhQ3KiTXEbIMZ13zFxTdVK+SNF8
	ujXvekSasxvJVxzoLroa9V8u4EKa13xvTOZpKCayMsLeQpsLxeES9wnj4S5yF6aAmbEETr
	xzEhGuE/lZusqF95c67dzz+7Y5VgMitXllTblGeBxWDao8QDSTPEe5tWpADgc5dBqo/X9G
	rMDpDBAE42pbUIsl3v4cDKfgu3atBtWOpEEGscOG7srQw09RnhnnHtvOc6WQfpsq78wob+
	OHLmV4+ncQmT0zduFS0tpqkvEIJidyGtxNuuTqwXCYTnayL8eC05hSErKEdm8A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Mar 2025 11:18:50 +0100
Subject: [PATCH net-next v6 01/12] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-feature_poe_port_prio-v6-1-3dc0c5ebaf32@bootlin.com>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
In-Reply-To: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigf
 hhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthh
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Introduce support for the ethnl_info_init_ntf helper function to enable
initialization of ethtool notifications outside of the netlink.c file.
This change allows for more flexible notification handling.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
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
index b4c45207fa32e..bb1a35494935f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -758,7 +758,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 	int reply_len;
 	int ret;
 
-	genl_info_init_ntf(&info, &ethtool_genl_family, cmd);
+	ethnl_info_init_ntf(&info, cmd);
 
 	if (WARN_ONCE(cmd > ETHTOOL_MSG_KERNEL_MAX ||
 		      !ethnl_default_notify_ops[cmd],
@@ -825,6 +825,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
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
index ff69ca0715dea..af20a175e1112 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -322,6 +322,8 @@ struct ethnl_sock_priv {
 int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
 			enum ethnl_sock_type type);
 
+void ethnl_info_init_ntf(struct genl_info *info, u8 cmd);
+
 /**
  * struct ethnl_request_ops - unified handling of GET and SET requests
  * @request_cmd:      command id for request (GET)

-- 
2.34.1


