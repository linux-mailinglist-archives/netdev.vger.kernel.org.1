Return-Path: <netdev+bounces-174649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C56A5FB3A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F35189FCB2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06226A0D3;
	Thu, 13 Mar 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBas+Xyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3226A0CC;
	Thu, 13 Mar 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882490; cv=none; b=knJlTnMQd6EwDUWaekMdMrzhcoGBicLtd7CrYJHBA6cTUl5cMwo2IgLNx3Y6ulQ2KiA2/I2DxHoI6jTj1z4PmyMuJ+iQhQdNLmQ1hIG4kruhghLPkdNj56XMRf5zjkBTpPxN4agle7mXXrF3sonGcybCtHEfqCsv9orcWZh18Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882490; c=relaxed/simple;
	bh=Y8/MDMfs1bwprrJrMnPBGIZtYhcw/F6xhmmiWJV6T6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2edEuezkQ2lelZtHhD0r1DEWQfcKvEQQn6aGuG8hxyk7k0vnNnd1t3C+7ZliWTdVfKr2iPZKXekesoOxKxOhT1BwBQZAXXdTuxls+j0nJrH6tq+C+YjQFWg5RvxZdZDkjFZg1rnnuOh6vIOtlbRjyf0qtFDPgDbOhS1fXvw3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBas+Xyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E409AC4CEEE;
	Thu, 13 Mar 2025 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741882490;
	bh=Y8/MDMfs1bwprrJrMnPBGIZtYhcw/F6xhmmiWJV6T6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBas+XyrOTNPJWUphlmNLX688HmEaBK54fr41BRraE1SYejqEdjCHI5FyhBDUmbHS
	 QEW7Zd152Yog4KahsAuOQr1/cObt7WrS8l+QlIP2V1EZ8PgzVej5M7qFkTnkb94yK0
	 FxGByoDLRv8wP3ZnFTGJ/Xci8ME6FV6zfuTOBs0nOmch9y/GSL5ERjZMrtYkmH2kqg
	 MGSfQD0h2KDectZHJbrOfkdD63TvY280mDfoU+YACl7lUBWDlCVRuuxPkjyWVl3lso
	 L/+e/MUGjZtiqIAE1ciFeA/Biayk2qyxOMHqxma08amizDszWbFq/04OUCKEUZt42w
	 RrxdH/yMlOpKw==
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
	Serge Semin <fancer.lancer@gmail.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Henry Chen <chenx97@aosc.io>
Subject: [PATCH net-next 3/3] stmmac: Replace deprecated PCI functions
Date: Thu, 13 Mar 2025 17:14:23 +0100
Message-ID: <20250313161422.97174-5-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313161422.97174-2-phasta@kernel.org>
References: <20250313161422.97174-2-phasta@kernel.org>
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


