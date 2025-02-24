Return-Path: <netdev+bounces-169030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE1A4225F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B7C3A4EE4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2A25A632;
	Mon, 24 Feb 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Eg3/Sh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1803525A2C8;
	Mon, 24 Feb 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405230; cv=none; b=OCZ37VMRA25AWc/+4JGM00r2GTY1z5ZOnWMRWwdExo5W54Mlilv0Re9jWybPU69NOCyxAt22eieNtjIVQ3eEgHLIJLWgUGUiMQ6UA9zlujHhZfK9aReMg5RT8FQrdS4kMLAa1aErsJIVXbkzDQg/IZqi6P9IG/vWe2LIGONs4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405230; c=relaxed/simple;
	bh=6AJEKimFGREFIv6dQXE7i5boQezEtjb7GqUPTRe+6Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQZsK+Cf9/IBjqvMl4YmYe0Lb9g28c+umZrclSXRICDm4MrWAsd3f7jkpgevN7R23np+bjPk8E3uXHAAZXQ7/ZknLIQTQsTyDdwOeoLFwsiNS0HmXpvi6PXyM4swig7hiQkndjT5Ygg4CoVnjOBRDzOvvwrTmgpjf1kmV0BuHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Eg3/Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC87FC4CEEE;
	Mon, 24 Feb 2025 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405229;
	bh=6AJEKimFGREFIv6dQXE7i5boQezEtjb7GqUPTRe+6Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7Eg3/ShhVOZNOsWWOj84nY2fquvYuZpUvYenGvAUgmhWX+mAYZmO8am9h6dT564f
	 qWxqcrxt8f5SmxaXCrtJA/Kr+reZx49QhlqCD5oERYLLmTZ6LohaoUS4hHIcZUO3xr
	 j7yPRbs6Q+cmjY8fpLQqppHnIi+5rjc68Ml18F0WSPZTRXLlE4GXBuUliqg8dh0VOW
	 c7PvPlDqqHCh+x8e+beLjNp/mb5IGNQBuHJcYEVu8W7gqfy18bq4TvJbjCL3+Q++MA
	 bqUta3GptmlhDmQiKV7euT29ujamO7V/lxBE0BLojb7usecjMaVMC6jq6tY/oIMDZE
	 MvATDSRqbdLbw==
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
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] stmmac: Replace deprecated PCI functions
Date: Mon, 24 Feb 2025 14:53:22 +0100
Message-ID: <20250224135321.36603-6-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224135321.36603-2-phasta@kernel.org>
References: <20250224135321.36603-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

The PCI functions
  - pcim_iomap_regions() and
  - pcim_iomap_table()
have been deprecated.

Replace them with their successor function, pcim_iomap_region().

Make variable declaration order at closeby places comply with reverse
christmas tree order.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 11 ++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 14 ++++++--------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f3ea6016be68..25ef7b9c5dce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -521,10 +521,10 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
+	struct stmmac_resources res = {};
 	struct stmmac_pci_info *info;
-	struct stmmac_resources res;
 	struct loongson_data *ld;
-	int ret, i;
+	int ret;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -554,13 +554,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
 	ld->dev = &pdev->dev;
@@ -603,7 +601,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct loongson_data *ld;
-	int i;
 
 	ld = priv->plat->bsp_priv;
 	stmmac_dvr_remove(&pdev->dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 91ff6c15f977..37fc7f55a7e4 100644
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
 
-- 
2.48.1


