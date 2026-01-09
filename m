Return-Path: <netdev+bounces-248437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79096D087AF
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CD19303C67F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07F3375AA;
	Fri,  9 Jan 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBjU0aNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF8336EC5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953609; cv=none; b=fnqxJoX3rrEh8BH2qcQH85aXOds/Gg9+cMnKLDqTq2FjZ36yCwN//hvPbanKuyAK0NLB3QCfthNcQVqQo2zccLLw1LSG+wsp1nbVdUpIb0l4jlAtqC0x90Tbdg1rzhHT516ydB+EEIoGhuqlXFpqISoCyEGEko31aFjzMSpeYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953609; c=relaxed/simple;
	bh=LZv7VbJVZNPCl/GQ3+7aKwn27qsXY6G1rJO/vD5EKeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGWCJMDTKFRW5l90GVaVkhmjoEH8/YHIgzI+G9LLTzRTU+Ef3XkdyPPBlol+eUNPB1f2v6z4M5qRBPCmplH6HIKp7enKlCUs5yawCztXlke4bx95k386I+0CYxSASyorsZnWmCB6ATsxFlbQ9hz/OoYS7C8FRbAiy7njAKm1OnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBjU0aNp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so6204955a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 02:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767953605; x=1768558405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0HVCB8h37LjRdbYf+NBimR89qCOjk6XADJ4vCRu8yk=;
        b=NBjU0aNpmbNHIQOm7TpGa+/AM3fOQs1WOoVaQVyTILoCzyWsmZcZfygTkCNfrrIkG5
         2QFy0D31yIKIeTg5cLLWXGaPiPmpfRXT1no0xtO0906kh6bUuFe8g2woH8BOYeTLRh5w
         k3mWSpJla5007ZYNH2v98MfDJ18iGyQvD+ypAVSYuXaoixuEuLgtXPZnFsT/HMVejuOn
         X+eWZI4tNW+wtw8rQlOladLjZUD8kumNdFnqGQio6rOAw2cad5ZWYXJU9oyFnzrhsLAM
         FsEiI9AaXvr8BTOcqrGNbufH2Q9na8nen3zVMep6Cz0srQm522Fulj2RMmaCBUlZNekM
         q72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767953605; x=1768558405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0HVCB8h37LjRdbYf+NBimR89qCOjk6XADJ4vCRu8yk=;
        b=rTLHUSDKIHKAbiWP6/DsmE7dXvDOnbI3+44wx02kyPvCTMNe5Iv7NrJew1xCikQXaz
         fd5RLS/L1fxe4VM9KXL94YbVnqTLONOiJdG0NhhS+VlnZ7kwlSAuu2FInSYeQY4C2esS
         JkWtIPgd5i9IyO+rz7vBkPmaqRNBpb5vCx+hnfg6gWUTbUEYwOoBMgPLKTwUlUBpqU//
         8qSU7ZngyEo0pHMoXc2KRBToyInVBHyD7bNh9v6wToQztIyxj1bBNByervEifNKf6qr4
         b1ZommnamQ+2fRC+wwqGOfRaD9nLRwEZPKtApP1swOcF2qkk27cG4ft71twWMv30qjq1
         TnrQ==
X-Gm-Message-State: AOJu0YxD+wYi5h1eB42ebz9XqVVNgpn2gEc+JsP+5z7Oxi2DrerBTarW
	gl3zTPCc1FLnKTuk+UPb+6YowsJPDvzWHoJFjHddHGIfYWiedmCVrOA2
X-Gm-Gg: AY/fxX40+OQygnpO/SLM7iX/Twm9nZIgeGnnfUE6/ncK3EfURCd1h04zQ+tKITa45nq
	xymc74OWCYNUC7ABCqjVNXjMmwve3uLOtRLWw9QAoc1M7021XyFKTlr4kqdqLfDkPTCY4yN+GS+
	buHuJF1/cgyUV0jMOdfNO0GZwrLQnhj9QqqVsGpaof22g8U6PeBXUb+un8tN9DHW+qkurOfVAHs
	/uCLm+mvAHWKb8fCAJIgINnaqyVrIr9onCRfD1RSiiNhGeK2DuBNOoZp6hMNR/v9xnnCsgCj+ZJ
	5uElrTdDmQX10JRtZ8l89TB+ylDe5oSC8ZA2VP8c1+ouvRGSFlvxqEfYyFRanUwhZucfkzCwufU
	Ck5tI0c53jT1dxagBxVRU4HEI7gcQNLLiH9CwCVTZo8pWb6cewbDm4ND9L8y0giOt8JlRoKzn3P
	fnDqSmkecQN445nBw=
X-Google-Smtp-Source: AGHT+IHAs6M6/6d6TDseCaw58asjnE8jcwm8lPKvdScGi5kyj3ItTa1ERPN4RKKTaHnv8Pk62CNf+Q==
X-Received: by 2002:aa7:cf97:0:b0:64d:17af:81d4 with SMTP id 4fb4d7f45d1cf-65097e494a5mr6938930a12.20.1767953605213;
        Fri, 09 Jan 2026 02:13:25 -0800 (PST)
Received: from builder.. ([2001:9e8:f116:2816:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf661fesm10688575a12.25.2026.01.09.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:13:24 -0800 (PST)
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
Subject: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Date: Fri,  9 Jan 2026 10:13:21 +0000
Message-ID: <20260109101321.2804-1-jelonek.jonas@gmail.com>
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
changes since v4:
- fix formal issues
v3: https://lore.kernel.org/netdev/20260105161242.578487-1-jelonek.jonas@gmail.com/

changes since v2:
- fix previous attempt of v2 to fix return value
v2: https://lore.kernel.org/netdev/20260105154653.575397-1-jelonek.jonas@gmail.com/

changes since v1:
- return number of written bytes instead of zero
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
 

base-commit: fc65403d55c3be44d19e6290e641433201345a5e
-- 
2.48.1


