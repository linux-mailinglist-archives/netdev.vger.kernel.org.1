Return-Path: <netdev+bounces-145723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EB9D0857
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 05:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B465A1F21BE7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89BA81745;
	Mon, 18 Nov 2024 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H4E0+XAk"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB817C98;
	Mon, 18 Nov 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903045; cv=none; b=FKF8hv6NaayFskU8QQne5UZ5D5bPWp1rG21/mGUW9nxBa5cfnJcP7WcpcPppslBMkQSPsvxEHbVfIvaHwWPcZOpnIO/880qPphyaW5Oifc3FVXkZMCpL3TncwPeG26AlmkSs7zNeBY9dQd7srizbQQ2nd/q2mFvRVNjxZBGM3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903045; c=relaxed/simple;
	bh=ow1vGg4eO+2OEbxNFP6nOJmj1FB88Ng9OVoBewOdaRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIDH5XN2Jl/USp5hiQ3naNDadge5eHeVj6bOmI93tOYd0iABrXCUToWeYumxS+jB7tzY9JSBsl05alv/VJ2Dawtaw/y0TZbF/bi5ZhjJYt7WJb6RHukhewiFLswSMTPi2DdWjIwel7PBeQTaaIOEmx3rLO8bgRkY6wrZlySWWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H4E0+XAk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI4AS8w8108806, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731903028; bh=ow1vGg4eO+2OEbxNFP6nOJmj1FB88Ng9OVoBewOdaRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=H4E0+XAkkFu5/Skl/CXhtETYuUPBjwTEnZfAPjRxGvh2KRcldtILrVJrZOJvshvcJ
	 U2T8LDB0ZgxtwGi7cmwEDnm64xpy6BG67C6Kntu63aIxLrmxIVIdwf+slo2uHQZ1+q
	 7uEnTc3xbt/uRnrORsdhNbv9Z4ADzatvpcRHyWScHVDhXHG6EP4VNNDz9HiXc20z1m
	 KIKV+4sTmKDE3TWQoEdiT6kZm/CJ0ky3UKVvN+ekUl0qk2IKRkHqX/myri9qCCnIMo
	 A6qmfgi+DvRL4besCHQd98RX4kdbp4DLzKkW0/7WvPIizc6z1uKp1OMe6q++8VnV3j
	 e2ctgsPM/mSTg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI4AS8w8108806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:10:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:10:28 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:10:28 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3 4/4] rtase: Add defines for hardware version id
Date: Mon, 18 Nov 2024 12:08:28 +0800
Message-ID: <20241118040828.454861-5-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118040828.454861-1-justinlai0215@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
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

Add defines for hardware version id.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 547c71937b01..4a4434869b10 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -9,7 +9,10 @@
 #ifndef RTASE_H
 #define RTASE_H
 
-#define RTASE_HW_VER_MASK 0x7C800000
+#define RTASE_HW_VER_MASK     0x7C800000
+#define RTASE_HW_VER_906X_7XA 0x00800000
+#define RTASE_HW_VER_906X_7XC 0x04000000
+#define RTASE_HW_VER_907XD_V1 0x04800000
 
 #define RTASE_RX_DMA_BURST_256       4
 #define RTASE_TX_DMA_BURST_UNLIMITED 7
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 26331a2b7b2d..1bfe5ef40c52 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1720,11 +1720,11 @@ static int rtase_get_settings(struct net_device *dev,
 						supported);
 
 	switch (tp->hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
 		cmd->base.speed = SPEED_5000;
 		break;
-	case 0x04800000:
+	case RTASE_HW_VER_907XD_V1:
 		cmd->base.speed = SPEED_10000;
 		break;
 	}
@@ -1990,9 +1990,9 @@ static int rtase_check_mac_version_valid(struct rtase_private *tp)
 	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
 
 	switch (tp->hw_ver) {
-	case 0x00800000:
-	case 0x04000000:
-	case 0x04800000:
+	case RTASE_HW_VER_906X_7XA:
+	case RTASE_HW_VER_906X_7XC:
+	case RTASE_HW_VER_907XD_V1:
 		ret = 0;
 		break;
 	}
-- 
2.34.1


