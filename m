Return-Path: <netdev+bounces-246195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985ECE5797
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 22:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BBFF30038D1
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59223E325;
	Sun, 28 Dec 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMHPTRj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5823FC5A
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766957634; cv=none; b=s9kSh5ldsfFZF9wdddj1fQpA1fYPPYpQhSF1WgV7qov6VPhsV788Oh6sI2ZvFWsSsgYnsJJ9zAhqsXLgqrRbGe2rj5CVJojdUtznEEQ/pjimDgVWJ7zqJogXUP4pV4xV5FWFpPmUgQX+RHEHn08x0FQBBMruY2TjuXKw0JAGf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766957634; c=relaxed/simple;
	bh=az9tq5vkWNyI5dmkwb9SRrHDIFGiftqYFDZ7jtfIEB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T77YVgaiYXfDE/ttq2cI/ZwykxjBmd7zcM4mmCt6WD34QBVPqXuldI669QfU5iPLA/1pTYyh9HYi6aYuPTijmSs9lNmLJ846WHGM/5SCKL/2TUZ28JhDEsVlpUVhhDUt35AJaOOLqd9YQOriqZqJ6AqgwaYuZ70DIKsiqIfDtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMHPTRj1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so4236704f8f.0
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766957631; x=1767562431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M4TajEatn0rrqZiK2uI6pVwpeHJFLxkhdBPtFxXjfQ=;
        b=aMHPTRj1FcqmCkByiuussXQftOG2mGpnILdpVcU//HDHeJMo2szDT2Z9r6WYW/lvNA
         JOc0LaOOHHMUy2J5qqFBN6Ye+Z/d0m14A3Eso9U6crIMtuNlenX7Gc7UMmoZw1acm0rJ
         rJvW7Br7uPlr+jQGveO7l/gnff8fWsLaNwUEpsJhy4F+EHtpPd7CzeXyXHyoOXEf0WM9
         l5KZBfh6hkz2Ccb3vmOUo7vQ6OowiYvEKX+ciO42mkEOAGZ7c5WDq5Gho0dXGw5WCbJL
         rFP/sW+Qmst4jeGRkBtSS7FHCQHYJq32uFcFYXLzV+PQZwy9WL2dGwPcad/qV92KuKzC
         utrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766957631; x=1767562431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M4TajEatn0rrqZiK2uI6pVwpeHJFLxkhdBPtFxXjfQ=;
        b=oeWzPYkQRowSlaX5SqxIB1elF1/K9EcMBEwAbmhR1xr5IX1VptU9Z/NS7biAhUGKfF
         QWCh8jjmFnMakt43B4DpaP75dLCUY6adhpjGTotkjgsajt6v0c6Z6eNYp/sVGEvMuQ3Q
         KCiv6oTMu5gHicWM7pztC6YvTjp5yqRjXeDWGvJlVeIkzoAa792di7eiFPH5wlVD8a4w
         c8WIZNrVZWIV/nKTVdeCYzLUK7rUHKWfzg39DkaOKOcMvD/7x0BtChcBHV1IsRcOmr1E
         BZh1rQHigxhmN8oDOd5KxMZQ6eoH1RdyEQAQ2fyg5SNVilDoVZL4azhG/4A8/5VvKjw3
         F7eA==
X-Gm-Message-State: AOJu0YyaYsZGrqUabjQHoD+b00eI0dsYdETJoMENkWYS0NZG42voXln1
	6q4lvIXnkRnap6JpwljnOeiAS3guV+PCHlY29F6Nunk3Bvfhsc1klLW7
X-Gm-Gg: AY/fxX6M3ihUE4FaPJVHPiXjW7MrsCEyIfRoAISxWBL+kWYMNSWHB7Cabl1Hj9fNKHp
	aPwRh4vzXU9Ck7mus+YFemiVHranIGkXB7uo5ywkXVbFK82VTQMejHlXqrJB7n4m6PJ5rxU6qSa
	RvufzaJlnNUajoNT6hqszZB6s/ehN6gqSc7XWt1dl3UGOfy2qrvU+Azr/ZReGx5qXgvXE1X4WPX
	dbbYsPrjNK2hhfk8K0kDOvXYWrMojK/83QA6gsSz7XqUiF02vuPiLnZWy/ewJxX9fvbTZy/yZDM
	s1Qgiv1wuN0ZiSrxNI5pk4TPzVgxAWKqXw0MfqTGYsPjp3UcoFk4E3TrYV8EkeS+3HfGEJ1TgnN
	vXKe9KCSH1nQ2gQY10114DQJ2AVqwDlhmX0AMS8InjLJEUCHu8EGpaIqvn2STNRqAMhpWd43SjG
	NsEg5hQWfq7cqrGkg=
X-Google-Smtp-Source: AGHT+IGYU9WnSfVG4+4SZrHi2sCZjhcjLW707xvS9JQjXa/Yl5AZ9YJeVjFk7fmGE625aLmogNrSEg==
X-Received: by 2002:a05:600c:468f:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-47d269c7019mr289643875e9.18.1766957630638;
        Sun, 28 Dec 2025 13:33:50 -0800 (PST)
Received: from builder.. ([2001:9e8:f110:f516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm58706764f8f.7.2025.12.28.13.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 13:33:50 -0800 (PST)
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
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH] net: sfp: add SMBus I2C block support
Date: Sun, 28 Dec 2025 21:33:31 +0000
Message-ID: <20251228213331.472887-1-jelonek.jonas@gmail.com>
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
 drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6166e9196364..c5019fb682a3 100644
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
 	return 0;
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
+	return 0;
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
 

base-commit: 3387a7ad478b46970ae8254049167d166e398aeb
-- 
2.48.1


