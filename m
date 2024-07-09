Return-Path: <netdev+bounces-110161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146192B217
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB00B28289E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F515358F;
	Tue,  9 Jul 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOhYVyN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEBD1527AA;
	Tue,  9 Jul 2024 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513415; cv=none; b=YmkhufpDP5B90p0CNJfvD+9Xo8tcHe/3PwmejhvOjbcJcnbcbW8sOZv9mi8qv6igb+s7UfRsz0jvzK+AmT918LlSd/Na7K/W+1IHbjpq44dOBXZD8JfsA/O/oWPKqS0O4Ov/wSZzL5Ly4XaRNbRZ62YLExKbUV85J+h4mFCzrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513415; c=relaxed/simple;
	bh=sOT4iTDzWIfLs9UA0R4XOev6spnQG9gjkKs4PSXQU0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHqdjgS2eCYr7fTajly0NydcasqGdwBahs+/UUqUHy5JgKk0/70UKDYc0UCuu71YdQFi3Dmos44cNEGmrgDDwPwOmQTcZc37oPDUqIl0MNtLvcoTWHAgJe5WfMavx/HiFsjXUXRNurHGIDrmA4qsXa5Qdx7DblE57g1w4nvYe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOhYVyN4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c95ca60719so2862087a91.3;
        Tue, 09 Jul 2024 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513413; x=1721118213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP0LjrMRjIFsgCTgIBPUz0T81YiHTsFBk9I0t0JMtzc=;
        b=gOhYVyN4HWShWBlYHn7n1c1X/AqYC7dfJQs4aZ+KOWbnrVzyCbF3iaMbzu7pVkscBl
         yITWh+9YAATUoRweC52CVrPU2S43glCdep2vdjA+MhMrWXIroY4I2TSa/X3lLjFu0ZwR
         4DqluLUSeT5gp/2Sz8l/IrgMAcLipLjvi0c/qKBkwVgiS6tw4dN5UFyAyEqxpKuWGSRb
         48w3Ikgz2iEwW+lJVU92oD3qUhxZKSxdP42h7pmWiSiwqAKNJyb4F9vALb64IkPu6285
         e0KbwUxWiMlLvOQk4YCmgrrGO8cWHOK+pIjOU0DUlLRSjf3Tkiq2UWPwzHbMRi16fyzx
         XwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513413; x=1721118213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP0LjrMRjIFsgCTgIBPUz0T81YiHTsFBk9I0t0JMtzc=;
        b=tC8D9fm5nX25M2uh74HuIl9tZdR/hcsd/A/FF2KoL6BON3zNGDYIomI4QDLBCf0+ZN
         QXsnOleErvgZpALNuWziyoZNU4VE9CxGk/iGciHgLdYjOQobNRPG7uVuYK5iwiEpyiOw
         F2HcxRQqrU0H4iX14+R6JnIy4i7diFtZw/yA+O/0pLx0qp5YitO6Rm3/MPp5OGnyyFXl
         V8zwH8V/rq3dajdgePi9MuzJmjjJfhcw3Qzr1+4OaTDw2LH2iK+aYy/skoku34RRgplH
         vGvUK7GeATNMBBoNe2wNtiSclLQuwLPYQYfgSuA/5+vT42FfKshpIGoZJ3H8gZi0/yxD
         zH9w==
X-Forwarded-Encrypted: i=1; AJvYcCXadAVlQuKuJlXOvwAWdkIiywlaauEK1nsEyztXSdngX9QyL7VWr9+ilKeDfRbwtW74U8Qo6EImqb0Hihas7uRDydnZa/Jcd6eka58Z
X-Gm-Message-State: AOJu0Yy8kcpNe17bAPQZccCEMBDb+NE7wfOFPnBJ5jkRKZbb7H9kcfP3
	cfhy90InjL9edrcWJRTISxspMPhx8rlBNFXVd/RausCpQ95uyOxo
