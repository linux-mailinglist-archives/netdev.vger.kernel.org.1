Return-Path: <netdev+bounces-250234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A903D25896
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAE7C303E019
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A293B5302;
	Thu, 15 Jan 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HOv2LhlV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E213A4AA8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492634; cv=none; b=o3OUtHPLXUAKUrX2SOTFCX1C/ytT2ZHB0UeLo3lx0IxvSNAg1LF1LUQ6i0BlQzjbaFHt0bcfng+divqRmwkWRXglofYI/+2hKqlka5IOM6VZNg1OLPKZdUIPeQEhU/xAhSP2GUqgy7r6Ig15LXQRjt9LZ29vtSt3QbbBRzS2Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492634; c=relaxed/simple;
	bh=N3ryQbGEWD3cPHtfikuGqfoTM8sOAlPC0aYgdbP0Wxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHKvC6NifMtXiebK7RNX2SsOP3Ib7uwETdCUoPdLNJHqjc6fX4rBQ1fqCDTtCAs0TU5q+kfjaA/99jfWChPBGSn+DNqGqXtKOTVsvtpPzjHGhnUi5h0kNC3AWXCGd8ZqHrDPVfa9HgFXA5Jk+tmK4niT8VRZbA01J+xumcMLSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HOv2LhlV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 791C81A2883;
	Thu, 15 Jan 2026 15:57:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F479606E0;
	Thu, 15 Jan 2026 15:57:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB97F10B686B7;
	Thu, 15 Jan 2026 16:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gkMPdwGfu8X4F3+hrF5ewptOuduz1YxWL/Ffa1MnO38=;
	b=HOv2LhlV3WCO+Kx5dww09cxJXRaHQ4wZRDop66U4vUXr/g7IWrwYx+hE5qkRZ5Gn15Ap5J
	I61hGD2lFqPpfMm7mnzn8epFegBPDTE1MwqhlmRDIWZ2whso780TlKOi+IMpfFgoBmM/hM
	BPNYG/dOikJ5mVFAcfmhoVlg7RwjhKjsBwRETsE/1N4DENzGI4vwR1IpK45QFyyQTicoeT
	phZlZkBKMPgFPNI7/etyLg/vaPDLin+vS3t/Lt7jQQDoxgy0o4eeW+WPYWWmfbVPIkEieX
	da0zyOwZRhlMEBdZ5mx1H1V7O1QLXbXvcOKm8RRFpFz2vsexbzHlBtQULDlCzQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:00 +0100
Subject: [PATCH net-next 1/8] net: dsa: microchip: Add support for KSZ8463
 global irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-ksz8463-ptp-v1-1-bcfe2830cf50@bootlin.com>
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

KSZ8463's interrupt scheme differs from the others KSZ swicthes. Its
global interrupt handling is done through an 'enable irq' register
instead of a 'mask irq' one, so the bit logic to enable/disable
interrupt is reversed. Also its interrupts registers are 16-bits
registers and don't have the same address.

Add ksz8463-specific global interrupt setup function that still relies
on the ksz_irq_common_setup().
Add a check on the device type in the irq_chip operations to adjust the
bit logic for KSZ8463

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 40 +++++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz_common.h |  3 +++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e5fa1f5fc09b37c1a9d907175f8cd2cd60aee180..82ec7142a02c432f162e472c831faa010c035123 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2817,14 +2817,20 @@ static void ksz_irq_mask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked |= BIT(d->hwirq);
+	if (ksz_is_ksz8463(kirq->dev))
+		kirq->masked &= ~BIT(d->hwirq);
+	else
+		kirq->masked |= BIT(d->hwirq);
 }
 
 static void ksz_irq_unmask(struct irq_data *d)
 {
 	struct ksz_irq *kirq = irq_data_get_irq_chip_data(d);
 
-	kirq->masked &= ~BIT(d->hwirq);
+	if (ksz_is_ksz8463(kirq->dev))
+		kirq->masked |= BIT(d->hwirq);
+	else
+		kirq->masked &= ~BIT(d->hwirq);
 }
 
 static void ksz_irq_bus_lock(struct irq_data *d)
@@ -2840,7 +2846,10 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
+	if (ksz_is_ksz8463(dev))
+		ret = ksz_write16(dev, kirq->reg_mask, kirq->masked);
+	else
+		ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
@@ -2890,14 +2899,14 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
 	unsigned int nhandled = 0;
 	struct ksz_device *dev;
 	unsigned int sub_irq;
-	u8 data;
+	u16 data;
 	int ret;
 	u8 n;
 
 	dev = kirq->dev;
 
 	/* Read interrupt status register */
-	ret = ksz_read8(dev, kirq->reg_status, &data);
+	ret = ksz_read16(dev, kirq->reg_status, &data);
 	if (ret)
 		goto out;
 
@@ -2939,6 +2948,22 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	return ret;
 }
 
+static int ksz8463_girq_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	struct ksz_irq *girq = &dev->girq;
+
+	girq->nirqs = 15;
+	girq->reg_mask = KSZ8463_REG_IER;
+	girq->reg_status = KSZ8463_REG_ISR;
+	girq->masked = 0;
+	snprintf(girq->name, sizeof(girq->name), "global_irq");
+
+	girq->irq_num = dev->irq;
+
+	return ksz_irq_common_setup(dev, girq);
+}
+
 static int ksz_girq_setup(struct ksz_device *dev)
 {
 	struct ksz_irq *girq = &dev->girq;
@@ -3044,7 +3069,10 @@ static int ksz_setup(struct dsa_switch *ds)
 	p->learning = true;
 
 	if (dev->irq > 0) {
-		ret = ksz_girq_setup(dev);
+		if (ksz_is_ksz8463(dev))
+			ret = ksz8463_girq_setup(ds);
+		else
+			ret = ksz_girq_setup(dev);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de5254defdc1afb52b224b3898233b..67a488a3b5787f93f9e2a9266ce04f6611b56bf8 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -839,6 +839,9 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ87XX_INT_PME_MASK		BIT(4)
 
 /* Interrupt */
+#define KSZ8463_REG_ISR			0x190
+#define KSZ8463_REG_IER			0x192
+
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
 

-- 
2.52.0


