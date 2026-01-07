Return-Path: <netdev+bounces-247614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14914CFC4D1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D809C3012751
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDD1FBEA8;
	Wed,  7 Jan 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKrBQXeV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AA7DA66
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770357; cv=none; b=kgbfzSIdJxOYQ46NXiL+rJf9kqWnpH5hIz8El3ERAsks///kAwdZqHp3g/RpdEj5OjjHX7hSxaX6ZhDbpjgFe1y02By26nZc+bsvWJ1WPxJt2ea3eDgLAEjf6qA9Wa9B6wX8zrE7YKYBSXTzR0XJG0xYO8YXtu/ChEvuwS4PsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770357; c=relaxed/simple;
	bh=qODfchQt2Ax4LN1GlAt6JHGtFYLrEQDmIa9eWQEJ3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AD+6NuXksEZg7YhNxzzszPt5siprOlbbRWLjbYU9OhWZFK6HzaVyf3p50IqJnkeGI9FePLJYrMIyKi8OVzR88Ardvr7vUWoXgbgmu0thc4t8mnRdNTEyQ8IDSv60hr0B4XDSXzRkGYwi2Zpnwx1BfWk2/xRR+EdMdvNEXRP5IzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKrBQXeV; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso1926643eec.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767770355; x=1768375155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4CflCTYa9b6bwo3NxQIh+T3QRujVuSG4vE5IJ1V1UQ=;
        b=hKrBQXeV1fQdwmEG1tFm5M3z/bOfB31kkSrhIo4niIyoacJU6fdJr8P5XCy+G3oyLd
         9Jkzyoultle1IKVle5Tg8uaMVNU7LpPlJYlWezmxGPRRbQ8/CtJVskXRsDM4qiBkj+BE
         030ePciPkn5P8xERYEG+tBg9tbqElBahBdQYY4Nsa1t59gfLgrCam4SMqZxkQ8KKA3dD
         2V04ufNRe3H9A4+Mg5m2rynFn2sppItn5YDf5+MsUxq8iHBDUUzGmET38OIiyrms5fZV
         nDWA8zIPIaID7ErbH1dOAAWqwL8uqp56rtiV7Nhu+0hDWcyXNEPfmKXh7ty7dJ+ptVuB
         Lt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770355; x=1768375155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4CflCTYa9b6bwo3NxQIh+T3QRujVuSG4vE5IJ1V1UQ=;
        b=Y0rJpYCqgXrZQ1tbGASLs8m/qPet4hyK5jHlLeAHin/yAeQYVF3az5J9P+fG67mz5d
         qsHlMtb+6nR0PM60Z7QO3d18SADUqKfPv3X+Cb3btWYfJE7WqJPeLnGL5m2WXa3IRk9y
         FabxKFas+25KD3F9WfuDHBozRTt4JNdSOGRWe/rYo+i0mkNjjkcPdWaocAftPq9qUCd9
         BbTewxN3QoBa9MIRW6CKVFXUtw4eyIX6QyxM3+IRXrRUEIFvfLUZQlngNg0dx3A9Cxb3
         7cKY60T6hu21E5z/DQ1ZehB7SfpLPXEIPUU8WHoFhsqCFai4xhiJ6dAe58A76VbT/XlG
         GyVg==
X-Gm-Message-State: AOJu0YzdGLAhgH2v0oS65eAbCwE4TpD3GbWxNup1YYlAD8aJ5FbKOc1h
	tgPA+IxW2g4Q1NDxKhGCnEzcmcX4wGPP8qJ/rBbbb5EWFmMvD3bF/x18pmE3T8ir
X-Gm-Gg: AY/fxX5WOmCYDO4t1x15ni8f1rjGPDeOuZx+EJUcnR1i7PSdLvMNoz7vIEcPkg61Bnp
	jKW4T7OhqzlDt/0hBH2l/gZLNk2OJdKSh1bqCAuypvjwMeSfMT3FxBM8XBGBXEYqRIi7MeccLES
	mZDSWrtt1PEmNWvyc1+IXE15Fg/S4J8r3eE0dT69gY7K+YOMkrdlK9tXBKk2V2mvsVrOiT4/1bR
	Y9OEWm3ZdXWgmIkMjPV6mV+AJvc5kB++RiyWSKjc/ow1PRo0ob/r3Sx0MjLrNEisrxLdUX37MwG
	XHKjNJCFaPj2HrF95rYeq5f1jKMQUT1WUGnzYWEZlKXn5wXZzP+hq7GKP/6MAx+eafGevoz1QhD
	MZw/gixyimokRAaadK4UPnpFO1iLNrQcelyEy6UBQWb5x9/72AGV8fcPWOu/hXqZPEdPA1IXGqk
	Ats3Q6sSx8WkVvC7YN8Qu2Byk45fKFEKlKbJGOfC7m0tW9DYZNth2JYAqvS6jGSojBv5XytcNCF
	QjZudlyQPhUpcZCfW1ua1GZBqUIXOA+KRGAbfkANNpZS/zcj/mhO7Px0/0REiCg0E0/DCl0X7+7
	pZNB
