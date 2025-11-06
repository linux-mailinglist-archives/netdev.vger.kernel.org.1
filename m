Return-Path: <netdev+bounces-236355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0AC3B0B4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F163F50300C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4296334C05;
	Thu,  6 Nov 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mjiNlnZq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419A333733
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433605; cv=none; b=WmT6IuP25wxtyajMh8/Gzlh8piykiYnWMPthO5aonFTP1XrcdNJ/y5ligkYEI8s6p3MQ01tTltOqs3ijwYxLLp5TxLQYL+f7QJEqhjJOqEJx8H8+YVN1wQHbnHBmPmtFT/XPWZIaG8T5bgrmRmwFqQOL9C7RGe3zEIaazl7fs/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433605; c=relaxed/simple;
	bh=gt5H4rVHnAPE0oemZIv7zqZ6B2+MOlDhA/XvwMT0PVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr2CuNLSVDJqgOKvvtF8tuNZCE+95jFMSwxAcB+Swebn0IaTymiJKuof9zFmtlEBojFMk8fn8xhF8OvlQlV+gtIPLYYMtDLPGCKQolOqcMRKQKUlZlSF/dvukIw/amEG7uRJoyDAjlzGFQ12ruFmd3vpQG/W1kkBMa+r+GcXMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mjiNlnZq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 566F94E4155F;
	Thu,  6 Nov 2025 12:53:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D3986068C;
	Thu,  6 Nov 2025 12:53:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45AB111851035;
	Thu,  6 Nov 2025 13:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762433601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aYT5CBgRRZjbjQjWuTTIforvN8cPnOUXp5WDBhMNj1g=;
	b=mjiNlnZqdfEdHoc7ZKr9doLyplhMa8hTPj6h7JPknnsakekKVaR2x/JOrMyC4WTkTUSDqK
	2J4HmLmM5Dthc/SjhBHioxifIg4b2L0SGN+EMtvrghzw27JY/OmmLWNV3i7bv2qec45/K8
	y1rtCOSNLqjaHqpAxRbChmAydTaG/z5unpmRrbeqRd0TmWBlXfDsP6HyVuXtJIShA7lvvn
	F+64f95zvJq4NP1+VcEtJNdlanKllv89GWwDbOrIP1Mp1jWQLbbHyrovr1YbwFjMosPuEs
	kk4OBFKaIbI3iwRBt5SzBivzUfvPKAiSTtTgGhaMfbxsiDTWuZYkbuY+3GJ0uA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 06 Nov 2025 13:53:11 +0100
Subject: [PATCH net v2 4/4] net: dsa: microchip: Immediately assing IRQ
 numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ksz-fix-v2-4-07188f608873@bootlin.com>
References: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
In-Reply-To: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
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
2.51.0


