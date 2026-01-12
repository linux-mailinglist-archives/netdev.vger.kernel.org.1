Return-Path: <netdev+bounces-249140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D210D14BB4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8742C301A499
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38F387596;
	Mon, 12 Jan 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd8xi1Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2637F8A0
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241873; cv=none; b=RwnfXd23sjeFH5GjTxuP3RvXniPMgRfJJKi0jTFnTvzFSzXZHnuyFKpHuGBKDOWMSBNzMcTixNCtFabVOMvZqwXzly/njBBfv70pVc3Z/eIEeNSVQIx9aN71B6HlCVk2mCdYSjb65++CSH9pc1ThU1d9qfymgwdklEuVlNg9HQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241873; c=relaxed/simple;
	bh=7+9/4nymDsorNrdw/Y+cdaz+q2znF/7yqtVvfiRWfiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=analr3qoiUOzklYCV3W3QP6ra/ZUOr0LWA2hZZinsgDUSydyiFqyfhTrcS88IKeXQ6vxyHJGVTVMn05o2iZqMiWGBxJZ/WH/UZGzfpsi+U4eDT3vATm7pA4zPq1KEMXMsyX1n5cEsCvsgNgMR47lIuWNoVslacbViXKpS9hR2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd8xi1Vn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so5064654a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241871; x=1768846671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iPYz0c2/YOE9HPEJLTZDgF+3tXabqT+BOwl+/nVPFU=;
        b=Hd8xi1Vnh+6zvIHokUglamIp/naaI75931XzAkT5eWpqdiCmshuGNm5NuPbcoBvdQs
         t9AZaUSFkhtvX5HIK7mpP0OJ1AqTctBtNwYdvOYob7GkNU97MN8+fzkL4Hut3M+4hich
         jqHi9BKrr0uS2ym7fUcuO6Hi9Qxfw6SnBGH+pBRq0OlySkRL2eZCysygfR6SuCXmdali
         zo67FRw4v2orkuWU1kxyhkaf4ippko5LwYofu8/q0YJrX16OnmT1194iuaSzd8oQ0wwc
         txMBd6VQ2QR3ixPH5JClX/vIvtpUtDW5CssChYuy0Gx3ipuWjTtV+mPJP4PBJi6dWpoA
         YQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241871; x=1768846671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4iPYz0c2/YOE9HPEJLTZDgF+3tXabqT+BOwl+/nVPFU=;
        b=XwTaBa5ZGxNue+eWSpfMOfVxVRonZY3fmXkLcoouL7smeiEY+Xvm5UYsJB5k+M4NL8
         XDRqxeE9prNOQfQabbCHmVhROGOb06lUgcg2jjyGl2xPhjSE15HZ8Dnw/KCFhNsN9CcB
         MvpgcAZMAcovYwVNemf/7SzvJs8ektuuBfkWYdPho8CGWgM4h1uCn4CLZqMBxeXKYffk
         t+6j4S2QFKtXl99H6xzLlYiDUeEPLDG1Q/ub+zPJzRCowxOpf+a2jIuqdwZ1f3nHWyUd
         a8uYr0kPD03O5S/qP1xsjdEu8CTHG7XbOpwMXuHN8T6qW37heT/GGb7yvNNHVg/Zdabz
         rJhw==
X-Forwarded-Encrypted: i=1; AJvYcCU+QiAOQGJvGmD/HmKof8geirniX9ORiD+2ifdSyWfw72MNAZrxfTe4EginhkBRfc7plAQDmrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOsTXD78FPPMBDca8JfPXQPJvclGJoTcKDsTa24LzMNvAnc1o
	LigYBOQ+GtyetFyM45VKHijb4fxmb1DsIZ3NUUttKFEaX6ny6vn6o70e
X-Gm-Gg: AY/fxX7P4OStXf+z84s4yP6/ryXwsqMJx0VLzC5OjQzgnYo04j/xkuPRrR1MO8cm0iT
	uvmCxfOMxiUpaMIGbndBCqK40Tim+JZ/7ZoZjQgtJj6nLfnx6e/1EeuSgfXmenOZq9WEFZskAkq
	WGMcIyYuwkFBPBQs+r5F5hE6hJmjvsE2lUa/rybB20Zhil30w3+4fV+hWgDyRIKP68C6I4c7YRY
	Nh/zydYhZ4uEfRY9s0JxFlih6idQTFoPOyk4jH3+W9HQu4Q0DuOZn1TeWV+s87zbEdEfF1ftnB2
	UD4dq2iyriD5j+HyCI0gyxmFQz8YWZL3su6CglZ7XXgyUCQywsx7b/4G1tYNvP74rX1Mwczcf00
	cW2eDRUvh5NOTBkvwqqeHttqef5uNzsnoPKhAP2ChsOpyZfgdAMRRk8IQtpZblxzsUXmqBYihiI
	KapkwhFaJjXe8L+BE3zNCeKO4sbZFOPNtxQUu8Ft7t+TqvTBCXy1FpuFP0Qbrd+OhrxA==
X-Google-Smtp-Source: AGHT+IFiK1jweRQzBOm3ZEpB+UiR7srhpNL+qg9Y/k0eatbaDQCE66uWR/fEIuhnV//+2MGMla7rxw==
X-Received: by 2002:a17:90b:5628:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-34f68c91bbemr16740424a91.9.1768241871384;
        Mon, 12 Jan 2026 10:17:51 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:50 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	ronak.doshi@broadcom.com,
	pcnet32@frontier.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	intel-wired-lan@lists.osuosl.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v8 6/6] pcnet32: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:26 +0530
