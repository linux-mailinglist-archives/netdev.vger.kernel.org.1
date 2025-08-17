Return-Path: <netdev+bounces-214357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF531B2910B
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A787C4E806F
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C567082F;
	Sun, 17 Aug 2025 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U6K9Jt/O"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E22B665;
	Sun, 17 Aug 2025 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755391228; cv=none; b=fce6SAZ/BR2TM7OQXcwxJrioMB47WVzUilOYldQhHxfQ1tvXyDm8AYZRydaEpsPmQfhT3CKAc3Qb/JPg0WbBwW1IjkVarXP3ZBZmYsecQdTaX0Fa3P9jixXdNcIe5ZrR45RhDMyWWWrol4ZMqkBu3beJgRMgSnuo79idc5LDvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755391228; c=relaxed/simple;
	bh=SYSf3xnc7zAMoFCLHwjiYQSb+HCoNuTd/lwQn8+geW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8zHek3GYcxB4U/iHyHcjs3FeZ42Q6oxWUOGO+iIydRSruGr0X9CkIWTvVLJB6+pUexwyeIaP7iOZMabmZO9pw46TmPi9jLs1/Ax5gxpQkOLWd85V05l0ipvDw8CrOPafUt9yqmxs+pP+5Lk46pZHl09AHSscGZ5E0Iy+aZ+39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U6K9Jt/O; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gy
	S0BF4N7kb4dNNguU2QXnvUxcXRJcFEexZ/e1tAMcw=; b=U6K9Jt/OTvq+gtX4Yd
	MZIzZGMJKG/+TL7hZmpSqF/xBl7821QUn2tMiYnwZTTpkJZ6RmZemMT5NYYq6jfO
	WsuLM9cHczoLzGTDMvwzRgbcYo+aawoo7ZX/n6ayD8OGRYfnZKG5dazWkYZo3mhO
	rYCDRsHymN4pFS68ddjqMIl9k=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3Xzi+JKFoenr+CQ--.51539S2;
	Sun, 17 Aug 2025 08:39:35 +0800 (CST)
From: luoguangfei <15388634752@163.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	15388634752@163.com
Subject: [PATCH] net: macb: fix unregister_netdev call order in macb_remove()
Date: Sun, 17 Aug 2025 08:39:25 +0800
Message-ID: <20250817003925.3362-1-15388634752@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Xzi+JKFoenr+CQ--.51539S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1fXrW3WFyrur47AFWUArb_yoW8Ww48pw
	43GFyfWryIqrsFyws7Xa1UJFy5Ga47t348Wa4xu393Z39IkryqyrWjkFy8uFy5GrZrAFWa
	yr15AasxAa1kAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJKsUUUUUU=
X-CM-SenderInfo: jprvjmqywtklivs6il2tof0z/1tbiEBWsn2ihHnZTpgAAsi

When removing a macb device, the driver calls phy_exit() before
unregister_netdev(). This leads to a WARN from kernfs:

  ------------[ cut here ]------------
  kernfs: can not remove 'attached_dev', no directory
  WARNING: CPU: 1 PID: 27146 at fs/kernfs/dir.c:1683
  Call trace:
    kernfs_remove_by_name_ns+0xd8/0xf0
    sysfs_remove_link+0x24/0x58
    phy_detach+0x5c/0x168
    phy_disconnect+0x4c/0x70
    phylink_disconnect_phy+0x6c/0xc0 [phylink]
    macb_close+0x6c/0x170 [macb]
    ...
    macb_remove+0x60/0x168 [macb]
    platform_remove+0x5c/0x80
    ...

The warning happens because the PHY is being exited while the netdev
is still registered. The correct order is to unregister the netdev
before shutting down the PHY and cleaning up the MDIO bus.

Fix this by moving unregister_netdev() ahead of phy_exit() in
macb_remove().

Signed-off-by: luoguangfei <15388634752@163.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce55a1f59..7bbb674d5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5407,11 +5407,11 @@ static void macb_remove(struct platform_device *pdev)
 
 	if (dev) {
 		bp = netdev_priv(dev);
+		unregister_netdev(dev);
 		phy_exit(bp->sgmii_phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
-		unregister_netdev(dev);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.43.0


