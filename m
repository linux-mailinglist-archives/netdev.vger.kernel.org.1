Return-Path: <netdev+bounces-13060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AB273A113
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC5E281990
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E281C763;
	Thu, 22 Jun 2023 12:38:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596B3AAA0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:38:46 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 05:38:44 PDT
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C750DE
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:38:44 -0700 (PDT)
Received: from localhost.localdomain ([151.79.164.54])
	by Aruba Outgoing Smtp  with ESMTPSA
	id CJZEqf8KC1xz6CJZEqE7my; Thu, 22 Jun 2023 14:37:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1687437462; bh=g03OJMjrBbsiPap55M8C8/eh3feEmOWxGVwXp3EGFpY=;
	h=From:To:Subject:Date:MIME-Version;
	b=eNW2RDBrrahovjFeZYjyVuvgwITFcUflLImIHBwPRNH9Upd1xJu5xag4yMSbQ829i
	 WJyFarH57K33ffFtTxfWtKM+2+kbHF80bwpkm5qCLSzYHQSxiB5bHkrd89X4sInQGH
	 JVTqE1ldzEuaMJHYXEtL5CYqbNfVQ7oJw29ibNza8id1sqgudEY4pAFS6VueATpOya
	 84cBolwYe4KjcdyW7tlzvHFVls31tFfn+g8dyGw3gN4crIpV0v1zMCmpQHHxlCMSeD
	 0tQHyTH9kQW5aTMkmf1FNwhve2NB45L+DzH0rl7mQ+7THBwC87/psqaZ/UoxbbGeoC
	 IhsLzFppiKoNA==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] net: phy: broadcom: drop brcm_phy_setbits() and use phy_set_bits() instead
Date: Thu, 22 Jun 2023 14:37:37 +0200
Message-Id: <20230622123737.8649-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHJyd/ZEh28BATS8DEkFR2WqXze3wFY5EaNI9gpZ4M9ewFj4saI/IPlanEGmVHTBGnqhO9SLMg0TvAzgIQ1Pf2nsrjngHOJXlr3LVID+EEgwyss0ApMi
 QzwxBMw7JexINdQp6yqOLGLh1f4MrMLEsMuL1dTQPicgScYCZsOd+01Ncma+tdvkjvab2lSdLNMS31/nsW6c1AYgZLR/u9DsE592KZ5bdYurNIByQUy14J2k
 Fi/NbH/YAu0Cl61EJvHNsy7+C7zboB38KW7JuDHGl2LQP0s+4ZcZEL/EAR7taZ654Mtpgn6TfuxY6twCjkBIoLHnoRhPEdm1GfIcsZyECMqI06NTBVJ9/ZI3
 jqREXWN8zBxD5CJdbufGIf9zC4bdxxPJZ3XwRe/KBTc12kPhSVKUsWovzWJ/j9AJSSter4tt3UG7EJezXG3TWHSwl9VB5gYCwdr1LjeiqnyHUIOTyTjozSuk
 OqhrNCaPSbIasDz8iUs+u4EfcVOYLp6awLV7wye4d9vOckgbJlZWXTHzQOZrcH6jH3pIm/BExN8A4gbeg8IX2MP7kCcgeueJyHZsTKMdJK26avUNx1dbyeos
 t7PTdiCUDoQXjimyxd2fGxt2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
use phy_set_bits() in its place.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/net/phy/broadcom.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index ad71c88c87e7..d684c5be529a 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -608,17 +608,6 @@ static int bcm54616s_read_status(struct phy_device *phydev)
 	return err;
 }
 
-static int brcm_phy_setbits(struct phy_device *phydev, int reg, int set)
-{
-	int val;
-
-	val = phy_read(phydev, reg);
-	if (val < 0)
-		return val;
-
-	return phy_write(phydev, reg, val | set);
-}
-
 static int brcm_fet_config_init(struct phy_device *phydev)
 {
 	int reg, err, err2, brcmtest;
@@ -689,14 +678,14 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		goto done;
 
 	/* Enable auto MDIX */
-	err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
+	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
 				       MII_BRCM_FET_SHDW_MC_FAME);
 	if (err < 0)
 		goto done;
 
 	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
 		/* Enable auto power down */
-		err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
+		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
 					       MII_BRCM_FET_SHDW_AS2_APDE);
 	}
 
-- 
2.34.1