Message-ID: <20260112181626.20117-7-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
References: <20260112181626.20117-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add callback and update the code to use the rx_mode snapshot and
deferred write model

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 This is a very weird driver in that it calls pcnet32_load_multicast to set up
 the mc filter registers instead of the set_rx_mode callback in ndo_open.
 I can't find a single other driver that does that.
 
 Apart from that, I don't think it makes sense for the (now) write_rx_mode 
 callback to call netif_wake_queue(). Correct me if I am wrong here.
 
 drivers/net/ethernet/amd/pcnet32.c | 57 ++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 9eaefa0f5e80..8bb0bb3da789 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -314,8 +314,9 @@ static void pcnet32_tx_timeout(struct net_device *dev, unsigned int txqueue);
 static irqreturn_t pcnet32_interrupt(int, void *);
 static int pcnet32_close(struct net_device *);
 static struct net_device_stats *pcnet32_get_stats(struct net_device *);
-static void pcnet32_load_multicast(struct net_device *dev);
+static void pcnet32_load_multicast(struct net_device *dev, bool is_open);
 static void pcnet32_set_multicast_list(struct net_device *);
+static void pcnet32_write_multicast_list(struct net_device *);
 static int pcnet32_ioctl(struct net_device *, struct ifreq *, int);
 static void pcnet32_watchdog(struct timer_list *);
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num);
@@ -1580,6 +1581,7 @@ static const struct net_device_ops pcnet32_netdev_ops = {
 	.ndo_tx_timeout		= pcnet32_tx_timeout,
 	.ndo_get_stats		= pcnet32_get_stats,
 	.ndo_set_rx_mode	= pcnet32_set_multicast_list,
+	.ndo_write_rx_mode	= pcnet32_write_multicast_list,
 	.ndo_eth_ioctl		= pcnet32_ioctl,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -2264,7 +2266,7 @@ static int pcnet32_open(struct net_device *dev)
 
 	lp->init_block->mode =
 	    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
-	pcnet32_load_multicast(dev);
+	pcnet32_load_multicast(dev, true);
 
 	if (pcnet32_init_ring(dev)) {
 		rc = -ENOMEM;
@@ -2680,18 +2682,26 @@ static struct net_device_stats *pcnet32_get_stats(struct net_device *dev)
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
+		allmulti = netif_rx_mode_get_cfg(dev,
+						 NETIF_RX_MODE_CFG_ALLMULTI);
+
 	/* set all multicast bits */
-	if (dev->flags & IFF_ALLMULTI) {
+	if (allmulti) {
 		ib->filter[0] = cpu_to_le32(~0U);
 		ib->filter[1] = cpu_to_le32(~0U);
 		lp->a->write_csr(ioaddr, PCNET32_MC_FILTER, 0xffff);
@@ -2705,20 +2715,40 @@ static void pcnet32_load_multicast(struct net_device *dev)
 	ib->filter[1] = 0;
 
 	/* Add addresses */
-	netdev_for_each_mc_addr(ha, dev) {
-		crc = ether_crc_le(6, ha->addr);
-		crc = crc >> 26;
-		mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
-	}
+	if (is_open)
+		netdev_for_each_mc_addr(ha, dev) {
+			crc = ether_crc_le(6, ha->addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
+	else
+		netif_rx_mode_for_each_mc_addr(ha_addr, dev, ni) {
+			crc = ether_crc_le(6, ha_addr);
+			crc = crc >> 26;
+			mcast_table[crc >> 4] |= cpu_to_le16(1 << (crc & 0xf));
+		}
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
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
+}
+
 /*
  * Set or clear the multicast filter for this adaptor.
  */
-static void pcnet32_set_multicast_list(struct net_device *dev)
+static void pcnet32_write_multicast_list(struct net_device *dev)
 {
 	unsigned long ioaddr = dev->base_addr, flags;
 	struct pcnet32_private *lp = netdev_priv(dev);
@@ -2727,7 +2757,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 	spin_lock_irqsave(&lp->lock, flags);
 	suspended = pcnet32_suspend(dev, &flags, 0);
 	csr15 = lp->a->read_csr(ioaddr, CSR15);
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Log any net taps. */
 		netif_info(lp, hw, dev, "Promiscuous mode enabled\n");
 		lp->init_block->mode =
@@ -2738,7 +2768,7 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 		lp->init_block->mode =
 		    cpu_to_le16((lp->options & PCNET32_PORT_PORTSEL) << 7);
 		lp->a->write_csr(ioaddr, CSR15, csr15 & 0x7fff);
-		pcnet32_load_multicast(dev);
+		pcnet32_load_multicast(dev, false);
 	}
 
 	if (suspended) {
@@ -2746,7 +2776,6 @@ static void pcnet32_set_multicast_list(struct net_device *dev)
 	} else {
 		lp->a->write_csr(ioaddr, CSR0, CSR0_STOP);
 		pcnet32_restart(dev, CSR0_NORMAL);
-		netif_wake_queue(dev);
 	}
 
 	spin_unlock_irqrestore(&lp->lock, flags);
-- 
2.47.3


