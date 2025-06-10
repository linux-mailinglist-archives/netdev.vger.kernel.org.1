Return-Path: <netdev+bounces-195982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94251AD2FC0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD5A16F02F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AB28031D;
	Tue, 10 Jun 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QYpVK008"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873521C9E3;
	Tue, 10 Jun 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543521; cv=none; b=vFnX4IcNrtE8OScfr/zgFXZzNWeuuweS+SFswxu9kFd7QZE2euHA0vMPNZxSqRoZkLHb922hWi8Leitmmrh00cVvjbvPPcqS+ci7aRuq6bnn5XpXduXV0j/XGDpSgCIstUCeY8j1IL5BXOG/5hkiOxYfO3gn/TZR6ouq1mygevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543521; c=relaxed/simple;
	bh=3FhbuHXLpa7KgvpJ6+b1LnbU3c/n7jjtCvudUrSkBC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jN292UVF0l+aPLzTpHxH6SN79l0BqjgmpjK1FOSZ41d0ffY4tQu24ToLnroc2wLKQAfDViDH3dt3zfznJQ40Kt7Z0HfgFFOWfotUNDUbQeDiS5F1ntR5X39WZXXWvZzfGhLIMOnVIgnO3uOeKfwGx1y0CIfDzH1THQv1gSdCfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QYpVK008; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 584C544281;
	Tue, 10 Jun 2025 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749543516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBS7sXArMlg3bsa0fvLdaXHa2pcTep+pc45pVR53ipk=;
	b=QYpVK008+KDTajXYHuKm8n6FgBndxN996ozwBjRZ+A+BD9Bq8fca4Xt96E3Z5zy06IWEef
	7ABXyJL1XJyrbAkiJ4qDQzJ1H2suTXRcwhxPa2c7CI/Sg/6JWRqFKmrb9kw6ITTltuc7pu
	oBWgRss1IXSGy5pk8ZPgWv/3R7Zvxw43eVgidq7CC70vixBHvm7Y4y3Dlwqe3S8CiSniFn
	H0mN7vjh9t0vFUuSCUSyQne6ju48cLkKVnHd2eU9r0LGWGfW2WtGoFaeTWzmL8PtuQLzdE
	NQ/fhDxKWM7grl6EWIgqKi3hgON88sma0PZjRXkj7BUQfj4OoHwqewCIdoH1BQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 10 Jun 2025 10:11:35 +0200
Subject: [PATCH net-next v13 01/13] net: pse-pd: Introduce attached_phydev
 to pse control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-feature_poe_port_prio-v13-1-c5edc16b9ee2@bootlin.com>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
In-Reply-To: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvefgvdfgkeetgfefgfegkedugffghfdtffeftdeuteehjedtvdelvddvleehtdevnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

In preparation for reporting PSE events via ethtool notifications,
introduce an attached_phydev field in the pse_control structure.
This field stores the phy_device associated with the PSE PI,
ensuring that notifications are sent to the correct network
interface.

The attached_phydev pointer is directly tied to the PHY lifecycle. It
is set when the PHY is registered and cleared when the PHY is removed.
There is no need to use a refcount, as doing so could interfere with
the PHY removal process.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---

Change in v11:
- New patch due to a split of the next patch.
---
 drivers/net/mdio/fwnode_mdio.c | 26 ++++++++++++++------------
 drivers/net/pse-pd/pse_core.c  | 11 ++++++++---
 include/linux/pse-pd/pse.h     |  6 ++++--
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index aea0f0357568..9b41d4697a40 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -18,7 +18,8 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
 
 static struct pse_control *
-fwnode_find_pse_control(struct fwnode_handle *fwnode)
+fwnode_find_pse_control(struct fwnode_handle *fwnode,
+			struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	struct device_node *np;
@@ -30,7 +31,7 @@ fwnode_find_pse_control(struct fwnode_handle *fwnode)
 	if (!np)
 		return NULL;
 
-	psec = of_pse_control_get(np);
+	psec = of_pse_control_get(np, phydev);
 	if (PTR_ERR(psec) == -ENOENT)
 		return NULL;
 
@@ -128,15 +129,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	u32 phy_id;
 	int rc;
 
-	psec = fwnode_find_pse_control(child);
-	if (IS_ERR(psec))
-		return PTR_ERR(psec);
-
 	mii_ts = fwnode_find_mii_timestamper(child);
-	if (IS_ERR(mii_ts)) {
-		rc = PTR_ERR(mii_ts);
-		goto clean_pse;
-	}
+	if (IS_ERR(mii_ts))
+		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
@@ -169,6 +164,12 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 			goto clean_phy;
 	}
 
