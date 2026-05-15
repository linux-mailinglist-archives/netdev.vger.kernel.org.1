Return-Path: <netdev+bounces-288405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEraL7djB2q90wIAu9opvQ
	(envelope-from <netdev+bounces-288405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB65560EE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273E031C1CE7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E333F39F3;
	Fri, 15 May 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIe3aPCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE73F39F5
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866850; cv=none; b=qokzfUomWF1ZQgHmPwJeUHEoUIA2RZKeQBvgSBEieGDdaoQ4rXshfN1V0CZmQ92vE3vuspIgksq03UmGsH/+oOj0gs7dsk0I3xWMcanXe5ylLg6hhGQR6fXCFg1gtSvlTwP00TP3TIbgxUOwdOydOWiDF8lfoh362Qd5ve6o5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866850; c=relaxed/simple;
	bh=sRDA+CjgrGJ0MlgHuTRNrkyxOYcG8ReDzd+EHyI7WCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9RV1upzISeO7ehKOGBHeuUf3Zarv9oj/AbbNi8W+O5fJ1KaYVRuX+1O+TJxqfxyd8Xbl1JP8Vs8FdZORBW4J+XY7Zj+BN03wHE4iPS3dJMzQQ07RA/J5Yjr/OMd3S6px2GgHEKpsUQblzi8GoLTdARoFZcFkJClXWrXibFL8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIe3aPCn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so533845e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866847; x=1779471647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAVHRa/Uf1SiF1TksKJAl/zTvj0QOoaVUWhWO9iNGk4=;
        b=VIe3aPCn+MHWEVLGVmbIw1zWk5Lg9YuRHYygw9+fGHa/2IzchXVPd+HifHa/0bcdn2
         1+MsD8z7VHg3EdbCI0eNmtiyfnTqfpGOTvbBT5NPB1miJI99rEjqp9R3VY2Z24QdDexW
         DUairz3oE5IH4q0sJhZhmsL/55lj0cCRHVr7UAcXs1Pe0BTwT7y8GrUCnyv56fGfde/4
         6d0p5qtl5qTm3WQhx20nZtNCLP/kRApysaLq6BqJsgWdj6K6nFZF/tmUoXKvJmZxc/C6
         4f9wVwISA3eZqJ2WX+6zNqpBmBsQrTIfI4C+FRdeDSw9vm+R4mVnAONMn9ShDoGWX71Q
         oAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866847; x=1779471647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAVHRa/Uf1SiF1TksKJAl/zTvj0QOoaVUWhWO9iNGk4=;
        b=kltQTMt0lPhoBTuevmqPR9+HWDg5Pu0DjyVfhX0Pvn5Q2Yr5p+VB0B55rYEdt66rfD
         Rnflk66xScU0nDE9SeyQpkR6uVuy+8iFAOIdUrsK3+arIaCGpSzaosWPI5fK+twSQzmX
         DQWGWJ7DfnBRazx4PUiz2rrja3YxJ+2dt4P/vKHpUg66rQiQUgWKUbbJXH3IYb+AYNQy
         A09QnoPnBDHruru8JFXWVFKjDvGAW70zad5DBV0SavglKgVtvV7HmAr8VJd7iXBoRiad
         jREt9rEBkvS6R7/uz5JcDWq57tuatnvU6/Bt/7v4H3sYDkSFz2cQ9p1lCkiR5rDNaRVg
         ze/A==
X-Gm-Message-State: AOJu0YxQQjabcbcn15pR/yGcdCmaz0Sv5PN4M+xda3WS7FoH2u1tnWO2
	FD/r6sQ49jKljspQIme6PHlIn4yp1xl4vA2f2BsPozfCANY0R7cqBBsHAdrr4pcm
X-Gm-Gg: Acq92OG0x4Pajpc4qOI83IHTluSntWPO37/Glk3VEofdCC5cS0u7g30NfEDHqCRmbBB
	MbpYIhmBFVG0SR/5AM689eer3uvyUyDcabIj5czR+6IGWCC+0LpjfB36C8r7037iJXrgMZnBXou
	IDTvZaA7T0WHHR015KL5pBjXTSxQj/bCuxd8uxNrUmX1bLWzKqaBzmqUrkPdMRMVZWDUtRRs8bZ
	m+JN8wXfpI/MV7OiltWW0V0rlxY/rKBIAG56KZ0ING10n21AbhIsdHtDT2ekb9FWL9UmkH4wr3S
	4Gw0rNITMNc6g8KGtcZR/MMEYnNJm8HX2/pi9+C1fc0dxf8ULN1ojoCZIyLQTSQSmAsdkF4F8gU
	b7A2wkXlBz1nNzWo2DNDr9Zj/wKu50R2pSBFsSAtTiIKgWcmX7UEBXxcZqaANmuB7mR/f+X+5Xo
	NfWVKt3vn3RKN2YRJJgNg+ThzVAFSZvQflNjJhwFQMDXVy19gJ6LIyHkM=
X-Received: by 2002:a05:600c:8b56:b0:48e:7f1c:8776 with SMTP id 5b1f17b1804b1-48fe6514c83mr77911265e9.25.1778866846764;
        Fri, 15 May 2026 10:40:46 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm16094402f8f.23.2026.05.15.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:46 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: bjorn@mork.no,
	andrew@lunn.ch,
	linux-phy@lists.infradead.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH v3] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Fri, 15 May 2026 19:40:44 +0200
