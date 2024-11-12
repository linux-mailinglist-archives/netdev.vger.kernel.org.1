Return-Path: <netdev+bounces-144171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 745659C62A1
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4311FB4771A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E0219E2A;
	Tue, 12 Nov 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ytekury5"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29E217905;
	Tue, 12 Nov 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431231; cv=none; b=CP43rzJmgLc66OD6DJZlGx3rwJdGD5NErI/4yi6taqo+0YP6Mt7Zuk7+zc7LFTRrvgR/g2/jRQRwmegbqw1jaFnKsDpR9zzL5T7UAJT0EF9Ke5R87xWiJZIsS6EZpUZSB5yQOEYRfTBHGqnFFFkfbLBN+IqPrhsQCVEfR+mOlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431231; c=relaxed/simple;
	bh=eLjWcDHkfciiegfslYMvZGgOofNetPEeUABVo92Xx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2t9G+UT2gGuyNMHVBxv+P0+Sg4UfE//PJIcYNoVxo7XZxVTiDmbB6PsSZa0nz5uvqEJ9OybwExbzqv5suy2IAU8XSQu42v/GjhnQmuO4Jzx6yd4VSD6mLjP/p6t2lha8V7J7hNVhaVNQsF+VPbSN/nFzXaM9TRxlKp6jGrSeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ytekury5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC671E000D;
	Tue, 12 Nov 2024 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731431227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpUCuhSkHtWF9OeH4XyNxAJf2CxJ+XC2B1fk8Kli6Z0=;
	b=Ytekury5gdFXSXmU+zzqb3irnJBxDuDcnfrJdrj4fdYJXDSebxzyEp/hsM5/kagAJqaJfO
	EyCXhyj8U4qBc8txVs8HkBrkRCca1uhLekoBlSF64Hyu7Ui/toUTbcw93d4fwzcemrj2sW
	15f+YJ72AYKqXXLFse8o5gIvmPVgI2Ykjdj9CvxfR5lgRoiu8BrQRoBf7o7R4OrfYzXe14
	s8Gj9mq8+GBgVPJ45ikw9plxtWgM1v0kQdZ23QL0BK8z1DUxBZlUwamarEldeiluiYtYt8
	lx4abxj5c42AfQQYDWRl61ZDtKZjaawT5No03O6ZH+lkfIv3UuiZIFMV+iSUdA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 6/9] net: stmmac: Enable timestamping interrupt on dwmac1000
Date: Tue, 12 Nov 2024 18:06:54 +0100
Message-ID: <20241112170658.2388529-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
References: <20241112170658.2388529-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The default configuration for the interrupts on dwmac1000 have the
timestamping interrupt masked. Now that the timestamping has been
adapted to dwmac1000, enable the timestamping interrupt on these
platforms.

On dwmac1000, the external snapshot interrupt is configured through a
dedicated bit, that is set as reserved on other dwmac variants. The
timestaming interrupt is acknowledged by reading the
GMAC3_X_TIMESTAMP_STATUS register.

Make sure that this interrupt is enabled when snapshot is enabled, and
masked when disabled.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 73bba4fdc2e4..96bcda0856ec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -595,6 +595,20 @@ void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv)
 
 /* DWMAC 1000 ptp_clock_info ops */
 
+static void dwmac1000_timestamp_interrupt_cfg(struct stmmac_priv *priv, bool en)
+{
+	void __iomem *ioaddr = priv->ioaddr;
+
+	u32 intr_mask = readl(ioaddr + GMAC_INT_MASK);
+
+	if (en)
+		intr_mask &= ~GMAC_INT_DISABLE_TIMESTAMP;
+	else
+		intr_mask |= GMAC_INT_DISABLE_TIMESTAMP;
+
+	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+}
+
 int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 			 struct ptp_clock_request *rq, int on)
 {
@@ -628,6 +642,8 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 					 10, 10000);
 
 		mutex_unlock(&priv->aux_ts_lock);
+
+		dwmac1000_timestamp_interrupt_cfg(priv, on);
 		break;
 
 	default:
-- 
2.47.0


