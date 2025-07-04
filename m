Return-Path: <netdev+bounces-204114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD73AF8F28
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309D0485FF9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97092ECE99;
	Fri,  4 Jul 2025 09:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA912ECD0E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622707; cv=none; b=PiJEZ4WOJOvVEZZf2g4EiqRRuuWfP/CdiCilhWIE89OD3GqkLcShF7xkGld7vW8XQV9yYNEcSAc+SkW496vL210tQQeWenGiwoKk6cyfcIzCtyGj/c/eVNBpu98XEIFgzT9QHCOcJZlop403HLMIXuOHzzP7+46qwo8xQ1yB77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622707; c=relaxed/simple;
	bh=oJN4xFwwerElt8tRUBfFIy3dHogKHSop8LY+HoU4Jxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/SCFZ2XGU2PI/QiLzwCm1IP9w0yJQwpy+E3NNSD2Q3mvP4Psp9zSWrmIY2fqJKasUuh/cBrYsTaNosUwpT5IMqRnUXqT2XEtp+as8rvaP+DHOiNsFh55YNjxi4GjIrikEFsua4tIrg1JHtkwnOJXs1CUm1Wp0hVV+Sv2tpLuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622628t0103cc81
X-QQ-Originating-IP: T1uTyhq45qk4pYJEfgwj/iNZU6nPDhfU0aWn38VEKjs=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1682222252056590613
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
Subject: [PATCH net-next v3 07/12] net: txgbevf: Support Rx and Tx process path
Date: Fri,  4 Jul 2025 17:49:18 +0800
Message-Id: <20250704094923.652-8-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: Mb1BOhWcNIRMlv/NmF+bhmQ19+h0ek17kMNWYWUEkjs90lo2ObkJS6uH
	H54fJoITXX4QS9fqaKNdzSzczC+s233TX+6cB76li4kKyHpuHrVA8wKAzpshOJ86UVMAZtI
	4CN2olwRm9ta6Hco6R1Qmx194CcZpKrVxap3wkGYLnGTYfUL4Nq8tpdU4yqvWbefL8VujIi
	yzbsx+F9wG3m096cFipyH1zdUStkfleZ7OAP9wOBtBjME45TOQMJFC5PMt86xRuYQo9k2mV
	BSQPmTE2J80QQr4QPUlD4lvTPHXYQveauXjUPWdkjcBSdh7D5e+JQYyLJF6kZNCt3GyKxoJ
	v89tMGBiXcmwGPQIZQE4KT+TFmR1Hep7mFxPDedHCbpRFlI8NNQQOiNy/GoJAKX/Ma4j5tC
	nYXTrqRUnlGJPcCCIA6WGe09LICQS7hfBwOzRpjHYfsUFBefq5hEMU9O/6Fbs/biJ1eVL+1
	G5g0tXl4S0azV6kE0Z4nnj0o0OqHAxHU7Luu/bWkRkii//tH2mW1AXSSF8N6iw5eEw2R+SM
	OgrEuwfMOhdvuBaTDTpSU3r+UmLe6CRFqmW4/9mxJx0yDTS9JqN1A1Q2L8Vs/CH1Nw6WPBS
	RVdLLgtVSNHKVE3kbSjnz2+Tp8+7MUd4Jg3/io1DzK5dKk2M2/HM/PbihNprdwSITSqMyK2
	VGhhEPcyuhwRh3lU2quFn5Omk4c9w62ukhhLf/4CWRvCLGO8gCV5lkn+kW3V3BZ9ssBv6ab
	lDA8IRb2lCSnQyeBqRaSVL559/ySZiW+EZWwtClNpvHmWD4QB05RQz3GBMK+lA2PEPVWzTv
	C7zcD7jjJ52VZxyUk10Y1ScZuZboVuH2n4rW2nq33JStsvJeqryIMikdjNilNR23eL7qYP3
	FuKOOCBrMrBmuOxPTDLifXCww6TEYugJ+f0JnTOKhKR6IRWASis5BCQRJ2XaWN6Vv+vpmBA
	CmDRFIscMICvJMDLJvh1iRF8s3GMd2MeR2qmcRQB7JLlx2RuIVFVdCvwEx1TRp0yWPXP91+
	XqUJmt02bHG6zwPgw4JhtgHnbjd/4vA100TzznlZ8PiuhOsD1fo6Z+GHuwS48VR+vcrKA5N
	NHXrlKCcukUNEEnAdaotoIyz/z2mLw/gJbh3RG6oB1CJ1qeu8Aghu5zmFS7cjulNDW1iDn0
	Gq5ZouGS1MjD1xM=
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
index 7442b195425f..dc3ed0808e15 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -251,10 +251,14 @@ static void wxvf_irq_enable(struct wx *wx)
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
@@ -262,13 +266,31 @@ int wxvf_open(struct net_device *netdev)
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
@@ -294,6 +316,7 @@ int wxvf_close(struct net_device *netdev)
 
 	wxvf_down(wx);
 	wx_free_irq(wx);
+	wx_free_resources(wx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index a61e4a0781cf..57e67804b8b7 100644
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
@@ -258,6 +259,7 @@ static int txgbevf_probe(struct pci_dev *pdev,
 		goto err_register;
 
 	pci_set_drvdata(pdev, wx);
+	netif_tx_stop_all_queues(netdev);
 
 	return 0;
 
-- 
2.30.1


