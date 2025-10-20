Return-Path: <netdev+bounces-230870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1276BF0C1D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CDC189FA9F
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4552FC864;
	Mon, 20 Oct 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWHW06Vj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49502FB63F
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958707; cv=none; b=TILjthVId7WhS2raTmAoh4WoPV1C/kuquecKmMOtifgcGo24ttTO5y+Xec+zkVRxXSlvNq2/dQEnZsuwuF/HX8nP+Y2ZWy87KSXjc7PxcjD3WpKUleC/HUTKg8CzuQskLoRKDP7e6I14bs6Ix7qmahrZQA8hLDgIf+xSlDu0nR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958707; c=relaxed/simple;
	bh=d6sfJJmsrn4jmlJ0VLaRv55O7ZBthMgGtDA6+FXK5CM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUvZsGB76OZtUAxRQ5s4Zppe9zasdEgdF1ymOOJ3WZKg+zx6Ssz1k/aE6YBG2yTaR0d/ROzE3lXR/P9P27m5ynm+iyMAhnOyIv69/6nyIYi3oxPm0zUIkfN/KBFI7u3NXDJwoMWnsnOnafb2cF45zzxyKo2hyobq7J3bsRLckYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWHW06Vj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47106fc51faso50107925e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958703; x=1761563503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbIeGWFTYyfsk1cZ4GSr/dZ9OnIwY7Q2HU34N1odmLk=;
        b=JWHW06Vj/BAixmuSo+oXSZtBLOUraQVRsxPeBpILa1MOR/betLuH1d7bGmHXEfjE86
         OK7gzZ22NvyD2KNIfqOZsjwhcYDm4RmoRNB40BTIsIfN9bramdUOj+6cFWTjZj8g+cxI
         mRhYc3acliOySTs0FVzdtxo9MYCTVAbGbBhqDW8zzHA98DeXVz2F7K283o+9ZKe5QeG/
         VzlTwRMxKLTXm4ZYl7JlX9mSms8FaXdPIF0YvLZnZOtnw6u+wxaLSIOmEzhHlYurHrTF
         f4xykgysRcFOeAp2LmxPwopg/invQqBnU4jv7DqQQ67+4j3GMdt7z7Ln12/+oTfs9Jfr
         iO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958703; x=1761563503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbIeGWFTYyfsk1cZ4GSr/dZ9OnIwY7Q2HU34N1odmLk=;
        b=CtYqIBGHs2akj6auyNCcVXoXOse0wA+Kvgfk37HyOwEXlflMeemgMB3EFQs87s0yKX
         CzJamnoY8emgbPgKo/Lw9iqvf36wEWU2HDlf4SIH+e40A/23dX6Wt0eQpR6s4gBrMzbT
         DXxOAYtK6ue0x1bIG/H6aDhTxFTeLfBtFOIu6aAVAAMft3JUnqHqo8MJq/gqalDViXlK
         pZ3fiIB9UBPRPh0qHdVYFtuvjwn0ANQzq6WMVsVC3mGsLsyUODqswGapkL64wxnlAjPM
         vHv/kYhbevbInDNm8Z+FvU2rAkXo91PCeylC4ZhiuDucEZJ6GLFKmwBuL9TmYcnBLUan
         VlqA==
X-Forwarded-Encrypted: i=1; AJvYcCVk3VZvcarpCk8dFqhUj8+E07EH4nyIesGeqJc+gEGkUgzq8BCpV7IXX9fZREa5UIIYuJmO8jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9L95NbPVJijRMFicEiy8KxeWspri2AuxFhOkdPvyumstjYhA
	J+fko6goLLueQyQh87i9KuTufYiYihjsQtP5tv96r8j0T4oA8h7sAD5g
