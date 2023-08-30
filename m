Return-Path: <netdev+bounces-31354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0A78D48C
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3387E1C209BB
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F061C39;
	Wed, 30 Aug 2023 09:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DEB1C10
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:21:40 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73338CCB;
	Wed, 30 Aug 2023 02:21:38 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 428BA864EF;
	Wed, 30 Aug 2023 11:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693387296;
	bh=8vxd2qPCpP6m2nYudlDH5tbegJ9wBVvB3PF1O86stzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1DJodv45zfCQqRv/NeXJL8jLT/pbfn0bfkbs8hXNptSsHmq/vP7KSPgrZV33woan
	 i8LP/1OQVxiBVWzSRZTomxKGwPMa4kGcDqDc3/7vDGrVP5exdGMekrlSl0Mf9ZEYkR
	 DpfkVTAmbnbhsrBkZv5vz2YOroZZQwxrDAxOK+xAnzx7BQoJSeQ+esNML7kiBBfyLh
	 7d092I8jtm8xcxyuc1r3hHf81SF0QinLrmUAp64+wn4KxNhcIsnPdcy8grALUbKYBB
	 E1j+hVPghC/qoSEAPdNr/7JOJ+mxayC8agS2Qey2SC3DeO7lypYHxVKvLE4VVawbbz
	 vvDw2rHEl7NsQ==
From: Lukasz Majewski <lukma@denx.de>
To: Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)
Date: Wed, 30 Aug 2023 11:21:19 +0200
Message-Id: <20230830092119.458330-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830092119.458330-1-lukma@denx.de>
References: <20230830092119.458330-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The KSZ9477 errata points out (in 'Module 4') the link up/down problem
when EEE (Energy Efficient Ethernet) is enabled in the device to which
the KSZ9477 tries to auto negotiate.

The suggested workaround is to clear advertisement of EEE for PHYs in
this chip driver.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 87b090ad2874..469dcd8a5711 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz9477_get_features(struct phy_device *phydev)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
+	int ret;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* KSZ9477 Errata DS80000754C
+	 *
+	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
+	 * manually disabled
+	 *   The EEE feature is enabled by default, but it is not fully
+	 *   operational. It must be manually disabled through register
+	 *   controls. If not disabled, the PHY ports can auto-negotiate
+	 *   to enable EEE, and this feature can cause link drops when linked
+	 *   to another device supporting EEE.
+	 *
+	 *   Although, the KSZ9477 MMD register
+	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that EEE is
+	 *   operational one needs to manualy clear them to follow the chip
+	 *   errata.
+	 */
+	linkmode_and(phydev->supported_eee, phydev->supported, zero);
+
+	return 0;
+}
+
 #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
 #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
 #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
@@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-	.get_features	= ksz9131_get_features,
+	.get_features	= ksz9477_get_features,
 } };
 
 module_phy_driver(ksphy_driver);
-- 
2.20.1


