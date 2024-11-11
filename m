Return-Path: <netdev+bounces-143670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD469C3967
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603942823D2
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB18158D79;
	Mon, 11 Nov 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="G7hrW6fd"
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A514B077;
	Mon, 11 Nov 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312455; cv=none; b=mv9YMn/5Jyn0aYCm4V/XZfu9FK8zsF6feffYc1P5IVd4U3lS70IwEGPJTApw0Szn7g0C6bHJlh8jgw1Au6VgtoEyZW6SNHXRHsWmsdaZmDRKPrukH9Kepe6VvQ4lvzTJxRhRkWOCu7BvVgDyHO40V1Q9v5Laq2cc7hQ4YknJTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312455; c=relaxed/simple;
	bh=PhwDtEg/LEpTPpLUYCpjCql2vZFz2gWbSSuDrAl9AKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c58tu2wm2RoocEtjuZX4V1yjox+CMR9wQqOeJE3rDvGlkgRMrbTSKVLqgB1GnOg5weioZVIWVwgdYrZfi3JFt4zYO4ZOs5C8oriivhVuFhr2vYPVP5bMxOZaLUFuiO2Wv+rGO20A6ZyZ5KQHqdCiP4gqPV4ljAR0vPCYUs91YFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=G7hrW6fd; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731312435;
	bh=Y1fuglRgUw47/f3KQYozli3/k4/a9X3TSldSFC8XL5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=G7hrW6fd6BKCGpmY3swi8/cH+8+Dt+0u+dkjl/nPaH1YBmro9pg5Ocwjd+NOKJQtp
	 dcfTmQ0QCRZlf/jZr06JhM8RHY/qCD3HcnaSQLjIJh66UoRmoQQNjCRGunuG6OlHa3
	 E5z/e6iZ44oZ8s53DgXaUAr5ruX7cSrRUkgqaAWc=
X-QQ-mid: bizesmtpsz8t1731312404twhijyk
X-QQ-Originating-IP: sjAl8FxYTJ6OMhx6nAYKrFe48tSnxFP11GG7iE8sYj8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 16:06:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6476989594551450920
From: WangYuli <wangyuli@uniontech.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	f.fainelli@gmail.com,
	sebastian.hesselbarth@gmail.com,
	mugunthanvnm@ti.com,
	geert+renesas@glider.be,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] net: phy: fix may not suspend when phy has WoL
Date: Mon, 11 Nov 2024 16:06:27 +0800
Message-ID: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NV9lVvsB36OpD6PKvxpVWu6D1z11YJfLSY4u2HvUy/KS3zr3hAkPgjS5
	okRxcIKaAdmn90ieMiTsXMmXt0/nVVQ1XXMusgHlsiTnU+S6qQE+9CzIz6dX8nYYS2Akf5l
	IKP3L6K8MtxtBttfe1WbVF7tADyLp17ZdzGIXd4vloeUQLhsOjYslfrG7JeVUvD/92y1xaA
	c1PfIw2JlRBFcpui3PlRxNtghtUHu19CL8k7CsHD+iXguDwO7eFf4ns5sv7oADNt3XrGNeW
	SLZkLs9UxcsCr+weGUHOdOUK8//pp/4tyjWQcfiMDuQFX+bMdsvS5GSjoYnFIhlVcYqwxGv
	0BNhk9YbfbXA6mTIqGffhubRZXneZv7BXSqlYDOa9p/8cymNkHj4Fr2H/xAoZhaJU9qUND1
	QmcXPYOLO+lAahJZO/izSlMqfxpzs/xMdFj+VMDAurBhjjx9/ANrvoDcsxLMNmEYxVx1plq
	lkPZr3ISSdM/Vs1+oNaNS/L70nPr4A8HEWpqlxEOjgNdKkSChd3c95SVykWGgzIgFTD6Goy
	TUsLsjB8PKkjDzPgeuFmcfh7Sbl+dza3Xb+//lmprh00wojN8gs217OP4zd0qZ15KS9A5nN
	Hu+NUBelClE9/viLC7XZ3tyAlckdeV2phFWsPx0dBis8Ia9Z206iEHlGLPKFEQs/Io5T8PW
	wbxbUAKw8I0yk+dggcabFHu3a4iqMGRaFJ79lp0m37u/iLq1cJs1QMcb94wJW8/XA/m2XAj
	GLO3huJcsJ76tCigMOmLyfgF2LO2dkRJOcDE5MQ+R8L5s+ZZmeEgQ52MkubsoTNfVeVecri
	ZWN10Zx6AewPnupR5i9w9jEo6v+geosZfhvVXZzNIVYgA74wZZcF4I7i5QHL1MwmARgt/Vq
	WkOX+Oy7zIdbsCw4lE2R9ndo3RzGaEFC9bnplp7cVU4b/b5DTSF520QCIpSx7pf0P4qaFbc
	LOLFFCzY6FL8kkTy4apwhfV8A0F27FLyMEykllEW7pFqwdsMlUQwE4ZQXXta3DMdugW4xVE
	ybzlBghd5GA+i/KByC8dhmJ133BpIXXAhMQ8enPJ2MJShZHUleMUhjgPO/tJw=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: Wentao Guan <guanwentao@uniontech.com>

When system suspends and mdio_bus_phy goes to suspend, if the phy
enabled wol, phy_suspend will returned -EBUSY, and break system
suspend.

Commit 93f41e67dc8f ("net: phy: fix WoL handling when suspending
the PHY") fixes the case when netdev->wol_enabled=1, but some case,
netdev->wol_enabled=0 and phydev set wol_enabled enabled, so check
phydev->wol_enabled.

This case happens when using some out of tree ethernet drivers or
phy drivers.

Log:
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to freeze: error -16

Link: https://lore.kernel.org/all/20240827092446.7948-1-guanwentao@uniontech.com/
Fixes: 481b5d938b4a ("net: phy: provide phy_resume/phy_suspend helpers")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/phy/phy_device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bc24c9f2786b..12af590bfd99 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -315,6 +315,19 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (netdev->ethtool->wol_enabled)
 		return false;
 
+	/* Ethernet and phy device wol state may not same, netdev->wol_enabled
+	 * disabled, and phydev set wol_enabled enabled, so netdev->wol_enabled
+	 * is not enough.
+	 * Check phydev->wol_enabled.
+	 */
+	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+
+	phy_ethtool_get_wol(phydev, &wol);
+	if (wol.wolopts) {
+		phydev_warn(phydev, "Phy and mac wol are not compatible\n");
+		return false;
+	}
+
 	/* As long as not all affected network drivers support the
 	 * wol_enabled flag, let's check for hints that WoL is enabled.
 	 * Don't suspend PHY if the attached netdev parent may wake up.
-- 
2.45.2


