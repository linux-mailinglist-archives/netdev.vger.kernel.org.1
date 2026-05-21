Return-Path: <netdev+bounces-290246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGmnNYqjDmpxAwYAu9opvQ
	(envelope-from <netdev+bounces-290246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C359F5B5
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F128830D432A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE514393DE9;
	Thu, 21 May 2026 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U9o+ZvT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A42392C5F
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343981; cv=none; b=GWodz6P6+cKAJPpunWFqGte74kK51aLtBVbstX7brh4g+49vYCYHebpp0WX5YeF0L21HLaloMOMfm7yyPKbaVaOnrbqwCRiIL0jBc51AQjUbHd0hixdLGv0gie3RDwBYygdwjgsNgMxXyV7kgwN8GGdTlzGLWs/8Pp37dmKdlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343981; c=relaxed/simple;
	bh=jrCjh6Gf7mvqfUCo/Z+WojGkoMK+qVYNKi2MK19UZDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1qgizXncw2TxZS1bImNOIBLOpKmhOH203IrEp8nmL3XOgs9zqiqoK1t4v1+mDQ+GEUQLltTz07rw36NnNtnZ5OFAvtgzhAPOGdIBjd614PvGfIOOBZPX4ynh2UybQbUlPCt0iFAYk9vCetC9/EpYK3bUK946sSSJidip1G2PBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U9o+ZvT0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 933A54E42D17;
	Thu, 21 May 2026 06:12:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6767D60718;
	Thu, 21 May 2026 06:12:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DD57107EA6B7;
	Thu, 21 May 2026 08:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779343973; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AqtCy147yU/f+Lx+VwPk3eev5t8Y0ZJDO+q3HAMz+74=;
	b=U9o+ZvT0YszLH84e5C+wWY1yo02d5kSWKPg4rwlpoPzX/W6I83Am2THvUlKcsy6z10SnhA
	vL/N02oD7A6N8fEoNL/KenDEiG0mXYc7myIvMV6QRBGghR0Yn6ahMOiF00XoXSDMX/XYGs
	sh/GLVN2lAJ6NMUMIF/YN8AtIbOAVNVCPQt1XfGwoJxcarViSJOrhV8QK0UOvqLlSAlaFH
	W42zsK7n0oeeywFwu+goqk5YFCSNB1Bbvk2KH3wm4a92/0MdI/SU0WTVP/WDCsZGu1Li0v
	0i/ZdHosWsWbKxsgsBFs1g9LRtWkqKVaP/dE9JVX2T/BaNjy+iSFuawa0AKipQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:12:39 +0200
Subject: [PATCH net-next v3 4/8] net: dsa: microchip: bypass
 dev_ops->setup() and teardown() for ksz8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-clean-ksz-2nd-series-v3-4-75c38971c19a@bootlin.com>
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 375C359F5B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The KSZ switch families are sufficiently different that a common
ds->ops->setup() - ksz_setup() with micro-managed dev_ops->reset(),
dev_ops->pcs_create(), dev_ops->config_cpu_port(),
dev_ops->enable_stp_addr(), dev_ops->setup() seems to be too convoluted.

I am proposing to make each KSZ switch family part ways for
dsa_switch_ops :: setup() and teardown(), to allow them greater
flexibility. This here is the implementation for ksz8, which is
nothing other than a copy of ksz_setup() with the dev_ops function
pointers replaced with direct function calls.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 139 +++++++++++++++++++++++++++++++++------
 1 file changed, 119 insertions(+), 20 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index ccbc3480717f..acc898c68f98 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1935,9 +1935,52 @@ static int ksz8_enable_stp_addr(struct ksz_device *dev)
 static int ksz8_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
-	const u16 *regs = dev->info->regs;
-	int i, ret = 0;
+	u16 storm_mask, storm_rate;
+	struct dsa_port *dp;
+	struct ksz_port *p;
+	const u16 *regs;
+	int i, ret;
+
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = ksz8_reset_switch(dev);
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
+	if (ksz_is_ksz8463(dev)) {
+		storm_mask = swab16(storm_mask);
+		storm_rate = swab16(storm_rate);
+	}
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	ksz8_config_cpu_port(ds);
+
+	ksz8_enable_stp_addr(dev);
+
+	ds->num_tx_queues = dev->info->num_tx_queues;
+
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
+			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
+
+	ksz_init_mib_timer(dev);
 
+	ds->configure_vlan_while_not_filtering = false;
+	ds->dscp_prio_mapping_is_global = true;
 	ds->mtu_enforcement_ingress = true;
 
 	/* We rely on software untagging on the CPU port, so that we
@@ -1987,12 +2030,80 @@ static int ksz8_setup(struct dsa_switch *ds)
 		ret = ksz8_pme_write8(dev, regs[REG_SW_PME_CTRL], 0);
 		if (!ret)
 			ret = ksz_rmw8(dev, REG_INT_ENABLE, INT_PME, 0);
+		if (ret)
+			return ret;
 	}
 
-	if (!ret)
-		return ksz8_handle_global_errata(ds);
-	else
+	ret = ksz8_handle_global_errata(ds);
+	if (ret)
 		return ret;
+
+	/* Start with learning disabled on standalone user ports, and enabled
+	 * on the CPU port. In lack of other finer mechanisms, learning on the
+	 * CPU port will avoid flooding bridge local addresses on the network
+	 * in some cases.
+	 */
+	p = &dev->ports[dev->cpu_port];
+	p->learning = true;
+
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
+			if (dev->info->ptp_capable) {
+				ret = ksz_ptp_irq_setup(ds, dp->index);
+				if (ret)
+					goto pirq_release;
+			}
+		}
+	}
+
+	if (dev->info->ptp_capable) {
+		ret = ksz_ptp_clock_register(ds);
+		if (ret) {
+			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
+				ret);
+			goto port_release;
+		}
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
+	if (dev->info->ptp_capable)
+		ksz_ptp_clock_unregister(ds);
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
+			ksz_irq_free(&dev->ports[dp->index].pirq);
+		}
+		ksz_irq_free(&dev->girq);
+	}
+
+	return ret;
 }
 
 static void ksz8_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -2206,7 +2317,6 @@ const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 };
 
 const struct ksz_dev_ops ksz8463_dev_ops = {
-	.setup = ksz8_setup,
 	.get_port_addr = ksz8463_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
 	.port_setup = ksz8_port_setup,
@@ -2217,14 +2327,10 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.config_cpu_port = ksz8_config_cpu_port,
-	.enable_stp_addr = ksz8_enable_stp_addr,
-	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
 };
 
 const struct ksz_dev_ops ksz87xx_dev_ops = {
-	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
 	.port_setup = ksz8_port_setup,
@@ -2235,9 +2341,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.r_mib_stat64 = ksz_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.config_cpu_port = ksz8_config_cpu_port,
-	.enable_stp_addr = ksz8_enable_stp_addr,
-	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
@@ -2245,7 +2348,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 };
 
 const struct ksz_dev_ops ksz88xx_dev_ops = {
-	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
 	.port_setup = ksz8_port_setup,
@@ -2256,9 +2358,6 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
 	.freeze_mib = ksz8_freeze_mib,
 	.port_init_cnt = ksz8_port_init_cnt,
-	.config_cpu_port = ksz8_config_cpu_port,
-	.enable_stp_addr = ksz8_enable_stp_addr,
-	.reset = ksz8_reset_switch,
 	.init = ksz8_switch_init,
 	.pme_write8 = ksz8_pme_write8,
 	.pme_pread8 = ksz8_pme_pread8,
@@ -2269,7 +2368,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
@@ -2329,7 +2428,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_tag_protocol	= ksz87xx_get_tag_protocol,
 	.connect_tag_protocol   = ksz87xx_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
@@ -2389,7 +2488,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_tag_protocol	= ksz88xx_get_tag_protocol,
 	.connect_tag_protocol   = ksz88xx_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,

-- 
2.54.0


