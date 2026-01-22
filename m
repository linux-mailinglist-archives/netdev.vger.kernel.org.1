Return-Path: <netdev+bounces-252120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABgqIhJ1cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:53:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DAE6019A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F055E0F45
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECD31326C;
	Thu, 22 Jan 2026 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1PieVa+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5553128D2
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043095; cv=none; b=qA/RWb1sAtrE6x+08tS0KpAlBqd3gPUFg3z7g3xpVq7JHH5sUKgXcQGMS+VC/A9IsSmVajTAEAhFntpO7BNphg3fkeKlXDpA/IizRBCDyT3HQ2iAWxuo3ZeBf6J43ov4XEHHLoJAqBQTlAVRqSMDdJb16d122Yop1SO10JNETms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043095; c=relaxed/simple;
	bh=EsTtuNzdqT1J+apFCNMKmo3dkGanglaYkNC9AAfUxx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6fp4+dc2tbYVCKUAcBfbKBsaFQz+qnHktjA0vaFDHkRa2ZLoY+dUVfi+LEFMEraRgmt8PTFfb5IgtE+hROvJUrXx0JmY/FWubhcJzaP1yjl91Irt+x9m2PmsnghnHXGR9ZJsfqC82ebi8dV7suu1lovZgwYc0ACcPIcQNWuwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1PieVa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30556C19421;
	Thu, 22 Jan 2026 00:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043094;
	bh=EsTtuNzdqT1J+apFCNMKmo3dkGanglaYkNC9AAfUxx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1PieVa+ecL5Iy9t9HOZ8/+YsEg/rmxREoYB9pCjCrSufQk5drPEYYTpDD2ry1MF3
	 JphUBfWq0y9J3GkIzgh1Swl0JiUXRT2ZoJZNpY91vtHKMtVQeiJnmCCnlw410kYeFA
	 aUmzslI7QhXustXhMVekENg4eVAQs70PRqUl7TuBiddvRBnJcvBAZ2LOl8MSwmkycR
	 nNYNY9pzsrdCCdclBrbHNOZ76ZO5J/BoDU5S1VyAVFU5BrnJGlOoNU+ojgHYeY/ffx
	 ffEyRHgEyiCn9eZhA+nfszhci1DCq6t1mQYqWz3wSL6dnUJGzmPHMeqeQAs6qrLzZ3
	 frcQHstMeFecg==
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
Subject: [PATCH net-next 5/6] net: add queue config validation callback
Date: Wed, 21 Jan 2026 16:51:12 -0800
Message-ID: <20260122005113.2476634-6-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-252120-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 03DAE6019A
X-Rspamd-Action: no action

I imagine (tm) that as the number of per-queue configuration
options grows some of them may conflict for certain drivers.
While the drivers can obviously do all the validation locally
doing so is fairly inconvenient as the config is fed to drivers
piecemeal via different ops (for different params and NIC-wide
vs per-queue).

Add a centralized callback for validating the queue config
in queue ops. The callback gets invoked before memory provider
is installed, and in the future should also be called when ring
params are modified.

The validation is done after each layer of configuration.
Since we can't fail MP un-binding we must make sure that
the config is valid both before and after MP overrides are
applied. This is moot for now since the set of MP and device
configs are disjoint. It will matter significantly in the future,
so adding it now so that we don't forget..

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h | 10 ++++++
 net/core/dev.h              |  5 +++
 net/core/netdev_config.c    | 64 ++++++++++++++++++++++++++++++-------
 net/core/netdev_rx_queue.c  | 11 +++++--
 4 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 4b23c3697cc9..95ed28212f4e 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -143,6 +143,13 @@ enum {
  *			Queue config structs are passed to this helper before
  *			the user-requested settings are applied.
  *
+ * @ndo_validate_qcfg: (Optional) Check if queue config is supported.
+ *			Called when configuration affecting a queue may be
+ *			changing, either due to NIC-wide config, or config
+ *			scoped to the queue at a specified index.
+ *			When NIC-wide config is changed the callback will
+ *			be invoked for all queues.
+ *
  * @supported_params:	Bitmask of supported parameters, see QCFG_*.
  *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
@@ -166,6 +173,9 @@ struct netdev_queue_mgmt_ops {
 				  int idx);
 	void	(*ndo_default_qcfg)(struct net_device *dev,
 				    struct netdev_queue_config *qcfg);
+	int	(*ndo_validate_qcfg)(struct net_device *dev,
+				     struct netdev_queue_config *qcfg,
+				     struct netlink_ext_ack *extack);
 	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
 						 int idx);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index da18536cbd35..98793a738f43 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -10,6 +10,7 @@
 
 struct net;
 struct netlink_ext_ack;
