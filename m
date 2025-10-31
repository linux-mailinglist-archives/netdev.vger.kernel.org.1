Return-Path: <netdev+bounces-234679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 668EAC260DA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212B41A61A88
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D622F90D8;
	Fri, 31 Oct 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oLeN7eW2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052C2F6183
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926751; cv=none; b=V2dlRVSOiqgP5+mFj5PlpHvEwkAb1NeZnaLQzDLgIMmI4gCp8vU3uqluxQdwwvQmYPj8q0OmctemUMCN//fhanN1TxupIJl9mdaVLN6tGpF5bXNMn2Uvms6gezth/lwVi11/zkBZIsfWmKqkrtriOzGP+3tl7wulR+WaQlxAe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926751; c=relaxed/simple;
	bh=JcnwdY8lRx59kxN7gAwOccPBuzqdGKNApvQA0+Faz40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWULIDGoT2Q6N3wssPzm3eGk+77/W1plYPptrPkiPOHflV+NY9YXY4WK60xhvlFsxcGwF1q2Vn96VGN0d8Iky2sEwxeypeHinBpXbsHb468VHfyGA7FI3b2HwOXd6cyQM8LvkUAZzCJjLr2XT+5XTElYZopOQADx1V0vk99M8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oLeN7eW2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 888754E41444;
	Fri, 31 Oct 2025 16:05:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5DE1860704;
	Fri, 31 Oct 2025 16:05:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DAD31181806D;
	Fri, 31 Oct 2025 17:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SuE1P/t3JhQxGDqkLTlGxkPzTN+VoYUJlI/OuU0IJZ8=;
	b=oLeN7eW2SJJheRVLrP64qKAWC1cV4qxKr64rW29/TW1S558J3lK8kKLMwttmvvZEONTmI5
	+fyBM+yuoJR86GSSfyZvlQ6f+bf61a/AdB4mT24w97bttq1KUBzZjo4mAphrVOBiO50371
	yFmkxmDnI7sJ2xtyvBCScDcDxC3o49p8DC5/qua4SRIMw2VffsLh+70/Iw53I93E8yTboZ
	R02/3By19voR4nMYm3DLyU5g7uFY7UW97jjroXhYjPnU22FgIm3FohJ1WkRUjirYNEECOJ
	xzraihbauy/OBWxXAoqJk96+YGURa03c4ijtOfDjK9lQLzJh8OFya6Vxfea4Lw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 17:05:39 +0100
Subject: [PATCH net 2/3] net: dsa: microchip: Ensure a ksz_irq is
 initialized before freeing it
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-ksz-fix-v1-2-7e46de999ed1@bootlin.com>
References: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
In-Reply-To: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
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

Sometimes ksz_irq_free() can be called on uninitialized (or partially
initialized) ksz_irq. It leads to freeing uninitialized IRQ numbers
and/or domains.

Ensure that IRQ numbers or domains are initialized before freeing them.

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


