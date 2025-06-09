Return-Path: <netdev+bounces-195750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9FAD227A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC77F3A85FA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B51F3FED;
	Mon,  9 Jun 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RdJfvjGU"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222181FBE80
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483120; cv=none; b=TXzZh2EhxwAyGjK9KReqEd23iWHw2P8Arby4EeevtJQAQMvtH5Vr1SMt+pYAM4fU5kuBlbf94ypz95KSscJbizpin7ksseObN/gmyhNp4Dki+lmj8+HQhO+gBLQUJD7EUja4nQoM4ptvSqFNd65467IXePYZOnCzD7jHFJVsW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483120; c=relaxed/simple;
	bh=dV9ocoa0PcpeTm/G8g/EfUy7y6M/jyd61EQotUF2MOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=UZGrtWlPkzryFB/Qza/4Hq+YdSAZEywcfyBhrwKQ6UXzx5CHy9JPPpwf8aHrAW+8pqumqiI8wj2VEYFtLyAZOu+ONLvhkR1jR8o4NxZpc3lj4yevVLAR6Dmwd/cH/r8JTxjYU/Fyee925eOr1y7Ys2390rYqS0ErCSJwbuTyoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RdJfvjGU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250609153156euoutp016cc7114117d55f31634b64ccf9b58ba0~HaaASYWJL2305223052euoutp01k
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:31:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250609153156euoutp016cc7114117d55f31634b64ccf9b58ba0~HaaASYWJL2305223052euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749483116;
	bh=ffW9nNUAtcbBjg01JUeoB8jBeRlx3RPs8ZTJ8M6WXgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdJfvjGUtvEbjC3/ik52dUxf4yoyDgG1jMs7r1y/VnwQiDeY22QelcUay+fqSWiBZ
	 /G6OyieuJKgK4nATBTbNjiAWLwoXSi/Uz23kMPkB5+xxSqLOtmphQRwWMugXcHgGLx
	 +VOpT0KLV5AcUvLOqWGEMkbjB+zih4lK/bJxMxsU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250609153156eucas1p2cf6399b609395de4d4a33b0cf6b4c15d~HaZ-4BTic0658406584eucas1p2P;
	Mon,  9 Jun 2025 15:31:56 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250609153155eusmtip2ec90ce94e7020726023fcb3f8bbf992d~HaZ-kkFr40427204272eusmtip2-;
	Mon,  9 Jun 2025 15:31:55 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>, Wenjing Shan <wenjing.shan@samsung.com>
Subject: [PATCH 2/2] net/mdiobus: Fix potential out-of-bounds clause 45
 read/write access
Date: Mon,  9 Jun 2025 17:31:47 +0200
Message-Id: <20250609153147.1435432-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609153147.1435432-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250609153156eucas1p2cf6399b609395de4d4a33b0cf6b4c15d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250609153156eucas1p2cf6399b609395de4d4a33b0cf6b4c15d
X-EPHeader: CA
X-CMS-RootMailID: 20250609153156eucas1p2cf6399b609395de4d4a33b0cf6b4c15d
References: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
	<20250609153147.1435432-1-j.raczynski@samsung.com>
	<CGME20250609153156eucas1p2cf6399b609395de4d4a33b0cf6b4c15d@eucas1p2.samsung.com>

When using publicly available tools like 'mdio-tools' to read/write data
from/to network interface and its PHY via C45 (clause 45) mdiobus,
there is no verification of parameters passed to the ioctl and
it accepts any mdio address.
Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
but it is possible to pass higher value than that via ioctl.
While read/write operation should generally fail in this case,
mdiobus provides stats array, where wrong address may allow out-of-bounds
read/write.

Fix that by adding address verification before C45 read/write operation.
While this excludes this access from any statistics, it improves security of
read/write operation.

Fixes: 4e4aafcddbbf ("net: mdio: Add dedicated C45 API to MDIO bus drivers")
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
---
 drivers/net/phy/mdio_bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 60fd0cd7cb9c..fda2e27c1810 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -541,6 +541,9 @@ int __mdiobus_c45_read(struct mii_bus *bus, int addr, int devad, u32 regnum)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->read_c45)
 		retval = bus->read_c45(bus, addr, devad, regnum);
 	else
@@ -572,6 +575,9 @@ int __mdiobus_c45_write(struct mii_bus *bus, int addr, int devad, u32 regnum,
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->write_c45)
 		err = bus->write_c45(bus, addr, devad, regnum, val);
 	else
-- 
2.34.1