X-Google-Smtp-Source: AGHT+IF99bd2OqpEi5lpjV4DoG84mdbYHhxzaWY2/G27fliRjdiqWHYPxta0mr6ynJnV6I7fneodWA==
X-Received: by 2002:a05:7300:6ca7:b0:2ae:5d27:ff49 with SMTP id 5a478bee46e88-2b17d1e4b87mr1416688eec.7.1767770354487;
        Tue, 06 Jan 2026 23:19:14 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a5d3dsm5739393eec.13.2026.01.06.23.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:19:14 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] pcnet32: remove VLB support
Date: Tue,  6 Jan 2026 23:18:31 -0800
Message-ID: <20260107071831.32895-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the code managing device instances to be simplified
significantly. The VLB bus is very obsolete and last appeared on
P5 Pentium-era hardware. Support for it has been removed from
other drivers, and it is highly unlikely anyone is using it with
modern Linux kernels.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/amd/pcnet32.c | 144 ++++-------------------------
 1 file changed, 20 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 9eaefa0f5e80..7a63426af641 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -75,17 +75,8 @@ MODULE_DEVICE_TABLE(pci, pcnet32_pci_tbl);
 
 static int cards_found;
 
-/*
- * VLB I/O addresses
- */
-static unsigned int pcnet32_portlist[] =
-    { 0x300, 0x320, 0x340, 0x360, 0 };
-
 static int pcnet32_debug;
 static int tx_start = 1;	/* Mapping -- 0:20, 1:64, 2:128, 3:~220 (depends on chip vers) */
-static int pcnet32vlb;		/* check for VLB cards ? */
-
-static struct net_device *pcnet32_dev;
 
 static int max_interrupt_work = 2;
 static int rx_copybreak = 200;
