Return-Path: <netdev+bounces-167336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D60A39D95
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B426167ED2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243E26AAA1;
	Tue, 18 Feb 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+kxQs1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE3269B03;
	Tue, 18 Feb 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885265; cv=none; b=CFmFKH5OVFHhI9oIpo+MapZIdRyhBgXjHe5XSAXCzy8zL1XL7h5MS897N3rkawev1nrGU2wi2NX6w9vHbUH1EYdKF978l7i9GRaMEW+iHnYZ3i7Oe5jvaRU2OoHJDwmkeKgIEBFpUPSTEOx1q3FyR5abtxPITlTOT93hjwRCb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885265; c=relaxed/simple;
	bh=AJKyiXBafQUU2GUK7AJl0waPaVhJd3oQT87yxSvobvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4XTOc0v3wg1blmbwxkSfz4FGjCHVeCFvUsCpGIy8v4cKS3caTtZ6KO45T5NB7Ye9FKMxx0zfth+yuClXhk6nOHn0hI3wVAmyFGdplcc4nqI5gyJe2yNljE1xo7zVHXJrL2r1qE7lo4eKkNo1KdPuAdLQPOoDjsgpDgGL2iFalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+kxQs1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AB1C4CEE2;
	Tue, 18 Feb 2025 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885265;
	bh=AJKyiXBafQUU2GUK7AJl0waPaVhJd3oQT87yxSvobvE=;
	h=From:To:Cc:Subject:Date:From;
	b=p+kxQs1YIab8Jsxu8m5/6WK6C1bPtYDQRySad4qGSEE4/CavI+ZXsPmAYNRZxKDN/
	 gs+acWA7zva4f052NKytP/Z/jNhM3dc5XBpEZtllL1rSnCWlGSWx/vdkwSh24RDX22
	 H6E5HQJ6SUEwHVtcBRacnzo6vevnIDt3tHgQ2UraOP6tQddnYmDUolehDZauQp8Neo
	 oU2TsQCIPqWel4Pe91YXBaYLxRKY/Vmt3CSVO3bg/+7EzSO5//NuoFns0tNLebaylG
	 sPAqmlyeFDO5niDOcQ70O8iMoJ2qkdBBV3GpdiXvFwz1qihcjaAx+2ivV8QEKZUxWB
	 GDI2aPis+n8lw==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2] stmmac: Replace deprecated PCI functions
Date: Tue, 18 Feb 2025 14:21:21 +0100
Message-ID: <20250218132120.124038-2-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

The PCI functions
  - pcim_iomap_regions()
  - pcim_iomap_table() and
  - pcim_iounmap_regions()
have been deprecated.

The usage of pcim_* cleanup functions in the driver detach path (remove
callback) is actually not necessary, since they perform that cleanup
automatically.

Furthermore, loongson_dwmac_probe() contains a surplus loop. That loop
does not use index i in pcim_iomap_regions(), but costantly attempts to
request and ioremap BAR 0. This would actually fail (since you cannot
request the same BAR more than once), but presumably never fails because
the preceding length check detects that all BARs except for 0 do not
exist.

Replace them with pcim_iomap_region(). Remove the surplus loop.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
  - Fix build errors because of missing ';'
  - Address in the commit message why the patch removes a loop. (Andrew)
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 31 ++++++-------------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 24 ++++----------
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bfe6e2d631bd..6f7c479c1a51 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,6 +11,8 @@
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
+#define DRIVER_NAME "dwmac-loongson-pci"
+
 /* Normal Loongson Tx Summary */
 #define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
 /* Normal Loongson Rx Summary */
@@ -520,9 +522,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 {
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_pci_info *info;
-	struct stmmac_resources res;
+	struct stmmac_resources res = {};
 	struct loongson_data *ld;
-	int ret, i;
+	int ret;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -552,17 +554,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	pci_set_master(pdev);
 
 	/* Get the base address of device */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-		if (ret)
-			goto err_disable_device;
-		break;
-	}
-
-	memset(&res, 0, sizeof(res));
-	res.addr = pcim_iomap_table(pdev)[0];
+	res.addr = pcim_iomap_region(pdev, 0, DRIVER_NAME);
+	ret = PTR_ERR_OR_ZERO(res.addr);
+	if (ret)
+		goto err_disable_device;
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
@@ -606,7 +601,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct loongson_data *ld;
-	int i;
 
 	ld = priv->plat->bsp_priv;
 	stmmac_dvr_remove(&pdev->dev);
@@ -617,13 +611,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
 		loongson_dwmac_msi_clear(pdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		pcim_iounmap_regions(pdev, BIT(i));
-		break;
-	}
-
 	pci_disable_device(pdev);
 }
 
@@ -673,7 +660,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
 
 static struct pci_driver loongson_dwmac_driver = {
-	.name = "dwmac-loongson-pci",
+	.name = DRIVER_NAME,
 	.id_table = loongson_dwmac_id_table,
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 352b01678c22..9d45af70d8a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -155,7 +155,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 {
 	struct stmmac_pci_info *info = (struct stmmac_pci_info *)id->driver_data;
 	struct plat_stmmacenet_data *plat;
-	struct stmmac_resources res;
+	struct stmmac_resources res = {};
 	int i;
 	int ret;
 
@@ -188,13 +188,13 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
-	/* Get the base address of device */
+	/* The first BAR > 0 is the base IO addr of our device. */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-		ret = pcim_iomap_regions(pdev, BIT(i), pci_name(pdev));
-		if (ret)
-			return ret;
+		res.addr = pcim_iomap_region(pdev, i, STMMAC_RESOURCE_NAME);
+		if (IS_ERR(res.addr))
+			return PTR_ERR(res.addr);
 		break;
 	}
 
@@ -204,8 +204,6 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	memset(&res, 0, sizeof(res));
-	res.addr = pcim_iomap_table(pdev)[i];
 	res.wol_irq = pdev->irq;
 	res.irq = pdev->irq;
 
@@ -226,21 +224,11 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
  * stmmac_pci_remove
  *
  * @pdev: platform device pointer
- * Description: this function calls the main to free the net resources
- * and releases the PCI resources.
+ * Description: Main driver resource release function
  */
 static void stmmac_pci_remove(struct pci_dev *pdev)
 {
-	int i;
-
 	stmmac_dvr_remove(&pdev->dev);
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		pcim_iounmap_regions(pdev, BIT(i));
-		break;
-	}
 }
 
 static int __maybe_unused stmmac_pci_suspend(struct device *dev)
-- 
2.47.1


