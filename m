Return-Path: <netdev+bounces-250512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50858D307E7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE42F30B450A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E6379984;
	Fri, 16 Jan 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StWvrU1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65329378D96
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563075; cv=none; b=OfPEUvkujuYBvzqup6Oz6MbTJJjUBfddAPM0F/RJBkS69ABo3cqMi/kRw/H/4N9paKxWVKccqMYAq4ffRnkuEHfCGLfgLxfG+DsGr4Nly0oWKbpJ5eSUug8vuaMzQHs3ugg8jTg0Omu1uiIM0HpOMWDOaVjIXGYC3IdSoL9ls/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563075; c=relaxed/simple;
	bh=S0PkLCZjarOG7ySOVOl2alRaMDNY0B9BDVZlqcYzNIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BilQpnzDah8ahg3FGT+PPDiIs61yg+eAc++2J6QGSdcNZo2qnV54WlVoV2OeZapn6cV2qQeMs9iHqGza/OEo/v9E6SSPWCIQyIqVY+VTDGVj34GcSpLfYUTJWcI1dB/ZEPdpsXPrY47CP+GZhpGNS60Sw2QzUXoNVeZoTDeQe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StWvrU1m; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so3181607a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768563071; x=1769167871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HccSZY+rZTaO1CqKYtPWo1Xi+9vA2I6W+eqQUhoLZlo=;
        b=StWvrU1mxD+jc5lMegowlx9Z34xS3AxtdetZMm8gERggFfvP/lyHp7Xn2u9nou4S9T
         ueb7T03PN6fySIAmyayOhqS1pAkDrhXiAH6Y+4FNunPcJ6rsC+sA+QbJDwsCTvKgzVv0
         l/Hd2A3a7OJmrSorHMkTvv4JEL80I8fZG57wxyva0CkFn86yakE0LYFy590Ad9HBXquT
         Nbg3Yu/PMzeD5BQNXJsmVaa4s4Pyp5wPObiBstKaVqY4Jze4pDv/8Fhxqe9Fvzm3/Oc4
         i/5mgwbx7FMTjSpEyyJ3fVHVOQSQBOkQWHRtGExRwjfHAUPHUjzUVJKI2Nk5HO9qNhq2
         /cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768563071; x=1769167871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HccSZY+rZTaO1CqKYtPWo1Xi+9vA2I6W+eqQUhoLZlo=;
        b=rxRlWBx0gzXrgYu2hqKBVDrEe/sgCepqTcLvEpzPi1CcRh80txQI9djEV/1M38C7dr
         BGk6Iu//qdTej1L2LNYpaOoTodNoqXKI2SY6RUE1rPXLGfc5tvm0fM/Wsp8CdB2hXmZt
         zSG4vRmfb1UNMiJzQFNXlXxKNGhN+yZI08JtlF+TPfOi8Q/n0ghIB++5igA3J0jxryqn
         9JugjXAcK0H11piK2oGIscKjYmvZpxiW1BYC+wcuqmYrC6QMvAYVLCcVI3oiE029QoyP
         P+ZRovGXQ0931pP+MP//932QGUBDndJnFGmAH2p0E2gadDAQaUT2zjY1WLSodoEuzO8R
         sP/g==
X-Gm-Message-State: AOJu0Yx7BMOsGOGyFZ83ew0kqa1eUHZ0ImLRgywsxsTpmWHDF9XI0XdU
	JXT4pgG2E/FAWSbEqqIH5Vw/NFieYZqtCSwNZaj5meQg0Q4C8Td4+7m1
X-Gm-Gg: AY/fxX4CG66UJpsve75cC0LX9B1oq1nwCzz5Fat9KaTAwtAe8gCHyWcZJbMke0YEvtI
	CjLj/7N62MvQVhZsi/1w3WX9AE1ZWeuJCUOZr0xh1qSsUG9pZ29dqfrXPs8P73fh4EXhdGz//lI
	lNaRpj2svbmCViilY9nzD8Ev/dFcCFsujkb/BW9luKyO5eNYKEKLW+IUQr+27QBBeHnkqT2S4uN
	FUZWGUNbasJ58i6E9ktlP0iDOKpgwvWneeorBGrFjKnXMR817NFloKSW1/+Olf4r5l2dI6xr4EB
	2hg7hOzfRBiJ9OnslfLJ5brWXejRtSLXqqb9tKKWCb/hJGlUrzSUzizKHY82mbYe266Zz2TrLrt
	ofcq8ZpZa6mkXrfB/+Ai6NKsPi3oDVfHLsGxtNMAHG/qc0rcGzldMNAnCjRDQAMo0LQROr22+OZ
	MVGSVhWYU2t8fA0blqIn1kr1oJYg==
