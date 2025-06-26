Return-Path: <netdev+bounces-201570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF8AE9ECB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76243AA9F7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B328C86E;
	Thu, 26 Jun 2025 13:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9772F1FCE;
	Thu, 26 Jun 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944686; cv=none; b=Fn5KfjSIAKAOsJbenqEUWwGqzDfmm/zh+qt164JBVUSMUGhqfmcnurDEnTyJylKqtJ5l1Q5iGRYzy9Ojt6sqc6+2ddC2GatE45eliZcOdMzsF/CwNeDD+wuc5QIjQL+7Mpjw8nrMjdT3c6yEKYlKPr4s2MXMtvLT/dQuQBimQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944686; c=relaxed/simple;
	bh=eu4zrfHzNiFBI3SfatLsyhMyAcafe6C6mOYVJvdNHCM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckx5l8YRadXeIXm7+ASaRKAuEDgHYBqyu+v2WUrq1ZcvYsHhfogSk0phQXxjOvLW1djMIkbCe1NxZwZ0avb1PjxPYHOQcDUeKK2+LQ7eLw3eOtPts4V1yWjRKDOcZKrjg4rralArcQQ0LbX8LdwIx9y8ZEudPqlWwVyta2uE4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH net v2] dpaa2-eth: fix xdp_rxq_info leak
Date: Thu, 26 Jun 2025 21:30:03 +0800
Message-ID: <20250626133003.80136-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

The driver registered xdp_rxq_info structures via xdp_rxq_info_reg()
but failed to properly unregister them in error paths and during
removal.

Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 2ec2c3dab250..b82f121cadad 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -3939,6 +3939,7 @@ static int dpaa2_eth_setup_rx_flow(struct dpaa2_eth_priv *priv,
 					 MEM_TYPE_PAGE_ORDER0, NULL);
 	if (err) {
 		dev_err(dev, "xdp_rxq_info_reg_mem_model failed\n");
+		xdp_rxq_info_unreg(&fq->channel->xdp_rxq);
 		return err;
 	}
 
@@ -4432,17 +4433,25 @@ static int dpaa2_eth_bind_dpni(struct dpaa2_eth_priv *priv)
 			return -EINVAL;
 		}
 		if (err)
-			return err;
+			goto out;
 	}
 
 	err = dpni_get_qdid(priv->mc_io, 0, priv->mc_token,
 			    DPNI_QUEUE_TX, &priv->tx_qdid);
 	if (err) {
 		dev_err(dev, "dpni_get_qdid() failed\n");
-		return err;
+		goto out;
 	}
 
 	return 0;
+
+out:
+	while (i--) {
+		if (priv->fq[i].type == DPAA2_RX_FQ &&
+		    xdp_rxq_info_is_reg(&priv->fq[i].channel->xdp_rxq))
+			xdp_rxq_info_unreg(&priv->fq[i].channel->xdp_rxq);
+	}
+	return err;
 }
 
 /* Allocate rings for storing incoming frame descriptors */
@@ -4825,6 +4834,17 @@ static void dpaa2_eth_del_ch_napi(struct dpaa2_eth_priv *priv)
 	}
 }
 
+static void dpaa2_eth_free_rx_xdp_rxq(struct dpaa2_eth_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_fqs; i++) {
+		if (priv->fq[i].type == DPAA2_RX_FQ &&
+		    xdp_rxq_info_is_reg(&priv->fq[i].channel->xdp_rxq))
+			xdp_rxq_info_unreg(&priv->fq[i].channel->xdp_rxq);
+	}
+}
+
 static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 {
 	struct device *dev;
@@ -5028,6 +5048,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	free_percpu(priv->percpu_stats);
 err_alloc_percpu_stats:
 	dpaa2_eth_del_ch_napi(priv);
+	dpaa2_eth_free_rx_xdp_rxq(priv);
 err_bind:
 	dpaa2_eth_free_dpbps(priv);
 err_dpbp_setup:
@@ -5080,6 +5101,7 @@ static void dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	free_percpu(priv->percpu_extras);
 
 	dpaa2_eth_del_ch_napi(priv);
+	dpaa2_eth_free_rx_xdp_rxq(priv);
 	dpaa2_eth_free_dpbps(priv);
 	dpaa2_eth_free_dpio(priv);
 	dpaa2_eth_free_dpni(priv);
-- 
2.36.1


