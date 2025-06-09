Return-Path: <netdev+bounces-195749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD5CAD2279
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FBF3A7A85
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1E199396;
	Mon,  9 Jun 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="npNPRjDz"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87226175D53
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483117; cv=none; b=FQ2670W6hYzanjQasDFPjARgTcKubia6o29fKEJoNbwgH8pVNRF9G53QGIJGrurv9Wg/Fgmi5tzfnngBOS2m9IMI5r6sXCTTc6Izwu4NDpbWNE2SSAbesUTzlbH1enajSjhjslO7Xo5lcFEgfQ91j0f/jfeGP1tGtmKAggfi0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483117; c=relaxed/simple;
	bh=xZWJ7DeAB8U98hOrncXa2h5Zd9gSYSnW04hRz1dwWwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=PeMzjtGfyz5zDrgW+359RZiB0Lbp5akjUXnrw9JbP4TvA2PzBWzuEmUxCo29Pe3TTzBluU4Gtr+pTjFeE2sP8bnXKTHaJefiWkDRGZl2z+OT5HNpNV7KrLmHo0tygVoGFYjaOmt2l0aCVSJPQVqPjTuUmCVDaNaBaSg/yqGUSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=npNPRjDz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250609153151euoutp01a6dcc70846036d9202b728c0fb8ce1d9~HaZ70wf0o2305223052euoutp01i
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:31:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250609153151euoutp01a6dcc70846036d9202b728c0fb8ce1d9~HaZ70wf0o2305223052euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749483111;
	bh=yQiQtkLtTYnohEeuNL15/EQgRaVP0IhcScwxaKjceVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npNPRjDz6TJL/SkjQNkr3xlr+ne2TRQlIcmJqnQ+W2mXkRAuuKHFNC1btFIxPmLpm
	 kAODWDMtQc3ACQ6Q2f6/38vt/KAy48j0vkFVTAheQCKirPB1jaSi6o0PtlSprVdFA/
	 Jdfnnzbt2jVwsgr3VCQ1INpYYmpBIDYtihiRf5do=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250609153151eucas1p12def205b1e442c456d043ab444418a56~HaZ7jhU8G0051200512eucas1p13;
	Mon,  9 Jun 2025 15:31:51 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250609153151eusmtip29f968ccef250c40272847e40a52f9dee~HaZ7P05200319703197eusmtip2U;
	Mon,  9 Jun 2025 15:31:51 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>, Wenjing Shan <wenjing.shan@samsung.com>
Subject: [PATCH 1/2] net/mdiobus: Fix potential out-of-bounds read/write
 access
Date: Mon,  9 Jun 2025 17:31:46 +0200
Message-Id: <20250609153147.1435432-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250609153151eucas1p12def205b1e442c456d043ab444418a56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250609153151eucas1p12def205b1e442c456d043ab444418a56
X-EPHeader: CA
X-CMS-RootMailID: 20250609153151eucas1p12def205b1e442c456d043ab444418a56
References: <aEb2WfLHcGBdI3_G@shell.armlinux.org.uk>
	<CGME20250609153151eucas1p12def205b1e442c456d043ab444418a56@eucas1p1.samsung.com>

When using publicly available tools like 'mdio-tools' to read/write data
from/to network interface and its PHY via mdiobus, there is no verification of
parameters passed to the ioctl and it accepts any mdio address.
Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
but it is possible to pass higher value than that via ioctl.
While read/write operation should generally fail in this case,
mdiobus provides stats array, where wrong address may allow out-of-bounds
read/write.

Fix that by adding address verification before read/write operation.
While this excludes this access from any statistics, it improves security of
read/write operation.

Fixes: 080bb352fad00 ("net: phy: Maintain MDIO device and bus statistics")
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
---
 drivers/net/phy/mdio_bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a6bcb0fee863..60fd0cd7cb9c 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -445,6 +445,9 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->read)
 		retval = bus->read(bus, addr, regnum);
 	else
@@ -474,6 +477,9 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->write)
 		err = bus->write(bus, addr, regnum, val);
 	else
-- 
2.34.1


