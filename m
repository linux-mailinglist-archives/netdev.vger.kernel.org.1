Return-Path: <netdev+bounces-261488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDE4FFmMoGkCkwQAu9opvQ
	(envelope-from <netdev+bounces-261488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:09:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9FC1AD4C5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A09834A315C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E00D355F4B;
	Thu, 26 Feb 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mTsUue/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AB355F29
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124128; cv=none; b=aI/k5k979ka305uv5Ymicz+DzSXxGwGyYu68ngImlruDDJeszXPzUOY5uiIbK0T22YYbshSqe9J+G6y3sWzSdTt11+1km7htCOPFRSGfQG7/PcAbO/W4rPTljwpYDlfFghITa9uqXL2YqAas1+erHsI49BkaPK1aJOQdssp5q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124128; c=relaxed/simple;
	bh=U8g6xzyvVxsDztEQJMOrMvhuBGuw6fFFSBeuSLkp6AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6bBeaxI01oh1WpXWd8k1cYOkx+0bjD4If1OGBSEiTzebOr/qlTXVHBtaPdqhi/xuNUgQycSXk8EAqRLrWgzWNrgJkfpBmh6sbAG6I/zNmZGaQmx33MFZ8CYFdigMD41WMR8BQfdvcmTTQXpgR3U3W+60mdR7l/sF39elQWD/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mTsUue/2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AE3324E41230;
	Thu, 26 Feb 2026 16:42:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 84F005FDE9;
	Thu, 26 Feb 2026 16:42:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8FB4103693DF;
	Thu, 26 Feb 2026 17:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772124124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2k46UmcdIZlsYIFFkjiNBnzEAvjefgMYz08QLRPkAMc=;
	b=mTsUue/2DUhMDSV/MlsBVi0J/PETq4XwJzQZmYJy3MMnU50iCD4CWA9KMhVVD3n6lnIRC6
	ncxh01+hwjsnlr05A0eHUixnsZ99YMgMeCiRwbJYmJS1umLHE9sr5QeJgQQYTo8vLWOAqW
	68VGxKO2h32jjm0SMUYEoMNLI/xOetzUMwspSJcC9UnWfBuZAo/rB0qjrLi6TsLBKl1meU
	geGGKKTzNMsq/P5zLUM/R+7WhN1W58L+4bBWyq8TOiw5mdVbD5iRbGhTwTYtXe4itw7XRp
	GiwvfyA/qZu7Jk13Fj+yUHd+6nOaBnSLiXFq79BcYJ3Ey8QAIWuX5mIAkVBupg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 26 Feb 2026 17:41:51 +0100
Subject: [PATCH net-next v5 4/9] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-ksz8463-ptp-v5-4-1bc24fb9627d@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
In-Reply-To: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: AB9FC1AD4C5
X-Rspamd-Action: no action

KSZ8463 PTP interrupts aren't handled by the driver.
The interrupt layout in KSZ8463 has nothing to do with the other
switches:
- all the interrupts of all ports are grouped into one status register
  while others have one interrupt register per port
- xdelay_req and pdresp timestamps share one single interrupt bit on the
  KSZ8463 while each of them has its own interrupt bit on other switches

Add KSZ8463-specific IRQ setup()/free() functions to support KSZ8463.
Both ports share one IRQ domain held by port n°1.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c  |  49 +++++++++-----
 drivers/net/dsa/microchip/ksz_common.h  |   2 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 112 +++++++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.h     |   9 +++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |   7 ++
 5 files changed, 160 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 0102b950e09df7d33c8e429d9b34f51375e0ef73..7deeb0b86793bab4818a7e70bc468346ec8f22e3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3076,15 +3076,21 @@ static int ksz_setup(struct dsa_switch *ds)
 		if (ret)
 			return ret;
 
-		dsa_switch_for_each_user_port(dp, dev->ds) {
-			ret = ksz_pirq_setup(dev, dp->index);
+		if (ksz_is_ksz8463(dev)) {
+			ret = ksz8463_ptp_irq_setup(ds);
 			if (ret)
-				goto port_release;
-
-			if (dev->info->ptp_capable) {
-				ret = ksz_ptp_irq_setup(ds, dp->index);
+				goto girq_release;
+		} else {
+			dsa_switch_for_each_user_port(dp, dev->ds) {
+				ret = ksz_pirq_setup(dev, dp->index);
 				if (ret)
-					goto pirq_release;
+					goto port_release;
+
+				if (dev->info->ptp_capable) {
+					ret = ksz_ptp_irq_setup(ds, dp->index);
+					if (ret)
+						goto pirq_release;
+				}
 			}
 		}
 	}
@@ -3119,14 +3125,20 @@ static int ksz_setup(struct dsa_switch *ds)
 		ksz_ptp_clock_unregister(ds);
 port_release:
 	if (dev->irq > 0) {
-		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
-			if (dev->info->ptp_capable)
-				ksz_ptp_irq_free(ds, dp->index);
+		if (ksz_is_ksz8463(dev)) {
+			ksz8463_ptp_irq_free(ds);
+		} else {
+			dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+				if (dev->info->ptp_capable)
+					ksz_ptp_irq_free(ds, dp->index);
 pirq_release:
-			ksz_irq_free(&dev->ports[dp->index].pirq);
+				ksz_irq_free(&dev->ports[dp->index].pirq);
+			}
 		}
-		ksz_irq_free(&dev->girq);
 	}
+girq_release:
+	if (dev->irq > 0)
+		ksz_irq_free(&dev->girq);
 
 	return ret;
 }
