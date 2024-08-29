Return-Path: <netdev+bounces-123060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D096390D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BF3B23CF1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D64AECE;
	Thu, 29 Aug 2024 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FYGA4qZG"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257233B796;
	Thu, 29 Aug 2024 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903611; cv=none; b=bWP0/i1TfUFGL7zoSXNUt78sMpYkAYbvw9TP7GOy/3FGJNlqno+ZMJcKvvVD1UjhLMVJM7hjBio3VHGl4JqoPjiYjZTbbmS19TI6nSi/EscSqCTGT36QiL5LRF37sVKbuom933cNFN2ZgrpIKCftXEMjh77nMh7Fzw+mFw3Uy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903611; c=relaxed/simple;
	bh=3Ht4dnB1XqAFhIv6tCt3sOLJMZ76FbNZeAmtZXklZ3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBQW6CP985D747YEN2/06OyOrOlwqamLaQk/67wfSfcxqKIbpwEZlhz/o0aKI1HJQ/n+OsNwtkQZ5eZjnmV/rMYt6ZUOVEjHcY3xzcAEhM+i9GcskaIjVXMni8hqwhIHjQG57kUW8TGZ+FviAMo2WgnGAQpJjWOWeKVpi5meE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FYGA4qZG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47T3r2pM53108788, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724903582; bh=3Ht4dnB1XqAFhIv6tCt3sOLJMZ76FbNZeAmtZXklZ3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=FYGA4qZGTxNJrNgd6DARP+Gs/uT3krtOR2HRdaM0yZfJQ4rG0Fn/jaewlfoEQTe0R
	 tajGy3WWdTCZko0nb7Zpfnz30auOlsJrB9RsRchoiayX7Ec/MShUe/9Om5EdmmLQ04
	 d7LVHvzVpdMnT+MdFMq3MIBZCAKhYHoJD6maSgsqMZ6YIvrAP3wGxEZEXfI//7NI7B
	 NE1Bm/i3IHS7hXun5Gse1j6C7AxwME/05U6nWwNClQ+94vlTsPPO9U+OSS/VoOLh9l
	 ng8zCWfnthAYSGE99R7VOESlsqQdKrxku2rwqSDsnGRxiT7wiJypMStbP5ttPsyFL8
	 r2mPuLHLFowzQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47T3r2pM53108788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:53:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 11:53:02 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Aug
 2024 11:53:02 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v29 09/13] rtase: Implement pci_driver suspend and resume function
Date: Thu, 29 Aug 2024 11:48:28 +0800
Message-ID: <20240829034832.139345-10-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829034832.139345-1-justinlai0215@realtek.com>
References: <20240829034832.139345-1-justinlai0215@realtek.com>
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

Implement the pci_driver suspend function to enable the device
to sleep, and implement the resume function to enable the device
to resume operation.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 57c2b18bcb57..059e911218e2 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2152,12 +2152,63 @@ static void rtase_shutdown(struct pci_dev *pdev)
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


