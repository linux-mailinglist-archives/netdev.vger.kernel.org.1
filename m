Return-Path: <netdev+bounces-290845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD6HKDtfEGoxWwYAu9opvQ
	(envelope-from <netdev+bounces-290845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E845B584D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F13B31B75ED
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740853B0AEA;
	Fri, 22 May 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLk8zUKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C93A9854;
	Fri, 22 May 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456122; cv=none; b=jCVJrIE+TCUiY/1Q80AhaG68y1lszUVxz0Pm9UOPOrxCHFRxmOw9oaAlFBvOb3fJLYBLZptJOusOvMIhRbirtCHnjOREPd0dKLJsQKVWfbuiqU+51V83L/z7kLeQsMxPiXysHgQ/ECePq9b6Q0ixpaGPyDkU85t8cRrtR++bykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456122; c=relaxed/simple;
	bh=mKE5A72cuiiPMZFuXVgOjGYdifEFvOKPVrTqn4IplPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7bEn6S2jqHSTDDutyTWxoFmr2vkXQUGka2Cul6bziZ4zg+gqfycrtYnjpuXY8OivYRh5iNlhMQxIixeiJfd4n2MnRFfnEf56coUApZgigKRRF5gSE/NUZHj1jw6yISV7nFZDaOGt6lvFnxgMAAnr1uNVk79LaTOpqqpku45D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLk8zUKs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B181F00A3D;
	Fri, 22 May 2026 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456116;
	bh=bV/xHBHDyVMUxtarmnhur+JFfVXSx0vdtFNvjoRsX7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TLk8zUKs6y/0Oxsy/456Ut6KyR1h5W+aY9rBmXFQYP/CeJP/jyg9Gq3Om8hNUQ6vx
	 IF1eQLH3/1c1+HLZN17ZG6h2xZM9vFcA2KeLOi1rgBXX/wW56c+/pMtm7mfLmeDUGO
	 vCXW+KU+OKV73xwR87MCJIJZV5QWUwzA4ETheZdPXKx4v+bjCK7M8eRSL3GvIddEGg
	 Xsmob89kBD7BWCb06/CMyyxoAcq91kHxaCe4gZD8sNlfLe7yPflwwWq1A8Ax8zXQoc
	 sbm7i1haFkFKkXdCniJMR5pG6mT2n4SR4o3t1vALzmh37AKCSxoEraZ7sHQWjP9e5H
	 mkyk1qeCg1IoQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 22 May 2026 15:21:26 +0200
Subject: [PATCH net-next v2 4/5] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-ks8995-to-ksz8-v2-4-5712c0dc9e75@kernel.org>
References: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
In-Reply-To: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290845-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92E845B584D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds support for the Microchip KSZ8995XA also known as the
Micrel KS8995XA switch to the KSZ driver.

Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
different from the KSZ8995XA.

The helper macros are named ksz_is_ksz8995xa() to make it
possible to add E and MA support in the future.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/Kconfig           |   1 +
 drivers/net/dsa/microchip/ksz8.c            | 166 +++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8.h            |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h        |   7 ++
 drivers/net/dsa/microchip/ksz_common.c      |  70 ++++++++++--
 drivers/net/dsa/microchip/ksz_common.h      |  11 +-
 drivers/net/dsa/microchip/ksz_spi.c         |  18 ++-
 include/linux/platform_data/microchip-ksz.h |   1 +
 8 files changed, 238 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index c71d3fd5dfeb..75c9b2114afd 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -2,6 +2,7 @@
 menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
 	tristate "Microchip KSZ8XXX/KSZ9XXX/LAN937X series switch support"
 	depends on NET_DSA
+	select NET_DSA_TAG_KS8995
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
 	select NET_IEEE8021Q_HELPERS
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 825133e9ce6e..82e528c7e8d0 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -3,6 +3,7 @@
  * Microchip KSZ8XXX series switch driver
  *
  * It supports the following switches:
+ * - KSZ8995XA (the oldest ancestor)
  * - KSZ8463
  * - KSZ8863, KSZ8873 aka KSZ88X3
  * - KSZ8895, KSZ8864 aka KSZ8895 family
@@ -137,7 +138,18 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
 
 static int ksz8_reset_switch(struct ksz_device *dev)
 {
-	if (ksz_is_ksz88x3(dev)) {
+	if (ksz_is_ksz8995xa(dev)) {
+		unsigned int port;
+
+		/* KSZ8995XA is "reset" by stopping the switch and starting it */
+		ksz_cfg(dev, REG_SW_ID_1, SW_START_SWITCH, false);
+		usleep_range(10, 100);
+		ksz_cfg(dev, REG_SW_ID_1, SW_START_SWITCH, true);
+
+		/* Often boot loaders have fun with ports, so reset them */
+		for (port = 0; port < dev->info->port_cnt; port++)
+			ksz_port_cfg(dev, port, 0x0f, BIT(4), true);
+	} else if (ksz_is_ksz88x3(dev)) {
 		/* reset switch */
 		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
@@ -161,8 +173,14 @@ static int ksz8_reset_switch(struct ksz_device *dev)
 static int ksz8863_change_mtu(struct ksz_device *dev, int frame_size)
 {
 	u8 ctrl2 = 0;
+	unsigned int legalsz;
+
+	if (ksz_is_ksz8995xa(dev))
+		legalsz = KSZ8995XA_LEGAL_PACKET_SIZE;
+	else
+		legalsz = KSZ8_LEGAL_PACKET_SIZE;
 
-	if (frame_size <= KSZ8_LEGAL_PACKET_SIZE)
+	if (frame_size <= legalsz)
 		ctrl2 |= KSZ8863_LEGAL_PACKET_ENABLE;
 	else if (frame_size > KSZ8863_NORMAL_PACKET_SIZE)
 		ctrl2 |= KSZ8863_HUGE_PACKET_ENABLE;
@@ -207,6 +225,7 @@ static int ksz8_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
+	case KSZ8995XA_CHIP_ID:
 		return ksz8863_change_mtu(dev, frame_size);
 	}
 
@@ -826,6 +845,10 @@ static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)
 	if (reg_val & PORT_MDIX_STATUS)
 		*val |= KSZ886X_CTRL_MDIX_STAT;
 
+	/* KSZ8995XA has no fancy features in register 0xA */
+	if (ksz_is_ksz8995xa(dev))
+		return 0;
+
 	ret = ksz_pread8(dev, port, REG_PORT_LINK_MD_CTRL, &reg_val);
 	if (ret < 0)
 		return ret;
@@ -924,8 +947,10 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, u16 port, u16 *val)
 	if (ctrl & PORT_FORCE_FULL_DUPLEX)
 		*val |= BMCR_FULLDPLX;
 
-	if (speed & PORT_HP_MDIX)
-		*val |= KSZ886X_BMCR_HP_MDIX;
+	if (!ksz_is_ksz8995xa(dev)) {
+		if (speed & PORT_HP_MDIX)
+			*val |= KSZ886X_BMCR_HP_MDIX;
+	}
 
 	if (restart & PORT_FORCE_MDIX)
 		*val |= KSZ886X_BMCR_FORCE_MDI;
@@ -1020,6 +1045,9 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 			data |= LPA_LPACK;
 		break;
 	case PHY_REG_LINK_MD:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		ret = ksz_pread8(dev, p, REG_PORT_LINK_MD_CTRL, &val1);
 		if (ret)
 			return ret;
@@ -1134,13 +1162,15 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 	if (val & BMCR_RESET)
 		return 0;
 
-	speed = 0;
-	if (val & KSZ886X_BMCR_HP_MDIX)
-		speed |= PORT_HP_MDIX;
+	if (!ksz_is_ksz8995xa(dev)) {
+		speed = 0;
+		if (val & KSZ886X_BMCR_HP_MDIX)
+			speed |= PORT_HP_MDIX;
 
-	ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
-	if (ret)
-		return ret;
+		ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
+		if (ret)
+			return ret;
+	}
 
 	ctrl = 0;
 	if (ksz_is_ksz88x3(dev)) {
@@ -1250,11 +1280,17 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		}
 		break;
 	case PHY_REG_LINK_MD:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		if (val & PHY_START_CABLE_DIAG)
 			ksz_port_cfg(dev, p, REG_PORT_LINK_MD_CTRL, PORT_START_CABLE_DIAG, true);
 		break;
 
 	case PHY_REG_PHY_CTRL:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		ret = ksz8_w_phy_ctrl(dev, p, val);
 		if (ret)
 			return ret;
@@ -1452,7 +1488,7 @@ static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev) || ksz_is_ksz8995xa(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -1668,14 +1704,16 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		offset = P1CR1;
 	ksz_port_cfg(dev, port, offset, PORT_BROADCAST_STORM, true);
 
-	ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
+	if (!ksz_is_ksz8995xa(dev)) {
+		ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
 
-	/* replace priority */
-	offset = P_802_1P_CTRL;
-	if (ksz_is_ksz8463(dev))
-		offset = P1CR2;
-	ksz_port_cfg(dev, port, offset,
-		     masks[PORT_802_1P_REMAPPING], false);
+		/* replace priority */
+		offset = P_802_1P_CTRL;
+		if (ksz_is_ksz8463(dev))
+			offset = P1CR2;
+		ksz_port_cfg(dev, port, offset,
+			     masks[PORT_802_1P_REMAPPING], false);
+	}
 
 	if (cpu_port)
 		member = dsa_user_ports(ds);
@@ -1684,6 +1722,19 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	ksz8_cfg_port_member(dev, port, member);
 
+	if (ksz_is_ksz8995xa(dev)) {
+		/*
+		 * The KSZ8995XA has a special tag format in the front of the frame
+		 * that need to be inserted by the CPU and then removed by each
+		 * port. PORT_REMOVE_TAG simply means "remove tags coming from the
+		 * CPU port" it does not affect ingress packets.
+		 */
+		if (cpu_port)
+			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_INSERT_TAG, true);
+		else
+			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_REMOVE_TAG, true);
+	}
+
 	/* Disable all WoL options by default. Otherwise
 	 * ksz_switch_macaddr_get/put logic will not work properly.
 	 * CPU port 4 has no WoL functionality.
@@ -1720,7 +1771,9 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 	masks = dev->info->masks;
 	regs = dev->info->regs;
 
-	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+	/* KSZ8995XA uses a tag in the header instead of the tail */
+	if (!ksz_is_ksz8995xa(dev))
+		ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
 
 	ksz8_port_setup(dev, dev->cpu_port, true);
 
