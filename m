Return-Path: <netdev+bounces-98976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B208D3471
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB1EB22CE0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F854180A95;
	Wed, 29 May 2024 10:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143B17BB09
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978005; cv=none; b=vBkq/DKmNr1pJ2yPdNMPU1cREPCEeE6aE7+t6HPymS59yS139veF7rrgJpbrfGQAH5lK5G8Ob071d0yw8N8m9Mohk2fD9lNNEpwptUiFk8k58VomQslTCGfrFW4MWr5/lYyEHkCx94sZV4Q8myFg8jDIdwlW9vpCJ0z5ixbna0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978005; c=relaxed/simple;
	bh=x/nyIW0QAr8mJSAJ24msUKDQShTgTs6p5sOuZ87Tfo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFm86JFpRvFGYTFf6sFUC2MQrpnM74ZHwY+u0J7KaMx3V3v9trqdjWBEuSRx8M6CFfjCAB7ZrW9yebb0hBm4jv4o/v905rj+3l4YKgZvnH+1C9acjcBjgPTWGvgCIjGhzs2PVp3qh+7FBG/oOHpqJLV4LZDry0cfWjDNQSqZmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8CxOupSAVdmDBkBAA--.4578S3;
	Wed, 29 May 2024 18:20:02 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWcZOAVdmn94MAA--.34007S4;
	Wed, 29 May 2024 18:20:01 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v13 09/15] net: stmmac: dwmac-loongson: Introduce PCI device info data
Date: Wed, 29 May 2024 18:19:48 +0800
Message-Id: <817880fd50d623ac84f6a01fc7eb3748864386a8.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxWcZOAVdmn94MAA--.34007S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCryfZr17JF47tr47XFy5trc_yoW5Xr47pF
	y3AasxWrZ3tF1Skan5JFWDZFy5ArW5t3sruF4xJwnrKas2y342qF10gFWjyr1xAFWkWF17
	Zr4jkw48uF4DJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxzuWDUUUU

Just introduce PCI device info data to prepare for later
ACPI-base support. Loongson machines may use UEFI (implies
ACPI) or PMON/UBOOT (implies FDT) as the BIOS.

The BIOS type has no relationship with device types, which
means: machines can be either ACPI-based or FDT-based.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 0289956e274b..fec2aa0607d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,6 +11,10 @@
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
 
+struct stmmac_pci_info {
+	int (*setup)(struct plat_stmmacenet_data *plat);
+};
+
 static void loongson_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
@@ -54,9 +58,14 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
 	return 0;
 }
 
+static struct stmmac_pci_info loongson_gmac_pci_info = {
+	.setup = loongson_gmac_data,
+};
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
+	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
 	struct device_node *np;
 	int ret, i, phy_mode;
@@ -107,6 +116,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		break;
 	}
 
+	info = (struct stmmac_pci_info *)id->driver_data;
+	ret = info->setup(plat);
+	if (ret)
+		goto err_disable_device;
+
 	plat->bus_id = of_alias_get_id(np, "ethernet");
 	if (plat->bus_id < 0)
 		plat->bus_id = pci_dev_id(pdev);
@@ -122,7 +136,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	pci_set_master(pdev);
 
-	loongson_gmac_data(plat);
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
@@ -224,7 +237,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 			 loongson_dwmac_resume);
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
-	{ PCI_DEVICE_DATA(LOONGSON, GMAC, NULL) },
+	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
-- 
2.31.4


