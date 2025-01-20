Return-Path: <netdev+bounces-159784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DAA16E4E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42663A2888
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC941E282D;
	Mon, 20 Jan 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dIUMfJ86"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43861E1A2D;
	Mon, 20 Jan 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382779; cv=none; b=nDGxqrE0QNLTsUzwVtPX/D/paqoNZI/Mce9qwWcb+sNW7D0jEYCk7KaKVS2xg1zl8YKM6Yp8R5z54yrIjO+pr4LvbRDOajicIso/mzEhyYfKkPD2HMbQXdDG7Ii6bYaPDjo/Tq5GhcSOSWGKSQd48+RVLjFJcgCDwS8bSwdpILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382779; c=relaxed/simple;
	bh=pVidTGCNoa4z0zvKE9RLaRKAlIgW+qfJFiG/vMITwoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cA2e4wMtvVnBe4ypUDD5CPWrlg93CCAh5Bqi7iINwA41eGOPBED+GQkK+Uroo0zFrHe33aMMYzuvYIlWqVdzsg435FHiHWW/psxpIksxSv7gHg8ZgLfpR2y8PRx+i/OEW256iV4pBZ5Q0oNH7FM9vd+q59SC2WBUxoVBHkMxlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dIUMfJ86; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 614DF20004;
	Mon, 20 Jan 2025 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737382772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0HVe5lcWJ1ICiNX7irGNyfKwXwwkX3hMUT/PxOg1fRE=;
	b=dIUMfJ86/hm1RhFt1uG2TzxOBPkqLujqXzVhs+qakXIpfkk7W9mQBVSdVY1lDfD7CtaeyA
	In4fWM7Qahsvmuu0WU/vfbqhyNdhoI9/nI73SmkHSLEm4qeBEEOVTomCWA6ytUWBgCqKmT
	7yn2sKvYNRhgvzJeLtnph82Ue+jbif5FnUrNp1s/Fs6h2Nt3+d3HpFKP8O4NG6k3R3ZLVh
	mbYqlltIPyaFCCtIFi/csn73g3rdlZWW2MSo2J2k7n2AOkEP+PYjLNmS3zusu9Poy+yYfE
	Xxj/4xSpmZ0HuMClHh84g6oZ72+O2sQukURNA0jSUBLUIB6yHNfuehIz3DcJOA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference usage
Date: Mon, 20 Jan 2025 15:19:25 +0100
Message-Id: <20250120141926.1290763-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

The phy_detach function can be called with or without the rtnl lock held.
When the rtnl lock is not held, using rtnl_dereference() triggers a
warning due to the lack of lock context.

Add an rcu_read_lock() to ensure the lock is acquired and to maintain
synchronization.

The path reported to not having RTNL lock acquired is the suspend path of
the ravb MAC driver. Without this fix we got this warning:

[   39.032969] =============================
[   39.032983] WARNING: suspicious RCU usage
[   39.033019] -----------------------------
[   39.033033] drivers/net/phy/phy_device.c:2004 suspicious
rcu_dereference_protected() usage!
...
[   39.033597] stack backtrace:
[   39.033613] CPU: 0 UID: 0 PID: 174 Comm: python3 Not tainted
6.13.0-rc7-next-20250116-arm64-renesas-00002-g35245dfdc62c #7
[   39.033623] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   39.033628] Call trace:
[   39.033633]  show_stack+0x14/0x1c (C)
[   39.033652]  dump_stack_lvl+0xb4/0xc4
[   39.033664]  dump_stack+0x14/0x1c
[   39.033671]  lockdep_rcu_suspicious+0x16c/0x22c
[   39.033682]  phy_detach+0x160/0x190
[   39.033694]  phy_disconnect+0x40/0x54
[   39.033703]  ravb_close+0x6c/0x1cc
[   39.033714]  ravb_suspend+0x48/0x120
[   39.033721]  dpm_run_callback+0x4c/0x14c
[   39.033731]  device_suspend+0x11c/0x4dc
[   39.033740]  dpm_suspend+0xdc/0x214
[   39.033748]  dpm_suspend_start+0x48/0x60
[   39.033758]  suspend_devices_and_enter+0x124/0x574
[   39.033769]  pm_suspend+0x1ac/0x274
[   39.033778]  state_store+0x88/0x124
[   39.033788]  kobj_attr_store+0x14/0x24
[   39.033798]  sysfs_kf_write+0x48/0x6c
[   39.033808]  kernfs_fop_write_iter+0x118/0x1a8
[   39.033817]  vfs_write+0x27c/0x378
[   39.033825]  ksys_write+0x64/0xf4
[   39.033833]  __arm64_sys_write+0x18/0x20
[   39.033841]  invoke_syscall+0x44/0x104
[   39.033852]  el0_svc_common.constprop.0+0xb4/0xd4
[   39.033862]  do_el0_svc+0x18/0x20
[   39.033870]  el0_svc+0x3c/0xf0
[   39.033880]  el0t_64_sync_handler+0xc0/0xc4
[   39.033888]  el0t_64_sync+0x154/0x158
[   39.041274] ravb 11c30000.ethernet eth0: Link is Down

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reported-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Closes: https://lore.kernel.org/netdev/4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev/
Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwtstamp in netdevice")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Update the commit message with the stack trace.

Changes in v2:
- Add a missing ;
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b34d39d1d52..3eeee7cba923 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2001,12 +2001,14 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		struct hwtstamp_provider *hwprov;
 
-		hwprov = rtnl_dereference(dev->hwprov);
+		rcu_read_lock();
+		hwprov = rcu_dereference(dev->hwprov);
 		/* Disable timestamp if it is the one selected */
 		if (hwprov && hwprov->phydev == phydev) {
 			rcu_assign_pointer(dev->hwprov, NULL);
 			kfree_rcu(hwprov, rcu_head);
 		}
+		rcu_read_unlock();
 
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
-- 
2.34.1


