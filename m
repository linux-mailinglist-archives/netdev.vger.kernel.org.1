Return-Path: <netdev+bounces-144968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8709C8E91
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE921F28233
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263E1AC88A;
	Thu, 14 Nov 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jyhMgyjQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3C19CC0F;
	Thu, 14 Nov 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598578; cv=none; b=A/8sL28cAbn8BJ0Vhv+1Aed3hJAfjDkS9gJ/nb9z1oLJSR4wV3MpFYP/jnbN9IUjDW89pGa7UWBGi02SsaEDTMd6g2QD5zRi4KjhVa3Cgwxil9TMudK0TydsxLcMk6WJ+vu1ey99asSHFiXSS/zNtN+yZjTdPCc4MeTPMvftqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598578; c=relaxed/simple;
	bh=891f4ChfUy9ld15ZISZhA05VjzAsC22sOsxxWTgB5Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ostaMsULgSmHxCoFBMpUy0bjSrp/cpivmmVbkCQoS7NISs1QLVUmX12X21PaME89WwN2GRWalv8UW4aw9YiNUYe3+PDGXqvLCf7WI66ahCABiMJDc9g9L3Mrm2ldCXxIExbR0EGVEobe+UMdfjIlSxa+PD26pulfdFMqd4wqO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jyhMgyjQ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCCF41BF20F;
	Thu, 14 Nov 2024 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kW6y+es3PhkNN7oGJsip9taWxcOyK0imTW0mpB6Vpt4=;
	b=jyhMgyjQNphFcbuLgQ6JC1+lbRGUxfdG4uDocbUbLs17d7Ri+vicdK2NWyAeH5ocBKOeoA
	JnzTJmcXNkr+r04mVeBO1rpKs48cpUyBnctnmpp05hqZl+VDLz5MnFzrcP7PaRHtSV0EvG
	dcQN0mBSUB7offJ2AcNuCryTChJ/6/ASYFwZ5ObKIaTYcMfMg1QrjnMo6rizwcNxljTWWB
	yDLDHTxai7n2A1BUO0PZUoV60C5+slZPC43E5ZdgDGYmOiHcRGLBw9Y5Z6b5Jc0sdoZrTJ
	Ka2d6qSd8BUT7LFZym0IwS4VAT9vxbJu1B1UPgf4tkTgAfoZrzmcJ3DQAXgibA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 03/10] net: freescale: ucc_geth: Use netdev->phydev to access the PHY
Date: Thu, 14 Nov 2024 16:35:54 +0100
Message-ID: <20241114153603.307872-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

As this driver pre-dates phylib, it uses a private pointer to get a
reference to the attached phy_device. Drop that pointer and use the
netdev's pointer instead.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: No changes

 drivers/net/ethernet/freescale/ucc_geth.c     | 27 ++++++++-----------
 drivers/net/ethernet/freescale/ucc_geth.h     |  1 -
 .../net/ethernet/freescale/ucc_geth_ethtool.c | 17 ++++++------
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 6286cd185a35..13b8f8401c81 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1646,7 +1646,7 @@ static void ugeth_link_down(struct ucc_geth_private *ugeth)
 static void adjust_link(struct net_device *dev)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
-	struct phy_device *phydev = ugeth->phydev;
+	struct phy_device *phydev = dev->phydev;
 
 	if (phydev->link)
 		ugeth_link_up(ugeth, phydev, phydev->interface,
@@ -1727,8 +1727,6 @@ static int init_phy(struct net_device *dev)
 
 	phy_set_max_speed(phydev, priv->max_speed);
 
-	priv->phydev = phydev;
-
 	return 0;
 }
 
@@ -2001,7 +1999,7 @@ static void ucc_geth_set_multi(struct net_device *dev)
 static void ucc_geth_stop(struct ucc_geth_private *ugeth)
 {
 	struct ucc_geth __iomem *ug_regs = ugeth->ug_regs;
-	struct phy_device *phydev = ugeth->phydev;
+	struct phy_device *phydev = ugeth->ndev->phydev;
 
 	ugeth_vdbg("%s: IN", __func__);
 
@@ -3316,13 +3314,13 @@ static int ucc_geth_open(struct net_device *dev)
 		goto err;
 	}
 
-	phy_start(ugeth->phydev);
+	phy_start(dev->phydev);
 	napi_enable(&ugeth->napi);
 	netdev_reset_queue(dev);
 	netif_start_queue(dev);
 
 	device_set_wakeup_capable(&dev->dev,
-			qe_alive_during_sleep() || ugeth->phydev->irq);
+			qe_alive_during_sleep() || dev->phydev->irq);
 	device_set_wakeup_enable(&dev->dev, ugeth->wol_en);
 
 	return err;
@@ -3343,8 +3341,7 @@ static int ucc_geth_close(struct net_device *dev)
 
 	cancel_work_sync(&ugeth->timeout_work);
 	ucc_geth_stop(ugeth);
-	phy_disconnect(ugeth->phydev);
-	ugeth->phydev = NULL;
+	phy_disconnect(dev->phydev);
 
 	free_irq(ugeth->ug_info->uf_info.irq, ugeth->ndev);
 
