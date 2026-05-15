Return-Path: <netdev+bounces-288240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIJzHGneBmp4ogIAu9opvQ
	(envelope-from <netdev+bounces-288240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E858754BBC9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 756D03135F76
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC118410D18;
	Fri, 15 May 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MtT9m1+d"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403D40759A
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834335; cv=none; b=dx/ZFWyBzPUnWz/9ZOkwExpceotz8DKObtSy8u50eFk8z8SGI0Mq9LaLLap/1RApDQIYwQsdHlqK6xKRZijvEDwoprNukimngL4Gba4xaw/KoGya1HIcDW8iTjV7nsd0m6aSG4tElSM2zfcmrhUaZgaoSi2qI6f2Tmhjb5IBx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834335; c=relaxed/simple;
	bh=3LxElBOxJLRd9Q4qi4cg2fOh9USgK7YBzXtsouHkZ7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8MssKO9FVXuWF0wq5aoxg5WB824CwfCkC8hNLSQkcOlwXDvXYE+9sj6ihLRJN49oCZmQBMBo29qMNyTtkXQfoMxz8ut6blkQ3N6rlHNT/qohQuyqoIF2Lr4EPNvNhD9gxXHgjI4ZBVzhba+wyjqbDIKy1nBwOvcbpbpmsuEXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MtT9m1+d; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7CF091A35DF;
	Fri, 15 May 2026 08:38:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B7D3606FD;
	Fri, 15 May 2026 08:38:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D427311AF8FC9;
	Fri, 15 May 2026 10:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778834330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ju3/kyVC5648lwOekB1EhFgUY0zqwPy+KKgsrhJfkEo=;
	b=MtT9m1+dmENun/kKK6WBJXL9D7nPK9j136Z/HzObOEiSwnUQ/+V8WAV6YoL4KJ60Wwq7oR
	jx4hoRWsg5RghiIqxlRzO9v7eNIxbbTRxy0W8NyfSZWyLi3E8wnHsNoKCiW3IjWXpnBJTJ
	viW79Bv/OTW9rUesFfl6oXrDGuigMXD+8H7cYQHstWzCIP+Vqb/jpjVccWSwM5VHjx1GAH
	FCYkbOafWYYX+jOc6+He7RG465RZ4guBrhYRyDha2yb5egQxviuyB0/FVVqC+SllIbNMYt
	vnePmGkEAzO5eEEax6/19S8RrIqHewXXZ9FsJyhPUQm5/tFPWHZqkCgSwAlFww==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 15 May 2026 10:38:37 +0200
Subject: [PATCH net-next v2 2/8] net: dsa: microchip: bypass
 dev_ops->setup() and teardown() for lan937x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-clean-ksz-2nd-series-v2-2-35a968a739f6@bootlin.com>
References: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
In-Reply-To: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: E858754BBC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The KSZ switch families are sufficiently different that a common
ds->ops->setup() - ksz_setup() with micro-managed dev_ops->reset(),
dev_ops->pcs_create(), dev_ops->config_cpu_port(),
dev_ops->enable_stp_addr(), dev_ops->setup() seems to be too convoluted.

I am proposing to make each KSZ switch family part ways for
dsa_switch_ops :: setup() and teardown(), to allow them greater
flexibility. This here is the implementation for lan937x, which is
nothing other than a copy of ksz_setup() with the dev_ops function
pointers replaced with direct function calls.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c   |  12 ++--
 drivers/net/dsa/microchip/ksz_common.h   |   6 ++
 drivers/net/dsa/microchip/lan937x_main.c | 116 ++++++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 78d77a60a6ce2..c2624b1930f51 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2488,7 +2488,7 @@ static int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
  *
  * Return: 0 on success, or a negative error code on failure.
  */
-static int ksz_mdio_register(struct ksz_device *dev)
+int ksz_mdio_register(struct ksz_device *dev)
 {
 	struct device_node *parent_bus_node;
 	struct mii_bus *parent_bus = NULL;
@@ -2644,7 +2644,7 @@ static const struct irq_domain_ops ksz_irq_domain_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-static void ksz_irq_free(struct ksz_irq *kirq)
+void ksz_irq_free(struct ksz_irq *kirq)
 {
 	int irq, virq;
 
@@ -2713,7 +2713,7 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	return ret;
 }
 
-static int ksz_girq_setup(struct ksz_device *dev)
+int ksz_girq_setup(struct ksz_device *dev)
 {
 	struct ksz_irq *girq = &dev->girq;
 
@@ -2728,7 +2728,7 @@ static int ksz_girq_setup(struct ksz_device *dev)
 	return ksz_irq_common_setup(dev, girq);
 }
 
-static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
+int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 {
 	struct ksz_irq *pirq = &dev->ports[p].pirq;
 
@@ -2745,8 +2745,6 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
-static int ksz_parse_drive_strength(struct ksz_device *dev);
-
 int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -4698,7 +4696,7 @@ static int ksz88x3_drive_strength_write(struct ksz_device *dev,
  *
  * Return: 0 on success, error code otherwise
  */
-static int ksz_parse_drive_strength(struct ksz_device *dev)
+int ksz_parse_drive_strength(struct ksz_device *dev)
 {
 	struct ksz_driver_strength_prop of_props[] = {
 		[KSZ_DRIVER_STRENGTH_HI] = {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 1cdb6661729a6..5fad56c2d067a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -518,6 +518,12 @@ int ksz_hsr_leave(struct dsa_switch *ds, int port,
 int ksz_suspend(struct dsa_switch *ds);
 int ksz_resume(struct dsa_switch *ds);
 
+int ksz_mdio_register(struct ksz_device *dev);
+int ksz_pirq_setup(struct ksz_device *dev, u8 p);
+int ksz_girq_setup(struct ksz_device *dev);
+void ksz_irq_free(struct ksz_irq *kirq);
+int ksz_parse_drive_strength(struct ksz_device *dev);
+
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
 {
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 778e32f568df4..ecb072cd99819 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -626,8 +626,49 @@ static int lan937x_switch_init(struct ksz_device *dev)
 static int lan937x_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	u16 storm_mask, storm_rate;
+	struct dsa_port *dp;
+	struct ksz_port *p;
+	const u16 *regs;
 	int ret;
 
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = lan937x_reset_switch(dev);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset switch\n");
+		return ret;
+	}
+
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
+
+	/* set broadcast storm protection 10% rate */
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	lan937x_config_cpu_port(ds);
+
+	ksz9477_enable_stp_addr(dev);
+
+	ds->num_tx_queues = dev->info->num_tx_queues;
+
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
+			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
+
+	ksz_init_mib_timer(dev);
+
+	ds->configure_vlan_while_not_filtering = false;
+	ds->dscp_prio_mapping_is_global = true;
+
 	/* The VLAN aware is a global setting. Mixed vlan
 	 * filterings are not supported.
 	 */
@@ -659,13 +700,71 @@ static int lan937x_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Disable global VPHY support. Related to CPU interface only? */
-	return ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE,
-			 SW_VPHY_DISABLE);
-}
+	ret = ksz_rmw32(dev, REG_SW_CFG_STRAP_OVR, SW_VPHY_DISABLE,
+			SW_VPHY_DISABLE);
+	if (ret < 0)
+		return ret;
 
-static void lan937x_teardown(struct dsa_switch *ds)
-{
+	/* Start with learning disabled on standalone user ports, and enabled
+	 * on the CPU port. In lack of other finer mechanisms, learning on the
+	 * CPU port will avoid flooding bridge local addresses on the network
+	 * in some cases.
+	 */
+	p = &dev->ports[dev->cpu_port];
+	p->learning = true;
 
+	if (dev->irq > 0) {
+		ret = ksz_girq_setup(dev);
+		if (ret)
+			return ret;
+
+		dsa_switch_for_each_user_port(dp, dev->ds) {
+			ret = ksz_pirq_setup(dev, dp->index);
+			if (ret)
+				goto port_release;
+
+			ret = ksz_ptp_irq_setup(ds, dp->index);
+			if (ret)
+				goto pirq_release;
+		}
+	}
+
+	ret = ksz_ptp_clock_register(ds);
+	if (ret) {
+		dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+			ret);
+		goto port_release;
+	}
+
+	ret = ksz_mdio_register(dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to register the mdio");
+		goto out_ptp_clock_unregister;
+	}
+
+	ret = ksz_dcb_init(dev);
+	if (ret)
+		goto out_ptp_clock_unregister;
+
+	/* start switch */
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
+			   SW_START, SW_START);
+
+	return 0;
+
+out_ptp_clock_unregister:
+	ksz_ptp_clock_unregister(ds);
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
+			ksz_irq_free(&dev->ports[dp->index].pirq);
+		}
+		ksz_irq_free(&dev->girq);
+	}
+
+	return ret;
 }
 
 static enum dsa_tag_protocol lan937x_get_tag_protocol(struct dsa_switch *ds,
@@ -698,8 +797,6 @@ const struct phylink_mac_ops lan937x_phylink_mac_ops = {
 };
 
 const struct ksz_dev_ops lan937x_dev_ops = {
-	.setup = lan937x_setup,
-	.teardown = lan937x_teardown,
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
 	.port_setup = lan937x_port_setup,
@@ -713,10 +810,7 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.freeze_mib = ksz9477_freeze_mib,
 	.port_init_cnt = ksz9477_port_init_cnt,
 	.setup_rgmii_delay = lan937x_setup_rgmii_delay,
-	.config_cpu_port = lan937x_config_cpu_port,
 	.tc_cbs_set_cinc = lan937x_tc_cbs_set_cinc,
-	.enable_stp_addr = ksz9477_enable_stp_addr,
-	.reset = lan937x_reset_switch,
 	.init = lan937x_switch_init,
 };
 
@@ -724,7 +818,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_tag_protocol	= lan937x_get_tag_protocol,
 	.connect_tag_protocol   = lan937x_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= lan937x_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,

-- 
2.53.0


