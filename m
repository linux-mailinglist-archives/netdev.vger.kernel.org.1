Return-Path: <netdev+bounces-249966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333AD21B08
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58537307E253
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5673A4AD5;
	Wed, 14 Jan 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TCMS1gX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B438B98D;
	Wed, 14 Jan 2026 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431485; cv=none; b=aa83aFr71PCQjbhH7dZZyFo9qWMyWoUQJsseqglcBmvidKXAxzbf/LWQ0w7fIPU3gTTPXwngXmJ4cH8YHCfit/9tEx0fgeA6yj2S/wRM1MX5YP30Ri77MWI/wSn1gFuDtdSfYC7yZ8TZSz2A4eZ1DfcqhBW8/kK4h+fGrWPiJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431485; c=relaxed/simple;
	bh=z4WqN2kh5qmAt21Q277EcIgqW0dOmQxzf7nNvly+CsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDbNsKLLpObz6ZfBpZHf6H8bX+N1X9o6kGBdsqZABA5r61XIdLeRxDjV+Ki7MoUWihUkrYRSGGhUqqX5r1ut1GOYSjI/iGIA9ejQuB7yfggHcmgVS1WtOiyBVzWEKikdXLjJf85V08QZE3LCR7bsVdGRcipYeEm9hCILBgN+hyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TCMS1gX8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 389A41A2870;
	Wed, 14 Jan 2026 22:57:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0ECEF6074A;
	Wed, 14 Jan 2026 22:57:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B522A10B68450;
	Wed, 14 Jan 2026 23:57:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431476; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jrfj5FZfYx7TZar0UsYfofe6PTAJ+saTzQzi5V7Is9I=;
	b=TCMS1gX8OD9n7qRPEOnqKvI8QBs15gRU9Ar58RkcY98JNuvAp4BP8bEYyE1DINXC6sux3x
	h4Oohx5k28UU5/WEGhYkuB7e0D/VGg6/7lmLpcgsKHUHsGIFcflCe8utX0SWaaWx8WBG3L
	7f8zG+96cKFVnSBQg9VXGx1co0zyOg+sTRb0n+7t8qx9+GZpfffJYdsXdhIRS+EWHXCXCw
	pdCFWuEf7/OLGY/gW9qoAxDhoBECrYj0sbVz0rZ0pEkRVlMf1JnZd9R35OFh/HQiDwPLLL
	VVHrJY8fv3DyAvUNwLMniv6yw6otInXpiZ2lsc4R4t44KJLSNCAR4Zfcf8Oevw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 5/6] net: mdio: mdio-i2c: Add single-byte C22 MDIO protocol
Date: Wed, 14 Jan 2026 23:57:27 +0100
Message-ID: <20260114225731.811993-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In commit d4bd3aca33c2 ("net: mdio: mdio-i2c: Add support for single-byte
SMBus operations"), we introduced single-byte SMBus support for the
mdio-i2c. This was intended to deal with the case where the I2C adapter
that accesses the SFP module is limited to single-byte smbus accesses.
We find this type of adapters in some PHY devices such as the VSC8552.

It was discovered that some SFP modules have a built-in PHY that only
reply to single-byte smbus accesses. This is the case for the Prolabs
GLC-GE-100FX-C SGMII to 100FX module, which contains a Broadcom BCM5461
PHY.

In that case, trying to access the PHY with regular 16-bit transactions
with the mdio-i2c driver causes the PHY to stall the i2c bus completely,
without any way to recover. Accessing it in single-byte mode however,
works fine.

Add a dedicated MDIO_I2C_SINGLE_BYTE_C22 protocol type, so that we can
setup the mdio-i2c driver accordingly. The good news here is that this
should work on pretty much every setup, as a true I2C adapter is also
capable of single-byte accesses thanks to the i2c smbus emulation layer.

Some care will need to be taken should we add support for word-only
smbus adapters.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/mdio/mdio-i2c.c   | 12 ++++++++----
 drivers/net/phy/sfp.c         |  1 +
 include/linux/mdio/mdio-i2c.h |  1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index ed20352a589a..86ae8a5c0ebd 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -452,7 +452,8 @@ static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
 		return true;
 
 	if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) &&
-	    protocol == MDIO_I2C_MARVELL_C22)
+	    (protocol == MDIO_I2C_MARVELL_C22 ||
+	     protocol == MDIO_I2C_SINGLE_BYTE_C22))
 		return true;
 
 	return false;
@@ -475,9 +476,12 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 	mii->parent = parent;
 	mii->priv = i2c;
 
-	/* Only use SMBus if we have no other choice */
-	if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) &&
-	    !i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
+	/* Only use single-byte SMBus if explicitly asked, or if we have no
+	 * other choice.
+	 */
+	if (protocol == MDIO_I2C_SINGLE_BYTE_C22 ||
+	    (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) &&
+	    !i2c_check_functionality(i2c, I2C_FUNC_I2C))) {
 		mii->read = smbus_byte_mii_read_default_c22;
 		mii->write = smbus_byte_mii_write_default_c22;
 		return mii;
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 1f9112efef62..bff91735f681 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2016,6 +2016,7 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
 		break;
 
 	case MDIO_I2C_MARVELL_C22:
+	case MDIO_I2C_SINGLE_BYTE_C22:
 		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, false);
 		break;
 
diff --git a/include/linux/mdio/mdio-i2c.h b/include/linux/mdio/mdio-i2c.h
index 65b550a6fc32..f51c474da5b1 100644
--- a/include/linux/mdio/mdio-i2c.h
+++ b/include/linux/mdio/mdio-i2c.h
@@ -16,6 +16,7 @@ enum mdio_i2c_proto {
 	MDIO_I2C_MARVELL_C22,
 	MDIO_I2C_C45,
 	MDIO_I2C_ROLLBALL,
+	MDIO_I2C_SINGLE_BYTE_C22,
 };
 
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
-- 
2.49.0


