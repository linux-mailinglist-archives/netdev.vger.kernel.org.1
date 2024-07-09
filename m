Return-Path: <netdev+bounces-110156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C375A92B209
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528E21F2275A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13D153578;
	Tue,  9 Jul 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXv6RFOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DF152790;
	Tue,  9 Jul 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513375; cv=none; b=Vo+Z4x3+PXk9ZmKeX5XTR9aEGN2Yu+kx9bVjDpdg8vGLGEI/wMlhTIh9OzM8zvaqSpBM7g2SI3oIPDVlaNBIneAjzV8pqKt2nqTCZ2buvHEvGK+2BrNzemcGjPZcmkHVxYDdcaay/GtejNB0ve76YYS3U/E1uj3d/4wew6VGcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513375; c=relaxed/simple;
	bh=Hanol2veyTqozQGRSLQJV2JVIrrmZ4vWOOE5XIcf1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLOnNxtrDPjTD1NdNWVlyTAHO5T0KXaZfSwkcVJrudJurTU5xWcZipMNgQTVTXJz83ikkLBo1ZJMUsHWimy4wXA593fmHtb3DAI/OS2lwnakqnPvezFl7d6Rr8Mwdj6gUgWEnExijOtpZFe3PJkpuF64WwKxn+MxGKsAVZi0CDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXv6RFOy; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-707040e3017so3243235a12.3;
        Tue, 09 Jul 2024 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513373; x=1721118173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4bF8onLf0sdE3t3KB8zz6I+NlPIzXeOdYuUooT+xDk=;
        b=DXv6RFOyl2+rglc0ZxQRjxkS3FWtoyvxs9HLPSNQcoXUBejQoSlF3+UxEF6PyyMGaB
         7iefTSeA0sJ+pwARoe8lB0OduE9bZ6E2hKBuF5Rb4NXQ1Pozd82y75YxPIxjn8czYz5u
         Ij3zk7nqwwIwVuUaJXEdV/LmzmQZ6B2vEt8JT03iS5DmZfHtfa6GI64F3llEzaFcBBT6
         dM0cEEzVW9tYwLPUzTGNNKnxSFPhqz/farFk/CFtdJxsuvfEI5OreUMJSoySVa5mkcYX
         X3nnmX6+2HOhnh8x9412TxZ+pJcsW0ukTyzaE+dRGSmqL/Q8ovLFxdiT2a7h3PtR0Rsk
         j2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513373; x=1721118173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4bF8onLf0sdE3t3KB8zz6I+NlPIzXeOdYuUooT+xDk=;
        b=wlcI0zO50tJl7B9qs2EPolT3xHBx9LS5JfnjBkGAH6Exhwqfu4pmgTqNDErJCiSPEU
         XhQtlnz8clIzCWg0PjXxmBkWq3a1bgM2wGFeMXtwaiiECYQFI58MRLRFhpXQoruapwZ9
         6ufwcYwNj3YuPnjDO9w+WvY5FeSOCv2N6efCxhdyTMK7fn1vyrTHQiD+lLSSiPrSWcLr
         kke9isgamv/4n8D/1uwReGcqNDAqE8H2A8WeAcM/g/9UtuEHIg5uegb2PN3aka0CIRzr
         6BDt7HKMIRx26EQBHeQgKeP1pS5+VwIr2XCzu3UyIxLP33O8mmXZqdws/Ek2DJYbD+i9
         C78A==
X-Forwarded-Encrypted: i=1; AJvYcCVWUyYY5wwn+ZcpSpPLWDYpZ0Fydy8Vpb7zzdmF2cjfKh7C40qyG6EXVIhlV0e/HSglEvB3sTX5CS77+lrrQOyb1KptCewOiq0dDhq7
X-Gm-Message-State: AOJu0Yxu9gZImC9CS1XVALPksb26zMNM+eFfXn6Bqyfmp/5/xYSI38Jq
	CyrqP1af2ImMtTgIGLZYcmeaG6i/qxathqobl7NZl7nYq8DBHZFv
