Return-Path: <netdev+bounces-102958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB239059DF
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D26B1C2279E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B131822D1;
	Wed, 12 Jun 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FBdPhDQP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41981822CE;
	Wed, 12 Jun 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213334; cv=none; b=JjATYaDXZIP+sUQSmYf+++bg9RgwB/jX6P8LM4NBeIkzYicyIkQC4iBqOGHc5Elr03/AemC5NOe/xtMKKY4S4Ya/+DPG5qiFxyR5Zfb1ZPcv/OoET/nA82W28XnlsUQScHGEzqR8gL7TMtMSXadrZRhUSXnE6gQCRBNsj+Gpfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213334; c=relaxed/simple;
	bh=riOoqu/bsmYryWoPNq+qSSg4e9AZz4xSKxN54pv5OL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJQywOKguoPutLHA0dPC0ED7hcCkNTD8DTMTHjxcbXLqhRI0n/WyrdQMunWsoPaGMZvIUgIqT+0SViTMMz6BhBKaQmdFSXMHoSCN3D8BKrg1US5yW+uCTgRfkBi32xyflgbOC73B6VZ6lJlO+gaeAbdyuIxqOm4n4xHhFu2TUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FBdPhDQP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718213332; x=1749749332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=riOoqu/bsmYryWoPNq+qSSg4e9AZz4xSKxN54pv5OL0=;
  b=FBdPhDQPJHK9jHOgLzHDDvjJK4Zi5/rHK9xbuqgN+ZABRLj4r/fqKjVy
   SUmZ0BlmntMrhv/MfgXCDkq71H4Jyzgd9IaE5zasiUwB6DBSaWYTp61E+
   4WhousuXs0S0atHFD5IygnaFbFKDnuwbBz3sAGwIpRMzmrcLH21UkH5N8
   Be5+OEQUR0NAGjkxHXPhiphlTHEJqzreJdbhOtFzEu84XVZiEpAmw9ani
   3WQzlcQSbTRjTRi43vtfMookcIl9USgKTIRVpqCGLKM1L575lEmVLDt36
   h33DRBsAdV0rgXWmKC2ZIr3NrPPQsuxsCmsAcG1ImK/CjAjj/XnozOeYn
   w==;
X-CSE-ConnectionGUID: kQJR97/CQB64mCyFSlUH9g==
X-CSE-MsgGUID: Un5h+f01RDK1PE87fATe3A==
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="258194646"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2024 10:28:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Jun 2024 10:28:34 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 12 Jun 2024 10:28:29 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<wojciech.drewek@intel.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V4 0/3] net: lan743x: Fixes for multiple WOL related issues
Date: Wed, 12 Jun 2024 22:55:36 +0530
Message-ID: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
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

Raju Lakkaraju (3):
  net: lan743x: disable WOL upon resume to restore full data path
    operation
  net: lan743x: Support WOL at both the PHY and MAC appropriately
  net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

 .../net/ethernet/microchip/lan743x_ethtool.c  | 44 ++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 48 ++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
 drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
 4 files changed, 146 insertions(+), 32 deletions(-)

-- 
2.34.1


