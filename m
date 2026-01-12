Return-Path: <netdev+bounces-249138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13764D14B96
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9BCD30855BE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11138735B;
	Mon, 12 Jan 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr9o58Ak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA0137E312
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241856; cv=none; b=HdEp9cbx4VwUjoY7YejHJTep1XYXRhd9zQwlIDnreDUWHLSBwPOi9UGCTKME/RBxrQEHfVaT7CUsoIbdDwxTppZIkmFRVjldmeI3Mvk3TvHywQUWY0WawlRVWuIIdecHLGQYRN3/Y4vZisd6skK+udPTY6GzlamOzM1P4PMY+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241856; c=relaxed/simple;
	bh=zUlknjpr6NS/41pV6wwhH8kUJOwAMPCghxbyamS0MmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjDXaSllHJWPxac/xZ9dpp1O1hBpN6IdpFzpZis6LcO2ggSYQcVbxUUDA9YGdtaHYpW7Kspp2YIZ/vkDJh4ucjRmI5uE4RbsBKvITZNsU1PN7OhdX89hnFg5ksGGwGMIoDJaOFsBRgD9Vo9fijCwlQVkDViwBvZUVrrt9MhCps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr9o58Ak; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso2871534a12.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241854; x=1768846654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaMWg4vSUFgDqiP4zZzxboikLWW6MxJC8CsR8zCkSA4=;
        b=Gr9o58AkpaOTSVkVUMVXfnj5mo6xa+hNrqNCPXd2wfXwp7yRO2pGjb9kJ3YIWJcGRN
         1VKyLMYTamZPjHGwLUruqEHjhvOfqBusN4rr/PzURZnxPCzGCAQTPgoJArFje24+rdIJ
         oELIu7Ouq5V1Rys8gVOJA8rRa9xTV4RozL7CZCPPVI1elKGOY40ig6QgsOgj18mvxruB
         KETtul4F1fvF6VRLg25bqKoSV6fMqtoHNtPlo1OZNI8BZyzpCJ/HQT5qE63DDajz61nW
         fXP02dohATcKNGqMtqJpRNhq/2FTg/qYne9WdPIK2LBXq8jbPJ41oPAOGbzonNAvVAvR
         JAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241854; x=1768846654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaMWg4vSUFgDqiP4zZzxboikLWW6MxJC8CsR8zCkSA4=;
        b=EGDYcgbrXr4r4Io0P4fKrsHx5yvY2DfIXCiCeQyqe+hX4l1FYWvROLyMY1FulxtxmR
         8jnfYBUcr+8F5FipNpd2kp6u6c0QaY3nTzLcCpYH6ZkT9On0cXnP1h5eIq0SGE5SV9hY
         K7efsmzHpDZ9Aa8lNODpi9cvo46de1sfNp8OQM/rOndjR5eJzaOP3mDYJbvIp+eqTr5j
         13DSf0XNDX7PXbZY5JNqWl6yvbUrRGag7J6iUe3m7gCrRPsWiGlE9+dsujGOf1Hek0ds
         6iw3JaQTADAPENdxRCKHH4UFb1pUjsJQwyQUI8vvNCZH6T9MwQ29ms6mG+kPIF5U7T6S
         H3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVU6Ah0kpVCIaZh1Eh1AyTrNCkCdbBpZ2RNXnBnhM2Sxk3rZoPu1Runi2XVW2UKeYNg7fZTPzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26Sju2tDHM15tSGcn+VD/71uHVPapY4iydo4GO2C0/ZFsADwo
	/tQBI7yG414t+cSfj7mypBxadNR6stPixYUmSvijLloOzawTtq6ZffGx