X-Gm-Gg: ASbGncuaAcOsVEEBpYXBrq0hp8EqvNKwP5ooLRT3fH3mCtWy/B8cwSybWCyGkkYkzET
	LVgzZ+Y2wiuZ7DIO+JIS5+fHP1avX/5FnalShN3imp2VpYjz0hUeVlg/pY4qmkWWQZFG2UKfKes
	5EIRzXWXbx2CRcwFl9xd7De19dR4HSc1P/XreSGtAcO7GY8Z7H3srpmzXuW22hQxnRKwthRw51x
	t+LaiykSrIij2M8hmqL6coEWDlSo80deZEFAcPNxG2hCf0qKhK3Jlj+ocv4wneELAYEXxUiWgoM
	cVNave1rAxE0b2mY9RwonqvUhb6Qjt5vjX2UHu6SCQAMDQDp/0K1SdKUeAvZUHZCia1yWA2aNoM
	qA+0H2H6gZAFWjyk94o6AKuDcuCbZ/F7WQ3tVQu8wRWAMmaDDsCDwza2Wjp5gGbUVMIs3JE34Zb
	9hiONGmvLswTQr/YEq4PI8/byREY8UaLhXRm0coOxvk48=
X-Google-Smtp-Source: AGHT+IFlMvcsghCbEtYlJFP5IolC9pAMY6FOui1RTLbJZ1uhCFPw3pViibwIRY6AzcnOgeG33heQFg==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr114423345e9.32.1760958702709;
        Mon, 20 Oct 2025 04:11:42 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 3/5] PCI: mediatek: Convert bool to single quirks entry and bitmap
Date: Mon, 20 Oct 2025 13:11:07 +0200
Message-ID: <20251020111121.31779-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
use a single quirks to reference all the values. This permits cleaner
addition of new quirk without having to define a new bool in the struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 33 ++++++++++++++++----------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..cbffa3156da1 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -142,24 +142,32 @@
 
 struct mtk_pcie_port;
 
+/**
+ * enum mtk_pcie_quirks - MTK PCIe quirks
+ * @MTK_PCIE_FIX_CLASS_ID: host's class ID needed to be fixed
+ * @MTK_PCIE_FIX_DEVICE_ID: host's device ID needed to be fixed
+ * @MTK_PCIE_NO_MSI: Bridge has no MSI support, and relies on an external block
+ */
+enum mtk_pcie_quirks {
+	MTK_PCIE_FIX_CLASS_ID = BIT(0),
+	MTK_PCIE_FIX_DEVICE_ID = BIT(1),
+	MTK_PCIE_NO_MSI = BIT(2),
+};
+
 /**
  * struct mtk_pcie_soc - differentiate between host generations
- * @need_fix_class_id: whether this host's class ID needed to be fixed or not
- * @need_fix_device_id: whether this host's device ID needed to be fixed or not
- * @no_msi: Bridge has no MSI support, and relies on an external block
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
+ * @quirks: PCIe device quirks.
  */
 struct mtk_pcie_soc {
-	bool need_fix_class_id;
-	bool need_fix_device_id;
-	bool no_msi;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
+	enum mtk_pcie_quirks quirks;
 };
 
 /**
@@ -703,7 +711,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_RST_CTRL);
 
 	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
+	if (soc->quirks & MTK_PCIE_FIX_CLASS_ID) {
 		val = PCI_VENDOR_ID_MEDIATEK;
 		writew(val, port->base + PCIE_CONF_VEND_ID);
 
@@ -711,7 +719,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
-	if (soc->need_fix_device_id)
+	if (soc->quirks & MTK_PCIE_FIX_DEVICE_ID)
 		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
 
 	/* 100ms timeout value should be enough for Gen1/2 training */
@@ -1099,7 +1107,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	host->ops = pcie->soc->ops;
 	host->sysdata = pcie;
-	host->msi_domain = pcie->soc->no_msi;
+	host->msi_domain = !!(pcie->soc->quirks & MTK_PCIE_NO_MSI);
 
 	err = pci_host_probe(host);
 	if (err)
@@ -1187,9 +1195,9 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
-	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
+	.quirks = MTK_PCIE_NO_MSI,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
@@ -1199,19 +1207,18 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
-	.need_fix_class_id = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.quirks = MTK_PCIE_FIX_CLASS_ID,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
-	.need_fix_class_id = true,
-	.need_fix_device_id = true,
 	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.quirks = MTK_PCIE_FIX_CLASS_ID | MTK_PCIE_FIX_DEVICE_ID,
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
-- 
2.51.0


