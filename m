Return-Path: <netdev+bounces-59282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9681A347
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D03B25DDB
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421441850;
	Wed, 20 Dec 2023 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2d6/7cA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B941844
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCB5C433CB;
	Wed, 20 Dec 2023 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087751;
	bh=G8NYMSoxXsM+su2HLc3KV+Gn32NJ1REsm+1Kuxjlo2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2d6/7cAGPv3oNix8z2ulLzJ/rCFTZZs0sSIGEIZV/xfH3m10+6TBYDlAik+3X8rM
	 r9cxUvpLvK9y5Ee35pF83b5b20acSj9zabqxlpI21JP8u1XQPij1xWFGp1XrV58mtK
	 ZMaWRbt8olbA+Bc9g7wT3nqouwFVSJJn6M/lxaMT4wNz/FcUGmEE6+kOWEFYnwqypd
	 T21dU59x+Z8cH20nI0X6Md3bqXWwVg3cQM5lzIub221ZR5WtvZtNQraOepXUA+NmOd
	 Pbex1f07S+I+f9TSbqty5L0uGjcPk19hs76EE2tDES9zOHUWHXh7fwAmxxZ9Y+5d+D
	 20zrhv/IOka/A==
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
Subject: [PATCH net-next 09/15] net: phy: realtek: read standard MMD register for rtlgen speed capability
Date: Wed, 20 Dec 2023 16:55:12 +0100
Message-ID: <20231220155518.15692-10-kabel@kernel.org>
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

Read the standard "PMA/PMD speed ability" register instead of it's
vendor specific alias via paging in rtlgen_supports_2_5gbps(), which is
used by the .match_phy_device method.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 66515981d2aa..0bb56d89157a 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -699,11 +699,7 @@ static int rtl822x_read_status(struct phy_device *phydev)
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
-	int val;
-
-	phy_write(phydev, RTL821x_PAGE_SELECT, 0xa61);
-	val = phy_read(phydev, 0x13);
-	phy_write(phydev, RTL821x_PAGE_SELECT, 0);
+	int val = rtlgen_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_SPEED);
 
 	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
-- 
2.41.0


