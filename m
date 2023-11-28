Return-Path: <netdev+bounces-51623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F378C7FB6AA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB94282762
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C44C3BC;
	Tue, 28 Nov 2023 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33699D56
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:04:58 -0800 (PST)
X-QQ-mid: bizesmtp88t1701165843tgzr5l2b
Received: from wxdbg.localdomain.com ( [183.128.129.197])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Nov 2023 18:03:46 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 2w1wQVt6itS10hN4m1tv4CJaJVciC1nnqOrAohlg3NlTGmq+TdU21og79cyxj
	FGw5YGwUFwNO4SgUsIvNax18Fb3Bv6d3ekEwM2F/WD+2+phpVf+2BDAU8fVeC+56YcHtW8p
	7iX/BsuhnA+0eh0F+EU7A21V4Qf5CrKUCsrxKVFMPjemY7LPl0/iNnzJAksFkWG82pCCZrz
	eBGFjpBteXZeO3xnl4wJds48wRJ44uY89/bImNvKe14M1ILFy/1cYpFSbkYfX15iwz0HVwV
	PVMZbB7ageLZFeHltYJlYOjq9GB4DmsDagIa1KK9Gh8dytNodpDIMXxbh4fOavd934kLeZG
	KP8Itp79Xcl7sEfzZA0K6QJCEgwue11w0H6P2LIqldeWSHZBsdgMv+jgPCjtMEpksF2KO5v
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8251242974751596196
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: fix memory leak on msix entry
Date: Tue, 28 Nov 2023 17:59:28 +0800
Message-Id: <20231128095928.1083292-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Since pci_free_irq_vectors() set pdev->msix_enabled as 0 in the
calling of pci_msix_shutdown(), wx->msix_entries is never freed.
Reordering the lines to fix the memory leak.

Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2823861e5a92..a5a50b5a8816 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1972,11 +1972,11 @@ void wx_reset_interrupt_capability(struct wx *wx)
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		return;
 
-	pci_free_irq_vectors(wx->pdev);
 	if (pdev->msix_enabled) {
 		kfree(wx->msix_entries);
 		wx->msix_entries = NULL;
 	}
+	pci_free_irq_vectors(wx->pdev);
 }
 EXPORT_SYMBOL(wx_reset_interrupt_capability);
 
-- 
2.27.0


