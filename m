Return-Path: <netdev+bounces-295624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9XiHMxZYImouVQEAu9opvQ
	(envelope-from <netdev+bounces-295624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:01:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF3645179
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:01:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qihDW02b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295624-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295624-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3768E305A256
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE73B2D04;
	Fri,  5 Jun 2026 04:56:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487C3B2FF2
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 04:56:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635414; cv=none; b=mdH/a/ghUa5XpyIs2ZXJHs/fbMNZVWelvBoxU3S5wSpksc/PzhZQcPugzL4bxdomGKuBAfHddEhT9FCULtN/a5Ek9+sBFpm+12UCrYHu1UkQsCS76VQ1fURA+hLyn9W8DpDXaBEVp5JhG1GvzGm2ZT1Dw6/ZpqRnP8WSQijKcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635414; c=relaxed/simple;
	bh=mWtqvokkNY0OMKtPyvUg9pSyjnftJ/9lXl/rcD/dICM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jVlZsEhrFoqbBGSJ0xThqu6crfZcbvP5JrdFFPXgVujS8/bxs4a2bIg4QGVyFYphrxdkPKEdugO6TVuIfCPZbUmAgTyXrCSGPDrfPEO3NVycgs+WxYifllZzLxpAg8oyYcMTOXpBcsjr97zm6g1jR1ulKuFO07yA2HXAImM063I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qihDW02b; arc=none smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e3b2a435ecso14486807b3.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 21:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780635412; x=1781240212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HeBzSN7Bi1btALPQSDlRLmfvwWO13MW01wePrMLTlc=;
        b=qihDW02bu1gcP+RVzT1rKd6Tez6jYHzNCSoiDLGahh1H/3S1WVV4/thw6kNL3DkQGw
         Psbnxt4v4QaaEPzQY+DSBV0H4qV+A7yr3mgrnvi9smvZkzWfhffkzzwUyly+tdXGgECp
         pqtUBvJ32XvIhpScK0swQDpdre51zaNuQxEmvFpJYcQ4BzkI4eRX78vsoIvbzjKZG3Dq
         zuciRtIn4+aeJq6bPFUE2DEKkjylS4NoTFmNYvb7qtgd+xcYPPk6gZAL1NOc/v25dL0p
         HqiHQIcFzzA1l5CJRlG1K1uHCm29k1JgOwy1+fN9cWWRjtBC6ODF6VpzaUc3nM0N43OX
         yYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635412; x=1781240212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HeBzSN7Bi1btALPQSDlRLmfvwWO13MW01wePrMLTlc=;
        b=pXmL3FJSlRODwlsOXQkc8w2bQQiEP7nrTsFHfWbR/0N+v4PlwOVN3UMfT0Z0Gye90+
         NQGUA/bBm2M80u4h87BvklunJv3BQMqMeAOywKxvbsYKOF8Qh2Ha5Yk+hBj4tWgEuEwH
         iwWG/fyuFOFqBW1iw5Rp1zo23tqWmY/Z5GNnLQXyCZqdSyuGo1Qki/i9HD6ghaGyQE1r
         ZxNSaimr+UpmUgRfJ/kPlOw+MZmpYmnRtfer17Y7Zr7Yo9Skis4G9EAyppwIczfw0okJ
         fjMbMSl5jiFuM+Ij3DHc00uBpOfWnWUcH1R80S+ZPfBCUJSLO74/nQY+/Z36KKW04MXW
         UmMA==
X-Gm-Message-State: AOJu0Ywtj8nF2H+JmSIZFBgfpDF5y14kiqsN77zW8wEwgrveDX3O/XAE
	vgTVRirgSweCaHJsTtDEjZI4K980x+VF5+NWAZ0M1zQGJYFeD+gD3H25
X-Gm-Gg: Acq92OFFKdY6yldXecdTkgpO5fq1so2gFuAS2FSLf1w5DkNvfkwdEZ3yYCEkqAFW0XZ
	xXuu5dKgnggwkjzwo7IC7EN6WxhLiav/RdVyS+vpFfoKcyG9tvCQx0b3AieH+fve8uf5elQCHT8
	6QRWGBq/fnWDLYcVdN3xMr0AYBAjLPx2DVUiLwSXqh7xjWUIUlYrGhjdr0v0rylmkEkyD6z8AAe
	lo/dUkKojHBil3rWTpOown0fDlcMDCJELWbrXEtNJTeYrt4bhbywBIVR4NBUXt6SUqueZ3rEsz9
	36XtoKIrAvhMfYWVWh0TKyAgqWqolk++y2IsNl+sPCbK/bc4mm6lFcDrJzGkbwLizk5gEQDL8VR
	lJ6+USOzl17ovkZZSYW3fFYsncYqjbgkFA1rwzMwkvgzaeWackEP/V8vTxlnAcQ1B4Rm9iZyCql
	CWf9mGwMBUp7FvmIPgdfPprlXvKR7frUMP67l8I5HkgIPgDtQaEw==
X-Received: by 2002:a05:690c:6706:b0:7be:5f3e:5309 with SMTP id 00721157ae682-7ed0cee8e26mr17752967b3.38.1780635412187;
        Thu, 04 Jun 2026 21:56:52 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm45840207b3.16.2026.06.04.21.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 21:56:50 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 05 Jun 2026 01:56:11 -0300
Subject: [net-next PATCH v12 3/9] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-realtek_forward-v12-3-78eb7b31df72@gmail.com>
References: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
In-Reply-To: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295624-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:abdulkader.alrezej@gmail.com,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:yurynorov@gmail.com,m:abdulkaderalrezej@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,yahoo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29FF3645179

Convert open-coded port iteration loops to use the DSA helpers and
restructure rtl8365mb_setup() into clear blocking, user, and
CPU port phases.

As part of this refactoring, unused ports are explicitly placed into a
blocked, isolated state with learning disabled, ensuring safe default
hardware behavior. The driver also does not allocate a virtual IRQ
mapping for unused ports. To accommodate this, a guard check is added to
the interrupt handler (rtl8365mb_irq) to safely skip ports without a
valid IRQ mapping. The irq domain teardown, however, does clean all
ports as external PHYs may still map the IRQ.

Furthermore, since the new initialization loop starts with all ports
administratively isolated by default, CPU port forwarding and isolation
masks are explicitly configured at the end of the setup phase to prevent
egress traffic from being blocked.

Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 166 +++++++++++++++++++++++-------------
 1 file changed, 105 insertions(+), 61 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 37e1d7654b1d..14fee2a3001b 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1554,18 +1554,15 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
 	struct dsa_switch *ds = &priv->ds;
-	int i;
+	struct dsa_port *dp;
 
 	/* Per-chip global mutex to protect MIB counter access, since doing
 	 * so requires accessing a series of registers in a particular order.
 	 */
 	mutex_init(&mb->mib_lock);
 
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
-
-		if (dsa_is_unused_port(ds, i))
-			continue;
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
 		/* Per-port spinlock to protect the stats64 data */
 		spin_lock_init(&p->stats_lock);
@@ -1581,13 +1578,10 @@ static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
 	struct dsa_switch *ds = &priv->ds;
-	int i;
-
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
+	struct dsa_port *dp;
 
-		if (dsa_is_unused_port(ds, i))
-			continue;
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
 		cancel_delayed_work_sync(&p->mib_work);
 	}
