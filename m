Return-Path: <netdev+bounces-295382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4J6tOGXBIWpaNAEAu9opvQ
	(envelope-from <netdev+bounces-295382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 441866428C5
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:18:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PZ4WuWpw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295382-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295382-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6126302DFBD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2FE3BC68E;
	Thu,  4 Jun 2026 18:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E13C060E
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:12:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596733; cv=none; b=tSwYhv6aGn968eN3tsCW5FKpzCJvsyXxRs5N/6yQ7BSTO39W+mx6GEAUoQ+2x+ilMWGNZ1dE6ZRg+kOTp4dkeqxRlpGvND7iJ6BPVDKlL79VVW05RBs0K79M95wz0FKMncWaW4AWD+00rE54PtLzy94xCNyDoGBHRxJdrWY3QpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596733; c=relaxed/simple;
	bh=N1D5ItiD4ohqTNcYJwbRlDdv4O8t+O3dJ2OVB84yHyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqFaD0PLCBix5qPwLgIpNq/3he9MPiZqUP+FPt1U8ysSHf1IQFdZ1ocWFyjOToCELT4x0QAVU4g/0IlwMmVj+a3nD7gqOT8UzIV3pGui+huWN28St/2m1Pl+SODiwUy1mCg3lXN2hhQDVz9OWgKbuJ7GpbdyjZG5jZKgdkcpot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ4WuWpw; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef372c58aso637736f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596730; x=1781201530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBV5F5ZFXu3LplEpSL9jXQmyH1fcjls/VQKnmrV9OCk=;
        b=PZ4WuWpwxLP3K5VoSZS44JtZc9g+i5+cL9kOoiWuDORAZTfKKhUkty5gwT8CqBQGAb
         4iqq5pKknPw35if5iJEufsU2VP3ITbKI4jo+fN6pTeFfkEOpLMkvEWfO5lFBCC4RjHEo
         dRnfod3QWX7M32KO7hVlz0EXWRZZPxeYUyovscn/M8RMqiWZWXjOLR8lhunCedCIm9aF
         y3/rWJaNaEFYFH6I2UJOhohqJuVqcr76p8zI2OEb8B7sk1G30Dzc1ltBySMx98xJSyVO
         vONr4t3TZkhnxpBRdewnJvODDlen1n+Ef7xv990Brg4+mt8neWLHDzaa9bRDPnS9huI2
         jlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596730; x=1781201530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBV5F5ZFXu3LplEpSL9jXQmyH1fcjls/VQKnmrV9OCk=;
        b=EGj1NmwZ6tHVDU0iUSMyBVJpnpG778peqETxMdk6bpYGI2BYIU/xqEhQKBZ7Xl1oQN
         E3fbzBhXqqBeSbYDkNZdUuyWgzdwlCYt4KQd2k6jgex7yovgmM3D3qVLKfvQaAFEMKIw
         GlkNQ3f/OGV06D8MT/1wW3/5/YE4PVCrtdfEa5ljNiPrXmKrPPJyS/I9d14zzT33lho4
         +P6NRVgv6igXJhIA7GnBZdn3rzhKDwSKwY8WCOCf/SFELJSB8/9UjOSyxdBPiJ+gE4DT
         k8Gf9eD5bKP4hXBcbi36a/JBgU4dnEC6VSDzoUjCDh0GSbhpzHGn8X8G9fucEzuKFfQG
         vYtg==
X-Gm-Message-State: AOJu0YwUfz+5uJUJHXvINcTo0Qt/OsmYW12m+Iou+ktLu2QAubU0UIk1
	hVBTWYZ/CIN8xsd1WGvjp7lH/qbqkyum1ap5gpBUiWqoMw3e/PBZ9Jpq3vC2L0bh
X-Gm-Gg: Acq92OGxX1Bsz0z0MZbKC0OMo04VMfe62cxvAepwpsUTt9ghWFtcUcwSPgfpWMjWA6L
	VVlkmihFUHdMceU+OYwUk886A+S+/T2Kz1TLMKOPLS2nEbMeJMGhkvdo29dGrwmeKj/57LXLTCo
	dIE56vxCzH9i8WaeCx8VhpwZEHnjCOSsVOFY25NRgxXO/OcORCHSEmgNOWDAAYa/9hMg87gATBY
	CeS1MBvK4EbH41o7ljKBdpYVguW3BtQ6AIWP8ikqyM1A/bSZmOrp6+5xGuTM0WIGenbq/jVyz4J
	iHdVcch5Tw+itGkhBgp3VJhjc4KxSLKhPg89B0vPFMgHxOoH9u5UTUCo36syf5NiG7cDM5tskqH
	jItWl6athGjLU3JeHGfZD4hI+ZtBpW1USp72ZgY97R7gx4CeAgvoW+ENgR7VO+nbns8Y17dK7A1
	HPd93gCL03mIAB7dj2vULoUxNMOUnWJh6Myosg1sA59AjIZzWtcMLzmYo1x0OJsroFYBWX9g/qg
	zrqotiWLBjL0xKpmmzoMv5+a1++
X-Received: by 2002:a05:600c:8b38:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-490b5e51b8amr147464915e9.20.1780596729771;
        Thu, 04 Jun 2026 11:12:09 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c159f51asm4304115e9.1.2026.06.04.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:12:09 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net-next] net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
