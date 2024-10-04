Return-Path: <netdev+bounces-132006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F89901FC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0803DB221B3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3615666B;
	Fri,  4 Oct 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbhO+LLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CC156644;
	Fri,  4 Oct 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040812; cv=none; b=QykHX6Ynf1YEkgdU6J21NYQJ167FHZvW5xHecjPkpT44rc5IiZlFPPEjKx2FLfxulbT0T8TFzPQZVpk8GYMHfSyH3fwZe0t1OQ94nF1Ku2VJTH6i5Hc3jtCIG7M7HWxpA7gCwQgOazKNfykNsEC4oI0kOp+q9rhdOpteHfin/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040812; c=relaxed/simple;
	bh=2ZGI4+LkSpEruLL8EnqsIqSTHwo9vb6w6YxxWCOgnGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMPsCD++KZbgSkyfgh1G80HCPs2c6HePgxhWP8GmusTE9lqkbuy9bvxRWj2XhqatLNunmawWTgtKVYx8UfjUFlW4QrZbQNaeqiEPKzhuViKxMasmHb8e4s8n45ZYauQeBVzn+19YACs2krozxKrZRtN+T//hvzo2oJLB0WkXA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbhO+LLz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cafda818aso19560895e9.2;
        Fri, 04 Oct 2024 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728040809; x=1728645609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+SmcQqURVxBycNPDlTxY63u5VTYQ9bCdSfxUOfW7HU=;
        b=EbhO+LLzDhL4nd0F8Ka3WYcGhRHVRTuBUvs8yUiRMv7bmdMcFGXsWKYPKN6OPjRdML
         E3GvuK2MmQfYF4ofy7559Wnkz82EvX7Jz9Q/QoIUG+aDegd1CeW0sNhCKayFirpgUK5g
         5evij5jghEr5eC9fiKcwEfU1zzRDxlkZVF5/txrr4ysPTU6ixlGlizZ3thqyI0gjkPFy
         In1cNpVi6DLjwA0tU0ZHguNatE3LmZCl/7MiPj8SkJ/SC1AJJ1T1sdU75Rdn6khIImAJ
         j4vttl6aatmX1OhTTaTtvFhGbTuenA54YnJ4izCD7qaf834UNoG12l+lGMNjSYJb7oAu
         D7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040809; x=1728645609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+SmcQqURVxBycNPDlTxY63u5VTYQ9bCdSfxUOfW7HU=;
        b=QnVMY9gcw6BudBll+c7NHm1j9o50Vz1k06z4FtMxBxjDrevg8cjaACjkJ/Q5b0P4cx
         cmdCuyTNRjjMyxstwiSy0YXm/OnGu86A1xCSUQYCtP4QGJKQOWfRXifik5KGNpxSxn4J
         sRRQW1bUwxZeTTejY/hxVAUdJRGZDAUKiVUeRFRkjsmOgxbGkhMhHM28fu7f0v7etdpa
         tC7DiS+DxXa90+gd+my3L6q5IipLV5WOlDrsJmeTHtDo3JU9f95H+4aEerYOLA9FAYd6
         1qWp+Ji5Nl4PzJjLj+0QchzaKnVqGgJwt8O27fVwzbRFnhjU7nrCjWHrjIwpxZZNzVWy
         NteQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3y/ql10Aw6dZ8j2hYjvP6ArHmzYCSpAuZPnO+Ktm1pLSLl1CQgiohD8JAonzK9ubJnQJGle96UZM3ZYQ=@vger.kernel.org, AJvYcCX+MDuXmGvyE9QdsvZaMccHbpLfxIqz2Y9JMwUFq0bxYVyAmrqXRVZz2gTKmqk8emzAhPNAXNQM@vger.kernel.org, AJvYcCX0OttE0qsPUlMFozzc0Agbq8rxlrhcgnx2VW4bcDNXU+4qxMwvA/7husqrEjYedG4o/Sl2KHpyJgzl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EPWkalDrVeupwalh5qm2vc9lAbbWiYkJXtNdagX5xQx3d6Fe
	+X878n5x9t7dP6/yKT3makhN1+yKMkhI0Pp2UgdsWIs99OgUuIcb
