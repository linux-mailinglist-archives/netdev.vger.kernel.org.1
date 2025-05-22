Return-Path: <netdev+bounces-192889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C243BAC1811
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F80189E0DB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6542417C4;
	Thu, 22 May 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd6xjRIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18733221FB7;
	Thu, 22 May 2025 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956940; cv=none; b=H7DTumxHXZ3pYU8ci1kWoYO1p6KlRzGo2LhtYvv9A8WCObD5MF5V7Flym4cIUcGKBegNjv1T3x6NrDrXuoxQRpBnUXMre+zWk3gMYG9t6Whthk8uGtLborqmb9P6H4KNsjZ+GXNcHjy3y9roVG/17Rt7rkL/x8mp74KEwQvsMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956940; c=relaxed/simple;
	bh=czoIWuhXnPSr+ph5d5pGCEbEfyC8aXk7ltntHa/MeoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWLha/lPTIzERSc3Btc9enFLbgLg9tyyFr1PCPyiQ8kUL9BgjdtKwVn/ZVGqJVQBMiksTaNv2pKwIIABNHx+jJTqW7O6oJGPN4f3/QC7dcPYdZe1GcIasaDaRvhehBJwBvN2Y/u+2V7cuBlF01/NxPsh3E/QWnntx2EjfmFiZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd6xjRIX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c035f2afso3875617b3a.2;
        Thu, 22 May 2025 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747956938; x=1748561738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOzKNVIPtCb3bls2x+8GmpP1FGWXc09cxECCk2fUXy8=;
        b=Rd6xjRIXj9NdgvooUMnJc4+iazJyks/QmZ5t73CbQ0pXxhjTaZYqS+tA/hRyzVh1so
         RCoNEvnwRfjU8+rj6S8jl/LPYlJ/voeqB8XjJgd9dSmIIW/G80TzBDIuzrYDwgfs7IZW
         f9gYbgHzTe1+vPwBg3uo0JpAwTKcM69DjN4R90hkBWqF1J8605irWazITsBz7Qah79Lo
         KZQaT+vCd8BM9hIUnXa/HuqoOuM8nEiHdKY69LwybDFoFGnf4O3mJTxGB8d3az7ib8SS
         6skr5T7MSOcvpIvjOXP6pdgfue821E8jTb7icNpLTUnqc7e4cc4oYWmE6EGCaSlCZwOu
         1Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956938; x=1748561738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOzKNVIPtCb3bls2x+8GmpP1FGWXc09cxECCk2fUXy8=;
        b=cC03/4VRRnEEdKYETWVJpAQt/ihwTv4Dobjfn1zsZPrB3077MP/mbg0kqW2h2PB5B5
         ZmcwVbd8BBKIhYr4RSQ05zp+mRs/jVRj8ADkMPrI8dHgrOLJthg/ws1/ZDtttgO1NcTM
         RLHI/CMD6uVi/cMTLdnH4hyLwtWr6QbyCRTJDvnh74FS5htj9fXl/5Y/vplZw2GHqeU5
         UI7qHk7N2LoWtnA2HH/C8q/tamRPsJHQStOV8C5DKHnUpCUquHY7g1C97hCgMvXBWo9z
         EYuxi4CfxaKbIkRPrpD8pJbcZyQadboNq7bK27KUrvB7VqoakEJeYKhvV7gNeFU9riHc
         NcOg==
X-Forwarded-Encrypted: i=1; AJvYcCW1uN56u1Is4YbQ0m7N3lA7WQ/kNIk/+/zmzHTkXrwo5zDW/ArJ/Ld+r33zSstbhz2/MWB2O9X2@vger.kernel.org, AJvYcCXzRmMc08LlZ/YSQtbRfrxrORLlNF+T8msQEEfLLSAayNNEiliVlvKuxc7Dn2OPdA9HDhpOe/KLthXKYTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXl7f5zeMIXzx/xkO1+MgOXq8LtNGMKUr0uTgNklA8eTGSAFSE
	t0VLaM0EC1sDGzJ59KLL0au7M49OcewiWtKz+p6fprqKKm49HLeeCBKK
X-Gm-Gg: ASbGncvYgHvcds/XlXOg1lz3eZxIPCdukTQ8AOvM5gPQiR5G6arvGcZyCMtHV4FdANT
	6jWHrlN5hqWKGOCgGsWu1Ef7jWgX7miBWEEPGDKKZXXx0JOSPezMdwg5fdLW1/nZ3dla5Jc4Prj
	ww51JuQCjTekzsnLNqLwez2JmqqVvWYfVC/o+JAa9QtygAjTAn7P3cp5x3FoRy8m/Fj4VKQYPEA
	n6HX9NEvZ7ZSbHpzSF/Ynq4f4JlkR8oXH6/lgjJt3cbCAUpxPZEEf4+FjO+TtBVP/4VLDkGpDQE
	lexUQGT373fjtTke3SYGRbtxe85NfwyLrY5GW5AK6ZR4HuHkHgCe
X-Google-Smtp-Source: AGHT+IGGCm275dqXU+tczGZTKOc0m27ciGhUxWu1jZ+0SBX0keCxM1iMff320GrUlWTtZOoG4gPIKg==
X-Received: by 2002:a05:6a00:3d4d:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-742a97c3f4dmr34919826b3a.10.1747956938106;
        Thu, 22 May 2025 16:35:38 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8e114sm11873416a12.44.2025.05.22.16.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:35:37 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dlink: enable RMON MMIO access on supported devices
