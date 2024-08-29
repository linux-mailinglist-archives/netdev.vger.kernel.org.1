Return-Path: <netdev+bounces-123083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC29963A10
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F42A1C22089
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F10145FE5;
	Thu, 29 Aug 2024 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="db2zyw6s"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769241487F1;
	Thu, 29 Aug 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910962; cv=none; b=RTSsR96OuwsKzxlFHZE0EMcU4ozolJ4LrS1fxNlVDOcOLLaIUMsLhYF6k7BpsAKTtg1eZgOaASEvYOZmj2V1Bv5M6Mnmy2eQbe7R/0sGQSfdPLoJJwP5N4VRSBdilratEg0xBltQO/JXYIPmE2KgR8+BlNmSEyBRclwUuzWAZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910962; c=relaxed/simple;
	bh=awg13QCLRvaX7kb8KIorHdKyKvRmjNYCGTZ98BD5/M0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UlOtA/TELgW6H8dwrmeLnjNjGYcfj0ksMy1+T+2ej4b8tbmi5AgBRhysbriqb/8/V0FgswBpQlytUmFi4gIhT8eNvGM+bUip6h6IgkeP5IKxI0AClp3e8AoQTzFgposVYmqsU25eOHUqctRq4YD7gffhAGGrcbfUM517WXgGzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=db2zyw6s; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724910960; x=1756446960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=awg13QCLRvaX7kb8KIorHdKyKvRmjNYCGTZ98BD5/M0=;
  b=db2zyw6sAHnVrJ3gPD+jzMLaEau25XCoqPkyOyZEsofQKfx4/RYPRSh/
   TZ8Gb8jL/RuFdfEPrCpn3esCKd+w036dEdPuL/r81WkxDsAmrSWKIEhxc
   XJ4y3WJYTioPFHicNbYMh7+OHxV91cVlHHE5uipkl7T3DY3j+pZTUSag2
   zMisbaperzJgB0/3L/WVZJ722pYKeL5B1gs+u7plbX2wC4ZCtKpZPVBFw
   ztW3dnACfRII4aJAmregoMgbkXmu+E2hZrX3MAYUfYSVpujOFdEKe7YqN
   Un5BBRbPWGiA31XJvQb6DToeaMGmOXk84vq9mk49+XVl10hlpxXwgpO4e
   A==;
X-CSE-ConnectionGUID: 2MQclz5sT/+LITt4o2qSTg==
X-CSE-MsgGUID: 1GiybGNwRwyyDUmec29r2Q==
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="261978658"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 22:55:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 22:55:20 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Aug 2024 22:55:16 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V4 0/5] Add support to PHYLINK for LAN743x/PCI11x1x chips
Date: Thu, 29 Aug 2024 11:21:27 +0530
Message-ID: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This is the follow-up patch series of
https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html

Divide the PHYLINK adaptation and SFP modifications into two separate patch
series.

The current patch series focuses on transitioning the LAN743x driver's PHY
support from phylib to phylink.

Tested on PCI11010 Rev-1 Evaluation board

Change List:
============
V3 -> V4:
  - Add fixed-link patch along with this series. 
    Note: Note: This code was developed by Mr.Russell King
    Ref: 
    https://lore.kernel.org/netdev/LV8PR11MB8700C786F5F1C274C73036CC9F8E2@LV8PR11MB8700.namprd11.prod.outlook.com/T/#me943adf54f1ea082edf294aba448fa003a116815
  - Change phylink fixed-link function header's string from "Returns" to
    "Returns:" 
  - Remove the EEE private variable from LAN743x adapter strcture and fix the
    EEE's set/get functions
  - set the individual caps (i.e. _RGMII, _RGMII_ID, _RGMII_RXID and
    __RGMII_TXID) replace with phy_interface_set_rgmii( ) function
  - Change lan743x_set_eee( ) to lan743x_mac_eee_enable( )

V2 -> V3:
  - Remove the unwanted parens in each of these if() sub-blocks 
  - Replace "to_net_dev(config->dev)" with "netdev".
  - Add GMII_ID/RGMII_TXID/RGMII_RXID in supported_interfaces
  - Fix the lan743x_phy_handle_exists( ) return type

V1 -> V2:
  - Fix the Russell King's comments i.e. remove the speed, duplex update in 
    lan743x_phylink_mac_config( )
  - pre-March 2020 legacy support has been removed

V0 -> V1:
  - Integrate with Synopsys DesignWare XPCS drivers
  - Based on external review comments,
  - Changes made to SGMII interface support only 1G/100M/10M bps speed
  - Changes made to 2500Base-X interface support only 2.5Gbps speed
  - Add check for not is_sgmii_en with is_sfp_support_en support
  - Change the "pci11x1x_strap_get_status" function return type from void to
    int
  - Add ethtool phylink wol, eee, pause get/set functions

Raju Lakkaraju (5):
  net: phylink: Add phylink_set_fixed_link() to configure fixed link
    state in phylink
  net: lan743x: Create separate PCS power reset function
  net: lan743x: Create separate Link Speed Duplex state function
  net: lan743x: Migrate phylib to phylink
  net: lan743x: Add support to ethtool phylink get and set settings

 drivers/net/ethernet/microchip/Kconfig        |   5 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  | 117 +--
 drivers/net/ethernet/microchip/lan743x_main.c | 677 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   4 +
 drivers/net/phy/phylink.c                     |  42 ++
 include/linux/phylink.h                       |   2 +
 6 files changed, 523 insertions(+), 324 deletions(-)

-- 
2.34.1


