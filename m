Return-Path: <netdev+bounces-183662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F3A91725
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE0117883C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554C225A3E;
	Thu, 17 Apr 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l8zZgzXB"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49F21ABDB;
	Thu, 17 Apr 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880329; cv=none; b=NHZYSjvYEaDdLcVFKqo/i5H+U+ZM4tPN0jqAs8RueqI4dEoGjuZdQCdLoZigyEucvs3QWwupRJDLfznp1oEEFsnW/7+0RI4mghaf8cuQ5P/LpQzFtbYSV0dfAIETug4LSVy9DKJE0uEnzk/1vGxv7AKeb0XoCAE28aaokHEXQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880329; c=relaxed/simple;
	bh=4FJsdCfn91/lkxy2lUFnPEV522v97mbzTnQHWoCV0h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICMNmVtH9QVotPcR3ynoNbiRtMh9927z7asbLNgijC5rcR8R3WSx7CoXv+IskT8M90c3p+AvflAKCPVJtsAdRJXcHjJqiphflgQgOS988D3NcB9uvyTwTPOuioY0WLHXOUNnAmtkEZHGA1+zv5zEx4R9xtmLwGUSyGOkOXNHWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l8zZgzXB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H8wWocD618370, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744880312; bh=4FJsdCfn91/lkxy2lUFnPEV522v97mbzTnQHWoCV0h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=l8zZgzXBB6AEiLr0+M2YuGHwO2fp5lqPO38IgbnzZoapjtXpcXxPSFoSvgS5T7XH5
	 wi8aWjLF2yd/58BOhfVYc7hD/FtMhVEH1O2djMzTVBbCIlveYgu0VuELfg8ZyPTzem
	 8xVKjuSxA95p9Rrd6W2ihjx6OAah4/ZcEPEUXWQSLf/EXN1tcIXyYZZHtaQxnVWOAn
	 UbyE0LSoQNZaELoAxK2m8Q6owMuA0kvM/EvE/euFAn6BVrmyjZ+GAPnRi/A82YyIFB
	 lH7O3ob2uV0YgXLiiaFLS2SDASr4kcWCV1sxVcSzmERQ76pVITBI+tMyZm9eW8gap/
	 gnPNUGHHExSWQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H8wWocD618370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:58:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 16:58:33 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 17 Apr
 2025 16:58:32 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        Andrew Lunn
	<andrew@lunn.ch>
Subject: [PATCH net v3 3/3] rtase: Fix a type error in min_t
Date: Thu, 17 Apr 2025 16:56:59 +0800
Message-ID: <20250417085659.5740-4-justinlai0215@realtek.com>
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
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Fix a type error in min_t.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


