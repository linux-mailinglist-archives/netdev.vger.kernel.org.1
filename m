Return-Path: <netdev+bounces-252119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJHCDeR0cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D865D6017E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DADE93C50B0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4231282C;
	Thu, 22 Jan 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFN3EQwf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67230311C33
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043094; cv=none; b=C98SMHz1sMbQCUygB9JEnKmszF1yqPUafm/WxmC/1P65ZIDFHB+rdFmVo4NpiTKUvN0DCwzKQePMEB6FYKZXi08ORdYCOe/sAI5d847MgHhoze7Ujcs6AGQSf8t5BgBRZSH52tCBN256q+BJYb4H9FA5Mq4OHKV+NFB4fvTpFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043094; c=relaxed/simple;
	bh=iH6VSp1YnWkeVg8b6diJizHDnczm2jP5J+A2zUEXRYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9qZcVm/+mJJ//+AkPbt/0Esfvs9K1mi5NzREOYH9ISAWqyLkahAlgn2rnX3CINwIhMiuXzWQyIupNAGl86FiateVMg/qxiaC6SIq9fuWV/286w5fQdTX89rMr3+VPue0P7IfLZQnyxpUXGv0g3SKmPsaMAUKHYvXK05HeykYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFN3EQwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61264C4CEF1;
	Thu, 22 Jan 2026 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043094;
	bh=iH6VSp1YnWkeVg8b6diJizHDnczm2jP5J+A2zUEXRYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFN3EQwfGNI5vVy200mQrJh1h19FiMNiS95A56qU+zuz2y0w2oNYijcab0f6tXCcE
	 Bw4Q1IsuZZlpu6MJCyxLNMn+xCe6DdqzW2++sRNUNSZTR4iDu5B9bdDFJim0l1l7GH
	 AiGPOnQebswZDoBPm0rXVOmeXCLijH5ghWtVwMLPSqxMdSH1GQQgE7Omds9fzxXqcl
	 1j6UW2OqIDpyfGjepVIcySyO2cZoZ4GWXT9j/4WwClPLw9hRNI0fjIyAbTEGePQh4C
	 NluVVeYSdO8TpzAzu87Y3/90KLl/3UPBc3TGI2DomrSmUivoV7DlZjoxY8YORsrQkx
	 8h5XtDIFQHyfA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/6] net: use netdev_queue_config() for mp restart
Date: Wed, 21 Jan 2026 16:51:11 -0800
Message-ID: <20260122005113.2476634-5-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122005113.2476634-1-kuba@kernel.org>
References: <20260122005113.2476634-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252119-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: D865D6017E
X-Rspamd-Action: no action

We should follow the prepare/commit approach for queue configuration.
The qcfg struct should be added to dev->cfg rather than directly to
queue objects so that we can clone and discard the pending config
easily.

Remove the qcfg in struct netdev_rx_queue, and switch remaining callers
to netdev_queue_config(). netdev_queue_config() will construct the qcfg
on the fly based on device defaults and state of the queue.

ndo_default_qcfg becomes optional because having the callback itself
does not have any meaningful semantics to us.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h |  4 +++-
 net/core/dev.c              | 17 ---------------
 net/core/netdev_config.c    | 12 ++++++++---
 net/core/netdev_rx_queue.c  | 43 +++++++++++++++++++++----------------
 4 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 725bf69ef86c..4b23c3697cc9 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -139,7 +139,9 @@ enum {
  * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
  *			   for this queue. Return NULL on error.
  *
- * @ndo_default_qcfg:	Populate queue config struct with defaults. Optional.
+ * @ndo_default_qcfg:	(Optional) Populate queue config struct with defaults.
+ *			Queue config structs are passed to this helper before
+ *			the user-requested settings are applied.
  *
  * @supported_params:	Bitmask of supported parameters, see QCFG_*.
  *
diff --git a/net/core/dev.c b/net/core/dev.c
index 048ab4409a2c..2661b68f5be3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11282,21 +11282,6 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 	}
 }
 
