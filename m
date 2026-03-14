Return-Path: <netdev+bounces-267826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMBuMqCptWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:32:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53828E7B8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B37B430774EF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1F30C610;
	Sat, 14 Mar 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0/7fHcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15322B8B6
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512990; cv=none; b=Pv90CtzCuZK7PPolxZS5nA3nUKi0JDOcrEldcqpZ4Fj4404Gxyixg5coWrQ4PrBDpBbgFLap0tahnl/nsM04S1RGXGSz2ckusReyddRP9gsXjE84wrfED06rFOs5AmSrWUwRb9hVgz2eN2feIg9BRP0DZuiWduo4rBMGUfyX6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512990; c=relaxed/simple;
	bh=1tG9qcJg/ScoAbc2s3rBPup6tclQThm8ZNIWVQwHMpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXoMmr8Tj5HnXdsPS0c+GqlxRwmNQ16dkMZa7wPnlAls8vMmgcuZoLyMMORYPhDLK5BfAg28vorm9re0lf5j87BICLyqSrwCSlsIioxzxTR2IF6wsUTC9eb56NNtYi0w50AdrtCravVsLMovXZ9IbMYP6VMmL3DHEVfNKlYUqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0/7fHcx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4e538abdso36154135ad.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512988; x=1774117788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JSH/0/b9giaRQVQnVF9Hnbf5bM9rYVcnC9nwZ0R2/U=;
        b=b0/7fHcxe40SglyAJpzqO/8MW0rbtz36KdXFN9hn8IZMIH71iVumPVuhdmWBAr8r/R
         EYtlVNQwLsO6QePN8Wm82otF2dEHFj7S4LBHrIYCrnAjta3EfDniIs3+vWAIoCLIeZjk
         SB/lLcZC5NZx++H4HjSRkQSEzlbnzstxT3e1mGQ+AhAbcWBxtkKDSAEa7fdJG6N8zYkR
         oQvySAVyozI4jSDx0gVzxhnwpAhBjlm2CFH/71laegsy/SgK7Hvf+bkVECUPesXozosi
         gLaRvvngod35hpDBkkepVzzX45BZ6bme9ttA/0UHgLsVVTgDPokQ/L8JCshxEZAQaVv7
         hL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512988; x=1774117788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JSH/0/b9giaRQVQnVF9Hnbf5bM9rYVcnC9nwZ0R2/U=;
        b=hci/UaD9UXC2c9tzEDxrbsNz2b6MEVz074rwJaydmj7c58a0JiXiVB5ZbYvgVJUQEz
         WlNOhxt0nlQT7aEUMOfe0JaYXs+gQVNmTiq8bjPKJybpqQOw9ifgCIquMWfnY4A8bqmZ
         UOF3KbdVjtAqmnVK3AdJbwUiSefv518W0uSp71btaOsdNZEme6ySpmcFq6caL5XV1ym1
         4NaDD/bt+5q7RrGwc32EIRwNiNHmaTDcgEdTBA/3OOhnkpnunYWNgC4sQONg5LhcdXUA
         GPuzyJJlMwgWv/2O90zR1hlosGteaO8PNPGZ7g8/11451x/Ji8mzJS2hfpgfMypBFDYI
         i8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBm0CfKf50P2abdzNRu+5BNG26sZujNrXJqN3Yq+496TdZ4ndbW1xTythinQrw6n8gfs7j860=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFzbQRSVnAe6AsDdPrPk/XhoHWqhur2ULsIK6yhO6TBv1yOa3
	V9qQ3WeVvN5dKYnIdd/l8WLHBM44u2i+sc1eah3snvvUgvMUzA6BDscj
X-Gm-Gg: ATEYQzyHEOX+rxrZbqHb2sVfLmQ88mxzrrdlTTOChwCCJnAEH04EILVxg7cgIR51Sid
	6Re8du0k3XAtS3dd9S6p+V1HbKE/AJF30f8DAAnhu4iKFkSpc1+QiAI34wKUskbEmg4XYDipNr4
	XyWFWtjod/Eb5tRKrdc+0Z9Zl6WpA8jnWPfxSx906ZmjoSsgP25NP0XVLQmdy/OFe1ilePFuEw/
	RL7IZtAqOOkjEGg7nph/BDWM0fuRIAMoiba08sHa4YNX4/XL+6HQe1hyhk7q8dY1YnzbQ4iCpOP
	69f8wWMAGIixYJvdtE3rqtEF5e8FIwTAnOwbvDurNg4AWYLxgSH74rzNO+t60+Mdb6DW6YrDsd9
	XDhXq6F8oZAPy+EHuVTBi/2HThPrpKo2yKMjGAymv64m/8Ba3FLAbTSJ+Z/ioXJ/ZJ2qtpxD4gm
	dkS3t26s9waCq9hb/S4UTYFG+z1jN4iy/QeDJdwT9ds3eGBoeK54THoXhMtOL4dUx35Y9T8LPDY
	5/tPQ==
X-Received: by 2002:a17:903:90f:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2aeca999738mr72086855ad.19.1773512988217;
        Sat, 14 Mar 2026 11:29:48 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:47 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: stfomichev@gmail.com,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	mst@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v9 7/7] pcnet32: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:09 +0530
Message-ID: <20260314182809.362808-8-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viswanathiyyappan@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F53828E7B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_set_rx_mode_async callback and update
the driver to use the snapshot/commit model for RX mode update.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
There are no calls to netif_set_rx_mode in pcnet32
 
 drivers/net/ethernet/amd/pcnet32.c | 65 ++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 911808ab13a7..d5ad96985d68 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -314,8 +314,9 @@ static void pcnet32_tx_timeout(struct net_device *dev, unsigned int txqueue);
 static irqreturn_t pcnet32_interrupt(int, void *);
 static int pcnet32_close(struct net_device *);
 static struct net_device_stats *pcnet32_get_stats(struct net_device *);
