Return-Path: <netdev+bounces-139895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F036C9B48BF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA31E283DF4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB7206972;
	Tue, 29 Oct 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FvHDWDN8"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B487205AD1;
	Tue, 29 Oct 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202877; cv=none; b=IU1LMc/IPG+7TtnqXCjZ68iHY3xZgRGJ/wF42QaMIzThePUzgpvHGVEKXSlmudJJsICdd+sjJIUAdvBKDS90rDzgYTOkmHcMat1pqqJX5Kro9lrGq6RxJpXQGRgIjGVzMdYaqIXZSjpztdK3WTdalOXxjJQ9ykdmOMPIxiKOH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202877; c=relaxed/simple;
	bh=omShkOpsn6KA+YWJm9eDfu6oDGmPjXsDM4c64AYJmxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rur+fnFH3ZWjVmpxOBkfXqF2vXmqtIbR6joy0o5V0/Pe5W7dJR+mYQqSdKgZAysLREFXK2of60GJwzuHaT+dZGonNSDc895kkgW1i+tOcpexxFdX5PHPdZgwR2995oeQc7ZzL4WkUVkpNID8DMtMU5GC9CDPxDj13uoA3GQOj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FvHDWDN8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB5491C0005;
	Tue, 29 Oct 2024 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730202866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4VyTp5+y/e+0m/mVUXyvUDk3HWSlqTKu4UNCW+JxDU=;
	b=FvHDWDN89BVFjjEkthTWcdZSSaK3bhl/5W3r1QfylC7mrxK4uERpCunKwJNsNnBk/U86ZD
	veXTUNKeI/E0LdseKS6oDh9zhVS2sqr3yDAJmuIzyIszKohARgVaFJVkJDqxJAYUugKw52
	oK/zyNP26/u7QLeathbhL5exvlL/h32MpKUFcdqDRtYyKyRbTc7gKO17H+TU9eHZOh05Bk
	UU6ZHGppgI8j4P7kiD9PcYKFf08MSmG8ahEyBGBF7D9gTzaQzc8I8pcD+mcVrSE3qXPRu7
	fXo6D3xJjdtl+Wmo8suuVIOfQZzRNfBGKC4mpDYexXZ5Gv40cEGKAck7dnIzYQ==
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
Subject: [PATCH net-next 4/7] net: stmmac: Introduce dwmac1000 ptp_clock_info and operations
Date: Tue, 29 Oct 2024 12:54:12 +0100
Message-ID: <20241029115419.1160201-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The PTP configuration for GMAC3_X differs from the other implementations
in several ways :

 - There's only one external snapshot trigger
 - The snapshot configuration is done through the PTP_TCR register,
   whereas the other dwmac variants have a dedicated ACR (auxiliary
   control reg) for that purpose
 - The layout for the PTP_TCR register also differs, as bits 24/25 are
   used for the snapshot configuration. These bits are reserved on other
   variants.

On GMAC3_X, we also can't discover the number of snapshot triggers
automatically.

The GMAC3_X has one PPS output, however it's configuration isn't
supported yet so report 0 n_per_out for now.

Introduce a dedicated set of ptp_clock_info ops and configuration
parameters to reflect these differences specific to GMAC3_X.

This was tested on dwmac_socfpga.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |  5 +++
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 45 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 18 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  6 +++
 6 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 4a0a1708c391..6f68a6b298c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -552,6 +552,7 @@ extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
 extern const struct ptp_clock_info stmmac_ptp_clock_ops;
+extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
 
 struct mac_link {
 	u32 caps;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 4296ddda8aaa..01eafeb1272f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -329,5 +329,10 @@ enum rtc_control {
 #define GMAC_MMC_RX_CSUM_OFFLOAD   0x208
 #define GMAC_EXTHASH_BASE  0x500
 
+/* PTP and timestamping registers */
+
+#define GMAC_PTP_TCR_ATSFC	BIT(24)
+#define GMAC_PTP_TCR_ATSEN0	BIT(25)
+
 extern const struct stmmac_dma_ops dwmac1000_dma_ops;
 #endif /* __DWMAC1000_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index d413d76a8936..b6930009ea06 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
+#include "stmmac_ptp.h"
 #include "dwmac1000.h"
 
 static void dwmac1000_core_init(struct mac_device_info *hw,
@@ -551,3 +552,47 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 
 	return 0;
 }
+
+/* DWMAC 1000 ptp_clock_info ops */
+
+int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
+			 struct ptp_clock_request *rq, int on)
+{
+	struct stmmac_priv *priv =
+	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
+	void __iomem *ptpaddr = priv->ptpaddr;
+	int ret = -EOPNOTSUPP;
+	u32 tcr_val;
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_EXTTS:
+		mutex_lock(&priv->aux_ts_lock);
+		tcr_val = readl(ptpaddr + PTP_TCR);
+
+		if (on) {
+			tcr_val |= GMAC_PTP_TCR_ATSEN0;
+			tcr_val |= GMAC_PTP_TCR_ATSFC;
+			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
+		} else {
+			tcr_val &= ~GMAC_PTP_TCR_ATSEN0;
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+		}
+
+		netdev_dbg(priv->dev, "Auxiliary Snapshot %s.\n",
+			   on ? "enabled" : "disabled");
+		writel(tcr_val, ptpaddr + PTP_TCR);
+
+		mutex_unlock(&priv->aux_ts_lock);
+
+		/* wait for auxts fifo clear to finish */
+		ret = readl_poll_timeout(ptpaddr + PTP_TCR, tcr_val,
+					 !(tcr_val & GMAC_PTP_TCR_ATSFC),
+					 10, 10000);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index caa8d9810cd3..4af6a5fceb20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -134,7 +134,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac100_dma_ops,
 		.mac = &dwmac100_ops,
 		.hwtimestamp = &stmmac_ptp,
-		.ptp = &stmmac_ptp_clock_ops,
+		.ptp = &dwmac1000_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
 		.mmc = &dwmac_mmc_ops,
@@ -153,7 +153,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac1000_dma_ops,
 		.mac = &dwmac1000_ops,
 		.hwtimestamp = &stmmac_ptp,
-		.ptp = &stmmac_ptp_clock_ops,
+		.ptp = &dwmac1000_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
 		.mmc = &dwmac_mmc_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 8ea2b4226234..430905f591b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -282,6 +282,24 @@ const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.getcrosststamp = stmmac_getcrosststamp,
 };
 
+/* structure describing a PTP hardware clock */
+const struct ptp_clock_info dwmac1000_ptp_clock_ops = {
+	.owner = THIS_MODULE,
+	.name = "stmmac ptp",
+	.max_adj = 62500000,
+	.n_alarm = 0,
+	.n_ext_ts = 1,
+	.n_per_out = 0,
+	.n_pins = 0,
+	.pps = 0,
+	.adjfine = stmmac_adjust_freq,
+	.adjtime = stmmac_adjust_time,
+	.gettime64 = stmmac_get_time,
+	.settime64 = stmmac_set_time,
+	.enable = dwmac1000_ptp_enable,
+	.getcrosststamp = stmmac_getcrosststamp,
+};
+
 /**
  * stmmac_ptp_register
  * @priv: driver private structure
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index fce3fba2ffd2..fa4611855311 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -94,4 +94,10 @@ enum aux_snapshot {
 	AUX_SNAPSHOT3 = 0x80,
 };
 
+struct ptp_clock_info;
+struct ptp_clock_request;
+
+int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
+			 struct ptp_clock_request *rq, int on);
+
 #endif	/* __STMMAC_PTP_H__ */
-- 
2.47.0


