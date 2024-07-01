Return-Path: <netdev+bounces-108008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E584991D8BA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF4A1F21B0D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36C7406D;
	Mon,  1 Jul 2024 07:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552880623
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818134; cv=none; b=XiuXftK4oujZJkcJdSaUifzDoRaNASAtO3dW2ibRvnyRksumupmJxXemu0PxGLmbwptz8TcJAqaq8l1unGsmEz3c4dTMlWThpkKyhImyQfDefQNW3oQmNqVg+enfVaIIfjZncs49krJj887ZlAxn0Tb+kgKHJqa7iNzjsWdUtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818134; c=relaxed/simple;
	bh=jkVfl18CTkUJ1OOtDxOxkicO0213+0vWOL+JebwN+4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jx38H8Vn+STcFLHb7BQuuUC8yrxC6OBT+KvLo5Tgt9LqvRVzYttCUbx3dIWcj7y8AP+BUcH4D2Eo/Pa2bDhtb1GaTo//lKPGb6G048lI6TRh44pwCu/G902OETFRjIdg7QphPGTzzy3jjrLXT7VjHdV9hIDV03u6E6sKBwee/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp86t1719818072tyn5chvb
X-QQ-Originating-IP: pfF+L1tYYwLgqmP/R3T6hJht6lAkqVP4TJWK8D5Y8KU=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.148.68])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jul 2024 15:14:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14090906609733261651
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
Subject: [PATCH net v3 3/4] net: txgbe: add extra handle for MSI/INTx into thread irq handle
Date: Mon,  1 Jul 2024 15:14:15 +0800
Message-Id: <20240701071416.8468-4-jiawenwu@trustnetic.com>
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

Rename original txgbe_misc_irq_handle() to txgbe_misc_irq_thread_fn()
since it is the handle thread to wake up. And add the primary handler
to deal the case of MSI/INTx, because there is a schedule NAPI poll.

Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 44 ++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 1490fd6ddbdf..a4cf682dca65 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -111,6 +111,36 @@ static const struct irq_domain_ops txgbe_misc_irq_domain_ops = {
 };
 
 static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
+{
+	struct wx_q_vector *q_vector;
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	u32 eicr;
+
+	if (wx->pdev->msix_enabled)
+		return IRQ_WAKE_THREAD;
+
+	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
+	if (!eicr) {
+		/* shared interrupt alert!
+		 * the interrupt that we masked before the ICR read.
+		 */
+		if (netif_running(wx->netdev))
+			txgbe_irq_enable(wx, true);
+		return IRQ_NONE;        /* Not our interrupt */
+	}
+	wx->isb_mem[WX_ISB_VEC0] = 0;
+	if (!(wx->pdev->msi_enabled))
+		wr32(wx, WX_PX_INTA, 1);
+
+	/* would disable interrupts here but it is auto disabled */
+	q_vector = wx->q_vector[0];
+	napi_schedule_irqoff(&q_vector->napi);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 {
 	struct txgbe *txgbe = data;
 	struct wx *wx = txgbe->wx;
@@ -157,6 +187,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
 
 int txgbe_setup_misc_irq(struct txgbe *txgbe)
 {
+	unsigned long flags = IRQF_ONESHOT;
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
@@ -170,14 +201,17 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 		irq_create_mapping(txgbe->misc.domain, hwirq);
 
 	txgbe->misc.chip = txgbe_irq_chip;
-	if (wx->pdev->msix_enabled)
+	if (wx->pdev->msix_enabled) {
 		txgbe->misc.irq = wx->msix_entry->vector;
-	else
+	} else {
 		txgbe->misc.irq = wx->pdev->irq;
+		if (!wx->pdev->msi_enabled)
+			flags |= IRQF_SHARED;
+	}
 
-	err = request_threaded_irq(txgbe->misc.irq, NULL,
-				   txgbe_misc_irq_handle,
-				   IRQF_ONESHOT,
+	err = request_threaded_irq(txgbe->misc.irq, txgbe_misc_irq_handle,
+				   txgbe_misc_irq_thread_fn,
+				   flags,
 				   wx->netdev->name, txgbe);
 	if (err)
 		goto del_misc_irq;
-- 
2.27.0