X-Received: by 2002:a17:907:d7cb:b0:b87:2f29:2060 with SMTP id a640c23a62f3a-b8792e32203mr260561766b.26.1768563070244;
        Fri, 16 Jan 2026 03:31:10 -0800 (PST)
Received: from builder.. ([2001:9e8:f13f:1016:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fbefdsm204116066b.55.2026.01.16.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 03:31:09 -0800 (PST)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v5] net: sfp: extend SMBus support
Date: Fri, 16 Jan 2026 11:31:05 +0000
Message-ID: <20260116113105.244592-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
added support for SMBus-only controllers for module access. However, this
is restricted to single-byte accesses and has the implication that hwmon
is disabled (due to missing atomicity of 16-bit accesses) and warnings
are printed.

There are probably a lot of SMBus-only I2C controllers out in the wild
which support more than just byte access. And it also seems that in
several devices, SFP slots are attached to these SMBus controllers
instead of full-featured I2C controllers. Right now, they don't work
with SFP modules. This applies - amongst others - to I2C/SMBus-only
controllers in Realtek longan and mango SoCs. They also support word
access and I2C block reads.

Extend the current read/write SMBus operations to support SMBus I2C
block and SMBus word access. To avoid having dedicated operations for
each kind of transfer, provide generic read and write operations that
covers all kinds of access depending on whats supported.

For block access, this requires I2C_FUNC_SMBUS_I2C_BLOCK to be
supported as it relies on reading a pre-defined amount of bytes.
This isn't intended by the official SMBus Block Read but supported by
several I2C controllers/drivers.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
changes since v4:
- made a more general approach, also covering word access
v4: https://lore.kernel.org/netdev/20260109101321.2804-1-jelonek.jonas@gmail.com/

changes since v3:
- fix formal issues
v3: https://lore.kernel.org/netdev/20260105161242.578487-1-jelonek.jonas@gmail.com/

changes since v2:
- fix previous attempt of v2 to fix return value
v2: https://lore.kernel.org/netdev/20260105154653.575397-1-jelonek.jonas@gmail.com/

changes since v1:
- return number of written bytes instead of zero
v1: https://lore.kernel.org/netdev/20251228213331.472887-1-jelonek.jonas@gmail.com/
---
 drivers/net/phy/sfp.c | 124 +++++++++++++++++++++++++++++++++---------
 1 file changed, 98 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 84bef5099dda..8f0b34a93ae8 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 
 #include "sfp.h"
@@ -719,50 +720,103 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
 	return ret == ARRAY_SIZE(msgs) ? len : 0;
 }
 
-static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
-			       void *buf, size_t len)
+static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
+			  size_t len)
 {
 	union i2c_smbus_data smbus_data;
 	u8 bus_addr = a2 ? 0x51 : 0x50;
+	size_t this_len, transferred;
+	u32 functionality;
 	u8 *data = buf;
 	int ret;
 
+	functionality = i2c_get_functionality(sfp->i2c);
+
 	while (len) {
-		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
-				     I2C_SMBUS_READ, dev_addr,
-				     I2C_SMBUS_BYTE_DATA, &smbus_data);
+		this_len = min(len, sfp->i2c_max_block_size);
+
+		if (this_len > 2 &&
+		    functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
+			smbus_data.block[0] = this_len;
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_READ, dev_addr,
+					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
+
+			memcpy(data, &smbus_data.block[1], this_len);
+			transferred = this_len;
+		} else if (this_len >= 2 &&
+			   functionality & I2C_FUNC_SMBUS_READ_WORD_DATA) {
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_READ, dev_addr,
+					     I2C_SMBUS_WORD_DATA, &smbus_data);
+
+			put_unaligned_le16(smbus_data.word, data);
+			transferred = 2;
+		} else {
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_READ, dev_addr,
+					     I2C_SMBUS_BYTE_DATA, &smbus_data);
+
+			*data = smbus_data.byte;
+			transferred = 1;
+		}
+
 		if (ret < 0)
 			return ret;
 