@@ -1922,6 +1975,10 @@ static int ksz8_enable_stp_addr(struct ksz_device *dev)
 {
 	struct alu_struct alu;
 
+	/* KSZ8995XA lacks STP */
+	if (ksz_is_ksz8995xa(dev))
+		return 0;
+
 	/* Setup STP address for STP operation. */
 	memset(&alu, 0, sizeof(alu));
 	ether_addr_copy(alu.mac, eth_stp_addr);
@@ -1937,6 +1994,7 @@ static int ksz8_setup(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
 	int i, ret = 0;
+	u8 val;
 
 	ds->mtu_enforcement_ingress = true;
 
@@ -1962,9 +2020,10 @@ static int ksz8_setup(struct dsa_switch *ds)
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
 	 */
-	ret = ksz_rmw8(dev, REG_SW_CTRL_2,
-		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
-		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	val = NO_EXC_COLLISION_DROP;
+	if (!ksz_is_ksz8995xa(dev))
+		val |= UNICAST_VLAN_BOUNDARY;
+	ret = ksz_rmw8(dev, REG_SW_CTRL_2, val, val);
 	if (ret)
 		return ret;
 
@@ -1972,11 +2031,15 @@ static int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
+	if (ksz_is_ksz8995xa(dev))
+		ksz_cfg(dev, REG_SW_CTRL_9, SW_SPECIAL_TAG, true);
+	else if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
-	for (i = 0; i < (dev->info->num_vlans / 4); i++)
-		ksz8_r_vlan_entries(dev, i);
+	if (!ksz_is_ksz8995xa(dev)) {
+		for (i = 0; i < (dev->info->num_vlans / 4); i++)
+			ksz8_r_vlan_entries(dev, i);
+	}
 
 	/* Make sure PME (WoL) is not enabled. If requested, it will
 	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
@@ -2114,6 +2177,13 @@ static void ksz8_switch_exit(struct ksz_device *dev)
 	ksz8_reset_switch(dev);
 }
 
+static enum dsa_tag_protocol ksz8995xa_get_tag_protocol(struct dsa_switch *ds,
+							int port,
+							enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_KS8995;
+}
+
 static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -2210,6 +2280,24 @@ const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
+/*
+ * The KS(Z)8995XA has no indirect access, meaning no MIB counters,
+ * no FDB access, and no VLAN handling.
+ */
+const struct ksz_dev_ops ksz8995xa_dev_ops = {
+	.setup = ksz8_setup,
+	.get_port_addr = ksz8_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.port_setup = ksz8_port_setup,
+	.r_phy = ksz8_r_phy,
+	.w_phy = ksz8_w_phy,
+	.config_cpu_port = ksz8_config_cpu_port,
+	.enable_stp_addr = ksz8_enable_stp_addr,
+	.reset = ksz8_reset_switch,
+	.init = ksz8_switch_init,
+	.exit = ksz8_switch_exit,
+};
+
 const struct ksz_dev_ops ksz8463_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8463_get_port_addr,
@@ -2273,6 +2361,34 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.pme_pwrite8 = ksz8_pme_pwrite8,
 };
 
+/*
+ * Restricted operations for KSZ8995XA, so many things are not supported
+ * by this old switch that we need diet DSA operations.
+ */
+const struct dsa_switch_ops ksz8995xa_switch_ops = {
+	.get_tag_protocol	= ksz8995xa_get_tag_protocol,
+	.get_phy_flags		= ksz_get_phy_flags,
+	.setup			= ksz_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz_phy_read16,
+	.phy_write		= ksz_phy_write16,
+	.phylink_get_caps	= ksz8_phylink_get_caps,
+	.port_setup		= ksz_port_setup,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_teardown		= ksz_port_teardown,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz8_flush_dyn_mac_table,
+	.port_mirror_add	= ksz8_port_mirror_add,
+	.port_mirror_del	= ksz8_port_mirror_del,
+	.port_change_mtu	= ksz8_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	/* TODO: add .port_get/set_apptrust() when we implement priority */
+};
+
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index bc371cc26c6f..9b37c56c9617 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -12,11 +12,13 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
+extern const struct ksz_dev_ops ksz8995xa_dev_ops;
 extern const struct ksz_dev_ops ksz8463_dev_ops;
 extern const struct ksz_dev_ops ksz87xx_dev_ops;
 extern const struct ksz_dev_ops ksz88xx_dev_ops;
 extern const struct phylink_mac_ops ksz88x3_phylink_mac_ops;
 extern const struct phylink_mac_ops ksz8_phylink_mac_ops;
+extern const struct dsa_switch_ops ksz8995xa_switch_ops;
 extern const struct dsa_switch_ops ksz8463_switch_ops;
 extern const struct dsa_switch_ops ksz87xx_switch_ops;
 extern const struct dsa_switch_ops ksz88xx_switch_ops;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 332408567b47..2a1f6dd53b9d 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -30,6 +30,11 @@
 #define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
 #define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
 
+#define REG_SW_ID_0			0x00
+#define REG_SW_ID_1			0x01
+
+#define SW_START_SWITCH			BIT(0)
+
 #define REG_SW_CTRL_0			0x02
 
 #define SW_NEW_BACKOFF			BIT(7)
@@ -95,6 +100,8 @@
 #define SW_LED_LINK_ACT_DUPLEX		2
 #define SW_LED_LINK_DUPLEX		3
 
+#define SW_SPECIAL_TAG			BIT(0) /* KSZ8995XA only */
+
 #define REG_SW_CTRL_10			0x0C
 
 #define SW_PASS_PAUSE			BIT(0)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 4a7bcd1a9392..7f514064116a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -554,6 +554,20 @@ static const u8 ksz8895_shifts[] = {
 	[DYNAMIC_MAC_SRC_PORT]		= 24,
 };
 
+static const u16 ksz8995xa_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x68,
+	[P_FORCE_CTRL]			= 0x0C,
+	[P_LINK_STATUS]			= 0x0E,
+	[P_LOCAL_CTRL]			= 0x0C,
+	[P_NEG_RESTART_CTRL]		= 0x0D,
+	[P_REMOTE_STATUS]		= 0x0E,
+	[P_SPEED_STATUS]		= 0x09,
+	[P_STP_CTRL]			= 0x02,
+	[S_START_CTRL]			= 0x01,
+	[S_BROADCAST_CTRL]		= 0x06,
+	[S_MULTICAST_CTRL]		= 0x04,
+};
+
 static const u16 ksz9477_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x0302,
 	[P_STP_CTRL]			= 0x0B04,
