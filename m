Return-Path: <netdev+bounces-252359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNeGKqs6cmlMfAAAu9opvQ
	(envelope-from <netdev+bounces-252359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:56:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015D68332
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E13EBE86
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0E314D03;
	Thu, 22 Jan 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PUsi0bkW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10330CDBD;
	Thu, 22 Jan 2026 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088467; cv=none; b=ZdrDB+bcQt0PVtwXB5CqhFASWW5Q7MO67rJGqd4RdUUQOkXXPTltMikhdXkY2Fb/jvOrbM3euh1/uM8tlNvshaPBYuNCXEO145JC/oiUwBGkOveH69HjfQAQ+20CUWqrpsJ491QStvCrFrpdNf2deoNVnt7624zVfyJoagNEU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088467; c=relaxed/simple;
	bh=N3ryQbGEWD3cPHtfikuGqfoTM8sOAlPC0aYgdbP0Wxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIgsQRsDdxJ1n0jGbpeLc88+ivBZWDWXDTV87wa1HW9EOWYpIB7g+gzabHhJIVfh7E9Qu6y25MAiG+99zi7krCraE6ijwIYG6cbrVtRrGIXoy6XIxrGa6Cjozrzdc1BRDx6tuHMT9/pBnidnjKd8IgfN8qnlR/xVIO3dNBCynIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PUsi0bkW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6A2E7C21AA4;
	Thu, 22 Jan 2026 13:27:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91AAF60740;
	Thu, 22 Jan 2026 13:27:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95CD0119B815E;
	Thu, 22 Jan 2026 14:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769088462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gkMPdwGfu8X4F3+hrF5ewptOuduz1YxWL/Ffa1MnO38=;
	b=PUsi0bkWNCq8ZmpHiC3jf/Kadro8gSFNgMk8kvGzYnN/Z/S6aG2tG/c2SJqvmZ6XcjAWOI
	f9vYb0L4u5y9KFH+ZryD2r6M9PR6/Tk8TZfAkiA1h4DgVED5IAhX43oa/EvJr3iCVivJOi
	5fJvotr36ug/Ozv4S9yO+AAHnVz2DLLAG06gGucpmfqu3ic7ROPSkvI7JWH/yn5hcA/1V4
	BWnZMg3paMyz16Z64EpFqvq2AgZN/a0WhaCv2cnQD7Qt6i8Uvky4HcsuaM5/E/8uGFpsKh
	bbMN/EiN1TrwwwlIoam2C1ihED93OM4kl/IvDGLfPQ9/0xKjEW/e7eGdm8LuyA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 22 Jan 2026 14:27:35 +0100
Subject: [PATCH net-next v2 1/8] net: dsa: microchip: Add support for
 KSZ8463 global irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-ksz8463-ptp-v2-1-b6683f5ce50b@bootlin.com>
References: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
In-Reply-To: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252359-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5015D68332
X-Rspamd-Action: no action

KSZ8463's interrupt scheme differs from the others KSZ swicthes. Its
global interrupt handling is done through an 'enable irq' register
instead of a 'mask irq' one, so the bit logic to enable/disable
interrupt is reversed. Also its interrupts registers are 16-bits
registers and don't have the same address.

Add ksz8463-specific global interrupt setup function that still relies
on the ksz_irq_common_setup().
Add a check on the device type in the irq_chip operations to adjust the
bit logic for KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 40 +++++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h |  3 +++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e5fa1f5fc09b37c1a9d907175f8cd2cd60aee180..82ec7142a02c432f162e472c831faa010c035123 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2817,14 +2817,20 @@ static void ksz_irq_mask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked |= BIT(d->hwirq);
+	if (ksz_is_ksz8463(kirq->dev))
+		kirq->masked &= ~BIT(d->hwirq);
+	else
+		kirq->masked |= BIT(d->hwirq);
 }
 
 static void ksz_irq_unmask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked &= ~BIT(d->hwirq);
+	if (ksz_is_ksz8463(kirq->dev))
+		kirq->masked |= BIT(d->hwirq);
+	else
+		kirq->masked &= ~BIT(d->hwirq);
 }
 
 static void ksz_irq_bus_lock(struct irq_data *d)
@@ -2840,7 +2846,10 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
+	if (ksz_is_ksz8463(dev))
+		ret = ksz_write16(dev, kirq->reg_mask, kirq->masked);
+	else
+		ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
@@ -2890,14 +2899,14 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
 	unsigned int nhandled = 0;
 	struct ksz_device *dev;
 	unsigned int sub_irq;
-	u8 data;
+	u16 data;
 	int ret;
 	u8 n;
 
 	dev = kirq->dev;
 
 	/* Read interrupt status register */
-	ret = ksz_read8(dev, kirq->reg_status, &data);
+	ret = ksz_read16(dev, kirq->reg_status, &data);
 	if (ret)
 		goto out;
 
@@ -2939,6 +2948,22 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	return ret;
 }
 
+static int ksz8463_girq_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_irq *girq = &dev->girq;
+
+	girq->nirqs = 15;
+	girq->reg_mask = KSZ8463_REG_IER;
+	girq->reg_status = KSZ8463_REG_ISR;
+	girq->masked = 0;
+	snprintf(girq->name, sizeof(girq->name), "global_irq");
+
+	girq->irq_num = dev->irq;
+
+	return ksz_irq_common_setup(dev, girq);
+}
+
 static int ksz_girq_setup(struct ksz_device *dev)
 {
 	struct ksz_irq *girq = &dev->girq;
@@ -3044,7 +3069,10 @@ static int ksz_setup(struct dsa_switch *ds)
 	p->learning = true;
 
 	if (dev->irq > 0) {
-		ret = ksz_girq_setup(dev);
+		if (ksz_is_ksz8463(dev))
+			ret = ksz8463_girq_setup(ds);
+		else
+			ret = ksz_girq_setup(dev);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de5254defdc1afb52b224b3898233b..67a488a3b5787f93f9e2a9266ce04f6611b56bf8 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -839,6 +839,9 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ87XX_INT_PME_MASK		BIT(4)
 
 /* Interrupt */
+#define KSZ8463_REG_ISR			0x190
+#define KSZ8463_REG_IER			0x192
+
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
 

-- 
2.52.0


