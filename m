Return-Path: <netdev+bounces-238608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C84FC5BC37
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952543A71F8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F62F25E6;
	Fri, 14 Nov 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fEVKbwMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE34288514
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104838; cv=none; b=l1fPR3upxMPYrSNxVfcUnfwnWY5fQ5V29YfiN5knv/A1y+31Ih+CzNLWFzD7Q8Xq2ZkHMd1dVI3W4G8NYohM5JHib1Ce6mPnkTwqgZ47cLjzmt5umdL0btAxhBCdiiksonOm8Ol4E/s0GUmDXoDCWbx5net+vuE9jloK47/Zf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104838; c=relaxed/simple;
	bh=bA81shltpQIqo6ERwe+YEEDiuPrqc/y6ChY0B4cSbI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1SJzdhLULmqG9L8yfaiauCzmrxvTK7BwtjS9GU0JWN5KqaF2vCHz9weNZWlyYKFSgPV+qnCkmPE8NP4EtbWBhT6t72ezbhmqy/WjpCPxVqrlXD6Q6TmU6CMwhmMyt2VRgkq+/14T9iwMh+6AtwcuJnf4g+Bc82Dbh0qJOmDiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fEVKbwMf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0379A1A1A95;
	Fri, 14 Nov 2025 07:20:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE2E56060E;
	Fri, 14 Nov 2025 07:20:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B198A102F27C7;
	Fri, 14 Nov 2025 08:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763104828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JWi0y84NUpIkh/iErh4hngLnIokL0fky07nZkrhPRJc=;
	b=fEVKbwMfVc7aKOdKe4z+6mtD+AyLbUv/ysVYDkAkX0X5qo1FvJGhq+oHAwYJ84shynfYCT
	ZHn0Phc3qn/rI7gyQwKtN4AxuOWjZIBFMlA3ZyWowXIjuC0EptssI0OwzPaLQ9ucuphKs2
	e2MNUrE7hn3pgeZcwb5eeQZIBQA+tYfoELq2uhsE6h6cHvW2EKlA8cdm12iAXDrN/5Koe+
	qYtckMU7Z6Uo9LwKY7Rc8iPTuJqTh3Mm0DX66Xk649qvg4TgyxkgwOfuOgYpADvt0+uJFM
	eZKWYYrpJoiRwUGAImB4Vsbmc2OpjXIZdD81Ps/odSoMJP14bTC1WKx1Cp0bhA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 14 Nov 2025 08:20:20 +0100
Subject: [PATCH net v3 1/4] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-ksz-fix-v3-1-acbb3b9cc32f@bootlin.com>
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

irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
but it never returns a negative value. However, on each
irq_find_mapping() call, we verify that the returned value isn't
negative.

Fix the irq_find_mapping() checks to enter error paths when 0 is
returned. Return -EINVAL in such cases.

Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a962055bfdbd8fbfc135b2dec73c222a213985c4..3a4516d32aa5f99109853ed400e64f8f7e2d8016 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2583,8 +2583,8 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 
 			irq = irq_find_mapping(dev->ports[port].pirq.domain,
 					       PORT_SRC_PHY_INT);
-			if (irq < 0) {
-				ret = irq;
+			if (!irq) {
+				ret = -EINVAL;
 				goto out;
 			}
 			ds->user_mii_bus->irq[phy] = irq;
@@ -2948,8 +2948,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	snprintf(pirq->name, sizeof(pirq->name), "port_irq-%d", p);
 
 	pirq->irq_num = irq_find_mapping(dev->girq.domain, p);
-	if (pirq->irq_num < 0)
-		return pirq->irq_num;
+	if (!pirq->irq_num)
+		return -EINVAL;
 
 	return ksz_irq_common_setup(dev, pirq);
 }

-- 
2.51.1