X-Google-Smtp-Source: AGHT+IHhIuX+FJut2UgQgTKlSXaWRsoLbM1iDBCDl40PDBwCuEtm80W3kQYnoh/asgUs6qvwwyhhkg==
X-Received: by 2002:a05:600c:4ecb:b0:42e:93eb:ca26 with SMTP id 5b1f17b1804b1-42f85aa9258mr18619375e9.11.1728040808673;
        Fri, 04 Oct 2024 04:20:08 -0700 (PDT)
Received: from ubuntu-20.04.myguest.virtualbox.org ([77.137.66.252])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d981sm13263805e9.23.2024.10.04.04.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:20:08 -0700 (PDT)
From: Liel Harel <liel.harel@gmail.com>
To: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: liel.harel@gmail.com
Subject: [PATCH net] smsc95xx: Add implementation for set_pauseparam for enabling to pause RX path.
Date: Fri,  4 Oct 2024 14:20:00 +0300
Message-Id: <20241004112000.421681-1-liel.harel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable userspace applications to pause RX path by IOCTL.
The function write to MAC control and status register for pausing RX path.

Signed-off-by: Liel Harel <liel.harel@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 79 ++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 8e82184be..98afdf635 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -137,7 +137,8 @@ static int __must_check smsc95xx_write_reg(struct usbnet *dev, u32 index,
 }
 
 /* Loop until the read is completed with timeout
- * called with phy_mutex held */
+ * called with phy_mutex held
+ */
 static int __must_check smsc95xx_phy_wait_not_busy(struct usbnet *dev)
 {
 	unsigned long start_time = jiffies;
@@ -470,7 +471,8 @@ static int __must_check smsc95xx_write_reg_async(struct usbnet *dev, u16 index,
 
 /* returns hash bit number for given MAC address
  * example:
- * 01 00 5E 00 00 01 -> returns bit number 31 */
+ * 01 00 5E 00 00 01 -> returns bit number 31
+ */
 static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 {
 	return (ether_crc(ETH_ALEN, addr) >> 26) & 0x3f;
@@ -772,6 +774,45 @@ static int smsc95xx_ethtool_get_sset_count(struct net_device *ndev, int sset)
 	}
 }
 
+/* Starts the Receive path */
+static int smsc95xx_start_rx_path(struct usbnet *dev)
+{
+	struct smsc95xx_priv *pdata = dev->driver_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
+	pdata->mac_cr |= MAC_CR_RXEN_;
+	spin_unlock_irqrestore(&pdata->mac_cr_lock, flags);
+
+	return smsc95xx_write_reg(dev, MAC_CR, pdata->mac_cr);
+}
+
+/* Stops the Receive path */
+static int smsc95xx_stop_rx_path(struct usbnet *dev)
+{
+	struct smsc95xx_priv *pdata = dev->driver_priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
+	pdata->mac_cr &= ~MAC_CR_RXEN_;
+	spin_unlock_irqrestore(&pdata->mac_cr_lock, flags);
+
+	return smsc95xx_write_reg(dev, MAC_CR, pdata->mac_cr);
+}
+
+static int smsc95xx_ethtool_set_pauseparam(struct net_device *netdev,
+									struct ethtool_pauseparam *pause)
+{
+	struct usbnet *dev = netdev_priv(netdev);
+
+	if (!pause->tx_pause || !pause->autoneg)
+		return -EINVAL;
+
+	if (pause->rx_pause)
+		return smsc95xx_start_rx_path(dev);
+	return smsc95xx_stop_rx_path(dev);
+}
+
 static const struct ethtool_ops smsc95xx_ethtool_ops = {
 	.get_link	= smsc95xx_get_link,
 	.nway_reset	= phy_ethtool_nway_reset,
@@ -791,6 +832,7 @@ static const struct ethtool_ops smsc95xx_ethtool_ops = {
 	.self_test	= net_selftest,
 	.get_strings	= smsc95xx_ethtool_get_strings,
 	.get_sset_count	= smsc95xx_ethtool_get_sset_count,
+	.set_pauseparam = smsc95xx_ethtool_set_pauseparam,
 };
 
 static int smsc95xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
@@ -863,26 +905,13 @@ static int smsc95xx_start_tx_path(struct usbnet *dev)
 	return smsc95xx_write_reg(dev, TX_CFG, TX_CFG_ON_);
 }
 
-/* Starts the Receive path */
-static int smsc95xx_start_rx_path(struct usbnet *dev)
-{
-	struct smsc95xx_priv *pdata = dev->driver_priv;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
-	pdata->mac_cr |= MAC_CR_RXEN_;
-	spin_unlock_irqrestore(&pdata->mac_cr_lock, flags);
-
-	return smsc95xx_write_reg(dev, MAC_CR, pdata->mac_cr);
-}
-
 static int smsc95xx_reset(struct usbnet *dev)
 {
 	struct smsc95xx_priv *pdata = dev->driver_priv;
 	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
-	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
+	netif_dbg(dev, ifup, dev->net, "entering %s\n", __func__);
 
 	ret = smsc95xx_write_reg(dev, HW_CFG, HW_CFG_LRST_);
 	if (ret < 0)
@@ -1065,7 +1094,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 		return ret;
 	}
 
-	netif_dbg(dev, ifup, dev->net, "smsc95xx_reset, return 0\n");
+	netif_dbg(dev, ifup, dev->net, "%s, return 0\n", __func__);
 	return 0;
 }
 
