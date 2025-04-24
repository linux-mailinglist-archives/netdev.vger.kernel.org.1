Return-Path: <netdev+bounces-185399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2376A9A1D6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A421663F2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71B1FDE1E;
	Thu, 24 Apr 2025 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kVR+Bvjb"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB61FAC54;
	Thu, 24 Apr 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475743; cv=none; b=MSZiq4WuzmrYXRDZUkMA5f7yG9T321BbMyoaW3V5Zp7gohlBL/of/zSaNdZsClm+Dof9tA9vI4jh0zgX4TbhTU/AAUlZITHiOhsJVQlvgTpjXGmXXKRl5Y02Fv88WZjKb+8Ss6pThfLNJvAuNV2jKt+B3rG+TzRpHDkA5YnqadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475743; c=relaxed/simple;
	bh=ZH/3QV6nOgqLnTJ+tkVZafLysGcPv+ncUTcAarFD+wI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gdjlUhdHHeValG6uMvT5r++yhnEeVS01Ep5O3JXIZ6c44dAosRilfv9miMaFHzlw9r20KWmodtrOGu9H662TZeJTCn/sgeriyhWPBrVt2mjfgQwjVCtL8FOfhb5yPsWTPjM7lSEcna86f+oDlDoYdcLyRRO7gK81cSqDF9XOJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kVR+Bvjb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53O6LqEK2044763, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745475712; bh=ZH/3QV6nOgqLnTJ+tkVZafLysGcPv+ncUTcAarFD+wI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kVR+BvjbkG7WlB+I0vPVRscpCIdkK6J0YhD3/qnWcOY9tejugjDUwGH84fyeZ1Lvh
	 MV9wrFvB7JMuRdxHj//SRrc6txNeXKsGhcnxJ+PVQZVvd3qh/nD9Uev+UjLkYXdw4y
	 vIgmVjuSsruXqdTiUbNA+iOp2KlsFcBNfdMVx/4FUTG8Bl4ujTmPhFkxuFwDjEMyFa
	 DRAma9Zr+WlmPPFzd1t9ByLvMNAvo3eb2oAvs+4IP/n+9/lX4snC4RCU3gxsIWBuE2
	 piwQKmEtAyTuZBHuc+tIz28aobZ2+4S/HPIqhSPRwhEzxq9LGoBfBOdWdvJZOMf1oh
	 K/BQb7BZrJbdg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53O6LqEK2044763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 14:21:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Apr 2025 14:21:52 +0800
Received: from RTDOMAIN (172.21.210.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 24 Apr
 2025 14:21:52 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next] rtase: Use min() instead of min_t()
Date: Thu, 24 Apr 2025 14:21:45 +0800
Message-ID: <20250424062145.9185-1-justinlai0215@realtek.com>
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

Use min() instead of min_t() to avoid the possibility of casting to the
wrong type.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 6251548d50ff..8c902eaeb5ec 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1983,7 +1983,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 	u8 msb, time_count, time_unit;
 	u16 int_miti;
 
-	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
+	time_us = min(time_us, RTASE_MITI_MAX_TIME);
 
 	msb = fls(time_us);
 	if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
@@ -2005,7 +2005,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
 	u8 msb, pkt_num_count, pkt_num_unit;
 	u16 int_miti;
 
-	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
+	pkt_num = min(pkt_num, RTASE_MITI_MAX_PKT_NUM);
 
 	if (pkt_num > 60) {
 		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
-- 
2.34.1


