Return-Path: <netdev+bounces-183294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB1A8B990
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A52189EB09
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBDF3594B;
	Wed, 16 Apr 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UBaGp2CD"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808A134A8;
	Wed, 16 Apr 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807651; cv=none; b=eIIATBuv+PIk7q7i2f6nb9oA7DhfL0EB6KMuZw1+eHe4OMioKgrFUgXzTm9uUNYVNoE0snkhkrm/Fni7SwRo1y/yhEt2FKE3AN31kNZXT75c0iDgdr+X5xKinmo+g8eJTrBdLYVqbv2ROWiMyqPSvwWa4USEUR5iTwuArKd9bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807651; c=relaxed/simple;
	bh=tRK7Mw6CYOBN/JnDtQqLu4sNQOY4stUMtei2t4MDVO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtnLM2vIEqW3eD12hnRF9L75ofCfzTqbgAAsIwOWqHS4Mg3WUHXc7R02b60+iHPG/lyPy1/Hr1aZ7QDay3KbxmlE1a62L8xVNWQBMizap9gIkvb506SYQ7Ew6ULF4WXXUp91jp2Cq9aVHPoqccpIAdAYDtQBnHV6BDI1II4CC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UBaGp2CD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53GClCnH53270950, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744807632; bh=tRK7Mw6CYOBN/JnDtQqLu4sNQOY4stUMtei2t4MDVO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UBaGp2CDM5/v/ORRvvAAbpFG19IlHrjt2rpJBJjWM20zpc1tlLkj6sLuaTNsY6vXk
	 f4RGAgp5XVkD/JI3jalu3jx7X7AUyxVa+FjebkXqhVhIB7/FX0y2+luWuAAZxu2FgU
	 5+81oG//VzGtXLONTpTbRv+MddiCEaB2m9vnhINJgarR2m2EUgqbnxMLn34SpV8Mqh
	 lWI1WQlUGxufnMd0+AHKtdT5ZvublriHv6R0D9P343tUPTg4h+g7ncbeRgdyRTKcEp
	 39a6b+5ZmKy2bilNkczMPnK3VjjXMx/+mtgIWi/IxIXZk97j3AoNg0kg1eLIL/gArn
	 8Ciai/fMO0ogA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53GClCnH53270950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:47:12 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 20:47:13 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 20:47:12 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 3/3] rtase: Fix a type error in min_t
Date: Wed, 16 Apr 2025 20:45:34 +0800
Message-ID: <20250416124534.30167-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416124534.30167-1-justinlai0215@realtek.com>
References: <20250416124534.30167-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Fix a type error in min_t.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 55b8d3666153..bc856fb3d6f3 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1923,7 +1923,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 	u8 msb, time_count, time_unit;
 	u16 int_miti;
 
-	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
+	time_us = min_t(u32, time_us, RTASE_MITI_MAX_TIME);
 
 	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
 		msb = fls(time_us);
@@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
 	u8 msb, pkt_num_count, pkt_num_unit;
 	u16 int_miti;
 
-	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
+	pkt_num = min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
 
 	if (pkt_num > 60) {
 		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
-- 
2.34.1


