Return-Path: <netdev+bounces-114182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8E9413EB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2461F24A9C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93371A08BF;
	Tue, 30 Jul 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TZ1g6Cws"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E51A08BB;
	Tue, 30 Jul 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348606; cv=none; b=RcmIJ2S0enAxoEy9vQnrQu9p1k5sOaelX3RZaPeRrFp+2k6TdRGpDqi2+zSKElLu2HIBnjWOUC3kF+1nYTv07c9mRumMiC7/wPuKIcDjVvwObiYPYoK4Zg4VZMSfVUj8ZdcfgMdyvx+p7sPVUsV04H+Sm7j0exJWJPOwYRVrM8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348606; c=relaxed/simple;
	bh=sbjw89L9tQB48+1/iGY5wGSebtwNNrk4os+S0LGy578=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PVAOCtAxZxA5EDTOVOR8kuZj55NAcTFiCrHBJi0q+wCezTfg0nhAiXyJCK/8IcQlMm5kslY1UMSn0PzJwD3taY5VLkTO8OVke+JCPUri7bZ0WD8ZzQlUEl+ApYOp1J5KQsg913O9VueGMOhMVHOb8SbeVPyLurdlgC03Fhe3n+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TZ1g6Cws; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722348604; x=1753884604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbjw89L9tQB48+1/iGY5wGSebtwNNrk4os+S0LGy578=;
  b=TZ1g6CwssmDkQVZa3/DAyCdtEE9YLbm2TmXU8mCpOpqRbDIhmn7r+afa
   jM3sAUvUlCymfh1zosRpM7v51wMdpdvNlQPkanGFkSRzwZAMMYtnK2d+E
   j1A7S0b24s+tHW6gYsJZmhCmax7rTicUG+wLSlN2kXz0daDRTmHvQi3Ce
   G9M5wz+08JOIOtFJGP+yPftf1NPBjj+zO81TZPK9zBEOGnR505KmW4yhw
   HsTeu3n3RjGNjd2ET0I9vGYhnF9SGqTYg+q9Dnue7sFghy+8TQO5hpbJf
   2TNmNWh6DYOhPo+j9sv6GbOJBcaJajIuLk5ffBKIdADzT9Hrk7s4QTMJL
   A==;
X-CSE-ConnectionGUID: pJjtUho7TD2Gsi4T6qZB0A==
X-CSE-MsgGUID: hsO+Z3wGR7WmVo1siQ+R+w==
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="260769369"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2024 07:09:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jul 2024 07:09:40 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jul 2024 07:09:35 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V3 0/4] Add support to PHYLINK for LAN743x/PCI11x1x chips
Date: Tue, 30 Jul 2024 19:36:15 +0530
Message-ID: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
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

Tested on chip PCI11010 Rev-B with Bridgeport Evaluation board Rev-1

Change List:
============
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


Raju Lakkaraju (4):
  net: lan743x: Create separate PCS power reset function
  net: lan743x: Create separate Link Speed Duplex state function
  net: lan743x: Migrate phylib to phylink
  net: lan743x: Add support to ethtool phylink get and set settings

 drivers/net/ethernet/microchip/Kconfig        |   5 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  | 118 +---
 drivers/net/ethernet/microchip/lan743x_main.c | 657 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   7 +
 4 files changed, 460 insertions(+), 327 deletions(-)

-- 
2.34.1