@@ -3140,11 +3152,14 @@ static void ksz_teardown(struct dsa_switch *ds)
 		ksz_ptp_clock_unregister(ds);
 
 	if (dev->irq > 0) {
-		dsa_switch_for_each_user_port(dp, dev->ds) {
-			if (dev->info->ptp_capable)
-				ksz_ptp_irq_free(ds, dp->index);
-
-			ksz_irq_free(&dev->ports[dp->index].pirq);
+		if (ksz_is_ksz8463(dev)) {
+			ksz8463_ptp_irq_free(ds);
+		} else {
+			dsa_switch_for_each_user_port(dp, dev->ds) {
+				if (dev->info->ptp_capable)
+					ksz_ptp_irq_free(ds, dp->index);
+				ksz_irq_free(&dev->ports[dp->index].pirq);
+			}
 		}
 
 		ksz_irq_free(&dev->girq);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 67a488a3b5787f93f9e2a9266ce04f6611b56bf8..dfbc3d13daca8d7a8b9d3ffe6a7c1ec9927863f2 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -851,6 +851,8 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define PORT_SRC_PHY_INT		1
 #define PORT_SRC_PTP_INT		2
 
+#define KSZ8463_SRC_PTP_INT		12
+
 #define KSZ8795_HUGE_PACKET_SIZE	2000
 #define KSZ8863_HUGE_PACKET_SIZE	1916
 #define KSZ8863_NORMAL_PACKET_SIZE	1536
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index ae46ba41c588c076de2c3b70c7c6702ad85263d5..5daadf62689e6d60ab32e7a5a6c1f3fac3024b87 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -31,6 +31,9 @@
 #define KSZ_PTP_SUBNS_BITS 32
 
 #define KSZ_PTP_INT_START 13
+#define KSZ8463_PTP_PORT1_INT_START 12
+#define KSZ8463_PTP_PORT2_INT_START 14
+#define KSZ8463_PTP_INT_START KSZ8463_PTP_PORT1_INT_START
 
 static int ksz_ptp_tou_gpio(struct ksz_device *dev)
 {
@@ -1102,6 +1105,7 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port,
 				 u8 index, int irq)
 {
+	static const char * const ksz8463_name[] = {"sync-msg", "delay-msg"};
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
@@ -1115,15 +1119,106 @@ static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *por
 		return -EINVAL;
 
 	ptpmsg_irq->port = port;
-	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[index]);
 
-	strscpy(ptpmsg_irq->name, name[index]);
+	if (ksz_is_ksz8463(port->ksz_dev)) {
+		ts_reg[0] = KSZ8463_REG_PORT_SYNC_TS;
+		ts_reg[1] = KSZ8463_REG_PORT_DREQ_TS;
+		strscpy(ptpmsg_irq->name, ksz8463_name[index]);
+	} else {
+		strscpy(ptpmsg_irq->name, name[index]);
+	}
+
+	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[index]);
 
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
 }
 
