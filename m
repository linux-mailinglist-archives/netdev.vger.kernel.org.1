Return-Path: <netdev+bounces-59277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9081A342
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83321C221FC
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3D40C00;
	Wed, 20 Dec 2023 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQaY7A0a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF940BF0
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48732C433CA;
	Wed, 20 Dec 2023 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087735;
	bh=LDVFFU8cwSaSzDydsQFZt0H8tN+EUon5x7E9dsIwfb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQaY7A0aw8E9u8/ZPTc8gWQMryCi/7t/29VuTbTW/7QHcU8VSdgVPIN6btmbU3/ho
	 YGoOmSGFD+9nvJPhjLYovXRnQd8q05qCIZugFHpdQdxJ9YF4iBsOs+Zeh8ibVOHJoO
	 CElTwqozKmXjGbIX5F1QGpwufGdbCzWRBChdlhXVDu2b3PM6HQBuwvKxxrITUfk1b0
	 IsWBElcH4HjibyNbTezBTW+14ogK/4bp5VbQfPMJzw9zJhV2UtR5QyqHCxUhcnzxb0
	 KiL0OGPsA8e9JuRnRPrawm7EH8WrGw8UwWsmnjO0/B2PbPPSbyKvodHB/O57Yco6Aj
	 Y4Ct6knBOBrTQ==
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
Subject: [PATCH net-next 04/15] net: phy: realtek: fill .read_mmd and .write_mmd methods for all rtl822x PHYs
Date: Wed, 20 Dec 2023 16:55:07 +0100
Message-ID: <20231220155518.15692-5-kabel@kernel.org>
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

Fill in the .read_mmd() and .write_mmd() methods for all rtl822x PHYs,
so that we can start reimplementing rtl822x driver methods into using
genphy_c45_* functions.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 6e84f460a888..8f11320b38a8 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -996,6 +996,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		.read_mmd	= rtlgen_read_mmd,
+		.write_mmd	= rtlgen_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
@@ -1006,6 +1008,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		.read_mmd	= rtlgen_read_mmd,
+		.write_mmd	= rtlgen_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
@@ -1016,6 +1020,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		.read_mmd	= rtlgen_read_mmd,
+		.write_mmd	= rtlgen_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc84a),
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
@@ -1026,6 +1032,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+		.read_mmd	= rtlgen_read_mmd,
+		.write_mmd	= rtlgen_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc961),
 		.name		= "RTL8366RB Gigabit Ethernet",
-- 
2.41.0


