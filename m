Return-Path: <netdev+bounces-196463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2180AD4E8C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72BB7A4630
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54E23D290;
	Wed, 11 Jun 2025 08:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA523E346
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631052; cv=none; b=HaW7lxyXmdSvFFLJ37FBy2lDw7KT40dKfYPz+3mUAizaLYnAQBojeR4NGm6mxnMrGchxx+lTMqORHgESu8zZxR0PCTQxYfeXaoFbpoKU6GMz8NwsVUJmrJSxCtS8SUaF4LuiWKPY/JgSzKvFB2BORNVPd726As7k0znp0QBI+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631052; c=relaxed/simple;
	bh=DQsK4cZzEc2UGCY/gTL/Q/JDaY65KuGiCobp2nU9Rvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tEUvfk2zyfqG0nTDIkhUwiGQp8YI/R2r+6TW1kjYoGBDjWRu/aKTzia5XgdLA1Wr5r/yhyTAXoxdqgpeMOwP/d6kM1tW1jqMtI7xzeGSk8BG+mFsphd3q0O7dAaIx8xfT1McjebE4Jk+DBvZRrOlx5kID3FPHnRGTdUY3IEg5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630981t8922a70a
X-QQ-Originating-IP: qRgK3xgu6HukfSVDOhGrNGzOhnxVkChrObbnOLBUkIw=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:20 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4299090505336962142
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 07/12] net: txgbevf: Support Rx and Tx process path
Date: Wed, 11 Jun 2025 16:35:54 +0800
Message-Id: <20250611083559.14175-8-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N42p3T2RvIR94hx2K9WbOwyBZ+aIIfTIBBLFtRNuwa65ACfNt0AaMvVc
	lPbFr++siqjmUt6+AB1ULk/YtdimxUuCtnl96b2XwUjKm5AA8G2bXVgAM1j5d+455LOiwo/
	5y5NHCHtmWu9HOu9NlvbmEZg3X8zuhJvPKr1w1iHbvzn8zjg4Y5jV0CZhZo/oHqVLCawV74
	4Zow4iZEPgHl5ZGG11vlDSKMNQRd5ZCESfmEltUW8xvWgGabESdzw6CKuurgUTcrO8K07U8
	D+46LYJwFGeQdq4kJfIscCODHSpKM7xHdsqEZMoev1BGzwhpO1EWYhg2D7GO/xNzRbZJvOl
	/kAW3x9fQkPiulPAjo14EMgq6P+azSnO4sSU/ikHsepGRJ6wk9oSlLfou4iNdG0xkGlkMQp
	ouyjUAHOYkUe4dC8VXnm8dSCpFjW3agstnH5Bb89ibcX952z4cHKS+sc0//ZOLZ8+kBzrng
	xg51hWl4KkXyqAIcYsJH8Hg+VmFuKqgbXbTobVfbaU91zPPSakFaPongcHCKncXgn4E9GeW
	vymNBtxDJ21b5ZVm/hN2q4tOoAfRHn5bBNpDgHuljaG0LUAV08o0IokAHVUgjg8DG056vey
	i5ksD36MSTOIQ1c9r3COiBCepggi6qGLf0o2W5LH0UbMZh9x+yRrFgQaznkAHYP2o3XtvFe
	960sGa7gBfE4idOBlB+F8P6+xbuD207WCkThMVySIDYUOcWGugKx/wBrzGhaFknqc9D2IwK
	C9fDMfv3RI2PlM7mLbsLDnpRTM1ZILaHEyU03GbGA9LeoGVQA4I51glaHKGMUtRBaCKRxNz
	ZkkY4jULU+3z88Dwf51bylDL0LS8fvd1RdlUHffq9dvDjI6JdhveqOBcMsGDyOJ5P225OoN
	VKFoe9BnFM+Lj8XEVICbKou83a+jo7BfjjRhMj4R2YHsK9zZQcYbrHXN0i6jAqS80AjlPTm
	BLgknRoikX1ltzAmBPcMqzaHrt5QVfhjBgsAlJgyA/KS891HEXTtiBsqS+hepTPVIsE8i+K
	hPZCrpIerPlTYUr2MwAxiJ07ri4Z2LffYS9FcKb/9RnF0fh7da0BO/KTlMkeULJlX/LQp40
	9lywX/uYZe9rzc1wtx/P5tA4CSDxbmKnHW9IjZA3oXnb3t6JVjglD28ME5EZaoJcg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Improve the configuration of Rx and Tx ring.
Setup and alloc resources.
Configure Rx and Tx unit on hardware.
Add .ndo_start_xmit support and start all queues.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 25 ++++++++++++++++++-
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index c01ff91a057d..51c93364aaf1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -250,10 +250,14 @@ static void wxvf_irq_enable(struct wx *wx)
 static void wxvf_up_complete(struct wx *wx)
 {
 	wx_configure_msix_vf(wx);
+	smp_mb__before_atomic();
+	wx_napi_enable_all(wx);
 
 	/* clear any pending interrupts, may auto mask */
 	wr32(wx, WX_VXICR, U32_MAX);
 	wxvf_irq_enable(wx);
+	/* enable transmits */
+	netif_tx_start_all_queues(wx->netdev);
 }
 
 int wxvf_open(struct net_device *netdev)
@@ -261,13 +265,31 @@ int wxvf_open(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 	int err;
 
-	err = wx_request_msix_irqs_vf(wx);
+	err = wx_setup_resources(wx);
 	if (err)
 		goto err_reset;
+	wx_configure_vf(wx);
+
+	err = wx_request_msix_irqs_vf(wx);
+	if (err)
+		goto err_free_resources;
+
+	/* Notify the stack of the actual queue counts. */
+	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
+	if (err)
+		goto err_free_irq;
+
+	err = netif_set_real_num_rx_queues(netdev, wx->num_rx_queues);
+	if (err)
+		goto err_free_irq;
 
 	wxvf_up_complete(wx);
 
 	return 0;
+err_free_irq:
+	wx_free_irq(wx);
+err_free_resources:
+	wx_free_resources(wx);
 err_reset:
 	wx_reset_vf(wx);
 	return err;
@@ -293,6 +315,7 @@ int wxvf_close(struct net_device *netdev)
 
 	wxvf_down(wx);
 	wx_free_irq(wx);
+	wx_free_resources(wx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 64f171423b23..448513cf882c 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -40,6 +40,7 @@ static const struct pci_device_id txgbevf_pci_tbl[] = {
 static const struct net_device_ops txgbevf_netdev_ops = {
 	.ndo_open               = wxvf_open,
 	.ndo_stop               = wxvf_close,
+	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac_vf,
 };
@@ -261,6 +262,7 @@ static int txgbevf_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	netif_tx_stop_all_queues(netdev);
 
 	return 0;
 
-- 
2.30.1


