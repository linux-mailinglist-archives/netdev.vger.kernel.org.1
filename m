Return-Path: <netdev+bounces-307038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ExXpLPmQVGq1nQMAu9opvQ
	(envelope-from <netdev+bounces-307038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:17:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10315747EE5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:17:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=tJF4JBmK;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307038-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307038-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 203AF305E399
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A636F8F1;
	Mon, 13 Jul 2026 07:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B716369D5D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926701; cv=none; b=oVaYV+OicS425oPafCmDfR9jPyBEBk2sFyqIU+YS0HBX8JWfxmraADZ+NkIl6a4uVwGVjW/gUUgZQ+qU5C3oVeGNxPJz7YPx2M1BD9wIbmmtYR/DRS3wzxteCEK1SnpvVm5/4VTpWAJs3LSRyJgoL5rG6jfP0TOAid0PAleAXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926701; c=relaxed/simple;
	bh=uLBsbgmaCtzWNPc7EFgj136/4QpNUYTi1s1We/t6BWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+/RIE4qOh6npTrg/KORH+Ep4ex2aW5uXn59yt5ZACL1t6eWk9wudSL/pt8TJjao6XUoMLghNzusK8tWmUCYpE/TGhZxMFSUo07hbNrAczzBTQy4HpTdcXFvUSkSswIt/jNrAbOkhtS+kTaEnLCVJtFUqZCXqOnFv7g0G7pYirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tJF4JBmK; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 11DC04E40D82;
	Mon, 13 Jul 2026 07:11:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA2A760341;
	Mon, 13 Jul 2026 07:11:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06F7411BD39F5;
	Mon, 13 Jul 2026 09:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926694; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ijrwmHBHgcyT5IDoh+XNYGuziVn49C8hIpQpFC8Cizo=;
	b=tJF4JBmKKE5kSrXv3bh8gDC9EDwMXFZmPGApwHIborlyJpG4ybK1XJBocgoBFH+5jiLjPW
	HUYpomybFwuhCmaM20TvRgj253hKPvBwAd1TWb9J1Q+NVk4mmfZNS0h13weSS3TjwoWhb1
	agNGxrDDL5uIj22ctImh6qHDpjob8Jjb68w3333QULQY3eezv4l4+t/lpHuzIrRL7/CQzu
	Sw9Z97seAR4XSBXrUXbRNd4YH3QMnDl5lXZE1qxLVaqxPk7CcSRJ/9uPaJ9Oy8L1sa/Dxf
	EghjqwQ59JnB3b6EhpbLiZsgN0TPD3R+zCvFShmiqeTblc7ooPBQrfAiuyqvKQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:23 +0200
Subject: [PATCH net-next v2 04/10] net: dsa: microchip: add PTP interrupt
 handling for KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-4-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307038-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10315747EE5

KSZ8463 PTP interrupts aren't handled by the driver.
The interrupt layout in KSZ8463 has nothing to do with the other
switches:
- Its global interrupt enable register is 16-bits long and follow an
  'enable' logic, instead of a 'mask' one
- all the interrupts of all ports are grouped into one status register
  while others have one interrupt register per port
- xdelay_req and pdresp timestamps share one single interrupt bit on the
  KSZ8463 while each of them has its own interrupt bit on other switches

Create a KSZ8463-specific set of interrupt domain operations to handle
the global IRQ layer. To limit code duplication, it uses the same
interrupt handler than the other switches. Since other switches have
8-bits registers, only the high-byte of the interrupt status/enable
registers are used. This high-byte is where the PTP interrupts are
located. The low-byte contains the wake-up detection interrupts so if at
some points these interrupts are needed we'll need a bit of rework here.

Create KSZ8463-specific functions to setup the PTP interrupts. The
created IRQ domain is tied to the first port of the KSZ8463. Again,
the same PTP interrupt handler than the others switches is used.

Implement the teardown callback to release the interrupts.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c        |  93 ++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.c     | 131 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 +++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |   6 ++
 4 files changed, 237 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 3bbca6f9cfc5..c099a7005808 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -36,6 +36,13 @@
 #include "ksz8_reg.h"
 #include "ksz8.h"
 
+/*
+ * We use only the high-byte (so odd addresses) of the 16-bits registers to fit
+ * in the common IRQ framework
+ */
+#define KSZ8463_REG_ISR			0x191
+#define KSZ8463_REG_IER			0x193
+
 /* ksz88x3_drive_strengths - Drive strength mapping for KSZ8863, KSZ8873, ..
  *			     variants.
  * This values are documented in KSZ8873 and KSZ8863 datasheets.
@@ -181,6 +188,58 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
 	return ksz8_ind_write8(dev, table, (u8)(offset), data);
 }
 
+static void ksz8463_irq_mask(struct irq_data *d)
+{
+	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
+
+	kirq->masked &= ~BIT(d->hwirq);
+}
+
+static void ksz8463_irq_unmask(struct irq_data *d)
+{
+	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
+
+	kirq->masked |= BIT(d->hwirq);
+}
+
+static const struct irq_chip ksz8463_irq_chip = {
+	.name			= "ksz8463-irq",
+	.irq_mask		= ksz8463_irq_mask,
+	.irq_unmask		= ksz8463_irq_unmask,
+	.irq_bus_lock		= ksz_irq_bus_lock,
+	.irq_bus_sync_unlock	= ksz_irq_bus_sync_unlock,
+};
+
+static int ksz8463_irq_domain_map(struct irq_domain *d,
+				  unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, d->host_data);
+	irq_set_chip_and_handler(irq, &ksz8463_irq_chip, handle_level_irq);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ksz8463_irq_domain_ops = {
+	.map	= ksz8463_irq_domain_map,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static int ksz8463_girq_setup(struct ksz_device *dev)
+{
+	struct ksz_irq *girq = &dev->girq;
+
+	girq->nirqs = 8;
+	girq->reg_mask = KSZ8463_REG_IER;
+	girq->reg_status = KSZ8463_REG_ISR;
+	girq->masked = 0;
+	snprintf(girq->name, sizeof(girq->name), "ksz8463-girq");
+
+	girq->irq_num = dev->irq;
+
+	return ksz_irq_common_setup(dev, girq, &ksz8463_irq_domain_ops);
+}
+
 static int ksz8463_reset_switch(struct ksz_device *dev)
 {
 	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
@@ -2407,21 +2466,50 @@ static int ksz8463_setup(struct dsa_switch *ds)
 	p = &dev->ports[dev->cpu_port];
 	p->learning = true;
 
+	if (dev->irq > 0) {
+		ret = ksz8463_girq_setup(dev);
+		if (ret)
+			return ret;
+
+		ret = ksz8463_ptp_irq_setup(ds);
+		if (ret)
+			goto free_girq;
+	}
+
 	ret = ksz_mdio_register(dev);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to register the mdio");
-		return ret;
+		goto free_ptp_irq;
 	}
 
 	ret = ksz_dcb_init(dev);
 	if (ret)
-		return ret;
+		goto free_ptp_irq;
 
 	/* start switch */
 	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
 			   SW_START, SW_START);
 
 	return 0;
