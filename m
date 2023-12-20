Return-Path: <netdev+bounces-59285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B381A34C
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982CA1F25C31
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FE41C96;
	Wed, 20 Dec 2023 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES0S4cDx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD741875
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEACC433C9;
	Wed, 20 Dec 2023 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087760;
	bh=PzqSoS7JcvqSMbjEYVeKdFso7tqADg3bJ1pfbVXyVDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ES0S4cDxOVXd+2Fl6uKtO1BKt0J/axd0o6ZbB4HPQevWUvAdmzb+ARCEXY5DvXVtL
	 n5jd/cJsB5vU6CwUslQUOnJEeVv7xy+7DH5XmsP31/7WRj1Rie5vjCjIXiJsrGPXjx
	 qbwoNsUzmc57NOGHQCYTOT6x+4Y0AAi/ZwFSagsUd87NKD87nk2XOLP6qRnNy95sg0
	 nxoO3xgDuwFyTKgXEGsXlaKEGsc+CKFG+DDlc5anuaFyO165mT4TOY/tvJp0VYtB7D
	 PCy+UTFaKe5x+mSPy5KKG3ZM8p46HbnxZhdYJeZH/hc1bjmirRk2/tuFebojS2OgW4
	 RTiEyTlwEPG2A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 12/15] net: phy: realtek: use generic c45 suspend/resume for rtl822x
Date: Wed, 20 Dec 2023 16:55:15 +0100
Message-ID: <20231220155518.15692-13-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
References: <20231220155518.15692-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that rtl822x PHYs .read_mmd() and .write_mmd() methods support
accessing all MMD registers, use the generic clause 45 functions
genphy_c45_pma_suspend() and genphy_c45_pma_resume() for the rtl822x
series of Realtek transceivers.

Add a 20ms delay after resume, as done in the current resume
implementation.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index f36b2bfabe57..cf608d390aa5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -651,6 +651,18 @@ static int rtl822x_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_resume(struct phy_device *phydev)
+{
+	int ret = genphy_c45_pma_resume(phydev);
+
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+
+	return 0;
+}
+
 static int rtl822x_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -949,8 +961,8 @@ static struct phy_driver realtek_drvs[] = {
 		.probe		= rtl822x_probe,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
-		.suspend	= genphy_suspend,
-		.resume		= rtlgen_resume,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtl822x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
@@ -961,8 +973,8 @@ static struct phy_driver realtek_drvs[] = {
 		.probe		= rtl822x_probe,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
-		.suspend	= genphy_suspend,
-		.resume		= rtlgen_resume,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtl822x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
@@ -973,8 +985,8 @@ static struct phy_driver realtek_drvs[] = {
 		.probe		= rtl822x_probe,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtl822x_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
@@ -985,8 +997,8 @@ static struct phy_driver realtek_drvs[] = {
 		.probe		= rtl822x_probe,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtl822x_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
@@ -997,8 +1009,8 @@ static struct phy_driver realtek_drvs[] = {
 		.probe		= rtl822x_probe,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtl822x_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
@@ -1009,8 +1021,8 @@ static struct phy_driver realtek_drvs[] = {
 		.probe		= rtl822x_probe,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-		.suspend        = genphy_suspend,
-		.resume         = rtlgen_resume,
+		.suspend	= genphy_c45_pma_suspend,
+		.resume		= rtl822x_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
-- 
2.41.0


