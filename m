Return-Path: <netdev+bounces-289521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ko7GuyNDGo3jAUAu9opvQ
	(envelope-from <netdev+bounces-289521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F345822EE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1250D304CF65
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AEE409639;
	Tue, 19 May 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4EzgdZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9105407CEB
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207614; cv=none; b=abVeyyA6BHRBk366Ye8vYLC9GVqwki6UgTZlh6XfNBeoJjJ1oxcSwAPgsAktvQ+lGwAqLvK+ho97tovYhR5+Xqc1VAlrQ1efA1RjnR+SrCCWKhUnprzHbomU8L3x3rYYXE1EH9CpNvLkyHaDSAuJWIc0hQuj/k19+mGIfPsvvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207614; c=relaxed/simple;
	bh=Uvv9ss39hupZA+UisExEcDNAhmVUE2p0CtOyrFKYY84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOgBjceujs2wJf8HPVa+o4/SaM0EFC/CiUUinxY+49B4RZbGhYEHK7rZhgVPLaJdw05jWnC5QjjCQBzaT0urNrNpk/MErChpIcVu10UMpnUVJDqOYCbgoqlw92yXSymiZrL5r6Se7qEPWwBtqqVn0J5Hc58lv31UVobKhp8cWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4EzgdZg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-444826c16ffso3320626f8f.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207610; x=1779812410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQvNZYmK2UjJJYvWoxV0gic/h6MHvMaK/SgBK3dfmuM=;
        b=j4EzgdZgBk83GlViJQTEbA5eZfvDFzoAnAu65YAPtR3H0UpREdzAWhI6ESFn04PtRd
         uzZTM/71RGn5CPOV9DN2g0wMytXcOtnP6HvU/3FH8jjvJ3LMvdwn5L+JXCf+nMKc/16K
         Qm60dp8dnRIvrFLCMsZiXLdkLe1eV3lE0KhMQhv2zw0ETgXmYtmHhcbXt+4KJ/w0lknU
         ezNTD6zc/rqxxr4SlAE/VqKL3ciWFin0xgVKY0qWG8hh9XaHPhVy3+5GL5DKGM6lgtan
         ttJvcqZnJ4WpnA8bdevL1AGqGHr6Zirpp4IxS08ZPSK4wpHeot04Kta7woIaZRrU2mNn
         0NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207610; x=1779812410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQvNZYmK2UjJJYvWoxV0gic/h6MHvMaK/SgBK3dfmuM=;
        b=TqOuqHkHIo1liIkkXNe5pEg/Dp55uKEzcHv2NAvFWBzvg/Lnbtq1P19lxBLnSmKf/2
         cOnmldmH5UaT98dEVZsqEjQ7cqAPPY64cTRnatwxLjlMVOpq4SfA8jwuwuPSkNKBWiHY
         9fuHi10d8FiUdkJ0t1fJbl7FI0shRGPpt/PXFjh7AqaUdOAb6AYs/7bum62MpgLxKwYi
         Wisdjug+oqbjt/n1ZtaRM4fYN7ID4y3QftcEvCs6fDaq8v+zSuKGrLRjHGZS0VhBgXyE
         nDrPi6kypGUBMX2xg59d4X6/1DS3u7sJE8ggGIQZ7nCRGYYoiweF4F0Bd9fpx4iOeRDl
         aNOQ==
X-Gm-Message-State: AOJu0YzJKDc+zvUX3wabCUVojISHo9KYrf324pET1x4bw26M6/nTHeJf
	qGhVk0ieidQ5RySm7he3JHllQv+TAaITohMmTJAI6VgITshpJSFCn2ZT9i4COd0+
X-Gm-Gg: Acq92OGO5UfEUD/umqgrPiXL0r5jzhkDT9DyueP2Y+4Eyao9HS++rDX+cduyEoKxF3I
	oreY2oZjWdRabFumN5vBe7n0qMkt/+nX785Wcao675R+zaYpDeOhgbpeJqN6fQcqNl6ZovQgPcH
	B1GycC4ZcmpuwnVnKmCA7qDXj4ZZrSGl8amuVmCPDxxTLuBA+vajqfmJhdFDg6TaWtMMHXYdLF3
	iG8YkYfSXrpV1ie28MBo53d+Dvxn6m7X+J9+q0n8DjfRfJj5TK0YwTYw2vdXtMgoVFgdqBYB2cV
	mWe5j2aVeDwenXA94U+w+Cnqd82+8BjosHlyzbgOJA323YUARAX4rAh5wLdbxh8sDQzibQTuK/A
	BYopEn6LI0slEPEDMf/WB1XrJunM57Sz5IfwXDHQxGRgVRejDXS0Xv/UdbXs63SPE5R9dkdxxEK
	7Luzsjii+WMhFiHB7Fog3SNDjKBbYfcxx1/0df7hvbp2lYKKw+kfljlML67ca1BwixdQ==
X-Received: by 2002:a05:6000:290d:b0:441:1fa5:457e with SMTP id ffacd0b85a97d-45e5c36bb9cmr33208204f8f.13.1779207610076;
        Tue, 19 May 2026 09:20:10 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm44435407f8f.20.2026.05.19.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:20:09 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	andrew@lunn.ch,
	linux-phy@lists.infradead.org,
	kuba@kernel.org
Subject: [PATCH net-next v5] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Tue, 19 May 2026 18:20:07 +0200
Message-ID: <20260519162007.13635-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-289521-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 25F345822EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
vendor/part-number combination.  This works for modules that genuinely
implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
that share the same EEPROM strings without having such a bridge.

The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
00:00:00, making OUI-based differentiation impossible.  With
MDIO_I2C_ROLLBALL forced, the module silently ACKs the unlock password
write, the MDIO bus is created, but no PHY responds; the SFP state
machine cycles through the RollBall PHY-probe retry window before
reporting no PHY.

Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
RollBall protocol constants are already defined.  After sending the
unlock password, issue a CMD_READ and wait ~70 ms for CMD_DONE.  A
genuine RollBall bridge asserts CMD_DONE within that window; modules
without a bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
mdio_i2c_alloc() propagates -ENODEV to the caller to signal that no
bridge is present and PHY probing should be skipped.
sfp_sm_add_mdio_bus() catches -ENODEV and transitions
sfp->mdio_protocol to MDIO_I2C_NONE so the rest of the state machine
skips PHY probing for this module.

Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
the probe path; genuine RollBall modules continue to work as before.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Changes since v4 (feedback from Maxime Chevallier):
  - Fix commit message: replace "stalls" with accurate description of
    the RollBall PHY-probe retry window
  - Fix variable declaration order in i2c_mii_probe_rollball() to
    follow reverse-xmas tree (descending line length)
  - Remove spurious alignment space on "SFP-10G-T" quirk entry
  - Document that -ENODEV from mdio_i2c_alloc() means no bridge present,
    PHY probing should be skipped

Changes since v3 (feedback from Jakub Kicinski):
  - Drop spurious Tested-by: tag -- author and tester are the same person
  - Use PATCH net-next subject prefix
  - Move -ENODEV handling from sfp_i2c_mdiobus_create() into
    sfp_sm_add_mdio_bus() so bus-creation code does not mutate
    sfp->mdio_protocol; the state machine is the correct place for
    protocol-state transitions
  - Split combined variable declaration for clarity

Changes since v2:
  - Compile-tested and hardware-tested on BPI-R4 (MT7988A, 6.12.87)
  - RTL8261BE (OEM/SFP-10G-T-I): probes MDIO_I2C_NONE, link Up 10Gbps
  - Genuine RollBall (OEM/SFP-10G-T): bridge detected, link Up 10Gbps

 drivers/net/mdio/mdio-i2c.c | 60 +++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.c       | 16 ++++++++--
 2 files changed, 65 insertions(+), 11 deletions(-)

--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -419,6 +419,46 @@
 	return 0;
 }

