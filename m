Return-Path: <netdev+bounces-99717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9578D60A0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152F1C23CCB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A63156257;
	Fri, 31 May 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Haw/SstV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FA315099E
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154787; cv=none; b=poJFmen1gOeWj0E0//Ft5s1FBbkTYS7/s1bpYxSOMeHCrjg9UHfmmv3yQHYB9n69vy5JLmIy95sE5RxA6ufCiT/pBnVvNW27933Yz2YZz610E98ztOLvuIlJIoTTXTHLODFAu1LfsVTaTXPbFXHNg/g8h2Z0UsKfR0bVnBJ3SMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154787; c=relaxed/simple;
	bh=C0A5OQyluwnMYYlitivCEeBs4mWj5PBKfb3lv3BhyQY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=M/8eywyzkRKjZarxnXlrSt3qt0vKQV+u3GWek+qXZNTtLvK6uh21XRErvHs5SUU3RENjILVGBNZFaZY5AN2k/yBBMnwLh1kYdKfoPi42Qx8yu9Mi4WsVrwYhA0JQEeAVahuDCsiMFRvG21LsasFBNdwK+gP+0r568YyNADTeXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Haw/SstV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=znBvrxbm5XBULWEnnD42FCLop5RMvOAuJY+uJBUOxaI=; b=Haw/SstVgRX+H7bIgQQKSGKSsr
	78W61r+U1sACYCStLTNEQq9f9iUK1APsKsyOTGFKLWjpkMh6xJRNqT8r3CM9kXdXwQmC9YyvY50kr
	A74JKm0wqo5BtNZV+zIR1D6ik8fGOjY5i4bYkN4c1jhemHw4vEoyx7xKUtvmC/teRwDL0m9LCjGfZ
	oOHcI2vdCHA4HE7c9xC//IwO4A+NVR5Xg2xRypTo63AB8WCBK1DlrYvYbTQ7M5mjwzhgHEdUxlR3B
	zNLd1P6UifVyDejDSzfszqdx84iD+TUaUC5FntuXrOBd9F4X6XTGlavRQ/QlFOOey8ZBXJiw9269C
	woJEn7og==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38408 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sD0Oi-0008RI-0u;
	Fri, 31 May 2024 12:26:12 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sD0Ol-00EzBh-3f; Fri, 31 May 2024 12:26:15 +0100
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC net-next v2 1/8] net: stmmac: add infrastructure for hwifs
 to provide PCS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sD0Ol-00EzBh-3f@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 12:26:15 +0100

Allow hwifs to provide a phylink_select_pcs() implementation via struct
stmmac_ops, which can be used to provide a phylink PCS.

Code analysis shows that when STMMAC_FLAG_HAS_INTEGRATED_PCS is set,
then:

	stmmac_common_interrupt()
	stmmac_ethtool_set_link_ksettings()
	stmmac_ethtool_get_link_ksettings()

will all ignore the presence of the PCS. The latter two will pass the
ethtool commands to phylink. The former will avoid manipulating the
netif carrier state behind phylink's back based on the PCS status.

This flag is only set by the ethqos driver. From what I can tell,
amongst the current kernel DT files that use the ethqos driver, only
sa8775p-ride.dts enables ethernet, and this defines a SGMII-mode link
to its PHYs without the "managed" property. Thus, phylink will be
operating in MLO_AN_PHY mode, and inband mode will not be used.

Therefore, it is safe to ignore the STMMAC_FLAG_HAS_INTEGRATED_PCS
flag in stmmac_mac_select_pcs().

Further code analysis shows that XPCS is used by Intel for Cisco
SGMII and 1000base-X modes. In this case, we do not want to provide
the integrated PCS, but the XPCS. The same appears to also be true
of the Lynx PCS.

Therefore, it seems that the integrated PCS provided by the hwif MAC
code should only be used when an external PCS is not being used, so
give priority to the external PCS.

Provide a phylink_pcs instance in struct mac_device_info for hwifs to
use to provide their phylink PCS.

Omit the non-phylink PCS code paths when a hwif provides a
phylink_select_pcs() method (in other words, when they are converted to
use a phylink PCS.) This provides a way to transition parts of the
driver in the subsequent patches.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  9 ++++++++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 19 +++++++++++++++++--
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 12 ++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index cd36ff4da68c..940e83fa1202 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -14,7 +14,7 @@
 #include <linux/etherdevice.h>
 #include <linux/netdevice.h>
 #include <linux/stmmac.h>
-#include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/module.h>
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
@@ -591,6 +591,7 @@ struct mac_device_info {
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
+	struct phylink_pcs mac_pcs;	/* The MAC's RGMII/SGMII "PCS" */
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
@@ -611,6 +612,12 @@ struct mac_device_info {
 	bool hw_vlan_en;
 };
 
+static inline struct mac_device_info *
+phylink_pcs_to_mac_dev_info(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct mac_device_info, mac_pcs);
+}
+
 struct stmmac_rx_routing {
 	u32 reg_mask;
 	u32 reg_shift;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 97934ccba5b1..aa5f6e40cb53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -5,6 +5,7 @@
 #ifndef __STMMAC_HWIF_H__
 #define __STMMAC_HWIF_H__
 
+#include <linux/err.h>
 #include <linux/netdevice.h>
 #include <linux/stmmac.h>
 
@@ -17,13 +18,17 @@
 	} \
 	__result; \
 })
