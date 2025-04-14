Return-Path: <netdev+bounces-182092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0AAA87C05
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE35188A20C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AF26562C;
	Mon, 14 Apr 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="epb5rizE"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8320E700;
	Mon, 14 Apr 2025 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623454; cv=none; b=paMgeN9EbiejwCetWY0WYMZtyLJu7MVnUYtAtPojhxCSI2zYXYqWtX2Jo4v/yEzgx8YeNRivmSIrKGz6Zycq/4kxgWz5WFLgT/0Ac2vYm8Qu2yvkK05JZglV/osq5M5dCqn2+dJwpzd3N//puCFeW9Sh0yHipn7+nV3skgSnmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623454; c=relaxed/simple;
	bh=kp+M2KrPLl6VzIuGTQAyY8wQUEd/52xXmifPXNiiZ8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EvXXas7II+m0Js7uuqLQOMlejsrZmG5q2ilE/Vaz37n71uYGV8u+TPXvFH35Fznq4TUTRlPVL9V5yRzRAWjjcYz9e+0F189N1lvjL3Z96GPCAZsL5fNyJaXNt+Nl3OmkcGMgbHo4nEE4S4XQlu6pmthJHeHnwsKw6TBk1/ObAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=epb5rizE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53E9auQJ32753252, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744623416; bh=kp+M2KrPLl6VzIuGTQAyY8wQUEd/52xXmifPXNiiZ8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=epb5rizE0OllzmoxkyGuqiIQHkyjC/b9uuDEGblNXAtp8hVBOMSliyiskEqXCx+sR
	 K87Lh1GIDDdu9I+vaUwDGssfW+1qyPZcjzmDfsUl+D+aiPNUJTBtfHu8PVf4iYDnq7
	 gRgdshLRRSRsvZWd71pey2OO00chmaURNG/f3DjGQxsHGQ7d+/0axghr7K+6BB2h55
	 B73DBV2Qqu3WGleHx05CWE5YLVZArEWBFgDo1Ub3+o3JyJxbyAMa4C67ES0czBL/bm
	 NgFhkwljCipp1zoeQCMslihe126hSPX30ANkvGAAFLCg8denyrU2N07yKIsHzN+Nt9
	 FGOxUB0YOEGsw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53E9auQJ32753252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 17:36:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Apr 2025 17:36:57 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 14 Apr
 2025 17:36:56 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH net] rtase: Fix kernel test robot issue
Date: Mon, 14 Apr 2025 17:36:45 +0800
Message-ID: <20250414093645.21181-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

1. Fix the compile error reported by the kernel test robot by modifying
the condition used to detect overflow in rtase_calc_time_mitigation.
2. Fix the compile warning reported by the kernel test robot by
increasing the size of ivec->name.
3. Fix a type error in min_t.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.com/
Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h      | 2 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 2bbfcad613ab..1e63b5826da1 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -259,7 +259,7 @@ union rtase_rx_desc {
 #define RTASE_VLAN_TAG_MASK     GENMASK(15, 0)
 #define RTASE_RX_PKT_SIZE_MASK  GENMASK(13, 0)
 
-#define RTASE_IVEC_NAME_SIZE (IFNAMSIZ + 10)
+#define RTASE_IVEC_NAME_SIZE (IFNAMSIZ + 14)
 
 struct rtase_int_vector {
 	struct rtase_private *tp;
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 2aacc1996796..bc856fb3d6f3 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1923,10 +1923,10 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 	u8 msb, time_count, time_unit;
 	u16 int_miti;
 
-	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
+	time_us = min_t(u32, time_us, RTASE_MITI_MAX_TIME);
 
-	msb = fls(time_us);
-	if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
+	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
+		msb = fls(time_us);
 		time_unit = msb - RTASE_MITI_COUNT_BIT_NUM;
 		time_count = time_us >> (msb - RTASE_MITI_COUNT_BIT_NUM);
 	} else {
@@ -1945,7 +1945,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
 	u8 msb, pkt_num_count, pkt_num_unit;
 	u16 int_miti;
 
-	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
+	pkt_num = min_t(u16, pkt_num, RTASE_MITI_MAX_PKT_NUM);
 
 	if (pkt_num > 60) {
 		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
-- 
2.34.1


