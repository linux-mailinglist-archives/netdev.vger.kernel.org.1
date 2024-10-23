Return-Path: <netdev+bounces-138109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C00D9ABFCE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585FD1C208C6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554514C5BD;
	Wed, 23 Oct 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECs9IaJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5515748F;
	Wed, 23 Oct 2024 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667204; cv=none; b=gfxVUnlS6KHiprOmkAVeZqoD68qP82F/wnpqiauY2PxbUFehqT/L7wVkjnEi1lay9N7MqYemVhmQB7LXfmLQbsDaY15QIfpY8/OeN0nPeA62gvlU8vovHHQXgdxdDbyYqTeI72VsM4UBBYdCe3pkloOLVZ9OJcAxkmt0JxhF33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667204; c=relaxed/simple;
	bh=rROPSUQXDhQer51k6kqjA7fVNXhpvrmis0jA8IjPZFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KlcwvkWxPCvvy5nTG5Fib3G0LJVVHpwXMMHCOkgDkUjPJBpBvsDQu58zZbTA97Y5X74q7M3tU02SEoXyoMDfcgPYIkOFVNkOXO2ScGDqP4RoApf7WJP6CdD3kkKI3BttyPZhR7ke4L36tPHZbAqIwISupE06moaRBYBHe8W0MdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECs9IaJV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b5affde14so45315695ad.3;
        Wed, 23 Oct 2024 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729667202; x=1730272002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92JLfIaRpUjF8Sxfadd8XbPPyUtSnUgfSS6vRr6nt1E=;
        b=ECs9IaJV/UWIpXyusTjDeH8nC9zQsUzOdaZRrSWdaYbypdS/WKbHl1CJdpUj0xwMFw
         smdDh77rXIGJYKfGOsfiWIe0EFxsxfJOU2dX4506JRylEC+g2Vet6DJdwuAoU5tSbIfM
         UoRSdSay9ukiw0v1OOG8MBPNdaLS9Y9LWyTBV/1xIOabkrGX54tJCJ+gV4N6DphqvyKk
         bmcZUMoKMyOPuNiM8aPw0jk127OuhWs0raCgEm4+nxoYeRivoFR1t1CzcEs5TyhWW8H/
         nF99w3w9oWKOz0lVYPhu51Qif702q7VvtBwbdDdt/JMdHTzWqPSNYS8yT/EravKDZ/84
         8mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667202; x=1730272002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92JLfIaRpUjF8Sxfadd8XbPPyUtSnUgfSS6vRr6nt1E=;
        b=I+JkIh7RLDIRSvt36sYdgB8VmeJWkyRMOpUdW7wIgpyArSrRQbSqsKzWYANhj+RY+b
         TpolBcFlCOXlhIsdSJE8cr5S5o+EVDKFmYIk1KU9nULC3DGlonvMgVBSBHbJjuFBlQ4/
         Iqs5HciYCk6y4wVK3dAsPp0oaVz7t9cPils8xQ8OKDfMHlLDet8uGGD1Wrp8n82wuY+1
         FG2CqvTELYOAO/+DGVSP/bi6hdaR55fqY3JZkvRzPOV1lP6mdDYTe3aZCQvVMMMy8zVR
         9STu+qqD3OmDC+QuI3/LxYDZb+h441DDjowNey7RaeEbwJ4o4oQ+FjbWC5eYgmbgl0Uw
         AjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp3iI5diYDEj+gZwJz37jUE3VR23sSbEmby7wvP+yFTLu91+BoQUAyEx0f343h8ZQw+OYHIIMq16xaZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXDn7acSErdhe1Y2y5Em8Z6zsCcVKR4hcP/le3V7MsnJ3VTqs
	Y2l1ggsQUENmogM83Np2Zz46ada9xkIfh7O3As/IvMXm3tGwyAUiIQBeZw==
X-Google-Smtp-Source: AGHT+IFg1+0gg++PfvZ8hUJJpo9mELaDNf04I2kCVWV0tn6VzhK1umPvfXNOy3n6ytKA79kkAxgxwA==
X-Received: by 2002:a17:903:1c4:b0:20c:7a0b:74a5 with SMTP id d9443c01a7336-20fa9ea1583mr20904445ad.39.1729667202049;
        Wed, 23 Oct 2024 00:06:42 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e7f0c167bsm51981745ad.140.2024.10.23.00.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:06:41 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 5/6] net: stmmac: xgmac: Complete FPE support
Date: Wed, 23 Oct 2024 15:05:25 +0800
Message-Id: <ebe4fae607de047a9153fbea73955d19d630752d.1729663066.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729663066.git.0x1207@gmail.com>
References: <cover.1729663066.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the necessary fpe_map_preemption_class callback for xgmac.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 43 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  3 ++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index de6ffda31a80..9a60a6e8f633 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1545,6 +1545,7 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
+	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1601,6 +1602,7 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
+	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index f7d48bf2faed..b604d2aafce0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -360,6 +360,49 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 	return 0;
 }
 
+int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
+				      struct netlink_ext_ack *extack, u32 pclass)
+{
+	u32 val, offset, count, preemptible_txqs = 0;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 num_tc = ndev->num_tc;
+
+	if (!num_tc) {
+		/* Restore default TC:Queue mapping */
+		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
+			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
+			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+		}
+	}
+
+	/* Synopsys Databook:
+	 * "All Queues within a traffic class are selected in a round robin
+	 * fashion (when packets are available) when the traffic class is
+	 * selected by the scheduler for packet transmission. This is true for
+	 * any of the scheduling algorithms."
+	 */
+	for (u32 tc = 0; tc < num_tc; tc++) {
+		count = ndev->tc_to_txq[tc].count;
+		offset = ndev->tc_to_txq[tc].offset;
+
+		if (pclass & BIT(tc))
+			preemptible_txqs |= GENMASK(offset + count - 1, offset);
+
+		for (u32 i = 0; i < count; i++) {
+			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
+			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+		}
+	}
+
+	val = readl(priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
+	       priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+
+	return 0;
+}
+
 const struct stmmac_fpe_reg dwmac5_fpe_reg = {
 	.mac_fpe_reg = GMAC5_MAC_FPE_CTRL_STS,
 	.mtl_fpe_reg = GMAC5_MTL_FPE_CTRL_STS,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index 9c7ddf34de24..fe463bb7a535 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -35,6 +35,9 @@ void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
 
 int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 				    struct netlink_ext_ack *extack, u32 pclass);
+int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
+				      struct netlink_ext_ack *extack,
+				      u32 pclass);
 
 extern const struct stmmac_fpe_reg dwmac5_fpe_reg;
 extern const struct stmmac_fpe_reg dwxgmac3_fpe_reg;
-- 
2.34.1


