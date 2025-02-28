Return-Path: <netdev+bounces-170627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E318AA49661
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1578B16C70C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF32620F6;
	Fri, 28 Feb 2025 10:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E75F2620C1;
	Fri, 28 Feb 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736860; cv=none; b=Vmoawjxjk2L7LDK7KVrlMG5RZl8TdqUg8UGFOlRs5GDIs1cxUFiceN8f6YG+QlbX2oVpk8vgokDvMVz6q7EPDFFRx9A3Zq0E90kDsWSduX32ie5AHp6xBmbmXak5Cae6SN5Tvd2Fsn1O9gt+SMsmZv+XeUAM1qb6W2YIOx8qp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736860; c=relaxed/simple;
	bh=Rjs6BCqM+SxeVg1lbFe9Ds4CosVf3jyDUn/fUVkK+dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJFydqbmfABoorajR0kUE4vPLVKP0MUDjwkoqJBWjmuSBq3pVjHANgq1AEmPoUWtC4MrGx8bow/BfGFvIHzfWpXHAwUCcUgHJAcpWHKhDfuM4vMTo3xBlNdV/xOh5Y73FS+2FtBtQRn+e4jZmebQ/k7H+Kb85kkJYWFaWNxjTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Lr_1740736840 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:40 +0800
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
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 12/14] motorcomm:yt6801: Implement pci_driver suspend and resume
Date: Fri, 28 Feb 2025 18:00:18 +0800
Message-Id: <20250228100020.3944-13-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
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
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 14 +++++
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    | 58 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index d6c1c0fd4..01df945d0 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -1378,6 +1378,20 @@ static void fxgmac_restart_work(struct work_struct *work)
 	rtnl_unlock();
 }
 
+int fxgmac_net_powerup(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	priv->powerstate = 0;/* clear all bits as normal now */
+	ret = fxgmac_start(priv);
+	if (ret < 0) {
+		yt_err(priv, "%s: fxgmac_start ret: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void fxgmac_config_powerdown(struct fxgmac_pdata *priv)
 {
 	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, RE, 1); /* Enable MAC Rx */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
index fba01e393..e9d2ac820 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -103,6 +103,59 @@ static void fxgmac_shutdown(struct pci_dev *pcidev)
 	}
 	mutex_unlock(&priv->mutex);
 }
+
+static int fxgmac_suspend(struct device *device)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(device);
+	struct net_device *netdev = priv->netdev;
+	int ret = 0;
+
+	mutex_lock(&priv->mutex);
+	if (priv->dev_state != FXGMAC_DEV_START)
+		goto unlock;
+
+	if (netif_running(netdev))
+		__fxgmac_shutdown(to_pci_dev(device));
+
+	priv->dev_state = FXGMAC_DEV_SUSPEND;
+unlock:
+	mutex_unlock(&priv->mutex);
+
+	return ret;
+}
+
+static int fxgmac_resume(struct device *device)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(device);
+	struct net_device *netdev = priv->netdev;
+	int ret = 0;
+
+	mutex_lock(&priv->mutex);
+	if (priv->dev_state != FXGMAC_DEV_SUSPEND)
+		goto unlock;
+
+	priv->dev_state = FXGMAC_DEV_RESUME;
+	__clear_bit(FXGMAC_POWER_STATE_DOWN, &priv->powerstate);
+
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		ret = fxgmac_net_powerup(priv);
+		if (ret < 0) {
+			dev_err(device, "%s, fxgmac_net_powerup err:%d\n",
+				__func__, ret);
+			goto unlock;
+		}
+	}
+
+	netif_device_attach(netdev);
+	rtnl_unlock();
+
+unlock:
+	mutex_unlock(&priv->mutex);
+
+	return ret;
+}
+
 #define MOTORCOMM_PCI_ID			0x1f0a
 #define YT6801_PCI_DEVICE_ID			0x6801
 
@@ -113,11 +166,16 @@ static const struct pci_device_id fxgmac_pci_tbl[] = {
 
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


