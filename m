Return-Path: <netdev+bounces-164500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBADA2E032
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 20:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A82164E24
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922971E0DF5;
	Sun,  9 Feb 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="TrStwC52"
X-Original-To: netdev@vger.kernel.org
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45570807
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739128814; cv=none; b=PA5kPf9lv4XsTVrxhSfC+wGIG1W0FLPyOTC6nqPCYaDgZaDUT22bi6tlTu3u/cJBQgCc/U8DXudNRxwAz0Wl8olP6XEM8Cvb22/bJRfUUVPNwipBajGp+GTFUYQhaeOXezYUweboSRx5Pdv44dKCAr7otvkLRt22JaSdzEMm7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739128814; c=relaxed/simple;
	bh=YBAgOtx01RqAZQ8xOalw6CYiidRyobliz/2mma3HqPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJZXfr9RWQN6K0IHAUuriPN9inPcjGDfnelRyUi9PYBH1l2N8n5mdEi7e7052sCWpBIvUa4zf8cFTshnvk+mEqA5z/+cCSypTwIOSAo8H2MzLikkqEg6A4UHkxOO0aA50ZDe2SkwgYGx5nHequVA9ec84XEco7j2QOEpRp9UaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=TrStwC52; arc=none smtp.client-ip=81.19.149.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0T7dMZS8iI/+ZLccfsoRU9yTS4TF+pB3xys2o+XhnJ0=; b=TrStwC52fZlfqXUzC0NN6a0PMY
	vw7mPNDQ5t86dwnbGi+KvhNJphUupg/pcCCo4a0eIIB5oEeGnNuIs7sPMsLK0poS+0KcIhnGRZ4zp
	FDVbZ+qImK+l/7sj7pc3H/esgtCeBgpdpXIk5Qy6NY7innZ8+hyPmQMDzPVGYq2O0NII=;
Received: from [88.117.60.28] (helo=hornet.engleder.at)
	by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1thCfO-000000007TS-2ES8;
	Sun, 09 Feb 2025 20:08:31 +0100
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
Subject: [PATCH net-next v6 0/7] Support loopback mode speed selection
Date: Sun,  9 Feb 2025 20:08:20 +0100
Message-Id: <20250209190827.29128-1-gerhard@engleder-embedded.com>
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

Gerhard Engleder (7):
  net: phy: Allow loopback speed selection for PHY drivers
  net: phy: Support speed selection for PHY loopback
  net: phy: micrel: Add loopback support
  net: phy: marvell: Align set_loopback() implementation
  tsnep: Select speed for loopback
  net: selftests: Export net_test_phy_loopback_*
  tsnep: Add PHY loopback selftests

 drivers/net/ethernet/engleder/Kconfig         |   1 +
 drivers/net/ethernet/engleder/tsnep_main.c    |  21 ++-
 .../net/ethernet/engleder/tsnep_selftests.c   | 153 +++++++++++++++++-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |   2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |   8 +-
 drivers/net/phy/adin1100.c                    |   5 +-
 drivers/net/phy/dp83867.c                     |   5 +-
 drivers/net/phy/marvell.c                     |  68 ++++----
 drivers/net/phy/micrel.c                      |  28 ++++
 drivers/net/phy/mxl-gpy.c                     |  11 +-
 drivers/net/phy/phy-c45.c                     |   5 +-
 drivers/net/phy/phy.c                         |  78 +++++++++
 drivers/net/phy/phy_device.c                  |  43 +----
 drivers/net/phy/xilinx_gmii2rgmii.c           |   7 +-
 include/linux/phy.h                           |  18 ++-
 include/net/selftests.h                       |  19 +++
 net/core/selftests.c                          |  13 +-
 19 files changed, 379 insertions(+), 114 deletions(-)

-- 
2.39.5