-static void init_rx_queue_cfgs(struct net_device *dev)
-{
-	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
-	struct netdev_rx_queue *rxq;
-	int i;
-
-	if (!qops || !qops->ndo_default_qcfg)
-		return;
-
-	for (i = 0; i < dev->num_rx_queues; i++) {
-		rxq = __netif_get_rx_queue(dev, i);
-		qops->ndo_default_qcfg(dev, &rxq->qcfg);
-	}
-}
-
 /**
  * register_netdevice() - register a network device
  * @dev: device to register
@@ -11342,8 +11327,6 @@ int register_netdevice(struct net_device *dev)
 	if (!dev->name_node)
 		goto out;
 
-	init_rx_queue_cfgs(dev);
-
 	/* Init, if this function is available */
 	if (dev->netdev_ops->ndo_init) {
 		ret = dev->netdev_ops->ndo_init(dev);
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 562087bd30c8..48f763446506 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -22,11 +22,17 @@
 void netdev_queue_config(struct net_device *dev, int rxq_idx,
 			 struct netdev_queue_config *qcfg)
 {
-	struct netdev_queue_config *stored;
+	struct pp_memory_provider_params *mpp;
 
 	memset(qcfg, 0, sizeof(*qcfg));
 
-	stored = &__netif_get_rx_queue(dev, rxq_idx)->qcfg;
-	qcfg->rx_page_size = stored->rx_page_size;
+	/* Get defaults from the driver, in case user config not set */
+	if (dev->queue_mgmt_ops->ndo_default_qcfg)
+		dev->queue_mgmt_ops->ndo_default_qcfg(dev, qcfg);
+
+	/* Apply MP overrides */
+	mpp = &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
+	if (mpp->rx_page_size)
+		qcfg->rx_page_size = mpp->rx_page_size;
 }
 EXPORT_SYMBOL(netdev_queue_config);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 03d7531abb3a..72374930699a 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -18,11 +18,13 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
-int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+static int netdev_rx_queue_reconfig(struct net_device *dev,
+				    unsigned int rxq_idx,
+				    struct netdev_queue_config *qcfg_old,
+				    struct netdev_queue_config *qcfg_new)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
-	struct netdev_queue_config qcfg;
 	void *new_mem, *old_mem;
 	int err;
 
@@ -30,18 +32,8 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	    !qops->ndo_queue_mem_alloc || !qops->ndo_queue_start)
 		return -EOPNOTSUPP;
 
-	if (WARN_ON_ONCE(qops->supported_params && !qops->ndo_default_qcfg))
-		return -EINVAL;
-
 	netdev_assert_locked(dev);
 
-	memset(&qcfg, 0, sizeof(qcfg));
-	if (qops->ndo_default_qcfg)
-		qops->ndo_default_qcfg(dev, &qcfg);
-
-	if (rxq->mp_params.rx_page_size)
-		qcfg.rx_page_size = rxq->mp_params.rx_page_size;
-
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
 		return -ENOMEM;
@@ -52,7 +44,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
+	err = qops->ndo_queue_mem_alloc(dev, qcfg_new, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
 
@@ -65,7 +57,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		if (err)
 			goto err_free_new_queue_mem;
 
-		err = qops->ndo_queue_start(dev, &qcfg, new_mem, rxq_idx);
+		err = qops->ndo_queue_start(dev, qcfg_new, new_mem, rxq_idx);
 		if (err)
 			goto err_start_queue;
 	} else {
@@ -77,7 +69,6 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	kvfree(old_mem);
 	kvfree(new_mem);
 
-	rxq->qcfg = qcfg;
 	return 0;
 
 err_start_queue:
@@ -88,7 +79,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	 * WARN if we fail to recover the old rx queue, and at least free
 	 * old_mem so we don't also leak that.
 	 */
-	if (qops->ndo_queue_start(dev, &rxq->qcfg, old_mem, rxq_idx)) {
+	if (qops->ndo_queue_start(dev, qcfg_old, old_mem, rxq_idx)) {
 		WARN(1,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
@@ -106,6 +97,14 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 
 	return err;
 }
+
+int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
+{
+	struct netdev_queue_config qcfg;
+
+	netdev_queue_config(dev, rxq_idx, &qcfg);
+	return netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg, &qcfg);
+}
 EXPORT_SYMBOL_NS_GPL(netdev_rx_queue_restart, "NETDEV_INTERNAL");
 
 int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
@@ -113,6 +112,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      struct netlink_ext_ack *extack)
 {
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int ret;
 
@@ -154,8 +154,11 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	}
 #endif
 
+	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
 	rxq->mp_params = *p;
-	ret = netdev_rx_queue_restart(dev, rxq_idx);
+	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
+
+	ret = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
 	if (ret)
 		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 
@@ -176,6 +179,7 @@ int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
+	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int err;
 
@@ -195,8 +199,11 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
+	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
 	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
-	err = netdev_rx_queue_restart(dev, ifq_idx);
+	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
+
+	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
 	WARN_ON(err && err != -ENETDOWN);
 }
 
-- 
2.52.0


