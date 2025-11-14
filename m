Return-Path: <netdev+bounces-238612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94098C5BC5B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF083B1771
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2592EDD7D;
	Fri, 14 Nov 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UdoxGSHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591C2E613C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104843; cv=none; b=ZWlZyZ+S6rN1P/vT7vzLrHz1UNpCHbyxPJHtV6kgbh86okxmAsqSf/BYT40emycNBJBsgUW9vpYrI0wsODhsNT0O4RVotr5PUvbc8xRP9sHRmMmF1KNbTuKuRjdhwQE2DTINFJHE1mIQKUH8OKjsesiUbAuazuaPQY4o4GufIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104843; c=relaxed/simple;
	bh=NGRwkgSxolK/2c9dDLpj5CBW0FVd4LmMQwPSXORDZoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tv4IJt2bgZ/0EkDPIiZ5V+I6mh3FqRiMNjwjD6BEQiFsfL915hmipbmnAcy0iPNKJFvTNkPt8WRF0+5eMUrWc4CLJQ9Ijc/MZcD4eJaeVdEd2Rn0CkN/id31u17JqqpAUuvZzambw/RWCmaUA+CuSlxxpgIrvaG8GOcWQtT3wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UdoxGSHG; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0C9ADC10F5A;
	Fri, 14 Nov 2025 07:20:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC45D6060E;
	Fri, 14 Nov 2025 07:20:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C172102F292F;
	Fri, 14 Nov 2025 08:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763104833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IO1xnDzOycn8GAViF9q7Sa/lIVw19nSLvwRtLk30Ywc=;
	b=UdoxGSHGz5bOyPjqKHdiAmIhGwIxJTTHvkrUpZOR8GLVX1Bfidvv4QL2INTjpTTcRDLUll
	IuCgtW4pVXLTe1qUXx7LTHJGPcq+SvVeqa7CDKy1U0Zyrk6D0eoKMUxnJpkys9NO7wApBl
	xLiFGtJtwimlSmhqgcsFnEpYGgmWa5NXP8zoeirojRwxeycnyR0GSq4R1rRKMssneyyHaf
	hRKY8T5+ciBnLRbKGqSpY03OheghjiEB4lRXMCwQK+T64NpcslZF5igepfCZsbZVZXnhp4
	Sn+rVCru6t4y0TEsN4Ep0xRX/furoO9g77xD++QjCMNJsU5trZjtlTCl0v+Suw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 14 Nov 2025 08:20:23 +0100
Subject: [PATCH net v3 4/4] net: dsa: microchip: Immediately assing IRQ
 numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-ksz-fix-v3-4-acbb3b9cc32f@bootlin.com>
References: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
In-Reply-To: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The IRQ numbers created through irq_create_mapping() are only assigned
to ptpmsg_irq[n].num at the end of the IRQ setup. So if an error occurs
between their creation and their assignment (for instance during the
request_threaded_irq() step), we enter the error path and fail to
release the newly created virtual IRQs because they aren't yet assigned
to ptpmsg_irq[n].num.

Assign the IRQ number at mapping creation.

Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index c8bfbe5e2157323ecf29149d1907b77e689aa221..a8ad99c6ee35ff60fb56cc5770520a793c86ff66 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1102,10 +1102,6 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
-	if (ptpmsg_irq->num < 0)
-		return ptpmsg_irq->num;
-
 	return request_threaded_irq(ptpmsg_irq->num, NULL,
 				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
 				    ptpmsg_irq->name, ptpmsg_irq);
@@ -1135,8 +1131,13 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
-	for (irq = 0; irq < ptpirq->nirqs; irq++)
-		irq_create_mapping(ptpirq->domain, irq);
+	for (irq = 0; irq < ptpirq->nirqs; irq++) {
+		port->ptpmsg_irq[irq].num = irq_create_mapping(ptpirq->domain, irq);
+		if (!port->ptpmsg_irq[irq].num) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
 	if (!ptpirq->irq_num) {

-- 
2.51.1


