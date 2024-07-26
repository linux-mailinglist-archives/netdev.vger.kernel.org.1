Return-Path: <netdev+bounces-113178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC793D0D3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE521F220D3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14EA179970;
	Fri, 26 Jul 2024 10:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB67176AD5
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988233; cv=none; b=fALnb3isxjH+mCTQ0lJtwG8NfVykU+3cNXxKvPbXPn9KHM5RNSR2kJfFs8zonxNbPg7j27sb24XIfzSHOyY2Y32lkxXM5Hxjs23HH0nL38SH/DLlkjs0hLODjuKpUcZmG0Kc0Dv3jY21TKLnotL6c9EPXZwbFvISCXdUOVteCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988233; c=relaxed/simple;
	bh=ixypbAcaozQ6hFgpS39bj8Z4DjGqSTk9XuFkBcaqq+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp9nR0dX3kuqFhurjELob0iYR/8MVoXKHfM6Puj1RpBuuK6w1hHsV+WCk8xxARE5tpDs0+pd2uXtIlgENhctT7JF/LvaahbACpSqqq+dViaVFY9BaB7qcXuPdCB46PQBvswQcCWTrAI1SL2ye4sCZ9yNZwlGI2sT9DqLsUEN47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1721988220t7lr9p41
X-QQ-Originating-IP: XEzhFo4bp/ABUD9TOfEVpr5oYpSjJ4f0BmkeLvZzAy0=
Received: from localhost.localdomain ( [122.231.252.211])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jul 2024 18:03:39 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 686133209948113762
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RFC PATCH net-next v5 09/10] net: txgbe: add devlink and devlink port created
Date: Fri, 26 Jul 2024 18:03:00 +0800
Message-ID: <B9735D5509541210+20240726100301.21416-10-mengyuanlou@net-swift.com>
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
 .../net/ethernet/wangxun/txgbe/txgbe_main.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index c95d0611cf25..bf9756814f76 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -16,6 +16,7 @@
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_sriov.h"
+#include "../libwx/wx_devlink.h"
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
@@ -564,6 +565,13 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->netdev = netdev;
 	wx->pdev = pdev;
 
+	wx->dl_priv = wx_create_devlink(&pdev->dev);
+	if (!wx->dl_priv) {
+		err = -ENOMEM;
+		goto err_pci_release_regions;
+	}
+
+	wx->dl_priv->priv_wx = wx;
 	wx->msg_enable = (1 << DEFAULT_DEBUG_LEVEL_SHIFT) - 1;
 
 	wx->hw_addr = devm_ioremap(&pdev->dev,
@@ -707,9 +715,14 @@ static int txgbe_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_free_misc_irq;
 
-	err = register_netdev(netdev);
+	err = wx_devlink_create_pf_port(wx);
 	if (err)
 		goto err_remove_phy;
+	SET_NETDEV_DEVLINK_PORT(netdev, &wx->devlink_port);
+
+	err = register_netdev(netdev);
+	if (err)
+		goto err_devlink_create_pf_port;
 
 	pci_set_drvdata(pdev, wx);
 
@@ -731,6 +744,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	return 0;
 
+err_devlink_create_pf_port:
+	devl_port_unregister(&wx->devlink_port);
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
 err_free_misc_irq:
@@ -767,6 +782,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
+	devl_port_unregister(&wx->devlink_port);
 	txgbe_remove_phy(txgbe);
 	txgbe_free_misc_irq(txgbe);
 	wx_free_isb_resources(wx);
-- 
2.43.2


