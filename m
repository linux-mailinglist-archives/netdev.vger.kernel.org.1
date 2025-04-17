Return-Path: <netdev+bounces-183660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6476A9171B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE6B5A4959
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB722576D;
	Thu, 17 Apr 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q8l7BsbB"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57D222590;
	Thu, 17 Apr 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880283; cv=none; b=TNu/exqXxJqR2kP3XcxvAVuDLFc9MglpuNhNFRGcAcbA21KCqtCg9+66eveJ84+uMyk8c+gDbVymp59pS42KBwPBina/cQoZenChpH+nN/NCdHs74LlmJsXkb1lbi/swb2YyLBXl5SFU8ewBOV3A3P08EkNMWNIAZIdizVU/baQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880283; c=relaxed/simple;
	bh=zIn0km++2bJjxdtNcvt3p0b/gp8d2fo9+lm8abcL1Kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/Yazc1eoHXzct3SL3OCM9SUUvBUWRky2hwAsYmwCsKsToo6uKIP6tBjPa31CvXk4fXWX3lvGs/Eng0lUMxsbBPE0sugpZW4kqOgOBszh5TKZMRXDurW03W8/Es2BSlnmJvEQ/pX0GaX6yvWj+bGDU0mm/lE3kY6m8mwfc8rajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q8l7BsbB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H8vetsF616119, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744880260; bh=zIn0km++2bJjxdtNcvt3p0b/gp8d2fo9+lm8abcL1Kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Q8l7BsbB3R3dNnPkIZFj1FYcGxtWEdQb+Q2oF8tby54mbj1om/q+aKIgHNRRGPx1G
	 DOcxJJQekq9t4+vqVUy+j6zbLF+pwFcUvD/BGPs4ITSQbZhw5yvzf5myF+q/Up+yaa
	 v4FpQIYFlFbuFG92O4tIDBnHngTq7xJH2Ibc5P1jXZUGlvKMORE4AdbkLwSG9fzEF3
	 0bQ5ybIJxP1WhRx590J+IPEgygMT5xt4bl86S7UsHDi7qFm/hbmo0BCWCHWhsG2SZ7
	 aEAnakavejXp3UpdLEhhbONoLOYv54PPlXl4BnBcODhw5CYVN+hj/xV0+G051PL6xO
	 6pp1Esw9sJ8kg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H8vetsF616119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:57:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 16:57:40 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 17 Apr
 2025 16:57:39 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH net v3 1/3] rtase: Modify the condition used to detect overflow in rtase_calc_time_mitigation
Date: Thu, 17 Apr 2025 16:56:57 +0800
Message-ID: <20250417085659.5740-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085659.5740-1-justinlai0215@realtek.com>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Fix the following compile error reported by the kernel test
robot by modifying the condition used to detect overflow in
rtase_calc_time_mitigation.

In file included from include/linux/mdio.h:10:0,
                  from drivers/net/ethernet/realtek/rtase/rtase_main.c:58:
 In function 'u16_encode_bits',
     inlined from 'rtase_calc_time_mitigation.constprop' at drivers/net/
     ethernet/realtek/rtase/rtase_main.c:1915:13,
     inlined from 'rtase_init_software_variable.isra.41' at drivers/net/
     ethernet/realtek/rtase/rtase_main.c:1961:13,
     inlined from 'rtase_init_one' at drivers/net/ethernet/realtek/
     rtase/rtase_main.c:2111:2:
>> include/linux/bitfield.h:178:3: error: call to '__field_overflow'
      declared with attribute error: value doesn't fit into mask
    __field_overflow();     \
    ^~~~~~~~~~~~~~~~~~
 include/linux/bitfield.h:198:2: note: in expansion of macro
 '____MAKE_OP'
   ____MAKE_OP(u##size,u##size,,)
   ^~~~~~~~~~~
 include/linux/bitfield.h:200:1: note: in expansion of macro
 '__MAKE_OP'
  __MAKE_OP(16)
  ^~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.com/
Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 2aacc1996796..55b8d3666153 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1925,8 +1925,8 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 
 	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
 
-	msb = fls(time_us);
-	if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
+	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
+		msb = fls(time_us);
 		time_unit = msb - RTASE_MITI_COUNT_BIT_NUM;
 		time_count = time_us >> (msb - RTASE_MITI_COUNT_BIT_NUM);
 	} else {
-- 
2.34.1


