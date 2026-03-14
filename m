Return-Path: <netdev+bounces-267824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJyNOWyptWmw3AAAu9opvQ
	(envelope-from <netdev+bounces-267824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:31:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6628028E78A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF36E3025162
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526523382C8;
	Sat, 14 Mar 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMxYfnhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA231C3C08
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512971; cv=none; b=TWB0hEvik1vYCiDdhCtdJ0c9p2KLeIsEmV+oXOGzDFTRiFsJZu2Rspu3anjv8JpuuKyUgOfYQGokhVuwnB6uKo9M/GkCZwEm7qnVF6otECJ4iiNruTx0ME5KGKQQJj2LH6csuNOyj7VlGXGVgMkmrtkMDkTH20i2nzXbRm7wECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512971; c=relaxed/simple;
	bh=QLZYYEoj+5kLfwWS2IqKub9BTqN23yPeZ2bW6yAB0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcuyELad4+DNYLdXl7R7n8eygg2jDZlwaL+tq4qy9LqUNu41gM4n+TYvFYryps7QdgGDTDGIVw5Q8DekGu07EttwKSKdmRLQzTvJKeXlUN0Eaqncyyg3i52HDj3aSB84yJjbMtPemS07YjKnrwXCX+H8Ep0cmcdEWnMdXYVLD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMxYfnhi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b04b4974abso2543335ad.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512969; x=1774117769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB6x/lr1ek9kI9gI1prPQzKFPvlqHQ7Z+jL2sCBy488=;
        b=FMxYfnhi+21QvpNVJLMxrxfpYn3MFU1yIWd0SaDIllEPzEYag8eWm0OnHDVkw4oqo5
         ZKddlHnxTnuB/klDtPkQ+DTYpMclDFn5km+vdZcbFwwicwWJvLnDzVaTW7cABi6+6VKi
         WBIYaySPmcowSec2oNIiMUPr/BvZIxnsJBdsQZBqcYr6r8CJCnciOJxOfrdHqKUBK7ax
         Yy4Wr7sa/TXEBDGcBBa6ypzAUdkXlj1rB/F9/GDmuRoHS0vy4KoCvfj8nzVAMbbpjNpj
         wy0t9uVa5iZvloU3tg1uHmeBzGqCxBiphUbmZK119U6/duD6yvWJdInRUfxIs7W+axxl
         CQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512969; x=1774117769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IB6x/lr1ek9kI9gI1prPQzKFPvlqHQ7Z+jL2sCBy488=;
        b=Y9hgdJTRQjIpKyXtNKctyS4VfuUPTqLMt7OneFYGRvPFUX857SFSqC/1WjpASH9kRc
         m+V++cUvET7n1hyoJdSZSkTpNK73+8bCNDfhr5zc/n8fgKqv0/AnJpv/a2OW4RL9Y/3A
         PnvhDxRdVY9gsFO6Qikj2Cpy7d3kXxjqEjK/yoigziNp0U+Btv0pseBADe7Qy9maymPm
         uf5syZ+ydHNu1xRMD8EsGL0FH411C0zAMojLzcI56+BrBvU71qhBW64XN3qRRLdViZ/z
         R3vWJOAKbhhPUdpxlG+K+bHI/tHfbHK98qLltzvPifPVevMvUQ/ItM7OKPGhlQoXpOXg
         BAHA==
X-Forwarded-Encrypted: i=1; AJvYcCXSEl2S7jshWSgESDcCYIPI9pDh8dPHhKKSF38pNYcm3veDPhL1SmDN80OOEcQi7LWnV4flYd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1eBzHWOSSzEU0vA3g7BiaHG4wiqgdZWfQBI70Txe1KlOKFeD
	XyhKcweRKYKFMgCkJYEX+9zZWvAM1Lhab3Y1+O7c1ClhyAg0bRFa79Jc
X-Gm-Gg: ATEYQzz+ieDg6b3LUdM5wvx2JezKcYirCuCoOwEjz06vhBHRN5z/UiOey/P/CpirSjI
	GlGyB+OevxVi9XALZtdh5kV/9SavRJ9Xdrw6Td+hzdOtthXmqN5AXNz0h9S9x/8h2W5kCh9IP+Q
	SbYYFIGwtapdiG0K9OtvNMb/oMnm60cTMNAvq2Zyf6pPJ8VzdFmV5uHgnes0FgE1Datl4GMie1g
	7GnWa53iedc+FEM1Y0dTuP3LqquFr93BNsI6kM2bCcclD8KFHAWLvPJB+e2hzRBiU3CvMTqvP3O
	HHtR7/oK0nBi22DHQaYO+tG39AU+SvkG1shap/WkIux7kmWPtBxIreOIzseqmMT/htJ4sfdmIde
	05ms3Uti4QebO871D+18CC0w7aN0uFi3k604RmpVelV5jDM0pyofUf/7AKLpqrTdNy33TKS2Wsq
	PlCJr/VxzVoR+z0uQpTZNt9fVFSHKKAGZ03wc3CrdkSqdLrFtloLr1BrsDN82C9Pb+PGyPRUo/P
	bmFqQ==
X-Received: by 2002:a17:902:d592:b0:2ae:5ec4:2f78 with SMTP id d9443c01a7336-2aecaaa860dmr85707515ad.33.1773512968776;
        Sat, 14 Mar 2026 11:29:28 -0700 (PDT)
Received: from localhost.localdomain ([122.168.66.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c581sm77673525ad.33.2026.03.14.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:29:27 -0700 (PDT)
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
Subject: [PATCH net-next v9 5/7] 8139cp: Implement ndo_set_rx_mode_async callback
Date: Sat, 14 Mar 2026 23:58:07 +0530
Message-ID: <20260314182809.362808-6-viswanathiyyappan@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-267824-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6628028E78A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the ndo_set_rx_mode_async callback and update
the driver to use the snapshot/commit model for RX mode update.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
Call paths involving netif_set_rx_mode in 8139cp

netif_set_rx_mode
|-- cp_init_hw
|   |-- cp_open (ndo_open, takes lock)
|   |   `-- cp_change_mtu (ndo_change_mtu, takes lock)
|   |
|   `-- cp_resume (lock added)
|
`-- cp_tx_timeout (ndo_tx_timeout, takes lock)

 drivers/net/ethernet/realtek/8139cp.c | 49 ++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..9651a0d9d8f0 100644
--- a/drivers/net/ethernet/realtek/8139cp.c
+++ b/drivers/net/ethernet/realtek/8139cp.c
@@ -372,7 +372,6 @@ struct cp_private {
 	} while (0)
 
 
-static void __cp_set_rx_mode (struct net_device *dev);
 static void cp_tx (struct cp_private *cp);
 static void cp_clean_rings (struct cp_private *cp);
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -885,30 +884,31 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
 /* Set or clear the multicast filter for this adaptor.
    This routine is not state sensitive and need not be SMP locked. */
 
-static void __cp_set_rx_mode (struct net_device *dev)
+static void cp_set_rx_mode_async(struct net_device *dev)
 {
 	struct cp_private *cp = netdev_priv(dev);
 	u32 mc_filter[2];	/* Multicast hash filter */
+	char *ha_addr;
 	int rx_mode;
+	int ni;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_get_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Unconditionally log net taps. */
 		rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
+	} else if ((netif_rx_mode_mc_count(dev) > multicast_filter_limit) ||
+		   netif_get_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI)) {
 		/* Too many to filter perfectly -- accept all multicasts. */
 		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
 	} else {
-		struct netdev_hw_addr *ha;
 		rx_mode = AcceptBroadcast | AcceptMyPhys;
 		mc_filter[1] = mc_filter[0] = 0;
-		netdev_for_each_mc_addr(ha, dev) {
-			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
+		netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni) {
+			int bit_nr = ether_crc(ETH_ALEN, ha_addr) >> 26;
 
 			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
 			rx_mode |= AcceptMulticast;
@@ -925,12 +925,14 @@ static void __cp_set_rx_mode (struct net_device *dev)
 
 static void cp_set_rx_mode (struct net_device *dev)
 {
-	unsigned long flags;
-	struct cp_private *cp = netdev_priv(dev);
+	bool allmulti = !!(dev->flags & IFF_ALLMULTI);
+	bool promisc = !!(dev->flags & IFF_PROMISC);
 
-	spin_lock_irqsave (&cp->lock, flags);
-	__cp_set_rx_mode(dev);
-	spin_unlock_irqrestore (&cp->lock, flags);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_set_rx_mode_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_set_rx_mode_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static void __cp_get_stats(struct cp_private *cp)
@@ -1040,7 +1042,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	netif_set_rx_mode(dev);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1262,7 +1264,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	netif_set_rx_mode(dev);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1870,6 +1872,7 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
 	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_set_rx_mode_async	= cp_set_rx_mode_async,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
@@ -2071,7 +2074,7 @@ static int __maybe_unused cp_suspend(struct device *device)
 	spin_unlock_irqrestore (&cp->lock, flags);
 
 	device_set_wakeup_enable(device, cp->wol_enabled);
-
+	netif_disable_async_ops(dev);
 	return 0;
 }
 
@@ -2081,6 +2084,8 @@ static int __maybe_unused cp_resume(struct device *device)
 	struct cp_private *cp = netdev_priv(dev);
 	unsigned long flags;
 
+	netif_enable_async_ops(dev);
+
 	if (!netif_running(dev))
 		return 0;
 
@@ -2088,7 +2093,11 @@ static int __maybe_unused cp_resume(struct device *device)
 
 	/* FIXME: sh*t may happen if the Rx ring buffer is depleted */
 	cp_init_rings_index (cp);
+
+	rtnl_lock();
 	cp_init_hw (cp);
+	rtnl_unlock();
+
 	cp_enable_irq(cp);
 	netif_start_queue (dev);
 
@@ -2101,6 +2110,13 @@ static int __maybe_unused cp_resume(struct device *device)
 	return 0;
 }
 
+static void cp_shutdown(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	netif_disable_async_ops(dev);
+}
+
 static const struct pci_device_id cp_pci_tbl[] = {
         { PCI_DEVICE(PCI_VENDOR_ID_REALTEK,     PCI_DEVICE_ID_REALTEK_8139), },
         { PCI_DEVICE(PCI_VENDOR_ID_TTTECH,      PCI_DEVICE_ID_TTTECH_MC322), },
@@ -2116,6 +2132,7 @@ static struct pci_driver cp_driver = {
 	.probe        =	cp_init_one,
 	.remove       = cp_remove_one,
 	.driver.pm    = &cp_pm_ops,
+	.shutdown     = &cp_shutdown
 };
 
 module_pci_driver(cp_driver);
-- 
2.47.3


