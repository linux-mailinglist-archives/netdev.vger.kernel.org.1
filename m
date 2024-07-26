Return-Path: <netdev+bounces-113176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41593D0D1
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAB61F21A2A
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F30178CC3;
	Fri, 26 Jul 2024 10:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0383179663
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988231; cv=none; b=YK7OMiAxOTOfO78xXtwyvawabeYYxIlNxQAMlMsx6GvyH7MYY+GQKfNaWhb8RqV9mXrV6dAlCxKezDvfmv47jRfDLPZ0OcaEUajHAiMFntHosjV/HFgzqkCW2+rEG+nR5S7R8PGo8co5mfcstKyeTaVwzsUvpbOsgfrt2o12pTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988231; c=relaxed/simple;
	bh=0/oYikfuKK20djbAz28xrKtDpeB717aq+cK6lhEUOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpZYwRiPraR0+9DerNiBhwOhGg7Vgwjs9rDxoXfGvy3X9FG/tiki1i+tb//WVdVAF7+ZDoKbCk0XI/aEaAyIyDF8r14VrbMmMqF6jL/TzYKJrAxb7Nq/2BMIHggTiAaA+SRoMogFDI7NCZnwFssmmbS04ZUcRCUVqpuq5ToAEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1721988223t7jgz9xy
X-QQ-Originating-IP: XnLlgt/j+JNTntotQ7vPTkUErVqGHwVleDb4wK8dcTo=
Received: from localhost.localdomain ( [122.231.252.211])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jul 2024 18:03:41 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1084126950472790650
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RFC PATCH net-next v5 10/10] net: ngbe: add devlink and devlink port created
Date: Fri, 26 Jul 2024 18:03:01 +0800
Message-ID: <57F6E5845914FDC4+20240726100301.21416-11-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240726100301.21416-1-mengyuanlou@net-swift.com>
References: <20240726100301.21416-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a03a4b5f2766..784819f8fcd5 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -16,6 +16,7 @@
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_sriov.h"
+#include "../libwx/wx_devlink.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
 #include "ngbe_hw.h"
@@ -616,6 +617,13 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx = netdev_priv(netdev);
 	wx->netdev = netdev;
 	wx->pdev = pdev;
+
+	wx->dl_priv = wx_create_devlink(&pdev->dev);
+	if (!wx->dl_priv) {
+		err = -ENOMEM;
+		goto err_pci_release_regions;
+	}
+	wx->dl_priv->priv_wx = wx;
 	wx->msg_enable = BIT(3) - 1;
 
 	wx->hw_addr = devm_ioremap(&pdev->dev,
@@ -735,6 +743,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_clear_interrupt_scheme;
 
+	err = wx_devlink_create_pf_port(wx);
+	if (err)
+		goto err_devlink_create_pf_port;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -744,6 +756,8 @@ static int ngbe_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	devl_port_unregister(&wx->devlink_port);
+err_devlink_create_pf_port:
 	phylink_destroy(wx->phylink);
 	wx_control_hw(wx, false);
 err_clear_interrupt_scheme:
@@ -775,6 +789,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 	netdev = wx->netdev;
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
+	devl_port_unregister(&wx->devlink_port);
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
-- 
2.43.2


