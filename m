Return-Path: <netdev+bounces-265675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FUmKBoKr2nXMQIAu9opvQ
	(envelope-from <netdev+bounces-265675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:57:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D823E147
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8045E302BDEE
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102943EB804;
	Mon,  9 Mar 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBqzAVcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5573E95B5;
	Mon,  9 Mar 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078936; cv=none; b=aeWJj7tiapGfv1MjHNtdYAYvAhtdOHS9nsaDszfR7AS9q+K4O+CIf3tqRoQmEejYlTOrcx+BzRoOYbPz+rSDJvi1tDHZvXdwx068csRMbbMW1LmYOBrTnzrOZPev2ZI4w/YDjhSXgW8R0bwv4diDgVhBCcp8hx88Csm7tmbgLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078936; c=relaxed/simple;
	bh=Q9V6sTMaJ2pd7d5NGrdgzvEcNvyFxJE7OuvaMwzwrfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDjJTsSU3ExtUoDWZGFpjsJjKRW+KJzslQXABxh97mcC9JbYgKUXm5WHzi9k6EUrJ2PssOEvvdljm/vH3PcfAJFBc7uyfhRcMiAaiNN0v72JQoALfcZ/cGcIwDU1lLDgyqj97U44l/GRxok0KOcyQREODYtYQW8hxt2e4zJ7WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBqzAVcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1924EC4CEF7;
	Mon,  9 Mar 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078936;
	bh=Q9V6sTMaJ2pd7d5NGrdgzvEcNvyFxJE7OuvaMwzwrfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BBqzAVccYflp8biEyYqWk5Jgx0vSSzaJgvtYW6vpkQ/HVrPQoON9eExNw46BhzkDP
	 0uAw41qa+p1VlYbyvZ6KhS4OhfoAtpoWoNvrXHOg0FJaTHMZ8VMLdmDgT+sJC3qS5t
	 BsArHu1eS0Qy3OxKiHwm5OYAbiPeU8qpMmOXBz1uepLvVEm+g+p7C3sJKWIk0CdB6c
	 2/HIKqG+ALSmYJwLwbJlnEiMPHiclKcQuBuHPryR6noC5NuzMfgD0ysi0bovIy7DOK
	 KFNBfOtrYU16Z8RQsnkvB/dNxkTfSzKFSttVqMIFgHDcregeZp3NTV2tpvATQm2tzX
	 U6H45CZhoilkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CD5FCA16E;
	Mon,  9 Mar 2026 17:55:36 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Mon, 09 Mar 2026 18:55:20 +0100
Subject: [PATCH v8 1/5] net: stmmac: Use helper macro for loop over
 queue-based arrays
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-dwmac_multi_irq-v8-1-f0cc5bc811a7@oss.nxp.com>
References: <20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com>
In-Reply-To: <20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773078934; l=4143;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=AN9BxArjvT+LtwWtaoyDzsO4XeDTxufZg6uDwPtH3+8=;
 b=8zmy0Wg+/alVIyq8vDTkwX/2ouFXubxQdbigH7oUaZvyZHMnrqY+gtBnRuGivKrD6kjmNjgi/
 DlXIdSvF53lAnnh49NzL1XEMBVcLhvDEuUb+EXyx0oQpvF2QXYXwMV/
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Queue-Id: 605D823E147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265675-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.nxp.com:replyto,oss.nxp.com:mid,nxp.com:email]
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



