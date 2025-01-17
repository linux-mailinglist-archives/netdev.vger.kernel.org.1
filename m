Return-Path: <netdev+bounces-159314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11402A15160
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF747A2136
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D31FFC5B;
	Fri, 17 Jan 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NcpsGw9j"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B71FF7D2;
	Fri, 17 Jan 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123294; cv=none; b=tDURW33OqOxJvJihrhuFI8pc/gBlm87xGmbss4VyeMKn0ZsjFbDQcQWoBGKbK1298dscLx8M7OpgDhda+lz6mo0j5dneqBTAEZXFpLVkZmADByGQjfZ0yqKQ5eGe+YgzoDxjpw1JTMkWcv9nA6r965u56RBYphDVVaalJ6j+bTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123294; c=relaxed/simple;
	bh=1bOPb5VdCz4eHXjqT5fY4ekBP0H/uXTuzfMUrUK2EKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHj6ym3OmiOdBzXBEv2YSUxHaitEwl+USw8cLF9YSddxxUAWy2nGRaXt07svxkZe+58F/3ToJLBVkASYhXW2SBnEmToJpO6DlNoqMa6H1lpFfrH0G2DZLFDu6a/7/2BOzcafMZbofzEXcW59Faa19buhd+MnMNEYr9x+zMXeb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NcpsGw9j; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CC54FF809;
	Fri, 17 Jan 2025 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737123290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x0KUv8M5Gb6Z9m+QF9uSKWB3kjhkWezSSQK/wpVRB8w=;
	b=NcpsGw9j/ZWtgLymot/CGGMcU1AEAox+oCn5d5dtD4/3jE8pRO9a1I79zpIxzgy4pNKdEO
	o2UIJ3C5x2bS7eYwH0B5UpHxl6gB49UQn4B8pRJT8EZJK1z2X+lAWimhuYLReajt1CrB9i
	mzP2HHDtIBDbLZ6Zumh7ODQeFnq29s0K99kHwQuUFM/a1MjCPxApp9n2hwpr5/6XhUO94s
	7jpr4aaRcI7sZoxCdGkeAJYHPd69MjOpSADAsvx2PqHdj6lC7OJ7Hark2sqMlexxwIK55W
	xnxevBP1YvDfTtfH4mcf0IQY7BTYDhtBEqK/fCujadmONdzG7GNBMNGkBGS+6A==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
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
Subject: [PATCH net-next] net: phy: Fix suspicious rcu_dereference usage
Date: Fri, 17 Jan 2025 15:14:45 +0100
Message-Id: <20250117141446.1076951-1-kory.maincent@bootlin.com>
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

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reported-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Closes: https://lore.kernel.org/netdev/4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev/
Fixes: 35f7cad1743e ("net: Add the possibility to support a selected hwtstamp in netdevice")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/phy/phy_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5b34d39d1d52..b9b9aa16c10a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2001,12 +2001,14 @@ void phy_detach(struct phy_device *phydev)
 	if (dev) {
 		struct hwtstamp_provider *hwprov;
 
-		hwprov = rtnl_dereference(dev->hwprov);
+		rcu_read_lock()
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