Message-ID: <20260515174044.26036-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28FB65560EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mork.no,lunn.ch,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288405-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
vendor/part-number combination.  This works for modules that genuinely
implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
that share the same EEPROM strings without having such a bridge.

The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
00:00:00, making OUI-based differentiation impossible.  With
MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
appears:

  sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol

Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
RollBall protocol constants are already defined.  After sending the
unlock password, issue a CMD_READ and wait ~70 ms for CMD_DONE.  A
genuine RollBall bridge asserts CMD_DONE within that window; modules
without a bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
sfp_i2c_mdiobus_create() treats -ENODEV as no PHY and falls back to
MDIO_I2C_NONE without creating an MDIO bus.

Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
the probe path; genuine RollBall modules continue to work as before.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
Tested-by: Petr Wozniak <petr.wozniak@gmail.com>
---

Targeting: net-next

Changes since v2:
  - Compile-tested and hardware-tested on BPI-R4 (MT7988A, 6.12.87)
  - RTL8261BE (OEM/SFP-10G-T-I): probes MDIO_I2C_NONE, link Up 10Gbps
  - Genuine RollBall (OEM/SFP-10G-T): bridge detected, link Up 10Gbps

 drivers/net/mdio/mdio-i2c.c | 59 +++++++++++++++++++++++++++++++++----
 drivers/net/phy/sfp.c       |  8 ++++-
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index da2001e..1973fda 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -352,6 +352,52 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
 	return 0;
 }
 
+/*
+ * Probe for a RollBall I2C-to-MDIO bridge by issuing CMD_READ and waiting
+ * ~70 ms for CMD_DONE.  Genuine RollBall bridges respond within that window.
+ * Modules that share the same EEPROM vendor/part strings but have no bridge
+ * (e.g. RTL8261BE pure copper media converter) never assert CMD_DONE, so
+ * -ENODEV is returned for them.
+ */
+static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+{
+	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
+	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
+	u8 cmd_addr   = ROLLBALL_CMD_ADDR, result;
+	struct i2c_msg msgs[2];
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
+	return result == ROLLBALL_CMD_DONE ? 0 : -ENODEV;
+}
+
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
 	struct i2c_msg msg;
@@ -372,10 +418,10 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
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
 
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
@@ -399,9 +445,10 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
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
index 218c775..ce745b6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -599,7 +599,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("TP-LINK", "TL-SM410U", sfp_quirk_oem_2_5g),
 
 	SFP_QUIRK_F("ETU", "ESP-T5-R", sfp_fixup_rollball_cc),
-	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
+	SFP_QUIRK_F("OEM", "SFP-10G-T",   sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
@@ -802,6 +803,11 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
 	int ret;
 
 	i2c_mii = mdio_i2c_alloc(sfp->dev, sfp->i2c, sfp->mdio_protocol);
+	if (PTR_ERR_OR_ZERO(i2c_mii) == -ENODEV) {
+		/* RollBall probe found no bridge: no PHY on this module */
+		sfp->mdio_protocol = MDIO_I2C_NONE;
+		return 0;
+	}
 	if (IS_ERR(i2c_mii))
 		return PTR_ERR(i2c_mii);
 
-- 
2.51.0