@@ -1485,6 +1499,21 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 	},
 
+	[KSZ8995XA] = {
+		.chip_id = KSZ8995XA_CHIP_ID, /* Also known as KS8995XA */
+		.dev_name = "KSZ8995XA",
+		.cpu_ports = 0x10,	/* can be configured as cpu port */
+		.port_cnt = 5,		/* total cpu and user ports */
+		.num_tx_queues = 4,
+		.num_ipms = 4,
+		.ops = &ksz8995xa_dev_ops,
+		.switch_ops = &ksz8995xa_switch_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
+		.regs = ksz8995xa_regs,
+		.supports_mii = {true, true, true, true, true},
+		.internal_phy = {true, true, true, true, false},
+	},
+
 	[KSZ9477] = {
 		.chip_id = KSZ9477_CHIP_ID,
 		.dev_name = "KSZ9477",
@@ -2850,9 +2879,15 @@ int ksz_setup(struct dsa_switch *ds)
 		goto out_ptp_clock_unregister;
 	}
 
-	ret = ksz_dcb_init(dev);
-	if (ret)
-		goto out_ptp_clock_unregister;
+	/* TODO: the KSZ8995XA does have TOS priority control registers albeit
+	 * 7 instead of 15 and in a different location. Revisit this and attempt
+	 * to enable DCB on the KS8995XA.
+	 */
+	if (!ksz_is_ksz8995xa(dev)) {
+		ret = ksz_dcb_init(dev);
+		if (ret)
+			goto out_ptp_clock_unregister;
+	}
 
 	/* start switch */
 	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
