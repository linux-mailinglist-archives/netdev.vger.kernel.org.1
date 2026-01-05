Return-Path: <netdev+bounces-247098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D1CF49E4
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70AB13047FE0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5192A33D4FC;
	Mon,  5 Jan 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQM40Uti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987833AD96
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628036; cv=none; b=B0U9hvDEAqcZpKoQp+YAzzC/YP13c7zN+AlbrCb4UjKfSa8WMptMT/BArdI9mOnaavBS0IGLZYtmIeKxNJ1zxl4wGhKQggPtz3L6PhQJKSYb09HPwn/NzdydPcQ+l6jOvih4iA/WAFDQtg4puEWaLi0zNIwZXgl0gwKXOmVdAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628036; c=relaxed/simple;
	bh=QYEuEY61wG8oUvuzapP8GVYDVxXmSdsiwBHw/T5y+A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHwuWF5nNxjGwk7Xipvk1dIu/26Y77Zwr/n0ZU8ATb9ZV3i2IGVJIqyHUsFwf3yIQ9wtc+1r8MIygV3K44QuR6b3qK8JHO4YiyfeY/ICOjH2TVMtyGiuf6UvjymIuffzdbIxqmcnH/CfdQBgiE7h6F9o/mugT1iwoeqxm7FiMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQM40Uti; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso17740a12.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767628033; x=1768232833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+GEuhKvq1iucMrcGxna3GqAPQ3VBX1HpzGhekETBM=;
        b=RQM40UtiY5lxvSSPjr3Y7DBzWVrUjl703d7JPmFrL5hUN7AiffT1RNc3ktIKABDnAB
         484DKFA2v+zhn9DOJevM4fiHM68VwQt82DrZPkolwHZ7y9qLdky4nbGfkDw+TzlL39wc
         mlkH/Zb9xToM15IeHPCeLtokJCufNiSFfB/7D0jysZuFo+F1g0+HK+z7e35SCrEG47z4
         UitAH278KfVgi8L24F40iIojGft7p9AlB822tGU4NHXy/0KXyE/v1uIdNMeE3EA4QvAj
         GysG0GAVZBMN3N+sTFgXxhpm4ucqbWuCZdRr3k7CDXHwCkMmqE+J62vbjocomkojbRhT
         Tj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767628033; x=1768232833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+GEuhKvq1iucMrcGxna3GqAPQ3VBX1HpzGhekETBM=;
        b=JegTFedM0vUbyWaVCgx3u3TKHWYkooFCXNHZKS3QkuZSV4+gyzMbNR9y0tCXDhnbBA
         3zXiNayF6FZtM4b35IVXIW8Soya5s0s8VxhJ6l7YjNMgQ0dkv44FpG3ImcJK3UJUX+Jq
         1n85nnS1UBgXrW9fPqHhJ6xqt2UPp/D2gkaAyE8/oDCb2r75jtmp+sf3Ndyh6yWhebE7
         nQC8SU5e2cOsXW7K6eVFOolaDH40JWb3XJsCxpdTYPhBDxn/8Kq2ZlLsos45e08J9cwK
         HFjdLAcuybSrWjBg6+J//awpG/NfY4/68So9HeUiaArxubadGzIdUI4BCAtv7uNNOq6i
         +6bg==
X-Gm-Message-State: AOJu0Ywxc5OB3ZVRxbk4NJJN3utQnun+FZHFznZb4sgiEhN3FoDS6hsV
	f3ioxuJhLd9Y8y2lr9jfHZJpjgFpAxhAfL+cBjlHcbUC/kg5yi/ZaCX8
X-Gm-Gg: AY/fxX64ZVXymt4ZEAC6uKdREs9DmaaOV56TlHu6md7ZtayAzbchdeZPLiGFbDSmitO
	fxOBoenn2UPeQB+f7i92+B/hyBIr5YogPe3xN2GJdiiR/H+4azRPgm4YpRSQ00XMsJgehbIEq9o
	Wv7H3Ne4arZajxkJrRmDx0Jn9dUY6TIaJnoJWx0dVBCe1iVoX6c0H46+vP+G+OKYUa3+ciC6KEc
	Hfv6qX3GRR4DvpPVlVP7NivBCfjMXpl3Jb5rn6G783SBGG+1nLQ0U4nM8CPem+eKPZLb355c+mp
	4OxBfB9tfnf/Qc3cBU75Aga7JQGTuHl+znMtoNLJTJG8tmwQU5sq9cx5DZHCObdQl39xkxO2ctT
	bS0yl/S12Q8bJERWo+sMtSAJ9LBZ0J8EZSIdHcy8skNRNM1DxNiPYUfyW1T8sTtgjohCvG8SvSf
	eF3HAgmZpdeh4euCGqemFz6zJpjA==
X-Google-Smtp-Source: AGHT+IFu4fkD1Setd5lZUTe5/J+3L/4MXVljFxVKe0P+9I4fnxbNSOkjXQLnIsMCeE/m70suRLe4ig==
X-Received: by 2002:a17:907:a4b:b0:b6d:9576:3890 with SMTP id a640c23a62f3a-b8426bf130bmr18681866b.45.1767628032332;
        Mon, 05 Jan 2026 07:47:12 -0800 (PST)