+
+free_ptp_irq:
+	if (dev->irq > 0)
+		ksz8463_ptp_irq_free(ds);
+free_girq:
+	if (dev->irq > 0)
+		ksz_irq_free(&dev->girq);
+
+	return ret;
+}
+
+static void ksz8463_teardown(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->irq > 0) {
+		ksz8463_ptp_irq_free(ds);
+		ksz_irq_free(&dev->girq);
+	}
 }
 
 /**
@@ -3010,6 +3098,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
 	.setup			= ksz8463_setup,
+	.teardown		= ksz8463_teardown,
 	.phy_read		= ksz8463_phy_read16,
 	.phy_write		= ksz8463_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 8b98039320ad..89fbc1253f25 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -32,6 +32,15 @@
 
 #define KSZ_PTP_INT_START 13
 
+/*
+ * PTP interrupt bit is the bit 12 of the 16-bits ISR/IER. But ksz_common.c only
+ * accesses the high-byte of these registers so the PTP interrupt bit becomes 4.
+ */
+#define KSZ8463_SRC_PTP_INT		4
+#define KSZ8463_PTP_PORT1_INT_START	12
+#define KSZ8463_PTP_PORT2_INT_START	14
+#define KSZ8463_PTP_INT_START		KSZ8463_PTP_PORT1_INT_START
+
 static int ksz_ptp_tou_gpio(struct ksz_device *dev)
 {
 	int ret;
@@ -1129,6 +1138,128 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 	return ret;
 }
 
