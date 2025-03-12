Return-Path: <netdev+bounces-174338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DECA5E559
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C947178910
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED41E5701;
	Wed, 12 Mar 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="viM5U8l8"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24681C5D5E
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811425; cv=none; b=XZjBlCobuOds7jwqoglLvitD+VNMmcG0PmdpsBP1ItGU6DVPLA6FhIHOcuLMIJKpLeymFqJJr+09CBQ9l1W1LO8KGPNJ9UnR4pnHzWocuMQjAx4+NLZXAK4m54bpklAT+x/muO88W7xdljcTBwbyic07Ec87EuTRLLkBhAtRnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811425; c=relaxed/simple;
	bh=edrEULpRSxmsg3pvLbMojEpdmXIW+OUkASYSglEa2oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KZ6p+kfPLqSV2u4p8NCUJjw+M/BIJFk5Q0nulZbxgblqyv4pI46BTPTVlwJidvh3YHyHlctF95Duzu6XHLcYUwsmPbfSf/6ocNWeuEW9RsSqxw12yZdbp4GttEe2iCxR8Tp/YH7Ls9q5+UdtyYpR4pyKXySioFRRvuO+cLRaLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=viM5U8l8; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mJ5u7YybwOZq2DYwi+uEf0jin1iulKMcdAWLYXY4S6U=; b=viM5U8l8/SF8RiZKjTUANqPYQB
	zH13+chOMUbQc/JmNoJ/uM4DxDQgn5Tk2v/GlnHZkrlvuJxhVnWzGr0mNI3m/9uOj/Hv19XP1q5Ux
	BxiaeofvJxhx6XfD89SCYkeopqkjELUZIDrKC4EM4j05yLgtDCmcgU3H3nyMTwq8cLYE=;
Received: from [80.121.79.4] (helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tsSiS-000000006Ue-1jXC;
	Wed, 12 Mar 2025 21:30:12 +0100
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
Subject: [PATCH net-next v10 0/5] Support loopback mode speed selection
Date: Wed, 12 Mar 2025 21:30:05 +0100
Message-Id: <20250312203010.47429-1-gerhard@engleder-embedded.com>
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

v10:
- remove selftests, because Anrew Lunn expects a new netlink API for
  selftests and the selftest patches should wait for it

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

Gerhard Engleder (5):
  net: phy: Allow loopback speed selection for PHY drivers
  net: phy: Support speed selection for PHY loopback
  net: phy: micrel: Add loopback support
  net: phy: marvell: Align set_loopback() implementation
  tsnep: Select speed for loopback

 drivers/net/ethernet/engleder/tsnep_main.c    | 21 +++--
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |  8 +-
 drivers/net/phy/adin1100.c                    |  5 +-
 drivers/net/phy/dp83867.c                     |  5 +-
 drivers/net/phy/marvell.c                     | 68 +++++++--------
 drivers/net/phy/micrel.c                      | 24 +++++
 drivers/net/phy/mxl-gpy.c                     | 11 ++-
 drivers/net/phy/phy-c45.c                     |  5 +-
 drivers/net/phy/phy.c                         | 87 +++++++++++++++++++
 drivers/net/phy/phy_device.c                  | 43 ++-------
 drivers/net/phy/xilinx_gmii2rgmii.c           |  7 +-
 include/linux/phy.h                           | 18 ++--
 net/core/selftests.c                          |  4 +-
 16 files changed, 209 insertions(+), 107 deletions(-)

-- 
2.39.5


