Return-Path: <netdev+bounces-213221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63682B2424D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A20188D77A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F62EA172;
	Wed, 13 Aug 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UPmCWCOf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DL+G3Oz+"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D712D0C80;
	Wed, 13 Aug 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068931; cv=none; b=TUFYHyzxG9h7ZSIQytttgp5e76ivZvPC/OQC6IDfEW4ywkvKVRF3Eji0Jaho0jWCPk7hf/Bnxn/ZBH0IK1DMvAz6SwAaaGjeMQZqutIER0eAUv7PJ410iH7rujbvKUTMbaxdz4xCHMrqW1stBAUgIcZ1iMHje7Bf8v9I9fFa7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068931; c=relaxed/simple;
	bh=bNnYgFC4hFfdbpjmc2FfnD98vXhNZNLzKrIefbzC1qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfhkHpY2tgfqCn/U8t9dE5eJR4o+g2BcSgyVJuzObpM9+mBJX0u/qWhfkSejpxqukGAqS6N8wimRmsi/6KUEcPsz0ppBbycJwJX0tIwD9p725yuGlaK6HdQ3wmRPUng+NtCimU4tJxUFJzWqIAIxS8tz10nnSlcTcfXbIrd3Mbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UPmCWCOf; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DL+G3Oz+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c1zxP5ns7z9tKV;
	Wed, 13 Aug 2025 09:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755068921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pHFPvwaciHcTj0LICdh8q49BvDmRNZ6BaPvEkmxLNY=;
	b=UPmCWCOfSNJ18tRvwNjvGpc9AkKQ041p6IlW9K1vR+TEzPnnPTwW8B3z7JjWfMoxgdE1WB
	OQyWs4oyKAcO+ahkHTW3PZN3dNuxXjrwSTuC9iVfuru1YoXRqc6F3u/KFWFhcD0+epAx9Z
	OFR24P8B4L0WGuhpEen5awOIpi25DwWNEQLoRlngNmn8WHbsFx3TY6Emqy3UNATDLmBXeP
	N0ac+9EsD5FDCPFuFpLJkl2BK44hXiBDoyRF4mFOufauJhvD0DBO1EjZYnbDPl1Hu1XN9o
	Cw09/DKKYi1qHq0HdET9SR48pIbEAZ98W9L9mL3dxfGH/SYGkYJNZzJkHubMHA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DL+G3Oz+;
	spf=pass (outgoing_mbo_mout: domain of lukasz.majewski@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lukasz.majewski@mailbox.org
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755068919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pHFPvwaciHcTj0LICdh8q49BvDmRNZ6BaPvEkmxLNY=;
	b=DL+G3Oz+4feCh0OrFuLlsLT+o1Yi1ZqX7Vh5iWYKEJs8WU8TB+BZs+1JLxGwQDR9/GU19H
	jKKbSvdTpSlFvcq61wPTdSlKheMivRVwhnqQqfGLt9Ng0JMDt9ZVIYDGV852576+Fy4+2j
	C5ZVE8UPBDqnwhuKSJY4DmWDbXFbX4MOH8j2n2635ufvj1g2R/FxV+eGiXkz/ysfP3MuJh
	IXfMnTHgVlV+r9DwV3YR2MEEkWz9mztTJLxzWjgPzUE8QzKD/2wmK7t3eaHgRljS+im5MZ
	Uyil9r1PWz6PTmYdGShax/EpgTArCWV+xeY8gVn1K4RApfwYrGIbqlrmyh3qhg==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v18 4/7] net: mtip: Add net_device_ops functions to the L2 switch driver
Date: Wed, 13 Aug 2025 09:07:52 +0200
Message-Id: <20250813070755.1523898-5-lukasz.majewski@mailbox.org>
In-Reply-To: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 433f81a8514b40f96c9
X-MBO-RS-META: e4kpjktogacktoz4hfrnngngfn7dsm1w
X-Rspamd-Queue-Id: 4c1zxP5ns7z9tKV

This patch provides callbacks for struct net_device_ops for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>