@@ -1646,6 +1640,9 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 	for_each_set_bit(line, &line_changes, priv->num_ports) {
 		int child_irq = irq_find_mapping(priv->irqdomain, line);
 
+		if (!child_irq)
+			continue;
+
 		handle_nested_irq(child_irq);
 	}
 
@@ -1667,10 +1664,14 @@ static struct irq_chip rtl8365mb_irq_chip = {
 static int rtl8365mb_irq_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
-	irq_set_chip_data(irq, domain->host_data);
+	struct realtek_priv *priv = domain->host_data;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	irq_set_chip_data(irq, priv);
 	irq_set_chip_and_handler(irq, &rtl8365mb_irq_chip, handle_simple_irq);
 	irq_set_nested_thread(irq, 1);
 	irq_set_noprobe(irq);
+	irq_set_parent(irq, mb->irq);
 
 	return 0;
 }
@@ -1709,13 +1710,14 @@ static int rtl8365mb_irq_disable(struct realtek_priv *priv)
 static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
 	struct device_node *intc;
+	struct dsa_port *dp;
 	u32 irq_trig;
 	int virq;
 	int irq;
 	u32 val;
 	int ret;
-	int i;
 
 	intc = of_get_child_by_name(priv->dev->of_node, "interrupt-controller");
 	if (!intc) {
@@ -1736,6 +1738,9 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_put_node;
 	}
 
