Return-Path: <netdev+bounces-149814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A699E79C6
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16711886EC8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491AA2135C6;
	Fri,  6 Dec 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePU9y7gE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C620ADF7
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515479; cv=none; b=a/S0xo4dv+uxtWvQ1RmV71Ps9WPBxeTBPBL93sRIT31Vx0696O5BxPF/8vX6GVQ4+scSkKVvkWbKtWBvY9hRsqbTuB/II2UVSXShZlT3ZOJDWLTurRhxbvKhCBZHHarkFNK7cogzoBibeqkruor7uHtA52DqQN/0Efqc5uJ1rgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515479; c=relaxed/simple;
	bh=vIG7g6S+y3x8IVVR0Rwd2ra4ixtI7rPHq7MMT+V5aUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L29u2b/sQv3UgjX2u/Oj/bhcXRpZb7CYCC9xD1UsRqnZw0NfXO3qX1cNeei94pf6LIYEJgq1ZpqpIl1FvVOm+aIq7Pls8OMqKeIQrLmf6OEoF43PXilyvUwoKwcfgXlDC8NjTStEc0uJQo4KyJFhHEVfPCH8hsiFCuiYCcNlIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePU9y7gE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733515476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fMjHOTJ3IG23u1irgURN19CYjdI/G0om6iCqk5PM28U=;
	b=ePU9y7gEPk/dhRQzr4snitiGEcf8K1cRCEhMsLYiXZ2bRd6CqhC7BysR0sYYOokCJw4sST
	nst8G0Fq5+FSMM2spXpsjmC89XbSByznQ3OEqEQWUL7Jo3PaQiBTKhIvIbki+YxEKi/sWQ
	hzjgx972mQuFMXzgmrYf+Vi38B7dTPo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-oEMSgHCUNEmAPQo07C0I8g-1; Fri, 06 Dec 2024 15:04:34 -0500
X-MC-Unique: oEMSgHCUNEmAPQo07C0I8g-1
X-Mimecast-MFC-AGG-ID: oEMSgHCUNEmAPQo07C0I8g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa638133084so194784966b.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 12:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515473; x=1734120273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMjHOTJ3IG23u1irgURN19CYjdI/G0om6iCqk5PM28U=;
        b=RUgahr6S4mp2jXggtiIZzttj+3uneaunB2alVzaowE9Az2zIzR9wy04riQ1Hnprg/v
         YwxO1y+GevaOj+UutaYSizctyeIvMpiz9YgCkHAcqO15gXgAHooLoyndYUSHc5Yr2mAO
         H5R2OmtcczfBqfKTVD7jN2UoP1omIjV6HY0TRo5bdFU1fil1DkM4MJ8bQRFDlXE5DVhP
         dU57m/7yUGpC6r4iL9rR6E9tGkKaKA5oMAp9WUO4BNSNI6XwbJZwsk3RedpjZM7V2VNf
         +17mDUGClUFm46IHvZ1OzzWOogqz1s9TVb1BK0UHWeuVDYRhliNmVWk8SnOzcaSC/C85
         2J1w==
X-Gm-Message-State: AOJu0YztT5MGn4amiP/7EdMxuROz1aaGaqCexUb5wiRTAF2Hf3/zemul
	TJHrgZYBHcoP5HmlAnXqMN02g+kkVnRa8PjRd0xVTkp4N5nrN2n1+EOCl88p/wGywg4yINt2QYO
	u+BYSp3iI5UyzQlYEAzBVxPG1f/GO4DZkzpPSVFRC8hCfNaUm7ZYoeg==
X-Gm-Gg: ASbGncvhLTlEwnTVjhgm7pZGNaguKR7YrtvzeDDpMyVMaV47JddMy/2AXrdb7Umg47f
	AbRKYXrOqGINQO5kpvTp5f/mHdQXTGAgBh5ITl38LzsS0YOseiJYDTlybh5mvLHsfXBVrjORRMx
	htuKC+jKNT8rB7hiP5bTNxuAcoPQhKwv+fHxp/3waZGk4GIwwBjwLA5NYuXbOe8852CSSezR+1m
	8Z82EV9wW5RCH2hAPW15phxBmzydukwSmlehjSl+udU/pjevwZe7ReMitdVQbycnxiw94CCckzg
	FkXi9h/44oHo4Zt1S+TVbM1jMb7NfMGTJG4Abh/W8Dh1VhfO
