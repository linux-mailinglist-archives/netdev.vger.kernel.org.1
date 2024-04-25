Return-Path: <netdev+bounces-91318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652008B223E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F3B20AD7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2A149C67;
	Thu, 25 Apr 2024 13:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861151EB48
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050653; cv=none; b=KDecSFuf3bV+2tuQPU+Ji1MTgcFOAySjshTtnq0IcYruohBBAEoFSA2mz+IjBMmxCEqKZ+qTGCHDrbozy9FvyBiMDMzBVLL6tHeBaYx+cSsLMDTl0p0pk9LJhpgUvlNISzX8zvh8iJQOWB9/lCFCf/ZWoD+ww8V92MmHBnI5QOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050653; c=relaxed/simple;
	bh=GAtMvV3d1neANH66V3l71yWo2bjvwGOgixl/4IXXReU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8sS/F5GiLWvjuN7l8115ni+2uqSDIvvUk5rDijd+W9jTW9IsxgG1+28u46gyPoSD5ksEhgSsA8IxsOXQJzVwMwCcLKF0hJhN6slXssHtdreKP9vWoDYDl+K1h4eOEnl8owi/MG6fa+5T/DfnDmIWRf41S7OQCFN9YNUmCIOHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8AxK+paVipmp9ACAA--.799S3;
	Thu, 25 Apr 2024 21:10:50 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+91SVipmIRsFAA--.17935S4;
	Thu, 25 Apr 2024 21:10:48 +0800 (CST)
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
	siyanteng01@gmail.com
Subject: [PATCH net-next v12 12/15] net: stmmac: dwmac-loongson: Fixed failure to set network speed to 1000.
Date: Thu, 25 Apr 2024 21:10:37 +0800
Message-Id: <9b9f8ddd1e3ac9e05fa0d15585e172a4965f675f.1714046812.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1714046812.git.siyanteng@loongson.cn>
References: <cover.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx+91SVipmIRsFAA--.17935S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFyxCw15Kw4DXF43CF1Dtwc_yoW5XF18pa
	9rAa429r1xtF1xJw4kAw4UXFyYgayUKrWxWrW2ywsI9FZ7t39aqr1avFWYyFy7ArZ8uFya
	qr4DCr4UuFn8CwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bOfHUUUUUU=

GNET devices with dev revision 0x00 do not support manually
setting the speed to 1000.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
 include/linux/stmmac.h                               | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index df5899bec91a..a16bba389417 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -10,6 +10,7 @@
 #include "stmmac.h"
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
 
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
@@ -179,6 +180,13 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
 
+	/* GNET devices with dev revision 0x00 do not support manually
+	 * setting the speed to 1000.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
+	    pdev->revision == 0x00)
+		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_disable_msi;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 542e2633a6f5..eb4b3eaf9e17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 		return 0;
 	}
 
+	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg != AUTONEG_ENABLE)
+			return -EOPNOTSUPP;
+	}
+
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 1b54b84a6785..c5d3d0ddb6f8 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -223,6 +223,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
+#define STMMAC_FLAG_DISABLE_FORCE_1000		BIT(13)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


