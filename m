Return-Path: <netdev+bounces-307036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wtMODMuQVGqrnQMAu9opvQ
	(envelope-from <netdev+bounces-307036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:16:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3D747EC9
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:16:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=GDBxKdys;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307036-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307036-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4080305557A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCBA369208;
	Mon, 13 Jul 2026 07:11:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED736A340
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926700; cv=none; b=pkZyfSqrR3gLN3l/PVYvoJt2kUimclnF779pX8e1xEC7vNp/HpUvaDluAWBnwWU3KO1feQg68/B1Tdfuvi9qnv6GF2KJgTmkPsNkcy/KQYBRRyXb6qRSklvgsJDqm1gphKVtM8qcA5At5AmpFAMOfB+iD0lbEyt7L6w36EeFeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926700; c=relaxed/simple;
	bh=hWw4xiAaOHbn0Lxb1RJ9sP1ExOiCtbQjGmsfJ6RvU0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OvKE61HH6CJNZklscMO9yx7e/eDkT+L8z4iqVyltQEiP44OtgI8C8gUHEGujitnp26kEme4jKicGlIC1WDrQTmaiqT8PZdgmhEsocV1X5EElyIqy6BmxeC5HNiWcH9WHnWm8x+9OazKltY9WGChmDeA6r8ynsICYBTFgVY/7/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GDBxKdys; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A98FEC2BB12;
	Mon, 13 Jul 2026 07:11:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B2F9E60341;
	Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12EC311BD3A37;
	Mon, 13 Jul 2026 09:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VmVvjxYNp9LkN0emJrGpqwbiGfhUTLyxiUgQJDJv1kU=;
	b=GDBxKdysIePXadG8hiAVOqH5TNfwbt6CI9iL20gIHIiiopY5lBjguskcbunvRd5isQpk/U
	LyDcOYsXcggWJWocWsFLhDH0NTdNw+jVqG6xMkIPzSktcoeFduw+qnMYGDq0Gmh9fUq+4k
	+HZUPSw7cLkGYqVaKI3nMQW6o+aEeW+IBu3PrLoyA8oCH7DdLA7bcg+qbE+1tHZGzEKuCh
	bJ0Pf3m3274zAGbTmD2bXoJRb+BHJWITHVUOn+L+a1iWS6c5A4QacAy9BJgpwyTY6/Kbj7
	5WjJK9Bhaud0PTdnMpDIkU4OANj/aHOmWL6Exs1byNCnD0OlkfJbDqEjA1s4tg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:22 +0200
Subject: [PATCH net-next v2 03/10] net: dsa: microchip: allow the use of
 other IRQ operations.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-3-7209c05058ef@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-307036-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7AF3D747EC9

The IRQ setup uses an hardcoded set of IRQ operations. These operations
don't fit with the KSZ8463 which has an inverted bit logic (it uses an
'enable irq' register instead of a 'mask irq' one) and 16-bits registers.

Take the IRQ domain operations as input of ksz_irq_common_setup() to
allow KSZ8463 to use the already existing setup with its own set of IRQ
operations.
Expose ksz_irq_common_setup() and ksz_irq_bus_lock/unlock() so they can
be used by ksz8.c.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 15 ++++++++-------
 drivers/net/dsa/microchip/ksz_common.h |  5 +++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 67ab6ddb9e53..ff1be540b546 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2419,14 +2419,14 @@ static void ksz_irq_unmask(struct irq_data *d)
 	kirq->masked &= ~BIT(d->hwirq);
 }
 
-static void ksz_irq_bus_lock(struct irq_data *d)
+void ksz_irq_bus_lock(struct irq_data *d)
 {
 	struct ksz_irq *kirq  = irq_data_get_irq_chip_data(d);
 
 	mutex_lock(&kirq->dev->lock_irq);
 }
 
-static void ksz_irq_bus_sync_unlock(struct irq_data *d)
+void ksz_irq_bus_sync_unlock(struct irq_data *d)
 {
 	struct ksz_irq *kirq  = irq_data_get_irq_chip_data(d);
 	struct ksz_device *dev = kirq->dev;
@@ -2504,14 +2504,15 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
-static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
+int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq,
+			 const struct irq_domain_ops *ops)
 {
 	int ret, n;
 
 	kirq->dev = dev;
 
-	kirq->domain = irq_domain_create_simple(dev_fwnode(dev->dev), kirq->nirqs, 0,
-						&ksz_irq_domain_ops, kirq);
+	kirq->domain = irq_domain_create_simple(dev_fwnode(dev->dev),
+						kirq->nirqs, 0, ops, kirq);
 	if (!kirq->domain)
 		return -ENOMEM;
 
@@ -2543,7 +2544,7 @@ int ksz_girq_setup(struct ksz_device *dev)
 
 	girq->irq_num = dev->irq;
 
-	return ksz_irq_common_setup(dev, girq);
+	return ksz_irq_common_setup(dev, girq, &ksz_irq_domain_ops);
 }
 
 int ksz_pirq_setup(struct ksz_device *dev, u8 p)
@@ -2560,7 +2561,7 @@ int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	if (!pirq->irq_num)
 		return -EINVAL;
 
-	return ksz_irq_common_setup(dev, pirq);
+	return ksz_irq_common_setup(dev, pirq, &ksz_irq_domain_ops);
 }
 
 void ksz_teardown(struct dsa_switch *ds)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index acaf70e6f393..0f2abb22ca91 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -8,6 +8,7 @@
 #define __KSZ_COMMON_H
 
 #include <linux/etherdevice.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/pcs/pcs-xpcs.h>
@@ -508,6 +509,10 @@ int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val);
 int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum);
 int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val);
 int ksz_mdio_register(struct ksz_device *dev);
+void ksz_irq_bus_lock(struct irq_data *d);
+void ksz_irq_bus_sync_unlock(struct irq_data *d);
+int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq,
+			 const struct irq_domain_ops *ops);
 int ksz_pirq_setup(struct ksz_device *dev, u8 p);
 int ksz_girq_setup(struct ksz_device *dev);
 void ksz_irq_free(struct ksz_irq *kirq);

-- 
2.54.0