---
Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14:
- Add read memory barier (rmb) before reading current descriptor
- Use proper locking primitives

Changes for v15 - v15:
- None

Changes for v16:
- Enable MTIP ports to support bridge offloading
- Use dev_err_ratelimited() instead of plain dev_err()
- Move skb storage and tx ring buffer modifications after
  dma mapping code.
- Do not increase tx_errors when frames are dropped after
  failed dma_mapping.
- Refactor the code for better readability
- Remove legacy call to netif_trans_update()
- Remove not needed rmb() - synchronized data read already assured by
  coherent DMA allocation
- Replace spin_{un}lock() with _bh variant

Changes for v17:
- Add missing _bh() variant of spin_unlock
- Avoid reverse christmas tree in swap_buffer()
- Print error message after unlock
- Add DO_ONCE() and a separate function to print state of switch HW
- Remove dev->stats.tx_errors++

Changes for v18:
- None
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 284 ++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index c80857310a17..39a4997fc8fe 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -43,6 +43,15 @@
 
 #include "mtipl2sw.h"
 
+static void swap_buffer(void *bufaddr, int len)
+{
+	unsigned int *buf = bufaddr;
+	int i;
+
+	for (i = 0; i < len; i += 4, buf++)
+		swab32s(buf);
+}
+
 /* Set the last buffer to wrap */
 static void mtip_set_last_buf_to_wrap(struct cbd_t *bdp)
 {
@@ -436,6 +445,124 @@ static void mtip_config_switch(struct switch_enet_private *fep)
 	       fep->hwp + ESW_IMR);
 }
 
