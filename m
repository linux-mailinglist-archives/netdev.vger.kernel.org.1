Return-Path: <netdev+bounces-169428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A5A43D5C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9017819C3AC0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC0267B7F;
	Tue, 25 Feb 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KuhvPD0b"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02B267AF2;
	Tue, 25 Feb 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482452; cv=none; b=elQMOXspiFTv8PMOcFRwjlvpnFDmKrLrPY5W+T7UUtg+GpeUxMf38DYlHesUXjskYp5LZNi4sr3CMTOr89Vx3gnQyqVUZTzup1LMCpDlYYu5Z2cBozPTmMEq2U1GhA2xU2fPiHV+ZsqRR8G2srmIzqkUt4CXIh/V/rFi9SRViHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482452; c=relaxed/simple;
	bh=fG0y+Q+63eUBGl7McsmR3ude44yvoc4DsfOWpmwEmB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqWNsfrPcVj4m09zJ/FmzAgN+Ig11Me39qEOtCA8lKfn/iGa4V/HInXBw9A3Ro38IhYYZDCato+eTrZjtFIHdq15ir2y1RvplIBy2LWJSIdaWXp4XIK+gNqEk0gnuyoWM7CfsoOGm224rljniqrD7ToI2P5Q/YhThE41JQUrli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KuhvPD0b; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0266020454;
	Tue, 25 Feb 2025 11:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740482448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty3kCEGIUaAoqvgkGrP5ZIySdrAuR1skZRDzsYZi4YA=;
	b=KuhvPD0bayceixMKyVNmzXPCAkjTlxtyiM5DADzKtYGj+fnIcQBhQmrL2yA8/Bn55016Qk
	CjQb/bGciWJwJE6ZDFAba4RhzJVmWQO6hK+2mNYuc+y/8K7E8KJds7rEpOGHdZEOL5zM4E
	ktXDWnZXzkGyZbeYeDd67HMt0angw85X6w1WN30SBQTjf8zsaFs8xZj35tWu9Vm0CAz5sN
	2S3UjiGmPz6B/J1q5U68ZYDA6/6II975nrf3xW8yIt5thsINLjR3FeFfJXqJw4MI+WLnNn
	UNiBAX3//kcRGjR37p23zvkmEWI0Zl4M5dX4s33v/6ExIokqm38/CmmOEph1Lg==
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
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v2 2/2] net: mdio: mdio-i2c: Add support for single-byte SMBus operations
Date: Tue, 25 Feb 2025 12:20:40 +0100
Message-ID: <20250225112043.419189-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

PHYs that are within copper SFP modules have their MDIO bus accessible
through address 0x56 (usually) on the i2c bus. The MDIO-I2C bridge is
desgned for 16 bits accesses, but we can also perform 8bits accesses by
reading/writing the high and low bytes sequentially.

This commit adds support for this type of accesses, thus supporting
smbus controllers such as the one in the VSC8552.

This was only tested on Copper SFP modules that embed a Marvell 88e1111
PHY.

Tested-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

V2: No changes

 drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index da2001ea1f99..202f486e71f1 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -106,6 +106,62 @@ static int i2c_mii_write_default_c22(struct mii_bus *bus, int phy_id, int reg,
 	return i2c_mii_write_default_c45(bus, phy_id, -1, reg, val);
 }
 
+static int smbus_byte_mii_read_default_c22(struct mii_bus *bus, int phy_id,
+					   int reg)
+{
+	struct i2c_adapter *i2c = bus->priv;
+	union i2c_smbus_data smbus_data;
+	int val = 0, ret;
+
+	if (!i2c_mii_valid_phy_id(phy_id))
+		return 0;
+
+	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			     I2C_SMBUS_READ, reg,
+			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	if (ret < 0)
+		return ret;
+
+	val = ((smbus_data.byte & 0xff) << 8);
+
+	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			     I2C_SMBUS_READ, reg,
+			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	if (ret < 0)
+		return ret;
+
+	val |= (smbus_data.byte & 0xff);
+
+	return val;
+}
+
+static int smbus_byte_mii_write_default_c22(struct mii_bus *bus, int phy_id,
+					    int reg, u16 val)
+{
+	struct i2c_adapter *i2c = bus->priv;
+	union i2c_smbus_data smbus_data;
+	int ret;
+
+	if (!i2c_mii_valid_phy_id(phy_id))
+		return 0;
+
+	smbus_data.byte = ((val & 0xff00) >> 8);
+
+	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			     I2C_SMBUS_WRITE, reg,
+			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	if (ret < 0)
+		return ret;
+
+	smbus_data.byte = val & 0xff;
+
+	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			     I2C_SMBUS_WRITE, reg,
+			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+
+	return ret < 0 ? ret : 0;
+}
+
 /* RollBall SFPs do not access internal PHY via I2C address 0x56, but
  * instead via address 0x51, when SFP page is set to 0x03 and password to
  * 0xffffffff.
@@ -378,13 +434,26 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 		return 0;
 }
 
+static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
+					 enum mdio_i2c_proto protocol)
+{
+	if (i2c_check_functionality(i2c, I2C_FUNC_I2C))
+		return true;
+
+	if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) &&
+	    protocol == MDIO_I2C_MARVELL_C22)
+		return true;
+
+	return false;
+}
+
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 			       enum mdio_i2c_proto protocol)
 {
 	struct mii_bus *mii;
 	int ret;
 
-	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
+	if (!mdio_i2c_check_functionality(i2c, protocol))
 		return ERR_PTR(-EINVAL);
 
 	mii = mdiobus_alloc();
@@ -395,6 +464,14 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 	mii->parent = parent;
 	mii->priv = i2c;
 
+	/* Only use SMBus if we have no other choice */
+	if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) &&
+	    !i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
+		mii->read = smbus_byte_mii_read_default_c22;
+		mii->write = smbus_byte_mii_write_default_c22;
+		return mii;
+	}
+
 	switch (protocol) {
 	case MDIO_I2C_ROLLBALL:
 		ret = i2c_mii_init_rollball(i2c);
-- 
2.48.1


