Return-Path: <netdev+bounces-110159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C092B213
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D19B22302
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE543154C16;
	Tue,  9 Jul 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRqZBPEJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342B154BFF;
	Tue,  9 Jul 2024 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513395; cv=none; b=Ob4dkFFhYmLWROmsSIL8QQ8FyHXeAl3iqmo9hOgxi+UFnIjcglbslDXteQEiGHcipzwComG4kSZMcNI+Ol5+CyDVxmR/OulxMvlmWREWqqin8m4O9JExhhHSvKbewXrWUplC5ZutzUjhrmgYg3YWXh2VtE/BVbF8PUAlvtvLZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513395; c=relaxed/simple;
	bh=j3+Fqcv4SuXIX+AP4voaXbaU8e6nuOk+mCcXfqpFsQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8ioURXyyBvVkvEZmJ1h8+5blPbKdUsSkypK4C8IljDlCVoGsIevG7GJ5wobkKv9g7/6w/mpd/0aQD3gdxeEAuVdVkzrIqwjnWE8HGalkhsP8cRsEyNcu2fJAvMQvAFIEbsPyc+p7Vgjs0IL5Q63pXuPOkPOz+JL7AQIGcPEVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRqZBPEJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af8128081so3025011b3a.1;
        Tue, 09 Jul 2024 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513394; x=1721118194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29S9tCNcE/YwkqoQYa1nGmQDJhmHQQbSPi7L9uy3DQY=;
        b=IRqZBPEJFY9RXYKtf/Qc4MLqdEnwUMyA59bFP5qIDPy6vnwxz7BnwazBoX1UrBAj8C
         Gp+PaAbs4dd7U1us62rSyvtyK+6yttsf02/+CVjJlb7o5c538me8Bxuh+hG8F4DhtqTx
         mU0AI9KUx5rG+4sY5X/ZLM/NWaFTvE6nLZGzAsgA8zQbRdkmLaxHPwHLjY0lyyHij2lP
         DYyDfBzfcmUgVu1gtT+MypEG1rGe1StN0ktBpuPSVFeXzYp6HQx7WLnqj6ajOJA67Ldt
         hotnOhydiKTAhiPGH0EkYKk8QWMFkBvXoVEM9zAnC4VS7t7Uc050rT6/DC1Uq6/d8HxE
         KWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513394; x=1721118194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29S9tCNcE/YwkqoQYa1nGmQDJhmHQQbSPi7L9uy3DQY=;
        b=cut0SCz/fxk0bjHxHEhK3mXT54ZCMRihRdBvL/0+9Wig9f2RonENcLUjkKv32F+uhy
         EpkhrxdoLlALhfGvsZ0qi5IN7X5RiwbdJpLSIBVeEShllZQjXi/3W5cGynjT5OSVsKhS
         oADpjxDqn4iaSQIwaWELC9QUq5r9574BGYleX0nuDXGlKccFOOS5l63DVyHaO61PcxyB
         Av499nTTwW+YX/W3YC0SP6my4Rc/pikf1Pz8sS9vw7p1duELEuGzLx0AyS3wPb0wCZyi
         ba72PhwnZpTjrbj7fglqjCz1QPWDp2OChGMT6Y1CqWTma/1wSGTNGNHRniWD5alAg8PV
         OLRA==
X-Forwarded-Encrypted: i=1; AJvYcCXCXzAiwzOToQpWS9SR2PvmGFwkghXs6PCnN13YXnASkh++ce0YgfV2x67DxtHNRP2PpfAaL0IjKtoAFj1jgOe2a1VJv0mC8++SpEcu
X-Gm-Message-State: AOJu0YzJb6X6jCcrLaYG9v5ZcimFsj3sBgv5mar8q3kXid1UxehQNF+g
	ImEIPbDDd0F4+nSUJzE+XgnqHgr1BioV/u9PQazBmIIjDPJqBJq1f4LQbw==
X-Google-Smtp-Source: AGHT+IFP7v9XA+038juiIKo9wMYKaZosf3yLoyyuExumRzoZB0Txu2gnsXX83zEVAqRtpk376wQ+bg==
X-Received: by 2002:a05:6a20:db0c:b0:1c2:93a7:2541 with SMTP id adf61e73a8af0-1c29822d122mr1658758637.24.1720513393543;
        Tue, 09 Jul 2024 01:23:13 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:23:13 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 4/7] net: stmmac: gmac4: complete FPE support