+static int ksz8463_ptp_port_irq_setup(struct ksz_irq *ptpirq, struct ksz_port *port, int hw_irq)
+{
+	int ret;
+	int i;
+
+	init_completion(&port->tstamp_msg_comp);
+
+	for (i = 0; i < 2; i++) {
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, i, hw_irq++);
+		if (ret)
+			goto release_msg_irq;
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
+	ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
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
+	ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,
+						  &ksz_ptp_irq_domain_ops, ptpirq);
+	if (!ptpirq->domain)
+		return -ENOMEM;
+
+	ret = request_threaded_irq(ptpirq->irq_num, NULL, ksz_ptp_irq_thread_fn,
+				   IRQF_ONESHOT, ptpirq->name, ptpirq);
+	if (ret)
+		goto release_domain;
+
+	ret = ksz8463_ptp_port_irq_setup(ptpirq, port1,
+					 KSZ8463_PTP_PORT1_INT_START - KSZ8463_PTP_INT_START);
+	if (ret)
+		goto release_irq;
+
+	ret = ksz8463_ptp_port_irq_setup(ptpirq, port2,
+					 KSZ8463_PTP_PORT2_INT_START - KSZ8463_PTP_INT_START);
+	if (ret)
+		goto free_port1;
+
+	return 0;
+
+free_port1:
+	ksz8463_ptp_port_irq_teardown(port1);
+release_irq:
+	free_irq(ptpirq->irq_num, ptpirq);
+release_domain:
+	irq_domain_remove(ptpirq->domain);
+
+	return ret;
+}
+
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1181,6 +1276,19 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	return ret;
 }
 
+void ksz8463_ptp_irq_free(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *port1 = &dev->ports[0];
+	struct ksz_port *port2 = &dev->ports[1];
+	struct ksz_irq *ptpirq = &port1->ptpirq;
+
+	ksz8463_ptp_port_irq_teardown(port1);
+	ksz8463_ptp_port_irq_teardown(port2);
+	free_irq(ptpirq->irq_num, ptpirq);
+	irq_domain_remove(ptpirq->domain);
+}
+
 void ksz_ptp_irq_free(struct dsa_switch *ds, u8 p)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 3086e519b1b641e9e4126cb6ff43409f6d7f29a5..46494caacc4287b845b8e5c3a68bcfc7a03bcf9d 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -48,6 +48,8 @@ void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
 void ksz_port_deferred_xmit(struct kthread_work *work);
 bool ksz_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
 		       unsigned int type);
+int ksz8463_ptp_irq_setup(struct dsa_switch *ds);
+void ksz8463_ptp_irq_free(struct dsa_switch *ds);
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p);
 void ksz_ptp_irq_free(struct dsa_switch *ds, u8 p);
 
@@ -65,6 +67,13 @@ static inline int ksz_ptp_clock_register(struct dsa_switch *ds)
 
 static inline void ksz_ptp_clock_unregister(struct dsa_switch *ds) { }
 
+static inline int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
+{
+	return 0;
+}
+
+static inline void ksz8463_ptp_irq_free(struct dsa_switch *ds) {}
+
 static inline int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 {
 	return 0;
diff --git a/drivers/net/dsa/microchip/ksz_ptp_reg.h b/drivers/net/dsa/microchip/ksz_ptp_reg.h
index eab9aecb7fa8a50323de4140695b2004d1beab8c..e80fb4bd1a0e970ba3570374d3dc82c8e2cc15b4 100644
--- a/drivers/net/dsa/microchip/ksz_ptp_reg.h
+++ b/drivers/net/dsa/microchip/ksz_ptp_reg.h
@@ -121,6 +121,10 @@
 #define REG_PTP_PORT_SYNC_TS		0x0C0C
 #define REG_PTP_PORT_PDRESP_TS		0x0C10
 
+#define KSZ8463_REG_PORT_DREQ_TS	0x0648
+#define KSZ8463_REG_PORT_SYNC_TS	0x064C
+#define KSZ8463_REG_PORT_DRESP_TS	0x0650
+
 #define REG_PTP_PORT_TX_INT_STATUS__2	0x0C14
 #define REG_PTP_PORT_TX_INT_ENABLE__2	0x0C16
 
@@ -131,4 +135,7 @@
 #define KSZ_XDREQ_MSG			1
 #define KSZ_PDRES_MSG			0
 
+#define KSZ8463_PTP_TS_ISR		0x68C
+#define KSZ8463_PTP_TS_IER		0x68E
+
 #endif

-- 
2.53.0


