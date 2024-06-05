Return-Path: <netdev+bounces-100927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD78FC8C9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098B91C21069
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C118FDDF;
	Wed,  5 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w/vYexpZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51411946D5;
	Wed,  5 Jun 2024 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582752; cv=none; b=dQSxav63ONYbd4rw3bB7/VFhJftL+PvhUdyJSuxiR+QQw42r7skyGm2i2Mr4Grynq1TpVUnCq13O5LvlpcHDid0nHFHQbjmNdXnRBIOE0hDuPFe3adWbfiDP34sdmmgXitjRLa7isP9BRl9Wq9N9ZTEYC91aztaDjWlMgWasJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582752; c=relaxed/simple;
	bh=IcBGzd2i5NFVkQBmEfgL5JoXdygRuf51+9PaFU0XsSo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GVQMpwQ0BtusDR6Iwbsrf/VaXs9V6sf31ko3jiRaxj7tKDDE31Lx25BxzlrG8ZMBYN+APq9FdE1asDDefYM3s8N5UWNgVfsLgHk7wpNSOGEnIduiB/n5A1THdSDuxtFIhePgLNPDrxfQxnOOezLHuhjOFUpU0VD6+CIXiC6GYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w/vYexpZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717582750; x=1749118750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcBGzd2i5NFVkQBmEfgL5JoXdygRuf51+9PaFU0XsSo=;
  b=w/vYexpZ7CtbN5MUSAVugJKW1MUghTcKhnwa5yzWTKJc7XgEnxuDLB+p
   2Vp06hb919w+AuqdS7VDN7VRjCndUK+jWaF+K1KJD7LTK9ncWqMi3EUoc
   co9DFW8UgrciHGPUkDXbCOJnJX8fMNWseC5OpgoCSo25XZEDH+xnHw1Eu
   XDECI0+nrYROZQhVloVG3EO2nb+j8BjIpio21KjA60xHaanSspBwNqzpQ
   sIM1xCCtkc+xSTgMdaXjsZ//9qn1KHPgXGuLmR3L25I7Aw4JPUErZDaS0
   0LCyfqkw5WYVyJroZa6Y2ZEwsLyJ5l2YWkixxG68sxLCikV+PIXJ8BsT5
   g==;
X-CSE-ConnectionGUID: t/O8Z945TGity0AczrxMxw==
X-CSE-MsgGUID: UybH7n7aSKGF62NtQNBxuQ==
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="29396149"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 03:19:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 03:19:00 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 5 Jun 2024 03:18:56 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net V3 0/3] net: lan743x: Fixes for multiple WOL related issues
Date: Wed, 5 Jun 2024 15:46:08 +0530
Message-ID: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
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
 drivers/net/ethernet/microchip/lan743x_main.c | 46 ++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h | 28 +++++++++
 drivers/net/phy/mxl-gpy.c                     | 58 ++++++++++++-------
 4 files changed, 144 insertions(+), 32 deletions(-)

-- 
2.34.1


