Return-Path: <netdev+bounces-159384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1AEA155D8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B328F7A4AAC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA01A0BDB;
	Fri, 17 Jan 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lfQRcf4M"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A71A239F;
	Fri, 17 Jan 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135421; cv=none; b=biAAb4/bpuv6854DeKtzYoYZsEFyl/I4jpUKAi67KKrI+VpDIWPlZw0jz8mjBt0vx+J8faZW8K6creQFqIMv+uYYb04xfB3C7lzUbe82CKj2UT1kS1uekDlJOAO9gD6FLKAZDEPTV/V28Narcb9Af3B/jW2HKtcq1ICmLEGh6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135421; c=relaxed/simple;
	bh=d8WQchQlANQhIMdsoo8xXU0d6OB8RCTcmltw+Gl2Ncc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a/X+KX15c3O6GOOyGszlubErp6tekrmOR8tGfAAnwI1rMgCScNWgAyoU1v+16oQPV4SsGT9NWU63q0hcn3r1NylEWlSt8dRrAup2M7dCCBpaW47O/ou93S13xIch2PJWdeM9LAQWVtRd16gxCsDkqqp5iCTgjXwmMH0UsvUmXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lfQRcf4M; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACBDE60003;
	Fri, 17 Jan 2025 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737135416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ne4f4mP67u3AZLSxFOKlfoi1xjfft9ILWQZ7yv01rtY=;
	b=lfQRcf4MYS6gEVjVaMjHWiVOqk8dEaqD2V2oraJvCUm57yfxgJal09epUfUxtIX7to71XE
	Nm2Dkb2iwgRyk5LjSvBYjm8xp1W6myK/VNLR50tX6DYn4YjvfX2I2VjjklX91NGbm1rWnr
	rY3c1CX8reFzavlS8DabjvGI/XXq74ah10co7+2c/fg3wmGhL19mqai1xhDJnVX4HK5WnS
	GM5A5r46dNhNC3MMqc70ogW+OKT1tO7j2ldtoCheH7fTdEOV5W+EyIRWp/091kvG9gXc1R
	kg89szrigCA4QdjQDcB9PWa2dWkPjDnq80Z+ebFZTZQgU55xzDqKbUqGLdKIFg==
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
Subject: [PATCH net-next v2] net: phy: Fix suspicious rcu_dereference usage
Date: Fri, 17 Jan 2025 18:36:44 +0100
Message-Id: <20250117173645.1107460-1-kory.maincent@bootlin.com>
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


