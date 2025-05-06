Return-Path: <netdev+bounces-188289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72BAABFE4
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B609F1C21DF7
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8C268FDA;
	Tue,  6 May 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IFtf2S71"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1102367B0;
	Tue,  6 May 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524348; cv=none; b=BG9k4nrtU2uHKY9xiH7SWu0zwhpW5EO5KRGxvVJQdjXYaSYdjSVuhHcKl5iIv523Ehdr59KjCAaRIDFaHt1vhCNjpR5XQQdkckijw9DhbjYIaw2hr7QB37DtrZBcbt+IXCBkMAFVgaodCZmEwCozrINNCqhzl+X3CDzQR9LiUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524348; c=relaxed/simple;
	bh=qBwgkCpHN9Q04YuSGhWuzK10Z5HEXbmT0E79Rvlfp+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1q4DU2ZQEVk+vPe8QScjNvqI9JJsIs4YQ2xUnrhoWjIWWNhqQ/B8SXHIxxg4fUtHaXCIDDQk8i3FNOrGVhukOromnh9cnGObVKlLzm7hO5vBW/7rmk9ZXJkyNjnpY8NKbrU1FvemA0IKFgFH9c2TYeKh57T5ghnW0cvZ7WP71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IFtf2S71; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80BC243314;
	Tue,  6 May 2025 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746524343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql6bc9nNH1PttIfAUL8+OGVKCX015+qoAPz81pk3JPY=;
	b=IFtf2S71q2T+YEc2srvxbgoGd447/9+XAoyOiWGnGlTjPFcsn1zEHPhzJP0sxbZXhJH/W6
	p7mJugHOzuxFOl/xiLGXq9GH/fVh7dxCmpexjnLRsw8CFmrOaCS1L7VSKhGzcgExqL+BBW
	YEM0aO8OFN8Di+/n9hC9yhxbU2ew2aoe0D4WoB+nBJ6lY5fM4yOiQscyljfvnnjSVaWwP6
	Iq+7NIy4IvOFGbQFObFU0R7uXtQ5yJUvaSdxJmbZivSFSEBJz47Wuf+VXCdwguod1RZQ6Q
	eRE3pJO+vmtB0G2/dWIoc+Uz4hYPU96qtonXusKeqhMl+a9h+uD0iBRxGVmOTA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 06 May 2025 11:38:33 +0200
Subject: [PATCH net-next v10 01/13] net: ethtool: Add support for
 ethnl_info_init_ntf helper function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-feature_poe_port_prio-v10-1-55679a4895f9@bootlin.com>
References: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
In-Reply-To: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgfdvgfektefgfefggeekudfggffhtdfffedtueetheejtddvledvvdelhedtveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvnhhtphhrohhjvggttheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmp
 dhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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