-static void pcnet32_load_multicast(struct net_device *dev);
+static void pcnet32_load_multicast(struct net_device *dev, bool is_open);
 static void pcnet32_set_multicast_list(struct net_device *);
+static void pcnet32_set_multicast_list_async(struct net_device *);
 static int pcnet32_ioctl(struct net_device *, struct ifreq *, int);
 static void pcnet32_watchdog(struct timer_list *);
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num);
@@ -1580,6 +1581,7 @@ static const struct net_device_ops pcnet32_netdev_ops = {
 	.ndo_tx_timeout		= pcnet32_tx_timeout,
 	.ndo_get_stats		= pcnet32_get_stats,
 	.ndo_set_rx_mode	= pcnet32_set_multicast_list,
+	.ndo_set_rx_mode_async	= pcnet32_set_multicast_list_async,
 	.ndo_eth_ioctl		= pcnet32_ioctl,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -2260,7 +2262,7 @@ static int pcnet32_open(struct net_device *dev)
 
 	lp->init_block->mode =
 	    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
-	pcnet32_load_multicast(dev);
+	pcnet32_load_multicast(dev, true);
 
 	if (pcnet32_init_ring(dev)) {
 		rc = -ENOMEM;
@@ -2676,18 +2678,26 @@ static struct net_device_stats *pcnet32_get_stats(struct net_device *dev)
 }
 
 /* taken from the sunlance driver, which it took from the depca driver */
-static void pcnet32_load_multicast(struct net_device *dev)
+static void pcnet32_load_multicast(struct net_device *dev, bool is_open)
 {
 	struct pcnet32_private *lp = netdev_priv(dev);
 	volatile struct pcnet32_init_block *ib = lp->init_block;
 	volatile __le16 *mcast_table = (__le16 *)ib->filter;
 	struct netdev_hw_addr *ha;
+	char *ha_addr;
+	bool allmulti;
 	unsigned long ioaddr = dev->base_addr;
-	int i;
+	int i, ni;
 	u32 crc;
 
+	if (is_open)
+		allmulti = dev->flags & IFF_ALLMULTI;
+	else
+		allmulti = netif_get_rx_mode_cfg(dev,
+						 NETIF_RX_MODE_CFG_ALLMULTI);
+
 	/* set all multicast bits */
-	if (dev->flags & IFF_ALLMULTI) {
+	if (allmulti) {
 		ib->filter[0] = cpu_to_le32(~0U);
 		ib->filter[1] = cpu_to_le32(~0U);
 		lp->a->write_csr(ioaddr, PCNET32_MC_FILTER, 0xffff);
@@ -2701,20 +2711,41 @@ static void pcnet32_load_multicast(struct net_device *dev)
 	ib->filter[1] = 0;
 
 	/* Add addresses */
-	netdev_for_each_mc_addr(ha, dev) {
-		crc = ether_crc_le(6, ha->addr);
-		crc = crc >> 26;
-		mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+	if (is_open) {
+		netdev_for_each_mc_addr(ha, dev) {
+			crc = ether_crc_le(6, ha->addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
+	} else {
+		netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni) {
+			crc = ether_crc_le(6, ha_addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
 	}
+
 	for (i = 0; i < 4; i++)
 		lp->a->write_csr(ioaddr, PCNET32_MC_FILTER + i,
 				le16_to_cpu(mcast_table[i]));
 }
 
+static void pcnet32_set_multicast_list(struct net_device *dev)
+{
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
+
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+}
+
 /*
  * Set or clear the multicast filter for this adaptor.
  */
-static void pcnet32_set_multicast_list(struct net_device *dev)
+static void pcnet32_set_multicast_list_async(struct net_device *dev)
 {
 	unsigned long ioaddr = dev->base_addr, flags;
 	struct pcnet32_private *lp = netdev_priv(dev);
@@ -2723,7 +2754,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 	spin_lock_irqsave(&lp->lock, flags);
 	suspended = pcnet32_suspend(dev, &flags, 0);
 	csr15 = lp->a->read_csr(ioaddr, CSR15);
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_get_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Log any net taps. */
 		netif_info(lp, hw, dev, "Promiscuous mode enabled\n");
 		lp->init_block->mode =
@@ -2734,7 +2765,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 		lp->init_block->mode =
 		    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
 		lp->a->write_csr(ioaddr, CSR15, csr15 & 0x7fff);
-		pcnet32_load_multicast(dev);
+		pcnet32_load_multicast(dev, false);
 	}
 
 	if (suspended) {
@@ -2922,6 +2953,7 @@ static int __maybe_unused pcnet32_pm_suspend(struct device *device_d)
 		pcnet32_close(dev);
 	}
 
+	netif_disable_async_ops(dev);
 	return 0;
 }
 
@@ -2929,6 +2961,7 @@ static int __maybe_unused pcnet32_pm_resume(struct device *device_d)
 {
 	struct net_device *dev = dev_get_drvdata(device_d);
 
+	netif_enable_async_ops(dev);
 	if (netif_running(dev)) {
 		pcnet32_open(dev);
 		netif_device_attach(dev);
@@ -2937,6 +2970,13 @@ static int __maybe_unused pcnet32_pm_resume(struct device *device_d)
 	return 0;
 }
 
+static void pcnet32_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	netif_disable_async_ops(dev);
+}
+
 static void pcnet32_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -2964,6 +3004,7 @@ static struct pci_driver pcnet32_driver = {
 	.driver = {
 		.pm = &pcnet32_pm_ops,
 	},
+	.shutdown = pcnet32_shutdown,
 };
 
 /* An additional parameter that may be passed in... */
-- 
2.47.3


