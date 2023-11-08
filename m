Return-Path: <netdev+bounces-46691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473337E5D77
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAF2813A1
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B636AFB;
	Wed,  8 Nov 2023 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167632C75
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:50:56 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CB210D;
	Wed,  8 Nov 2023 10:50:55 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A8Io8Or91018641, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A8Io8Or91018641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Nov 2023 02:50:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 9 Nov 2023 02:50:07 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 9 Nov 2023 02:50:06 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>
CC: <nic_swsd@realtek.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, ChunHao Lin <hau@realtek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH net v2 2/2] r8169: fix network lost after resume on DASH systems
Date: Thu, 9 Nov 2023 02:48:49 +0800
Message-ID: <20231108184849.2925-3-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108184849.2925-1-hau@realtek.com>
References: <20231108184849.2925-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.228.55]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Device that support DASH may be reseted or powered off during suspend.
So driver needs to handle DASH during system suspend and resume. Or
DASH firmware will influence device behavior and causes network lost.

Signed-off-by: ChunHao Lin <hau@realtek.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 108dc75050ba..5027cd595fe6 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4661,10 +4661,16 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl8169_cleanup(tp);
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
+
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_stop(tp);
 }
 
 static void rtl8169_up(struct rtl8169_private *tp)
 {
+	if (tp->dash_type != RTL_DASH_NONE)
+		rtl8168_driver_start(tp);
+
 	pci_set_master(tp->pci_dev);
 	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
-- 
2.39.2


