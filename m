Return-Path: <netdev+bounces-298697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wRsbJxMYLGofLQQAu9opvQ
	(envelope-from <netdev+bounces-298697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC167A304
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:30:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YuQFOLBF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298697-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298697-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A643931DD41B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5DF38CFFE;
	Fri, 12 Jun 2026 14:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E2388E4F
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:28:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274537; cv=none; b=nJyUcUXR7A3D6Q/GTo2LTJiUf2skcsQn/1P8+OAe4HHyjGT4GftXQFG2sAVIzioBPWK8vBuGGTdqzV97VQAjK8gxVF9DOJ/rtXV/wcvV+ghprDAlzBAIU4S3WFiXMd8HBVUM9VtrIwHWZCSLwGhT+ZYbd39KyEI5VhnRAsHrmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274537; c=relaxed/simple;
	bh=drYtyk8sa8FtyY+He0WDGl1ZCXxmi2hMWg4so7bVPYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p696knk9CAgHS4NHhj52/C66RomFNMItoE+Nt2+vvu+2o/6W6knx7yF9ee8gF5AzyIhLNky3P9R1tvx0w8CIZEUZzFoic4bDEOTa9Ejx+8cDUrJcPAO6ofAkjRMTj50doTYN/TWNpraj3U7lA5OeHHFlOIQut8KCp0jylSFy4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuQFOLBF; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a76757e5so7988175e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274534; x=1781879334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJHkOnPoCLmJvnRHd2fhpyqTWYKMhK9N637R6tbusLw=;
        b=YuQFOLBFSpaCjl+UlpAtWR8++gBhHBSTxV2JwIv6+myWkMc7jy2sKPOpikBBchX1dZ
         Ydv85PRXIgus4pP7wfTJviSMxANQxNdAFsURjn5xMCBq95cxTvF0EUKT5VtfiKg7QuOG
         Sd1aucRsql8USc8RP110ZqX1VWhx2HhALwEj12WUvwYi1OTTP9hvCt1EZn3BuXog7aQZ
         Zh3EwAub44Lg8Z4F+iEaRV+ZxBhaHWj4HejOgb4mV/DjgqroWM2YdU3NR8CjDt/T/GV5
         b4yos/ovuksDPfcpfAW4urpUm4R4VwiGZL4WOFV49UshcNGQV4z4IajOK8jeOoSyaVx5
         D6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274534; x=1781879334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJHkOnPoCLmJvnRHd2fhpyqTWYKMhK9N637R6tbusLw=;
        b=Lp/S8bhziXEIFXsCjT5wiTlylpV8DvQQCWqwveb3YKMMGpUaLof45+WQl7HoCMpa8w
         CFX28TFFkUyKjeL43/9IFgstN3xB56yFmkKa6ldyHHjwo1gbG8FuuWcVdWimC6l3KYee
         5KyxEBU8t4w1vcaK0WTjgmM/ysHxfUox7LtpzvXYY5ro44Hr9o/R/lP1i+7k/HqElG24
         5LK2m2y/BA+3UkpMbV0L9KMMvQdiaD7eAidVjEOtW9HnPUTp5aEvXfpGmNkJY2VTP/hJ
         e8fIsjqbdor9MMHm0scbc43sto5xdr+XJ5T9EmsQwliJZjcupcfhl73nzOpesPDisYok
         puVg==
X-Gm-Message-State: AOJu0Yy+Vq1D7nh/cwaIrR9IBcplT3eUV2+3BbGVL31CxKZMqca30WSG
	INchABFb0UDq/0OS3Y+EAhToRjwe+0w/2Q6g6rDZtApMEh1yk5a77hpm
X-Gm-Gg: Acq92OGC4XJOzbCrXY1x4UV+IWjOzhze8XyiZmfvX9y1b3dBppOr9gsOqtXP00aOiDp
	r1ZxwLQoraDm5FQp6hvQPdgFP3z7D5z3hryngFxYeFiiTX4OwjcIAjvR4yD74/feZ0+AAYq3HfF
	KRhR4MW6qpOVoTmOtqG1AF0vrvMASZdvSZlJ7IHS40nEpCHhAe4qQUoVJzUoF2AygW4rbIItrld
	QH+Ec8K9pW6Qn+vf7rUcIM/dE9unuPmIP87/iumK7x3eRXVpiJ3RAuQkLWzNKp5Xh1HM436bRDZ
	c8l1tWaEBd+SjYU0doi17tlpkWl3yg0g8bwVAYOictmzUElAnwhaszlISnHrmbDbQ5dnvbOmijG
	dcUy2qun732s6WHiN5PFPbxNuMxoAZJ1xmcHikSsWDCR9G56EQX40fyRIvOGYBR9rx8KY01rI4R
	FVHuQGK+5bco7f4arcWhLhoIq+yQ==
X-Received: by 2002:a05:600c:3586:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490ec339ec0mr49511075e9.0.1781274533730;
        Fri, 12 Jun 2026 07:28:53 -0700 (PDT)
Received: from builder ([2001:9e8:f11c:fd16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c0d360sm175410705e9.0.2026.06.12.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:28:53 -0700 (PDT)
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
Subject: [PATCH net-next v10 2/2] net: sfp: extend SMBus support
Date: Fri, 12 Jun 2026 14:28:40 +0000
Message-ID: <20260612142840.462664-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260612142840.462664-1-jelonek.jonas@gmail.com>
References: <20260612142840.462664-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298697-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:jelonek.jonas@gmail.com,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57CC167A304

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
index 3c232991faa1..b9046b833fc4 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include <linux/workqueue.h>
 
 #include "sfp.h"
@@ -759,50 +760,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
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
@@ -818,10 +879,29 @@ static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
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


