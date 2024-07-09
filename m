Return-Path: <netdev+bounces-110157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF192B20D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996F6281CF0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F39152790;
	Tue,  9 Jul 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEikvHgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A515252D;
	Tue,  9 Jul 2024 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513385; cv=none; b=kTz+Oy5fLYIAn/LrDL253iQmAk7rPEPb0A74j0bpUFlAOoA5I1PuVLq/2oATuELaH8K1OIxjpoBAYQV3vfREICFew3rp84V5Cp02bdcna7+pqPGZ/wj7uhC1at7LrVArol6zS4TVZd8gkWyczPoEsEloSgQS9YFdV8F3mSuRvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513385; c=relaxed/simple;
	bh=PF04ATtnNRqM/BWo/fqGDFpvk1WaS+H8YY782xKK+UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ui6yDgPQnyCuwo3oLAHHexBHBe6rvh3GKwqcGV8vfTTK5qyruizrIUR2WD0xSGQ8zfalGA6Y9HiEH8wJj8Keqx59rl65LuenXMAAnk8/JB76dGKprmdIjmDaMxPOA/2XJSdQG8hYF3NKxlsQEqLyL5zN4AkX/0lmfIVfDBCEe4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEikvHgQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so2777909a91.3;
        Tue, 09 Jul 2024 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513384; x=1721118184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbCdNehdkqlQo0sbLo5ceHBxjJlaQK9zcub8z/dtnZ8=;
        b=HEikvHgQNMjPv2cQGX0xhOejHUGqMY7teuXaL/PS9OkFQkmXbgCAX6+mADmq/deLlr
         7hojfoNPkKI5qU0QSy1vjz4P9NMsXSP0voiMaX0xLlEC5UK/IgBxX0ZzTNSXoFM3xXyn
         c6mHWfjdc2Ngj6gEQQFPX+uAqGxggRjZDtQ0E2tGkb3a0lTfX/ofHdgXmWnZ/N+j6pdb
         jWmkWuARTIAp9W+dI5R860Plt04hiotsLulf2QNIQQ2bjjLhgp8ZzHUrtXzbhgxp8vK/
         vfQpLjC88rh4bG5g1zkk8ttHlAH1mwzT3ZabCu2dR+buYSJynCe+8yDRxlk6JLRJRFMD
         xBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513384; x=1721118184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbCdNehdkqlQo0sbLo5ceHBxjJlaQK9zcub8z/dtnZ8=;
        b=JQdkBAQBWJAPy4CtJ8MneefghDikQf3aNEKaabGaX9EMrM0fB4TD9JM7ZuveKAr9fg
         633db12Is20ERz1jxQi3X09sPAM+PYzOXIs5LLk2vr5yu3erN6dJeWQZymhs/QAoU/Yp
         B6dz9g37kTWRFTazl5uJLjS/4+rBGFQPJJMtq9ensm2xKPbPa2e4TDqUZe/QqN3iW0Zt
         BsPh3JpQwmVpc7/OFtQab/g2SxkKMcoKoFp3UcH9U89ACz0MoE2nYHrJqeKsdUpXinp2
         t7S44yFXl/ky8c2WlLi+JsfXxNGYvjPL0xd6AXCKt9FY2iGKk/AXx2RzB10QEKdmywRQ
         yAJg==
X-Forwarded-Encrypted: i=1; AJvYcCW4dexOgwmF5PMfK+5a79oIFO+lf2tHCK1opv7e6a8nPlPIHDXPQvm476n4dxMW3in9Q/J1WarcZS/jY5eXiyoAPNAzu0qCEqRZlJ7U
X-Gm-Message-State: AOJu0YzcCFwVS6mCX7+lA16O3/8YS/NLBrNfpwjGVriznwXIExBUB2VN
	FG3tu8XWhcW2Rp1RqRZE3iHEx2rv2Yqq8M2BBE3sXWBtsNSINVRz
