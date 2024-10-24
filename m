Return-Path: <netdev+bounces-138508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82A9ADF3D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC12C282C3E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749E1B21A3;
	Thu, 24 Oct 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T288vqLN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8F1B0F05;
	Thu, 24 Oct 2024 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758735; cv=none; b=Bl1DOspT6Hi5mcGN+2RZtGrlTSQka/EkNzn4XXxp+ZB8Qn7VS/EFCMFyM67gTch3fZjr3IBvk9vNf/xPn87Ws+6INZVRHeCQB7gQt3UtthPLSwwiV6YOk+zFrTEWwtdGz571ZlpgX1e7tWs9/C+ACgg00EQpCyqfoMfyekklUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758735; c=relaxed/simple;
	bh=r4+G7+hM0fJeKKN5ssRaIGVu3ttQi/tgtqB75LlvVOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvHXMwy7yInkw50kdeLVx8Rs0wus8sERlyfxrqdR4/YY66ld7Aum4Ql+IVjKveA3myLTbA56ER+theIegEX6PvLirHcGc6ehzAPNxSoZC+81SL90jbDPSjou94SQAIMQrKiBkSAGNZ8q0C8ftE5TTZeaNgUHch16dbsvqsT2YMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T288vqLN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so1246041a91.0;
        Thu, 24 Oct 2024 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729758731; x=1730363531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq/el8SDEUzHww6+pTvugVJXjv8HRz8p8ZSj3pXNDbk=;
        b=T288vqLNiWNbgWM+fp5eDSk7pYuby3M/+RjBbovlz6KN1rAF+vFll599u8bjO3eMRF
         s+XNLPowdblqIAqXlSA/hd2TTyCz68bHs9sa5VcE3w1XSmjB8wZpVdTqqi7ZpnsFQKpW
         2qMBsd748ZasYg8B1vUyegJRzhhhRpDlO+J0HkMAB4dbzSUeqUIDI8tdmhJ7D/CvOXPx
         7VkQeKcGgJ13hshOfX36OYKhYahsTm5xw8TW0WxqL1LIxkQx/aDeHrQIxApK/BVOBPgK
         tbvHNY2A5CY9HCv4rSTdH4jFgBsqDcZfSJkW+OVAFL1bJ5YndSICuN8c/eg58f5JcOf6
         LzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758731; x=1730363531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq/el8SDEUzHww6+pTvugVJXjv8HRz8p8ZSj3pXNDbk=;
        b=ZpZBavkk41jsM3qPrUU+55sJVPvte4FhZIjhxlEMCjDAUiCLdTwfAYurTPjQNVujbr
         D1d/hzVdXQD/gMefr3NIC7OLEY+CcqZW4CYXA320EcPceVvcLTB6uBoN6ePx6AQRWpA4
         Sa55IGtrZtYT4MTzqlkVF6nUtBxDtzGEKpHXqVWGzilTZREQyexADBuRCUeMKoSrb0x9
         6q6qnp4uaI9raE0aKP0il6fTMcW4SguTxCqSaG4sOd0AaKMtKSVGsB62qlq9OJ0lPdcW
         z0Rmrf45Gg0W/5CwF5DVNP4q5alxty0EqLEnQ15eFhoyPn/vaWcLn6c3KkBgeWaBi0RN
         09jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz1xIL1DLX4bf8wlgfS6pbsxEAdnIb51818Kx2iEACh180cUqFcbx+Slmd3Zk8mC71ZGN2Tz3Tfurpxns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEHtbGsDA14mH6rQybqkAH1Lpf5OHFW4w7OXwCmIdE3lN1YmW
	bIN5a2IrD4qWvU1JEQ220ZMZx11KOm92XkfgG4MmP8IUkVSfnlrCEUKItg==
X-Google-Smtp-Source: AGHT+IHwjsbgefkXOJzeNdSxiJt2hUHwx1jGdvUi7g05IerbcBRmo0LH++Eh5cEiic4v8e17OaHYVA==
X-Received: by 2002:a17:90a:fa16:b0:2c9:90fa:b9f8 with SMTP id 98e67ed59e1d1-2e77e5fa97fmr2097554a91.10.1729758731043;
        Thu, 24 Oct 2024 01:32:11 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e77e5a4ec4sm868773a91.54.2024.10.24.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:32:10 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v4 5/6] net: stmmac: xgmac: Complete FPE support
Date: Thu, 24 Oct 2024 16:31:20 +0800
Message-Id: <1b73889f76493a6d2882c7e3aa9d981b34b265d3.1729757625.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729757625.git.0x1207@gmail.com>
References: <cover.1729757625.git.0x1207@gmail.com>
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
index c9c2e0b00a0c..f41329169cc8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -350,6 +350,49 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
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
index 0b601a9fd805..ea18ea738da6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -34,6 +34,9 @@ void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
 
 int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 				    struct netlink_ext_ack *extack, u32 pclass);
+int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
+				      struct netlink_ext_ack *extack,
+				      u32 pclass);
 
 extern const struct stmmac_fpe_reg dwmac5_fpe_reg;
 extern const struct stmmac_fpe_reg dwxgmac3_fpe_reg;
-- 
2.34.1