+static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+{
+	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
+	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
+	u8 cmd_addr   = ROLLBALL_CMD_ADDR;
+	struct i2c_msg msgs[2];
+	u8 result;
+	int ret;
+
+	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[0].flags = 0;
+	msgs[0].len   = sizeof(data_buf);
+	msgs[0].buf   = data_buf;
+	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[1].flags = 0;
+	msgs[1].len   = sizeof(cmd_buf);
+	msgs[1].buf   = cmd_buf;
+
+	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
+	if (ret)
+		return ret;
+
+	msleep(70);
+
+	msgs[0].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[0].flags = 0;
+	msgs[0].len   = 1;
+	msgs[0].buf   = &cmd_addr;
+	msgs[1].addr  = ROLLBALL_PHY_I2C_ADDR;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len   = 1;
+	msgs[1].buf   = &result;
+
+	ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
+	if (ret)
+		return ret;
+
+	/* -ENODEV: CMD_DONE not asserted — no RollBall bridge present */
+	return result == ROLLBALL_CMD_DONE ? 0 : -ENODEV;
+}
+
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
 	struct i2c_msg msg;
@@ -439,10 +479,10 @@
 	ret = i2c_transfer(i2c, &msg, 1);
 	if (ret < 0)
 		return ret;
-	else if (ret != 1)
+	if (ret != 1)
 		return -EIO;
-	else
-		return 0;
+
+	return i2c_mii_probe_rollball(i2c);
 }

 static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
@@ -487,9 +527,13 @@
 	case MDIO_I2C_ROLLBALL:
 		ret = i2c_mii_init_rollball(i2c);
 		if (ret < 0) {
-			dev_err(parent,
-				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
-				ret);
+			if (ret != -ENODEV)
+				dev_err(parent,
+					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
+					ret);
+			/* -ENODEV propagates to caller: no bridge present,
+			 * PHY probing should be skipped for this module. */
 			mdiobus_free(mii);
 			return ERR_PTR(ret);
 		}
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -579,7 +579,8 @@
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),

-	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
+	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
@@ -2022,10 +2023,18 @@

 static int sfp_sm_add_mdio_bus(struct sfp *sfp)
 {
-	if (sfp->mdio_protocol != MDIO_I2C_NONE)
-		return sfp_i2c_mdiobus_create(sfp);
+	int ret;

-	return 0;
+	if (sfp->mdio_protocol == MDIO_I2C_NONE)
+		return 0;
+
+	ret = sfp_i2c_mdiobus_create(sfp);
+	if (ret == -ENODEV) {
+		/* Probe confirmed no bridge present; skip PHY discovery. */
+		sfp->mdio_protocol = MDIO_I2C_NONE;
+		return 0;
+	}
+	return ret;
 }

 /* Probe a SFP for a PHY device if the module supports copper - the PHY
--
2.51.0

