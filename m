Return-Path: <netdev+bounces-180109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC11A7F988
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650921750A5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58564265CCD;
	Tue,  8 Apr 2025 09:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6F2638B0;
	Tue,  8 Apr 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104554; cv=none; b=jqf/1jrSrn23Gbfm2+zUZDlLFYhNEO8H6U+uZ8HTNz0/0ju5xukK4O+fUxU26tAtEza1Sdab6GFh1ruoKzVIWpOpXQtqBeYieO/ydRLK6WU8K8KB4CEvO1kxLvxgAttK5yAmoIyhFSkcpkLgvOy5qOdxBVE1tJ97DhCtrFOBlsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104554; c=relaxed/simple;
	bh=HsVDZCmJPDeierqtDYvUzaM1kHtAAhjk9X4oqELrwtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lY5Y0Jx3VKkTDDL8+T+Zy+GwvXI2dxmqe+aU3DLtp09cw6HUfKlmAj/fukh68STR8Jf3Hmemgk0LlZVGwE+l9VqbIG9oEeKhh7U0584duqiOopxmmMvGyP679stOVooYViwzV8TstrAxQ38CpNl4hNfD0anV4XmItF/mnqVJDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Vt_1744104540 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:29:01 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 12/14] yt6801: Implement pci_driver suspend and resume
Date: Tue,  8 Apr 2025 17:28:33 +0800
Message-Id: <20250408092835.3952-13-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the pci_driver suspend function to enable the device to sleep,
 and implement the resume function to enable the device to resume
 operation.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 6523fe4de..67ff71f80 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -17,7 +17,11 @@
  *  ********************||******************* **
  */
 
+#include <linux/if_vlan.h>
 #include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/tcp.h>
+
 #include "yt6801_type.h"
 #include "yt6801_desc.h"
 
@@ -1380,6 +1384,21 @@ static void fxgmac_restart_work(struct work_struct *work)
 	fxgmac_restart(container_of(work, struct fxgmac_pdata, restart_work));
 	rtnl_unlock();
 }
+
+static int fxgmac_net_powerup(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	priv->power_state = 0;/* clear all bits as normal now */
+	ret = fxgmac_start(priv);
+	if (ret < 0) {
+		dev_err(priv->dev, "fxgmac start failed:%d.\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void fxgmac_config_powerdown(struct fxgmac_pdata *priv)
 {
 	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_RE, 1); /* Enable MAC Rx */
@@ -2908,6 +2927,55 @@ static void fxgmac_shutdown(struct pci_dev *pcidev)
 	}
 	rtnl_unlock();
 }
+
+static int fxgmac_suspend(struct device *device)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(device);
+	struct net_device *ndev = priv->ndev;
+
+	rtnl_lock();
+	if (priv->dev_state != FXGMAC_DEV_START)
+		goto unlock;
+
+	if (netif_running(ndev))
+		__fxgmac_shutdown(to_pci_dev(device));
+
+	priv->dev_state = FXGMAC_DEV_SUSPEND;
+unlock:
+	rtnl_unlock();
+
+	return 0;
+}
+
+static int fxgmac_resume(struct device *device)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(device);
+	struct net_device *ndev = priv->ndev;
+	int ret = 0;
+
+	rtnl_lock();
+	if (priv->dev_state != FXGMAC_DEV_SUSPEND)
+		goto unlock;
+
+	priv->dev_state = FXGMAC_DEV_RESUME;
+	__clear_bit(FXGMAC_POWER_STATE_DOWN, &priv->power_state);
+	rtnl_lock();
+	if (netif_running(ndev)) {
+		ret = fxgmac_net_powerup(priv);
+		if (ret < 0) {
+			netdev_err(priv->ndev, "%s, fxgmac net powerup failed:%d\n",
+				   __func__, ret);
+			goto unlock;
+		}
+	}
+
+	netif_device_attach(ndev);
+unlock:
+	rtnl_unlock();
+
+	return ret;
+}
+
 #define MOTORCOMM_PCI_ID			0x1f0a
 #define YT6801_PCI_DEVICE_ID			0x6801
 
@@ -2918,11 +2986,16 @@ static const struct pci_device_id fxgmac_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, fxgmac_pci_tbl);
 
+static const struct dev_pm_ops fxgmac_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(fxgmac_suspend, fxgmac_resume)
+};
+
 static struct pci_driver fxgmac_pci_driver = {
 	.name		= FXGMAC_DRV_NAME,
 	.id_table	= fxgmac_pci_tbl,
 	.probe		= fxgmac_probe,
 	.remove		= fxgmac_remove,
+	.driver.pm	= pm_ptr(&fxgmac_pm_ops),
 	.shutdown	= fxgmac_shutdown,
 };
 
-- 
2.34.1


