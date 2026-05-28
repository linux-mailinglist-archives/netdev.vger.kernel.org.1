Return-Path: <netdev+bounces-292844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK2zNnytGGpolwgAu9opvQ
	(envelope-from <netdev+bounces-292844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DA5FA22A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0A832C08F7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00835C1B2;
	Thu, 28 May 2026 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/Vklm7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99E352014
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001574; cv=none; b=mKyIVpuC3EsUjxX/gENmzpvuXg8w8+T7nxFMftR0l6qThCOZsCynlpuqg/aw+Wg9A+pZNdSGOnQWzIwg250pmJZk9inDDDsXEV/q6ynSdZPxlmoC2ma+OP4M9rkmabALof8BMsjpnSyJiJSvr4+FIgJB5Xk8rg6QqXDFJ6w0/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001574; c=relaxed/simple;
	bh=gYl2Q5OIz8c1hTuxPbnw6ypHy1wyYNAAdMV8txuM8r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9WcmAANVWj4y1AbiezRRrtH33md5LLE1CaZXMsKlQo8REq29SFrhYy+8ml1C2AjmpSp28r0+4vVGf5nN2u4fjnQIOMT2E7BtoUgVP16boHnNsJvzpcgBvmANisqAyfLsF2XEX2XMua2Gpzn4CAAamCi1/g1/uJ8SNIfkBDzrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/Vklm7i; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49039a8851fso76545135e9.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001571; x=1780606371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etJjvA+lJoJ5iQ2R2eIRXhSV62QeiitQTrJwFNjFCsc=;
        b=c/Vklm7iYfsGfz5fMiZPPLcvkO23gAS0ITNR3BFoeYWtzlXcx4LptTt6A4RedmBfEM
         5zZ3ypIhi5YuA90WWdRKDXfTwPwNcN72ZRPCUo30uNLcZcrS+OkLSbbaeKmPe7OcXqjy
         JR1ncWcx8H09LykmnEbaROJCWIeSjBOsJ+lL5eFqJIMIwE13IdC2EeoM+nkR+qU78eZ6
         2I/SvaeHcHXQ11JFv/TAhlwvuUsUu4qfxTddk9y0XE0t5TEkJZI5WBF117wYxGj8GHq9
         2FqaJiSgaAjfgThFi/BceLM/FG2lisjE4+yIMKrVIE+hXkAdWsQ8qsqMt1gL8c0LKVwT
         zdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001571; x=1780606371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etJjvA+lJoJ5iQ2R2eIRXhSV62QeiitQTrJwFNjFCsc=;
        b=dg0qtfoBU6xeo9xFXHX0JFyUozPW8QJFeql/dWHCvP6wVMK7ey8uVPC+tzg1DChTaq
         Rkac9S9EQ9v2MHGI6gZdP9OOG9BMa0zSgCw0UB8UikJ609mUhnnz1qN/eLkUBrRAy/mg
         o+nUe7pajRCXEqc5OtrbGzQQDAAaeFSe8Gl6Na+vd0lVWOuRfpIyXynBGovRWazRgJ0k
         TuedKcnRmDHNJcd0MiC9ewKXy8c2F76VEOm4zjjg2LPYy3g5YF2QhFMCIB3uJCrPy4qo
         s6CZPPdv2M1/D2z00jQkTaa4WNOMjkTsqVD0HrUea/7IowWsqEp4fdWz9ruTXRPotNl5
         7gLw==
X-Gm-Message-State: AOJu0YwlJyzZYw/vzzBRrCZm7qUH1aAd3wl9sMBBUQXwHVdSN+OOoxCq
	UTsTSkaRn5yAbZICxJ2TZEYnOQdTldgdwk8DN9wLsQTF7kbQSmDUWo9D
X-Gm-Gg: Acq92OH+apIWpYMMIcsnPhdbvJinA/Ri1klzFEqgwoKxMc7M2uyIHwzeaGG/GDg9RiV
	Shh7W5brlgP2a9ghGmOqafAIFddNpCKCiHC61NiDgXy2ldrBPkY3+T/06U0clLQQet8aV8Hk/0y
	MSk8e2o2YEN13liDc/9ee/227ZOs08DCnJ8Ix4qXh5FIBkjTjq8i8TXWsp9Eagi7YC8MIavk3+D
	I+cd4n87OBUyV7cgKz8taYz0yZ8+nd1AHIRSJoSlu3rxjKwHcNBkazn+bYW6H48IZn8gtcssGxv
	KJF/py2sTkGp84GViKOhkb1EI/alKfOen0l4BU8+JW4b5KKyQ0L/uW7BfBPIgdGktmkDIefD4CP
	erZbNCaRFYZ9hZO592CBV5NJLWEtPA4sq1ifDnomNnsufCGJ9QqeBAnn2sqhMMhiWl4ws2cbqAx
	Dj46rmOHibWA46kqpSgVt9VhDkfdkjrkS2UZrU
X-Received: by 2002:a05:600c:58ce:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4909c0b546cmr1174425e9.24.1780001570449;
        Thu, 28 May 2026 13:52:50 -0700 (PDT)
Received: from builder ([2001:9e8:f104:6516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee5a84e92sm7104028f8f.35.2026.05.28.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:52:50 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v9 3/3] net: sfp: extend SMBus support
Date: Thu, 28 May 2026 20:52:42 +0000
Message-ID: <20260528205242.971410-4-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528205242.971410-1-jelonek.jonas@gmail.com>
References: <20260528205242.971410-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-292844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: 495DA5FA22A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
added SMBus access for SFP modules, but limited it to single-byte
transfers. As a side effect, hwmon is disabled (16-bit reads cannot be
guaranteed atomic) and a warning is printed.

Many SMBus-only I2C controllers in the wild support more than just
byte access, and SFP cages are often wired to such controllers
rather than to a full-featured I2C controller -- e.g. the SMBus
controllers in the Realtek longan and mango SoCs, which advertise
word access and I2C block reads. Today, they cannot drive an SFP at
all without falling back to the byte-only path.

Extend sfp_smbus_read()/sfp_smbus_write() so that, in addition to
the existing byte access, they also use SMBus word access and SMBus
I2C block access whenever the adapter advertises them. Both
directions are handled in a single read and a single write helper
that pick the largest supported transfer per chunk and fall back as
needed.

I2C-block is preferred unconditionally when available: the protocol
carries any length 1..32, so it can serve every chunk -- including
the 1- and 2-byte tails -- without help from word or byte access.
Note that this requires I2C_FUNC_SMBUS_I2C_BLOCK, which reads a
caller-specified number of bytes. This deviates from the official
SMBus Block Read (length is supplied by the slave) but is widely
supported by Linux I2C controllers/drivers.

Capability matrix this implementation supports:

  - BYTE only:                  works (unchanged behaviour); 1-byte
                                xfers, hwmon disabled.
  - BYTE + WORD:                word for >=2-byte chunks, byte for
                                trailing odd byte.
  - I2C_BLOCK present (with or
    without BYTE/WORD):         block as the universal transport for
                                every chunk.
  - WORD only (no BYTE/BLOCK):  accepted with WARN_ONCE. Even-length
                                transfers work; odd-length transfers
                                (e.g. the 3-byte cotsworks fixup
                                write) hit the BYTE branch which the
                                adapter does not implement, so the
                                xfer returns an error and the
                                operation is aborted. No mainline
                                I2C driver was found to advertise
                                WORD without BYTE; the warning lets
                                us learn about it if it ever shows
                                up.

Adapters with asymmetric R/W capabilities (e.g. only READ_I2C_BLOCK
but not WRITE_I2C_BLOCK) remain functionally correct -- the
per-iteration fallback uses the direction-specific bits -- but the
shared i2c_max_block_size is sized by the all-bits-set check, so a
transfer in the better-supported direction is not upgraded. None of
the mainline I2C bus drivers surveyed during review advertise such
asymmetry; promoting i2c_max_block_size to per-direction sizes can
be revisited if needed.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 136 +++++++++++++++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 60f36cba3d83..1725eb2151a1 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 
 #include "sfp.h"
@@ -758,50 +759,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
 	return ret == ARRAY_SIZE(msgs) ? len : 0;
 }
 
-static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
-			       void *buf, size_t len)
+static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
+			  size_t len)
 {
-	union i2c_smbus_data smbus_data;
+	union i2c_smbus_data smbus_data = {0};
 	u8 bus_addr = a2 ? 0x51 : 0x50;
+	size_t this_len, transferred;
+	u32 functionality;
 	u8 *data = buf;
 	int ret;
 
-	while (len) {
-		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
-				     I2C_SMBUS_READ, dev_addr,
-				     I2C_SMBUS_BYTE_DATA, &smbus_data);
-		if (ret < 0)
-			return ret;
+	functionality = i2c_get_functionality(sfp->i2c);
 
-		*data = smbus_data.byte;
+	while (len) {
+		this_len = min(len, sfp->i2c_block_size);
+
+		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
+			smbus_data.block[0] = this_len;
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_READ, dev_addr,
+					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
+			if (ret < 0)
+				return ret;
+
+			memcpy(data, &smbus_data.block[1], this_len);
+			transferred = this_len;
+		} else if (this_len >= 2 &&
+			   (functionality & I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_READ, dev_addr,
+					     I2C_SMBUS_WORD_DATA, &smbus_data);
+			if (ret < 0)
+				return ret;
+
+			put_unaligned_le16(smbus_data.word, data);
+			transferred = 2;
+		} else {
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_READ, dev_addr,
+					     I2C_SMBUS_BYTE_DATA, &smbus_data);
+			if (ret < 0)
+				return ret;
+
+			*data = smbus_data.byte;
+			transferred = 1;
+		}
 
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
-			return ret;
+		this_len = min(len, sfp->i2c_block_size);
+
+		if (functionality & I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) {
+			smbus_data.block[0] = this_len;
+			memcpy(&smbus_data.block[1], data, this_len);
+
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_WRITE, dev_addr,
+					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
+			if (ret < 0)
+				return ret;
+
+			transferred = this_len;
+		} else if (this_len >= 2 &&
+			   (functionality & I2C_FUNC_SMBUS_WRITE_WORD_DATA)) {
+			smbus_data.word = get_unaligned_le16(data);
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_WRITE, dev_addr,
+					     I2C_SMBUS_WORD_DATA, &smbus_data);
+			if (ret < 0)
+				return ret;
+
+			transferred = 2;
+		} else {
+			smbus_data.byte = *data;
+			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
+					     I2C_SMBUS_WRITE, dev_addr,
+					     I2C_SMBUS_BYTE_DATA, &smbus_data);
+			if (ret < 0)
+				return ret;
+
+			transferred = 1;
+		}
 
