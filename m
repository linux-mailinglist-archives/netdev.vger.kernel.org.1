Return-Path: <netdev+bounces-115539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E94A946EC3
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129671F21DAE
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1DC3B79C;
	Sun,  4 Aug 2024 12:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74761E4A4
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775777; cv=none; b=mzxphazGmYw8oUNrxzkEHZNHb2lt6AWUF1WbCcBk6SxcPqXVEihTe2JfiCTvi/6oIzmndv/OaB8+HyOFD5mNDtqpLQACia5wXOBKemzA17EJvceeecr22Ag5H8U5ZS9J9w28O7XFBPGe8yk4vTkeqeBjJ7UEJbb6JdL+C9qzz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775777; c=relaxed/simple;
	bh=2A+RwIShvD4cRN08JBkelR/m1zf4BquEpodSKS4d/TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNy8HFTYtkavXSsIIAjvOEYWU5QJQ2dvTERyYW0n+AoXiIc+6WRCYJWAX0/51R4uUZy6cBZuQb9XBRZn0OLpGQ0dvl/aC2zq+oT5ds98Qjb3adWWJy4m9Int5KJmWV+wKEzdyECOXqiFQ6sHwUlj/8Q7htZ1gl9gJpdXXcisIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1722775763t96hp7eb
X-QQ-Originating-IP: iQiBVI1j9ZEUd0AflhcxgB0HoAemAKekzD+NwxRMSnk=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Aug 2024 20:49:18 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16245427423179570249
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 10/10] net: ngbe: add devlink and devlink port created
Date: Sun,  4 Aug 2024 20:48:41 +0800
Message-ID: <C6023F033917F553+20240804124841.71177-11-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804124841.71177-1-mengyuanlou@net-swift.com>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
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
2.45.2


