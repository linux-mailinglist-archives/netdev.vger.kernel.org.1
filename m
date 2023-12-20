Return-Path: <netdev+bounces-59286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40981A34D
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F51C245A2
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48B47A66;
	Wed, 20 Dec 2023 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyji8rs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C545C18
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A67C433CB;
	Wed, 20 Dec 2023 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087763;
	bh=D24IxqQ8SbOHt1SLy+6Yt1Bwj3SMfAtFEcvcSNmoatg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyji8rs81KJMljwUXb2whPzsQHRaXF4+n5GmHqwH4rGdLJijvGoCs+xUn/CYkcHs6
	 UgSPi5yLNPz+aLdpApP4f+5QgUUqUu80Rhq7mSq2M2jeGYxWvohOLyQeLlVbLRrkqD
	 +wjU2gp9lAdTGpQc/taiqxS40hUT2Xu8m1GcE2qiaJb1X+CjZuwjREbjucKfrKqjDx
	 F3tKWNrY+Y2k/0raASWinESdk4lHfI8uIMucbBRX9/XrPC7Cm4G2qTQBJT24CrqYaP
	 4qmPAY+8x70taCkM4LsJYo0uWHrG1TpJZVL56e9wJ9KOSs/j4GmI1sw2hXRKSCjRso
	 Pse7Q3LIKxw4Q==
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
Subject: [PATCH net-next 13/15] net: phy: realtek: drop .read_page and .write_page for rtl822x series
Date: Wed, 20 Dec 2023 16:55:16 +0100
Message-ID: <20231220155518.15692-14-kabel@kernel.org>
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

Drop the .read_page() and .write_page() methods for rtl822x series.

The rtl822x driver methods are now reimplemented to only access clause
45 registers and these are the last methods that explicitly access
clause 22 registers.

If the underlying MDIO bus is clause 22, the paging mechanism is still
used internally in the .read_mmd() and .write_mmd() methods when
accessing registers in MMD 31.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index cf608d390aa5..e2f68ac4b005 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -963,8 +963,6 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtl822x_resume,
-		.read_page	= rtl821x_read_page,
-		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
 	}, {
@@ -975,8 +973,6 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtl822x_resume,
-		.read_page	= rtl821x_read_page,
-		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
 	}, {
@@ -987,8 +983,6 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtl822x_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
 	}, {
@@ -999,8 +993,6 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtl822x_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
 	}, {
@@ -1011,8 +1003,6 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtl822x_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
 	}, {
@@ -1023,8 +1013,6 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
 		.resume		= rtl822x_resume,
-		.read_page      = rtl821x_read_page,
-		.write_page     = rtl821x_write_page,
 		.read_mmd	= rtlgen_read_mmd,
 		.write_mmd	= rtlgen_write_mmd,
 	}, {
-- 
2.41.0


