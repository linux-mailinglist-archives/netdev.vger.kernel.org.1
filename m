Return-Path: <netdev+bounces-15160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3FC745FD0
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60F42809A1
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A11100BC;
	Mon,  3 Jul 2023 15:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5B9441
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:26:47 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA4E70
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:26:44 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230703152642d8b4f8d9a7892f3381
        for <netdev@vger.kernel.org>;
        Mon, 03 Jul 2023 17:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2C7Jb3Bpb/V3uMa0SnRT1zOU30LU1+kgf+2BdMTB4Bs=;
 b=VYSdB0sKL1CzSzgny3f6oQ5l1zmCH+5Ft+xdAJM48epFlTcrtIovvx5CH44BokaDgGbVb/
 Qparvi12ltQMSAOXklARVSYS6s+dYq3tZ72jGWXOTfmIvRdW4XMqxUE4F4MqwL0yOOLm4t72
 H+1YntpC2MQ0S3k3pBrjsjz+32jdk=;
From: "M. Haener" <michael.haener@siemens.com>
To: netdev@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 3/3] net: dsa: mv88e632x: Add SERDES ops
Date: Mon,  3 Jul 2023 17:26:09 +0200
Message-ID: <20230703152611.420381-4-michael.haener@siemens.com>
In-Reply-To: <20230703152611.420381-1-michael.haener@siemens.com>
References: <20230703152611.420381-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michael Haener <michael.haener@siemens.com>

The 88e632x family has several SERDES 100/1000 blocks. By adding these
operations, these functionalities can be used.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   | 32 ++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.c | 39 ++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.h |  9 +++++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 54e99cfb17c1..b889f08b9c3f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5197,10 +5197,26 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.serdes_get_lane = mv88e6320_serdes_get_lane,
+	.serdes_pcs_get_state = mv88e6352_serdes_pcs_get_state,
+	.serdes_pcs_config = mv88e6352_serdes_pcs_config,
+	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
+	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
+	.serdes_read = mv88e6320_serdes_read,
+	.serdes_write = mv88e6320_serdes_write,
+	.serdes_power = mv88e6352_serdes_power,
+	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
+	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
+	.serdes_irq_status = mv88e6352_serdes_irq_status,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
+	.serdes_get_strings = mv88e6352_serdes_get_strings,
+	.serdes_get_stats = mv88e6352_serdes_get_stats,
+	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
+	.serdes_get_regs = mv88e6352_serdes_get_regs,
 };
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
@@ -5243,10 +5259,26 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.serdes_get_lane = mv88e6320_serdes_get_lane,
+	.serdes_pcs_get_state = mv88e6352_serdes_pcs_get_state,
+	.serdes_pcs_config = mv88e6352_serdes_pcs_config,
+	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
+	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
+	.serdes_read = mv88e6320_serdes_read,
+	.serdes_write = mv88e6320_serdes_write,
+	.serdes_power = mv88e6352_serdes_power,
+	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
+	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
+	.serdes_irq_status = mv88e6352_serdes_irq_status,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
+	.serdes_get_strings = mv88e6352_serdes_get_strings,
+	.serdes_get_stats = mv88e6352_serdes_get_stats,
+	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
+	.serdes_get_regs = mv88e6352_serdes_get_regs,
 };
 
 static const struct mv88e6xxx_ops mv88e6341_ops = {
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 7b64e30600b9..8e8f264429de 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -17,6 +17,45 @@
 #include "port.h"
 #include "serdes.h"
 
+int mv88e6320_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val)
+{
+	return mv88e6xxx_phy_page_read(chip, lane,
+				       MV88E6320_SERDES_PAGE_FIBER,
+				       reg, val);
+}
+
+int mv88e6320_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val)
+{
+	return mv88e6xxx_phy_page_write(chip, lane,
+					MV88E6320_SERDES_PAGE_FIBER,
+					reg, val);
+}
+
+int mv88e6320_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
+{
+	u8 cmode = chip->ports[port].cmode;
+	int lane = -ENODEV;
+
+	switch (port) {
+	case 0:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+			lane = MV88E6320_PORT0_LANE;
+		break;
+	case 1:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+			lane = MV88E6320_PORT1_LANE;
+		break;
+	}
+
+	return lane;
+}
+
 int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 			  int device, int reg, u16 *val)
 {
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index e71cddf63eba..5af8a1046b69 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -12,6 +12,10 @@
 
 #include "chip.h"
 
+#define MV88E6320_PORT0_LANE		0x0c
+#define MV88E6320_PORT1_LANE		0x0d
+#define MV88E6320_SERDES_PAGE_FIBER	0x01
+
 #define MV88E6352_ADDR_SERDES		0x0f
 #define MV88E6352_SERDES_PAGE_FIBER	0x01
 #define MV88E6352_SERDES_IRQ		0x0b
@@ -108,6 +112,7 @@
 #define MV88E6393X_ERRATA_4_8_BIT		BIT(14)
 
 int mv88e6185_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
+int mv88e6320_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
@@ -137,10 +142,14 @@ int mv88e6352_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 				 int lane, int speed, int duplex);
 int mv88e6390_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 				 int lane, int speed, int duplex);
+int mv88e6320_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
 int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6320_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val);
 int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
 			   int reg, u16 val);
 int mv88e6390_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
-- 
2.41.0


