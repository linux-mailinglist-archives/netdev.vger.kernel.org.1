Return-Path: <netdev+bounces-145236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18F9CDD48
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B104A283568
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43DF1B5EDC;
	Fri, 15 Nov 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4+rCg2d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF418E047;
	Fri, 15 Nov 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669150; cv=none; b=INk5xiz6aypPo9NZGcm+oMFZzhbm3KclAadW6bvCB3v1yOAdHut6jSelOriis/Z51cOLQSSMRx4lhOeyq9RPVbf2VCLZzWZ2P1mc/ddwk7Mf2t5p6fI+pw7ATC5POkInG+bBUWl8UZGAIPdU9USSwc2vE+S6yng7mah6WPTLjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669150; c=relaxed/simple;
	bh=Vk5UJimJXW3rB4PeKQ8t+GgFEcFaZSXTDspcbtJZfZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fEjO6KrsMApZQOulXNbaYAT2Sjn7y6k7sn2mcoxHFwjLMqpiou4eIyDw0Yy5mjOwhuZE9m/Arbk2JfvIoIdZoTBIxH3z3Dq9sd5jL6yWRHt8MgpLBPCY+myIPVDx9njXdvMdIvjS0gPn6AMaQOfvCPX9nl+ai2P/VI/ulewymI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4+rCg2d; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731669149; x=1763205149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vk5UJimJXW3rB4PeKQ8t+GgFEcFaZSXTDspcbtJZfZ4=;
  b=Z4+rCg2dmvdZ7urZ8NyV1F8c5qPxnYqhrxqu8VZhhV7Cjx17U6eBTCyh
   dZ2oYX4ZZa6+CYK+rf1Vr//e9tpW8epz4odlKdRJlTFb6uY2Yusxj5yjA
   wFaMDluiZClhcHdg6Ki57XZk2pbh6IdzoqZIhTXwSEb3nL3V6dYdkomUk
   Hx4ezyUrWWJ4OgvPOpOAOA+JMQN6pe7XyWcOy2DpxchikH6oX8fQhPIpz
   3osn5o6zHtsYh9VQxYi7JxglxGml7PGoBp0q5dY6utIZeD9yAqkJ7EVFm
   mYjU3I5neNTWF13OxyOWvGe8mOojlbZx3NFhCxkk3lgvyw0RCrK+5VciV
   g==;
X-CSE-ConnectionGUID: 7zUyIExWRSi6t1nyE190lA==
X-CSE-MsgGUID: PLIdBB6mT5CZZBpnBc9K4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34543447"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="34543447"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 03:12:28 -0800
X-CSE-ConnectionGUID: zdlu9zFURK207QalAA83XQ==
X-CSE-MsgGUID: Zq/XNiqKSdSLHHWYxgXdbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88112362"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa006.fm.intel.com with ESMTP; 15 Nov 2024 03:12:24 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2 0/2] Fix 'ethtool --show-eee' during initial stage
Date: Fri, 15 Nov 2024 19:11:49 +0800
Message-Id: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Choong Yong Liang <yong.liang.choong@intel.com>

When the MAC boots up with a Marvell PHY and phy_support_eee() is implemented,
the 'ethtool --show-eee' command shows that EEE is enabled, but in actuality,
the driver side is disabled. If we try to enable EEE through
'ethtool --set-eee' for a Marvell PHY, nothing happens because the eee_cfg
matches the setting required to enable EEE in ethnl_set_eee().

This patch series will remove phydev->eee_enabled and replace it with
eee_cfg.eee_enabled. When performing genphy_c45_an_config_eee_aneg(), it
will follow the master configuration to have software and hardware in sync,
allowing 'ethtool --show-eee' to display the correct value during the
initial stage.

v2 changes:
 - Implement the prototype suggested by Russell
 - Check EEE before calling phy_support_eee()

Thanks to Russell for the proposed prototype in [1].

Reference:
[1] https://patchwork.kernel.org/comment/26121323/

Choong Yong Liang (2):
  net: phy: replace phydev->eee_enabled with eee_cfg.eee_enabled
  net: stmmac: set initial EEE policy configuration

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 +++
 drivers/net/phy/phy-c45.c                         | 11 +++++------
 drivers/net/phy/phy_device.c                      |  6 +++---
 include/linux/phy.h                               |  5 ++---
 4 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.34.1


