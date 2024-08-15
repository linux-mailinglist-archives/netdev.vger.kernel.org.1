Return-Path: <netdev+bounces-118810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8831952D37
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41C01C21002
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C31AC8A5;
	Thu, 15 Aug 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="pYAE38wW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB861AC896;
	Thu, 15 Aug 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720192; cv=none; b=qq1nXPojYjCUGIbxjsf2ELQPyUFT+MIBsBulgzoI7VHzLlpiQOZfIf54NiPjiK6FZqGSyikFyX1AmzWK9vZOfze4r7922CuWfqVwo3s9IFpA+YUC0RR0PeH1nsIv1dU1gFAEP0rsFhsbnc/KPLQ+NP3EHPqnF9DBi5zP9EK7QKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720192; c=relaxed/simple;
	bh=p8cQBsVNZQocKXPtWRwgzO1mDI9m8BaP3k7oD9RQYwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JeW5mZHpAWfPLMXdhxyEd3p1E3qjKtgVPMrMwsvSJjpZv+SxZmkZg/+Pn6IcxsOu2z0sOoUYtl/2usXBm6XY3bL4xpnTfYpjEXylK5l+xWc3DgDG9LtVeU7fEB8+QNBOuuxgTcBPdD4xblWJ3AF31wFXZ8moolUfOKidxPaPH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=pYAE38wW; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1723720163;
	bh=DetyQEvMXu5EoYCa2IX1vheCm9HvmnTOAj9m4USk9lA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pYAE38wWsyGkGgdHfy+bZzhH3KjAaeo19kjbwQYz/xeBOg75RlzmkcIxkoigb0XHN
	 N1Gr9ArpSU4IzwfXhp225cTf2TGZ8effHm8Z0qsQGM1DoxjCv+QHSKB5zA5ByIoXK8
	 Qdree1YZsQ1YCBXxQB4ahlcDveblcs6SYfbEpr3I=
X-QQ-mid: bizesmtp90t1723720159tr0cd36z
X-QQ-Originating-IP: tcQuEj9KVHFmtVeoIZiglIAKXYolPoSRabc65UNnXEg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 Aug 2024 19:09:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5852712459469230222
From: Wentao Guan <guanwentao@uniontech.com>
To: hkallweit1@gmail.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com
Subject: [RFC net] net: phy: fix may not suspend when phy has WoL
Date: Thu, 15 Aug 2024 19:09:07 +0800
Message-Id: <20240815110907.609-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1

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

Log:
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to suspend: error -16
PM: Some devices failed to suspend, or early wake event detected
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x10c returns -16
YT8531S Gigabit Ethernet phytmac_mii_bus-PHYT0046:00:07: PM: failed to freeze: error -16

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/net/phy/phy_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7752e9386b40..22bbabec229d 100644
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
+		dev_info(&dev->dev, "phy wol enabled,cannot suspend\n");
+		return false;
+	}
+
 	/* As long as not all affected network drivers support the
 	 * wol_enabled flag, let's check for hints that WoL is enabled.
 	 * Don't suspend PHY if the attached netdev parent may wake up.
-- 
2.20.1


