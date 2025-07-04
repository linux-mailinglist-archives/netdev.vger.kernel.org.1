Return-Path: <netdev+bounces-204111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB4AF8F24
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA77485B63
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7428689A;
	Fri,  4 Jul 2025 09:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93B2C3264
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622699; cv=none; b=pHA19gwwy31VXGDS6PSYOnAVI4z6Izl8Dq0oTfB1QB2VbKQzMMYmGB0Qg06UL4w2uu64aeliFZwxNopTCXHArHwYotniSoOV+dUVkFTi1t9xJJA0PWGNx7jS8mzSuTKf02R1sNUPBmz3t8CI6yq4sAjqRNOK9NOO/Sw+BdKGOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622699; c=relaxed/simple;
	bh=7hqcaz84SluVy67hFSf74JyGlTNdCH9W4vQKnsHS12s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJGPa41lFe8fLfxRbxVb5ViHecCxPbjF23X+53Z0Dxe4R6hOub9zZDQ9f9q/pAU1ktMKK2mAagO3saMcReJBSGyN/h8vs68uO1aVIAGwqZQmJtX7orNvfelq1Kkc8Fh0gmsDCv4kLJqBUX4US+i4f9hxqMe6Gd/Qom8Szf+ElQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622659t46204e9f
X-QQ-Originating-IP: nY9RJdlXBqoanBpDxAiRKvYsHhzzWsIDy3No+H2qkY0=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14614419719975722882
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 11/12] net: ngbevf: init interrupts and request irqs
Date: Fri,  4 Jul 2025 17:49:22 +0800
Message-Id: <20250704094923.652-12-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nw5WZPeltq7paQQoPCrcR0ae/s0MARjOeRiIhXl+TCjAMgApgIlDqHWB
	e/WvG90eLbGauHsMxu4Pw8OsarKzkJtdiBV+RLBIWk5y8BuAgjAF6mldNGFnAIIT1m5lN9F
	mZ6iSDA1Wy/0tiW9+JPE5iXyNA0emafVSmcqW6eo73MQoSfW3vtzCHWpVukDORKTN23QSRS
	41jZOKQEBTXmlENcssEa0zdC8Sbl8Opl5NmQ546DQI/AsBDFpcpisTYVHRq950aK35tkfRy
	5aL2VsqjQm2LxFCs8Hh1q+xflOXt6wK4npDbyXoKyd8n0VVtSKnmOULo6d2b0CYZJPYZqj6
	KCpLCadqkO8R8SpQjehTC/UBKP+52QoKy56fHYVdTFhov6FSbuuCmruHjjnrUZMrXNm42Jb
	bd5Y4MOCcI/c1j4InacRLwV/fpx1xH6KSiczwcsiwsrSlo3FyB3B7ta724n5+ALV9HKDiV6
	2fh/vtU9as6cM07je5R096s1UWk4MRtWNnXz2bGMR/M2ell1Xhqw8tjr0BQlw9xOrSQdC9q
	twnfAdGrVZT8wAcySLI/83hEsrkxloeTpAHofY6ZMm08+oob2t8c5K3MkrY+8mCUaBF7WCj
	zmJ9KsaaRNF7ZNYQjN0JwC05yp+JL9pA2yvpvpGrcGLDSMWZ9p4DmWypQHMtNEaLlvAA+1r
	U9FHmaFzWrDN1JD+yN1B1xO//dIi1v+25l/1zT/skXZW0B9lpCyE4L2ajGVwfteO7aw3sbB
	O1w9KDRVOXE7AZpngUbjrDCakoZduzaJnJv5u5gYlCZ3rAos18MREzBRCdlsNj43QQXq4hA
	M6u8IxhDow4xucSzXeaceYBnpmpsmmTVElVcZpLnOdzqBpZ2ITwAg6TNLUsSYA1ZmTkI5SR
	6PbemoZto9b1JPEZioXYHRP1+oxLG37BmaRgVrUmmVsULg6FGyQkupZ7coS1TXtJMoO0E5y
	zrrPSt+UbgpxDkdlUSnVv6GcBLuv84RYuovkR+rhqkzxfdC364VSvHzFXJLM6C6qAw/gC9f
	9XYCTAJLFPyrT0BKCwpYy06xOaDeYT/aGPySrntA6j7X8X7S5Z9jnV7kAlAFQc0TFh0WyB+
	XXosaBkIe1yjBGLzxBbfLzNRBJDF85Ta90RtNBGHBWN/6gggR++gq4CpvMTtK+zbcQ2HuZl
	LmXEM5v5Za19pXtby+mTVVweyQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add specific parameters for irq alloc, then use
wx_init_interrupt_scheme to initialize interrupt
allocation in probe.
Add .ndo_start_xmit support and start all queues.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c  | 18 ++++++++++++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h  |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index 4eea682f024b..a629b645d3a1 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -10,6 +10,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_lib.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
@@ -43,10 +44,18 @@ static const struct pci_device_id ngbevf_pci_tbl[] = {
 static const struct net_device_ops ngbevf_netdev_ops = {
 	.ndo_open               = wxvf_open,
 	.ndo_stop               = wxvf_close,
+	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac_vf,
 };
 
+static void ngbevf_set_num_queues(struct wx *wx)
+{
+	/* Start with base case */
+	wx->num_rx_queues = 1;
+	wx->num_tx_queues = 1;
+}
+
 static int ngbevf_sw_init(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
@@ -65,6 +74,7 @@ static int ngbevf_sw_init(struct wx *wx)
 
 	/* Initialize the device type */
 	wx->mac.type = wx_mac_em;
+	wx->mac.max_msix_vectors = NGBEVF_MAX_MSIX_VECTORS;
 	/* lock to protect mailbox accesses */
 	spin_lock_init(&wx->mbx.mbx_lock);
 
@@ -98,6 +108,7 @@ static int ngbevf_sw_init(struct wx *wx)
 	/* set default work limits */
 	wx->tx_work_limit = NGBEVF_DEFAULT_TX_WORK;
 	wx->rx_work_limit = NGBEVF_DEFAULT_RX_WORK;
+	wx->set_num_queues = ngbevf_set_num_queues;
 
 	return 0;
 err_reset_hw:
@@ -186,15 +197,22 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
+	err = wx_init_interrupt_scheme(wx);
+	if (err)
+		goto err_free_sw_init;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	netif_tx_stop_all_queues(netdev);
 
 	return 0;
 
 err_register:
+	wx_clear_interrupt_scheme(wx);
+err_free_sw_init:
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
index dc29349304f1..67e761089e99 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
@@ -18,6 +18,7 @@
 #define NGBEVF_DEV_ID_EM_WX1860A1               0x011a
 #define NGBEVF_DEV_ID_EM_WX1860AL1              0x011b
 
+#define NGBEVF_MAX_MSIX_VECTORS               1
 #define NGBEVF_MAX_RX_QUEUES                  1
 #define NGBEVF_MAX_TX_QUEUES                  1
 #define NGBEVF_DEFAULT_TXD                    128
-- 
2.30.1