Received: from builder.. ([2001:9e8:f13d:d916:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8426612903sm27217466b.30.2026.01.05.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:47:11 -0800 (PST)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v2] net: sfp: add SMBus I2C block support
Date: Mon,  5 Jan 2026 15:46:53 +0000
Message-ID: <20260105154653.575397-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
added support for SMBus-only controllers for module access. However,
this is restricted to single-byte accesses and has the implication that
hwmon is disabled (due to missing atomicity of 16-bit accesses) and
warnings are printed.

There are probably a lot of SMBus-only I2C controllers out in the wild
which support block reads. Right now, they don't work with SFP modules.
This applies - amongst others - to I2C/SMBus-only controllers in Realtek
longan and mango SoCs.

Downstream in OpenWrt, a patch similar to the abovementioned patch is
used for current LTS kernel 6.12. However, this uses byte-access for all
kinds of access and thus disregards the atomicity for wider access.

Introduce read/write SMBus I2C block operations to support SMBus-only
controllers with appropriate support for block read/write. Those
operations are used for all accesses if supported, otherwise the
single-byte operations will be used. With block reads, atomicity for
16-bit reads as required by hwmon is preserved and thus, hwmon can be
used.

The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
supported as it relies on reading a pre-defined amount of bytes.
This isn't intended by the official SMBus Block Read but supported by
several I2C controllers/drivers.

Support for word access is not implemented due to issues regarding
endianness.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

---
v2: return number of written bytes in sfp_smbus_block_write
v1: https://lore.kernel.org/netdev/20251228213331.472887-1-jelonek.jonas@gmail.com/
---
 drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6166e9196364..4f2175397534 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -744,6 +744,35 @@ static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
 	return data - (u8 *)buf;
 }
 
+static int sfp_smbus_block_read(struct sfp *sfp, bool a2, u8 dev_addr,
+				void *buf, size_t len)
+{
+	size_t block_size = sfp->i2c_block_size;
+	union i2c_smbus_data smbus_data;
+	u8 bus_addr = a2 ? 0x51 : 0x50;
+	u8 *data = buf;
+	u8 this_len;
+	int ret;
+
+	while (len) {
+		this_len = min(len, block_size);
+
+		smbus_data.block[0] = this_len;
+		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+				     I2C_SMBUS_READ, dev_addr,
+				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
+		if (ret < 0)
+			return ret;
+
+		memcpy(data, &smbus_data.block[1], this_len);
+		len -= this_len;
+		data += this_len;
+		dev_addr += this_len;
+	}
+
+	return data - (u8 *)buf;
+}
+
 static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 				void *buf, size_t len)
 {
@@ -765,26 +794,70 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 		dev_addr++;
 	}
 
+	return data - (u8 *)buf;
+}
+
+static int sfp_smbus_block_write(struct sfp *sfp, bool a2, u8 dev_addr,
+				 void *buf, size_t len)
+{
+	size_t block_size = sfp->i2c_block_size;
+	union i2c_smbus_data smbus_data;
+	u8 bus_addr = a2 ? 0x51 : 0x50;
+	u8 *data = buf;
+	u8 this_len;
+	int ret;
+
+	while (len) {
+		this_len = min(len, block_size);
+
+		smbus_data.block[0] = this_len;
+		memcpy(&smbus_data.block[1], data, this_len);
+		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+				     I2C_SMBUS_WRITE, dev_addr,
+				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
+		if (ret)
+			return ret;
+
+		len -= this_len;
+		data += this_len;
+		dev_addr += this_len;
+	}
+
 	return 0;
 }
 
 static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
 {
+	size_t max_block_size;
+
 	sfp->i2c = i2c;
 
 	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
 		sfp->read = sfp_i2c_read;
 		sfp->write = sfp_i2c_write;
-		sfp->i2c_max_block_size = SFP_EEPROM_BLOCK_SIZE;
+		max_block_size = SFP_EEPROM_BLOCK_SIZE;
+	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		sfp->read = sfp_smbus_block_read;
+		sfp->write = sfp_smbus_block_write;
+
+		max_block_size = SFP_EEPROM_BLOCK_SIZE;
+		if (i2c->quirks && i2c->quirks->max_read_len)
+			max_block_size = min(max_block_size,
+					     i2c->quirks->max_read_len);
+		if (i2c->quirks && i2c->quirks->max_write_len)
+			max_block_size = min(max_block_size,
+					     i2c->quirks->max_write_len);
+
 	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		sfp->read = sfp_smbus_byte_read;
 		sfp->write = sfp_smbus_byte_write;
-		sfp->i2c_max_block_size = 1;
+		max_block_size = 1;
 	} else {
 		sfp->i2c = NULL;
 		return -EINVAL;
 	}
 
+	sfp->i2c_max_block_size = max_block_size;
 	return 0;
 }
 

base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
-- 
2.48.1


