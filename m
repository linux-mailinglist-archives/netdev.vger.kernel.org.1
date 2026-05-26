Return-Path: <netdev+bounces-291946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOx7OkAWFmq7hQcAu9opvQ
	(envelope-from <netdev+bounces-291946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:53:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 920645DCEED
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADF66304670F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC723CB2FE;
	Tue, 26 May 2026 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCYDKd2G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC23C4565;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832340; cv=none; b=A4JAmutYUGHc/8qcEavP+gWoipfuu96tdHTtJ28Ercs1ph/Ndv3AhJudjMcxplySs8PVrQvN3G9HXWvbnvgBx+ffHVZNdQVrqMuBAlKYXZEqR44A5f1ERgcJNjsUUf5tEEfjJzKuoVJpLusprijHfsURGNIKt9k+2ORLkEMSTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832340; c=relaxed/simple;
	bh=A2Uj8QDZUKuoKmqg/79Vc/G1OinkPdUdxMsomCejTNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xa/P0WnuxCsfFW/0MfEQ4LjgxbsEuHIBM9+bRe53g0Yv5qhaLqd0WPc/f+lcx9k/qTcby84Qg0qfChx4WAnOK3HapJju2dtI7FA0QqlUqKExx9IFhAgMu4mvZVXfhNxfQR4/Gs+rpOrAL2K0Fa87u1vmYD5PYZf0j5uif2o/tfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCYDKd2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35597C2BCC4;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779832340;
	bh=A2Uj8QDZUKuoKmqg/79Vc/G1OinkPdUdxMsomCejTNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hCYDKd2GOuZHRA9yvZ4jszEYK95PJGGCUYOIM4CN0vQld5siyNPZPu3DE1mP9vNi1
	 LLW3q9crFYOpQVPLXpyW1WmnS6d/OP9OJkMmgf1igq6qpPuNdReQNLz3ntte54xUgc
	 qcVCdZV+OxSV5o7iAzlEGWxUaRVxx9CSvzE40P1NwE/U9AxXab5wCFuCKtRDbQq52h
	 g252LjH1sfFixJj76dwPF/k+UMNhTo2qxshCM+B/FL/Krz2BPeOB/FbU39BP/GIdXh
	 gL56hhChgbQAijack9qVhOsT18WQV2sblChgQfK6G+M0ZBVVwfUNb0KxePOlvJ3p6L
	 0FLBVuQNI5qmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D79BCD5BD5;
	Tue, 26 May 2026 21:52:20 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 27 May 2026 00:51:54 +0300
Subject: [PATCH net-next v2 09/10] net: phy: Add support for the ADIN1140
 PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-adin1140-driver-v2-9-37e5c8d4e0a0@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
In-Reply-To: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779832338; l=4959;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=Q4PnHqnyimvMStlwH1jthtt1eNnizfbV+xozD0BJvuo=;
 b=kkvmtdw2dyz8SJo2UZhOwBtOVrFFdZU0wXmK34FiytmotOtwDPMEJohEBh8hnU/8Y6VgN8cAb
 v07PbES8FNJDrf39yI/nTZ1W0uVQfh9ypD4FAR+uGkcOSN/Fdc+NEGE
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291946-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,analog.com:url,analog.com:replyto,analog.com:mid,analog.com:email]
X-Rspamd-Queue-Id: 920645DCEED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Regus <ciprian.regus@analog.com>

Add a driver for the ADIN1140's internal 10BASE-T1S PHY. The device
doesn't implement autonegotiation, so the link is always reported as
being up.

The device implements both C22 and C45 MDIO access methods, but can only
be discovered over C22, since the C45 MMD devices lack the MDIO_DEVID1 and
MDIO_DEVID2 registers. The indirect C45 over C22 feature is not
supported.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
v2 changelog:
 - No longer setting PHY_MAC_INTERRUPT in order to avoid state polling.
 - Replace the driver specific .read/write_mmd() functions with the ones
   exported from genphy.
 - Renamed the file to adin1140-phy.c in order to avoid module name
   conflicts with the adin1140 ethernet driver.
