Return-Path: <netdev+bounces-91319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29118B2242
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAC42819A6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F3149C43;
	Thu, 25 Apr 2024 13:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718461EB48
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050709; cv=none; b=JXoXObU+4UYqUje9JvRATbrZMh6kFLnLUxQc+HCv9C+EDMAkBrbKMWJxJCHS6d+K2INzudfLTsdCiEfYGyFKhHv/o6pCRblPgW4MCHISFeYwP+g6IfBTh/oPQqWan+ZFKenUyY4JY+/MmFYXvsP1DQM0IE/bmevphuvKVj69Uig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050709; c=relaxed/simple;
	bh=TbRPAcVRZkLYnuObXUfDUFegYfbQpOkPdkru5YufLUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwgQ119/si9RUOLjB8z8H4oGtEy3rAoKKuQ0Dzs4pr7LSQNEp/rB/RynylTAKLb7D7V3C4PSB2yngyaMlTo6l4shmWdxTAvctOR4iq2XPBbp2tkDCQ9/2Rt+BMYUNEmvAzqWbvBiDSN3SWXajpt8sfaITDwBX8LSArDYR2IC3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Dxd_CSVipmwNACAA--.13271S3;
	Thu, 25 Apr 2024 21:11:46 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnleKVipmWBsFAA--.13037S3;
	Thu, 25 Apr 2024 21:11:44 +0800 (CST)
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
Subject: [PATCH net-next v12 14/15] net: stmmac: dwmac-loongson: Move disable_force flag to _gnet_date
Date: Thu, 25 Apr 2024 21:11:37 +0800
Message-Id: <7235e4af89c169e79f0404a3dc953f1756bab196.1714046812.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8BxnleKVipmWBsFAA--.13037S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFyDXw1xKryUXrW5CFW7Awc_yoW8WrW7p3
	93Ca4j9ryfJF15Can8JrWDXFyY9FWUt397WFZFywnxuFZ7t3sIqr97KFWYyry7ZrWkXFy2
	qr48Cr48uFn8GwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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

We've already introduced loongson_gnet_data(), so the
STMMAC_FLAG_DISABLE_FORCE_1000 should be take away from
loongson_dwmac_probe().

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 68de90c44feb..dea02de030e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -286,6 +286,12 @@ static int loongson_gnet_data(struct pci_dev *pdev,
 	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
 	plat->fix_mac_speed = loongson_gnet_fix_speed;
 
+	/* GNET devices with dev revision 0x00 do not support manually
+	 * setting the speed to 1000.
+	 */
+	if (pdev->revision == 0x00)
+		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
+
 	return 0;
 }
 
@@ -540,13 +546,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		break;
 	}
 
-	/* GNET devices with dev revision 0x00 do not support manually
-	 * setting the speed to 1000.
-	 */
-	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GNET &&
-	    pdev->revision == 0x00)
-		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
-
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_disable_device;
-- 
2.31.4


