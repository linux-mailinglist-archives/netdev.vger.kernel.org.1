Return-Path: <netdev+bounces-142278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D39BE1AB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA4A1F2217A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623361DDA0E;
	Wed,  6 Nov 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dMiJmSrz"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C31DC1A7;
	Wed,  6 Nov 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883826; cv=none; b=NTDrUx0s4Qlb+vW6S236CXTxQFG99ypf0jD2PzFUigKpCSIuBuZpSQow0eDuWAfItXRvnG5GlvhwTKcplpUhXt+Y6E2tEeOr3hnWSizcQHyrkWJ1B6O2PmkSRnnQPiVzcY0gXxmyA/InOuMT/tMJyIrGryfV3bJYs66XdWtPjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883826; c=relaxed/simple;
	bh=L7+YOJA9BbsV2tyTIEWCcTOVQjJKDvOb9EFArgvsLrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwpM87xb4USbkJVMUeZrvhx0TO1yArjV5xX65sWBPA5pJXDb92Nwg7wZRU4gybVd20EkFcweV+SNB7eAN85rIwcUaSWbh6V5V8YE2flXhZYLta4oeGdAkBs58m+93LLoF6hr8sBtiyWrR9Sou8kFPKzRiqEd8qMwDGMB9+QrTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dMiJmSrz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09AC8C0005;
	Wed,  6 Nov 2024 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YY/BFgC6bGU8aHXsQwu5u3ZdGvQcTEQGF6Gva3LQNL4=;
	b=dMiJmSrzFewBNUuaWceqSLWR6fRO6pEH+oboc1R+HHxvzd0ut92rEWa4JprfE9CroX+2bp
	AsZpRjTE8mfc7mLFseC2uRnFeOcy/qsomBMgUmkICslYODjuq2OAxHR9dg15ulRAbVviV2
	yNaNBv6hX0o3IWdwqcmh9mM6RrZ94kvBWjAbirbiB3e1axiqrC4aIWjlLKtI+1G+GsMWSI
	0DlQ2v3IAjdilxUK69KzKqY4f2T5KCjpUS11BKogwZcwLHom+X0C+7CCQNvB+k1gYWw529
	irEZkMTrx9geAsaQgb9eFCaVG1py5MtwJp+QbA93GEr8DJprbcTB1IuJOCRcKA==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 8/9] net: stmmac: Configure only the relevant bits for timestamping setup
Date: Wed,  6 Nov 2024 10:03:29 +0100
Message-ID: <20241106090331.56519-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
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


