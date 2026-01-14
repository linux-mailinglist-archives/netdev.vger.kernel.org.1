Return-Path: <netdev+bounces-249957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9722FD21A49
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAFD130060C3
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB83B52E3;
	Wed, 14 Jan 2026 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CtQiYFSP"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9F357A31
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430654; cv=none; b=cI9s5qlh7tgrVZYSs0NS8NwNqduRfI9LEuEuc9ZTb1T7I8K7BYsL9feVeR+8C7ivzX5rb3BGYjbNLHwH888jLNU1X9fztO0gyn656bNKMGD6U6uOvBIydvxfUpUurp2O32WHjj300NYdDBPA339cNTkJCxKbTL9qhHmB9WzkQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430654; c=relaxed/simple;
	bh=Lv253Vhdyqoq3A5npjLCB56uuIiWXMDJHNoJItx2n8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvYl2tm1JdqNX+UivDHqdDgJjwW+TOzFvSisyorWrOxoEl6UmvSWTonZP+/DhH5DSajWUKcU8EbQ3tpUnUX469ukwPZaYiqjdrE1XDCADZG637nbkaGm33ScJdEhCIvBOYIZ3rNn0dQ4Sln3p1XeQsSMhcLcTs71MtIevNh3erY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CtQiYFSP; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768430643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s55j+wTSPH7nHnij6DJE35wc9T6tk2CJ+DwpAtHo/e0=;
	b=CtQiYFSP+Wd5VBxdHzgMoEzEK0rrVtL/es+iSmbk9bg2RyalLL0p89Tx8Rjks0oKrIv2fp
	J8dcauybSqwXpm4ogZunFcBRnLJWoM0KkekE/bs6cs5M0foxd8J/PUzScoX5FmQnFU6nwX
	c+oOZTxEDtNGB+HaLEplsutMAqSioOI=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 1/2] net: remove legacy way to get/set HW timestamp config
Date: Wed, 14 Jan 2026 22:44:13 +0000
Message-ID: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With all drivers converted to use ndo_hwstamp callbacks the legacy way
can be removed, marking ioctl interface as deprecated.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 net/core/dev_ioctl.c | 60 ++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 53a53357cfef..7a8966544c9d 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -287,7 +287,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	int err;
 
 	if (!ops->ndo_hwtstamp_get)
-		return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */
+		return -EOPNOTSUPP;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
@@ -414,7 +414,7 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	}
 
 	if (!ops->ndo_hwtstamp_set)
-		return dev_eth_ioctl(dev, ifr, SIOCSHWTSTAMP); /* legacy */
+		return -EOPNOTSUPP;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
@@ -438,48 +438,23 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	return 0;
 }
 
-static int generic_hwtstamp_ioctl_lower(struct net_device *dev, int cmd,
-					struct kernel_hwtstamp_config *kernel_cfg)
-{
-	struct ifreq ifrr;
-	int err;
-
-	if (!kernel_cfg->ifr)
-		return -EINVAL;
-
-	strscpy_pad(ifrr.ifr_name, dev->name, IFNAMSIZ);
-	ifrr.ifr_ifru = kernel_cfg->ifr->ifr_ifru;
-
-	err = dev_eth_ioctl(dev, &ifrr, cmd);
-	if (err)
-		return err;
-
-	kernel_cfg->ifr->ifr_ifru = ifrr.ifr_ifru;
-	kernel_cfg->copied_to_user = true;
-
-	return 0;
-}
-
 int generic_hwtstamp_get_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_get) {
-		int err;
-
-		netdev_lock_ops(dev);
-		err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
-		netdev_unlock_ops(dev);
+	if (!ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
 
-		return err;
-	}
+	netdev_lock_ops(dev);
+	err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
+	netdev_unlock_ops(dev);
 
-	/* Legacy path: unconverted lower driver */
-	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
+	return err;
 }
 EXPORT_SYMBOL(generic_hwtstamp_get_lower);
 
@@ -488,22 +463,19 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_set) {
-		int err;
-
-		netdev_lock_ops(dev);
-		err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
-		netdev_unlock_ops(dev);
+	if (!ops->ndo_hwtstamp_set)
+		return -EOPNOTSUPP;
 
-		return err;
-	}
+	netdev_lock_ops(dev);
+	err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+	netdev_unlock_ops(dev);
 
-	/* Legacy path: unconverted lower driver */
-	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
+	return err;
 }
 EXPORT_SYMBOL(generic_hwtstamp_set_lower);
 
-- 
2.47.3


