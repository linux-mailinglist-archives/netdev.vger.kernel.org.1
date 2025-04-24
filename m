Return-Path: <netdev+bounces-185393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1EFA99FFF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CF5188EE03
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853819D884;
	Thu, 24 Apr 2025 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JroYeDdf"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E619CC3D;
	Thu, 24 Apr 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745467529; cv=none; b=UJT7HvkzfY+zB8bI1CPDhC9QFSUzBtAe978SHaEl28bE7nBlZMzqsOk5n8oh3Oti2ddHFe45npekqiOhv/1a895VoZ23XBlha/zp2cus9Skt/N/giHG1qPJHSuiT/4Fgn9priSn4Rg9qpB+MTb99SmjxPDliqhJGRS4zEOD3MgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745467529; c=relaxed/simple;
	bh=C0fT7nTb4i7lur/awzNdei1Byl5mpGyS71sQxaNBIuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKhX4t6jVkH4ugJ+n+ZLhIeBgmDUoHYc3do/mhQNfkrkOjunLhqT86lHRqGSF5206kBatke3SSri94KSXYd33+uiNQrWqf8pqAbvJzcFkZFPMPVXO5jKEyINXdy5gpb/fwH1R+wDkOxPckR1dj8J0ryxr80f6RDOEQVtdZkkBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JroYeDdf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53O44qYpA4054997, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745467492; bh=C0fT7nTb4i7lur/awzNdei1Byl5mpGyS71sQxaNBIuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=JroYeDdfNUY387WH9CRYxi8U0q9lXCevPzBzWyHiBzeJIKmbD/z2d4zB/yutieFy8
	 mEx4zO49PcXUMcgiRfNI+9VR6y2G/3YDeQNn5jkZYGAJSWxO+kBjVM/Ba5u/FIsuNh
	 tOSQHJQUSs2FECTci71pcJxwKLDa0fWoK60FWj/+XpvN4u27+bLTRg8NfgjfXUH9WU
	 cLC7bnwjsGsmW+Kg9b5PosvySqrGx2hoEtH71z2YcHcUofVlX58ckF3qFNqIRH09GY
	 K84HwBHvHPFrmZuWj2qlkxAIooreeLrdomzB262Pavs4GmVSLr6n1vOJChET5q6e5e
	 JJpvzu6B5fI5A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53O44qYpA4054997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 12:04:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Apr 2025 12:04:52 +0800
Received: from RTDOMAIN (172.21.210.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 24 Apr
 2025 12:04:51 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH net] rtase: Modify the condition used to detect overflow in rtase_calc_time_mitigation
Date: Thu, 24 Apr 2025 12:04:44 +0800
Message-ID: <20250424040444.5530-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