Date: Thu,  4 Jun 2026 20:12:06 +0200
Message-ID: <20260604181207.17468-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295382-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-phy@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org,bootlin.com,mork.no,wp.pl];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,wp.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 441866428C5

commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
bridge in mdio-i2c") introduced a regression: for SFP modules inserted
before system boot, the RollBall I2C-to-MDIO bridge is not yet ready to
respond to CMD_READ/CMD_DONE cycles when sfp_sm_add_mdio_bus() runs.
The 200 ms probe times out, i2c_mii_probe_rollball() returns -ENODEV,
and sfp_sm_add_mdio_bus() sets mdio_protocol = MDIO_I2C_NONE.  By the
time sfp_sm_probe_for_phy() runs (up to ~17 s later on affected
hardware), the bridge is fully initialized — but PHY probing is skipped
because the protocol has already been changed to NONE.

Move the probe from i2c_mii_init_rollball() — called at bus-creation
time — to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP
state machine's module initialization delays.  Export the probe function
as mdio_i2c_probe_rollball() so sfp.c can call it.

For RTL8261BE-based modules: the probe correctly returns -ENODEV at PHY
discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
and set MDIO_I2C_NONE — eliminating the 5+ minute PHY probe retry loop.

For genuine RollBall modules inserted before boot (e.g. FLYPRO
SFP-10GT-CS-30M with Aquantia AQR113C): the probe now runs after
initialization is complete and correctly returns 0 — PHY detection
proceeds normally.

Reported-by: Aleksander Bajkowski <olek2@wp.pl>
Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 drivers/net/mdio/mdio-i2c.c   | 18 ++++--------------
 drivers/net/phy/sfp.c         | 18 ++++++++++++------
 include/linux/mdio/mdio-i2c.h |  1 +
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -352,7 +352,7 @@
 	return 0;
 }

-static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+int mdio_i2c_probe_rollball(struct i2c_adapter *i2c)
 {
 	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
 	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
@@ -397,9 +397,11 @@

 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(mdio_i2c_probe_rollball);

 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
+	/* Send the RollBall unlock password; bridge presence is verified
+	 * later, in sfp_sm_probe_for_phy(), after module initialization. */
 	struct i2c_msg msg;
 	u8 pw[5];
 	int ret;
@@ -419,7 +421,7 @@
 	if (ret != 1)
 		return -EIO;

-	return i2c_mii_probe_rollball(i2c);
+	return 0;
 }

 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
@@ -444,12 +446,8 @@
 	case MDIO_I2C_ROLLBALL:
 		ret = i2c_mii_init_rollball(i2c);
 		if (ret < 0) {
-			if (ret != -ENODEV)
-				dev_err(parent,
-					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
-					ret);
-			/* -ENODEV propagates to caller: no bridge present,
-			 * PHY probing should be skipped for this module. */
+			dev_err(parent,
+				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
+				ret);
 			mdiobus_free(mii);
 			return ERR_PTR(ret);
 		}
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2028,17 +2028,8 @@ static int sfp_sm_add_mdio_bus(struct sfp *sfp)
 	dev_info(sfp->dev, "probing phy device through the [%s] protocol\n",
 		 mdio_i2c_proto_type(sfp->mdio_protocol));

-	int ret;
-
 	if (sfp->mdio_protocol == MDIO_I2C_NONE)
 		return 0;

-	ret = sfp_i2c_mdiobus_create(sfp);
-	if (ret == -ENODEV) {
-		/* Probe confirmed no bridge present; skip PHY discovery. */
-		sfp->mdio_protocol = MDIO_I2C_NONE;
-		return 0;
-	}
-	return ret;
+	return sfp_i2c_mdiobus_create(sfp);
 }

 /* Probe a SFP for a PHY device if the module supports copper - the PHY
@@ -2058,8 +2049,23 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)

 	case MDIO_I2C_ROLLBALL:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
+		/* Probe here, after module initialization delays, so that
+		 * genuine RollBall bridges have had time to start up.
+		 * Modules without a bridge (e.g. RTL8261BE) return -ENODEV. */
+		err = mdio_i2c_probe_rollball(sfp->i2c);
+		if (err == -ENODEV) {
+			sfp_i2c_mdiobus_destroy(sfp);
+			sfp->mdio_protocol = MDIO_I2C_NONE;
+			break;
+		}
+		if (!err)
+			err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
 		break;
 	}
diff --git a/include/linux/mdio/mdio-i2c.h b/include/linux/mdio/mdio-i2c.h
--- a/include/linux/mdio/mdio-i2c.h
+++ b/include/linux/mdio/mdio-i2c.h
@@ -33,5 +33,6 @@

 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 			       enum mdio_i2c_proto protocol);
+int mdio_i2c_probe_rollball(struct i2c_adapter *i2c);

 #endif
--
2.51.0

