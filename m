Return-Path: <netdev+bounces-287145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJeaEScsA2pI1QEAu9opvQ
	(envelope-from <netdev+bounces-287145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:33:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42392521423
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA23030874E4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C13B5DFD;
	Tue, 12 May 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IKJNSF+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837733B2D3D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591224; cv=none; b=fz/PbC0bT14869d4OhvUQLVgsYgJFGk/RgYrrQ31gKuseVe+TK8+zGT8nlymDvfIa5cQVDSlUy8c2oYasNxF67/MD3XrH6NVD6cWlE6cPW3iHrFFnSLpYXQG9c9ETwUDFzyNgsRK82TfnJ4vPnv4TyHiCGhL2mTztd4b+XV6Y34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591224; c=relaxed/simple;
	bh=ll46DGOyhjsJvmihlV5o0j5gGJoeA0LP/URMNEHa6Zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dEBq8eblydOM5mK2JsqLdCEY8mz6/LTh1TNjV9/9SZrp77ommQY0X4sFSwTPurhxerOgvJ0shf16S489otSJvJ/x0CSohgFaOmAF70gkjQtkVsW0DY8ipdgOiXOqMejJGGGWm4ZbIPLrVbFPTF2BhdNHyGrnhukWcCwCd1R4i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IKJNSF+a; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 742D9C5E17B;
	Tue, 12 May 2026 13:07:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 795A560646;
	Tue, 12 May 2026 13:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D2C711AF8CD2;
	Tue, 12 May 2026 15:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591220; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zlhduSZrPeOgu/P9X7lc6Qzasj1anHxVDOvRSMRYXuU=;
	b=IKJNSF+a+ir/XKKzROMdERJMMWGtPQzDaWrcRq7Idlye2WdDJQ3KB7+wgonWWcbjqs07nx
	7HsxzWSGZRaO7HPDej4Qm1vfRlappXhwqdCY/7MdgDcMyoPRMH4y/JcX1GEdlpgF3ah1rX
	diu9ZbmjMd0D+cNA7ianMUXdf2Hu0driDRjZ+IFt4siJJT+pJds2WbT6GVgx74s6R0BBGv
	CYpSoV6dpaDjegLl+/0VVwGuMv5UmvcgRzURROkh/kieg4Dmiw+Tu592/2ynruPaQbGGEz
	5fCEEeaQ2gUVSN1k3QltSdgDFc5HHAG32VDFDHaso7puLg/SKJmtKl6njCd3hA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:34 +0200
Subject: [PATCH net-next 12/15] net: dsa: microchip: remove
 dev_ops->setup() and teardown()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-12-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
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
X-Rspamd-Queue-Id: 42392521423
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

From: Vladimir Oltean <vladimir.oltean@nxp.com>

All switch families have been converted to have their own
ds->ops->setup() methods and to call the common ksz_teardown().

Remove the no longer used ksz_setup() function and the associated
ksz_dev_ops callbacks.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 133 ---------------------------------
 drivers/net/dsa/microchip/ksz_common.h |   8 --
 2 files changed, 141 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c2624b1930f51..60edb02846481 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2745,136 +2745,6 @@ int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
-int ksz_setup(struct dsa_switch *ds)
-{
-	struct ksz_device *dev = ds->priv;
-	u16 storm_mask, storm_rate;
-	struct dsa_port *dp;
-	struct ksz_port *p;
-	const u16 *regs;
-	int ret;
-
-	regs = dev->info->regs;
-
-	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
-				       dev->info->num_vlans, GFP_KERNEL);
-	if (!dev->vlan_cache)
-		return -ENOMEM;
-
-	ret = dev->dev_ops->reset(dev);
-	if (ret) {
-		dev_err(ds->dev, "failed to reset switch\n");
-		return ret;
-	}
-
-	ret = ksz_parse_drive_strength(dev);
-	if (ret)
-		return ret;
-
-	if (ksz_has_sgmii_port(dev) && dev->dev_ops->pcs_create) {
-		ret = dev->dev_ops->pcs_create(dev);
-		if (ret)
-			return ret;
-	}
-
-	/* set broadcast storm protection 10% rate */
-	storm_mask = BROADCAST_STORM_RATE;
-	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
-	if (ksz_is_ksz8463(dev)) {
-		storm_mask = swab16(storm_mask);
-		storm_rate = swab16(storm_rate);
-	}
-	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
-			   storm_mask, storm_rate);
-
-	dev->dev_ops->config_cpu_port(ds);
-
-	dev->dev_ops->enable_stp_addr(dev);
-
-	ds->num_tx_queues = dev->info->num_tx_queues;
-
-	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
-			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
-
-	ksz_init_mib_timer(dev);
-
-	ds->configure_vlan_while_not_filtering = false;
-	ds->dscp_prio_mapping_is_global = true;
-
-	if (dev->dev_ops->setup) {
-		ret = dev->dev_ops->setup(ds);
-		if (ret)
-			return ret;
-	}
-
-	/* Start with learning disabled on standalone user ports, and enabled
-	 * on the CPU port. In lack of other finer mechanisms, learning on the
-	 * CPU port will avoid flooding bridge local addresses on the network
-	 * in some cases.
-	 */
-	p = &dev->ports[dev->cpu_port];
-	p->learning = true;
-
-	if (dev->irq > 0) {
-		ret = ksz_girq_setup(dev);
-		if (ret)
-			return ret;
-
-		dsa_switch_for_each_user_port(dp, dev->ds) {
-			ret = ksz_pirq_setup(dev, dp->index);
-			if (ret)
-				goto port_release;
-
-			if (dev->info->ptp_capable) {
-				ret = ksz_ptp_irq_setup(ds, dp->index);
-				if (ret)
-					goto pirq_release;
-			}
-		}
-	}
-
-	if (dev->info->ptp_capable) {
-		ret = ksz_ptp_clock_register(ds);
-		if (ret) {
-			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
-				ret);
-			goto port_release;
-		}
-	}
-
-	ret = ksz_mdio_register(dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "failed to register the mdio");
-		goto out_ptp_clock_unregister;
-	}
-
-	ret = ksz_dcb_init(dev);
-	if (ret)
-		goto out_ptp_clock_unregister;
-
-	/* start switch */
-	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
-			   SW_START, SW_START);
-
-	return 0;
-
-out_ptp_clock_unregister:
-	if (dev->info->ptp_capable)
-		ksz_ptp_clock_unregister(ds);
-port_release:
-	if (dev->irq > 0) {
-		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
-			if (dev->info->ptp_capable)
-				ksz_ptp_irq_free(ds, dp->index);
-pirq_release:
-			ksz_irq_free(&dev->ports[dp->index].pirq);
-		}
-		ksz_irq_free(&dev->girq);
-	}
-
-	return ret;
-}
-
 void ksz_teardown(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2893,9 +2763,6 @@ void ksz_teardown(struct dsa_switch *ds)
 
 		ksz_irq_free(&dev->girq);
 	}
