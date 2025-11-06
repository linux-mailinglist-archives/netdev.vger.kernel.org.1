Return-Path: <netdev+bounces-236353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1795FC3B0BA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2858B1AA5247
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C12334375;
	Thu,  6 Nov 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1zH71d0M"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE51332914
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433604; cv=none; b=uKCPfAe8Q/7W0f191UwjPUKbuQ253XjV6Am/kR1IASbkQ+SmGwvjihzX6XVSNNVK4w0gEnA6CsdrqpQ02D6ks0y9PssaGRXgU2St79jf8Rn8G67x7PW2KzLPZ/u/5RypUwDB1Eh/54WlpnPUDCR/lTZoSiM5TX25mhVYN2liWrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433604; c=relaxed/simple;
	bh=IAaIMkOnqP2yloVzJOFVv/QTLiRSqkCSV8+zencdd4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJ5LXp7HmpQvO7YByAljERwrBJ43/qemXT7QuGTob2jw2nAxMTm66AayZDVKWGAa67xYiLBIl3kFabS0iQVU4WQgwIIRFxfyGaExGICM98SuxSlJtEFenP4fLWqkCYhdwDS83umzfxVgQ9Pjtsmims8TLnJL+OLU45El59rPUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1zH71d0M; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DFD004E414CE;
	Thu,  6 Nov 2025 12:53:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AFD316068C;
	Thu,  6 Nov 2025 12:53:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B08AE11851002;
	Thu,  6 Nov 2025 13:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762433600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UTk0YczWZdiIENouofLZQdqIekWw5Y2Zi1fG/iQ0Rt4=;
	b=1zH71d0M/LpIaFgT6oh7yWVAu/kdssPt1TBo5Txmn1r6h6qEHJATGLa4gz/v+gzcVPSaxH
	9I6m3I6h6eVO5p9BEJfd+m9PFwgZqfmt9C0IlNsLCLZFCUD2qsSfw8bJSNxgu8umSWoMWJ
	mLBmy4RfjSH3n8pK/4BZ0B1XhMuF9QsBCWYpTfV8N0ce70VKrJyjfFNbREQQVl3E1sGfZb
	FQOzKI5JD0EaWdyYOTHiqWrHLZSHQ8yAQUYZzOruxat1/0XMq15xvwuaJ28hDgl4KwCwDR
	NkF79fvUNiUEvp0V2QgwB/775zVcVrxdcUjbN/l0Yer0UmdiLSYM2cY5pjX9cQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 06 Nov 2025 13:53:10 +0100
Subject: [PATCH net v2 3/4] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ksz-fix-v2-3-07188f608873@bootlin.com>
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

Sometimes ksz_irq_free() can be called on uninitialized ksz_irq (for
example when ksz_ptp_irq_setup() fails). It leads to freeing
uninitialized IRQ numbers and/or domains.

Ensure that IRQ numbers or domains aren't null before freeing them.
In our case the IRQ number of an initialized ksz_irq is never 0. Indeed,
it's either the device's IRQ number and we enter the IRQ setup only when
this dev->irq is strictly positive, or a virtual IRQ assigned with
irq_create_mapping() which returns strictly positive IRQ numbers.

Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for girq and pirq")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3a4516d32aa5f99109853ed400e64f8f7e2d8016..4f5e2024442692adefc69d47e82381a3c3bda184 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2858,14 +2858,16 @@ static void ksz_irq_free(struct ksz_irq *kirq)
 {
 	int irq, virq;
 
-	free_irq(kirq->irq_num, kirq);
+	if (kirq->irq_num)
+		free_irq(kirq->irq_num, kirq);
 
 	for (irq = 0; irq < kirq->nirqs; irq++) {
 		virq = irq_find_mapping(kirq->domain, irq);
 		irq_dispose_mapping(virq);
 	}
 
-	irq_domain_remove(kirq->domain);
+	if (kirq->domain)
+		irq_domain_remove(kirq->domain);
 }
 
 static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)

-- 
2.51.0


