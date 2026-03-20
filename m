Return-Path: <netdev+bounces-270072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOLSNaa6vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:22:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 820BE2E14FC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81BCE3028B43
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6093EF0B3;
	Fri, 20 Mar 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CgctF/jZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB73EF0A1;
	Fri, 20 Mar 2026 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041604; cv=none; b=LTd4Q/fbduLVlhb7sKOFeUsa08eTSruVLHW67fpgj64mBUoOvQun1FXOEjyAT5UR/QI5okaNOMuj9ooHTP0ph0sc3kkFqOPZCxLi9sli+CJBURKE2MxI2Y8NoMOBOFPJjc+Vjc3SuG4kHLMInoqt0aSNwBSE5G5FS1cIKZkQWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041604; c=relaxed/simple;
	bh=aZJWZChcHQriYj94KKlegTaH8Blqvbr+O8JNgv3EGt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxvZUnvlGQKjk+G/tOdlWLXDwOs3jjtVaFW7nlRoo5xe05pJZ8QI2NYeCACVfvUqa5fmekaZsVwZSzRy+bu6RhmZe+DYcc0ao9xfJiouOHCaE+ED7td4xTWfxapy5ZEZJnMAQf+/b3JhHlEljpB20wiW0epMJflo62WoumrmvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CgctF/jZ; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 922ABC05AE44;
	Fri, 20 Mar 2026 14:20:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 922ABC05AE44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1774041602;
	bh=aZJWZChcHQriYj94KKlegTaH8Blqvbr+O8JNgv3EGt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgctF/jZkVlUSumC82D5Onn44q+x64d8oSUKFsALOlQsXr74TWf7+tcls0fXZPS/5
	 mnGT3IP9a4H/+9wZUaLwBis5XHF51ZwLInidkUsAeIjmy0n6sS9PML3oX1RWypGvx6
	 30wIxu4JzTYNFT7354Zj1Atq1p2ieBsKKoOSPXso=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 5585FAE81;
	Fri, 20 Mar 2026 17:19:59 -0400 (EDT)
From: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v8 5/6] Fix error handling in probe function.
Date: Fri, 20 Mar 2026 14:19:20 -0700
Message-ID: <20260320211921.1202058-6-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,armlinux.org.uk,altera.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270072-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 820BE2E14FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Software node created in probe function is not being cleaned up if
the probe function returns an error.
The stmmac core provides mechanism to handle this error condition
with plat->init, plat->exit helper functions.
Move glue driver's initialization code to plat->init function.
If the probe function returns an error, plat->exit function is
called. Handle any glue driver level cleanup in the plat->exit
handler.
Use devm_add_action_or_reset() to register a callback to free
irq vectors automatically, simplifying error handling in probe().

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 164 ++++++++++--------
 1 file changed, 90 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
index 3a00452c0aa6..9103e9cf38f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
@@ -218,6 +218,13 @@ static void brcm_config_misc_regs(struct pci_dev *pdev,
 		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
 }
 
+static void brcm_free_irq_vectors(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	pci_free_irq_vectors(pdev);
+}
+
 static int brcm_config_multi_msi(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat,
 				 struct stmmac_resources *res)
@@ -251,9 +258,87 @@ static int brcm_config_multi_msi(struct pci_dev *pdev,
 	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
 	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+
+	return devm_add_action_or_reset(&pdev->dev,
+					brcm_free_irq_vectors, pdev);
+}
+
+static int brcm_drv_init(struct device *dev, void *bsp_priv)
+{
+	struct brcm_priv_data *brcm_priv = (struct brcm_priv_data *)bsp_priv;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rx_offset;
+	int tx_offset;
+	int vector;
+	int ret;
+
+	/* This device is directly attached to the switch chip internal to the
+	 * SoC using XGMII interface. Since no MDIO is present, register
+	 * fixed-link software_node to create phylink.
+	 */
+	ret = software_node_register_node_group(brcm_swnodes);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register software_node\n");
+	device_set_node(dev, software_node_fwnode(&parent_swnode));
+
+	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
+			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
+	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
+			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
+
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
+
+	/* SBD Interrupt */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE);
+	/* EP_DOORBELL Interrupt */
+	misc_iowrite(brcm_priv,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE);
+	/* EP_H0 Interrupt */
+	misc_iowrite(brcm_priv,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE);
+	/* EP_H1 Interrupt */
+	misc_iowrite(brcm_priv,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET,
+		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE);
+
+	rx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET;
+	tx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET;
+	vector = BRCM_XGMAC_MSI_RX_VECTOR_START;
+	for (int i = 0; i < BRCM_MAX_DMA_CHANNEL_PAIRS; i++) {
+		/* RX Interrupt */
+		misc_iowrite(brcm_priv, rx_offset, vector++);
+		/* TX Interrupt */
+		misc_iowrite(brcm_priv, tx_offset, vector++);
+		rx_offset += 4;
+		tx_offset += 4;
+	}
+
+	/* Enable Switch Link */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
+		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
+		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
+		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
+	/* Enable MSI-X */
+	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET,
+		     XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX);
 	return 0;
 }
 
