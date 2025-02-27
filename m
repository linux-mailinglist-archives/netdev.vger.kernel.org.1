Return-Path: <netdev+bounces-170417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A60A48A64
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B5D16BAB0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9E26FA68;
	Thu, 27 Feb 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="ttXPsNU/"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99788BEC
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691452; cv=none; b=FQXBDTyf8tUV6CBiO3i2eKPDL13OMO1DnKoybhIAs1I1NDiJgdII41r1GrjlOFgkt6Bl0yXLdiJ6FdRw9Dcl21FjbauqNPmtnSrT0SJpK7s+9nw9otufMPDoor4fY8H/7uvAk9zRDd+EBM7gadkWKj+4byO5Z4nVlFO+ofDc6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691452; c=relaxed/simple;
	bh=DXVDL52IDy2bsv4umiZa3Wy8xZbthByYhPv70isl2jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nyyLmuhh3nejBcEJTNB7uT7YwrPS4YDYUy6Waa5fY2SkZI9MMLSVSRs+l7kMJuitST4C2qPu20qCPhUQpQTzOWyMOi6xX+bY1dRvWpNnHSqPZwib4/bnTBcokWrQJJnFvD/7rae5YVeTDFS1LhqFap5V6012jiYPiil5Jd97HrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=ttXPsNU/; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AsaFwa7674FPCsMttkAFNCjFnUSMFGvCzZoYoUT2nTY=; b=ttXPsNU/VKqbgQWpFqc6By9C5V
	VQNyofGUTj2798rteQ/tCElCK8je/NAvVABUjl3cVZ/MjGqDAJIe6phmQc2nfaQFx5Nr/p8jU3VDv
	bvRKUgBLwAUbzELJRWeH1P8pXPdte8kOfY1v9s+0x1jJSuaexYukl2cwToTkbz9QHxbQ=;
Received: from [88.117.55.1] (helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tnkXl-000000000iA-3ycy;
	Thu, 27 Feb 2025 21:31:42 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v9 0/8] Support loopback mode speed selection
Date: Thu, 27 Feb 2025 21:31:30 +0100
Message-Id: <20250227203138.60420-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Previously to commit 6ff3cddc365b ("net: phylib: do not disable autoneg
for fixed speeds >= 1G") it was possible to select the speed of the
loopback mode by configuring a fixed speed before enabling the loopback
mode. Now autoneg is always enabled for >= 1G and a fixed speed of >= 1G
requires successful autoneg. Thus, the speed of the loopback mode depends
on the link partner for >= 1G. There is no technical reason to depend on
the link partner for loopback mode. With this behavior the loopback mode
is less useful for testing.

Allow PHYs to support optional speed selection for the loopback mode.
This support is implemented for the generic loopback support and for PHY
drivers, which obviously support speed selection for loopback mode.
Additionally, loopback support according to the data sheet is added to
the KSZ9031 PHY.

Extend phy_loopback() to signal link up and down if speed changes,
because a new link speed requires link up signalling.

Use this loopback speed selection in the tsnep driver to select the
loopback mode speed depending the previously active speed. User space
tests with 100 Mbps and 1 Gbps loopback are possible again.

v9:
- move struct net_test member loopback_speed to correct commit
- fix argument of net_selftest_set_get_count() dummy (kernel test robot)
- fix argument of net_selftest_set_get_strings() dummy (kernel test robot)

v8:
- align naming and kdoc of selftest set enum (Jakub Kicinski)
- add support for all link speeds (Jakub Kicinski)

v7:
- simplify ksz9031_set_loopback() (Andrew Lunn)
- try to restore link if loopback enable fails (Andrew Lunn)
- extend generic selftests to enable reuse (Andrew Lunn)

v6:
- add return value documentation to phy_loopback() (Jakub Kicinski)

v5:
- use phy_write() instead of phy_modify() (Russel King)
- add missing inline for export dummies (kernel test robot)

v4:
- resend without changed to RFC v3

RFC v3:
- align set_loopback() of Marvell to Micrel (Andrew Lunn)
- transmit packets in loopback selftests (Andrew Lunn)
- don't flush PHY statemachine in phy_loopback()
- remove setting of carrier on and link mode after phy_loopback() in tsnep

v2:
- signal link up to keep MAC and PHY in sync about speed (Andrew Lunn)

Gerhard Engleder (8):
  net: phy: Allow loopback speed selection for PHY drivers
  net: phy: Support speed selection for PHY loopback
  net: phy: micrel: Add loopback support
  net: phy: marvell: Align set_loopback() implementation
  tsnep: Select speed for loopback
  net: selftests: Support selftest sets
  net: selftests: Add selftests sets with fixed speed
  tsnep: Add loopback selftests

 drivers/net/ethernet/engleder/tsnep_main.c    |  21 +-
 .../net/ethernet/engleder/tsnep_selftests.c   |  30 ++-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |   2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |   8 +-
 drivers/net/phy/adin1100.c                    |   5 +-
 drivers/net/phy/dp83867.c                     |   5 +-
 drivers/net/phy/marvell.c                     |  68 +++---
 drivers/net/phy/micrel.c                      |  24 ++
 drivers/net/phy/mxl-gpy.c                     |  11 +-
 drivers/net/phy/phy-c45.c                     |   5 +-
 drivers/net/phy/phy.c                         |  87 +++++++
 drivers/net/phy/phy_device.c                  |  43 +---
 drivers/net/phy/xilinx_gmii2rgmii.c           |   7 +-
 include/linux/phy.h                           |  18 +-
 include/net/selftests.h                       |  29 +++
 net/core/selftests.c                          | 216 +++++++++++++-----
 18 files changed, 417 insertions(+), 170 deletions(-)

-- 
2.39.5


