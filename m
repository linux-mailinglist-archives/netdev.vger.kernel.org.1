Return-Path: <netdev+bounces-250235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D565BD25877
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4BA6300ED97
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15753B8BCB;
	Thu, 15 Jan 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QqdweSG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8D3B5312;
	Thu, 15 Jan 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492639; cv=none; b=cSVIFh7LQ/E69Ko8Yc9S2cZZVXIYpm65BuFrAdCjc4cHWzfgBMjXoBglnUkID/wtsp1KQSTPiQSjlGGzYODUWpZCVfvKpXMpo64o3I6j88A1gx7fSL/52wOGHnl9169KS4a8FesjB9wKMdX7WSmYOZQS2rQOrahgRQXmxB+AZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492639; c=relaxed/simple;
	bh=Mq588nrNPw+uc5oepjcOMjmGegEoAI+0BQA2zqK9rvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r6wjdCDUQDXlVfpTEG6lT3A9R8dEXJX4TsR3bKea5peSg4nnVbvkgAzyaXhsmYTQs3zF4J5QRk+0VzgVRB19DdBRLr4pTbE7OEpo29ux40ykVxQLUc7jEPGkN7SXWKiO6+ce+Xt0RkF2FZbEUfpCfKMR32eDJUWeg44qJm0i7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QqdweSG3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 494A04E420FF;
	Thu, 15 Jan 2026 15:57:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13BB4606E0;
	Thu, 15 Jan 2026 15:57:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A3AA10B686AA;
	Thu, 15 Jan 2026 16:57:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492632; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=msjsmNWxtn13jWdt/GBOpxERpRumsKymvRVrflpMg/g=;
	b=QqdweSG3nunxkUwVLk0VDNVtq8I8iX75XfgRU7ZD9mWnbYr2Q/UTG3+XWkcJ987kkc7R3T
	mf4V89/kG2FzdlqmsXIjoKyOeplmp2BNctHBSJbfkUJfdWCLiyT4DzvnXKwTd08chE59S7
	aWb+3D8mxoun8FVGPaqTo/me5+8WrPl//JHtqDJcUkSBTgElqNxe9Xk25BePqfoDuRXSoc
	pdfAGuAT1T/c8SS7YQmJ8t3DBU/UwSJb2omUfnN5eF6na0grxXcfVmU0cWSZhk3Gg9+Owm
	hyrFcHs/mncBLKVb0e7Ex8jPQwKW8ziinvgsTOXWEN6kG8Ue387wuuwH6eDQlQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:01 +0100
Subject: [PATCH net-next 2/8] net: dsa: microchip: Decorrelate IRQ domain
 from port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-ksz8463-ptp-v1-2-bcfe2830cf50@bootlin.com>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
In-Reply-To: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
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

KSZ8463 has one register holding interrupt bits from both port 1 and 2.
So it has to use one IRQ domain for both of its ports. This conflicts
with the current initialization procedure that ties one IRQ domain to
each port.

Decorrelate IRQ domain from port so a port can use an IRQ domain not
directly related to itself.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..3b0dddf918595e9318c9e9779035d5152dcd9dde 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1099,18 +1099,17 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 	irq_dispose_mapping(ptpmsg_irq->num);
 }
 
-static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
+static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port, u8 n)
 {
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
-	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
-	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
+	ptpmsg_irq->num = irq_create_mapping(domain, n);
 	if (!ptpmsg_irq->num)
 		return -EINVAL;
 
@@ -1162,7 +1161,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		goto out;
 
 	for (irq = 0; irq < ptpirq->nirqs; irq++) {
-		ret = ksz_ptp_msg_irq_setup(port, irq);
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
 		if (ret)
 			goto out_ptp_msg;
 	}

-- 
2.52.0


