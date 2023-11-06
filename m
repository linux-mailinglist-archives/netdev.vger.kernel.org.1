Return-Path: <netdev+bounces-46214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2937E284E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A73B20CA5
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021228E02;
	Mon,  6 Nov 2023 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761228DCB
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 15:11:41 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545AD51
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:11:38 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A6FBYSU03568828, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A6FBYSU03568828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 23:11:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 23:11:34 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Nov 2023 23:11:31 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net 1/2] r8169: add handling DASH when DASH is disabled
Date: Mon, 6 Nov 2023 23:11:23 +0800
Message-ID: <20231106151124.9175-2-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106151124.9175-1-hau@realtek.com>
References: <20231106151124.9175-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.228.55]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

For devices that support DASH, even DASH is disabled, there may still
exist a default firmware that will influence device behavior.
So driver needs to handle DASH for devices that support DASH, no matter
the DASH status is.

Fixes: ee7a1beb9759 ("r8169:call "rtl8168_driver_start" "rtl8168_driver_stop" only when hardware dash function is enabled")
Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 37 +++++++++++++++++------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4b8251cdb436..8cbd7c96d9e1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -624,6 +624,7 @@ struct rtl8169_private {
 
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
+	unsigned dash_enable:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rtl8169_private *tp)
 	return r8168ep_ocp_read(tp, 0x128) & BIT(0);
 }
 
-static enum rtl_dash_type rtl_check_dash(struct rtl8169_private *tp)
+static bool rtl_check_dash(struct rtl8169_private *tp)
+{
+	switch (tp->dash_type) {
+	case RTL_DASH_DP:
+		return r8168dp_check_dash(tp);
+	case RTL_DASH_EP:
+		return r8168ep_check_dash(tp);
+	default:
+		return 0;
+	}
+}
+
+static enum rtl_dash_type rtl_check_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
-		return r8168dp_check_dash(tp) ? RTL_DASH_DP : RTL_DASH_NONE;
+		return RTL_DASH_DP;
 	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
-		return r8168ep_check_dash(tp) ? RTL_DASH_EP : RTL_DASH_NONE;
+		return RTL_DASH_EP;
 	default:
 		return RTL_DASH_NONE;
 	}
@@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 
 	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enable) {
 		rtl_set_d3_pll_down(tp, !wolopts);
 		tp->dev->wol_enabled = wolopts ? 1 : 0;
 	}
@@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enable)
 		return;
 
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
@@ -4867,7 +4880,7 @@ static int rtl8169_runtime_idle(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_enable)
 		return -EBUSY;
 
 	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
@@ -4894,7 +4907,7 @@ static void rtl_shutdown(struct pci_dev *pdev)
 	rtl_rar_set(tp, tp->dev->perm_addr);
 
 	if (system_state == SYSTEM_POWER_OFF &&
-	    tp->dash_type == RTL_DASH_NONE) {
+		!tp->dash_enable) {
 		pci_wake_from_d3(pdev, tp->saved_wolopts);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
@@ -5252,7 +5265,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
 	tp->aspm_manageable = !rc;
 
-	tp->dash_type = rtl_check_dash(tp);
+	tp->dash_type = rtl_check_dash_type(tp);
+	tp->dash_enable = rtl_check_dash(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
@@ -5323,7 +5337,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* configure chip for default features */
 	rtl8169_set_features(dev, dev->features);
 
-	if (tp->dash_type == RTL_DASH_NONE) {
+	if (!tp->dash_enable) {
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
@@ -5363,7 +5377,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    "ok" : "ko");
 
 	if (tp->dash_type != RTL_DASH_NONE) {
-		netdev_info(dev, "DASH enabled\n");
+		if (tp->dash_enable)
+			netdev_info(dev, "DASH enabled\n");
+		else
+			netdev_info(dev, "DASH disabled\n");
 		rtl8168_driver_start(tp);
 	}
 
-- 
2.39.2