@@ -285,13 +276,11 @@ struct pcnet32_private {
 	char			tx_full;
 	char			phycount;	/* number of phys found */
 	int			options;
-	unsigned int		shared_irq:1,	/* shared irq possible */
-				dxsuflo:1,   /* disable transmit stop on uflo */
+	unsigned int		dxsuflo:1,   /* disable transmit stop on uflo */
 				mii:1,		/* mii port available */
 				autoneg:1,	/* autoneg enabled */
 				port_tp:1,	/* port set to TP */
 				fdx:1;		/* full duplex enabled */
-	struct net_device	*next;
 	struct mii_if_info	mii_if;
 	struct timer_list	watchdog_timer;
 	u32			msg_enable;	/* debug message level */
@@ -305,7 +294,7 @@ struct pcnet32_private {
 };
 
 static int pcnet32_probe_pci(struct pci_dev *, const struct pci_device_id *);
-static int pcnet32_probe1(unsigned long, int, struct pci_dev *);
+static int pcnet32_probe1(unsigned long, struct pci_dev *);
 static int pcnet32_open(struct net_device *);
 static int pcnet32_init_ring(struct net_device *);
 static netdev_tx_t pcnet32_start_xmit(struct sk_buff *,
@@ -798,12 +787,8 @@ static void pcnet32_get_drvinfo(struct net_device *dev,
 	struct pcnet32_private *lp = netdev_priv(dev);
 
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
-	if (lp->pci_dev)
-		strscpy(info->bus_info, pci_name(lp->pci_dev),
-			sizeof(info->bus_info));
-	else
-		snprintf(info->bus_info, sizeof(info->bus_info),
-			"VLB 0x%lx", dev->base_addr);
+	strscpy(info->bus_info, pci_name(lp->pci_dev),
+		sizeof(info->bus_info));
 }
 
 static u32 pcnet32_get_link(struct net_device *dev)
@@ -1506,28 +1491,6 @@ static const struct ethtool_ops pcnet32_ethtool_ops = {
 	.set_link_ksettings	= pcnet32_set_link_ksettings,
 };
 
-/* only probes for non-PCI devices, the rest are handled by
- * pci_register_driver via pcnet32_probe_pci */
-
-static void pcnet32_probe_vlbus(unsigned int *pcnet32_portlist)
-{
-	unsigned int *port, ioaddr;
-
-	/* search for PCnet32 VLB cards at known addresses */
-	for (port = pcnet32_portlist; (ioaddr = *port); port++) {
-		if (request_region
-		    (ioaddr, PCNET32_TOTAL_SIZE, "pcnet32_probe_vlbus")) {
-			/* check if there is really a pcnet chip on that ioaddr */
-			if ((inb(ioaddr + 14) == 0x57) &&
-			    (inb(ioaddr + 15) == 0x57)) {
-				pcnet32_probe1(ioaddr, 0, NULL);
-			} else {
-				release_region(ioaddr, PCNET32_TOTAL_SIZE);
-			}
-		}
-	}
-}
-
 static int
 pcnet32_probe_pci(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -1564,7 +1527,7 @@ pcnet32_probe_pci(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_disable_dev;
 	}
 
-	err = pcnet32_probe1(ioaddr, 1, pdev);
+	err = pcnet32_probe1(ioaddr, pdev);
 
 err_disable_dev:
 	if (err < 0)
@@ -1588,12 +1551,9 @@ static const struct net_device_ops pcnet32_netdev_ops = {
 #endif
 };
 
-/* pcnet32_probe1
- *  Called from both pcnet32_probe_vlbus and pcnet_probe_pci.
- *  pdev will be NULL when called from pcnet32_probe_vlbus.
- */
+/* Called from pcnet_probe_pci. */
 static int
-pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
+pcnet32_probe1(unsigned long ioaddr, struct pci_dev *pdev)
 {
 	struct pcnet32_private *lp;
 	int i, media;
@@ -1640,13 +1600,8 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 
 	switch (chip_version) {
 	case 0x2420:
-		chipname = "PCnet/PCI 79C970";	/* PCI */
-		break;
-	case 0x2430:
-		if (shared)
-			chipname = "PCnet/PCI 79C970";	/* 970 gives the wrong chip id back */
-		else
-			chipname = "PCnet/32 79C965";	/* 486/VL bus */
+	case 0x2430: /* Some give the wrong chip id back */
+		chipname = "PCnet/PCI 79C970";
 		break;
 	case 0x2621:
 		chipname = "PCnet/PCI II 79C970A";	/* PCI */
@@ -1752,8 +1707,7 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 		goto err_release_region;
 	}
 
-	if (pdev)
-		SET_NETDEV_DEV(dev, &pdev->dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	if (pcnet32_debug & NETIF_MSG_PROBE)
 		pr_info("%s at %#3lx,", chipname, ioaddr);
@@ -1856,7 +1810,6 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 	spin_lock_init(&lp->lock);
 
 	lp->name = chipname;
-	lp->shared_irq = shared;
 	lp->tx_ring_size = TX_RING_SIZE;	/* default tx ring size */
 	lp->rx_ring_size = RX_RING_SIZE;	/* default rx ring size */
 	lp->tx_mod_mask = lp->tx_ring_size - 1;
@@ -1920,32 +1873,10 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 	a->write_csr(ioaddr, 1, (lp->init_dma_addr & 0xffff));
 	a->write_csr(ioaddr, 2, (lp->init_dma_addr >> 16));
 
-	if (pdev) {		/* use the IRQ provided by PCI */
-		dev->irq = pdev->irq;
-		if (pcnet32_debug & NETIF_MSG_PROBE)
-			pr_cont(" assigned IRQ %d\n", dev->irq);
-	} else {
-		unsigned long irq_mask = probe_irq_on();
-
-		/*
-		 * To auto-IRQ we enable the initialization-done and DMA error
-		 * interrupts. For ISA boards we get a DMA error, but VLB and PCI
-		 * boards will work.
-		 */
-		/* Trigger an initialization just for the interrupt. */
-		a->write_csr(ioaddr, CSR0, CSR0_INTEN | CSR0_INIT);
-		mdelay(1);
-
-		dev->irq = probe_irq_off(irq_mask);
-		if (!dev->irq) {
-			if (pcnet32_debug & NETIF_MSG_PROBE)
-				pr_cont(", failed to detect IRQ line\n");
-			ret = -ENODEV;
-			goto err_free_ring;
-		}
-		if (pcnet32_debug & NETIF_MSG_PROBE)
-			pr_cont(", probed IRQ %d\n", dev->irq);
-	}
+	/* use the IRQ provided by PCI */
+	dev->irq = pdev->irq;
+	if (pcnet32_debug & NETIF_MSG_PROBE)
+		pr_cont(" assigned IRQ %d\n", dev->irq);
 
 	/* Set the mii phy_id so that we can query the link state */
 	if (lp->mii) {
@@ -1987,12 +1918,7 @@ pcnet32_probe1(unsigned long ioaddr, int shared, struct pci_dev *pdev)
 	if (register_netdev(dev))
 		goto err_free_ring;
 
-	if (pdev) {
-		pci_set_drvdata(pdev, dev);
-	} else {
-		lp->next = pcnet32_dev;
-		pcnet32_dev = dev;
-	}
+	pci_set_drvdata(pdev, dev);
 
 	if (pcnet32_debug & NETIF_MSG_PROBE)
 		pr_info("%s: registered as %s\n", dev->name, lp->name);
@@ -2100,8 +2026,7 @@ static int pcnet32_open(struct net_device *dev)
 	unsigned long flags;
 
 	if (request_irq(dev->irq, pcnet32_interrupt,
-			lp->shared_irq ? IRQF_SHARED : 0, dev->name,
-			(void *)dev)) {
+			IRQF_SHARED, dev->name, (void *)dev)) {
 		return -EAGAIN;
 	}
 
@@ -2157,7 +2082,7 @@ static int pcnet32_open(struct net_device *dev)
 	lp->a->write_csr(ioaddr, 124, val);
 
 	/* Allied Telesyn AT 2700/2701 FX are 100Mbit only and do not negotiate */
-	if (pdev && pdev->subsystem_vendor == PCI_VENDOR_ID_AT &&
+	if (pdev->subsystem_vendor == PCI_VENDOR_ID_AT &&
 	    (pdev->subsystem_device == PCI_SUBDEVICE_ID_AT_2700FX ||
 	     pdev->subsystem_device == PCI_SUBDEVICE_ID_AT_2701FX)) {
 		if (lp->options & PCNET32_PORT_ASEL) {
@@ -2970,10 +2895,9 @@ static struct pci_driver pcnet32_driver = {
 	},
 };
 
-/* An additional parameter that may be passed in... */
+/* Additional parameters that may be passed in... */
 static int debug = -1;
 static int tx_start_pt = -1;
-static int pcnet32_have_pci;
 
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, DRV_NAME " debug level");
@@ -2985,8 +2909,6 @@ MODULE_PARM_DESC(rx_copybreak,
 		 DRV_NAME " copy breakpoint for copy-only-tiny-frames");
 module_param(tx_start_pt, int, 0);
 MODULE_PARM_DESC(tx_start_pt, DRV_NAME " transmit start point (0-3)");
-module_param(pcnet32vlb, int, 0);
-MODULE_PARM_DESC(pcnet32vlb, DRV_NAME " Vesa local bus (VLB) support (0/1)");
 module_param_array(options, int, NULL, 0);
 MODULE_PARM_DESC(options, DRV_NAME " initial option setting(s) (0-15)");
 module_param_array(full_duplex, int, NULL, 0);
@@ -3010,38 +2932,12 @@ static int __init pcnet32_init_module(void)
 	if ((tx_start_pt >= 0) && (tx_start_pt <= 3))
 		tx_start = tx_start_pt;
 
-	/* find the PCI devices */
-	if (!pci_register_driver(&pcnet32_driver))
-		pcnet32_have_pci = 1;
-
-	/* should we find any remaining VLbus devices ? */
-	if (pcnet32vlb)
-		pcnet32_probe_vlbus(pcnet32_portlist);
-
-	if (cards_found && (pcnet32_debug & NETIF_MSG_PROBE))
-		pr_info("%d cards_found\n", cards_found);
-
-	return (pcnet32_have_pci + cards_found) ? 0 : -ENODEV;
+	return pci_register_driver(&pcnet32_driver);
 }
 
 static void __exit pcnet32_cleanup_module(void)
 {
-	struct net_device *next_dev;
-
-	while (pcnet32_dev) {
-		struct pcnet32_private *lp = netdev_priv(pcnet32_dev);
-		next_dev = lp->next;
-		unregister_netdev(pcnet32_dev);
-		pcnet32_free_ring(pcnet32_dev);
-		release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
-		dma_free_coherent(&lp->pci_dev->dev, sizeof(*lp->init_block),
-				  lp->init_block, lp->init_dma_addr);
-		free_netdev(pcnet32_dev);
-		pcnet32_dev = next_dev;
-	}
-
-	if (pcnet32_have_pci)
-		pci_unregister_driver(&pcnet32_driver);
+	pci_unregister_driver(&pcnet32_driver);
 }
 
 module_init(pcnet32_init_module);
-- 
2.43.0