---
 MAINTAINERS                    |  7 ++++
 drivers/net/phy/Kconfig        |  6 ++++
 drivers/net/phy/Makefile       |  1 +
 drivers/net/phy/adin1140-phy.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6c7425b45f..eda74f3154dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1857,6 +1857,13 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
+ANALOG DEVICES INC ETHERNET PHY DRIVERS
+M:	Ciprian Regus <ciprian.regus@analog.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://ez.analog.com/linux-software-drivers
+F:	drivers/net/phy/adin1140-phy.c
+
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 8b51bdc2e945..bd21a5dad366 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -124,6 +124,12 @@ config ADIN1100_PHY
 	  Currently supports the:
 	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
 
+config ADIN1140_PHY
+	tristate "Analog Devices ADIN1140 10BASE-T1S PHY"
+	help
+	  Adds support for the Analog Devices, Inc. ADIN1140's internal
+	  10BASE-T1S PHY.
+
 config AMCC_QT2025_PHY
 	tristate "AMCC QT2025 PHY"
 	depends on RUST_PHYLIB_ABSTRACTIONS
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 05e4878af27a..73152845b0b2 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -29,6 +29,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
+obj-$(CONFIG_ADIN1140_PHY)	+= adin1140-phy.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AMCC_QT2025_PHY)	+= qt2025.o
diff --git a/drivers/net/phy/adin1140-phy.c b/drivers/net/phy/adin1140-phy.c
new file mode 100644
index 000000000000..d35da4ad680d
--- /dev/null
+++ b/drivers/net/phy/adin1140-phy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Analog Devices, Inc. ADIN1140 10BASE-T1S PHY
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define ADIN1140_PHY_ID		0x0283be00
+
+#define ADIN1140_PCS_CTRL		0x08f3
+#define ADIN1140_PCS_CTRL_LOOPBACK	BIT(14)
+
+static int adin1140_config_aneg(struct phy_device *phydev)
+{
+	/* phylib tries to clear BIT(12) in MDIO_CTRL1, since AN is disabled.
+	 * However, on the ADIN1140, that field is non-standard, being used
+	 * to control the reset status of the PHY (thus it needs to remain set).
+	 */
+	return 0;
+}
+
+static int adin1140_loopback(struct phy_device *phydev, bool enable, int speed)
+{
+	if (enable && speed)
+		return -EOPNOTSUPP;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, ADIN1140_PCS_CTRL,
+			      ADIN1140_PCS_CTRL_LOOPBACK,
+			      enable ? ADIN1140_PCS_CTRL_LOOPBACK : 0);
+}
+
+static int adin1140_read_status(struct phy_device *phydev)
+{
+	phydev->link = 1;
+	phydev->duplex = DUPLEX_HALF;
+	phydev->speed = SPEED_10;
+	phydev->autoneg = AUTONEG_DISABLE;
+
+	return 0;
+}
+
+static struct phy_driver adin1140_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(ADIN1140_PHY_ID),
+		.name = "ADIN1140_PHY",
+		.features = PHY_BASIC_T1S_P2MP_FEATURES,
+		.read_status = adin1140_read_status,
+		.config_aneg = adin1140_config_aneg,
+		.set_loopback = adin1140_loopback,
+		.read_mmd = genphy_read_mmd_c45,
+		.write_mmd = genphy_write_mmd_c45,
+		.get_plca_cfg = genphy_c45_plca_get_cfg,
+		.set_plca_cfg = genphy_c45_plca_set_cfg,
+		.get_plca_status = genphy_c45_plca_get_status,
+	},
+};
+module_phy_driver(adin1140_driver);
+
+static const struct mdio_device_id __maybe_unused adin1140_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(ADIN1140_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, adin1140_tbl);
+
+MODULE_DESCRIPTION("Analog Devices, Inc. ADIN1140 10BASE-T1S PHY");
+MODULE_AUTHOR("Ciprian Regus <ciprian.regus@analog.com>");
+MODULE_LICENSE("GPL");

-- 
2.43.0



