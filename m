Return-Path: <netdev+bounces-169752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A809A458FF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6E16CAA9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC1224253;
	Wed, 26 Feb 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq/JSX2S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107B20DD7A;
	Wed, 26 Feb 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559953; cv=none; b=KARGWs5/bieMVVWGSiHfD6pG8zAfML3acYkmSbpF8iZ4tsrdAmMMKfj8xP8nGRZIq+9pLZ2FpIByo/LGit/qA5k5SN28DlnQyTn4bFtup1Ak6lGXxdcSfAV9pAmfye81TwjvywUJ313D4yoDpxfJ0fQ9+ygPSyIMsAS11yljU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559953; c=relaxed/simple;
	bh=Y8/MDMfs1bwprrJrMnPBGIZtYhcw/F6xhmmiWJV6T6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBZeUoy/aWhidQYqzPBbtucl37fDsXsyGjsEz0bLmzNeiP9sT7kZNgYanGVdiDw9pdZEsMducPFZKHbT8nRizwmVJTcLA4NSpM0khEUie4T+P115l1dJr07mHlKUUeeigxzQ1PdSkPjTU+vIoi+fsjaeGT5IaWmmPu6YXP7vyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq/JSX2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F063C4CEE9;
	Wed, 26 Feb 2025 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559953;
	bh=Y8/MDMfs1bwprrJrMnPBGIZtYhcw/F6xhmmiWJV6T6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lq/JSX2SNwHdFUwb43jUWWSRDyZIqIvZzAOTfytscfkXJQrAxZ8J1HAi1Sv1aDayj
	 oWzC0Mi2lIM4rzUBMLZdDE4bdJLJT82M6+DWQpTqKPi7aAd8cBr3QDfwvCII6haif9
	 7VQ62Uvw6Cc7g+Vtu8p38girQHx7VNmRNOeHciSmaT4BVGPMqKOOqpeIs3ata+c1E8
	 bM/nj81j/n5YS4SLnzZepeN5VjZRb0u3qTClcppYJTU4YIOiZvn80kzpSFQBUSfW5Y
	 gm0oDIqgoeZFgKRr/wAmBzFJ1yVvX8RDa4OEtZcPAEYhWz5ygAeT8YfekEy3+FEhjA
	 Hb2V4M2OYtTuA==
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
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Henry Chen <chenx97@aosc.io>
Subject: [PATCH net-next v4 4/4] stmmac: Replace deprecated PCI functions
Date: Wed, 26 Feb 2025 09:52:08 +0100
Message-ID: <20250226085208.97891-5-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226085208.97891-1-phasta@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Tested-by: Henry Chen <chenx97@aosc.io>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  8 +++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 14 ++++++--------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 5d7746d787ac..25ef7b9c5dce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -521,8 +521,8 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
+	struct stmmac_resources res = {};
 	struct stmmac_pci_info *info;
-	struct stmmac_resources res;
 	struct loongson_data *ld;
 	int ret;
 
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 1637c8139b9d..b7adda35b7b7 100644
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


