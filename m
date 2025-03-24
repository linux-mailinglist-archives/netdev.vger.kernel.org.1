Return-Path: <netdev+bounces-177040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9EA6D76D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A273B3C45
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEC825DD13;
	Mon, 24 Mar 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijNDJqpO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777F25D909;
	Mon, 24 Mar 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808624; cv=none; b=GoQX/N2kbmyJLfnYmpmEa+00PKJ0K77OPAt7vWMnXSaikAos56B5brjqcYWT9ZC1Zu6ygc9PNeRkAEo4T+ArmMgjeDUlhivNY0RcPDY+iPxe5NXHnR0xqxvJplraTStpK0sRDEpjpGD9U9Qe7p1YiYcIZ9GSplKHpP6rRrZcS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808624; c=relaxed/simple;
	bh=IPzrS0/Zcd1NgbTKD2p6gprmFogxoNJ569d846NwIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCdWTtdvDy8V+0qWQWPyDOVMINjTHmM5lE8bsPppiuZdqszYPcMFV/CuHihvpOAFF8ZDSGTrxQuE0Ai+gBdvxoC++J5y5NMW/TzgrBKuMuKAO0HCHGMnn99/xvyJCBaubwBb7p5hRBeMPJk1XS7McLZ3y8Zjg5vQp0S0pgXmGE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijNDJqpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1E9C4CEDD;
	Mon, 24 Mar 2025 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742808624;
	bh=IPzrS0/Zcd1NgbTKD2p6gprmFogxoNJ569d846NwIW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijNDJqpOO/9i/N70VDeLvEcXIYYBfUVNZaMbGsiH+SN6JXsWEQNTYaU5Yg56bkDrq
	 ASlVFNPr8XpZVXQbahLP5/XBLN6Vx9RDzHQKrh1XtCDR5FH8VEDTp+hM3jcvJotkZn
	 Y9jx6KGtekRJi97hnODq2Qm2TsRIUYsPsZ+4w6RDLu5DhQuYQAeESzjUGqQUBo+Fpr
	 cFBLJPAZjIjR9Xg6vbNAZtuiPACjWDcXk2OwCWR3gGSHBWEZmMghj+Cvty9uYa2ng1
	 Kl08LPtdM9Q6vSI829TTCo8Fd+e9OJ+64lpH2n35grdfFUhwmitVXWeAWCTLH3zIkW
	 hfGs94nL4i1cQ==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yinggang Gu <guyinggang@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Henry Chen <chenx97@aosc.io>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v4 3/3] stmmac: Replace deprecated PCI functions
Date: Mon, 24 Mar 2025 10:29:30 +0100
Message-ID: <20250324092928.9482-6-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324092928.9482-2-phasta@kernel.org>
References: <20250324092928.9482-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI functions
  - pcim_iomap_regions() and
  - pcim_iomap_table()
have been deprecated.

Replace them with their successor function, pcim_iomap_region().

Make variable declaration order at closeby places comply with reverse
christmas tree order.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Tested-by: Henry Chen <chenx97@aosc.io>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  8 +++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     | 12 +++++-------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index e015e54d9190..1a93787056a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -533,8 +533,8 @@ static int loongson_dwmac_fix_reset(void *priv, void __iomem *ioaddr)
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
+	struct stmmac_resources res = {};
 	struct stmmac_pci_info *info;
-	struct stmmac_resources res;
 	struct loongson_data *ld;
 	int ret;
 
@@ -566,13 +566,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	pci_set_master(pdev);
 
 	/* Get the base address of device */
-	ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
+	res.addr = pcim_iomap_region(pdev, 0, DRIVER_NAME);
+	ret = PTR_ERR_OR_ZERO(res.addr);
 	if (ret)
 		goto err_disable_device;
 
-	memset(&res, 0, sizeof(res));
-	res.addr = pcim_iomap_table(pdev)[0];
-
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
 	plat->fix_soc_reset = loongson_dwmac_fix_reset;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 1637c8139b9d..9c1b54b701f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -155,9 +155,9 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 {
 	struct stmmac_pci_info *info = (struct stmmac_pci_info *)id->driver_data;
 	struct plat_stmmacenet_data *plat;
-	struct stmmac_resources res;
-	int i;
+	struct stmmac_resources res = {};
 	int ret;
+	int i;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -192,9 +192,9 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
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
 
-- 
2.48.1


