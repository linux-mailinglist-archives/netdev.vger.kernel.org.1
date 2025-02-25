Return-Path: <netdev+bounces-169427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190FCA43D5B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5250819C3BCE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC334267B1C;
	Tue, 25 Feb 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mc8d6TtY"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E7267728;
	Tue, 25 Feb 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482451; cv=none; b=XpmgsvQxNeQ/Xx7R4ZCBs4iUUDxaPmFzO5/KsNBe+PUOe5vL+fE2srMg86V+IsUJkVTe6wTu8V4c5BPEFdoLzLqiq8o67R1ciFPjE4ItTtJFh2oJZdY047+nU0mDyZZmegAx5vK7HTBDgigd3goDW+0LPSpGVILfZclWXl2uB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482451; c=relaxed/simple;
	bh=lh2Mu0nnFYpRCIz1hcd82hDmyu/xMerxR7E3uBHyCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrKIs5Bsmhin5hfrMvRX4ROcK3ZFgU7mcWjnk/4xdBDiW3gG7r732VvLpN48V4WiaI6na5XEcumqdGMJrQ9Pfuh0D82B36L8BHjobe+WcgK/oXpswQyqD/qAJqHd76diyQ4czYmxrEHDnhJaLS9jWb8b4p29prdsl0spS5DUlOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mc8d6TtY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB1911F687;
	Tue, 25 Feb 2025 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740482447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4fX8+X4t4wzC4BRgGrlcEyJpIlujdTMJrEGDLk37Sg=;
	b=mc8d6TtYxAAYM5yNgJDMaG86BNTkFdXuPkmhqAMaMzPpSajwUfNu+cao6pIBEE68nal1fD
	7kjukdvOa27bcaTLRvkBrKm4wVtPYHVupE21dQMQa9mngodeGeksK/pPvnsfoKwzECA1nG
	T/HVH+JYUJrFUYqHLZgsQ7XIMYuqYPQ7LC3dKU6KoDP8whHvpqKJ6MtzgsQkVr9dNlgd6D
	iASKNf5G/Y+b66KhE+JJJZvcP/wqglfEyIBWmw3zMLgNltbuXv6ojAYNKcQ3ek+HT+L65/
	MjXe93FdsbamHteRdV9tZYOchXCklap/7UlvetQ5Hq57tAgOJ/4V6sHx+CGNYQ==
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
Subject: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus module access
Date: Tue, 25 Feb 2025 12:20:39 +0100
Message-ID: <20250225112043.419189-2-maxime.chevallier@bootlin.com>
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

The SFP module's eeprom and internals are accessible through an i2c bus.
However, all the i2c transfers that are performed are SMBus-style
transfers for read and write operations.

It is possible that the SFP might be connected to an SMBus-only
controller, such as the one found in some PHY devices in the VSC85xx
family.

Introduce a set of sfp read/write ops that are going to be used if the
i2c bus is only capable of doing smbus byte accesses.

As Single-byte SMBus transaction go against SFF-8472 and breaks the
atomicity for diagnostics data access, hwmon is disabled in the case
of SMBus access.

Moreover, as this may cause other instabilities, print a warning at
probe time to indicate that the setup may be unreliable because of the
hardware design.

Tested-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

V2: - Added Sean's tested-by
    - Added a warning indicating that operations won't be reliable, from
      Russell and Andrew's reviews
    - Also added a flag saying we're under a single-byte-access bus, to
      both print the warning and disable hwmon.

 drivers/net/phy/sfp.c | 79 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 9369f5297769..6e9d3d95eb95 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -282,6 +282,7 @@ struct sfp {
 	unsigned int rs_state_mask;
 
 	bool have_a2;
+	bool single_byte_access;
 
 	const struct sfp_quirk *quirk;
 
@@ -690,14 +691,70 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
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
+
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
+		sfp->single_byte_access = true;
+	} else {
+		sfp->i2c = NULL;
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -1628,7 +1685,8 @@ static void sfp_hwmon_probe(struct work_struct *work)
 
 static int sfp_hwmon_insert(struct sfp *sfp)
 {
-	if (sfp->have_a2 && sfp->id.ext.diagmon & SFP_DIAGMON_DDM) {
+	if (sfp->have_a2 && sfp->id.ext.diagmon & SFP_DIAGMON_DDM &&
+	    !sfp->single_byte_access) {
 		mod_delayed_work(system_wq, &sfp->hwmon_probe, 1);
 		sfp->hwmon_tries = R_PROBE_RETRY_SLOW;
 	}
@@ -3114,6 +3172,15 @@ static int sfp_probe(struct platform_device *pdev)
 	if (!sfp->sfp_bus)
 		return -ENOMEM;
 
+	if (sfp->single_byte_access)
+		dev_warn(sfp->dev,
+			 "Please note:\n"
+			 "This SFP cage is accessed via an SMBus only capable of single byte\n"
+			 "transactions. Some features are disabled, other may be unreliable or\n"
+			 "sporadically fail. Use with caution. There is nothing that the kernel\n"
+			 "or community can do to fix it, the kernel will try best efforts. Please\n"
+			 "verify any problems on hardware that supports multi-byte I2C transactions.\n");
+
 	sfp_debugfs_init(sfp);
 
 	return 0;
-- 
2.48.1


