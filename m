Return-Path: <netdev+bounces-160867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE1A1BE6C
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA0A16E444
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16881E990B;
	Fri, 24 Jan 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="QtxNc8Wp"
X-Original-To: netdev@vger.kernel.org
Received: from mx10lb.world4you.com (mx10lb.world4you.com [81.19.149.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525341DA60D
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757928; cv=none; b=tGj0vG35i/WaqKJizIr1YYBR49S+Rvs5EnxkAAz6DpgfI0C8qyDVRPm/hxp58PGpl8sKAD03BAkpaOYY7TJY0PECcjU8AJ7F+YDTBH99bhKiT8FSXuL6Gb/19R99unJrKCP/CZWrB9YvuqXXQ628XuvebNscbkEYQCBwCYce58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757928; c=relaxed/simple;
	bh=G1/tfw6zn8fvOqk7fpDGJB7oy7DJXDiGtKpkruwpShU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cPUHai0NNZ4cq1Nsbkydbv4hnIAL0hA44MofYguBUHPwJaiTJXZYCCLMeqnSDlbr/TOPMAp0OLhzJGktWpF0B/o+2Ap/JYY7oSqUWk1npQYzuHrbowOmPyiuHhbi9otAXSJg85F5nPEg/kj6c/EqSpXOWkdhaE4man0O3aZsOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=QtxNc8Wp; arc=none smtp.client-ip=81.19.149.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3JEbioB/6H9MvOkOm/w9Feh/1WDJbCj8BVx4cJKFadk=; b=QtxNc8WpjNxNtLORrmdR7VkSvv
	shSu5gwELyPjZ77O/aatx94yj88uy8wrzz+ciFOyAcmsGstQQNj0i/oWWO1fxHZLo7e8Kbrmz8eXs
	nyWKWHfTY8iyWvFiSsTqQaXlYnlFsGdTY6GGdOQLo6jxd2cuZ/7pG0BOC9Ye0AdKuNxQ=;
Received: from [88.117.60.28] (helo=hornet.engleder.at)
	by mx10lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tbRnp-000000005Ng-32jh;
	Fri, 24 Jan 2025 23:05:26 +0100
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
Subject: [RFC PATCH net-next v3 0/7] Support loopback mode speed selection
Date: Fri, 24 Jan 2025 23:05:09 +0100
Message-Id: <20250124220516.113798-1-gerhard@engleder-embedded.com>
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

RFC:
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
 drivers/net/phy/phy.c                         |  76 +++++++++
 drivers/net/phy/phy_device.c                  |  43 +----
 drivers/net/phy/xilinx_gmii2rgmii.c           |   7 +-
 include/linux/phy.h                           |  18 ++-
 include/net/selftests.h                       |  19 +++
 net/core/selftests.c                          |  13 +-
 19 files changed, 377 insertions(+), 114 deletions(-)

-- 
2.39.5


