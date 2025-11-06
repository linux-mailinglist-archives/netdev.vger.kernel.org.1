Return-Path: <netdev+bounces-236354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EC9C3B156
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26C8562922
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836C334697;
	Thu,  6 Nov 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g3EOW+eG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7432C951
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433605; cv=none; b=ZET1cmE3naD+fQ599D79yp0uCBV7uFYTSnF0cPA3LclbERoD2BwhJvrQhNEhTWxInVoz/DoQWpbofxo4MVvdVDwGWdXF5aQVXN/vOPuMTvXSwq9tFCuxtP7g6HnGfN47YCKV12+looziV0w5CZr2QcjEcaDi5ND5AUiAfTaA1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433605; c=relaxed/simple;
	bh=DgaEBzJVE0diUpcGF2jdqQ0yAib13/RGrDpfzFmIiKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFImQ+OtET1qJ7qmnzM8oeH+YTRH5mrbw9jlYmxXM0kB6/O8G/uZAn3i0d4dEosjQmWutmk2svWEoKTzrerrLRwqfDepWku45XCkIFfQSx6TdXlU1sbMQQmqZGRx4BsbeP2I3jeTap5cLVOueTykQFDdWOa2eY4rGmwKstTBZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g3EOW+eG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56FEC1A18F6;
	Thu,  6 Nov 2025 12:53:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B4CB6068C;
	Thu,  6 Nov 2025 12:53:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CED71185102A;
	Thu,  6 Nov 2025 13:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762433598; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U52A0foBkCvgyCUwDdVQ7zTmGiYooyVZixhAGJ0JZp4=;
	b=g3EOW+eGxuVNT5I+V9nxHKZM18Y6DjUN+oYkr6K8uOh0+Z5Rng0mL9EF/XsCp3l0I4El5Z
	RvoQOXMJ/w7MKzF3mkM3EGSlvcRbULcte5qOoyAzckRtS5hgQ43f4QMtxnnZaxGvukc7PZ
	5HdWDsprEhGYHT5dja3XpvBzXtsTdzI9zi6PPfSSpte81N4lXW8XNBE2KpoNStGU6GnfF1
	IQ3XYO6Xh5vATkXfiqEQEFUksRAI/rzX4MLVG/CX1wcwfaUDv5/vPPvbyhvkmgA5d7oGG/
	FYUnzoyFn6oXilNo/lrzmIMR/lmQ/Hr6M35hI+dM5WURyht8M+NMzffiZq9oAg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 06 Nov 2025 13:53:09 +0100
Subject: [PATCH net v2 2/4] net: dsa: microchip: ptp: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ksz-fix-v2-2-07188f608873@bootlin.com>
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

irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
but it never returns a negative value. However, during the PTP IRQ setup,
we verify that its returned value isn't negative.

Fix the irq_find_mapping() check to enter the error path when 0 is
returned. Return -EINVAL in such case.

Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 35fc21b1ee48a47daa278573bfe8749c7b42c731..c8bfbe5e2157323ecf29149d1907b77e689aa221 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1139,8 +1139,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		irq_create_mapping(ptpirq->domain, irq);
 
 	ptpirq->irq_num = irq_find_mapping(port->pirq.domain, PORT_SRC_PTP_INT);
-	if (ptpirq->irq_num < 0) {
-		ret = ptpirq->irq_num;
+	if (!ptpirq->irq_num) {
+		ret = -EINVAL;
 		goto out;
 	}
 

-- 
2.51.0


