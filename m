Return-Path: <netdev+bounces-292099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEsXEJKDFmpMnAcAu9opvQ
	(envelope-from <netdev+bounces-292099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:39:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191E5DF848
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 862FD30095F8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC8305681;
	Wed, 27 May 2026 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2VJFuwu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31630F7FA
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860357; cv=none; b=s6y0ouCr0PGpeCYU9MTJ9E0gtP0ajguCRr5aSPYE3QfSTqpWw1tcFlhlhK689eTtPYU3/+GlchNEYAXF5aibIlYk4WTKfuZaSU/fxKGlhDXGutOIaHNJPlubCsmh6CuqqVsPMB/lQQAKV/Zxr58wRHGPHvIC4BMAUsQryMeEW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860357; c=relaxed/simple;
	bh=y3oSGRmbfAOBxPqPXDgnXVLkFVS7op/0FXe3VArCSJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb2dsCuoEoafcMMtpkHygP3kd2JTBJKygNl1/dbVAJ1xRGGqRMUVzceNwDbCnrh/cL9k7I4Vcfyw63RS9zuvmZRj+aJMgEA190nmPY1Jt5wFZFKt72Ff6q8jv1l362TNXLSUooKfL8BRoUiSvvYXIs+TaRqzzNxBtImTaZUM6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2VJFuwu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso97064275e9.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779860353; x=1780465153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3mRI8mly2NbR54vqkvITGVjBSIViH+A5ziT0lYtjbs8=;
        b=i2VJFuwu2IPm9FWO+YD56lYtJDcMkOUCu6IvHYFMRA0Iofwm7sUcC05rVd8JcJ/uDK
         R/yulY9jfepKL7N8SOTJ8BZYeqDAWGWSLq4UnBCUmi3+nh5/KawZ5XaPqklC3j4p1lBO
         sgdwnoONqevf800XXm8a6qU26i8Vm1/myKcgEWgiaUhdccI5zvm6zE9jaagSvtWpZ53p
         VblijiMGUnJjDAwRX+eorsAjFhG7kY2Z4MySOF5LcSNYr9xEjKe/2ajsJ+pHTJt5mMOX
         nArByNOfF0Iv67Kn8lzvLWNaoxgli9LbZGYk69++jRw1SSG74D5mDyVBQNZWKiPOo88j
         8pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779860353; x=1780465153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mRI8mly2NbR54vqkvITGVjBSIViH+A5ziT0lYtjbs8=;
        b=qnVj41p0sMg5DmnjFqLLOw2kls0vTPDG8nzPZ97oYEuoyMCy1yvuQ7E5M4J5urQ8lC
         gQCuiKdozWG1n4EfJfvBF9B8rlYcZ7afJcARXzCigAppNZ1AOT3nNcZbZ5aj5OYpGDuX
         dyMLdvPaASfkNES/JMP3ZVXkD0iuulJY5cY9ZtHY6eKtPmKW3im9hmx65bDna4uCbw2X
         wRvPlKxzhGhX7h9rzEaqR3QdERXw/tl+SGsNTFE8s4a3g98KWVzO1i6kocvsZw2hQ/PY
         EOBlynDT3bYpMNHrSokmHgS76c55db9lpR4t+/QfIm+LygLI9Acy7ml2aSbEsG3ltnP8
         k4Xw==
X-Gm-Message-State: AOJu0YzL57ww1YWy4Q1cln8YejeIqM+KmXuDhp6ukCotFNAfmrNOhz3x
	mcs6fvhER7Sq2ogbfRSmXS+iVeEQMlmHJ1QwQqZLOfO0kLQv9TrBSyqPUMftooHK
X-Gm-Gg: Acq92OGNtax73riritUbQwO2a5/712Fg0bDr0fudGKufz08iLsBEIyp7IbHsXO/q4cq
	xfOKFWCIydHzpHndmCA/U/ty4EMPLZ1ZkA4zzUKjUHDvO0gXvBADSiSk6kc1l8DDD634uVlDvwI
	FntOFttk1kFbCEbeTwBczs+yRSsUZb19qRx33e10ZjBg4TEwLsq9jjWHuaM8g3o4XOrSaMjPiR6
	T56Ra7DmqbtMXVqhGZT3u74qUXmUav6YMzAda3kVqle4I5ZdiJXooveAIxkY8DR/TMWoTnAYfdg
	RDYyBp8tnEJDSRSj36ButccTB6gPPnyhNUrzxS+qeq36lqcf3seku2Q27tLMoLBly7xHuGSaPjK
	DQF/dPTuZl4VfzOXcS/51onsO2IqMt/iv4AtbB/q/TJJg4qdaPKzio67vQ3844vdvUoGiKxBrpT
	yP5lLsVxQBFT0P0K1YKA7IlBN9QXQEJNd9kd2jUkH04C5+e2IJ/YLzwJWGNl4Ojjwul9Wh9zEgZ
	KclLHSFEwIAbmHZlJ+BeG+0/x+qnufUxpMoX4k=
X-Received: by 2002:a05:600c:37c8:b0:48f:e230:8cad with SMTP id 5b1f17b1804b1-49042ae0201mr391034895e9.33.1779860353006;
        Tue, 26 May 2026 22:39:13 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490838b2b9fsm6502285e9.0.2026.05.26.22.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:39:12 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jan@3e8.eu,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net-next v8] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Wed, 27 May 2026 07:39:09 +0200