X-Google-Smtp-Source: AGHT+IFEmIk4Fnua+udZbbg4a2Wno8OJPoEc2MEYng2DzfsTfKmBeu2Kld3lgrUK1ZzT7Ajm2ycsmQ==
X-Received: by 2002:a17:90b:3804:b0:2c7:43c5:f2dc with SMTP id 98e67ed59e1d1-2ca35d86e39mr1275183a91.47.1720513383553;
        Tue, 09 Jul 2024 01:23:03 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:23:03 -0700 (PDT)
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
Subject: [PATCH net-next v1 3/7] net: stmmac: refactor Frame Preemption(FPE) implementation
Date: Tue,  9 Jul 2024 16:21:21 +0800
Message-Id: <4820163fc24ad809aa4d90467debd41f068908ca.1720512888.git.0x1207@gmail.com>
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

Refactor FPE implementation into a separate FPE module.
Interfaces only, implementations for gmac4 and xgmac will follow.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  3 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 28 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  |  9 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  | 13 +++++++++
 6 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..7e46dca90628 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index cd36ff4da68c..73c145dda11a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -591,6 +591,7 @@ struct mac_device_info {
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
+	const struct stmmac_fpe_ops *fpe;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 29367105df54..fc9f58f44180 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -8,6 +8,7 @@
 #include "stmmac.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
+#include "stmmac_fpe.h"
 
 static u32 stmmac_get_id(struct stmmac_priv *priv, u32 id_reg)
 {
@@ -116,6 +117,7 @@ static const struct stmmac_hwif_entry {
 	const void *tc;
 	const void *mmc;
 	const void *est;
+	const void *fpe;
 	int (*setup)(struct stmmac_priv *priv);
 	int (*quirks)(struct stmmac_priv *priv);
 } stmmac_hw[] = {
@@ -351,6 +353,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
 		mac->est = mac->est ? : entry->est;
+		mac->fpe = mac->fpe ? : entry->fpe;
 
 		priv->hw = mac;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 97934ccba5b1..bd360f3ea784 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -418,13 +418,6 @@ struct stmmac_ops {
 				bool en, bool udp, bool sa, bool inv,
 				u32 match);
 	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
-	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			      u32 num_txq, u32 num_rxq,
-			      bool enable);
-	void (*fpe_send_mpacket)(void __iomem *ioaddr,
-				 struct stmmac_fpe_cfg *cfg,
-				 enum stmmac_mpacket_type type);
-	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -523,12 +516,6 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, config_l4_filter, __args)
 #define stmmac_set_arp_offload(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
-#define stmmac_fpe_configure(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_configure, __args)
-#define stmmac_fpe_send_mpacket(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, fpe_send_mpacket, __args)
-#define stmmac_fpe_irq_status(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
@@ -660,6 +647,21 @@ struct stmmac_est_ops {
 #define stmmac_est_irq_status(__priv, __args...) \
 	stmmac_do_void_callback(__priv, est, irq_status, __args)
 
+struct stmmac_fpe_ops {
+	void (*configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq, bool enable);
+	int (*irq_status)(void __iomem *ioaddr, struct net_device *dev);
+	void (*send_mpacket)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type);
+};
+
+#define stmmac_fpe_configure(__priv, __args...) \
+	stmmac_do_void_callback(__priv, fpe, configure, __args)
+#define stmmac_fpe_irq_status(__priv, __args...) \
+	stmmac_do_callback(__priv, fpe, irq_status, __args)
+#define stmmac_fpe_send_mpacket(__priv, __args...) \
+	stmmac_do_void_callback(__priv, fpe, send_mpacket, __args)
+
 struct stmmac_regs_off {
 	u32 ptp_off;
 	u32 mmc_off;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
new file mode 100644
index 000000000000..f6701ba93805
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
+ * stmmac FPE(802.3 Qbu) handling
+ */
+
+#include "stmmac.h"
+#include "stmmac_fpe.h"
+
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
new file mode 100644
index 000000000000..84e3ceb9bdda
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Furong Xu <0x1207@gmail.com>
+ * stmmac FPE(802.3 Qbu) handling
+ */
+
+#define FPE_CTRL_STS_TRSP		BIT(19)
+#define FPE_CTRL_STS_TVER		BIT(18)
+#define FPE_CTRL_STS_RRSP		BIT(17)
+#define FPE_CTRL_STS_RVER		BIT(16)
+#define FPE_CTRL_STS_SRSP		BIT(2)
+#define FPE_CTRL_STS_SVER		BIT(1)
+#define FPE_CTRL_STS_EFPE		BIT(0)
-- 
2.34.1


