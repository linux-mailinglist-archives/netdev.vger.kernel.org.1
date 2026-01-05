Return-Path: <netdev+bounces-247110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213ECF4A36
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0713430859A4
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300B32E753;
	Mon,  5 Jan 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZoNDfGj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0031B107
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629576; cv=none; b=g436RXBLoSMHH2iSXhWc/P1EXIiaE8RZ4Vxl0uP8UmJaQjnLnRc+hs/Va8rY0D6T03UEc4uh99hydV9k8rZPW65hr9bqJGup4FzE6edLC8m+5kfAG2psKCjFaEXFsUao2nQrXLsBw7MBDv+7hI6glFMcbiO9+oa0gCsbyG24UNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629576; c=relaxed/simple;
	bh=+5jhfypVPPIYb0+sRwbUK3QmAT6+nuI7bYH6l4HoWgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AakoXND6zC6cIIIDJpC6Xcvs3tsaF2LFkzilU+WA65zsZVhivYRDTEKoVElCdRcFVDGAOS4qqKREltT7KSNOdTke+8F/a3tQod0yQxaQPsMbtDXb6waE4spPirTeWbgs0hQfWgpBNp0buhff6/JIL8KHRuqS+QlkJZDIto2nbr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZoNDfGj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so62859a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629573; x=1768234373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JyO/4GLHb5fMiTunzQRnSORs3Y8GgfKp+eWwFQOVdM=;
        b=OZoNDfGjYpdBxijD1H7c70TckZ1VT+D1C8FDMXvWhQVU4K/LmoH0pWpcY9cyxbdkX/
         LTWsoE5ua4E5ktM3mZF+Uf3WNTSIbkjmu4dxlzze73Adq0v+6S4atZQd+LQjWhts92PV
         a8UuLqVTLwwREerata26q7EDovFPcjdQ/qdtSnw3BGLDb8p/n4jtLz/LczcVy3JVvsmb
         CtBbvs5BR/hMQEuxgi/Kxp4c6y4xdlkLBaqX/dWFGu52vr7xzIT/539OCBuXhYQpXVrd
         B/42PrgwKAnPP22SsajsWevCiLdtDIz97KxflBg97EgNrxg34yFIGALT5pMhCy0YwI9G
         WPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629573; x=1768234373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JyO/4GLHb5fMiTunzQRnSORs3Y8GgfKp+eWwFQOVdM=;
        b=QVsfnvRbI56jaUQrjkZKYcNO3LSzXUXCk2SEjfkOiyemg54OvSDNamfnbygFI8TKhv
         ki+FSAEfhr3mnE33xdrrcrP3YwDoCKtEY93bdhl3fDZ5nJOyVp5HuYYkHOxkZznofpfT
         GrFDSgDW+gLTgJpNbZCJi8MbZxCMRzfCMV7P0Yp68jJ88/uMeP6rlXNr7BLiWFpzXxvn
         AobLBCQe68ZcE3ogcYXg4ynnY3uOx/dLLm/rSqlG3zAS9+koO0RvqnN2BNvBbchCibUN
         hhs1LNgtAQOiSxCrfv9NP3RGcO/S6G1z3h94+f1OP23HndW7iK3ceRHDvnezEvr0w5Nf
         oghQ==
X-Gm-Message-State: AOJu0YzQM+pIoD65M25ESuhhWVnMz5L4TFLbJ0u0dMMrviUI+3A/Xkyq
	Hw3gDtEnx54TxlslR3E+0bkoFJl+tQYVX/CgOwrvwQ/2AOtQ6azoIQjm
X-Gm-Gg: AY/fxX4/7fYSRDUhphMnL+MHLTqpI09amoGTnpy3cUoEDb3mcnPn4u+DlsSh8ZfiIfO
	h46t69EyIp/QjvOPlLhXyalQKvj/BZ/e5PKp/MFLjsuFJQqKi0i0dbCghEWyI67sp6W/Tg8n4FR
	pS6GgSDzqwIep7NsyeoaLGOIxTY6SXlbwUHJ6r2tWLheCVfMPChmqH+cdJ/a1pkagi5gFHz6u/X
	q+boCE9zIzCLPDTVY5D30MZrWVqwfg0M6CX6Tc5n8c6/GpTwKmqPw9xRbQhfZpNI0sfyo6W/yol
	J+VdpQfXierABF7ic7Wc8dZ4xK9kFVk3co6KhTNQKnmpFdeFRUAbbGjqhUyZBjFaQQ67OETmDGQ
	J9OmY0UEEJZaEe+LZF2KGR7PUw8H3Ux0du6ucpI279cRw6y7BOUuzKxHtOEe0D0MCwo/u5NuwuL
	myjo5n//4CWF2nses=
X-Google-Smtp-Source: AGHT+IENmT/MU8iQb9/3/4a9APHsSe4lNd++/lbyAnV3R6n9vio3JwjLfVyuMDllZ9wMr6RrbeBpkA==
X-Received: by 2002:a17:907:6d21:b0:b7d:1cbb:5deb with SMTP id a640c23a62f3a-b8426a9f126mr33838266b.27.1767629572962;
        Mon, 05 Jan 2026 08:12:52 -0800 (PST)
Received: from builder.. ([2001:9e8:f13d:d916:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b84265ec75fsm29908566b.20.2026.01.05.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:12:52 -0800 (PST)
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
Subject: [PATCH v3] net: sfp: add SMBus I2C block support
Date: Mon,  5 Jan 2026 16:12:42 +0000
Message-ID: <20260105161242.578487-1-jelonek.jonas@gmail.com>
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
v3: fix previous attempt of v2 to fix return value
v2: return number of written bytes in sfp_smbus_block_write
v2: https://lore.kernel.org/netdev/20260105154653.575397-1-jelonek.jonas@gmail.com/
v1: https://lore.kernel.org/netdev/20251228213331.472887-1-jelonek.jonas@gmail.com/
---
 drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 84bef5099dda..a1deb80f630a 100644
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
@@ -768,23 +797,67 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 	return data - (u8 *)buf;
 }
 
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
+	return data - (u8 *)buf;
+}
+
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
prerequisite-patch-id: ae039dad1e17867fce9182b6b36ac3b1926b254a
-- 
2.48.1