+struct netdev_queue_config;
 struct cpumask;
 
 /* Random bits of netdevice that don't need to be exposed */
@@ -91,6 +92,10 @@ extern struct rw_semaphore dev_addr_sem;
 extern struct list_head net_todo_list;
 void netdev_run_todo(void);
 
+int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
+				 struct netdev_queue_config *qcfg,
+				 struct netlink_ext_ack *extack);
+
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
 	struct hlist_node hlist;
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 48f763446506..f14af365d5cd 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -4,6 +4,50 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 
+#include "dev.h"
+
+static int netdev_nop_validate_qcfg(struct net_device *dev,
+				    struct netdev_queue_config *qcfg,
+				    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int __netdev_queue_config(struct net_device *dev, int rxq_idx,
+				 struct netdev_queue_config *qcfg,
+				 struct netlink_ext_ack *extack,
+				 bool validate)
+{
+	int (*validate_cb)(struct net_device *dev,
+			   struct netdev_queue_config *qcfg,
+			   struct netlink_ext_ack *extack);
+	struct pp_memory_provider_params *mpp;
+	int err;
+
+	validate_cb = netdev_nop_validate_qcfg;
+	if (validate && dev->queue_mgmt_ops->ndo_validate_qcfg)
+		validate_cb = dev->queue_mgmt_ops->ndo_validate_qcfg;
+
+	memset(qcfg, 0, sizeof(*qcfg));
+
+	/* Get defaults from the driver, in case user config not set */
+	if (dev->queue_mgmt_ops->ndo_default_qcfg)
+		dev->queue_mgmt_ops->ndo_default_qcfg(dev, qcfg);
+	err = validate_cb(dev, qcfg, extack);
+	if (err)
+		return err;
+
+	/* Apply MP overrides */
+	mpp = &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
+	if (mpp->rx_page_size)
+		qcfg->rx_page_size = mpp->rx_page_size;
+	err = validate_cb(dev, qcfg, extack);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /**
  * netdev_queue_config() - get configuration for a given queue
  * @dev:      net_device instance
@@ -22,17 +66,13 @@
 void netdev_queue_config(struct net_device *dev, int rxq_idx,
 			 struct netdev_queue_config *qcfg)
 {
-	struct pp_memory_provider_params *mpp;
-
-	memset(qcfg, 0, sizeof(*qcfg));
-
-	/* Get defaults from the driver, in case user config not set */
-	if (dev->queue_mgmt_ops->ndo_default_qcfg)
-		dev->queue_mgmt_ops->ndo_default_qcfg(dev, qcfg);
-
-	/* Apply MP overrides */
-	mpp = &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
-	if (mpp->rx_page_size)
-		qcfg->rx_page_size = mpp->rx_page_size;
+	__netdev_queue_config(dev, rxq_idx, qcfg, NULL, false);
 }
 EXPORT_SYMBOL(netdev_queue_config);
+
+int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
+				 struct netdev_queue_config *qcfg,
+				 struct netlink_ext_ack *extack)
+{
+	return __netdev_queue_config(dev, rxq_idx, qcfg, extack, true);
+}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 72374930699a..668a90658f25 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -7,6 +7,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/memory_provider.h>
 
+#include "dev.h"
 #include "page_pool_priv.h"
 
 /* See also page_pool_is_unreadable() */
@@ -156,12 +157,18 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
 	rxq->mp_params = *p;
-	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
+	ret = netdev_queue_config_validate(dev, rxq_idx, &qcfg[1], extack);
+	if (ret)
+		goto err_clear_mp;
 
 	ret = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
 	if (ret)
-		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+		goto err_clear_mp;
 
+	return 0;
+
+err_clear_mp:
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	return ret;
 }
 
-- 
2.52.0


