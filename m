Return-Path: <netdev+bounces-163229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027EA29A2C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6E31881B6B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8431196C7C;
	Wed,  5 Feb 2025 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="YY372G+/"
X-Original-To: netdev@vger.kernel.org
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17564155335
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784089; cv=none; b=DIEFjIH6lD0WtHVaH/uhspn0OqAcCwQG6w4ONDH/646Q2mjFrqWUK42YL7MkYrTwQvTXuRGPYxStVnZxU+4FBEU+6yNlARSmVzJVbLFevEPAkysfPQaIUPqKTAhEyucdSYfa1ksfllAeaLdE9TI9x+9qGS8+LeQX4o2oeqE8jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784089; c=relaxed/simple;
	bh=tLkYHJJwEPLBMe9d29UQxN19VGDYTMEZHUWmZDm/c/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NtW5C0znfrHYwbEHvp/i/A4YkQB6u2UZykdCRBWWKL7No3y25LjxpQ+pZmWIdGuN1M6lHiv0u1fDCnRMcx3fkWxybd2VNitkjEKXkY/RTQeh9Bfxz1co2MOZfRiZ5WqdT0FJvIFJCyZP5nNzDmxTxL3P9WYbqA2K8fGI0eP/yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=YY372G+/; arc=none smtp.client-ip=81.19.149.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QbQrAIvlPOOrpGCbMLjVvnVDA88gFw/PaPf3vWvUymI=; b=YY372G+/dMrgG0m9ClmEnJbQS5
	OStYqBNze0/EaLhLeiC4G3PwPDMSstFeBHLgnYwVha+5ebhNkEUWQeFEugFRDC4rXhea274z0byEb
	zJ+lgVJWFzamT41mw8+g6oxDOhiegP1od6I1sGfW82DMqyU8/zVtKHXCfaMt7pJGRCvY=;
Received: from [88.117.60.28] (helo=hornet.engleder.at)
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tfkl7-0000000017b-1Dkl;
	Wed, 05 Feb 2025 20:08:27 +0100
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
Subject: [PATCH net-next v5 0/7] Support loopback mode speed selection
Date: Wed,  5 Feb 2025 20:08:16 +0100
Message-Id: <20250205190823.23528-1-gerhard@engleder-embedded.com>
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
 drivers/net/phy/phy.c                         |  76 +++++++++
 drivers/net/phy/phy_device.c                  |  43 +----
 drivers/net/phy/xilinx_gmii2rgmii.c           |   7 +-
 include/linux/phy.h                           |  18 ++-
 include/net/selftests.h                       |  19 +++
 net/core/selftests.c                          |  13 +-
 19 files changed, 377 insertions(+), 114 deletions(-)

-- 
2.39.5


