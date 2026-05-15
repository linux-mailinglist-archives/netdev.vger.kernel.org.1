Return-Path: <netdev+bounces-288241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEzXBo7eBmp4ogIAu9opvQ
	(envelope-from <netdev+bounces-288241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D154BBE6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75CE8313B422
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719D41324C;
	Fri, 15 May 2026 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xUkPqnYa"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AB410D2F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834338; cv=none; b=YOGsdoQLX8di+YQrab5TjQSPVfN/FPz7TRSPpxz+UL2l/wWUJgFvF0iw+wouUG57O/5ZJbDDxexohJcAAKydM+F5ic8SlT6YG0cPmMRMblwjMsIv2VvC1mC6khvM0bi4gz+O6aGcdZNLcXDh8Sj0xxVUwARw2uYNa6t+d+/Azz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834338; c=relaxed/simple;
	bh=ZKfxWajAxYQs1sfsZ9MJXJTY63iDTlUlFlRAAn53PaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3shrFbYyTvfhvbR5iEJtw3Cqa1O/vG6cVP1+IoXfzQVaxS/VB++sWuUgCFbzTOvPQIzxHiZ3Y4V4HrYit6sIkNJgaESbMRIShCwBAS0fV07NSa1P2euU+lCPdiPvM6gHm3GF7/4MWdAB5i3DEJ+Ddpl5h6liPYoqAK8kqb9Kig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xUkPqnYa; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 598894E42CAC;
	Fri, 15 May 2026 08:38:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F115606FD;
	Fri, 15 May 2026 08:38:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26C0611AF8DB0;
	Fri, 15 May 2026 10:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778834333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PdhuDCwcMhUVRIDe9AhfDuhFhu55EzwmwPrb4Ns3vJA=;
	b=xUkPqnYau+DYyuv8aB942+lZ/jYJI54gCBn/oytJ2MRTYtmlMJ/Uqz7A32zxk0MSyOHJA9
	prWhU8VoSpqQs0n0+ILB6pbuCSnvz6jpCryPR/HhNItSKosOFVl1HZOUTGFBE1Ku8S/qqf
	veUZPcHjkQnl1HAkZ/jYoPqR4T7HfBSHkIMrFnNIrLhfjjt7JwKA15NZ6KOiLgia1ZxudF
	8hkl5XWSOkQ5I7gsK1AEeMGXl1dRL5Agah2BcCOpwgvGNtjH6VWud/S3Vzhip4GJ4QdGUW
	wGQ4mFGD3cqz0G73x4ymrXKXjN1EwIaorgpm3RRkAU/IW4aAV3UNmXs9rl9UfQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 15 May 2026 10:38:38 +0200
Subject: [PATCH net-next v2 3/8] net: dsa: microchip: bypass
 dev_ops->setup() and teardown() for ksz9477
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-clean-ksz-2nd-series-v2-3-35a968a739f6@bootlin.com>
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
X-Rspamd-Queue-Id: AC1D154BBE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288241-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The KSZ switch families are sufficiently different that a common
ds->ops->setup() - ksz_setup() with micro-managed dev_ops->reset(),
dev_ops->pcs_create(), dev_ops->config_cpu_port(),
dev_ops->enable_stp_addr(), dev_ops->setup() seems to be too convoluted.

I am proposing to make each KSZ switch family part ways for
dsa_switch_ops :: setup() and teardown(), to allow them greater
flexibility. This here is the implementation for ksz9477, which is
nothing other than a copy of ksz_setup() with the dev_ops function
pointers replaced with direct function calls.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 127 +++++++++++++++++++++++++++++++++---
 1 file changed, 118 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 88a5ff62aae89..7385aa4e788a1 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1477,9 +1477,54 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 static int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
-	const u16 *regs = dev->info->regs;
-	int ret = 0;
+	u16 storm_mask, storm_rate;
+	struct dsa_port *dp;
+	struct ksz_port *p;
+	const u16 *regs;
+	int ret;
+
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = ksz9477_reset_switch(dev);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset switch\n");
+		return ret;
+	}
+
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
 
+	if (ksz_has_sgmii_port(dev)) {
+		ret = ksz9477_pcs_create(dev);
+		if (ret)
+			return ret;
+	}
+
+	/* set broadcast storm protection 10% rate */
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	ksz9477_config_cpu_port(ds);
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
 	ds->mtu_enforcement_ingress = true;
 
 	/* Required for port partitioning. */
@@ -1512,7 +1557,76 @@ static int ksz9477_setup(struct dsa_switch *ds)
 	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
 	 * do not like PME events changes before shutdown.
 	 */
-	return ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
+	ret = ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
+	if (ret < 0)
+		return ret;
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
 
 u32 ksz9477_get_port_addr(int port, int offset)
@@ -1779,7 +1893,6 @@ const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 };
 
 const struct ksz_dev_ops ksz9477_dev_ops = {
-	.setup = ksz9477_setup,
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
 	.port_setup = ksz9477_port_setup,
@@ -1793,19 +1906,15 @@ const struct ksz_dev_ops ksz9477_dev_ops = {
 	.pme_write8 = ksz_write8,
 	.pme_pread8 = ksz_pread8,
 	.pme_pwrite8 = ksz_pwrite8,
-	.config_cpu_port = ksz9477_config_cpu_port,
 	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
-	.enable_stp_addr = ksz9477_enable_stp_addr,
-	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
-	.pcs_create = ksz9477_pcs_create,
 };
 
 const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_tag_protocol	= ksz9477_get_tag_protocol,
 	.connect_tag_protocol   = ksz9477_connect_tag_protocol,
 	.get_phy_flags		= ksz_get_phy_flags,
-	.setup			= ksz_setup,
+	.setup			= ksz9477_setup,
 	.teardown		= ksz_teardown,
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,

-- 
2.53.0


