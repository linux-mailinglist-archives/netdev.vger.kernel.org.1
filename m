Return-Path: <netdev+bounces-201055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08FAE7F02
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8153B1DDB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB02280CE0;
	Wed, 25 Jun 2025 10:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878A284686
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846919; cv=none; b=SpksKhDHkWcP6brsZjQw2U964WEqqWDlonxYiJUL7r1GIsuAaQTpOD4Lrs8PT2mSVstcsK+8NqAu4asYNVxdTbFNMsPikhKszSs08x0RQb9rXDmsF9OQHpsZQessDwJ8asjOZnBk3x6fzqsrd0Mlr4bGujkbxr7QmDlFJ+gFlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846919; c=relaxed/simple;
	bh=MUV51pH3VvRPFct1fOjf4Venu7Of8/P6xC0CX+lCTT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cz9Q3yFaHmhTIQVJ/QQmD3oI7ZWN0PbLpPiuRDumr7nOXSNwlRGUfwqVYBTvdrVYT8c/gctIcHpv9ogChy/acexEqbmxW2aaUhyL/HsRq/vcxeA49lH53EATnrKLiTi88DUklBn5E+g//52lqmYak8Vuv3ov+tYHv0hoiIMNTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846878t17e3db3b
X-QQ-Originating-IP: 5kkOV9t2Eg38lm4oJ9TSW/9+c6d33T0AJgiPTyaayTY=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:17 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14108390189384657594
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
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 07/12] net: txgbevf: Support Rx and Tx process path
Date: Wed, 25 Jun 2025 18:20:53 +0800
Message-Id: <20250625102058.19898-8-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MpkHnaaty8/1A2p9215943VbFf51gUbqMMkFzYw6xWaXjsGWGzDdjhr6
	Mv2+0czQl6zNKiivZPdGQPUP65r+Dc2AV/+0tYV9JVLUoCuGCgeRxyXL/69nhD78M4ToBk1
	7Dp/kWiXKcrUeLplkbz3RPsTpSInHMHbeNahG7h01cpXFVKAOCnUd58Ua+ZYOph9BRV16XB
	6aA4vU4Ja6KxtTyGStHTybjbTKh8izDD47bfEWzGOZKQh4gRr86yyeOCvI+lQP2kAq8niPC
	r2KUKnM2CggvyRcAzVrlqg2f4X9BJHkxwgFF72J8m9Vjka/UZW/2e/YUsMBjZQf6NFJ3FfD
	/+N9zs9p+zY6n9YBPMBk6ncxlzr8P3gB974jHyL0hZQ9/5xnfZVsPDodsTCepSZPX3QhiYz
	bC7z9sGtMVMUc1HJ+4ByHcpFm7GyhHjqJ91G33RTn7+b78xcpyElEdz5Tk9YgSm+hH0sIja
	OslXj8WQl7phvSzmlVyg8iccS9w7kH9LHD4y36Kk/JZTFYtzGUHr2mppMF/OMmJwBUdfd2O
	DEdU+oZk6K+nZ6lEV7AYoPpN26Ut/7ppo+oWZ4ByFPu7b39fq59BGifkykoviKahGd0JxIv
	lrayORRQ6/s0DnVjxTZdcEw/mI70fyPjcHkBF0vUf962D7Bm3XEehGiu3wlr5gYHS25WANP
	28UbKTMX2U3u0EUnlp2S0iGkIAkyrMhwkLY+MTxaqEn1AVRHIKBQmHTqD2R4frHBRO11d5c
	EQyhyW8txaUy5VJNzOfidtwoUPYODofXZ2s7TqsiWuEhg6t1+E0iSeeI5z8yDFwG/p1rdqq
	HvsRseeRYyghFuKtOv0CQTPYiJ6Qmi/MzLl8iI6JzjQ71fh+J0yAhH70dqrkAvcAicXpaiS
	/inkrkp0stBOeB/Qxl42Rc0o4NquD5cFpPMIDue9AAv/33EiniDI8VZOmDsyNq7QuWkb4uv
	dKiHnd+MZLLkLVhuw2QLkj+K8aiALR/bKwpaBilpq9HSEZDlpydixEyrzfNluNog4VI4uPv
	POUi5CV+nLUegPA0mH7kN3zxKHEpQjUN1f9nwl468RaDGEhNnQQcsWc5LclslHGT5XqRuW5
	tnyit7H1AkpYOFrNl9Q1C3TLlJA4pHeKLiUMioJWt5+46Gy+NTZidys44Hv0byqjQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
index 4224578b7974..60c9e1463efc 100644
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