-
-	if (dev->dev_ops->teardown)
-		dev->dev_ops->teardown(ds);
 }
 
 static void port_r_cnt(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5fad56c2d067a..f80034488cd1b 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -359,8 +359,6 @@ struct alu_struct {
 };
 
 struct ksz_dev_ops {
-	int (*setup)(struct dsa_switch *ds);
-	void (*teardown)(struct dsa_switch *ds);
 	u32 (*get_port_addr)(int port, int offset);
 	void (*cfg_port_member)(struct ksz_device *dev, int port, u8 member);
 	void (*port_setup)(struct ksz_device *dev, int port, bool cpu_port);
@@ -417,12 +415,7 @@ struct ksz_dev_ops {
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
 	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
 	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
-	void (*config_cpu_port)(struct dsa_switch *ds);
-	int (*enable_stp_addr)(struct ksz_device *dev);
-	int (*reset)(struct ksz_device *dev);
 	int (*init)(struct ksz_device *dev);
-
-	int (*pcs_create)(struct ksz_device *dev);
 };
 
 struct ksz_device *ksz_switch_alloc(struct device *base,
@@ -433,7 +426,6 @@ void ksz_switch_remove(struct ksz_device *dev);
 int ksz_switch_suspend(struct device *dev);
 int ksz_switch_resume(struct device *dev);
 
-int ksz_setup(struct dsa_switch *ds);
 void ksz_teardown(struct dsa_switch *ds);
 int ksz_port_setup(struct dsa_switch *ds, int port);
 void ksz_port_teardown(struct dsa_switch *ds, int port);

-- 
2.53.0


