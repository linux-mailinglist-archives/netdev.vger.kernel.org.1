Return-Path: <netdev+bounces-214791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD7B2B4C4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5366F16E8C2
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0752264B0;
	Mon, 18 Aug 2025 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A9EOX86d"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E631F1932;
	Mon, 18 Aug 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559694; cv=none; b=g1G0KQ7w7NOgoqmjhnengNzSvtT3ffy1LTKw0oWmYnqmPkuyfDSdAXf3ZlkI5ocBM5ZWNUq1fzZr2QFAnsal+Bs62D4wVm/KpeOQ3qOuQGB1F6DAktinSob7vaLIQZLIhiK8wZpFdWZhFqNIhmaWsikARSnrvGeNDk90Cv3x0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559694; c=relaxed/simple;
	bh=qWU5jKZb9in6UgtT2b/F4r0PzCZrNnHxBos+Lj7LMD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J30M2NYL9WZXY8bMzm+UYSZxoUHoCIaoIR8ohAv/k5BzbxDhlXB6E4ddWopGDUNjJLc7k3dCukjEF7XzmbfN2ausXe1V/1HdOhz8M9IBA9yZ2Mc9DFWfhlDcWb3vziSdfuHfbXQQ0RCYh08lVhftVmKEFDFmr+TxOIKNHqptNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A9EOX86d; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/i
	z/xnD8uPClOoozqxGllgCqbDdwjuuBB3H3lArHsUo=; b=A9EOX86dEh9/qHSGTK
	FPdXgxdqwMrWjI+dBsrPaPpBUF3U2SHBhNc06zt3K81EwjkGzvn6Z5llQqcm1qsC
	Ekq6i2/eVqP+uyhZglyY3ZWoeeceDf1nVS1n5k8+rFiycl+DIj0FLopJ+TN+Qp1Q
	8YhCTV2eyFbukL1DyIZeFnuFI=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnt2hstqNotTBVCw--.32213S2;
	Tue, 19 Aug 2025 07:25:44 +0800 (CST)
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
Subject: [PATCH] net: macb: fix unregister_netdev call order in macb_remove() [v2]
Date: Tue, 19 Aug 2025 07:25:27 +0800
Message-ID: <20250818232527.1316-1-15388634752@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt2hstqNotTBVCw--.32213S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1fXrW3WFyrur47AFWUArb_yoW8AF43pw
	43CFyfWryIqr4qvws7Xa1UJFy5Ca47t348Wa4xurZ3Z392kw1qyFW0kFy8u345GFZrAFWa
	yr1Yya9xAa1kCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piBWlDUUUUU=
X-CM-SenderInfo: jprvjmqywtklivs6il2tof0z/xtbBMRKtn2ijpe73zgAAso

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

Fixes: 8b73fa3ae02b ("net: macb: Added ZynqMP-specific initialization")
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


