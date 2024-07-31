Return-Path: <netdev+bounces-114509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2C942C42
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65038281AB3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995161AD403;
	Wed, 31 Jul 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQZ9e9G8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B21AC43C;
	Wed, 31 Jul 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422651; cv=none; b=rhXNlwAlXNwGLlRYSDiEud7VUfAx1VA/6yvcChSeOgCHasqX+vig6rCAdjin6Vw+3ThAsYsGK+6UtgmWcAweqckZEN/3wpecrTQ4WYAtZtA2OQkWhcn6d3voOPeVAOI4vopDNy/SmnFYNzVhks3cr2JSgvXoM6CgSmc56vTpLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422651; c=relaxed/simple;
	bh=zVer1X4pD3xyz04ZGh4eaC6+zbTxi9uUKqGhpGLnAPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3vLX5zJVvZDMnJTSHoyM8gEDEjfyMcTimCBzPP+HCgISEdiSC5WgyCciuVSUfg2h+9zkHn6YC3/DZNZswgLsDDIy1k44U4oBx7sYbmBvyD6Zvy/z8X3GcF4rQglG52bRfyiVSuXW/qikXZ6Q48/ED23f4CGOemnVhbo24allZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQZ9e9G8; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db19caec60so4025504b6e.1;
        Wed, 31 Jul 2024 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422649; x=1723027449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5uCSeDS2KlYFiPNdbR3vKj49AmACS3RssJxcitTbJU=;
        b=HQZ9e9G82hNygqNV+r4aqCasZPzxTJPPDo1M8k5pZMhXACLk5x2jeMRYdlr1qXO9jJ
         LavaZ6Ai0uZ0IiUsklbqd0EhFzAi+eCaOuwNxYHEPilrhNd1P53XpgLICoFfeBC0zuBJ
         FGx7uUzVuj7UA+BISRmZmArO239sW8iPzGIiVVmTjg1+Owq4jqyHSkWU7JX2wrlC+fAG
         5g6gKIbeW/bOLno+IPczRIhJCFLjK6/4FBkzIKGnP9mNoSQe4RcDagvswCETiOluEKDj
         NaSS42JXx7MiHDvPnmSJQkUEkRFNu4hRgf2fnjGvF+HcD7C9AcFz7riA2G0X0wWrMD9J
         2ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422649; x=1723027449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5uCSeDS2KlYFiPNdbR3vKj49AmACS3RssJxcitTbJU=;
        b=tgnhKWnTy9LePP98yNf0TGJiuVXQiZemNGhUmTfqJG+EguJkGy1hOz4cBB2VgOfxxG
         SvzaD0Dp5HvztsGqvRylGh16mc/a2XQ1KX0rAqJb6TT4xD/MRR+hYWKuhf9flavgHUH9
         PGAdDCs3utY4rlbBWIFVx2GwLN7ZBEXxebpx17KorpnexCB+2IOTJqOUTAMKnRPLDsQg
         vmbPjtYe8IuKbOVbjYSYvE3lsV8kgsOAqwEEKMQYZgzXDaqV6vBFUHjy/6UP/mjnd0/H
         BH+O3pobsX6wA6Q4acb2Xz8d0bWnBNn+85trd7HFmFNfCXanxSlBefIZbmJc08x7RQ6j
         Jueg==
X-Forwarded-Encrypted: i=1; AJvYcCXCaRh9Za9IC4hnb/NjiWuolvw3qxJh8naoYGX4qyD+sCaRfJKnpxNEeNP3nZj62vKHUCuMbwydlAYCB+fK2J94EYqqGwI23XAwFbQk
X-Gm-Message-State: AOJu0Yzigo4cLYGoTP5c0yWDArRxMZkNth6OUJzmwfQxhRrHYtdCzpVu
	Rs2TbSQtlx4+0sIU4KHdTmxkpaUwu+rUFTuOZLMyrS+dNUR/mBwN
X-Google-Smtp-Source: AGHT+IHcHs92dpP656QF9x0ILt6Q+QZ+HokBNWMSIIQRCqfEkorPMSQjHNCWI7OPXpiMNpEaK7cxPQ==
X-Received: by 2002:aca:905:0:b0:3da:aae9:718e with SMTP id 5614622812f47-3db23d7a442mr14618692b6e.46.1722422648801;
        Wed, 31 Jul 2024 03:44:08 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f816da59sm8791375a12.29.2024.07.31.03.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:44:08 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next v1 2/5] net: stmmac: support fp parameter of tc-mqprio
Date: Wed, 31 Jul 2024 18:43:13 +0800
Message-Id: <df005cc6b2f97e7ea373dcc356fb6a693f33263a.1722421644.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>
References: <cover.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc-mqprio can select whether traffic classes are express or preemptible.

