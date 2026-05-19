Return-Path: <netdev+bounces-289269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCzgB/7nC2pXQgUAu9opvQ
	(envelope-from <netdev+bounces-289269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F25773E2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AD193006988
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA082D0614;
	Tue, 19 May 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUlQQuWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9C128395
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779165176; cv=none; b=juNyILvyvSjfzsrFc8Cnaq6GOiRscqtMEpHHLR3lOxT1fJTwqxuOrVOYVsSaXO0L0J0Vud+vbqnedKDD/MQVR5h1rmRG3EjHXmBAT9ZaRp8BC1rq5RqjaKK1qlBGchDen8w1EKu9JBSzO30Wa1OipLILc9jp1DV1OqsoNQzpQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779165176; c=relaxed/simple;
	bh=2/mvF74bsOBWsGqlNvNRzQU9LK4+PzmgJWuYuVFP0HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POzifrzukz0Erlwrd4knEiuVZ4vn8oMYNgvsy7GarM2dxVKG0F92hhXyK8w4tNTwALHbLRnvDJx3QrDCIePSIaLH76/Ar/gNsFrwrbnKumh4nyylw9z3QTN862VTwJzu59enUhpQqFHyXHYTVAfxguU+HuOqlmKOj+kUgfJAcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUlQQuWt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe62837baso1637271f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779165173; x=1779769973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqVrwZhTS4+jEVcoMiK7OH2y16LpRHVglx7FTCzRJ5Q=;
        b=ZUlQQuWtyr9TE/CtyJHiTU7FFXofXbGpQiru8PhLYncEvydMHnUE1Sl8qKO8GXxAZ+
         VsLh6Wg+20Y2iQxigspWJq+C4MW7HfgkB9Enmw8hJlh8++ZrM2bfUIq6yWtwCPODHG+g
         Bw7VsQYsPOY3qV17zCUvN3UhnzHQNE5077f8oUpRmtjaeBLw/HMG+tkouZATX8jBW0ld
         25SNVMYFK/g4oxjLT51PS9iBRE3SXvmbHBMD4VDmx6yIZr4ZvJKWhjSrNfP3rpsBgoOn
         MueWcLL7JLickXHYtRddZn6z35oEoyYDPtjvUIznRwthkn89F1x4ZVZgmCLGvkG0XYYG
         aNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779165173; x=1779769973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqVrwZhTS4+jEVcoMiK7OH2y16LpRHVglx7FTCzRJ5Q=;
        b=NZ7UjUUiwNv+cxrQyp2OcFD1QtkgPnRq+N1Xs27cjMb5Q/eDen5gvRC0TgnhrB6+dj
         gIFANZwTslS54iO1JxbEMfmj3YG1CDEaSD3t+IVLQXZT/gmyE6Nkyl5OKQ6LYuRmdCr9
         qVWAz9gY7o9LW6Rs6Wwbh3q6Gcc4maVgZBtgaXoOYrmB5l28JDkgMNVag/2972jr/B2k
         kUWKNkpbgam9w9qaeYG/DL1CQUlvaYqZ026FMMGk6OFEJPTt6J95SWJ3OVMPDMal960t
         c9Q91leSEBhW0qp0t+O72vR55EPKWh7KJGMm3zY1TkkE3IRUPLIjKkq+IZoQVBGPB1p1
         2gpg==
X-Gm-Message-State: AOJu0YyUTVg2pUKkMdW+NvErjFnO8suuo1pD6tPaAmMBTinBjx2fhMzC
	pdnjyhkeoXhXt0LhlePnRT1YVxXHzLTIQPYz0TFoC9EZ0fKFUsteoOt7P/0/jVOr
X-Gm-Gg: Acq92OGh8EBC0+G2UuboPM77li/C87jyYXJm7WdUr033HXrTOcVMxB56+AQJFhnhEWI
	mqkWdY2SxGuzTxiqwmmy1bv9Sldlt1h6ynyXTOauA4ixsSkH9GxE+4R96Jui3GAa9YJmy+KnVYw
	qUAKiNpAwIDcsWN1L6gkO4obf7fDFMoujvuAfuEPINp7e5GYM65uQ6zw5xXyZeA9FFAokrZRHA8
	OKBrBZIKl6gNgB71Uq9Y5W4lgsddsiJVRxnJHLPwCLsoALr+ODgGO8iAnGD8CIO/FgB4Q6iQhQV
	JoNsXcCqCG9JGWo5BfFSXV2watMX6JeWzrteo9W5Oeg1uuIokRylXS+aOifWGZislDDdxMvFszU
	xRNKsze9QwyYnXO/b5m5nkF/qjRqbd43z09iJzWU39JEizot7JfTwc/OayaCGFnnzZaqa6ate/v
	C+ddCpNicjD2Z6t5aRoX1SuEI/16MAXSFskSBLkgfYRLWFoG6bzWvfuqY=
X-Received: by 2002:a05:6000:4021:b0:45a:c97a:905e with SMTP id ffacd0b85a97d-45e5c35db40mr27602343f8f.1.1779165173174;
        Mon, 18 May 2026 21:32:53 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm23722540f8f.27.2026.05.18.21.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:32:51 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: bjorn@mork.no,
	andrew@lunn.ch,
	linux-phy@lists.infradead.org,
	kuba@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net-next v4] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
Date: Tue, 19 May 2026 06:32:49 +0200
Message-ID: <20260519043249.2868-1-petr.wozniak@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mork.no,lunn.ch,lists.infradead.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C7F25773E2
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
MDIO_I2C_ROLLBALL the kernel stalls waiting for a PHY that never
appears:

  sfp sfp2: probing phy device through the [MDIO_I2C_ROLLBALL] protocol

Move the probe into i2c_mii_init_rollball() in mdio-i2c.c, where the
RollBall protocol constants are already defined.  After sending the
unlock password, issue a CMD_READ and wait ~70 ms for CMD_DONE.  A
genuine RollBall bridge asserts CMD_DONE within that window; modules
without a bridge never do, so i2c_mii_init_rollball() returns -ENODEV.
mdio_i2c_alloc() propagates -ENODEV to the caller without logging an
error.  sfp_sm_add_mdio_bus() catches -ENODEV and transitions
sfp->mdio_protocol to MDIO_I2C_NONE so the rest of the state machine
skips PHY probing for this module.

Add "OEM"/"SFP-10G-T-I" to the quirk table so RTL8261BE modules enter
the probe path; genuine RollBall modules continue to work as before.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---

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

 drivers/net/mdio/mdio-i2c.c | 57 +++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.c       | 15 ++++++++--
 2 files changed, 62 insertions(+), 10 deletions(-)

--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -419,6 +419,46 @@
 	return 0;
 }
 
+static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+{
+	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
+	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
+	u8 cmd_addr = ROLLBALL_CMD_ADDR;
+	u8 result;
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
@@ -487,9 +527,10 @@
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
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -579,7 +579,8 @@
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
+	SFP_QUIRK_F("OEM", "SFP-10G-T-I", sfp_fixup_rollball),
+	SFP_QUIRK_F("OEM", "SFP-10G-T",   sfp_fixup_rollball_cc),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
@@ -2022,10 +2023,17 @@
 
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