+static void brcm_drv_exit_cleanup(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	device_set_node(&pdev->dev, NULL);
+	software_node_unregister_node_group(brcm_swnodes);
+}
+
 static int brcm_pci_resume(struct device *dev, void *bsp_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -272,9 +357,6 @@ static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
 	struct brcm_priv_data *brcm_priv;
 	struct stmmac_resources res;
 	struct device *dev;
-	int rx_offset;
-	int tx_offset;
-	int vector;
 	int ret;
 
 	dev = &pdev->dev;
@@ -291,13 +373,6 @@ static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
 	if (!plat->axi)
 		return -ENOMEM;
 
-	/* This device is directly attached to the switch chip internal to the
-	 * SoC using XGMII interface. Since no MDIO is present, register
-	 * fixed-link software_node to create phylink.
-	 */
-	software_node_register_node_group(brcm_swnodes);
-	device_set_node(dev, software_node_fwnode(&parent_swnode));
-
 	/* Disable D3COLD as our device does not support it */
 	pci_d3cold_disable(pdev);
 
@@ -324,6 +399,8 @@ static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
 	res.addr += BRCM_XGMAC_IOMEM_CFG_REG_OFFSET;
 	brcm_priv->xgmac_regs = res.addr;
 
+	plat->init		= brcm_drv_init;
+	plat->exit		= brcm_drv_exit_cleanup;
 	plat->suspend		= stmmac_pci_plat_suspend;
 	plat->resume		= brcm_pci_resume;
 	plat->bsp_priv = brcm_priv;
@@ -332,78 +409,17 @@ static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LOW,
-			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_LO_VALUE);
-	pci_write_config_dword(pdev, XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HIGH,
-			       XGMAC_PCIE_CFG_MSIX_ADDR_MATCH_HI_VALUE);
-
-	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_OFFSET,
-		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_LO_VALUE);
-	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_OFFSET,
-		     XGMAC_PCIE_MISC_MSIX_ADDR_MATCH_HI_VALUE);
-
-	/* SBD Interrupt */
-	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_OFFSET,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_SBD_ALL_VALUE);
-	/* EP_DOORBELL Interrupt */
-	misc_iowrite(brcm_priv,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_OFFSET,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST_DBELL_VALUE);
-	/* EP_H0 Interrupt */
-	misc_iowrite(brcm_priv,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_OFFSET,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST0_VALUE);
-	/* EP_H1 Interrupt */
-	misc_iowrite(brcm_priv,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_OFFSET,
-		     XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_EP2HOST1_VALUE);
-
-	rx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_RX0_PF0_OFFSET;
-	tx_offset = XGMAC_PCIE_MISC_MSIX_VECTOR_MAP_TX0_PF0_OFFSET;
-	vector = BRCM_XGMAC_MSI_RX_VECTOR_START;
-	for (int i = 0; i < BRCM_MAX_DMA_CHANNEL_PAIRS; i++) {
-		/* RX Interrupt */
-		misc_iowrite(brcm_priv, rx_offset, vector++);
-		/* TX Interrupt */
-		misc_iowrite(brcm_priv, tx_offset, vector++);
-		rx_offset += 4;
-		tx_offset += 4;
-	}
-
-	/* Enable Switch Link */
-	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_MII_CTRL_OFFSET,
-		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_RX |
-		     XGMAC_PCIE_MISC_MII_CTRL_PAUSE_TX |
-		     XGMAC_PCIE_MISC_MII_CTRL_LINK_UP);
-	/* Enable MSI-X */
-	misc_iowrite(brcm_priv, XGMAC_PCIE_MISC_PCIESS_CTRL_OFFSET,
-		     XGMAC_PCIE_MISC_PCIESS_CTRL_EN_MSI_MSIX);
-
 	ret = brcm_config_multi_msi(pdev, plat, &res);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"%s: ERROR: failed to enable IRQ\n", __func__);
-		goto err_disable_msi;
-	}
-
-	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
-		goto err_disable_msi;
-
-	return ret;
-
-err_disable_msi:
-	pci_free_irq_vectors(pdev);
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to configure IRQ\n");
 
-	return ret;
+	return stmmac_dvr_probe(&pdev->dev, plat, &res);
 }
 
 static void dwxgmac_brcm_pci_remove(struct pci_dev *pdev)
 {
 	stmmac_dvr_remove(&pdev->dev);
-	pci_free_irq_vectors(pdev);
-	device_set_node(&pdev->dev, NULL);
-	software_node_unregister_node_group(brcm_swnodes);
 }
 
 static const struct pci_device_id dwxgmac_brcm_id_table[] = {
-- 
2.34.1


