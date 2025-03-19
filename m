Return-Path: <netdev+bounces-176080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EAFA68A70
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B730884188
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD13255E38;
	Wed, 19 Mar 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zo/O0EGe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5516254AE4;
	Wed, 19 Mar 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381904; cv=none; b=QHoxJG/CTJVVsh5Wmuwtcvg+iRa37blaFrlCtAyShsXGI03pqoHzJtMCGS303lDVB1h1wPTNb5P+GYttVRWE13QNpaewMwYzS3avdE6aaOwqGk4wlytmLx1fZEnNd8RY7dutmbWolEpNdzsHvsjIyhKJUeJo56zu9OdDhCrdsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381904; c=relaxed/simple;
	bh=GxnJ9WEx2Cn71o4Gu2M9LzY2aDcJeActAGo04ysFpJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXfuex7cBFd7tfTRqrH2qVreVRlU9l4SKC2hHm63P73oqgJng00cj/9QMetypr+V+OzPAaYLj3gH4xC7C8NDXI9J5jvBdf3XtJavHFhIWa14CU2AfVZ4/wLiK6qNgia/pTkfSKKjnPy8NFMa1yPIpKER/K83N7GwsK+fG5j9HYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zo/O0EGe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381903; x=1773917903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GxnJ9WEx2Cn71o4Gu2M9LzY2aDcJeActAGo04ysFpJk=;
  b=Zo/O0EGelsGVeuMFQDhmU8gg1ejLv4ujNAj4nj4HRTSTiWoeJZvAGFLU
   uo2uxkaiMTSOIjF6Ap2lFuIsUnkgr1pglRsTfROhdGQRodS7PqbXW1Ber
   XyNxCvq1j3dKg81jICDTPgo6b//wuyt20AN1EBhLH9PLTShm1uO3chF4Q
   DhV8j60vRMdi1RZIOiBGWxRoGbpVbt6sjA9e5pZbvLotRcaGWaHB0sD1G
   38F2fgTj2eoHDQp5KiAa4OM/k3E42wayMrDA2+wJyIiY2bFANjdFymKx0
   HhIzOCLxNt6D8gBBiYmYIEdKpgnKWauqI2LrvSqY0BMpWyLq0yng3Q6MZ
   w==;
X-CSE-ConnectionGUID: NqKNk5thQ8SVBTFLoZj6rQ==
X-CSE-MsgGUID: NErVRCscQRWU0WZ8q2KGmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43296782"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43296782"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:58:20 -0700
X-CSE-ConnectionGUID: Nn4CBZcdQ7KVrVQy2ijmwA==
X-CSE-MsgGUID: snY9lz5mQii9MO9dqwRlJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122593882"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 19 Mar 2025 03:58:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AAFFF2A2; Wed, 19 Mar 2025 12:58:15 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v2 2/2] net: usb: asix: ax88772: Increase phy_name size
Date: Wed, 19 Mar 2025 12:54:34 +0200
Message-ID: <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC compiler (Debian 14.2.0-17) is not happy about printing
into a short buffer (when build with `make W=1`):

 drivers/net/usb/ax88172a.c: In function ‘ax88172a_reset’:
 include/linux/phy.h:312:20: error: ‘%s’ directive output may be truncated writing up to 60 bytes into a region of size 20 [-Werror=format-truncation=]

Indeed, the buffer size is chosen based on some assumptions, while
in general the assigned name might not fit. Increase the buffer to
cover maximum length of the parameters. With that, change snprintf()
to use sizeof() instead of hard coded number.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/usb/ax88172a.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index e47bb125048d..df00c62dd538 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -18,7 +18,7 @@
 struct ax88172a_private {
 	struct mii_bus *mdio;
 	struct phy_device *phydev;
-	char phy_name[20];
+	char phy_name[MII_BUS_ID_SIZE + 3];
 	u16 phy_addr;
 	u16 oldmode;
 	int use_embdphy;
@@ -210,7 +210,10 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	ret = asix_read_phy_addr(dev, priv->use_embdphy);
 	if (ret < 0)
 		goto free;
-
+	if (ret >= PHY_MAX_ADDR) {
+		netdev_err(dev->net, "Invalid PHY ID %x\n", ret);
+		return -ENODEV;
+	}
 	priv->phy_addr = ret;
 
 	ax88172a_reset_phy(dev, priv->use_embdphy);
@@ -308,7 +311,7 @@ static int ax88172a_reset(struct usbnet *dev)
 		   rx_ctl);
 
 	/* Connect to PHY */
-	snprintf(priv->phy_name, 20, PHY_ID_FMT,
+	snprintf(priv->phy_name, sizeof(priv->phy_name), PHY_ID_FMT,
 		 priv->mdio->id, priv->phy_addr);
 
 	priv->phydev = phy_connect(dev->net, priv->phy_name,
-- 
2.47.2


