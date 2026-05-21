Return-Path: <netdev+bounces-290226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK7lFel0Dmpa+wUAu9opvQ
	(envelope-from <netdev+bounces-290226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:58:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B459E3BE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F92C302E7AF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D5377034;
	Thu, 21 May 2026 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxhsNqWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB5368D46
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332283; cv=none; b=qZ9M2wHQQcZUiF6I44QjO9RAIHBj+A5ZG3KN33Wf3JDD4ns2NEw6xzgzpLP8guBxd/d4TpG6jqu8GONO8p8zexi4EeUDsHFGzhSe7mqRvCSK0a5HcOHV1rYWRwkJgxy/HuqIeGNyd/xWMUGYtGf4oDr4/YpEbeI5yzaM4zWHyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332283; c=relaxed/simple;
	bh=ohfN6xnsyyhwKmHo97zfhgAs3Ize1J6t/BwHoxDoQ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTnGHccmI8GXyJMJ03kYz9JSxMIjq6zRDtuZxXQOIM75agz2YZ/eSnrxWyQzDYphAEW8o8biUqVqg6qima1VGqdFABPK2r7Im9aRvT3nKfAt41Saw11NoXMbj4cJjQhj2USGTgSbtIZ2cv6VnGqbk1oi8uqpOv6ISzTrhMVbH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxhsNqWl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d734223e4so3678648f8f.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779332281; x=1779937081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6wzXBilwDaEqTrdj11rHbLJY7P7PclyJf2gWIGAYeg=;
        b=RxhsNqWlZBsF7HSKv8fH4r8ATYV22uI6hHJ4l0MS7Vs3K3oRtE1dMt698FemiA0UDg
         A4c59agXp4QiLj3+ckBdSFCegUU39ire4jz4YS75g1PsXLKUk5p3D9szlTAKuxAr9YmY
         wDXJ6iL/Hb6Rv17HdSpOotVstb33Fx2saOK1C3YZtEW+3nABRhebUd8CSdt/nL8qzq+f
         YDQ1jbV7Cua3ov0CLlxIzImjRVGlLBekTss4y/2cnrrXzBA4DOSlfjikt4WBoYLNS4YU
         iw5X3dd+NmsNpiSpdej4VnGvK0F3YpQhhL2wlesM07qIewXz18z0tl/f2IA41Bv7xoqj
         ihTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779332281; x=1779937081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6wzXBilwDaEqTrdj11rHbLJY7P7PclyJf2gWIGAYeg=;
        b=jSXVOBWy+ZNAZSEsDdm2FYVDc59kgmq8OBRJEbt0dPIN5BRJGLKHlxO8wZzKv4U9Dk
         ZLzXuH4lvYyirhQmMsik7WUnnevtVawPOhwIGZ+aoYwc0GFQ1pr+Yk6EHrYuzAsy4Kxr
         JFXcV4m/3sa93VAN2Gmvdxepv2edsLIGMkwZ0UEwtVZfiDDk5uHAVXElE6MaNU6xiQc1
         TShldkGkeMhQi5549gNnpc3P8KKS/vuoCw6Ned2lPM5BvRJgX47aBghoAipW+kC2e1sd
         n4Z7CkXCyV0FWIp4k5M0n/avpR1b5UZxndNTSCgDEwm42eHnSOHuLD+oJu4g33cZnJBB
         3PYw==
X-Gm-Message-State: AOJu0YxWwjRBk1KzHM6fe7ZQCs/8E1Qs5clHvs1J3af5zJLGmsDE87Ep
	LQYOMJuAZhE/r5dGvpSBBSYLDUK8wsqKrzaaoJ4Z+qElDeb/SRhfu4sRacZR0Wkd
X-Gm-Gg: Acq92OFx3k4/wAwN42c0UV8SjjnpcbYfTNr0r3mW/Udih0V//6mgd8Ksr+X4D1y0yHv
	GelYyVMDWf1fJqv0YmklR5kYLmKClBzX1o/LX1DSXx7quewVc527WzREaQFlJjXxpqUboMpmh+7
	k+ZIybgKNIed4l2UTkE07909w1fHB4zggeZ94IlDn5AdKLhdoYdJWmxh1cXQDTjkG8dqJiBBCXM
	3K8AB1jD9cbDsJduRgFCLzzeUetzZP7p9aEEOuPg56p+tGg8mJwwHi9ElZ18JQ/HnzcIBawMwNN
	y/7q0OSbg0zJVjU/YWcQ1gtmTVlnV8Yf2HEfo5JRn/WGVOXmKJDrjovRqXP2tj6JUemuL2OzfQ4
	TMmaKmqE7M1jtpTdjKm4uxZHysWS0o//47AXltqF/KQManVvoy6blMFvEl5ACPu3m8CxirlAGFd
	nos//qUDRZl2FyPnBusOQfeq1NapEi2IuB7597Rvf7z5vmO1OiACYm8QWhYus5ZBKw+uheXVrT1
	znmS6I9VBIjtlyejw==
X-Received: by 2002:a5d:6f10:0:b0:449:cd74:7432 with SMTP id ffacd0b85a97d-45ea34ab49bmr878157f8f.15.1779332280425;
        Wed, 20 May 2026 19:58:00 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1a22csm58114198f8f.19.2026.05.20.19.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:57:58 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	linux-phy@lists.infradead.org,
	jan@3e8.eu
Subject: [PATCH net-next v6] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Thu, 21 May 2026 04:57:55 +0200
Message-ID: <20260521025755.24649-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290226-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,mork.no,lists.infradead.org,3e8.eu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: B85B459E3BE
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

 drivers/net/mdio/mdio-i2c.c | 65 ++++++++++++++++++++++++++++++------
 drivers/net/phy/sfp.c       | 16 ++++++++--
 2 files changed, 68 insertions(+), 13 deletions(-)
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -352,6 +352,54 @@
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
+	if (ret)
+		return ret;
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
+		if (ret)
+			return ret;
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
@@ -371,11 +419,11 @@
 
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
 
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
@@ -399,9 +447,12 @@
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
@@ -607,6 +607,7 @@
 	SFP_QUIRK_S("TP-LINK", "TL-SM410U", sfp_quirk_oem_2_5g),
 
 	SFP_QUIRK_F("ETU", "ESP-T5-R", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
@@ -2029,10 +2030,18 @@
 	dev_info(sfp->dev, "probing phy device through the [%s] protocol\n",
 		 mdio_i2c_proto_type(sfp->mdio_protocol));
 
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