@@ -3378,7 +3375,7 @@ static void ucc_geth_timeout_work(struct work_struct *work)
 		ucc_geth_stop(ugeth);
 		ucc_geth_init_mac(ugeth);
 		/* Must start PHY here */
-		phy_start(ugeth->phydev);
+		phy_start(dev->phydev);
 		netif_tx_start_all_queues(dev);
 	}
 
@@ -3421,7 +3418,7 @@ static int ucc_geth_suspend(struct platform_device *ofdev, pm_message_t state)
 		setbits32(&ugeth->ug_regs->maccfg2, MACCFG2_MPE);
 		ucc_fast_enable(ugeth->uccf, COMM_DIR_RX_AND_TX);
 	} else if (!(ugeth->wol_en & WAKE_PHY)) {
-		phy_stop(ugeth->phydev);
+		phy_stop(ndev->phydev);
 	}
 
 	return 0;
@@ -3461,8 +3458,8 @@ static int ucc_geth_resume(struct platform_device *ofdev)
 	ugeth->oldspeed = 0;
 	ugeth->oldduplex = -1;
 
-	phy_stop(ugeth->phydev);
-	phy_start(ugeth->phydev);
+	phy_stop(ndev->phydev);
+	phy_start(ndev->phydev);
 
 	napi_enable(&ugeth->napi);
 	netif_device_attach(ndev);
@@ -3477,15 +3474,13 @@ static int ucc_geth_resume(struct platform_device *ofdev)
 
 static int ucc_geth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct ucc_geth_private *ugeth = netdev_priv(dev);
-
 	if (!netif_running(dev))
 		return -EINVAL;
 
-	if (!ugeth->phydev)
+	if (!dev->phydev)
 		return -ENODEV;
 
-	return phy_mii_ioctl(ugeth->phydev, rq, cmd);
+	return phy_mii_ioctl(dev->phydev, rq, cmd);
 }
 
 static const struct net_device_ops ucc_geth_netdev_ops = {
diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 4294ed096ebb..c08a56b7c9fe 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -1210,7 +1210,6 @@ struct ucc_geth_private {
 	u16 skb_dirtytx[NUM_TX_QUEUES];
 
 	struct ugeth_mii_info *mii_info;
-	struct phy_device *phydev;
 	phy_interface_t phy_interface;
 	int max_speed;
 	uint32_t msg_enable;
diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index 699f346faf5c..fb5254d7d1ba 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -103,8 +103,7 @@ static const char rx_fw_stat_gstrings[][ETH_GSTRING_LEN] = {
 static int
 uec_get_ksettings(struct net_device *netdev, struct ethtool_link_ksettings *cmd)
 {
-	struct ucc_geth_private *ugeth = netdev_priv(netdev);
-	struct phy_device *phydev = ugeth->phydev;
+	struct phy_device *phydev = netdev->phydev;
 
 	if (!phydev)
 		return -ENODEV;
@@ -118,8 +117,7 @@ static int
 uec_set_ksettings(struct net_device *netdev,
 		  const struct ethtool_link_ksettings *cmd)
 {
-	struct ucc_geth_private *ugeth = netdev_priv(netdev);
-	struct phy_device *phydev = ugeth->phydev;
+	struct phy_device *phydev = netdev->phydev;
 
 	if (!phydev)
 		return -ENODEV;
@@ -132,8 +130,10 @@ uec_get_pauseparam(struct net_device *netdev,
                      struct ethtool_pauseparam *pause)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
+	struct phy_device *phydev = netdev->phydev;
 
-	pause->autoneg = ugeth->phydev->autoneg;
+	if (phydev)
+		pause->autoneg = phydev->autoneg;
 
 	if (ugeth->ug_info->receiveFlowControl)
 		pause->rx_pause = 1;
@@ -146,12 +146,13 @@ uec_set_pauseparam(struct net_device *netdev,
                      struct ethtool_pauseparam *pause)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
+	struct phy_device *phydev = netdev->phydev;
 	int ret = 0;
 
 	ugeth->ug_info->receiveFlowControl = pause->rx_pause;
 	ugeth->ug_info->transmitFlowControl = pause->tx_pause;
 
-	if (ugeth->phydev->autoneg) {
+	if (phydev && phydev->autoneg) {
 		if (netif_running(netdev)) {
 			/* FIXME: automatically restart */
 			netdev_info(netdev, "Please re-open the interface\n");
@@ -343,7 +344,7 @@ uec_get_drvinfo(struct net_device *netdev,
 static void uec_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
-	struct phy_device *phydev = ugeth->phydev;
+	struct phy_device *phydev = netdev->phydev;
 
 	if (phydev && phydev->irq)
 		wol->supported |= WAKE_PHY;
@@ -356,7 +357,7 @@ static void uec_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 static int uec_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
-	struct phy_device *phydev = ugeth->phydev;
+	struct phy_device *phydev = netdev->phydev;
 
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
-- 
2.47.0