+	psec = fwnode_find_pse_control(child, phy);
+	if (IS_ERR(psec)) {
+		rc = PTR_ERR(psec);
+		goto unregister_phy;
+	}
+
 	phy->psec = psec;
 
 	/* phy->mii_ts may already be defined by the PHY driver. A
@@ -180,12 +181,13 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	return 0;
 
+unregister_phy:
+	if (is_acpi_node(child) || is_of_node(child))
+		phy_device_remove(phy);
 clean_phy:
 	phy_device_free(phy);
 clean_mii_ts:
 	unregister_mii_timestamper(mii_ts);
-clean_pse:
-	pse_control_put(psec);
 
 	return rc;
 }
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 4602e26eb8c8..4610c1f0ddd6 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -23,6 +23,7 @@ static LIST_HEAD(pse_controller_list);
  * @list: list entry for the pcdev's PSE controller list
  * @id: ID of the PSE line in the PSE controller device
  * @refcnt: Number of gets of this pse_control
+ * @attached_phydev: PHY device pointer attached by the PSE control
  */
 struct pse_control {
 	struct pse_controller_dev *pcdev;
@@ -30,6 +31,7 @@ struct pse_control {
 	struct list_head list;
 	unsigned int id;
 	struct kref refcnt;
+	struct phy_device *attached_phydev;
 };
 
 static int of_load_single_pse_pi_pairset(struct device_node *node,
@@ -599,7 +601,8 @@ void pse_control_put(struct pse_control *psec)
 EXPORT_SYMBOL_GPL(pse_control_put);
 
 static struct pse_control *
-pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
+pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
+			 struct phy_device *phydev)
 {
 	struct pse_control *psec;
 	int ret;
@@ -638,6 +641,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index)
 	psec->pcdev = pcdev;
 	list_add(&psec->list, &pcdev->pse_control_head);
 	psec->id = index;
+	psec->attached_phydev = phydev;
 	kref_init(&psec->refcnt);
 
 	return psec;
@@ -693,7 +697,8 @@ static int psec_id_xlate(struct pse_controller_dev *pcdev,
 	return pse_spec->args[0];
 }
 
-struct pse_control *of_pse_control_get(struct device_node *node)
+struct pse_control *of_pse_control_get(struct device_node *node,
+				       struct phy_device *phydev)
 {
 	struct pse_controller_dev *r, *pcdev;
 	struct of_phandle_args args;
@@ -743,7 +748,7 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 	}
 
 	/* pse_list_mutex also protects the pcdev's pse_control list */
-	psec = pse_control_get_internal(pcdev, psec_id);
+	psec = pse_control_get_internal(pcdev, psec_id, phydev);
 
 out:
 	mutex_unlock(&pse_list_mutex);
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index c773eeb92d04..8b0866fad2ad 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -250,7 +250,8 @@ struct device;
 int devm_pse_controller_register(struct device *dev,
 				 struct pse_controller_dev *pcdev);
 
-struct pse_control *of_pse_control_get(struct device_node *node);
+struct pse_control *of_pse_control_get(struct device_node *node,
+				       struct phy_device *phydev);
 void pse_control_put(struct pse_control *psec);
 
 int pse_ethtool_get_status(struct pse_control *psec,
@@ -268,7 +269,8 @@ bool pse_has_c33(struct pse_control *psec);
 
 #else
 
-static inline struct pse_control *of_pse_control_get(struct device_node *node)
+static inline struct pse_control *of_pse_control_get(struct device_node *node,
+						     struct phy_device *phydev)
 {
 	return ERR_PTR(-ENOENT);
 }

-- 
2.43.0