+static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
+					struct net_device *dev, int port)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	unsigned short status;
+	struct cbd_t *bdp;
+	void *bufaddr;
+
+	spin_lock_bh(&fep->hw_lock);
+
+	if (!fep->link[0] && !fep->link[1]) {
+		/* Link is down or autonegotiation is in progress. */
+		netif_stop_queue(dev);
+		spin_unlock_bh(&fep->hw_lock);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = fep->cur_tx;
+	status = bdp->cbd_sc;
+
+	if (status & BD_ENET_TX_READY) {
+		/* All transmit buffers are full. Bail out.
+		 * This should not happen, since dev->tbusy should be set.
+		 */
+		netif_stop_queue(dev);
+		spin_unlock_bh(&fep->hw_lock);
+		dev_err_ratelimited(&fep->pdev->dev, "%s: tx queue full!.\n",
+				    dev->name);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Clear all of the status flags */
+	status &= ~BD_ENET_TX_STATS;
+
+	/* Set buffer length and buffer pointer */
+	bufaddr = skb->data;
+	bdp->cbd_datlen = skb->len;
+
+	/* On some FEC implementations data must be aligned on
+	 * 4-byte boundaries. Use bounce buffers to copy data
+	 * and get it aligned.spin
+	 */
+	if ((unsigned long)bufaddr & MTIP_ALIGNMENT) {
+		unsigned int index;
+
+		index = bdp - fep->tx_bd_base;
+		memcpy(fep->tx_bounce[index], skb->data, skb->len);
+		bufaddr = fep->tx_bounce[index];
+	}
+
+	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		swap_buffer(bufaddr, skb->len);
+
+	/* Push the data cache so the CPM does not get stale memory
+	 * data.
+	 */
+	bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
+					  MTIP_SWITCH_TX_FRSIZE,
+					  DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr))) {
+		dev_err(&fep->pdev->dev,
+			"Failed to map descriptor tx buffer\n");
+		dev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		goto err;
+	}
+
+	/* Save skb pointer. */
+	fep->tx_skbuff[fep->skb_cur] = skb;
+	fep->skb_cur = (fep->skb_cur + 1) & TX_RING_MOD_MASK;
+
+	/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+	 * it's the last BD of the frame, and to put the CRC on the end.
+	 */
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR | BD_ENET_TX_LAST |
+		   BD_ENET_TX_TC);
+
+	/* Synchronize all descriptor writes */
+	wmb();
+	bdp->cbd_sc = status;
+
+	skb_tx_timestamp(skb);
+
+	/* Trigger transmission start */
+	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
+
+	dev->stats.tx_bytes += skb->len;
+	/* If this was the last BD in the ring,
+	 * start at the beginning again.
+	 */
+	if (status & BD_ENET_TX_WRAP)
+		bdp = fep->tx_bd_base;
+	else
+		bdp++;
+
+	if (bdp == fep->dirty_tx) {
+		fep->tx_full = 1;
+		netif_stop_queue(dev);
+	}
+
+	fep->cur_tx = bdp;
+ err:
+	spin_unlock_bh(&fep->hw_lock);
+
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t mtip_start_xmit(struct sk_buff *skb,
+				   struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+
+	return mtip_start_xmit_port(skb, dev, priv->portnum);
+}
+
 static void mtip_configure_enet_mii(struct switch_enet_private *fep, int port)
 {
 	struct phy_device *phydev = fep->phy_dev[port - 1];
@@ -593,6 +720,70 @@ static void mtip_switch_restart(struct net_device *dev, int duplex0,
 	mtip_config_switch(fep);
 }
 
+static void mtip_print_hw_state(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	int i;
+
+	spin_lock_bh(&fep->hw_lock);
+	dev_info(&dev->dev, "%s: transmit timed out.\n", dev->name);
+	dev_info(&dev->dev,
+		 "Ring data: cur_tx 0x%p%s, dirty_tx 0x%p cur_rx: 0x%p\n",
+		 fep->cur_tx, fep->tx_full ? " (full)" : "", fep->dirty_tx,
+		 fep->cur_rx);
+
+	bdp = fep->tx_bd_base;
+	dev_info(&dev->dev, " tx: %u buffers\n", TX_RING_SIZE);
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		dev_info(&dev->dev, "  0x%p: %04x %04x %08x\n",
+			 bdp, bdp->cbd_sc, bdp->cbd_datlen,
+			 (int)bdp->cbd_bufaddr);
+		bdp++;
+	}
+
+	bdp = fep->rx_bd_base;
+	dev_info(&dev->dev, " rx: %lu buffers\n", RX_RING_SIZE);
+	for (i = 0 ; i < RX_RING_SIZE; i++) {
+		dev_info(&dev->dev, "  0x%p: %04x %04x %08x\n",
+			 bdp, bdp->cbd_sc, bdp->cbd_datlen,
+			 (int)bdp->cbd_bufaddr);
+		bdp++;
+	}
+	spin_unlock_bh(&fep->hw_lock);
+}
+
+static void mtip_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+
+	dev->stats.tx_errors++;
+	DO_ONCE(mtip_print_hw_state, dev);
+
+	schedule_work(&priv->tx_timeout_work);
+}
+
+static void mtip_timeout_work(struct work_struct *work)
+{
+	struct mtip_ndev_priv *priv =
+		container_of(work, struct mtip_ndev_priv, tx_timeout_work);
+	struct switch_enet_private *fep = priv->fep;
+	struct net_device *dev = priv->dev;
+
+	rtnl_lock();
+	if (netif_device_present(dev) || netif_running(dev)) {
+		napi_disable(&fep->napi);
+		netif_tx_lock_bh(dev);
+		mtip_switch_restart(dev, fep->full_duplex[0],
+				    fep->full_duplex[1]);
+		netif_tx_wake_all_queues(dev);
+		netif_tx_unlock_bh(dev);
+		napi_enable(&fep->napi);
+	}
+	rtnl_unlock();
+}
+
 static irqreturn_t mtip_interrupt(int irq, void *ptr_fep)
 {
 	struct switch_enet_private *fep = ptr_fep;
@@ -1068,6 +1259,92 @@ static int mtip_close(struct net_device *dev)
 	return 0;
 }
 