Date: Tue,  9 Jul 2024 16:21:22 +0800
Message-Id: <7cc2f0bd9216a4d34b6a937c22a14acc7e6cc5b2.1720512888.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720512888.git.0x1207@gmail.com>
References: <cover.1720512888.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce dwmac4_fpe_ops to complete the FPE implementation for DWMAC4

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  2 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 85 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  2 +
 4 files changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index fc9f58f44180..655012ffbc0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -216,6 +216,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwmac4_fpe_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
@@ -236,6 +237,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwmac4_fpe_ops,
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index bd360f3ea784..7b19614c611d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -685,6 +685,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
 extern const struct stmmac_est_ops dwmac510_est_ops;
+extern const struct stmmac_fpe_ops dwmac4_fpe_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index f6701ba93805..97e404fac56a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -6,4 +6,89 @@
 
 #include "stmmac.h"
 #include "stmmac_fpe.h"
+#include "dwmac4.h"
 
+static int __fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+{
+	u32 value;
+	int status;
+
+	status = FPE_EVENT_UNKNOWN;
+
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
+	value = readl(ioaddr);
+
+	if (value & FPE_CTRL_STS_TRSP) {
+		status |= FPE_EVENT_TRSP;
+		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
+	}
+
+	if (value & FPE_CTRL_STS_TVER) {
+		status |= FPE_EVENT_TVER;
+		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+	}
+
+	if (value & FPE_CTRL_STS_RRSP) {
+		status |= FPE_EVENT_RRSP;
+		netdev_info(dev, "FPE: Respond mPacket is received\n");
+	}
+
+	if (value & FPE_CTRL_STS_RVER) {
+		status |= FPE_EVENT_RVER;
+		netdev_info(dev, "FPE: Verify mPacket is received\n");
+	}
+
+	return status;
+}
+
+static void __fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			       enum stmmac_mpacket_type type)
+{
+	u32 value = cfg->fpe_csr;
+
+	if (type == MPACKET_VERIFY)
+		value |= FPE_CTRL_STS_SVER;
+	else if (type == MPACKET_RESPONSE)
+		value |= FPE_CTRL_STS_SRSP;
+
+	writel(value, ioaddr);
+}
+
+static void dwmac4_fpe_configure(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
+				 u32 num_txq, u32 num_rxq, bool enable)
+{
+	u32 value;
+
+	if (enable) {
+		cfg->fpe_csr = FPE_CTRL_STS_EFPE;
+		value = readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &= ~GMAC_RXQCTRL_FPRQ;
+		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr = 0;
+	}
+
+	writel(cfg->fpe_csr, ioaddr + FPE_CTRL_STS_GMAC4_OFFSET);
+}
+
+static int dwmac4_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+{
+	return __fpe_irq_status(ioaddr + FPE_CTRL_STS_GMAC4_OFFSET, dev);
+}
+
+static void dwmac4_fpe_send_mpacket(void __iomem *ioaddr,
+				    struct stmmac_fpe_cfg *cfg,
+				    enum stmmac_mpacket_type type)
+{
+	__fpe_send_mpacket(ioaddr + FPE_CTRL_STS_GMAC4_OFFSET, cfg, type);
+}
+
+const struct stmmac_fpe_ops dwmac4_fpe_ops = {
+	.configure = dwmac4_fpe_configure,
+	.irq_status = dwmac4_fpe_irq_status,
+	.send_mpacket = dwmac4_fpe_send_mpacket,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index 84e3ceb9bdda..efdb5536e856 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -4,6 +4,8 @@
  * stmmac FPE(802.3 Qbu) handling
  */
 
+#define FPE_CTRL_STS_GMAC4_OFFSET	0x00000234
+
 #define FPE_CTRL_STS_TRSP		BIT(19)
 #define FPE_CTRL_STS_TVER		BIT(18)
 #define FPE_CTRL_STS_RRSP		BIT(17)
-- 
2.34.1


