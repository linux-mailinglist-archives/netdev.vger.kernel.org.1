Return-Path: <netdev+bounces-195910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B633AAD2AC6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890873B119D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FAF4C96;
	Tue, 10 Jun 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU9i0EDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BC380;
	Tue, 10 Jun 2025 00:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513752; cv=none; b=PQl1gGus/odvtzQSygbEtrp2BDi6uxXLuYPNZuJXs7A2mB8a8mYczsjWS0uqHy8cOn92SdauMCGdSQVJ9zTYYwK8x1NOBipElz8E7UP8G3LYJCu0wkt8cpCrNXe8b6uZ/fgIIcPyaSZrI8NNTKV/vPupr++06RYd5BET69UZ4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513752; c=relaxed/simple;
	bh=py/EjQu3M9K/YOC8ikZvMaNTL30qCC681Umo91n1AHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u76JcDkeXkH3anKLINznQiGi6dIo5gLPk3SAh1t0Eb36LwI+hit5XDLyZM4ptM+1AJwKQvUQvWeiijVfezKhSVvUlV+TnG+t22D8d358pgPJ41rzKCVoIy5T3I46feVKu8ppevA8uX98glaalW8faEtaK/j8iQjz42gRn3kOUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU9i0EDc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d366e5f2so55065355ad.1;
        Mon, 09 Jun 2025 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749513751; x=1750118551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N09NtSHTa9JSyy4TL+QaIRBJm/FLbtqZCS7uK+1OoDo=;
        b=HU9i0EDcBzTMz1wFes0Fqh7pRzM671xpRrG52qZzaNlcTdxvUi5/OlFnPmcLCNoO8o
         zQeZ2ge/iWhiww+9a87b2VWMtNKywfs0uGLJln9U3nUZ7tWIk4o8LA/563urEUke8g8V
         p76SU2DDWhw8TAuWmvgF+9rwuDL59tZ20thYBbR/Y1zXlhSWOQe2q3TrcUmUszGe6/53
         OM7atvpJ3BnJKIYYulibStjQnAXxziHBAnvrxTyU9oI47jKPyCnXB1sybakP+vRqJlT+
         4i2RBjUG8f5v6lQ4F9SxeFrqd0uxFKrAXp1lzasLwFk1L8tboJcrquNQTtyOI1i0FUUm
         sj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749513751; x=1750118551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N09NtSHTa9JSyy4TL+QaIRBJm/FLbtqZCS7uK+1OoDo=;
        b=L5l8duDe5uZy2/ZRuBYROXZEun4duym3sTOcfNVttGm7ssjRRmSHqHFbMLf9Bt7B+c
         BwVRfDI8zO+lPm2jtyxOwTMzcG/As4t4fjzab06zon7rzp0uwgWh87liWxgpCVi90xAX
         bVOdNA2wfXD6JnfyCT79L0fXplV6ta6T+TsSZ2CQYeWRUF7d4uor7nO3wU58QC3kD9yj
         pBgemW45vtTkweAHbZP1EfiOUpAkeMy+vUIE3x2v5XEKLkMy3qL5UpjEO4U5JppH93Lg
         KRZqSMe2H88S49+F0ezlj0Oydiy83943sGD49nPXKXfNPzmdsOr1+sDOEGCGCY+xdxtt
         kBCA==
X-Forwarded-Encrypted: i=1; AJvYcCVTTp9rwDrZ02OhUEhpF5wG1MuzMncNTDKhw36CCYDsdR9HHO+xfIFMSt0MwEDIYaMSpG1x2MmSP/nlBcQ=@vger.kernel.org, AJvYcCWOKYcpjyJMtn2pU9O2IGk2TJKD6FVl3osoU6bNzIKJO7VsPgD4/mezSW6dMQREFjkANOIww90+@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMhx2ZbI4v8hVKJifUtxVtRMizcpaWYr4rgB21EO3aSE7J65T
	MAho751yAdlZ6Ew4V3PpKkq5gZ8IjQ4fL2RVgzI+YPDSzlifzPbb/d2J
