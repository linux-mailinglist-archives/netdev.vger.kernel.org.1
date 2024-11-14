Return-Path: <netdev+bounces-144725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C49C84B6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA21EB27834
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6DD1F5839;
	Thu, 14 Nov 2024 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQqRICgh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954E146588;
	Thu, 14 Nov 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572250; cv=none; b=YEpcW/2rND+tBEy0SrALJ3fDE3DuT6iusWL1sEPBy+zYF0+5oMHbtZfMzJeov9uEUjzz4lWgfnk25byLMdkqCXy0j7OzIzeZjVaBGzRB8S9M1+zwvJVPKQYfcN/WEoBtjU3RCHWATgXAYcCeX8gyYLsUxJQw4QZ4Cn8Nmcd5jfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572250; c=relaxed/simple;
	bh=LzcUFYSQKL3vPxB47TGpPrctgQCVXb4LxxKzcyPBE3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZT5eEOwmvi97qL6Lfg26PIRLIUVkDNxFEGoIgsqbOO1nKx1iGIFSMw+sPlQ5OJ6R14cAif4J7bLBzwgd+e9QpKDyGafKHwdKnSe2VNaBHLkqHflYEfkNdfUwwxyRGwC8ZVwnDlXQIGLlXIVLk8lmPynGyMlKo09jo4tBYReHFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQqRICgh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731572249; x=1763108249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LzcUFYSQKL3vPxB47TGpPrctgQCVXb4LxxKzcyPBE3c=;
  b=SQqRICghT1r0Cku+l2d7KcdK9LVt3FaZcL0emOD/1aeJ9Ajbbhnna6Rz
   EFU7YuHWKt1/ItvrBmt907LEgeMtOKpHxOJBwLjU5Cm59NPKnizSNJW70
   KZzoJATmSBD7F0wVDJmXXJKgFemflkIwtj4Y+Q4RgzjB6UtYU3Kud1vCQ
   mQVVeZD5kU3L8uHAWGJXISsgX2SBiPoCilB1WFWw5jLpefzF9EIlqSlm4
   sUwUpSv3SwoxN/DdQTcLTlzFCKHFf0VwA9wzbh45BveS5WSqFw2sltIPU
   msjeYRrANf1jcmJ+Aix3+Duap3e0+m6wHMPTWZOIoGOYbnHduc7SJT8rw
   A==;
X-CSE-ConnectionGUID: kVhP0Y0kRFihhWH6TCYp9Q==
X-CSE-MsgGUID: k40BXLbzSqamVcUEpS0ixw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42921246"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42921246"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:17:28 -0800
X-CSE-ConnectionGUID: Lvz13PUNTQi3AKSD7udmqQ==
X-CSE-MsgGUID: d9mnhq+6T1mq86CnPiONVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88553858"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa010.fm.intel.com with ESMTP; 14 Nov 2024 00:17:24 -0800
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
Subject: [PATCH net v1 0/2] Fix 'ethtool --show-eee' during initial stage
Date: Thu, 14 Nov 2024 16:16:51 +0800
Message-Id: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 49168d1980e2 
("net: phy: Add phy_support_eee() indicating MAC support EEE") introduced
phy_support_eee() to set eee_cfg.tx_lpi_enabled and eee_cfg.eee_enabled to
true as the default value. However, not all PHYs have EEE enabled by default.
For example, Marvell PHYs are designed to have EEE hardware disabled during
the initial state, and it needs to be configured to turn it on again.

When the MAC boots up with a Marvell PHY and phy_support_eee() is implemented,
the 'ethtool --show-eee' command shows that EEE is enabled, but in actuality,
the driver side is disabled. If we try to enable EEE through
'ethtool --set-eee' for a Marvell PHY, nothing happens because the eee_cfg
matches the setting required to enable EEE in ethnl_set_eee().

This patch series will read the PHY configuration and set it as the initial
value for eee_cfg.tx_lpi_enabled and eee_cfg.eee_enabled, allowing
'ethtool --show-eee' to display the correct value during the initial stage.

Choong Yong Liang (2):
  net: phy: set eee_cfg based on PHY configuration
  net: stmmac: set initial EEE policy configuration

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 drivers/net/phy/phy_device.c                      | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


