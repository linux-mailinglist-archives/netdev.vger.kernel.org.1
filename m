Return-Path: <netdev+bounces-157820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5801A0BE7C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C37A166323
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D321C5D73;
	Mon, 13 Jan 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCfBzXr+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA51BD01F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788274; cv=none; b=S+rOU9tj6vhUX+l9z5NvceT/UDu9dO6eVbn87KpkexY9nrjnZ9VmLgTcpiZmP5rEYchnFS4YUpuqrPtPHQDymDnrLgn6HBdBT72H8MShIjsOyG7uwbwsjiRFFiiXQ8pXWBSxD1yhBpKWWSXqfsD1UXv20ucCqFCGJ2HzTfdXxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788274; c=relaxed/simple;
	bh=M1kBFaCRQrGgECULS3Q+cacd5kwzkoj1IfpHJOo69p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0Dw6mCWZWrxXyOzRMgmqiHssgIqAYImR7HChHzxeevXZkRaRgOk+wGxyi8Elm5xpYKv5snNsGcCVlmmWzwNh0obt18+DRk52D7Tr7FZll8if8DwljYOkmfkEWFeFZNlD0CfXbIKppQaHw64fbXlXHmTYYAUYxenRRaRH1gyx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCfBzXr+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736788273; x=1768324273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M1kBFaCRQrGgECULS3Q+cacd5kwzkoj1IfpHJOo69p0=;
  b=ZCfBzXr+Ql+MmUhmXf606ExbEDOTSIioXZzw3q+9/UfHx96B7GMCpcOQ
   G0G4ZKeTi05Tocs1hHEPUdh3qJuHgl3msbsL+Y9ChMRYGbSteruTAH1tE
   iMN3TQBkML6guGZV1UYQ/UaqtITcGxoZygI16UBE6+CMLQtyUtX2yDDuV
   1APCrIJg8SmsuQXI0NyW2/T0Hb/hQy+zDKko5Th8KAWHhjv1u70i13WpK
   OiTwJzgnhhp1x0hOX7vQzLGx99SMI6mi5C25XoFymiwHmzwXpv6sddRSZ
   4pdcqDxiLIPXVDESF3QYuownIsRVd2Wur5aA+OoxUhXBACxVuy6jws0YB
   w==;
X-CSE-ConnectionGUID: fRLTxfZwQaeL1I/6PCvIlA==
X-CSE-MsgGUID: TudaHMKvT3WTspJevrdtfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36748845"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36748845"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:11:13 -0800
X-CSE-ConnectionGUID: 3X7BnHDiSKO32oRDwpLDyA==
X-CSE-MsgGUID: nzR8h5hpSsmxeZvVlzAqTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104499648"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:11:05 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	pavan.chebbi@broadcom.com,
	yury.norov@gmail.com,
	darinzon@amazon.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v5 2/6] net: napi: add internal ARFS rmap management
Date: Mon, 13 Jan 2025 10:10:38 -0700
Message-ID: <20250113171042.158123-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113171042.158123-1-ahmed.zaki@intel.com>
References: <20250113171042.158123-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For drivers using the netif_enable_cpu_rmap(), move the IRQ rmap notifier
inside the napi_struct.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/cpu_rmap.h  |  1 +
 include/linux/netdevice.h |  4 ++
 lib/cpu_rmap.c            |  2 +-
 net/core/dev.c            | 77 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/linux/cpu_rmap.h b/include/linux/cpu_rmap.h