-		len--;
-		data++;
-		dev_addr++;
+		data += transferred;
+		len -= transferred;
+		dev_addr += transferred;
 	}
 
 	return data - (u8 *)buf;
@@ -817,10 +878,29 @@ static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
 		sfp->read = sfp_i2c_read;
 		sfp->write = sfp_i2c_write;
 		max_block_size = SFP_EEPROM_BLOCK_SIZE;
-	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
-		sfp->read = sfp_smbus_byte_read;
-		sfp->write = sfp_smbus_byte_write;
-		max_block_size = 1;
+	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA) ||
+		   i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		/* Either protocol alone covers any length: I2C-block carries
+		 * 1..32 bytes per xfer, byte iterates one byte at a time.
+		 */
+		sfp->read = sfp_smbus_read;
+		sfp->write = sfp_smbus_write;
+
+		if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_I2C_BLOCK))
+			max_block_size = SFP_EEPROM_BLOCK_SIZE;
+		else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_WORD_DATA))
+			max_block_size = 2;
+		else
+			max_block_size = 1;
+	} else if (WARN_ONCE(i2c_check_functionality(i2c, I2C_FUNC_SMBUS_WORD_DATA),
+			     "SMBus word-only adapter; odd-length transfers will fail\n")) {
+		/* Word-only: even-length xfers work; odd-length xfers fall
+		 * to BYTE, which the adapter does not advertise and will
+		 * likely fail.
+		 */
+		sfp->read = sfp_smbus_read;
+		sfp->write = sfp_smbus_write;
+		max_block_size = 2;
 	} else {
 		sfp->i2c = NULL;
 		return -EINVAL;
-- 
2.51.0