X-Received: by 2002:a17:906:c10b:b0:aa5:3fe7:4475 with SMTP id a640c23a62f3a-aa6203311dfmr900970966b.11.1733515473389;
        Fri, 06 Dec 2024 12:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+BQutmvcA0nsCT88Amhm9QkyS+wJzkpWUQDFYNpirUHnJMDP0FLESOGwII887k38IbqsJUg==
X-Received: by 2002:a17:906:c10b:b0:aa5:3fe7:4475 with SMTP id a640c23a62f3a-aa6203311dfmr900967666b.11.1733515472947;
        Fri, 06 Dec 2024 12:04:32 -0800 (PST)
Received: from eisenberg.fritz.box (200116b82da23a00e80f0db59251468d.dip.versatel-1u1.de. [2001:16b8:2da2:3a00:e80f:db5:9251:468d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e9706csm281725266b.71.2024.12.06.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:04:32 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] net: wwan: t7xx: Replace deprecated PCI functions
Date: Fri,  6 Dec 2024 20:57:13 +0100
Message-ID: <20241206195712.182282-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem.

Replace them with pcim_iomap_region().

Additionally, pass the actual driver name to that function to improve
debug output.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 8381b0dc7acb..02f2ec7cf4ce 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -43,6 +43,8 @@
 #include "t7xx_state_monitor.h"
 #include "t7xx_port_proxy.h"
 
+#define DRIVER_NAME "mtk_t7xx"
+
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
 
@@ -833,6 +835,7 @@ static void t7xx_pci_infracfg_ao_calc(struct t7xx_pci_dev *t7xx_dev)
 static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct t7xx_pci_dev *t7xx_dev;
+	void __iomem *iomem;
 	int ret;
 
 	t7xx_dev = devm_kzalloc(&pdev->dev, sizeof(*t7xx_dev), GFP_KERNEL);
@@ -848,12 +851,21 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 
-	ret = pcim_iomap_regions(pdev, BIT(T7XX_PCI_IREG_BASE) | BIT(T7XX_PCI_EREG_BASE),
-				 pci_name(pdev));
+	iomem = pcim_iomap_region(pdev, T7XX_PCI_IREG_BASE, DRIVER_NAME);
+	ret = PTR_ERR_OR_ZERO(iomem);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not request BARs: %d\n", ret);
+		dev_err(&pdev->dev, "Could not request IREG BAR: %d\n", ret);
 		return -ENOMEM;
 	}
+	IREG_BASE(t7xx_dev) = iomem;
+
+	iomem = pcim_iomap_region(pdev, T7XX_PCI_EREG_BASE, DRIVER_NAME);
+	ret = PTR_ERR_OR_ZERO(iomem);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not request EREG BAR: %d\n", ret);
+		return -ENOMEM;
+	}
+	t7xx_dev->base_addr.pcie_ext_reg_base = iomem;
 
 	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
@@ -867,9 +879,6 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	IREG_BASE(t7xx_dev) = pcim_iomap_table(pdev)[T7XX_PCI_IREG_BASE];
-	t7xx_dev->base_addr.pcie_ext_reg_base = pcim_iomap_table(pdev)[T7XX_PCI_EREG_BASE];
-
 	ret = t7xx_pci_pm_init(t7xx_dev);
 	if (ret)
 		return ret;
@@ -937,7 +946,7 @@ static const struct pci_device_id t7xx_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
 
 static struct pci_driver t7xx_pci_driver = {
-	.name = "mtk_t7xx",
+	.name = DRIVER_NAME,
 	.id_table = t7xx_pci_table,
 	.probe = t7xx_pci_probe,
 	.remove = t7xx_pci_remove,
-- 
2.47.0