Message-ID: <20260527053909.2118-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[bootlin.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org,3e8.eu];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292099-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: 5191E5DF848
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
unlock password, issue a CMD_READ and poll for CMD_DONE up to 200 ms
(10 x 20 ms, matching the existing rollball poll tolerance).  A genuine
RollBall bridge asserts CMD_DONE within that window; modules without a
bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
mdio_i2c_alloc() propagates -ENODEV to the caller to signal that no
bridge is present and PHY probing should be skipped.
sfp_sm_add_mdio_bus() catches -ENODEV and transitions
sfp->mdio_protocol to MDIO_I2C_NONE so the rest of the state machine
skips PHY probing for this module.

Any I2C-level error (NACK, timeout) during the probe is also treated as
-ENODEV: if the module does not respond at I2C address 0x51 at all,
there is certainly no RollBall bridge there, and SFP initialization
should not abort.

The probe writes are safe with respect to SFP EEPROM integrity: only
modules explicitly listed in the quirk table enter this path, and the
RollBall password unlock write to 0x51 was already issued by
i2c_mii_init_rollball() before the probe for all such modules.  Any
module without a device at 0x51 NACKs the transfer and is treated as
-ENODEV.

Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
the probe path; genuine RollBall modules continue to work as before.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Changes since v7 (feedback from Jakub Kicinski):
  - Rebased on current net-next; no functional changes

Changes since v6 (feedback from Maxime Chevallier):
  - Remove redundant if (ret) checks after i2c_transfer_rollball() calls;
    the function never returns a positive value (always 0 or negative),
    so these branches were dead code

Changes since v5 (Sashiko AI review):
  - Treat I2C NACK/errors in i2c_mii_init_rollball() as -ENODEV so
    modules without a 0x51 EEPROM do not abort SFP initialization
  - Replace fixed 70 ms wait with 10 x 20 ms poll (total 200 ms),
    matching the existing i2c_rollball_mii_poll() tolerance and
    preventing false -ENODEV on slow RollBall bridges

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
---
 drivers/net/mdio/mdio-i2c.c | 59 ++++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.c       | 14 +++++++--
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index ed20352a5..b88f63234 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -419,6 +419,50 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
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
+	int i;
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
+	if (ret < 0)
+		return -ENODEV;
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
+	for (i = 0; i < 10; i++) {
+		msleep(20);
+		ret = i2c_transfer_rollball(i2c, msgs, ARRAY_SIZE(msgs));
+		if (ret < 0)
+			return -ENODEV;
+		if (result == ROLLBALL_CMD_DONE)
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
 	struct i2c_msg msg;
@@ -438,11 +482,11 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 
 	ret = i2c_transfer(i2c, &msg, 1);
 	if (ret < 0)
-		return ret;
-	else if (ret != 1)
+		return -ENODEV;
+	if (ret != 1)
 		return -EIO;
-	else
-		return 0;
+
+	return i2c_mii_probe_rollball(i2c);
 }
 
 static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
@@ -487,9 +531,10 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
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
 			mdiobus_free(mii);
 			return ERR_PTR(ret);
 		}
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bd970f753..7b2c20d78 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -579,6 +579,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
@@ -2022,10 +2023,17 @@ static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
 
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
+		sfp->mdio_protocol = MDIO_I2C_NONE;
+		return 0;
+	}
+	return ret;
 }
 
 /* Probe a SFP for a PHY device if the module supports copper - the PHY
-- 
2.51.0


