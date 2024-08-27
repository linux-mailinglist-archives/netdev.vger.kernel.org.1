Return-Path: <netdev+bounces-122200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA0960581
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F52281D67
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457E1990CF;
	Tue, 27 Aug 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FtWC3wZO"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D11805A;
	Tue, 27 Aug 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750804; cv=none; b=RWnE1a1UXNSYuQ9lP1CXWyKuZJAzr0pmEHx5zF+EGvjpFBsbrHNw5piP5os/mkCwcgqp8oi0tTplvsJf3TWe2X5B5MgIRIr5lRdkQCoEaNl9mapuj+vL1NP7ry6zvHW4MqsBMWC78yqJhmb1fXW9SoQ/7y6qC+m0BUdUO3Dou44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750804; c=relaxed/simple;
	bh=YgAbzv/H3Q/4IbRXM2+ZQEXSnn2PCcFCzZtP9nPCDuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c4+lbdE6V3N9D1tlVZeiw6iVnEJ0XzHtIeYCZTue/uP6yWkr/4MV+6bEi68TlvBvZZvTq8HPJlx1wYyTEUJJvNG1XN37KZ8nNJUPjFLwIEUo2EEfjJ+hX75Teviy96D3IzzSPVIgSjzm1mTTGJqEALL2ELFolFEK+jcCmK0SCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FtWC3wZO; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724750702;
	bh=i/GhOJ1ZFKQZVMyhTBSSDfXEgmelEXII6z8pE8AqzR0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FtWC3wZOaSHmArsC1pZHX8L4TWdP7Fvw7v7aGT71bhdu6tZvOfngeSWGKPkXu0SVj
	 o69FCJZOqUPevKKixm3hKW1fPC0I673OJpEHr4wyrubTV9FRmgjF4cSwUKR/cIe9G7
	 51hDSKEVu61lc0RjdF+9M5EU4bSxb4JZdtV/DB1M=
X-QQ-mid: bizesmtpsz8t1724750698trvfb4d
X-QQ-Originating-IP: HGW2LuQNBpMgl2zsSrSOUAQQQiujEmFCh+mE4oSmkJc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Aug 2024 17:24:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11387443622935446978
From: Wentao Guan <guanwentao@uniontech.com>
To: pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com
Subject: [RFC v2 net] net: phy: fix may not suspend when phy has WoL
Date: Tue, 27 Aug 2024 17:24:46 +0800
Message-Id: <20240827092446.7948-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0

When system suspend, and mdio_bus_phy goes to suspend,
if the phy enabled wol, phy_suspend will returned -EBUSY,
and break system suspend.

93f41e67(net: phy: fix WoL handling when suspending the PHY)
Fix the case when netdev->wol_enabled=1, but some case,
netdev->wol_enabled=0 and phydev set wol_enabled enabled,
so check phydev->wol_enabled.

I dont know why
481b5d93(net: phy: provide phy_resume/phy_suspend helpers)
think that it should return -EBUSY when WoL.

I met the case when use some out of tree ethernet driver or
phy driver.

Log:
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to freeze: error -16

v2: change warning message and fix build error.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/phy/phy_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7752e9386b40..c984f91a2c0c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -299,6 +299,18 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (netdev->ethtool->wol_enabled)
 		return false;
 
+	/* Ethernet and phy device wol state may not same, netdev->wol_enabled
+	 * disabled,and phydev set wol_enabled enabled, so netdev->wol_enabled
+	 * is not enough, so check phydev->wol_enabled.
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
2.20.1