@@ -2965,6 +3000,10 @@ void ksz_init_mib_timer(struct ksz_device *dev)
 {
 	int i;
 
+	/* KSZ8995XA lacks MiB features */
+	if (ksz_is_ksz8995xa(dev))
+		return;
+
 	INIT_DELAYED_WORK(&dev->mib_read, ksz_mib_read_work);
 
 	for (i = 0; i < dev->info->port_cnt; i++) {
@@ -3238,6 +3277,7 @@ int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
+	case KSZ8995XA_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8563_CHIP_ID:
 	case KSZ8567_CHIP_ID:
@@ -3504,11 +3544,15 @@ static int ksz_switch_detect(struct ksz_device *dev)
 			return -ENODEV;
 		break;
 	case KSZ8895_FAMILY_ID:
-		if (id2 == KSZ8895_CHIP_ID_95 ||
-		    id2 == KSZ8895_CHIP_ID_95R)
+		if (id2 == KSZ8895_CHIP_ID_95XA) {
+			dev->chip_id = KSZ8995XA_CHIP_ID;
+			break;
+		} else if (id2 == KSZ8895_CHIP_ID_95 ||
+			   id2 == KSZ8895_CHIP_ID_95R) {
 			dev->chip_id = KSZ8895_CHIP_ID;
-		else
+		} else {
 			return -ENODEV;
+		}
 		ret = ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
 		if (ret)
 			return ret;
@@ -4864,6 +4908,10 @@ int ksz_switch_register(struct ksz_device *dev)
 	if (ret)
 		return ret;
 
+	/* Override ops with something simpler for this legacy chip */
+	if (ksz_is_ksz8995xa(dev))
+		dev->ds->ops = &ksz8995xa_switch_ops;
+
 	dev->dev_ops = dev->info->ops;
 
 	ret = dev->dev_ops->init(dev);
@@ -4948,11 +4996,13 @@ int ksz_switch_register(struct ksz_device *dev)
 		return ret;
 	}
 
-	/* Read MIB counters every 30 seconds to avoid overflow. */
-	dev->mib_read_interval = msecs_to_jiffies(5000);
+	if (!ksz_is_ksz8995xa(dev)) {
+		/* Read MIB counters every 30 seconds to avoid overflow. */
+		dev->mib_read_interval = msecs_to_jiffies(5000);
 
-	/* Start the MIB timer. */
-	schedule_delayed_work(&dev->mib_read, 0);
+		/* Start the MIB timer. */
+		schedule_delayed_work(&dev->mib_read, 0);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f6dad256a550..98ba1eff13cb 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -235,6 +235,7 @@ enum ksz_model {
 	KSZ88X3,
 	KSZ8864,
 	KSZ8895,
+	KSZ8995XA,
 	KSZ9477,
 	KSZ9896,
 	KSZ9897,
@@ -759,7 +760,13 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 static inline bool ksz_is_8895_family(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8895_CHIP_ID ||
-	       dev->chip_id == KSZ8864_CHIP_ID;
+	       dev->chip_id == KSZ8864_CHIP_ID ||
+	       dev->chip_id == KSZ8995XA_CHIP_ID;
+}
+
+static inline bool ksz_is_ksz8995xa(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8995XA_CHIP_ID;
 }
 
 static inline bool is_ksz8(struct ksz_device *dev)
@@ -830,6 +837,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ87_CHIP_ID_94		0x6
 #define KSZ87_CHIP_ID_95		0x9
 #define KSZ88_CHIP_ID_63		0x3
+#define KSZ8895_CHIP_ID_95XA		0x0
 #define KSZ8895_CHIP_ID_95		0x4
 #define KSZ8895_CHIP_ID_95R		0x6
 
@@ -893,6 +901,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ8863_HUGE_PACKET_SIZE	1916
 #define KSZ8863_NORMAL_PACKET_SIZE	1536
 #define KSZ8_LEGAL_PACKET_SIZE		1518
+#define KSZ8995XA_LEGAL_PACKET_SIZE	1522
 #define KSZ9477_MAX_FRAME_SIZE		9000
 
 #define KSZ8873_REG_GLOBAL_CTRL_12	0x0e
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 77aecac32466..2c55014246e5 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -161,7 +161,8 @@ static int ksz_spi_probe(struct spi_device *spi)
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
 		regmap_config = ksz8795_regmap_config;
-	else if (chip->chip_id == KSZ8895_CHIP_ID ||
+	else if (chip->chip_id == KSZ8995XA_CHIP_ID ||
+		 chip->chip_id == KSZ8895_CHIP_ID ||
 		 chip->chip_id == KSZ8864_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
 	else
@@ -185,7 +186,10 @@ static int ksz_spi_probe(struct spi_device *spi)
 		dev->pdata = spi->dev.platform_data;
 
 	/* setup spi */
-	spi->mode = SPI_MODE_3;
+	if (chip->chip_id == KSZ8995XA_CHIP_ID)
+		spi->mode = SPI_MODE_0;
+	else
+		spi->mode = SPI_MODE_3;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;
@@ -239,6 +243,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "micrel,ksz8795",
 		.data = &ksz_switch_chips[KSZ8795]
 	},
+	{
+		.compatible = "micrel,ks8995",
+		.data = &ksz_switch_chips[KSZ8995XA]
+	},
 	{
 		.compatible = "microchip,ksz8463",
 		.data = &ksz_switch_chips[KSZ8463]
@@ -271,6 +279,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,ksz8895",
 		.data = &ksz_switch_chips[KSZ8895]
 	},
+	{
+		.compatible = "microchip,ksz8995xa",
+		.data = &ksz_switch_chips[KSZ8995XA]
+	},
 	{
 		.compatible = "microchip,ksz9477",
 		.data = &ksz_switch_chips[KSZ9477]
@@ -332,6 +344,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);
 
 static const struct spi_device_id ksz_spi_ids[] = {
+	{ "ks8995" },
 	{ "ksz8463" },
 	{ "ksz8765" },
 	{ "ksz8794" },
@@ -340,6 +353,7 @@ static const struct spi_device_id ksz_spi_ids[] = {
 	{ "ksz8864" },
 	{ "ksz8873" },
 	{ "ksz8895" },
+	{ "ksz8995" },
 	{ "ksz9477" },
 	{ "ksz9896" },
 	{ "ksz9897" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 028781ad4059..d8eddd21c3c7 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -31,6 +31,7 @@ enum ksz_chip_id {
 	KSZ88X3_CHIP_ID = 0x8830,
 	KSZ8864_CHIP_ID = 0x8864,
 	KSZ8895_CHIP_ID = 0x8895,
+	KSZ8995XA_CHIP_ID = 0x8995,
 	KSZ9477_CHIP_ID = 0x00947700,
 	KSZ9896_CHIP_ID = 0x00989600,
 	KSZ9897_CHIP_ID = 0x00989700,

-- 
2.54.0