+	/* Store the irq so that we know to map and free it during teardown */
+	mb->irq = irq;
+
 	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), priv->num_ports,
 						   &rtl8365mb_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
@@ -1744,8 +1749,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_put_node;
 	}
 
-	for (i = 0; i < priv->num_ports; i++) {
-		virq = irq_create_mapping(priv->irqdomain, i);
+	dsa_switch_for_each_available_port(dp, ds) {
+		virq = irq_create_mapping(priv->irqdomain, dp->index);
 		if (!virq) {
 			dev_err(priv->dev,
 				"failed to create irq domain mapping\n");
@@ -1799,9 +1804,6 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_remove_irqdomain;
 	}
 
-	/* Store the irq so that we know to free it during teardown */
-	mb->irq = irq;
-
 	ret = rtl8365mb_irq_enable(priv);
 	if (ret)
 		goto out_free_irq;
@@ -1812,18 +1814,20 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 
 out_free_irq:
 	free_irq(mb->irq, priv);
-	mb->irq = 0;
 
 out_remove_irqdomain:
-	for (i = 0; i < priv->num_ports; i++) {
-		virq = irq_find_mapping(priv->irqdomain, i);
-		irq_dispose_mapping(virq);
+	dsa_switch_for_each_port(dp, ds) {
+		virq = irq_find_mapping(priv->irqdomain, dp->index);
+
+		if (virq)
+			irq_dispose_mapping(virq);
 	}
 
 	irq_domain_remove(priv->irqdomain);
 	priv->irqdomain = NULL;
 
 out_put_node:
+	mb->irq = 0;
 	of_node_put(intc);
 
 	return ret;
@@ -1832,8 +1836,9 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
 	int virq;
-	int i;
 
 	if (mb->irq) {
 		free_irq(mb->irq, priv);
@@ -1841,9 +1846,15 @@ static void rtl8365mb_irq_teardown(struct realtek_priv *priv)
 	}
 
 	if (priv->irqdomain) {
-		for (i = 0; i < priv->num_ports; i++) {
-			virq = irq_find_mapping(priv->irqdomain, i);
-			irq_dispose_mapping(virq);
+		/* Unused ports with a linked PHY still have an active IRQ
+		 * mapping that must be disposed of during teardown. Loop
+		 * through all ports.
+		 */
+		dsa_switch_for_each_port(dp, ds) {
+			virq = irq_find_mapping(priv->irqdomain, dp->index);
+
+			if (virq)
+				irq_dispose_mapping(virq);
 		}
 
 		irq_domain_remove(priv->irqdomain);
@@ -1961,10 +1972,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb_cpu *cpu;
-	struct dsa_port *cpu_dp;
+	u32 downports_mask = 0;
+	u32 upports_mask = 0;
 	struct rtl8365mb *mb;
+	struct dsa_port *dp;
 	int ret;
-	int i;
 
 	mb = priv->chip_data;
 	cpu = &mb->cpu;
@@ -1991,67 +2003,99 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	for (i = 0; i < priv->num_ports; i++) {
+	dsa_switch_for_each_port(dp, ds) {
 		/* Cascading (DSA links) is not supported yet.
 		 * Historically, the driver has always been broken
 		 * without a dedicated CPU port because CPU tagging
 		 * would be disabled, rendering the switch entirely
 		 * non-functional for DSA operations.
 		 */
-		if (dsa_is_dsa_port(ds, i)) {
+		if (dsa_port_is_dsa(dp)) {
 			dev_err(priv->dev, "Cascading (DSA link) not supported\n");
 			ret = -EOPNOTSUPP;
 			goto out_teardown_irq;
 		}
 	}
 
-	/* Configure CPU tagging */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		cpu->mask |= BIT(cpu_dp->index);
+	/* Start with all ports blocked, including unused ports */
+	dsa_switch_for_each_port(dp, ds) {
+		struct rtl8365mb_port *p = &mb->ports[dp->index];
 
-		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
-			cpu->trap_port = cpu_dp->index;
-	}
-	cpu->enable = cpu->mask > 0;
+		/* Set the initial STP state of all ports to DISABLED, otherwise
+		 * ports will still forward frames to the CPU despite being
+		 * administratively down by default.
+		 */
+		rtl8365mb_port_stp_state_set(ds, dp->index, BR_STATE_DISABLED);
 
-	if (!cpu->enable) {
-		dev_err(priv->dev, "no CPU port defined\n");
-		ret = -EINVAL;
-		goto out_teardown_irq;
-	}
+		/* Start with all port completely isolated */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index, 0);
+		if (ret)
+			goto out_teardown_irq;
 
-	ret = rtl8365mb_cpu_config(priv);
-	if (ret)
-		goto out_teardown_irq;
+		/* Disable learning */
+		ret = rtl8365mb_port_set_learning(priv, dp->index, false);
+		if (ret)
+			goto out_teardown_irq;
 
-	/* Configure ports */
-	for (i = 0; i < priv->num_ports; i++) {
-		struct rtl8365mb_port *p = &mb->ports[i];
+		/* Set up per-port private data */
+		p->priv = priv;
+		p->index = dp->index;
+
+		/* Collect CPU ports. If we support cascade switches, it should
+		 * also include the upstream DSA ports.
+		 */
+		if (!dsa_port_is_cpu(dp))
+			continue;
+
+		upports_mask |= BIT(dp->index);
+	}
 
-		if (dsa_is_unused_port(ds, i))
+	/* Configure user ports */
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dsa_port_is_user(dp))
 			continue;
 
 		/* Forward only to the CPU */
-		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
+		ret = rtl8365mb_port_set_isolation(priv, dp->index,
+						   upports_mask);
 		if (ret)
 			goto out_teardown_irq;
 
-		/* Disable learning */
-		ret = rtl8365mb_port_set_learning(priv, i, false);
+		/* If we support cascade switches, it should also include the
+		 * downstream DSA ports.
+		 */
+		downports_mask |= BIT(dp->index);
+	}
+
+	/* Configure CPU tagging */
+	/* If we support cascade switches, it should also include the upstream
+	 * DSA ports.
+	 */
+	dsa_switch_for_each_cpu_port(dp, ds) {
+		/* Use the first CPU port as trap_port */
+		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
+			cpu->trap_port = dp->index;
+
+		/* Forward to all user ports */
+		ret = rtl8365mb_port_set_isolation(priv, dp->index,
+						   downports_mask);
 		if (ret)
 			goto out_teardown_irq;
+	}
 
-		/* Set the initial STP state of all ports to DISABLED, otherwise
-		 * ports will still forward frames to the CPU despite being
-		 * administratively down by default.
-		 */
-		rtl8365mb_port_stp_state_set(ds, i, BR_STATE_DISABLED);
+	cpu->mask = upports_mask;
+	cpu->enable = cpu->mask > 0;
 
-		/* Set up per-port private data */
-		p->priv = priv;
-		p->index = i;
+	if (!cpu->enable) {
+		dev_err(priv->dev, "no CPU port defined\n");
+		ret = -EINVAL;
+		goto out_teardown_irq;
 	}
 
+	ret = rtl8365mb_cpu_config(priv);
+	if (ret)
+		goto out_teardown_irq;
+
 	ret = rtl8365mb_port_change_mtu(ds, cpu->trap_port, ETH_DATA_LEN);
 	if (ret)
 		goto out_teardown_irq;

-- 
2.54.0


