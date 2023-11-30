Return-Path: <netdev+bounces-52323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566F7FE499
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2ED7282410
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA9180;
	Thu, 30 Nov 2023 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0CTuJPA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7861BF4
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701303067; x=1732839067;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lgxEZ3d+2hbS28CKoWQf+cPvMiDKdJEcNrEnkYKQ0HY=;
  b=f0CTuJPAA8n3Hrdi17dK5x+sIZEeM65shJBM6pDLgr/QUkGpCvjXE4sN
   ojzH2E2dLAf61I/psepNe+YKO8BSQEmLS/xujJB/ADOSDV6SmVkZ6dEBQ
   pSt/DnZKfVNV6wzAGpagglMLBIYbth+4uC6Laa2OQWn//JBkSDRtFoGh9
   DjYPOdjjSKKIUCM5kqZTdDn9srMayEe9QDq9Ku1nksR51AEPSVy0Zg9yL
   zjSei06WLG+oHA5Dd5RqCfuyOUzlKJP78xTp+lyr9OwUfLhXLq4WDxBdA
   /Vc5rIv7usFlS7a/MIywfkoNTnTnWGdhKac4UFoEqIkrHUSZAJ8SRpJ1q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6516711"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6516711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 16:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="860004506"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="860004506"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Nov 2023 16:11:05 -0800
Subject: [net-next PATCH v10 02/11] net: Add queue and napi association
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com
Date: Wed, 29 Nov 2023 16:27:33 -0800
Message-ID: <170130405381.5198.9101458398130202413.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add the napi pointer in netdev queue for tracking the napi
instance for each queue. This achieves the queue<->napi mapping.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/linux/netdevice.h     |    8 ++++++++
 include/net/netdev_rx_queue.h |    4 ++++
 net/core/dev.c                |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 998c7aaa98b8..821b81730c0e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -665,6 +665,10 @@ struct netdev_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool    *pool;
 #endif
+	/* NAPI instance for the queue
+	 * Readers and writers must hold RTNL
+	 */
+	struct napi_struct      *napi;
 /*
  * write-mostly part
  */
@@ -2655,6 +2659,10 @@ static inline void *netdev_priv(const struct net_device *dev)
  */
 #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
 
+void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+			  enum netdev_queue_type type,
+			  struct napi_struct *napi);
+
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
  */
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index cdcafb30d437..aa1716fb0e53 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -21,6 +21,10 @@ struct netdev_rx_queue {
 #ifdef CONFIG_XDP_SOCKETS
 	struct xsk_buff_pool            *pool;
 #endif
+	/* NAPI instance for the queue
+	 * Readers and writers must hold RTNL
+	 */
+	struct napi_struct		*napi;
 } ____cacheline_aligned_in_smp;
 
 /*
diff --git a/net/core/dev.c b/net/core/dev.c
index 3950ced396b5..0a2eecbeef38 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6400,6 +6400,43 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 }
 EXPORT_SYMBOL(dev_set_threaded);
 
+/**
+ * netif_queue_set_napi - Associate queue with the napi
+ * @dev: device to which NAPI and queue belong
+ * @queue_index: Index of queue
+ * @type: queue type as RX or TX
+ * @napi: NAPI context, pass NULL to clear previously set NAPI
+ *
+ * Set queue with its corresponding napi context. This should be done after
+ * registering the NAPI handler for the queue-vector and the queues have been
+ * mapped to the corresponding interrupt vector.
+ */
+void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
+			  enum netdev_queue_type type, struct napi_struct *napi)
+{
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	if (WARN_ON_ONCE(napi && !napi->dev))
+		return;
+	if (dev->reg_state >= NETREG_REGISTERED)
+		ASSERT_RTNL();
+
+	switch (type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		rxq = __netif_get_rx_queue(dev, queue_index);
+		rxq->napi = napi;
+		return;
+	case NETDEV_QUEUE_TYPE_TX:
+		txq = netdev_get_tx_queue(dev, queue_index);
+		txq->napi = napi;
+		return;
+	default:
+		return;
+	}
+}
+EXPORT_SYMBOL(netif_queue_set_napi);
+
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {


