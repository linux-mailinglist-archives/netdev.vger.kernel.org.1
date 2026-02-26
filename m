Return-Path: <netdev+bounces-261248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gChcFFcKoGnefQQAu9opvQ
	(envelope-from <netdev+bounces-261248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:54:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0872D1A2F87
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 562BC3054658
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BA399004;
	Thu, 26 Feb 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEnTesdL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE88396D06;
	Thu, 26 Feb 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096055; cv=none; b=fCjvghcmu/11FM7uX3GUPG5TGMD6fpk/fkynFihsz2TLkvIjtJW8V9oLsrjdgA4R3fJE/Yu5zdzd7UPHTx5+jzFGCepcm6fOScYRWFJyaqcsobtMR+ykIDONHO4AiReBncmiKczdY0uZpc5AFGtp5Jvr8JM6Bj/S8ENCzduxCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096055; c=relaxed/simple;
	bh=Q9V6sTMaJ2pd7d5NGrdgzvEcNvyFxJE7OuvaMwzwrfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E85Hjd/WeiuiP9/lJWy8BURnne43Azfkcu4GpeI1o3znMEPWA8eDCK4lbsto24C8CeArP6xbMdRv7SlGw7TqMRtpLaXGskpVDg3pdFt4M+gw+IBho3onrZdilfDhGwrxiHKwkLSGElovPN6v9hMxogTPy1l49dKkUEl8F1CQ/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEnTesdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DE03C19424;
	Thu, 26 Feb 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772096055;
	bh=Q9V6sTMaJ2pd7d5NGrdgzvEcNvyFxJE7OuvaMwzwrfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OEnTesdLTXh3CRG5FMziIXiU5v7UC1fFPXvISlCawSgWNkNG00f6jobgbp4NEqCTG
	 w4d80TikFRuNdyWYoIaWZCjXtiG+vMVxxdu0HNFaQKTwrniV7JU9JxNOuJnvV3hCfT
	 2HqVLHXm6AsXZYWY7uYtNTWSJPKRIEi/W89Jf8uVVX7zanc/nQ+OX7WK3pJ2lUozjN
	 /1l5Nso20pqtJixJo070o2aImKJLEKti3AQZRW2XYaFWDm/9zAOpmtDWIPqdrodQ7Z
	 IDYAGRyGfXZENuxjdkz9gMGuAHBQRi966HOd0ZNnFPvBOVzK4Mo9VIyYQAjPwpKPVt
	 MThc4+jlmWUjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE62AFC5913;
	Thu, 26 Feb 2026 08:54:14 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Thu, 26 Feb 2026 09:54:06 +0100
Subject: [PATCH v7 1/5] net: stmmac: Use helper macro for loop over
 queue-based arrays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-dwmac_multi_irq-v7-1-f8fe3b945bb4@oss.nxp.com>
References: <20260226-dwmac_multi_irq-v7-0-f8fe3b945bb4@oss.nxp.com>
In-Reply-To: <20260226-dwmac_multi_irq-v7-0-f8fe3b945bb4@oss.nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk, 
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772096053; l=4143;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=AN9BxArjvT+LtwWtaoyDzsO4XeDTxufZg6uDwPtH3+8=;
 b=qx4zViXLhquemljUdcK9/hePoUKUSGDPdEFSLQaAUKxdNbrTHqfA5yznxNKgqzJbgLNjeQe5h
 HwPpAWooWzzCnl0hEP7EkpABcn72M2PYEy57NzXZsGL5wKXTtsMpsUG
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261248-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,oss.nxp.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0872D1A2F87
X-Rspamd-Action: no action

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The stmmac driver contains similar pattern for processing queue-based
arrays, ie. interrupt lines, etc. Factor out the for loop and provide
a macro STMMAC_FOREACH_MTL_QUEUE(var, limit).

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h        |  3 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 16 ++++++++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 49893b9fb88c..3890e82c69f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -233,7 +233,7 @@ static void dwxgmac2_prog_mtl_tx_algorithms(struct mac_device_info *hw,
 	writel(value, ioaddr + XGMAC_MTL_OPMODE);
 
 	/* Set ETS if desired */
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_TX_QUEUES) {
 		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
 		value &= ~XGMAC_TSA;
 		if (ets)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 51c96a738151..c972ad8e79f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -382,6 +382,9 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
+#define STMMAC_FOREACH_MTL_QUEUE(var, limit) \
+	for (var = 0; var < (limit); var++)
+
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index edf0799b7236..b920ca17b2be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3875,7 +3875,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	}
 
 	/* Request Rx MSI irq */
-	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
+	STMMAC_FOREACH_MTL_QUEUE(i, priv->plat->rx_queues_to_use) {
 		if (i >= MTL_MAX_RX_QUEUES)
 			break;
 		if (priv->rx_irq[i] == 0)
@@ -3899,7 +3899,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 	}
 
 	/* Request Tx MSI irq */
-	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
+	STMMAC_FOREACH_MTL_QUEUE(i, priv->plat->tx_queues_to_use) {
 		if (i >= MTL_MAX_TX_QUEUES)
 			break;
 		if (priv->tx_irq[i] == 0)
@@ -4084,10 +4084,10 @@ static int __stmmac_open(struct net_device *dev,
 			 struct stmmac_dma_conf *dma_conf)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int ret, i;
 	u32 chan;
-	int ret;
 
-	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
+	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_TX_QUEUES)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
@@ -7734,9 +7734,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->device = device;
 	priv->dev = ndev;
 
-	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
+	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_RX_QUEUES)
 		u64_stats_init(&priv->xstats.rxq_stats[i].napi_syncp);
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_TX_QUEUES) {
 		u64_stats_init(&priv->xstats.txq_stats[i].q_syncp);
 		u64_stats_init(&priv->xstats.txq_stats[i].napi_syncp);
 	}
@@ -7759,9 +7759,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv->sfty_irq = res->sfty_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
-	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
+	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_RX_QUEUES)
 		priv->rx_irq[i] = res->rx_irq[i];
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
+	STMMAC_FOREACH_MTL_QUEUE(i, MTL_MAX_TX_QUEUES)
 		priv->tx_irq[i] = res->tx_irq[i];
 
 	if (!is_zero_ether_addr(res->mac))

-- 
2.47.0



