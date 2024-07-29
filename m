Return-Path: <netdev+bounces-113512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755893ED64
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CECF1F224C2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98884A5C;
	Mon, 29 Jul 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WR72Rjq2"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EA8175E;
	Mon, 29 Jul 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234360; cv=none; b=F4eDUc/y+NG63281ltMAUyg8+n0cHxsojGlcwveWP8MX/o9C0TxUwVLJe8x+0sG3ciEuDdn8gZZKTjmpLkp8UIjL0rzRH/bua+uv2vQN2ing5is59MMFLkT7nIQJTx+DpLg7DJD+TdGYaHl8jPdykwx5/vKPthc3TnWUZNxLWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234360; c=relaxed/simple;
	bh=NwtyDjR8is4y5UCArmq5SjCJ6uSxygfqsI1TSRD5Bho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvUuCOttS08FtselY663en8T17xZUEkoVxQpMB97MpcIW19UhZ2BMLb6Vs8Ifo+W3rAyfBcf3PMaB1UXhkwHPzPNhlvwFocnFmsId0KaryYAnKKLLi1xAAQiiilm5yM7I+tKE53Paqn77UPs2PrUuwlXF1tp1bzAw2qSjqrgtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WR72Rjq2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46T6Pa4jA3600312, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722234336; bh=NwtyDjR8is4y5UCArmq5SjCJ6uSxygfqsI1TSRD5Bho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WR72Rjq2tk8etdsLrKXp44IncXDeMVe0LzXks3PTVnP03G4N8c8EEcJ2DMFYDgVUe
	 n+7AS3P3r3+Cc/RZ2O76ofaaT5AQqy8g13gE+4azdebyUAKmi3C8cGkRYp1uR020nL
	 ch8ofo6+DBfyJawlflLjyssWkILtfSsBsrFy1fOWCN91yPWfY5phuiWtEnEXfD+MCi
	 r7Vj4pF78YItMOWm8cZao6v39LEchZ8xM1qwUE9Flz+ranjtRtfmksgqsM6Pb3ixvB
	 ACo+DVNzlD+LdrEHIwQArkjJCMJMPar/N5PXodU4w5dqV793ef0E8kb3mcYRtf//4m
	 LXHyB1c8wTAzA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46T6Pa4jA3600312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:25:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 14:25:36 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Jul
 2024 14:25:36 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v25 09/13] rtase: Implement pci_driver suspend and resume function
Date: Mon, 29 Jul 2024 14:21:17 +0800
Message-ID: <20240729062121.335080-10-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729062121.335080-1-justinlai0215@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
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

Implement the pci_driver suspend function to enable the device
to sleep, and implement the resume function to enable the device
to resume operation.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 80673fa1e9a3..77cf6d383129 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2167,12 +2167,63 @@ static void rtase_shutdown(struct pci_dev *pdev)
 	rtase_reset_interrupt(pdev, tp);
 }
 
+static int rtase_suspend(struct device *device)
+{
+	struct net_device *dev = dev_get_drvdata(device);
+
+	if (netif_running(dev)) {
+		netif_device_detach(dev);
+		rtase_hw_reset(dev);
+	}
+
+	return 0;
+}
+
+static int rtase_resume(struct device *device)
+{
+	struct net_device *dev = dev_get_drvdata(device);
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	/* restore last modified mac address */
+	rtase_rar_set(tp, dev->dev_addr);
+
+	if (!netif_running(dev))
+		goto out;
+
+	rtase_wait_for_quiescence(dev);
+
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret) {
+		netdev_err(dev, "unable to init ring\n");
+		rtase_free_desc(tp);
+		return -ENOMEM;
+	}
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_device_attach(dev);
+out:
+
+	return 0;
+}
+
+static const struct dev_pm_ops rtase_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(rtase_suspend, rtase_resume)
+};
+
 static struct pci_driver rtase_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = rtase_pci_tbl,
 	.probe = rtase_init_one,
 	.remove = rtase_remove_one,
 	.shutdown = rtase_shutdown,
+	.driver.pm = pm_ptr(&rtase_pm_ops),
 };
 
 module_pci_driver(rtase_pci_driver);
-- 
2.34.1