X-Gm-Gg: AY/fxX5JCzYfqRuLtSmnBO6E/TxSmH53uNfo4qgn1TuTZrqz0ADI99LD2fTzY/1cayE
	5U731kRkG6gebGnwa26qYJE+yznyjWfP/iNHgQfguZeGP9EK3OGARR4wTFY9HpveXf0AcUWuFGo
	X9SlurdJ2G756IcaG+FeYmo6nv9N3AxhD3YN9fNkYNBPf1kHkhQE5gBtBtz/m7cKfke1bJjYn9R
	bLvYwTOE5Z6FJlV0rg/lXZvWnsxdah9YBD+PQAPQAqX02UvFTwdLlnyoVvR+JFEOmk6GwUZl5tU
	mBEZw34b36Tz/sPSpv2dugGLpvrp1HfbkmWk++4w8fuvDtjaAYySiGMPhGURyUCxgtLVe0cDfml
	TKKqmzi17C4swo2SJCkXf9n3eQcTBE/+V+2BnYhVvoSIAiEJyP2eqdarmMvoXEDvFl7w5/XqYaY
	UHHXX+z8K2mfL76wMTAHcmUh8oj/U4WZWWn+DOzV6pmkPgk8S4Byn76Uyou0HqktRJ6g==
X-Google-Smtp-Source: AGHT+IHoeAxVt0AuWhhUsDTjmxXGaTHs8ySg3i9SS+DIkrhT+vbgKe7J+QXpC64qK2Vzx3i2dgGt/Q==
X-Received: by 2002:a17:90b:4acb:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-34f68b4ce84mr16936898a91.8.1768241854053;
        Mon, 12 Jan 2026 10:17:34 -0800 (PST)
Received: from localhost.localdomain ([122.183.54.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4141sm18165365a91.6.2026.01.12.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:17:33 -0800 (PST)
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
Subject: [PATCH net-next v8 4/6] 8139cp: Implement ndo_write_rx_mode callback
Date: Mon, 12 Jan 2026 23:46:24 +0530
Message-ID: <20260112181626.20117-5-viswanathiyyappan@gmail.com>
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
 In the old cp_set_rx_mode, cp->lock was protecting access to registers
 at addresses RxConfig, MAR0 and MAR0+4. The lock was probably meant to 
 provide synchronization for cp_set_rx_mode as these registers were 
 accessed exclusively by __cp_set_rx_mode.
 
 drivers/net/ethernet/realtek/8139cp.c | 33 +++++++++++++++------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
index 5652da8a178c..ab0395640305 100644
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
+static void cp_write_rx_mode(struct net_device *dev)
 {
 	struct cp_private *cp = netdev_priv(dev);
 	u32 mc_filter[2];	/* Multicast hash filter */
+	char *ha_addr;
 	int rx_mode;
+	int ni;
 
 	/* Note: do not reorder, GCC is clever about common statements. */
-	if (dev->flags & IFF_PROMISC) {
+	if (netif_rx_mode_get_cfg(dev, NETIF_RX_MODE_CFG_PROMISC)) {
 		/* Unconditionally log net taps. */
 		rx_mode =
 		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
 		    AcceptAllPhys;
 		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
+	} else if ((netif_rx_mode_mc_count(dev) > multicast_filter_limit) ||
+		   netif_rx_mode_get_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI)) {
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
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_UC_SKIP, true);
+	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_MC_SKIP, promisc | allmulti);
+
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_ALLMULTI, allmulti);
+	netif_rx_mode_set_cfg(dev, NETIF_RX_MODE_CFG_PROMISC, promisc);
 }
 
 static void __cp_get_stats(struct cp_private *cp)
@@ -1040,7 +1042,7 @@ static void cp_init_hw (struct cp_private *cp)
 	cp_start_hw(cp);
 	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
 
-	__cp_set_rx_mode(dev);
+	netif_schedule_rx_mode_work(dev);
 	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
 
 	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable);
@@ -1262,7 +1264,7 @@ static void cp_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	cp_clean_rings(cp);
 	cp_init_rings(cp);
 	cp_start_hw(cp);
-	__cp_set_rx_mode(dev);
+	netif_schedule_rx_mode_work(dev);
 	cpw16_f(IntrMask, cp_norx_intr_mask);
 
 	netif_wake_queue(dev);
@@ -1870,6 +1872,7 @@ static const struct net_device_ops cp_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address 	= cp_set_mac_address,
 	.ndo_set_rx_mode	= cp_set_rx_mode,
+	.ndo_write_rx_mode	= cp_write_rx_mode,
 	.ndo_get_stats		= cp_get_stats,
 	.ndo_eth_ioctl		= cp_ioctl,
 	.ndo_start_xmit		= cp_start_xmit,
-- 
2.47.3


