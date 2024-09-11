Return-Path: <netdev+bounces-127468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEA1975809
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29EF1C2349D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4A1AC452;
	Wed, 11 Sep 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2n1lzwR4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3B1AB525;
	Wed, 11 Sep 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071324; cv=none; b=Cw0BnMLFOmgIg0NvWkRIf0H0ORraH+/Ub1y7MndYvlYA2psf7eH2CFyufQweMaDjiLZ1rNDqjy7XiN6ZLk/TJAWUEotn0hKAPEi/Awj4JWkVG9trVAZ38GOqHNlS8IfphuC5a1K2QRhpvyfJAWyRxE7JxbQ/vhxK8FWdCWamY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071324; c=relaxed/simple;
	bh=76t25afxOrdjtZzYiracl8aOXEoGDYd6uUx1pVU5n+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ua15QJzXwE8ImtkAg3m4hRmO5n3QF0wWXbpIMk4dmk8YISkEmrK6ZXskG7S7DA0hdx7iRp8OtQlrQPCkzgDYvbIB4D0cAiKudFnBftGepzIXX5HBPs/zWJyJ039hPqDEGwr61gPVmK6V6GU/lYRieWbVUviQU+AhP8D460A18QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2n1lzwR4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726071323; x=1757607323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=76t25afxOrdjtZzYiracl8aOXEoGDYd6uUx1pVU5n+E=;
  b=2n1lzwR46JkhlJFOyd25mak0XP8E/AW1UL/e8QH8bfSroKggegpFoajl
   UHd6FPTI5pTfossKAYdcv+rhNRLkT3d3qMPNfbouJ/gpoGtTqQnf/nPAi
   BGaXh4W4nf4Rtdj09vbdrk+H4hzTPZ4L8If1WphHZ0hPU1zcqF8ljcpxk
   iIrfG8l7hwq2AHBEIcNh8qVe75PCML4M8XEI+RMcKpsQzN6BTwQRBzZyD
   H6RKVaZY5iUUkl3TrU6a+l5h7ASmmZYs5Ied3KR28EyrDt16/Vmma23Nc
   UggYwwKSezn9KB1q7/63pvhh+moI3vjRaHUzRVwLnri5lRRWbWA8Q2ZaQ
   g==;
X-CSE-ConnectionGUID: 2nHLmdpiRE6ZQX98BGaY/g==
X-CSE-MsgGUID: GXHU0rg7TUGotfNCx7szgA==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="262640531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 09:15:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 09:14:49 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 09:14:45 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 0/5] Add support to SFP for PCI11x1x chips
Date: Wed, 11 Sep 2024 21:40:49 +0530
Message-ID: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
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

This patch series focuses on sfp support for PCI11x1x chips.

Tested on PCI11010 Rev-1 Evaluation board with following SFP modules:
 1. FS's 2.5G SFP (SFP-2.5G-T) with 2.5 Gbps speed (interface 2500Base-X)
 2. Axcen's 1G SFP (AXGT-R1T4-05I1) at 1G/100M/10M bps speed (interface SGMII) 

Change Log:
===========
V1 -> V2:
  - Split the patches to "PHYLINK" and "SFP" parts
  - Change variable name from "chip_rev" to "fpga_rev"
  - SFP GPIO definitions and other macros move from lan743x_main.c to
    lan743x_main.h file
  - Change from "PCI11X1X_" to "PCI11X1X_EVB_PCI11010_" strings for GPIO macros
  - Add platform_device_unregister( ) when sfp register fail
  - Add two new patches to this patch series
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
  net: lan743x: Add SFP support check flag
  net: lan743x: Add support to software-nodes for sfp
  net: lan743x: Register the platform device for sfp pluggable module
  net: lan743x: Implement phylink pcs
  net: lan743x: Add Support for 2.5G SFP with 2500Base-X Interface

 drivers/net/ethernet/microchip/Kconfig        |   4 +
 drivers/net/ethernet/microchip/lan743x_main.c | 358 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  88 +++++
 3 files changed, 434 insertions(+), 16 deletions(-)

-- 
2.34.1


