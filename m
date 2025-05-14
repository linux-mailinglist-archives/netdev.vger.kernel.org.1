Return-Path: <netdev+bounces-190340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F30AB64D9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3700719E8180
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C421773F;
	Wed, 14 May 2025 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ke5CDRyt"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4062063F0;
	Wed, 14 May 2025 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209015; cv=none; b=Dq+Wb7caF/5tQPDbqFThQ61c6XdDTjqHqT4k0a+JuU3GSLJK+JvSlpt6VpruL2h++iHMb+ghO5tSzUJZ831WJSGpV8q3camEettKvAFjTGmYzbfAZ4dqpaVWHGQj5XdQFAcMiS+qrckBF9nNITktXFlyYUgh44uCMMh2bnmZ6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209015; c=relaxed/simple;
	bh=/tF8K2NTeCCHaif76f7Ley4J0CpUJfvELhKFRVyp/KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzBT84kP6uSW7HuiS1wJkWdpRw+aCnTegtx1+s6XUvP197d/ib2Pu56kU28dK2inVWBuZUsSeihOt6UryPXqWnMwXAPE2EUp+TBadlvmqcV1w925zvXj2K25ggMgdZWJq1VYg3qe6+Xx8PLY+6yOd/ys5txqXERsF8STXXhVSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ke5CDRyt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 691B0439D3;
	Wed, 14 May 2025 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747209011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1aRf1qlofiLBTSf6ULbxEoBgoZVuSsMmJGqVz5ikGs=;
	b=Ke5CDRyti81LkO2ACUXpk4vagGwlcXLNrl8rN9C5TOLXprgj4YkOj5Ox1mk16qRKEbM1r9
	BehkrqDihpbBaXUI5vorvs2d4fkFNtjUcmQzuMeMJVyswTGZd/FFUeXNsIOBCklTHayGEc
	UtxxyTqjY1UoYbdNoG9dkb2t75ashK7UrwnbZNT8+CLoZpuLpCumjqWxqSyJluVasFhyFQ
	0415YcjVJxXNBwodVBbSF8VvwxAV5Zdkyjr4Sz9S44goJUE3UxmVHIukpQF5jx6J6DXsjv
	NpJvLbVqJQA/Vhng3hU9CAv0K9nIM07lhTVwDUlsp0HncVDusLSE6MRpaDd2Ag==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 14 May 2025 09:49:59 +0200
Subject: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
 modules
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-dp83869-1000basex-v1-3-1bdb3c9c3d63@bootlin.com>
References: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
In-Reply-To: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -50
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeigeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenufgrugcufihorhgushculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeelieefteelffeuheevtdetkefhfffhteffkefgtefhkeevudeutdeugfffheegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

The DP83869 PHY supports multiple operational modes, including
RGMII-to-1000Base-X, which can be used to link an RGMII-capable Ethernet
MAC to a downstream fiber SFP module.

+-------+          +---------+            +-----------------+
|       |  RGMII   |         | 1000Base-X |                 |
|  MAC  |<-------> | DP83869 |<---------->| fiber SFP module|
|       |          |         |            |                 |
+-------+          +---------+            +-----------------+

Register the attach_port() callback, to set the supported downstream
interface modes for SFP ports and provide the configure_mii() callback,
which sets the correct DP83869 operational mode when a compatible SFP
module is inserted.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 000660aae16ed46166774e7235cd8a6df94be047..6d43c39ac525714a495327ec5a1a22b5e653b1cd 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/phy_port.h>
 #include <linux/delay.h>
 #include <linux/bitfield.h>
 
@@ -876,6 +877,57 @@ static int dp83869_config_init(struct phy_device *phydev)
 	return ret;
 }
 
+static int dp83869_port_configure_serdes(struct phy_port *port, bool enable,
+					 phy_interface_t interface)
+{
+	struct phy_device *phydev = port_phydev(port);
+	struct dp83869_private *dp83869;
+	int ret;
+
+	if (!enable)
+		return 0;
+
+	dp83869 = phydev->priv;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+		dp83869->mode = DP83869_RGMII_1000_BASE;
+		break;
+	default:
+		phydev_err(phydev, "Incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	ret = dp83869_configure_mode(phydev, dp83869);
+	if (ret)
+		return ret;
+
+	/* Update advertisement */
+	if (mutex_trylock(&phydev->lock)) {
+		ret = dp83869_config_aneg(phydev);
+		mutex_unlock(&phydev->lock);
+	}
+
+	return ret;
+}
+
+static const struct phy_port_ops dp83869_serdes_port_ops = {
+	.configure_mii = dp83869_port_configure_serdes,
+};
+
+static int dp83869_attach_port(struct phy_device *phydev,
+			       struct phy_port *port)
+{
+	if (!port->is_serdes)
+		return 0;
+
+	port->ops = &dp83869_serdes_port_ops;
+
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, port->interfaces);
+
+	return 0;
+}
+
 static int dp83869_probe(struct phy_device *phydev)
 {
 	struct dp83869_private *dp83869;
@@ -931,6 +983,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	.set_tunable	= dp83869_set_tunable,			\
 	.get_wol	= dp83869_get_wol,			\
 	.set_wol	= dp83869_set_wol,			\
+	.attach_port    = dp83869_attach_port,                  \
 	.suspend	= genphy_suspend,			\
 	.resume		= genphy_resume,			\
 }

-- 
2.49.0