+static int ksz8463_ptp_port_irq_setup(struct ksz_irq *ptpirq,
+				      struct ksz_port *port, int hw_irq)
+{
+	u16 ts_reg[] = {KSZ8463_REG_PORT_SYNC_TS, KSZ8463_REG_PORT_DREQ_TS};
+	static const char * const name[] = {"sync-msg", "delay-msg"};
+	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
+	struct ksz_ptp_irq *ptpmsg_irq;
+	int ret;
+	int i;
+
+	init_completion(&port->tstamp_msg_comp);
+
+	for (i = 0; i < 2; i++) {
+		ptpmsg_irq = &port->ptpmsg_irq[i];
+		ptpmsg_irq->num = irq_create_mapping(ptpirq->domain,
+						     hw_irq + i);
+		if (!ptpmsg_irq->num) {
+			ret = -EINVAL;
+			goto release_msg_irq;
+		}
+
+		ptpmsg_irq->port = port;
+		ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[i]);
+
+		strscpy(ptpmsg_irq->name, name[i]);
+
+		ret = request_threaded_irq(ptpmsg_irq->num, NULL,
+					   ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
+					   ptpmsg_irq->name, ptpmsg_irq);
+		if (ret) {
+			irq_dispose_mapping(ptpmsg_irq->num);
+			goto release_msg_irq;
+		}
+	}
+
+	return 0;
+
+release_msg_irq:
+	while (i--)
+		ksz_ptp_msg_irq_free(port, i);
+
+	return ret;
+}
+
+static void ksz8463_ptp_port_irq_teardown(struct ksz_port *port)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		ksz_ptp_msg_irq_free(port, i);
+}
+
+int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *port1, *port2;
+	struct ksz_irq *ptpirq;
+	int ret;
+
+	port1 = &dev->ports[0];
+	port2 = &dev->ports[1];
+	ptpirq = &port1->ptpirq;
+
+	ptpirq->irq_num = irq_find_mapping(dev->girq.domain,
+					   KSZ8463_SRC_PTP_INT);
+	if (!ptpirq->irq_num)
+		return -EINVAL;
+
+	ptpirq->dev = dev;
+	ptpirq->nirqs = 4;
+	ptpirq->reg_mask = KSZ8463_PTP_TS_IER;
+	ptpirq->reg_status = KSZ8463_PTP_TS_ISR;
+	ptpirq->irq0_offset = KSZ8463_PTP_INT_START;
+	snprintf(ptpirq->name, sizeof(ptpirq->name), "ptp-irq");
+
+	ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev),
+						  ptpirq->nirqs,
+						  &ksz_ptp_irq_domain_ops,
+						  ptpirq);
+	if (!ptpirq->domain)
+		return -ENOMEM;
+
+	ret = ksz8463_ptp_port_irq_setup(ptpirq, port1,
+					 KSZ8463_PTP_PORT1_INT_START - KSZ8463_PTP_INT_START);
+	if (ret)
+		goto release_domain;
+
+	ret = ksz8463_ptp_port_irq_setup(ptpirq, port2,
+					 KSZ8463_PTP_PORT2_INT_START - KSZ8463_PTP_INT_START);
+	if (ret)
+		goto free_port1;
+
+	ret = request_threaded_irq(ptpirq->irq_num, NULL, ksz_ptp_irq_thread_fn,
+				   IRQF_ONESHOT, ptpirq->name, ptpirq);
+	if (ret)
+		goto free_port2;
+
+	return 0;
+
+free_port2:
+	ksz8463_ptp_port_irq_teardown(port2);
+free_port1:
+	ksz8463_ptp_port_irq_teardown(port1);
+release_domain:
+	irq_domain_remove(ptpirq->domain);
+
+	return ret;
+}
+
+void ksz8463_ptp_irq_free(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *port1 = &dev->ports[0];
+	struct ksz_port *port2 = &dev->ports[1];
+	struct ksz_irq *ptpirq = &port1->ptpirq;
+
+	free_irq(ptpirq->irq_num, ptpirq);
+	ksz8463_ptp_port_irq_teardown(port2);
+	ksz8463_ptp_port_irq_teardown(port1);
+	irq_domain_remove(ptpirq->domain);
+}
+
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 3086e519b1b6..11408580031d 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -50,6 +50,8 @@ bool ksz_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 		       unsigned int type);
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p);
 void ksz_ptp_irq_free(struct dsa_switch *ds, u8 p);
+int ksz8463_ptp_irq_setup(struct dsa_switch *ds);
+void ksz8463_ptp_irq_free(struct dsa_switch *ds);
 
 #else
 
@@ -72,6 +74,13 @@ static inline int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 static inline void ksz_ptp_irq_free(struct dsa_switch *ds, u8 p) {}
 
+static inline int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
+{
+	return 0;
+}
+
+static inline void ksz8463_ptp_irq_free(struct dsa_switch *ds) {}
+
 #define ksz_get_ts_info NULL
 
 #define ksz_hwtstamp_get NULL
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index eab9aecb7fa8..1a669d6ee889 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -121,6 +121,12 @@
 #define REG_PTP_PORT_SYNC_TS		0x0C0C
 #define REG_PTP_PORT_PDRESP_TS		0x0C10
 
+#define KSZ8463_REG_PORT_DREQ_TS	0x0648
+#define KSZ8463_REG_PORT_SYNC_TS	0x064C
+#define KSZ8463_REG_PORT_DRESP_TS	0x0650
+#define KSZ8463_PTP_TS_ISR		0x068C
+#define KSZ8463_PTP_TS_IER		0x068E
+
 #define REG_PTP_PORT_TX_INT_STATUS__2	0x0C14
 #define REG_PTP_PORT_TX_INT_ENABLE__2	0x0C16
 

-- 
2.54.0


