Return-Path: <netdev+bounces-13362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4D873B557
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A41C21238
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085E8821;
	Fri, 23 Jun 2023 10:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF63AD2D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39768C4339A;
	Fri, 23 Jun 2023 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687516193;
	bh=ix+vKAfBpwxnlJKw+L5AoviCMLKx2fPBzB19tGgvqkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XB95Dcmc8wW4JD6DEXS1rgGOZ3p9hQXaQDnOEyCD1wlXpCZXNv6UbfGnRzpENIj+z
	 VNhwpnqp7isIRSIOiB4mwA5c9iciXrMUI2QS6ttZ15BfUARuOLziQfUgm6TV1c7SvW
	 o7wIIiRA2OpWWVs46jl12LGHMsjskm9c+dcKxwaFw5lKYFJEYs/9++Xs5XPWtq4G6d
	 zm//Jbll4UGQbAWhKle057rjMgHzgc9uHkOib3D5aYnUFgJrHE921KvI/WR+pGLtOa
	 BYS6UMXaRTRalUQtnr2ba8y2V4LmboZo08ULDWWy8DlP9Hd0rMiccCfsXMcSK07SVX
	 JQwia/4TOByfA==
From: Michael Walle <mwalle@kernel.org>
Date: Fri, 23 Jun 2023 12:29:18 +0200
Subject: [PATCH net-next v2 09/10] net: mdio: add C45-over-C22 fallback to
 fwnode_mdiobus_register_phy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-9-def0ab9ccee2@kernel.org>
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

If trying to register a C45 PHY on an MDIO bus which isn't capable of
C45 (either because the MDIO controller doesn't support it or because
C45 accesses are prohibited due to faulty C22 PHYs) we can fall back to
the new C45-over-C22 access method.

Signed-off-by: Michael Walle <mwalle@kernel.org>

---
Please note, that both with the old and the new code compatible =
"ethernet-phy-idNNNN.NNNN" only works for the C22 case. I'm wondering if
compatible = "ethernet-phy-idNNNN.NNNN", "ethernet-phy-ieee802.3-c45
even makes sense because there might be multiple C45 ids. At least it is
an allowed pattern according to the device tree bindings. But with the
current code, the ethernet-phy-idNNNN.NNNN is ignored in the c45 case.
---
 drivers/net/mdio/fwnode_mdio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 972c8932c2fe..fed056d82b4e 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -115,7 +115,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	struct mii_timestamper *mii_ts = NULL;
 	struct pse_control *psec = NULL;
 	struct phy_device *phy;
-	bool is_c45;
 	u32 phy_id;
 	int rc;
 
@@ -129,13 +128,19 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		goto clean_pse;
 	}
 
-	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
-		phy = get_phy_device(bus, addr,
-				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
-	else
+	if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45")) {
+		if (mdiobus_supports_c45(bus))
+			phy = get_phy_device(bus, addr, PHY_ACCESS_C45);
+		else
+			phy = get_phy_device(bus, addr,
+					     PHY_ACCESS_C45_OVER_C22);
+	} else if (fwnode_get_phy_id(child, &phy_id) == 0) {
 		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
 					NULL);
+	} else {
+		phy = get_phy_device(bus, addr, PHY_ACCESS_C22);
+	}
+
 	if (IS_ERR(phy)) {
 		rc = PTR_ERR(phy);
 		goto clean_mii_ts;

-- 
2.39.2


