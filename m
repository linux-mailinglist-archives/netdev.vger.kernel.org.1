Return-Path: <netdev+bounces-159978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAEA1793E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9420F3AAB84
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466A1B85CA;
	Tue, 21 Jan 2025 08:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E21B4156;
	Tue, 21 Jan 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447960; cv=none; b=b0QAZYtseMaYZTd3i3Rx+B4YhPdYACySf7BBKsqEBsnql5aNdAXEL3x3LbSCdfRrnm9ESXP5miNkxnkFKiafW+ZId6jKaVxVNPBfAxG95iChQvpWfxhqhgo3RqAgVILqz653cZf28bH4WwP5O9LAv1ql/XoMcUKeCVoBuOnecWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447960; c=relaxed/simple;
	bh=Yz7LgjRtYWtSV9qBZhppFu1JFzEMz1UqreTpg+ZVBPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fv84rvSl3ygtZy7gyUywHJdm1N13uuEbfLXBI6v+3Cdn1pONcMYWwZz12MwMJ0yoSicy2UOmjYhapeLfXUSvUXeeXORELfH8EJpc3vzPW+pRBGRaRfKcC2QwUnLv3yfZqCWYtXNUUZfrtv8/pmvjYK05UorCH4L11b7ijFZrRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8AxfawSWo9n4a5mAA--.15631S3;
	Tue, 21 Jan 2025 16:25:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMAx+8QRWo9n07QpAA--.29228S2;
	Tue, 21 Jan 2025 16:25:53 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: chenhuacai@kernel.org,
	si.yanteng@linux.dev,
	fancer.lancer@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Subject: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
Date: Tue, 21 Jan 2025 16:25:36 +0800
Message-Id: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAx+8QRWo9n07QpAA--.29228S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1xCw4Dur1UAr17tr13GFX_yoW8Wr48pr
	W3Aa4agryYgryIyan8JrZ8ZFyY9rWFg3s7WFWIywsa9a9Yy3sFqFyYqF4jyr13ArZ5KF1a
	vryjkr48WF1qkwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

Loongson's GMAC device takes nearly two seconds to complete DMA reset,
however, the default waiting time for reset is 200 milliseconds

Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bfe6e2d631bd..35639d26256c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -516,6 +516,18 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 	return 0;
 }
 
+static int loongson_fix_soc_reset(void *priv, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr + DMA_BUS_MODE);
+
+	value |= DMA_BUS_MODE_SFT_RESET;
+	writel(value, ioaddr + DMA_BUS_MODE);
+
+	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
+				  !(value & DMA_BUS_MODE_SFT_RESET),
+				  10000, 2000000);
+}
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
@@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
+	plat->fix_soc_reset = loongson_fix_soc_reset;
 	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 

base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
-- 
2.43.0


