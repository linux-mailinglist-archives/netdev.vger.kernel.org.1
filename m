Return-Path: <netdev+bounces-13359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4973B554
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB17281A61
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080379D5;
	Fri, 23 Jun 2023 10:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D88F62
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DF5C433CC;
	Fri, 23 Jun 2023 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687516182;
	bh=1muRLOb59+kQ7ZeXLBMZWXmkOisk9F6Bf+D/rqGDwuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fg6wduN550kCKQZAgcUK+qaSxIyBJvy3NpfG7LFBjHOeAxveVY2qfyTrz2SYTMYok
	 V9yn8w0v64hHHiyJx+/fThXbsPsHutp/n8hsSi5SMYEIjOGK7w/qZFfzbMtzBX1iTE
	 29nL8rlcN2obNqdLHbi5OzZRLRIie1wjFJqC7qN6U6kVIaOy/hCRiEk6wu2b0fePP7
	 D/kwRdTlPoDZ+t4LzMymI/5K5LWgCcR0jpt/8U5pI7RJI2Y89s57LurgxGWmq0bYYx
	 G/weE/QDJSfjzcCEDCxb815JI2ABvpdqcRO+qIXgrxyLIBUbxw8rXN2aqyO4nBjcnF
	 WHOJX1er4qZUg==
From: Michael Walle <mwalle@kernel.org>
Date: Fri, 23 Jun 2023 12:29:15 +0200
Subject: [PATCH net-next v2 06/10] net: phy: print an info if a broken C45
 bus is found
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-6-def0ab9ccee2@kernel.org>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Xu Liang <lxu@maxlinear.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2

If there is an PHY which gets confused by C45 transactions on the MDIO
bus, print an info together with the PHY identifier of the offending
one.

Signed-off-by: Michael Walle <mwalle@kernel.org>

---
I wasn't sure if this should be phydev_dbg() or phydev_info(). I mainly
see this as an info to a user why some PHYs might not be probed (or
c45-over-c22 is used later).
---
 drivers/net/phy/mdio_bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00b25f6803bc..38529add6420 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -617,10 +617,10 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  */
 void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
 {
+	struct phy_device *phydev;
 	int i;
 
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		struct phy_device *phydev;
 		u32 oui;
 
 		phydev = mdiobus_get_phy(bus, i);
@@ -633,6 +633,11 @@ void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
 			break;
 		}
 	}
+
+	if (bus->prevent_c45_access)
+		dev_info(&bus->dev,
+			 "Detected broken PHY (ID %08lx). Disabling C45 bus transactions.\n",
+			 (unsigned long)phydev->phy_id);
 }
 
 /**

-- 
2.39.2


