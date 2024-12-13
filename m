Return-Path: <netdev+bounces-151734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC49F0BFD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F518893A8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4E61DF737;
	Fri, 13 Dec 2024 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r8iiTZkB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB641DF263;
	Fri, 13 Dec 2024 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092076; cv=none; b=mBzkt97TTkuW7pSOFpU2tYxQUNoNyV11Yt9sMJLdblzTHtTv20InQ59p9r2YSZqj23u9OyfAckDx6cKCZYGSJEsmwlRv2TDuXiRo7AyVSFm3fIO+xbfLXubHkeRil4qp5WLzkF9r+bgycC1Zb23aD4pZiJPx7VBhYt7p25/iwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092076; c=relaxed/simple;
	bh=1CKMkx0fC44nPsnDb1lIyJp1DaL/yOamtTXLo8446nE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjaEcPhEu3+BagQaASaXYuWctjQ6D6d5yrecrhOa/cxPDM+EgY6yz6T7Fvpo3YheFc2/2xs11gWcR5PcVcxMYbMzXLywyF1uhxiDDTF9S+DcYxGqItpCC2p3NIyXLkvISddfh9dhuCoNde0WGpUuJG8q3DmpMp3OIO+S3X41NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r8iiTZkB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734092074; x=1765628074;
  h=from:to:subject:date:message-id:mime-version;
  bh=1CKMkx0fC44nPsnDb1lIyJp1DaL/yOamtTXLo8446nE=;
  b=r8iiTZkBMqD6JTuHu556HQRfowOJTlSuBeBrPKrsRoa99LALGgHKI9kH
   xkkigg+tdRfCnhzvesbW2GeoB06MXaaxm09zcsUthwYPCjJzH5Ip+ijuI
   FK8Q4L52h+Rq/ne1Vs0Bg8IJotatCdzMHfppuJVd62Z7cc/xWw8kg2aEZ
   6p2POnn5BpBY/2gp12IYJi0LzVukZRbaPdB84ZZZt3SX9oClX/O6PrLot
   M7rzqAWRg46iJbHFVrsGPzWoUBh9W+5U9V6eCWDRRBy2RSELmjQdh/CZG
   aYze0PTPE/KuFaCfP1c/jVy+UQBwb+UP6aq7Mxmvw3NXsZz0X1XRTstS6
   g==;
X-CSE-ConnectionGUID: R6LocSygTBu1rZt5XxoMKA==
X-CSE-MsgGUID: BY4Qr75FRku3XENcJpWhQw==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="35182255"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:14:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:14:11 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:14:06 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v7 0/5] Add rds ptp library for Microchip phys
Date: Fri, 13 Dec 2024 17:43:58 +0530
Message-ID: <20241213121403.29687-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds support for rds ptp library in Microchip phys, where rds is internal
code name for ptp IP or hardware. This library will be re-used in
Microchip phys where same ptp hardware is used. Register base addresses
and mmd may changes, due to which base addresses and mmd is made variable
in this library.

Divya Koppera (5):
  net: phy: microchip_rds_ptp: Add header file for Microchip rds ptp
    library
  net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys
  net: phy: Kconfig: Add rds ptp library support and 1588 optional flag
    in Microchip phys
  net: phy: Makefile: Add makefile support for rds ptp in Microchip phys
  net: phy: microchip_t1 : Add initialization of ptp for lan887x

 drivers/net/phy/Kconfig             |    9 +-
 drivers/net/phy/Makefile            |    1 +
 drivers/net/phy/microchip_rds_ptp.c | 1008 +++++++++++++++++++++++++++
 drivers/net/phy/microchip_rds_ptp.h |  219 ++++++
 drivers/net/phy/microchip_t1.c      |   41 +-
 5 files changed, 1274 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/phy/microchip_rds_ptp.c
 create mode 100644 drivers/net/phy/microchip_rds_ptp.h

-- 
2.17.1


