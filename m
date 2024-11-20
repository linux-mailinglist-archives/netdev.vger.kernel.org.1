Return-Path: <netdev+bounces-146475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E289D38FE
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7383D281E63
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BB19D884;
	Wed, 20 Nov 2024 11:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54218EFC1;
	Wed, 20 Nov 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100523; cv=none; b=Pa8OtH+yM5iOoV0Q+HP9NlZmB49Iq0vJqTWLsCW3gvkELRoS4syX2W8l4qwNdYTL7P306OgKEGZYdOhmLKWbG2yhfGkBGt/Khoe5NlOU23+5/IvXeEKR6enJttz+/qhrd4hPTuUyF53yiGdCzpZdDJIL8il+1Ke8elTzNDVHm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100523; c=relaxed/simple;
	bh=n5qmZstA4vXp7nR8WfMsqBhdooyw3ncSvgnvo9xUK8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXuCvFZOpdb0twYAkby79SvKT/Mgxt3v9iDJln4uN/7W0P6elcKRGE8gM0Xr7culLwOj7+I/0bQlXCtRM4AFyQz7jmxAxJw8NhKRjJHZV+Q/Gm3iwfNpLD1sC2EV/xXdbUqn9bZYVpIeOoUBrL3yiJ8u3xLkmhU4+XrHBcT344c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppVT_1732100200 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:40 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 03/21] motorcomm:yt6801: Implement the fxgmac_drv_probe function
Date: Wed, 20 Nov 2024 18:56:07 +0800
Message-Id: <20241120105625.22508-4-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the fxgmac_drv_probe function to init interrupts, register mdio and
netdev.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 925bc1e7d..0cb2808b7 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -249,3 +249,196 @@ int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, bool wake_en)
 
 	return 0;
 }