Date: Fri, 23 May 2025 08:34:32 +0900
Message-ID: <20250522233432.3546-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable memory-mapped I/O access to RMON statistics registers for devices
known to work correctly. Currently, only the D-Link DGE-550T (`0x4000`)
with PCI revision A3 (`0x0c`) is allowed.

To support this selectively, a runtime check was added, and the
`MEM_MAPPING` macro was removed in favor of runtime detection.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250519214046.47856-2-yyyynoom@gmail.com/
v2:
- Remove Kconfig option and do runtime check.
---
 drivers/net/ethernet/dlink/dl2k.c | 57 ++++++++++++++++---------------
 drivers/net/ethernet/dlink/dl2k.h |  2 ++
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 232e839a9d07..4e8da21042d5 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -99,6 +99,13 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_tx_timeout		= rio_tx_timeout,
 };
 
+static bool is_support_rmon_mmio(struct pci_dev *pdev)
+{
+	return pdev->vendor == PCI_VENDOR_ID_DLINK &&
+	       pdev->device == 0x4000 &&
+	       pdev->revision == 0x0c;
+}
+
 static int
 rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -131,18 +138,22 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	np = netdev_priv(dev);
 
+	if (is_support_rmon_mmio(pdev))
+		np->rmon_enable = true;
+
 	/* IO registers range. */
 	ioaddr = pci_iomap(pdev, 0, 0);
 	if (!ioaddr)
 		goto err_out_dev;
 	np->eeprom_addr = ioaddr;
 
-#ifdef MEM_MAPPING
-	/* MM registers range. */
-	ioaddr = pci_iomap(pdev, 1, 0);
-	if (!ioaddr)
-		goto err_out_iounmap;
-#endif
+	if (np->rmon_enable) {
+		/* MM registers range. */
+		ioaddr = pci_iomap(pdev, 1, 0);
+		if (!ioaddr)
+			goto err_out_iounmap;
+	}
+
 	np->ioaddr = ioaddr;
 	np->chip_id = chip_idx;
 	np->pdev = pdev;
@@ -287,9 +298,8 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 	dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 			  np->tx_ring_dma);
 err_out_iounmap:
-#ifdef MEM_MAPPING
-	pci_iounmap(pdev, np->ioaddr);
-#endif
+	if (np->rmon_enable)
+		pci_iounmap(pdev, np->ioaddr);
 	pci_iounmap(pdev, np->eeprom_addr);
 err_out_dev:
 	free_netdev (dev);
@@ -576,7 +586,8 @@ static void rio_hw_init(struct net_device *dev)
 	dw8(TxDMAPollPeriod, 0xff);
 	dw8(RxDMABurstThresh, 0x30);
 	dw8(RxDMAUrgentThresh, 0x30);
-	dw32(RmonStatMask, 0x0007ffff);
+	if (!np->rmon_enable)
+		dw32(RmonStatMask, 0x0007ffff);
 	/* clear statistics */
 	clear_stats (dev);
 
@@ -1069,9 +1080,6 @@ get_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
-#endif
 	unsigned int stat_reg;
 
 	/* All statistics registers need to be acknowledged,
@@ -1114,10 +1122,10 @@ get_stats (struct net_device *dev)
 	dr16(MacControlFramesXmtd);
 	dr16(FramesWEXDeferal);
 
-#ifdef MEM_MAPPING
-	for (i = 0x100; i <= 0x150; i += 4)
-		dr32(i);
-#endif
+	if (np->rmon_enable)
+		for (int i = 0x100; i <= 0x150; i += 4)
+			dr32(i);
+
 	dr16(TxJumboFrames);
 	dr16(RxJumboFrames);
 	dr16(TCPCheckSumErrors);
@@ -1131,9 +1139,6 @@ clear_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
-#endif
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
@@ -1169,10 +1174,9 @@ clear_stats (struct net_device *dev)
 	dr16(BcstFramesXmtdOk);
 	dr16(MacControlFramesXmtd);
 	dr16(FramesWEXDeferal);
-#ifdef MEM_MAPPING
-	for (i = 0x100; i <= 0x150; i += 4)
-		dr32(i);
-#endif
+	if (np->rmon_enable)
+		for (int i = 0x100; i <= 0x150; i += 4)
+			dr32(i);
 	dr16(TxJumboFrames);
 	dr16(RxJumboFrames);
 	dr16(TCPCheckSumErrors);
@@ -1798,9 +1802,8 @@ rio_remove1 (struct pci_dev *pdev)
 				  np->rx_ring_dma);
 		dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 				  np->tx_ring_dma);
-#ifdef MEM_MAPPING
-		pci_iounmap(pdev, np->ioaddr);
-#endif
+		if (np->rmon_enable)
+			pci_iounmap(pdev, np->ioaddr);
 		pci_iounmap(pdev, np->eeprom_addr);
 		free_netdev (dev);
 		pci_release_regions (pdev);
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 0e33e2eaae96..93f2978e8014 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -401,6 +401,8 @@ struct netdev_private {
 	u16 negotiate;		/* Negotiated media */
 	int phy_addr;		/* PHY addresses. */
 	u16 led_mode;		/* LED mode read from EEPROM (IP1000A only) */
+
+	bool rmon_enable;
 };
 
 /* The station address location in the EEPROM. */
-- 
2.49.0


