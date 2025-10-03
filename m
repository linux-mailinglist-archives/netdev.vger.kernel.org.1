Return-Path: <netdev+bounces-227723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25EBB61F3
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 09:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97ED94E7278
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320F2264B7;
	Fri,  3 Oct 2025 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YkaidwBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752A22D4E9
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475021; cv=none; b=d4AZxLurWlPl09lmwTjwIcz9OZOjs5CU7TWZZjrzKHpJILaEUvgEbghA18rY1C/iCoocqxKQprAkvRpnx9tff7w9Ub37iHjz/xjI9kyIMvjpiEjI5hNQ0bWgcezVpc7+aS/unPlddKTq/4ILtluHVod9h+MWsFyiTtLKyrJ2PMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475021; c=relaxed/simple;
	bh=WEpgQwj5ysHGdY0rQpoWHB2WE/mYExXO0H1/EEC7tEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3XyLyoXUud+yip7gd2iTS5Qs9ZoSOD/YRIre9WTvuCfZsnfkhxwWo2JYVJcXSBTz6SYfpjI8Fg001OkcdrNLq5GsP/4SQ8BiUwYJJZ2jgj2+UEdgPAru4DLs0hkAehvhWzwL/J/pu5aFUKSudmAW9VB1dv6NEROq9bE90A6qFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YkaidwBv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 78A76C00D89;
	Fri,  3 Oct 2025 07:03:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71D77606EB;
	Fri,  3 Oct 2025 07:03:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16AE5102F1C04;
	Fri,  3 Oct 2025 09:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759475011; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=FIGOkgiLU7D/zQZYWWPQIOlv2gbvyN0XXDYNmcnPLZw=;
	b=YkaidwBv1N46IA0tJRY4HE2I7lMFOupu995GkT/PlqQEVgC3/qFlKwsugBFg8jrKrVop0B
	nUSTE+9SN/6IZPufDRM+/WdHJ2aCXXKZ802RDtyXLqsbrBkjuMAGtcbVnWpDrXIRyjikqe
	XhVXqkpD6fMt9856Np4b/bJHpx0LsCW32biKs7AV/HmW6KYe2T1kKCiyAwYfMqFnYe8o+g
	INs5iwf67mTPmCCYpxYEcvu8vzdvqODGMYWIeeDY1ThqqteQZ477ygLMyJ9v8Yxh8MCWd1
	LM8MmkF7axyYFyAJsysgqYrtBQxRRjBET4pRS1VabtH1cCv/eIptXJmAaKAW+A==
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
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net] net: mdio: mdio-i2c: Hold the i2c bus lock during smbus transactions
Date: Fri,  3 Oct 2025 09:03:06 +0200
Message-ID: <20251003070311.861135-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When accessing an MDIO register using single-byte smbus accesses, we have to
perform 2 consecutive operations targeting the same address,
first accessing the MSB then the LSB of the 16 bit register:

  read_1_byte(addr); <- returns MSB of register at address 'addr'
  read_1_byte(addr); <- returns LSB

Some PHY devices present in SFP such as the Broadcom 5461 don't like
seeing foreign i2c transactions in-between these 2 smbus accesses, and
will return the MSB a second time when trying to read the LSB :

  read_1_byte(addr); <- returns MSB

  	i2c_transaction_for_other_device_on_the_bus();

  read_1_byte(addr); <- returns MSB again

Given the already fragile nature of accessing PHYs/SFPs with single-byte
smbus accesses, it's safe to say that this Broadcom PHY may not be the
only one acting like this.

Let's therefore hold the i2c bus lock while performing our smbus
transactions to avoid interleaved accesses.

Fixes: d4bd3aca33c2 ("net: mdio: mdio-i2c: Add support for single-byte SMBus operations")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/mdio/mdio-i2c.c | 39 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index 53e96bfab542..ed20352a589a 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -116,17 +116,23 @@ static int smbus_byte_mii_read_default_c22(struct mii_bus *bus, int phy_id,
 	if (!i2c_mii_valid_phy_id(phy_id))
 		return 0;
 
-	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
-			     I2C_SMBUS_READ, reg,
-			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	i2c_lock_bus(i2c, I2C_LOCK_SEGMENT);
+
+	ret = __i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			       I2C_SMBUS_READ, reg,
+			       I2C_SMBUS_BYTE_DATA, &smbus_data);
 	if (ret < 0)
-		return ret;
+		goto unlock;
 
 	val = (smbus_data.byte & 0xff) << 8;
 
-	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
-			     I2C_SMBUS_READ, reg,
-			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	ret = __i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			       I2C_SMBUS_READ, reg,
+			       I2C_SMBUS_BYTE_DATA, &smbus_data);
+
+unlock:
+	i2c_unlock_bus(i2c, I2C_LOCK_SEGMENT);
+
 	if (ret < 0)
 		return ret;
 
@@ -147,17 +153,22 @@ static int smbus_byte_mii_write_default_c22(struct mii_bus *bus, int phy_id,
 
 	smbus_data.byte = (val & 0xff00) >> 8;
 
-	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
-			     I2C_SMBUS_WRITE, reg,
-			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	i2c_lock_bus(i2c, I2C_LOCK_SEGMENT);
+
+	ret = __i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			       I2C_SMBUS_WRITE, reg,
+			       I2C_SMBUS_BYTE_DATA, &smbus_data);
 	if (ret < 0)
-		return ret;
+		goto unlock;
 
 	smbus_data.byte = val & 0xff;
 
-	ret = i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
-			     I2C_SMBUS_WRITE, reg,
-			     I2C_SMBUS_BYTE_DATA, &smbus_data);
+	ret = __i2c_smbus_xfer(i2c, i2c_mii_phy_addr(phy_id), 0,
+			       I2C_SMBUS_WRITE, reg,
+			       I2C_SMBUS_BYTE_DATA, &smbus_data);
+
+unlock:
+	i2c_unlock_bus(i2c, I2C_LOCK_SEGMENT);
 
 	return ret < 0 ? ret : 0;
 }
-- 
2.49.0