+#define FEC_HASH_BITS	6		/* #bits in hash */
+static void mtip_set_multicast_list(struct net_device *dev)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	unsigned int hash_high = 0, hash_low = 0, crc;
+	struct switch_enet_private *fep = priv->fep;
+	void __iomem *enet_addr = fep->enet_addr;
+	struct netdev_hw_addr *ha;
+	unsigned char hash;
+
+	if (priv->portnum == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	if (dev->flags & IFF_PROMISC) {
+		/* Promisc mode is required for switch - it is
+		 * already enabled during driver's probe.
+		 */
+		dev_dbg(&dev->dev, "%s: IFF_PROMISC\n", __func__);
+		return;
+	}
+
+	if (dev->flags & IFF_ALLMULTI) {
+		dev_dbg(&dev->dev, "%s: IFF_ALLMULTI\n", __func__);
+
+		/* Allow all multicast addresses */
+		writel(0xFFFFFFFF, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
+		writel(0xFFFFFFFF, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
+
+		return;
+	}
+
+	netdev_for_each_mc_addr(ha, dev) {
+		/* Calculate crc32 value of mac address */
+		crc = ether_crc_le(dev->addr_len, ha->addr);
+
+		/* Only upper 6 bits (FEC_HASH_BITS) are used
+		 * which point to specific bit in the hash registers
+		 */
+		hash = (crc >> (32 - FEC_HASH_BITS)) & 0x3F;
+
+		if (hash > 31)
+			hash_high |= 1 << (hash - 32);
+		else
+			hash_low |= 1 << hash;
+	}
+
+	writel(hash_high, enet_addr + MCF_FEC_GRP_HASH_TABLE_HIGH);
+	writel(hash_low, enet_addr + MCF_FEC_GRP_HASH_TABLE_LOW);
+}
+
+static int mtip_set_mac_address(struct net_device *dev, void *p)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	void __iomem *enet_addr = fep->enet_addr;
+	struct sockaddr *addr = p;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+	eth_hw_addr_set(dev, addr->sa_data);
+
+	if (priv->portnum == 2)
+		enet_addr += MCF_ESW_ENET_PORT_OFFSET;
+
+	writel(dev->dev_addr[3] | (dev->dev_addr[2] << 8) |
+	       (dev->dev_addr[1] << 16) | (dev->dev_addr[0] << 24),
+	       enet_addr + MCF_FEC_PALR);
+	writel((dev->dev_addr[5] << 16) | (dev->dev_addr[4] << 24),
+	       enet_addr + MCF_FEC_PAUR);
+
+	return mtip_update_atable_static((unsigned char *)dev->dev_addr,
+					 7, 7, fep);
+}
+
+static int mtip_get_port_parent_id(struct net_device *ndev,
+				   struct netdev_phys_item_id *ppid)
+{
+	struct mtip_ndev_priv *priv = netdev_priv(ndev);
+	struct switch_enet_private *fep = priv->fep;
+
+	ppid->id_len = sizeof(fep->mac[0]);
+	memcpy(&ppid->id, &fep->mac[0], ppid->id_len);
+
+	return 0;
+}
+
 static const struct ethtool_ops mtip_ethtool_ops = {
 	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
 	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
@@ -1079,6 +1356,11 @@ static const struct ethtool_ops mtip_ethtool_ops = {
 static const struct net_device_ops mtip_netdev_ops = {
 	.ndo_open		= mtip_open,
 	.ndo_stop		= mtip_close,
+	.ndo_start_xmit	= mtip_start_xmit,
+	.ndo_set_rx_mode	= mtip_set_multicast_list,
+	.ndo_tx_timeout	= mtip_timeout,
+	.ndo_set_mac_address	= mtip_set_mac_address,
+	.ndo_get_port_parent_id	= mtip_get_port_parent_id,
 };
 
 bool mtip_is_switch_netdev_port(const struct net_device *ndev)
@@ -1183,6 +1465,8 @@ static int mtip_ndev_init(struct switch_enet_private *fep,
 			goto cleanup_created_ndev;
 		}
 
+		INIT_WORK(&priv->tx_timeout_work, mtip_timeout_work);
+
 		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2 switch %pM\n",
 			fep->ndev[i]->name, fep->ndev[i]->dev_addr);
 	}
-- 
2.39.5