@@ -1076,7 +1105,7 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_tx_timeout		= usbnet_tx_timeout,
 	.ndo_change_mtu		= usbnet_change_mtu,
 	.ndo_get_stats64	= dev_get_tstats64,
-	.ndo_set_mac_address 	= eth_mac_addr,
+	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= smsc95xx_ioctl,
 	.ndo_set_rx_mode	= smsc95xx_set_multicast,
@@ -1471,7 +1500,8 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 		/* link is down so enter EDPD mode, but only if device can
 		 * reliably resume from it.  This check should be redundant
 		 * as current FEATURE_REMOTE_WAKEUP parts also support
-		 * FEATURE_PHY_NLP_CROSSOVER but it's included for clarity */
+		 * FEATURE_PHY_NLP_CROSSOVER but it's included for clarity
+		 */
 		if (!(pdata->features & FEATURE_PHY_NLP_CROSSOVER)) {
 			netdev_warn(dev->net, "EDPD not supported\n");
 			return -EBUSY;
@@ -1922,11 +1952,11 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
  */
 static bool smsc95xx_can_tx_checksum(struct sk_buff *skb)
 {
-       unsigned int len = skb->len - skb_checksum_start_offset(skb);
+	unsigned int len = skb->len - skb_checksum_start_offset(skb);
 
-       if (skb->len <= 45)
-	       return false;
-       return skb->csum_offset < (len - (4 + 1));
+	if (skb->len <= 45)
+		return false;
+	return skb->csum_offset < (len - (4 + 1));
 }
 
 static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
@@ -1955,7 +1985,8 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	if (csum) {
 		if (!smsc95xx_can_tx_checksum(skb)) {
 			/* workaround - hardware tx checksum does not work
-			 * properly with extremely small packets */
+			 * properly with extremely small packets
+			 */
 			long csstart = skb_checksum_start_offset(skb);
 			__wsum calc = csum_partial(skb->data + csstart,
 				skb->len - csstart, 0);
-- 
2.25.1