index 20b5729903d7..2fd7ba75362a 100644
--- a/include/linux/cpu_rmap.h
+++ b/include/linux/cpu_rmap.h
@@ -32,6 +32,7 @@ struct cpu_rmap {
 #define CPU_RMAP_DIST_INF 0xffff
 
 extern struct cpu_rmap *alloc_cpu_rmap(unsigned int size, gfp_t flags);
+extern void cpu_rmap_get(struct cpu_rmap *rmap);
 extern int cpu_rmap_put(struct cpu_rmap *rmap);
 
 extern int cpu_rmap_add(struct cpu_rmap *rmap, void *obj);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e95e9ee36dd..6f8b416aa32b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -392,6 +392,10 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+#ifdef CONFIG_RFS_ACCEL
+	struct irq_affinity_notify notify;
+	int			napi_rmap_idx;
+#endif
 	int			index;
 	struct napi_config	*config;
 };
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index 4c348670da31..f03d9be3f06b 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -73,7 +73,7 @@ static void cpu_rmap_release(struct kref *ref)
  * cpu_rmap_get - internal helper to get new ref on a cpu_rmap
  * @rmap: reverse-map allocated with alloc_cpu_rmap()
  */
-static inline void cpu_rmap_get(struct cpu_rmap *rmap)
+void cpu_rmap_get(struct cpu_rmap *rmap)
 {
 	kref_get(&rmap->refcount);
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ee7a514dca8..c965d947b33d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6748,7 +6748,20 @@ EXPORT_SYMBOL(netif_queue_set_napi);
 #ifdef CONFIG_RFS_ACCEL
 static void netif_disable_cpu_rmap(struct net_device *dev)
 {
-	free_irq_cpu_rmap(dev->rx_cpu_rmap);
+	struct cpu_rmap *rmap = dev->rx_cpu_rmap;
+	struct napi_struct *napi;
+	u16 index;
+
+	if (!rmap || !dev->rx_cpu_rmap_auto)
+		return;
+
+	for (index = 0; index < rmap->size; index++) {
+		napi = rmap->obj[index];
+		if (napi && napi->irq > 0)
+			irq_set_affinity_notifier(napi->irq, NULL);
+	}
+
+	cpu_rmap_put(rmap);
 	dev->rx_cpu_rmap = NULL;
 	dev->rx_cpu_rmap_auto = false;
 }
@@ -6763,6 +6776,66 @@ int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
 	return 0;
 }
 EXPORT_SYMBOL(netif_enable_cpu_rmap);
+
+static void
+netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
+			  const cpumask_t *mask)
+{
+	struct napi_struct *napi =
+		container_of(notify, struct napi_struct, notify);
+	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
+	int err;
+
+	if (rmap && napi->dev->rx_cpu_rmap_auto) {
+		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
+		if (err)
+			pr_warn("%s: RMAP update failed (%d)\n",
+				__func__, err);
+	}
+}
+
+static void
+netif_napi_affinity_release(struct kref *ref)
+{
+	struct napi_struct *napi =
+		container_of(ref, struct napi_struct, notify.kref);
+	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
+
+	if (!rmap || !napi->dev->rx_cpu_rmap_auto)
+		return;
+
+	rmap->obj[napi->napi_rmap_idx] = NULL;
+	cpu_rmap_put(rmap);
+}
+
+static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
+{
+	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
+	int rc;
+
+	if (!rmap)
+		return -EINVAL;
+
+	napi->notify.notify = netif_irq_cpu_rmap_notify;
+	napi->notify.release = netif_napi_affinity_release;
+	cpu_rmap_get(rmap);
+	rc = cpu_rmap_add(rmap, napi);
+	if (rc < 0)
+		goto err_add;
+
+	napi->napi_rmap_idx = rc;
+	rc = irq_set_affinity_notifier(irq, &napi->notify);
+	if (rc)
+		goto err_set;
+
+	return 0;
+
+err_set:
+	rmap->obj[napi->napi_rmap_idx] = NULL;
+err_add:
+	cpu_rmap_put(rmap);
+	return rc;
+}
 #endif
 
 void netif_napi_set_irq(struct napi_struct *napi, int irq)
@@ -6774,7 +6847,7 @@ void netif_napi_set_irq(struct napi_struct *napi, int irq)
 
 #ifdef CONFIG_RFS_ACCEL
 	if (napi->dev->rx_cpu_rmap && napi->dev->rx_cpu_rmap_auto) {
-		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
+		rc = napi_irq_cpu_rmap_add(napi, irq);
 		if (rc) {
 			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
 				    rc);
-- 
2.43.0


