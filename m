Return-Path: <netdev+bounces-168855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131FAA4106C
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21201894307
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4615573F;
	Sun, 23 Feb 2025 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NBZ3CEpa"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9F13E898;
	Sun, 23 Feb 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740331743; cv=none; b=fd4zL/zA6o058l/a0oK68GuQsPAl7SdamNjUWQ0P9fXBBfzCmYqiTLTw6k/aA2hQolz+PXTKU7zeDyiLdMjFg4jaoGmfpxrVIIWxmbkYZectgBIea/vcoV1RtSzIK2Uj1bYfld1LkXiWq1yNz5+pcqE5KEXVrHzH4RNDMI+rA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740331743; c=relaxed/simple;
	bh=Vbaku2GgrC1AC7T3ymTnSdvjD7CR0Ze8Z+51m03KvfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/+6PPEDRDlwbt0wWqWnkMRNMwpjvGpYhrFigCKSKGYAz3PSHVt7T/SVQMEY06VUpVrP0g5xTEHRnWyJSOfgeGytcXq5YJq5T524f1Vdl/aQKhZ/iFM9QB+7WhegueebFsifkKNG5kbCJxoCGXkB04b7vhe6lIlw0RNoBhFeBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NBZ3CEpa; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C86AD441C1;
	Sun, 23 Feb 2025 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740331732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uD3tAR9L9AEHWHZj53qRmDS7IYkXn70xLYcyxJ9fSk=;
	b=NBZ3CEpas/Se/+9N5XTKPMO7wSap77COcJ+G8UlnmlSlKThie/TX2fGPg+6hoS3cPEFm3l
	RIf78kt3gzxutV5yNZyz9RSBqkdVKeT733BqTuXqsOEZU+gGFbRxEMJs7tzpX/3HlxTq5/
	ALx2j8ylF5I+kLRzzo3HbsKskNGcgx3EKpiIL0Z0Qr8H72GQVvlqg84GmNIdYFWIXDjrYx
	6UX0xn9r2eIeMZoXgE5MseydrRUOxUe5qwJRAQZ+fknHP+VCf4LHaOLxztpiAUoik/f5Ys
	WrGoYC9LGcMnElo0rQUiz7uM2fwX874Wu1TByjVfRmg6IlMtFcag7OSwQG2/xQ==
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
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 1/2] net: phy: sfp: Add support for SMBus module access
Date: Sun, 23 Feb 2025 18:28:46 +0100
Message-ID: <20250223172848.1098621-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejieeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

The SFP module's eeprom and internals are accessible through an i2c bus.
However, all the i2c transfers that are performed are SMBus-style
transfers for read and write operations.

It is possible that the SFP might be connected to an SMBus-only
controller, such as the one found in some PHY devices in the VSC85xx
family.

Introduce a set of sfp read/write ops that are going to be used if the
i2c bus is only capable of doing smbus byte accesses.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 65 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9369f5297769..65d1fa836db8 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -690,14 +690,69 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
 	return ret == ARRAY_SIZE(msgs) ? len : 0;
 }
 
-static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
+static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
+			  size_t len)
 {
-	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
-		return -EINVAL;
+	u8 bus_addr = a2 ? 0x51 : 0x50;
+	union i2c_smbus_data smbus_data;
+	u8 *data = buf;
+	int ret;
+
+	while (len) {
+		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+				     I2C_SMBUS_READ, dev_addr,
+				     I2C_SMBUS_BYTE_DATA, &smbus_data);
+		if (ret < 0)
+			return ret;
 
+		*data = smbus_data.byte;
+
+		len--;
+		data++;
+		dev_addr++;
+	}
+
+	return data - (u8 *)buf;
+}
+
+static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
+			   size_t len)
+{
+	u8 bus_addr = a2 ? 0x51 : 0x50;
+	union i2c_smbus_data smbus_data;
+	u8 *data = buf;
+	int ret;
+
+	while (len) {
+		smbus_data.byte = *data;
+		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+				     I2C_SMBUS_WRITE, dev_addr,
+				     I2C_SMBUS_BYTE_DATA, &smbus_data);
+		if (ret)
+			return ret;
+
+		len--;
+		data++;
+		dev_addr++;
+	}
+
+	return 0;
+}
+
+static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
+{
 	sfp->i2c = i2c;
-	sfp->read = sfp_i2c_read;
-	sfp->write = sfp_i2c_write;
+
+	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
+		sfp->read = sfp_i2c_read;
+		sfp->write = sfp_i2c_write;
+	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		sfp->read = sfp_smbus_read;
+		sfp->write = sfp_smbus_write;
+	} else {
+		sfp->i2c = NULL;
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.48.1