-#define stmmac_do_callback(__priv, __module, __cname,  __arg0, __args...) \
+#define stmmac_do_typed_callback(__type, __fail_ret, __priv, __module, \
+				 __cname,  __arg0, __args...) \
 ({ \
-	int __result = -EINVAL; \
+	__type __result = __fail_ret; \
 	if ((__priv)->hw->__module && (__priv)->hw->__module->__cname) \
 		__result = (__priv)->hw->__module->__cname((__arg0), ##__args); \
 	__result; \
 })
+#define stmmac_do_callback(__priv, __module, __cname,  __arg0, __args...) \
+	stmmac_do_typed_callback(int, -EINVAL, __priv, __module, __cname, \
+				 __arg0, ##__args)
 
 struct stmmac_extra_stats;
 struct stmmac_priv;
@@ -310,6 +315,9 @@ struct stmmac_ops {
 	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
 	/* Update MAC capabilities */
 	void (*update_caps)(struct stmmac_priv *priv);
+	/* Get phylink PCS (for MAC */
+	struct phylink_pcs *(*phylink_select_pcs)(struct stmmac_priv *priv,
+						  phy_interface_t interface);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -431,6 +439,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, core_init, __args)
 #define stmmac_mac_update_caps(__priv) \
 	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
+#define stmmac_mac_phylink_select_pcs(__priv, __interface) \
+	stmmac_do_typed_callback(struct phylink_pcs *, ERR_PTR(-EOPNOTSUPP), \
+				 __priv, mac, phylink_select_pcs, __priv,\
+				 __interface)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
@@ -530,6 +542,9 @@ struct stmmac_ops {
 #define stmmac_fpe_irq_status(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
 
+#define stmmac_has_mac_phylink_select_pcs(__priv) \
+	((__priv)->hw->mac->phylink_select_pcs != NULL)
+
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 18468c0228f0..7c6530d63ade 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -323,7 +323,8 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 
 	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
 	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
-	     priv->hw->pcs & STMMAC_PCS_SGMII)) {
+	     priv->hw->pcs & STMMAC_PCS_SGMII) &&
+	    !stmmac_has_mac_phylink_select_pcs(priv)) {
 		struct rgmii_adv adv;
 		u32 supported, advertising, lp_advertising;
 
@@ -410,7 +411,8 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 
 	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
 	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
-	     priv->hw->pcs & STMMAC_PCS_SGMII)) {
+	     priv->hw->pcs & STMMAC_PCS_SGMII) &&
+	    !stmmac_has_mac_phylink_select_pcs(priv)) {
 		/* Only support ANE */
 		if (cmd->base.autoneg != AUTONEG_ENABLE)
 			return -EINVAL;
@@ -523,7 +525,8 @@ stmmac_get_pauseparam(struct net_device *netdev,
 	struct stmmac_priv *priv = netdev_priv(netdev);
 	struct rgmii_adv adv_lp;
 
-	if (priv->hw->pcs && !stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv_lp)) {
+	if (priv->hw->pcs && !stmmac_has_mac_phylink_select_pcs(priv) &&
+	    !stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv_lp)) {
 		pause->autoneg = 1;
 		if (!adv_lp.pause)
 			return;
@@ -539,7 +542,8 @@ stmmac_set_pauseparam(struct net_device *netdev,
 	struct stmmac_priv *priv = netdev_priv(netdev);
 	struct rgmii_adv adv_lp;
 
-	if (priv->hw->pcs && !stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv_lp)) {
+	if (priv->hw->pcs && !stmmac_has_mac_phylink_select_pcs(priv) &&
+	   !stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv_lp)) {
 		pause->autoneg = 1;
 		if (!adv_lp.pause)
 			return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bbedf2a8c60f..56c351e11952 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -953,7 +953,10 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 	if (priv->hw->xpcs)
 		return &priv->hw->xpcs->pcs;
 
-	return priv->hw->phylink_pcs;
+	if (priv->hw->phylink_pcs)
+		return priv->hw->phylink_pcs;
+
+	return stmmac_mac_phylink_select_pcs(priv, interface);
 }
 
 static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
@@ -3482,7 +3485,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		}
 	}
 
-	if (priv->hw->pcs)
+	if (priv->hw->pcs && !stmmac_has_mac_phylink_select_pcs(priv))
 		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, priv->hw->ps, 0);
 
 	/* set TX and RX rings length */
@@ -6052,7 +6055,8 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 
 		/* PCS link status */
 		if (priv->hw->pcs &&
-		    !(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)) {
+		    !(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
+		    !stmmac_has_mac_phylink_select_pcs(priv)) {
 			if (priv->xstats.pcs_link)
 				netif_carrier_on(priv->dev);
 			else
-- 
2.30.2


