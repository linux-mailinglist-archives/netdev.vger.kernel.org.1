Return-Path: <netdev+bounces-108010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9663591D8BC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436DB1F217E2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21182488;
	Mon,  1 Jul 2024 07:15:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2682485
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818148; cv=none; b=uV+MH3e7hTjnjoCsznrGp2Ogxwn2VLhwdSQzN9esE/PCQ6FEF3V8LsqbW9Wt4rw99AvccSixqwOrCTPvKAg1VenfcYNCxUTTYtt+lGAL+VFHciKq0GVTBkvu02MR/uIivQ4VzV8OCWMk6bYb2kIe8roXPOrYtAvSGwg1iTXeCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818148; c=relaxed/simple;
	bh=I7WwPyvzFqQoTANFxrrVL2Adu9IbPe1umib9lie2EMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzQ6gY4CIgKSUqhMbIY5nDcva6A1bQmU5SGnlpkCCeGrierJvfDJ5mu3sbJ5ll+oUFwMsIg7eLtYVmMi/EA9YiEjMGZMs/dYwAKz3j8nuNa0/VQXu7vF9tnByulvziEtUXqkwzlhOgmXInA7/0xqdZ8N5hfDP28w4FnrNBiKu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1719818074tanjz6pb
X-QQ-Originating-IP: uocOLv+tPESES/ZHNSvyB9I1ChSvaqRaXZ63yQ7arsc=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jul 2024 15:14:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9763058144234461500
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 4/4] net: txgbe: free isb resources at the right time
Date: Mon,  1 Jul 2024 15:14:16 +0800
Message-Id: <20240701071416.8468-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240701071416.8468-1-jiawenwu@trustnetic.com>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When using MSI/INTx interrupt, the shared interrupts are still being
handled in the device remove routine, before free IRQs. So isb memory
is still read after it is freed. Thus move wx_free_isb_resources()
from txgbe_close() to txgbe_remove(). And fix the improper isb free
action in txgbe_open() error handling path.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c     | 4 +++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 2 ++
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 7 ++++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index e1f514b21090..81bedc8ee8d4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2028,6 +2028,9 @@ int wx_setup_isb_resources(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
 
+	if (wx->isb_mem)
+		return 0;
+
 	wx->isb_mem = dma_alloc_coherent(&pdev->dev,
 					 sizeof(u32) * 4,
 					 &wx->isb_dma,
@@ -2387,7 +2390,6 @@ static void wx_free_all_tx_resources(struct wx *wx)
 
 void wx_free_resources(struct wx *wx)
 {
-	wx_free_isb_resources(wx);
 	wx_free_all_rx_resources(wx);
 	wx_free_all_tx_resources(wx);
 }
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e894e01d030d..af30ca0312b8 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -387,6 +387,7 @@ static int ngbe_open(struct net_device *netdev)
 err_free_irq:
 	wx_free_irq(wx);
 err_free_resources:
+	wx_free_isb_resources(wx);
 	wx_free_resources(wx);
 	return err;
 }
@@ -408,6 +409,7 @@ static int ngbe_close(struct net_device *netdev)
 
 	ngbe_down(wx);
 	wx_free_irq(wx);
+	wx_free_isb_resources(wx);
 	wx_free_resources(wx);
 	phylink_disconnect_phy(wx->phylink);
 	wx_control_hw(wx, false);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 76b5672c0a17..ca74d9422065 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -296,7 +296,7 @@ static int txgbe_open(struct net_device *netdev)
 
 	err = txgbe_request_queue_irqs(wx);
 	if (err)
-		goto err_free_isb;
+		goto err_free_resources;
 
 	/* Notify the stack of the actual queue counts. */
 	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
@@ -313,8 +313,8 @@ static int txgbe_open(struct net_device *netdev)
 
 err_free_irq:
 	wx_free_irq(wx);
-err_free_isb:
-	wx_free_isb_resources(wx);
+err_free_resources:
+	wx_free_resources(wx);
 err_reset:
 	txgbe_reset(wx);
 
@@ -729,6 +729,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 
 	txgbe_remove_phy(txgbe);
 	txgbe_free_misc_irq(txgbe);
+	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
-- 
2.27.0