Tested on DWMAC CORE 5.10a

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 12 ++++
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  2 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  8 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 61 +++++++++++++++++++
 6 files changed, 87 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index af871cce767e..68cdfd9e7c8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1270,6 +1270,7 @@ const struct stmmac_ops dwmac410_ops = {
 	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
 	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
+	.fpe_set_preemptible_tcs = dwmac5_fpe_set_preemptible_tcs,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1324,6 +1325,7 @@ const struct stmmac_ops dwmac510_ops = {
 	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
 	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
+	.fpe_set_preemptible_tcs = dwmac5_fpe_set_preemptible_tcs,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 5d132bada3fe..068859284691 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -655,3 +655,15 @@ void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
 
 	writel(value, ioaddr + MTL_FPE_CTRL_STS);
 }
+
+void dwmac5_fpe_set_preemptible_tcs(void __iomem *ioaddr, unsigned long tcs)
+{
+	u32 value;
+
+	value = readl(ioaddr + MTL_FPE_CTRL_STS);
+
+	value &= ~PEC;
+	value |= FIELD_PREP(PEC, tcs);
+
+	writel(value, ioaddr + MTL_FPE_CTRL_STS);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 6b1c9d2da308..bce7e88418ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -40,6 +40,7 @@
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
 #define MTL_FPE_CTRL_STS		0x00000c90
+#define PEC				GENMASK(15, 8)
 #define AFSZ				GENMASK(1, 0)
 
 #define MTL_RXP_CONTROL_STATUS		0x00000ca0
@@ -114,5 +115,6 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr);
 void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
+void dwmac5_fpe_set_preemptible_tcs(void __iomem *ioaddr, unsigned long tcs);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index f868ffc3e64f..109699d3df0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -7,6 +7,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/stmmac.h>
+#include <net/pkt_cls.h>
 
 #define stmmac_do_void_callback(__priv, __module, __cname,  __arg0, __args...) \
 ({ \
@@ -427,6 +428,7 @@ struct stmmac_ops {
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 	int (*fpe_get_add_frag_size)(void __iomem *ioaddr);
 	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
+	void (*fpe_set_preemptible_tcs)(void __iomem *ioaddr, unsigned long tcs);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -535,6 +537,8 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
 #define stmmac_fpe_set_add_frag_size(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
+#define stmmac_fpe_set_preemptible_tcs(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, fpe_set_preemptible_tcs, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
@@ -622,6 +626,8 @@ struct stmmac_tc_ops {
 			 struct tc_etf_qopt_offload *qopt);
 	int (*query_caps)(struct stmmac_priv *priv,
 			  struct tc_query_caps_base *base);
+	int (*setup_mqprio)(struct stmmac_priv *priv,
+			    struct tc_mqprio_qopt_offload *qopt);
 };
 
 #define stmmac_tc_init(__priv, __args...) \
@@ -638,6 +644,8 @@ struct stmmac_tc_ops {
 	stmmac_do_callback(__priv, tc, setup_etf, __args)
 #define stmmac_tc_query_caps(__priv, __args...) \
 	stmmac_do_callback(__priv, tc, query_caps, __args)
+#define stmmac_tc_setup_mqprio(__priv, __args...) \
+	stmmac_do_callback(__priv, tc, setup_mqprio, __args)
 
 struct stmmac_counters;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9b1cf81c50ea..a5e3316bc410 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6256,6 +6256,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	switch (type) {
 	case TC_QUERY_CAPS:
 		return stmmac_tc_query_caps(priv, priv, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return stmmac_tc_setup_mqprio(priv, priv, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &stmmac_block_cb_list,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 996f2bcd07a2..494fe2f68300 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1198,6 +1198,13 @@ static int tc_query_caps(struct stmmac_priv *priv,
 			 struct tc_query_caps_base *base)
 {
 	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
@@ -1214,6 +1221,59 @@ static int tc_query_caps(struct stmmac_priv *priv,
 	}
 }
 
+static void stmmac_reset_tc_mqprio(struct net_device *ndev)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	netdev_reset_tc(ndev);
+	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
+
+	stmmac_fpe_set_preemptible_tcs(priv, priv->ioaddr, 0);
+}
+
+static int tc_setup_mqprio(struct stmmac_priv *priv,
+			   struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *ndev = priv->dev;
+	int num_stack_tx_queues = 0;
+	int num_tc = qopt->num_tc;
+	int offset, count;
+	int tc, err;
+
+	if (!num_tc) {
+		stmmac_reset_tc_mqprio(ndev);
+		return 0;
+	}
+
+	err = netdev_set_num_tc(ndev, num_tc);
+	if (err)
+		return err;
+
+	for (tc = 0; tc < num_tc; tc++) {
+		offset = qopt->offset[tc];
+		count = qopt->count[tc];
+		num_stack_tx_queues += count;
+
+		err = netdev_set_tc_queue(ndev, tc, count, offset);
+		if (err)
+			goto err_reset_tc;
+	}
+
+	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
+	if (err)
+		goto err_reset_tc;
+
+	stmmac_fpe_set_preemptible_tcs(priv, priv->ioaddr, mqprio->preemptible_tcs);
+
+	return 0;
+
+err_reset_tc:
+	stmmac_reset_tc_mqprio(ndev);
+
+	return err;
+}
+
 const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.init = tc_init,
 	.setup_cls_u32 = tc_setup_cls_u32,
@@ -1222,4 +1282,5 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
+	.setup_mqprio = tc_setup_mqprio,
 };
-- 
2.34.1


