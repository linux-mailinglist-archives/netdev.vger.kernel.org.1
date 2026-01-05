Return-Path: <netdev+bounces-247048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230DCF3BDB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7D093004843
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37622A4E8;
	Mon,  5 Jan 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oM8dFMGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17B21CC55
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618508; cv=none; b=X5Qe9Qi5pI0puJqj0jxPqTPKgsRC0YdcVFT8wMwfYjdw2rT5Ln1rkbxyC1iTU0GUWwcVPBdogYAJgIC5HtOWfdIkWB5An4trni7lG1CZFrcGftTSnG0n7iZ9tzGW2yXdWy5oANlZKxT0bZZ5KEUQ1LoszbOa7FlXwEc/gjgdx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618508; c=relaxed/simple;
	bh=8agHYfGsTbdc3ErzqoR06YZ4Tg7PdxjqckMeQqhL/Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdwVa+fRydO1FZL1LU0LgnpFg28CyXNV2a4dNBS/tPCNKCymr3fIlcQZ8HdgToEIOzvFE/Otgn/oqDD/ZDNTOW//sga+DT4PxpTTNoH56tsXT/4sP6w9cdnMoa/GbSO9S6DZDWO6uzGQ54nlah4OFdgH3yytHmFLyd8gdcYKMVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oM8dFMGs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8AD9E4E41F7D;
	Mon,  5 Jan 2026 13:08:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60EB160726;
	Mon,  5 Jan 2026 13:08:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51DDA103C8525;
	Mon,  5 Jan 2026 14:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767618503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jcHdHKeRfk2L2dJr+OgepAfuQM3d1EUGFfjpNce4V24=;
	b=oM8dFMGsRhzfNp9RC6CRH3392rkU87OeLdXA9htqv/JOPCAVyy5JgY/D6b90sC6miEsaf2
	DQ19oQHFh24woKTYI1xUMRyR2xxvR8dSb+qSXuIythF6jGeLbroCfK87zqrRl9MuLQ+aHB
	AD7NT2xjfLC4NcKpqxdR4qwBNl8k0rlTn3Xmie0tawwQp1sgu6OaqItinfFsn3J5RLb4WE
	nNLX0au9KkyceQ1y2rZlzhrSnd/I59hgFYDrp5tS+5T6ViGpA3eaJ1e2L1NRXyd+40lJQR
	C/Pfi1SSxXhMnGbkfq8H87MocKl8W2DgbqwEW9RzBXslmr6M39XQuQ6JBqnwtw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 05 Jan 2026 14:08:01 +0100
Subject: [PATCH net-next 2/9] net: dsa: microchip: Use dynamic irq offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-ksz-rework-v1-2-a68df7f57375@bootlin.com>
References: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
In-Reply-To: <20260105-ksz-rework-v1-0-a68df7f57375@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The PTP irq_chip operations use an hardcoded IRQ offset in the bit
logic. This IRQ offset isn't the same on KSZ8463 than on others switches
so it can't use the irq_chip operations.

Convey the interrupt bit offset through a new attribute in struct ksz_irq

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.h | 1 +
 drivers/net/dsa/microchip/ksz_ptp.c    | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c65188cd3c0a0ed8dd75ee195cebbe47b3a01ada..3add190e686260bb1807ba03b4b153abeead223e 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -108,6 +108,7 @@ struct ksz_irq {
 	int irq_num;
 	char name[16];
 	struct ksz_device *dev;
+	u16 irq0_offset;
 };
 
 struct ksz_ptp_irq {
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 997e4a76d0a68448b0ebc76169150687bbc79673..0ac2865ba9c000fa58b974647c9c88287164cd1c 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1008,7 +1008,7 @@ static irqreturn_t ksz_ptp_irq_thread_fn(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for (n = 0; n < ptpirq->nirqs; ++n) {
-		if (data & BIT(n + KSZ_PTP_INT_START)) {
+		if (data & BIT(n + ptpirq->irq0_offset)) {
 			sub_irq = irq_find_mapping(ptpirq->domain, n);
 			handle_nested_irq(sub_irq);
 			++nhandled;
@@ -1023,14 +1023,14 @@ static void ksz_ptp_irq_mask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked &= ~BIT(d->hwirq + KSZ_PTP_INT_START);
+	kirq->masked &= ~BIT(d->hwirq + kirq->irq0_offset);
 }
 
 static void ksz_ptp_irq_unmask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked |= BIT(d->hwirq + KSZ_PTP_INT_START);
+	kirq->masked |= BIT(d->hwirq + kirq->irq0_offset);
 }
 
 static void ksz_ptp_irq_bus_lock(struct irq_data *d)
@@ -1126,6 +1126,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	ptpirq->reg_mask = ops->get_port_addr(p, REG_PTP_PORT_TX_INT_ENABLE__2);
 	ptpirq->reg_status = ops->get_port_addr(p,
 						REG_PTP_PORT_TX_INT_STATUS__2);
+	ptpirq->irq0_offset = KSZ_PTP_INT_START;
+
 	snprintf(ptpirq->name, sizeof(ptpirq->name), "ptp-irq-%d", p);
 
 	init_completion(&port->tstamp_msg_comp);

-- 
2.52.0


