Return-Path: <netdev+bounces-33094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335F79CB86
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E950281AB1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3316419;
	Tue, 12 Sep 2023 09:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F816414
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:19:12 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 867E810C4;
	Tue, 12 Sep 2023 02:19:10 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38C9ImM422457805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38C9ImM422457805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Sep 2023 17:18:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 12 Sep 2023 17:18:47 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 12 Sep
 2023 17:18:46 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v7 09/13] net:ethernet:realtek:rtase: Implement pci_driver suspend and resume function
Date: Tue, 12 Sep 2023 17:18:26 +0800
Message-ID: <20230912091830.338164-10-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912091830.338164-1-justinlai0215@realtek.com>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.21.210.160]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Implement the pci_driver suspend function to enable the device
to sleep, and implement the resume function to enable the device
to resume operation.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index f5be2741bf94..83f64e283891 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2222,12 +2222,73 @@ static void rtase_shutdown(struct pci_dev *pdev)
 	rtase_reset_interrupt(pdev, tp);
 }
 
+#ifdef CONFIG_PM
+static int rtase_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	netif_device_detach(dev);
+	rtase_hw_reset(dev);
+
+out:
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static int rtase_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	/* restore last modified mac address */
+	rtase_rar_set(tp, dev->dev_addr);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_wait_for_quiescence(dev);
+	netif_device_attach(dev);
+
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret)
+		netdev_alert(dev, "unable to init ring\n");
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+out:
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_driver rtase_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = rtase_pci_tbl,
 	.probe = rtase_init_one,
 	.remove = rtase_remove_one,
 	.shutdown = rtase_shutdown,
+#ifdef CONFIG_PM
+	.suspend = rtase_suspend,
+	.resume = rtase_resume,
+#endif
 };
 
 module_pci_driver(rtase_pci_driver);
-- 
2.34.1