+
+#ifdef CONFIG_PCI_MSI
+static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u32 i, *flags = &pdata->int_flags;
+	int vectors, rc, req_vectors;
+
+	/* Since we have 4 channels, we must ensure the number of cpu core > 4
+	 * otherwise, just roll back to legacy
+	 *  0-3 for rx, 4 for tx, 5 for misc
+	 */
+	vectors = num_online_cpus();
+	if (vectors < FXGMAC_MAX_DMA_RX_CHANNELS)
+		goto enable_msi_interrupt;
+
+	req_vectors = FXGMAC_MSIX_INT_NUMS;
+	pdata->msix_entries =
+		kcalloc(req_vectors, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!pdata->msix_entries)
+		goto enable_msi_interrupt;
+
+	for (i = 0; i < req_vectors; i++)
+		pdata->msix_entries[i].entry = i;
+
+	rc = pci_enable_msix_exact(pdev, pdata->msix_entries, req_vectors);
+	if (rc < 0) {
+		yt_err(pdata, "enable MSIx err, clear msix entries.\n");
+		/* Roll back to msi */
+		kfree(pdata->msix_entries);
+		pdata->msix_entries = NULL;
+		req_vectors = 0;
+		goto enable_msi_interrupt;
+	}
+
+	yt_dbg(pdata, "enable MSIx ok, cpu=%d,vectors=%d.\n", vectors,
+	       req_vectors);
+	fxgmac_set_bits(flags, FXGMAC_FLAG_INTERRUPT_POS,
+			FXGMAC_FLAG_INTERRUPT_LEN,
+			FXGMAC_FLAG_MSIX_ENABLED);
+	pdata->per_channel_irq = 1;
+	pdata->misc_irq = pdata->msix_entries[MSI_ID_PHY_OTHER].vector;
+	return;
+
+enable_msi_interrupt:
+	rc = pci_enable_msi(pdev);
+	if (rc < 0) {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_INTERRUPT_POS,
+				FXGMAC_FLAG_INTERRUPT_LEN,
+				FXGMAC_FLAG_LEGACY_ENABLED);
+		yt_err(pdata, "MSI err, rollback to LEGACY.\n");
+	} else {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_INTERRUPT_POS,
+				FXGMAC_FLAG_INTERRUPT_LEN,
+				FXGMAC_FLAG_MSI_ENABLED);
+		pdata->dev_irq = pdev->irq;
+		yt_dbg(pdata, "enable MSI ok, cpu=%d, irq=%d.\n", vectors,
+		       pdev->irq);
+	}
+}
+#endif
+
+static int fxgmac_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
+				 int phyreg, u16 val)
+{
+	struct fxgmac_pdata *yt = mii_bus->priv;
+
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return yt->hw_ops.write_phy_reg(yt, phyreg, val);
+}
+
+static int fxgmac_mdio_read_reg(struct mii_bus *mii_bus, int phyaddr, int phyreg)
+{
+	struct fxgmac_pdata *yt = mii_bus->priv;
+
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return  yt->hw_ops.read_phy_reg(yt, phyreg);
+}
+
+static int fxgmac_mdio_register(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	struct phy_device *phydev;
+	struct mii_bus *new_bus;
+	int ret;
+
+	new_bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!new_bus) {
+		yt_err(pdata, "devm_mdiobus_alloc err\n");
+		return -ENOMEM;
+	}
+
+	new_bus->name = "yt6801";
+	new_bus->priv = pdata;
+	new_bus->parent = &pdev->dev;
+	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "yt6801-%x-%x",
+		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
+
+	new_bus->read = fxgmac_mdio_read_reg;
+	new_bus->write = fxgmac_mdio_write_reg;
+
+	ret = devm_mdiobus_register(&pdev->dev, new_bus);
+	if (ret < 0) {
+		yt_err(pdata, "devm_mdiobus_register err:%x\n", ret);
+		return ret;
+	}
+
+	phydev = mdiobus_get_phy(new_bus, 0);
+	if (!phydev) {
+		yt_err(pdata, "mdiobus_get_phy err\n");
+		return -ENODEV;
+	}
+
+	pdata->phydev = phydev;
+	phydev->mac_managed_pm = true;
+	phy_support_asym_pause(phydev);
+
+	/* PHY will be woken up in rtl_open() */
+	phy_suspend(phydev);
+
+	return 0;
+}
+
+int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
+{
+	struct fxgmac_hw_ops *hw_ops;
+	struct fxgmac_pdata *pdata;
+	struct net_device *netdev;
+	int ret;
+
+	netdev = alloc_etherdev_mq(sizeof(struct fxgmac_pdata),
+				   FXGMAC_MAX_DMA_RX_CHANNELS);
+	if (!netdev) {
+		dev_err(dev, "alloc_etherdev_mq err\n");
+		return -ENOMEM;
+	}
+
+	SET_NETDEV_DEV(netdev, dev);
+	pdata = netdev_priv(netdev);
+
+	pdata->dev = dev;
+	pdata->netdev = netdev;
+	pdata->dev_irq = res->irq;
+	pdata->hw_addr = res->addr;
+	pdata->msg_enable = NETIF_MSG_DRV;
+	pdata->dev_state = FXGMAC_DEV_PROBE;
+
+	/* Default to legacy interrupt */
+	fxgmac_set_bits(&pdata->int_flags, FXGMAC_FLAG_INTERRUPT_POS,
+			FXGMAC_FLAG_INTERRUPT_LEN, FXGMAC_FLAG_LEGACY_ENABLED);
+	pdata->misc_irq = pdata->dev_irq;
+	pci_set_drvdata(to_pci_dev(pdata->dev), pdata);
+
+#ifdef CONFIG_PCI_MSI
+	fxgmac_init_interrupt_scheme(pdata);
+#endif
+
+	ret = fxgmac_init(pdata, true);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac_init err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	hw_ops = &pdata->hw_ops;
+	hw_ops->reset_phy(pdata);
+	hw_ops->release_phy(pdata);
+	ret = fxgmac_mdio_register(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac_mdio_register err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	netif_carrier_off(netdev);
+	ret = register_netdev(netdev);
+	if (ret) {
+		yt_err(pdata, "register_netdev err:%d\n", ret);
+		goto err_free_netdev;
+	}
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, netdev num_tx_q=%u\n", __func__,
+		       netdev->real_num_tx_queues);
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(netdev);
+	return ret;
+}
-- 
2.34.1


