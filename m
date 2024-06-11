Return-Path: <netdev+bounces-102466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088290329C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF597283360
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A18F5A;
	Tue, 11 Jun 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vXcdh4KQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80E13F43E;
	Tue, 11 Jun 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087450; cv=none; b=GmYH3aLZBxH+g8+RUuHZAPQXuE6M/lZ7vqzQYZHh16wsnPNkR7frq7KiGuCT/V4X4ePLbYyNFYL/d0UEbvvJuJIAiesb5K/cZtM+7XFQya+XpLQRr6G50oK9EneDW0tUomoXekVB65kgkMXdO148/xMmuoS34fqfMtbYpTIfbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087450; c=relaxed/simple;
	bh=6tEGaQgbx6qLCC8rjI6r1os6MQlD1XiS2YDMWqA6z4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ff/kD0ZHpvgEpCSEX8ma2S4JXNzckB5kNA9q3h0bORsMHlhtYcbkLNgBiM0k2XivWMDlWv5PrJAoCgccMdj6iAGxU3np4SMKu1YUZr0/QEpbHQKGqer59oAG3Ab72vk3poDj062sG2euMWSVL3K/gSCQNbXWhZd+aEz1VSoM+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vXcdh4KQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718087447; x=1749623447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tEGaQgbx6qLCC8rjI6r1os6MQlD1XiS2YDMWqA6z4k=;
  b=vXcdh4KQzf1NpwgRcOwTlbaVc0T7SN5jbPo9o9lILJAngW7QwidGOIYy
   z2T3cxxQXLJF8gaGAX60/Xgthe8dXyAdfYkRB8NDH2SoKB4HqZ774p6Jv
   9hnwDUI7YjZUgluO1bMPBco4/iD02cNi9Dlt5i63liP2INeZoD05rg8a7
   loqT288cHlgVv0e74dpPPzDYBC0U4yLsB8c3/vctJXAX3MdDq5Vrv48az
   ZYoX3F4XQGM+8p7r1aOaxZfITBgtLrixc+YHv8UJPZn2rdBlyHzO9pT+b
   fGlz1XlslEY2YMDRQOS8vW6yZXEuwnAP4lk7En3f36d7gkClQxQmQQbOd
   w==;
X-CSE-ConnectionGUID: qW/fHBgeQfKr2aS/bqXRMQ==
X-CSE-MsgGUID: JRGkWn15SQWc4oxqIUO+mg==
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="27243325"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 23:30:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 23:30:44 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 10 Jun 2024 23:30:39 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <lkp@intel.com>
CC: <Raju.Lakkaraju@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <hkallweit1@gmail.com>, <hmehrtens@maxlinear.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<lxu@maxlinear.com>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>, <sbauer@blackbox.su>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net V3 0/3] net: lan743x: Fixes for multiple WOL related issues
Date: Tue, 11 Jun 2024 11:57:50 +0530
Message-ID: <20240611062753.12020-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202406052200.w3zuc32H-lkp@intel.com>
References: <202406052200.w3zuc32H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series implement the following fixes:
1. Disable WOL upon resume in order to restore full data path operation
2. Support WOL at both the PHY and MAC appropriately 
3. Remove interrupt mask clearing from config_init 

Patch-3 was sent seperately earlier. Review comments in link: 
https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>                        
Reported-by: kernel test robot <lkp@intel.com>                                  
Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/

Raju Lakkaraju (3):
  net: lan743x: disable WOL upon resume to restore full data path
    operation
  net: lan743x: Support WOL at both the PHY and MAC appropriately
  net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

 .../net/ethernet/microchip/lan743x_ethtool.c  | 44 ++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 46 ++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
 drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
 4 files changed, 144 insertions(+), 32 deletions(-)

-- 
2.34.1


