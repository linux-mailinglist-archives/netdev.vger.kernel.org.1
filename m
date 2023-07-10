Return-Path: <netdev+bounces-16559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746D74DD27
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B3228134C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E814A93;
	Mon, 10 Jul 2023 18:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98C14A8B
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:14:31 +0000 (UTC)
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A5012B;
	Mon, 10 Jul 2023 11:14:29 -0700 (PDT)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
	by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id A4A34601F18C;
	Mon, 10 Jul 2023 20:58:20 +0300 (EEST)
Received: from yocto-vm.localdomain ([172.24.253.44]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	 Mon, 10 Jul 2023 20:58:20 +0300
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: 
Cc: vesa.jaaskelainen@vaisala.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: phy: dp83822: Add support for line class driver configuration
Date: Mon, 10 Jul 2023 20:56:20 +0300
Message-Id: <20230710175621.8612-3-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 17:58:20.0539 (UTC) FILETIME=[1CC644B0:01D9B358]
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Line driver can be configured either in Class A or in Class B modes.

By default the PHY is in Class B mode.

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 drivers/net/phy/dp83822.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index b7cb71817780..5c144d22b64e 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -31,12 +31,17 @@
 #define MII_DP83822_FCSCR	0x14
 #define MII_DP83822_RCSR	0x17
 #define MII_DP83822_RESET_CTRL	0x1f
+#define MII_DP83822_LDCSEL	0x404
 #define MII_DP83822_GENCFG	0x465
 #define MII_DP83822_SOR1	0x467
 
 /* GENCFG */
 #define DP83822_SIG_DET_LOW	BIT(0)
 
+/* Line Driver Class Selection (LDCSEL) */
+#define DP83822_LDCSEL_CLASS_A	0x24
+#define DP83822_LDCSEL_CLASS_B	0x20
+
 /* Control Register 2 bits */
 #define DP83822_FX_ENABLE	BIT(14)
 
@@ -118,6 +123,7 @@ struct dp83822_private {
 	bool fx_signal_det_low;
 	int fx_enabled;
 	u16 fx_sd_enable;
+	bool line_driver_class_a;
 };
 
 static int dp83822_set_wol(struct phy_device *phydev,
@@ -416,6 +422,16 @@ static int dp83822_config_init(struct phy_device *phydev)
 					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
 	}
 
+	/* Configure line driver class */
+	if (dp83822->line_driver_class_a)
+		/* full MLT-3 on both Tx+ and Tx–.*/
+		phy_write_mmd(phydev, DP83822_DEVADDR, MII_DP83822_LDCSEL,
+			      DP83822_LDCSEL_CLASS_A);
+	else
+		/* reduced MLT-3 */
+		phy_write_mmd(phydev, DP83822_DEVADDR, MII_DP83822_LDCSEL,
+			      DP83822_LDCSEL_CLASS_B);
+
 	if (dp83822->fx_enabled) {
 		err = phy_modify(phydev, MII_DP83822_CTRL_2,
 				 DP83822_FX_ENABLE, 1);
@@ -507,6 +523,12 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->fx_enabled = device_property_present(dev,
 							      "ti,fiber-mode");
 
+	/* DP83822 defaults to line driver class B - enable configuration for
+	 * class A
+	 */
+	dp83822->line_driver_class_a = device_property_present(dev,
+							       "ti,line-driver-class-a");
+
 	return 0;
 }
 #else
-- 
2.34.1