-		*data = smbus_data.byte;
-
-		len--;
-		data++;
-		dev_addr++;
+		data += transferred;
+		len -= transferred;
+		dev_addr += transferred;
 	}
 
 	return data - (u8 *)buf;
 }
 
-static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
-				void *buf, size_t len)
+static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
+			   size_t len)
 {
 	union i2c_smbus_data smbus_data;
 	u8 bus_addr = a2 ? 0x51 : 0x50;
+	size_t this_len, transferred;
+	u32 functionality;
 	u8 *data = buf;
 	int ret;
 
+	functionality = i2c_get_functionality(sfp->i2c);
+
 	while (len) {
-		smbus_data.byte = *data;
-		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
-				     I2C_SMBUS_WRITE, dev_addr,
-				     I2C_SMBUS_BYTE_DATA, &smbus_data);
-		if (ret)
+		this_len = min(len, sfp->i2c_max_block_size);
+
+		if (this_len > 2 &&
+		    functionality & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) {
+			smbus_data.block[0] = this_len;
+			memcpy(&smbus_data.block[1], data, this_len);
+
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_WRITE, dev_addr,
+					     I2C_SMBUS_WORD_DATA, &smbus_data);
+			transferred = this_len;
+		} else if (this_len >= 2 &&
+			   functionality & I2C_FUNC_SMBUS_WRITE_WORD_DATA) {
+			smbus_data.word = get_unaligned_le16(data);
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_WRITE, dev_addr,
+					     I2C_SMBUS_WORD_DATA, &smbus_data);
+			transferred = 2;
+		} else {
+			smbus_data.byte = *data;
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_WRITE, dev_addr,
+					     I2C_SMBUS_BYTE_DATA, &smbus_data);
+			transferred = 1;
+		}
+
+		if (ret < 0)
 			return ret;
 
-		len--;
-		data++;
-		dev_addr++;
+		data += transferred;
+		len -= transferred;
+		dev_addr += transferred;
 	}
 
 	return data - (u8 *)buf;
@@ -770,21 +824,39 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 
 static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
 {
+	size_t max_block_size;
+	u32 functionality;
+
 	sfp->i2c = i2c;
+	functionality = i2c_get_functionality(i2c);
 
-	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
+	if (functionality & I2C_FUNC_I2C) {
 		sfp->read = sfp_i2c_read;
 		sfp->write = sfp_i2c_write;
-		sfp->i2c_max_block_size = SFP_EEPROM_BLOCK_SIZE;
-	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		sfp->read = sfp_smbus_byte_read;
-		sfp->write = sfp_smbus_byte_write;
-		sfp->i2c_max_block_size = 1;
+		max_block_size = SFP_EEPROM_BLOCK_SIZE;
+	} else if (functionality & I2C_FUNC_SMBUS_BYTE_DATA) {
+		sfp->read = sfp_smbus_read;
+		sfp->write = sfp_smbus_write;
+
+		if (functionality & I2C_FUNC_SMBUS_I2C_BLOCK)
+			max_block_size = SFP_EEPROM_BLOCK_SIZE;
+		else if (functionality & I2C_FUNC_SMBUS_WORD_DATA)
+			max_block_size = 2;
+		else
+			max_block_size = 1;
+
+		if (i2c->quirks && i2c->quirks->max_read_len)
+			max_block_size = min(max_block_size,
+					     i2c->quirks->max_read_len);
+		if (i2c->quirks && i2c->quirks->max_write_len)
+			max_block_size = min(max_block_size,
+					     i2c->quirks->max_write_len);
 	} else {
 		sfp->i2c = NULL;
 		return -EINVAL;
 	}
 
+	sfp->i2c_max_block_size = max_block_size;
 	return 0;
 }
 

base-commit: 74ecff77dace0f9aead6aac852b57af5d4ad3b85
-- 
2.48.1


