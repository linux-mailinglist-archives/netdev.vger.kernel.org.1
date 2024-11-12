Return-Path: <netdev+bounces-144173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B239C5E80
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA30281A0E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D0521A6E5;
	Tue, 12 Nov 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b7JZkzQ4"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA49219E23;
	Tue, 12 Nov 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431233; cv=none; b=eLbE5YIUTJijaCZZMrhEvUjgXKS7oSPlEeRmIwbvyEInJL9YSVaQOmvVCiM0uGG01v467q83SB2etvrHJU+mICZZ6J519YNr4acwcnMGLb6D4c1NuBXD9qIAnbUjVqeFURyI4z/L7OvjoQ3nCbhIaBlTiXqIebwYRH28rVwNeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431233; c=relaxed/simple;
	bh=QKZIsiG1W6OLDPkpY3/P7o6n4z4Z1M/nJkWNGlqucxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmO3+fpqR3KjfzuLxt4ygtEnZ5AxqGAH0r4Ocns4P4SFwbSGBPhrp6k/YzjuEGMI5FmsVD7jvWshGqJ4of+POeG+v/AtOQNzl7E8lSkmqXQnz6vMSqsMRF5yBJKjlYsrz756uvhQ5EzLa1ukSb1DSXAHhQr8ylbH47j69F99NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b7JZkzQ4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A03CE0004;
	Tue, 12 Nov 2024 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731431229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EItfCXpyQ9SbyuhvhonsXakXTzV8T8EN3PjTEaNk6PI=;
	b=b7JZkzQ4ljBkleE5Yy+NKv3WgCE+j8KI+op45holACfyYm/+RV7tbnKmx57+0Dny8UM0oN
	ksT5Uu0dPt+vKDZc/8xaGJyMm615ic4EpJ54+TyWvoWe/vTiXE4/qw2qt7hXvWnCsvDV+p
	eYf96z75fG+7QH8lcqP08KE3wGD0YNHOP0ovBTq5RuEUH1FVgjVO4rTBA3TPt95goaaGME
	XL17YjUL9BWBm+ifh01OFsivFnOpGtG/nT7dRxJnxfm4SXq5jHK0XXlwgQ2Vh5qQFMLEP3
	1va3xCvl+uJCXEq8XugnaWy8S4sLei4VPj8MM0xsoac7N9bD7BoNR6ur1MMCEA==
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
Subject: [PATCH net-next v4 8/9] net: stmmac: Configure only the relevant bits for timestamping setup
Date: Tue, 12 Nov 2024 18:06:56 +0100
Message-ID: <20241112170658.2388529-9-maxime.chevallier@bootlin.com>
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

The PTP_TCR (Timestamp Control Register) is used to configure several
features related to packet timestamping.

On one hand, it configures the 1588 packet processing, to indicate what
types of frames should be timestamped (all, only 1588v1 or 1588v2, using
L2 or L4 timestamping, on IPv4 or IPv6, etc.). This is congfigured
usually through the ioctl / ndo dedicated for such setup. This
configuration is done by setting some fields in that register, that seem
to behave the same way on all dwmac variants, including DWMAC1000.

On the other hand, and only on DWMAC1000 apparently, some fields in that
register are used to configure external snapshots (bits 24/25).
On DWMAC4 and others, these fields are reserved and external
snapshots are configured through a dedicated register that simply
doesn't seem to exist on DWMAC1000.

This configuration is done in the dwmac1000-specific ptp_clock_info ops
(cf dwmac1000_ptp_enable()).

So to avoid the timestamping configuration interfering with the external
snapshots, this commit makes sure that the config_hw_tstamping only
configures the relevant bits in PTP_TCR, so that the DWMAC1000
timestamping can correctly rely on these otherwise reserved fields.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index a94829ef8cfb..0f59aa982604 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -18,9 +18,22 @@
 #include "dwmac4.h"
 #include "stmmac.h"
 
+#define STMMAC_HWTS_CFG_MASK	(PTP_TCR_TSENA | PTP_TCR_TSCFUPDT | \
+				 PTP_TCR_TSINIT | PTP_TCR_TSUPDT | \
+				 PTP_TCR_TSCTRLSSR | PTP_TCR_SNAPTYPSEL_1 | \
+				 PTP_TCR_TSIPV4ENA | PTP_TCR_TSIPV6ENA | \
+				 PTP_TCR_TSEVNTENA | PTP_TCR_TSMSTRENA | \
+				 PTP_TCR_TSVER2ENA | PTP_TCR_TSIPENA | \
+				 PTP_TCR_TSTRIG | PTP_TCR_TSENALL)
+
 static void config_hw_tstamping(void __iomem *ioaddr, u32 data)
 {
-	writel(data, ioaddr + PTP_TCR);
+	u32 regval = readl(ioaddr + PTP_TCR);
+
+	regval &= ~STMMAC_HWTS_CFG_MASK;
+	regval |= data;
+
+	writel(regval, ioaddr + PTP_TCR);
 }
 
 static void config_sub_second_increment(void __iomem *ioaddr,
-- 
2.47.0