X-Google-Smtp-Source: AGHT+IEsA/J8BKGkc+qhPKYByQIdxwFS8gpklEmLtJM7nUypk4CDvh/2Q/FxDq9p43lqdv9itrHpzw==
X-Received: by 2002:a17:90a:db58:b0:2c9:8d5d:d175 with SMTP id 98e67ed59e1d1-2ca35d59cedmr1492273a91.48.1720513413478;
        Tue, 09 Jul 2024 01:23:33 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:23:33 -0700 (PDT)
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
Subject: [PATCH net-next v1 6/7] net: stmmac: xgmac: complete FPE support
Date: Tue,  9 Jul 2024 16:21:24 +0800
Message-Id: <36336e43ee530596d77b15b80e3afac7bfd3319a.1720512888.git.0x1207@gmail.com>
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

FPE implementation for DWMAC4 and DWXGMAC differs only for:
1) Offset address of MAC_FPE_CTRL_STS
2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1

Introduce dwxgmac_fpe_ops to complete the FPE implementation for DWXGMAC.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  2 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 37 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  1 +
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 655012ffbc0a..f13ed91b498f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -259,6 +259,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwxgmac_fpe_ops,
 		.setup = dwxgmac2_setup,
 		.quirks = NULL,
 	}, {
@@ -280,6 +281,7 @@ static const struct stmmac_hwif_entry {
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
+		.fpe = &dwxgmac_fpe_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
 	},
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7b19614c611d..81ce8ede2641 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -686,6 +686,7 @@ extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
 extern const struct stmmac_est_ops dwmac510_est_ops;
 extern const struct stmmac_fpe_ops dwmac4_fpe_ops;
+extern const struct stmmac_fpe_ops dwxgmac_fpe_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 97e404fac56a..c6894d5263c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -7,6 +7,7 @@
 #include "stmmac.h"
 #include "stmmac_fpe.h"
 #include "dwmac4.h"
+#include "dwxgmac2.h"
 
 static int __fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 {
@@ -92,3 +93,39 @@ const struct stmmac_fpe_ops dwmac4_fpe_ops = {
 	.irq_status = dwmac4_fpe_irq_status,
 	.send_mpacket = dwmac4_fpe_send_mpacket,
 };
+
+static void dwxgmac_fpe_configure(void __iomem *ioaddr,
+				  struct stmmac_fpe_cfg *cfg,
+				  u32 num_txq, u32 num_rxq, bool enable)
+{
+	u32 value;
+
+	if (enable) {
+		cfg->fpe_csr = FPE_CTRL_STS_EFPE;
+		value = readl(ioaddr + XGMAC_RXQ_CTRL1);
+		value &= ~XGMAC_FPRQ;
+		value |= (num_rxq - 1) << XGMAC_FPRQ_SHIFT;
+		writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr = 0;
+	}
+
+	writel(cfg->fpe_csr, ioaddr + FPE_CTRL_STS_XGMAC_OFFSET);
+}
+
+static int dwxgmac_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+{
+	return __fpe_irq_status(ioaddr + FPE_CTRL_STS_XGMAC_OFFSET, dev);
+}
+
+static void dwxgmac_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+				     enum stmmac_mpacket_type type)
+{
+	__fpe_send_mpacket(ioaddr + FPE_CTRL_STS_XGMAC_OFFSET, cfg, type);
+}
+
+const struct stmmac_fpe_ops dwxgmac_fpe_ops = {
+	.configure = dwxgmac_fpe_configure,
+	.irq_status = dwxgmac_fpe_irq_status,
+	.send_mpacket = dwxgmac_fpe_send_mpacket,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index efdb5536e856..b74cf8f2c2f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -5,6 +5,7 @@
  */
 
 #define FPE_CTRL_STS_GMAC4_OFFSET	0x00000234
+#define FPE_CTRL_STS_XGMAC_OFFSET	0x00000280
 
 #define FPE_CTRL_STS_TRSP		BIT(19)
 #define FPE_CTRL_STS_TVER		BIT(18)
-- 
2.34.1


