Return-Path: <netdev+bounces-255291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGnZDSZZfWlDRgIAu9opvQ
	(envelope-from <netdev+bounces-255291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:21:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD90BFF44
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D12EA3001A5D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0323EAA1;
	Sat, 31 Jan 2026 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUFaZuDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9662DC322
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822496; cv=none; b=g19l088OLbzx/VlCSieZUkUetUlfzn6oW88EelTK4E/p7UCz5+GFOIJ1LsOvFdFxYrqQiC/WzRTGHK28oTAxd9+EMhi7NPfWtG+9xBEb09QF4JS45dmgGRhRRusoMe1CZWM/CZ30CFcHEoFMb8M0s9CBJgnfVLKjRqPkm7LgysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822496; c=relaxed/simple;
	bh=vzgrp/EgXt77EU1TGGhNpGE6Edjx4P/l1JswIpLUHx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+pYnZmcEgqL5BgK1QU4JlGu3n0berGk/BmQWJgueXocXJkmtdECZRcafFND6PICjrYHbNmlahMihNM8RQnSd5WGAo0qNn5k8c/Xo8KB3b0L0w2ZzZ0KLINyshpfRP7xkGnZB8IABioYTsLEInlQ0MTTTNW4CTWF1nMpZD67R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUFaZuDZ; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b7c5db431cso2408891eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769822494; x=1770427294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMPYU/0eKhS5d1rKGgHjuCyCSgdwaEDfc/DjMUwqSQ4=;
        b=AUFaZuDZEunpvD8RFqBYnZ9BjsbzFZzA+WlA9dKx9skdkrbkj5eRCTHKoMTVrMSE3k
         QjXaDN0QQmP6QTelwHo61W23lRyUSoW1FTB2qKpfiuWUDi5FxbvWCuQfVSbNXt+2pqsy
         WHgbdVC6O+I1zwxnDN7qIqWZPxKOyxLT2rjOBXxIL4VPWnQRQ547c8EIF124DH1kKy4n
         3kuF4yZe500c+WI+thPQYtv15gMkWVJLxx+SWpgWU/W3k8/JVH5R/07pU9suRq+O1LE0
         qfeZ6ZRKvcy0pMhs2Hz9hTC3how88+YUZgUWwRgOQVrmHaF9AhuF363dwaGLUG/Xyzpz
         aRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822494; x=1770427294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMPYU/0eKhS5d1rKGgHjuCyCSgdwaEDfc/DjMUwqSQ4=;
        b=hXUXv9UIlvlWN+MwGsoaI7yTZz9MnpuGj1Ssaruqntb/FYVBex3Jh0lk4h5KHdZmR+
         p5MnCKoAAH+FWVzWKurJo4l+S0j492cVLdXHJLYT+S3+qBeNytuPByN8dZJhBnXC1VSb
         erpUL+hduzbDTA6A2WOTKI6tO4b3tKVuJHzMKH838N5ZyE1gogH5GCpLoGMhENdXuxJc
         oTCTTKL1NtM172zbDpE1EmZe+TOj7XHloQtGlofmnGJEarbyvno/rg7twnUOiwHLfx13
         NKUnGdOampZYeioH/C9ysXFXPxFvxhDgyTrL8UZMkJl5bm8vo48VZM7TV7rYsxFQxQT7
         g63A==
X-Gm-Message-State: AOJu0YyIfFlr+TyyZ7fLwRpwp8YONMYTxlHPYfBLYPYSmpTjvdX8Vo78
	GcW/ZXM7kzThRsmqZfFh/6zLHDzijuGQROcT+uQnPrL4p66Cz7hoPsbi21IhTw3d
X-Gm-Gg: AZuq6aJE0dF9ahbOn/arggC7FoPU0hT/BVx5BtlmReh6b19IvBXcP8AX8wWJsn70zvN
	qGiLA39KL7xZr0KjvHW29cuNDjBi4pQ+TAIjzcAaPmcjpvOcxeHBw/YyQYH4z0tbCKQjE6U1VTJ
	ekcWqjMigi7JryiusaXB/Qx+rDMH1Bl2Llp8Ax1moZIBk6UncHazyVp3+ngEjrFOS09tawFbs/a
	S37I8HvTX5xr7Vlu2GH5tFsUzpDTzv5A+iXCXTqRg1uzCPRHwp6GIP6NXPwwJCsge2tFp1rDJOu
	y/oKKb347tAYqU5NsCqLFLqEge65BQ9kZQwY3vC8ylitDzOH6LNG90lGANEmRD2bYdUZo2Tzn3d
	svaVSSYJ3XA8RWnHYNtHuJCshGlPaCm3KPiXru2ChTWoNcIloheOMUTYw2hfp2XTX3Y/zGrGeCZ
	GXJ6eLDkGcwaV729Abs0LsD9kDnTH3QWSzwGZzs2BmhtV1lnfA22TWxOIQvo903OGM+MXI4DVrn
	TMDgO9fazMvqijs1xkhth7hdC3pn4g2Fc0Umn6wYy+A0N0SkbbY639FUXt2YuUX6qoVMvfeiDPE
	5kJoLEggEBIACnE=
X-Received: by 2002:a05:7301:128a:b0:2b7:17c4:be27 with SMTP id 5a478bee46e88-2b7c895b43amr2285546eec.42.1769822494104;
        Fri, 30 Jan 2026 17:21:34 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8f2sm14815377eec.7.2026.01.30.17.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 17:21:33 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Don Fry <pcnet32@frontier.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
Date: Fri, 30 Jan 2026 17:21:19 -0800
Message-ID: <20260131012119.25863-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,frontier.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255291-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FD90BFF44
X-Rspamd-Action: no action

The VLB bus is very obsolete and last appeared on P5 Pentium-era
hardware. Support for it has been removed from other drivers, and it is
highly unlikely anyone is using it with modern Linux kernels. The VLB
auto-probing code also has the potential to affect other devices that
use the same I/O ports in unexpected ways. Remove support for VLB cards
from the driver. This allows the code managing device instances to be
simplified significantly.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes in v2:
Rebase on latest net-next tree
Improve commit message
CC maintainers

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