X-Google-Smtp-Source: AGHT+IHdf/+Sw63Qfm2YgFi6J6SIA2YjPniRp27/Dn9i48xVvX5kBw2EaQzrGqnejAwaX/tV/o1qkg==
X-Received: by 2002:a05:6a20:c70b:b0:1c0:f20c:5bae with SMTP id adf61e73a8af0-1c2983983b4mr2047130637.47.1720513373172;
        Tue, 09 Jul 2024 01:22:53 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:22:52 -0700 (PDT)
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
Subject: [PATCH net-next v1 2/7] net: stmmac: gmac4: drop FPE implementation for refactoring
Date: Tue,  9 Jul 2024 16:21:20 +0800
Message-Id: <98183e72d59cc8ce71dd9fd25a65983ff69dfcd1.1720512888.git.0x1207@gmail.com>
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

The FPE support for gmac4 is complete, still drop it temporarily.
Once FPE implementation is refactored, gmac4 support will be added.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  6 --
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 66 -------------------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  | 16 -----
 3 files changed, 88 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index dbd9f93b2460..1505ac738b13 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1265,9 +1265,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.fpe_configure = dwmac5_fpe_configure,
-	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
-	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1317,9 +1314,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.fpe_configure = dwmac5_fpe_configure,
-	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
-	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e02cebc3f1b7..1c431b918719 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -572,69 +572,3 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 	writel(val, ioaddr + MAC_PPS_CONTROL);
 	return 0;
 }
-
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
-			  bool enable)
-{
-	u32 value;
-
-	if (enable) {
-		cfg->fpe_csr = EFPE;
-		value = readl(ioaddr + GMAC_RXQ_CTRL1);
-		value &= ~GMAC_RXQCTRL_FPRQ;
-		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-		writel(value, ioaddr + GMAC_RXQ_CTRL1);
-	} else {
-		cfg->fpe_csr = 0;
-	}
-	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
-}
-
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
-{
-	u32 value;
-	int status;
-
-	status = FPE_EVENT_UNKNOWN;
-
-	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
-	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
-	 */
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (value & TRSP) {
-		status |= FPE_EVENT_TRSP;
-		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
-	}
-
-	if (value & TVER) {
-		status |= FPE_EVENT_TVER;
-		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
-	}
-
-	if (value & RRSP) {
-		status |= FPE_EVENT_RRSP;
-		netdev_info(dev, "FPE: Respond mPacket is received\n");
-	}
-
-	if (value & RVER) {
-		status |= FPE_EVENT_RVER;
-		netdev_info(dev, "FPE: Verify mPacket is received\n");
-	}
-
-	return status;
-}
-
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			     enum stmmac_mpacket_type type)
-{
-	u32 value = cfg->fpe_csr;
-
-	if (type == MPACKET_VERIFY)
-		value |= SVER;
-	else if (type == MPACKET_RESPONSE)
-		value |= SRSP;
-
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
-}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index bf33a51d229e..00b151b3b688 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -11,15 +11,6 @@
 #define PRTYEN				BIT(1)
 #define TMOUTEN				BIT(0)
 
-#define MAC_FPE_CTRL_STS		0x00000234
-#define TRSP				BIT(19)
-#define TVER				BIT(18)
-#define RRSP				BIT(17)
-#define RVER				BIT(16)
-#define SRSP				BIT(2)
-#define SVER				BIT(1)
-#define EFPE				BIT(0)
-
 #define MAC_PPS_CONTROL			0x00000b70
 #define PPS_MAXIDX(x)			((((x) + 1) * 8) - 1)
 #define PPS_MINIDX(x)			((x) * 8)
@@ -102,12 +93,5 @@ int dwmac5_rxp_config(void __iomem *ioaddr, struct stmmac_tc_entry *entries,
 int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 			   struct stmmac_pps_cfg *cfg, bool enable,
 			   u32 sub_second_inc, u32 systime_flags);
-void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-			  u32 num_txq, u32 num_rxq,
-			  bool enable);
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
-			     struct stmmac_fpe_cfg *cfg,
-			     enum stmmac_mpacket_type type);
-int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 
 #endif /* __DWMAC5_H__ */
-- 
2.34.1


