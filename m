Return-Path: <netdev+bounces-221537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46633B50C0D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B6E3B485F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1142475CB;
	Wed, 10 Sep 2025 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WMK0M89V"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32533FFD;
	Wed, 10 Sep 2025 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473169; cv=none; b=NX7A1+F4y7pu18MAaPECdw73rw9JuuAHlqJ61m16kl11z5j85da/WOwApsChsZ9rSveJCsSMXO2Y+Q0zp31Srus6VZdy1L8Od/xE+CLskEiT/Mb9ZFNB3S+U2ipXupQMPoIpFHdxthk52tXcyuzM0Jh1gWFBKoCMjs3sWs5z714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473169; c=relaxed/simple;
	bh=BDgMoKfVttykmFPcqe1sdXgvBb74aCDVm+ce86zB0Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHZQmk1UUoJtvAw8Yd+VzKiIRvwvV10hbKGSC1gtuiJdsf0m4ykbHymB2b8exzhkB8ON1WyLPCGENHKwa/v7O/cxvGNFIpCIG5ar7Dtg5RB7yidFHc/kWYcAlEhznBBvIUanzYvfXhL1jvkY74mJLHD8JvIJlEDbGU5AjNJF6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WMK0M89V; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Qt
	pvTnbjdg3T3CsipIEVSIE35SUoMb8oPYJvdXdABJM=; b=WMK0M89V+q/ZAj0JD1
	K86bFF8OzPo6rZ89KalS6KjqzYS/OH2l9nbnx6bDxd1RARBOY1fUl3qWGlLFysiK
	qcHp6dqW7ARkY2Orur70KMTnLJGXZNV7OIAOV4ASDRG6cWWAe451oL3rZypxejoZ
	8myo+BfNUN5vPWnrJvGnjJjbA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v3BU6cBos1WWAA--.34149S2;
	Wed, 10 Sep 2025 10:58:28 +0800 (CST)
From: yicongsrfy@163.com
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yicong@kylinos.cn
Subject: [PATCH] net: phy: avoid config_init failure on unattached PHY during resume
Date: Wed, 10 Sep 2025 10:58:26 +0800
Message-Id: <20250910025826.3484607-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v3BU6cBos1WWAA--.34149S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWxKF48Gw13GrykXr1UZFb_yoW8WF17pF
	48XF95ZryIqa1xGw4rZw48Aa45ZwsFy3y3Kw1fK39Y9FyUXFyDur9xtFy3A398GFWUXay3
	ZF1DAay3CayDGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnUUUUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFBqv22ilJZHD1gACsU

From: Yi Cong <yicong@kylinos.cn>

When resuming a PHY device that is not attached to a MAC (i.e.
phydev->attached_dev is NULL), mdio_bus_phy_resume() may call into
phy_init_hw() -> phydev->drv->config_init(), which can return -EOPNOTSUPP
(-95) if the driver does not support initialization in this state.

This results in log messages like:
[ 1905.106209] YT8531S Gigabit Ethernet xxxxmac_mii_bus-XXXX:00:01:
PM: dpm_run_callback(): mdio_bus_phy_resume+0x0/0x180 [libphy] returns -95
[ 1905.106232] YT8531S Gigabit Ethernet xxxxmac_mii_bus-XXXX:00:01:
PM: failed to resume: error -95

In practice, only one PHY on the bus (e.g. XXXX:00:00) is typically
attached to a MAC interface; others (like XXXX:00:01) are probed but
not used, making such resume attempts unnecessary and misleading.

Add an early return in mdio_bus_phy_resume() when !phydev->attached_dev,
to prevent unneeded hardware initialization and avoids false error reports.

Fixes: 611d779af7ca ("net: phy: fix MDIO bus PM PHY resuming")
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7556aa3dd7ee..e8b4be967832 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -373,6 +373,9 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 	struct phy_device *phydev = to_phy_device(dev);
 	int ret;
 
+	if (!phydev->attached_dev)
+		return 0;
+
 	if (phydev->mac_managed_pm)
 		return 0;
 
-- 
2.25.1


