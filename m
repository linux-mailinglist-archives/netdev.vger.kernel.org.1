Return-Path: <netdev+bounces-157203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0038A09666
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CD21884316
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102F2116F0;
	Fri, 10 Jan 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="TeOULI5H"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D22116E5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524214; cv=none; b=qH6MRAFNuj8VM7WNR1ktRXhubMyzSO76UwFGF1b1bA1t3R2eAiTIlATDvmX6SHFcAImEbHPSGKDS6Hds5QrXfJ/GpY6fINm4YIvcIFQo5xJHyVK3WH5f9hd3ar5w2yyxR5APaBqsRmlt59em9cnz3FXfYXn5v2DJDcjj0ah/SqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524214; c=relaxed/simple;
	bh=nE3gLU9lmlRju6tXvaxDk9dB+qeCuBItScupPL5Zcco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ozew+jSGoN1wEQC53Imh/GpBCsLCcU/0YVi+PQ58Cz30SeKN66ZledX1NnQj+xbPCEVaAmnLE6mEnCkjRDhfb7qwp7szhGXRwzbSgMsA9RE3Xq7VlEqjYYhUbpiG41kIsuHcaEOZjJn+1i7bxzK6G8c5y9llzDt67EGBESbofp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=TeOULI5H; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=76aHCt5JKsNOdHhsT8O6npKHyXjDZMJMQyDcqHvQTNw=; b=TeOULI5HwcgWro6e4T59qnSVOY
	+i6yxWfkM4a3BvEQfT9UWMMfOQS2T2QK/ENXnwG/dX6BjvSzsCWeEF2Msbfza8wdyXKMw/PDLKlv+
	GMcBa6g1I8CH1bOkBoGJV60G7SX8UR9+KLNhMQju4Q8CrTvw0nxzAvt77kXYB0t/Zj9w=;
Received: from [88.117.60.28] (helo=hornet.engleder.at)
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tWGJS-000000006oP-05lP;
	Fri, 10 Jan 2025 15:48:38 +0100
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
Subject: [PATCH net-next v2 0/5] Support loopback mode speed selection
Date: Fri, 10 Jan 2025 15:48:23 +0100
Message-Id: <20250110144828.4943-1-gerhard@engleder-embedded.com>
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

Previously to commit 6ff3cddc365b
("net: phylib: do not disable autoneg for fixed speeds >= 1G") it was
possible to select the speed of the loopback mode by configuring a fixed
speed before enabling the loopback mode. Now autoneg is always enabled
for >= 1G and a fixed speed of >= 1G requires successful autoneg. Thus,
the speed of the loopback mode depends on the link partner for >= 1G.
There is no technical reason to depend on the link partner for loopback
mode. With this behavior the loopback mode is less useful for testing.

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

v2:
- signal link up to keep MAC and PHY in sync about speed (Andrew Lunn)

Gerhard Engleder (5):
  net: phy: Allow loopback speed selection for PHY drivers
  net: phy: Support speed selection for PHY loopback
  net: phy: micrel: Add loopback support
  tsnep: Select speed for loopback
  tsnep: Add PHY loopback selftests

 drivers/net/ethernet/engleder/tsnep_main.c    |  13 ++-
 .../net/ethernet/engleder/tsnep_selftests.c   | 102 ++++++++++++++++++
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   4 +-
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |   2 +-
 .../stmicro/stmmac/stmmac_selftests.c         |   8 +-
 drivers/net/phy/adin1100.c                    |   5 +-
 drivers/net/phy/dp83867.c                     |   5 +-
 drivers/net/phy/marvell.c                     |   8 +-
 drivers/net/phy/micrel.c                      |  28 +++++
 drivers/net/phy/mxl-gpy.c                     |  11 +-
 drivers/net/phy/phy-c45.c                     |   5 +-
 drivers/net/phy/phy.c                         |  79 ++++++++++++++
 drivers/net/phy/phy_device.c                  |  43 ++------
 drivers/net/phy/xilinx_gmii2rgmii.c           |   7 +-
 include/linux/phy.h                           |  18 +++-
 net/core/selftests.c                          |   4 +-
 17 files changed, 282 insertions(+), 64 deletions(-)

-- 
2.39.5


