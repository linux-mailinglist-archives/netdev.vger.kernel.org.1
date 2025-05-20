Return-Path: <netdev+bounces-191723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9CCABCE29
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 06:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391B17AD484
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D882580FF;
	Tue, 20 May 2025 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="A4eeK5gg"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427478F40;
	Tue, 20 May 2025 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747714876; cv=none; b=YI4k3uZkVsWDci3WyXteb0l2XoFa6qH++we9L+pQT8HzjdqeqqLEX0KEp+sbehdQ3RM1jLSiPUzN6rRhvCMpW5fSwpu5+6xco/RjeRU/Kts2lXW3oTaLD/q4RzmBxft6UM2MMpvSzgIl7455yHmaNKFMuVLTqjiN9YhiEjKv1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747714876; c=relaxed/simple;
	bh=tki70zGOXe8uDLHnr4w6sI/6H1GrLHAbBVvNzaE1BS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QODmCwwKmV/N0PdKmJgbpWrvaMVa+okolW4fDhO0x51XKwmq8RTWGyOEfcO91QiSsY9Gg00fbCmeJQlBdsomEX9WM96xsRonjVRsb5+jAw5SAjGmg6GkCDC2upZaPb+6vRaRiV11oIXt4/4PVJtUjnjg40oGuAAemvFifwnY/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=A4eeK5gg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54K4KhKkA2041609, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747714843; bh=tki70zGOXe8uDLHnr4w6sI/6H1GrLHAbBVvNzaE1BS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=A4eeK5ggZhxkpEGEmGvxmMlQtiwm7BqF9eWmUuyIl6PVe/bzXU9wneF4NvbDJaItw
	 bMLLPfV6QErE0flYeCvseidF6uJ9J0W0MTwhKwo4IC20l1AsG3p0vDQTT6nxyhzZK+
	 bgfSgPwdYIwx8QY+Sr2I7Gsc9rU83L6xq7uMxA3Ws2gJVDDMb8p5h5IKG6Q2hits8U
	 a9IdUuCbkr+74yzhTmbUy24+qYbjpb5Da7YUgJeZVHW/DF7yW8Uh4ory+WpUqOccTe
	 Z63dYstq/nJ0QYo1MT6Z+HD2XxzBg/iDswH5V9Tk9Gw2knd0DAnFRTNLEFFPqVD7HC
	 2qtglQT8Je25A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54K4KhKkA2041609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 12:20:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 May 2025 12:20:43 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 20 May
 2025 12:20:43 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        Joe Damato
	<jdamato@fastly.com>
Subject: [PATCH net-next v3] rtase: Use min() instead of min_t()
Date: Tue, 20 May 2025 12:20:31 +0800
Message-ID: <20250520042031.9297-1-justinlai0215@realtek.com>
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

Use min() instead of min_t() to avoid the possibility of casting to the
wrong type.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
v1 -> v2:
- Remove the Fixes tag.
 
v2 -> v3:
- Nothing has changed, and it simply has been rebased and reposted.
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 0efe7668e498..4d37217e9a14 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1983,7 +1983,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 	u8 msb, time_count, time_unit;
 	u16 int_miti;
 
-	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
+	time_us = min(time_us, RTASE_MITI_MAX_TIME);
 
 	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
 		msb = fls(time_us);
@@ -2005,7 +2005,7 @@ static u16 rtase_calc_packet_num_mitigation(u16 pkt_num)
 	u8 msb, pkt_num_count, pkt_num_unit;
 	u16 int_miti;
 
-	pkt_num = min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
+	pkt_num = min(pkt_num, RTASE_MITI_MAX_PKT_NUM);
 
 	if (pkt_num > 60) {
 		pkt_num_unit = RTASE_MITI_MAX_PKT_NUM_IDX;
-- 
2.34.1