X-Gm-Gg: ASbGnctr2MTuYoPULcrMg8RM+esaIuCZsqbbl9en4lOfVo9DDXFLsmrDT0GsTxTrZLP
	JYF1raBGOEnJttnrBjnA6hOQzaoRLZVqz3vE0pW8ZnVXieZQbgdsTSUF8LCSdUkARpARXeAFwLq
	Xx2Qf3T/4QsFFFMY6x6K6SjW2+65cFn5HfS8iv7YhQHXczEKR+JuTGVkeOtslBG/YaaYsx/Z/4n
	nYdkilu2C1b1bhqyHYFQfpNHlVmviOGqfJ+ZSuR5zocj6sg64kRnvY4RBw46x4SynfeDKnGSl5J
	/l/TBYheKbRFRZIy3oAJgUfaTRPfwupO6LaPy2i5aCL2UDytzqWhOsolSTlpM7qMM18lz5rqOgU
	=
X-Google-Smtp-Source: AGHT+IEiDkctUZYg6n+ZqGucCFCYFbAaZBbkZNUODVWsFqFPexY7EpyI9wdC/NN8bTVAW9DCj1V2cw==
X-Received: by 2002:a17:903:22c6:b0:234:bca7:2921 with SMTP id d9443c01a7336-23601dc09cemr217526495ad.33.1749513750503;
        Mon, 09 Jun 2025 17:02:30 -0700 (PDT)
Received: from mythos-cloud.. ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603513d02sm60190345ad.244.2025.06.09.17.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 17:02:30 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: dlink: enable RMON MMIO access on supported devices
Date: Tue, 10 Jun 2025 09:01:30 +0900
Message-ID: <20250610000130.49065-2-yyyynoom@gmail.com>
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

To avoid issues on other hardware, a runtime check was added to restrict
MMIO usage. The `MEM_MAPPING` macro was removed in favor of runtime
detection.

To access RMON registers, the code `dw32(RmonStatMask, 0x0007ffff);`
must also be skipped, so this patch conditionally disables it as well.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250519214046.47856-2-yyyynoom@gmail.com/
v2: https://lore.kernel.org/netdev/20250522233432.3546-2-yyyynoom@gmail.com/
- Remove Kconfig option and do runtime check.
v3:
- Rebased onto the latest net-next.
---
 drivers/net/ethernet/dlink/dl2k.c | 57 ++++++++++++++++---------------
 drivers/net/ethernet/dlink/dl2k.h |  2 ++
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 038a0400c1f9..ea8361ba6cad 100644
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
@@ -289,9 +300,8 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -578,7 +588,8 @@ static void rio_hw_init(struct net_device *dev)
 	dw8(TxDMAPollPeriod, 0xff);
 	dw8(RxDMABurstThresh, 0x30);
 	dw8(RxDMAUrgentThresh, 0x30);
-	dw32(RmonStatMask, 0x0007ffff);
+	if (!np->rmon_enable)
+		dw32(RmonStatMask, 0x0007ffff);
 	/* clear statistics */
 	clear_stats (dev);
 
@@ -1076,9 +1087,6 @@ get_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
-#endif
 	unsigned int stat_reg;
 	unsigned long flags;
 
@@ -1123,10 +1131,10 @@ get_stats (struct net_device *dev)
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
@@ -1143,9 +1151,6 @@ clear_stats (struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
 	void __iomem *ioaddr = np->ioaddr;
-#ifdef MEM_MAPPING
-	int i;
-#endif
 
 	/* All statistics registers need to be acknowledged,
 	   else statistic overflow could cause problems */
@@ -1181,10 +1186,9 @@ clear_stats (struct net_device *dev)
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
@@ -1810,9 +1814,8 @@ rio_remove1 (struct pci_dev *pdev)
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
index ba679025e866..4788cc94639d 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -403,6 +403,8 @@ struct netdev_private {
 	u16 negotiate;		/* Negotiated media */
 	int phy_addr;		/* PHY addresses. */
 	u16 led_mode;		/* LED mode read from EEPROM (IP1000A only) */
+
+	bool rmon_enable;
 };
 
 /* The station address location in the EEPROM. */
-- 
2.49.0


