Return-Path: <netdev+bounces-115537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DD946EC1
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D9B21257
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD391E493;
	Sun,  4 Aug 2024 12:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023525779
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775765; cv=none; b=OddfwFr/QwRJhkW/yxwk7x13fjLwpq4M/bgPMhDhyPgNNC2rLr2O3z/1tx6OVxCAsIbaIROvZzYbBtcWpGnGXu174PZkAxOrcd2OijRk/ipWWeD6ni8L9y7I/9hic+JB0K1+i6hTzZC1Z3XybkR04/JpW8PXAsorAebAPMFJ99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775765; c=relaxed/simple;
	bh=lIQY2254Zh7fpW8LwBTodAnfNc3/3g1wBZVNAwzgtqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU5XvrXZNaBeB75P8ukBvC2nn72h3NZG6ri9XT3/BD+2LM9ikMz6hnUa8rRyzIQGBkn5GtuMlQgbCHYL2MvD3B4M83PnXmRhLaBLng0E4Bar9s6i8/fC1J40+aJsY03mKF5kgGCb+D1Jaf2ZYPKdfcozbNvU6dpSmIn6+8tpL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1722775757tickwbci
X-QQ-Originating-IP: V6S8UTNw1jltEn/jDyWHShWQ63xCID0yJU6TsQuKyRw=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Aug 2024 20:49:16 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12258759675836617230
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 09/10] net: txgbe: add devlink and devlink port created
Date: Sun,  4 Aug 2024 20:48:40 +0800
Message-ID: <9203F9254D59FF19+20240804124841.71177-10-mengyuanlou@net-swift.com>
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
2.45.2


