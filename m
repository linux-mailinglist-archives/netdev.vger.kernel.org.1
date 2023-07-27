Return-Path: <netdev+bounces-21807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D7764CC7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114741C208F0
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0BFD301;
	Thu, 27 Jul 2023 08:27:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF8D2F0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:27:08 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491484EDB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pTHDtCKW0IluBtg4WbpD49owSeMHqMqck+SFzjWQotw=; b=DnDo5654XBkLj2a+Wb/1W2yCw2
	LP+AsX0KoX/GhpwB0oZjvlsInyvP3LzcmMwiiD2LhVdKkOqXYFME3L4LfRwAN+abEkV1dAQRKv9MF
	aHy0/IdfyFKUCDM8TJ6opxZY95f0gs6ZlB+766vJZnNFDLbY6//H0WyXUbh0PVRhvWIGnJqieRB6s
	QqfE5cHfUvn6BoyWT8nTdlnQuaEfKDlJfc2e1ke3XPwKOm042/wKpUvrOx6Fdlb4rXftZjABWSEvQ
	BbRVATgTw0sw+6ZY7kvzR89IdCdP05B9Gp0xUEz8g+iTQSXTEaMQ9MTDVswxgQLpZP180xrQOzyg/
	q7QpZdNw==;
Received: from [192.168.1.4] (port=13596 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qOwJp-0002sf-2y;
	Thu, 27 Jul 2023 10:25:57 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 27 Jul 2023 10:25:57 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Ante Knezic
	<ante.knezic@helmholz.de>
Subject: [PATCH net-next v4] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date: Thu, 27 Jul 2023 10:25:50 +0200
Message-ID: <20230727082550.15254-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fixes XAUI/RXAUI lane alignment errors.
Issue causes dropped packets when trying to communicate over
fiber via SERDES lanes of port 9 and 10.
Errata document applies only to 88E6190X and 88E6390X devices.
Requires poking in undocumented registers.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
V4 : Rework as suggested by Vladimir Oltean <olteanv@gmail.com>
     and Russell King <linux@armlinux.org.uk>
 * print error in case of failure to apply erratum
 * use mdiobus_c45_write instead of mdiodev_c45_write
 * use bool variable instead of embedding a chip pointer inside
   pcs struct.
V3 : Rework to fit the new phylink_pcs infrastructure
V2 : Rework as suggested by Andrew Lunn <andrew@lun.ch> 
 * make int lanes[] const 
 * reorder prod_nums
 * update commit message to indicate we are dealing with
   undocumented Marvell registers and magic values
---
 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index 98dd49dac421..ba373656bfe1 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -20,6 +20,7 @@ struct mv88e639x_pcs {
 	struct mdio_device mdio;
 	struct phylink_pcs sgmii_pcs;
 	struct phylink_pcs xg_pcs;
+	bool erratum_3_14;
 	bool supports_5g;
 	phy_interface_t interface;
 	unsigned int irq;
@@ -205,13 +206,53 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
 	mv88e639x_sgmii_pcs_control_pwr(mpcs, false);
 }
 
+static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
+{
+	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
+		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
+		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
+		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
+	int err, i;
+
+	/* 88e6190x and 88e6390x errata 3.14:
+	 * After chip reset, SERDES reconfiguration or SERDES core
+	 * Software Reset, the SERDES lanes may not be properly aligned
+	 * resulting in CRC errors
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(lanes); i++) {
+		err = mdiobus_c45_write(mpcs->mdio.bus, lanes[i],
+					MDIO_MMD_PHYXS,
+					0xf054, 0x400C);
+		if (err)
+			return err;
+
+		err = mdiobus_c45_write(mpcs->mdio.bus, lanes[i],
+					MDIO_MMD_PHYXS,
+					0xf054, 0x4000);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mv88e639x_sgmii_pcs_post_config(struct phylink_pcs *pcs,
 					   phy_interface_t interface)
 {
 	struct mv88e639x_pcs *mpcs = sgmii_pcs_to_mv88e639x_pcs(pcs);
+	int err;
 
 	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
 
+	if (mpcs->erratum_3_14) {
+		err = mv88e6390_erratum_3_14(mpcs);
+		if (err)
+			dev_err(mpcs->mdio.dev.parent,
+				"failed to apply erratum 3.14: %pe\n",
+				ERR_PTR(err));
+	}
+
 	return 0;
 }
 
@@ -524,6 +565,10 @@ static int mv88e6390_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	mpcs->xg_pcs.ops = &mv88e6390_xg_pcs_ops;
 	mpcs->xg_pcs.neg_mode = true;
 
+	if (chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6190X ||
+	    chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6390X)
+		mpcs->erratum_3_14 = true;
+
 	err = mv88e639x_pcs_setup_irq(mpcs, chip, port);
 	if (err)
 		goto err_free;
-- 
2.11.0


