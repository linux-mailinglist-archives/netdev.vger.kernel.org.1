Return-Path: <netdev+bounces-17185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA0750BE5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EF5281A4F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D63D3A6;
	Wed, 12 Jul 2023 15:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7434CF1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F1DC4167D;
	Wed, 12 Jul 2023 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689174469;
	bh=ddCdu6WVsdWVFfvgBcdVDn3T10QccxGUylRsenvX6jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DitXThW4uKEoasdiRZYLAtA3p/W5TdLyOjeCnsFgj2M9B+fz/1FI2yRX3Xhy1XUgn
	 SrY3Grn+AHRk5+lLLXQ1FJ0p5rS4rMSdw7ZlPaDAa5/gwJbyZ89iNebI/WpHMrR9rw
	 5FmgNySVn+xjePRk5RwCoIhGL3rNlYrkBoeq4TJ6K5+bv2EaTBvEXL3gHQGy/fFPn7
	 Gp6lLVEoDFO1S7Q1lQe6L/5ojU0Gug/9M5QLIViSJJ1yd7h5vM5+/jbZor4zFHBrU+
	 cqFJZ0CBJZfqlhJnpHCmGLGvv2hAqIOuzZdD7tFqzurw3Qd+L2z4LFHAmBGk9QXlKl
	 PJcul75F7D8oQ==
From: Michael Walle <mwalle@kernel.org>
Date: Wed, 12 Jul 2023 17:07:05 +0200
Subject: [PATCH net-next v3 05/11] net: phy: print an info if a broken C45
 bus is found
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-5-9eb37edf7be0@kernel.org>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
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
 Simon Horman <simon.horman@corigine.com>, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2

If there is an PHY which gets confused by C45 transactions on the MDIO
bus, print an info together with the PHY identifier of the offending
one.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - make it a dev_dbg()
 - check is phydev is not null
---
 drivers/net/phy/mdio_bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 29ad9302fe11..bdc178671234 100644
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
+	if (phydev && bus->prevent_c45_access)
+		dev_dbg(&bus->dev,
+			"Detected broken PHY (ID %08lx). Disabling C45 bus transactions.\n",
+			(unsigned long)phydev->phy_id);
 }
 EXPORT_SYMBOL_GPL(mdiobus_scan_for_broken_c45_access);
 

-- 
2.39.2


