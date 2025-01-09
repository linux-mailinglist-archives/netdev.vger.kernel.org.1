Return-Path: <netdev+bounces-156889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E9A08386
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB02F3A90EE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E0E204F9D;
	Thu,  9 Jan 2025 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLf9JxPA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7D205E31
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465495; cv=none; b=L0HLTZuHIyk30Eq+G4lFy+bAVa50Gsw8RdzW46xCfk2rudrLTDcSv3s8ZUByvFXRED5TG7Q2sP7rU5z69me5GIfUz6NwWFb+Fhs4W7464ghxZxTjy3QNebH5B6H3Hu04YBLmdx5OqBtZZlAnAi2047ZDx2T1mcL3D72R5ItC1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465495; c=relaxed/simple;
	bh=9STKZR++v1K6aFKrRxR2yATVX5LFBPD1PuzLbyW22Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epvH3dQ0Es9BNR5CeYIePJU8DfF+XOJn6Qe5qmk7OWG4FyxbxeVO2k8qWMsB9CJCLE0GMWAeofxcml1g+KWtsXDupKPGjyVSSz+y2JaOZFYuUHPJ8CXpgSEEEITPXP8drCeEUr9pwy3Ssg+0V0GF3xj3Am97cndJYSqrprV8zBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLf9JxPA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736465494; x=1768001494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9STKZR++v1K6aFKrRxR2yATVX5LFBPD1PuzLbyW22Cc=;
  b=mLf9JxPAoaMQnj+N2RiPnKaBcCjwNnu4z58n3gOh1Iz2e2Nb3+Vu/aZ4
   Nyp9ESe6kqzHOSKZpvK8p/HEBfyPQd9vVefeJj5b73jjK/s2l+Sh3uyFm
   NL+mtf0GjVLGsT/cQXOZ708IhJ0CvGVCBNzm5CpBqXq9Vavg15qLnFFhL
   Q4u9fqFZxZnUlViX81LvNyfx8cadM7QIgrOkWRYRuDLq0rhQ42+09OGpO
   hK+UIZwNyAmd1SJzWlP+olaj+PufpoSClqgBAjQpuZgl5CsIG9VIZz/H6
   v1l01/FNhb2VrwmGoMlugWAyBnAnN/RKMJ3owtDbh11dFNG5elJjsdYWm
   A==;
X-CSE-ConnectionGUID: nQL5pxOGQBGmhX+8YBjc3A==
X-CSE-MsgGUID: a1niD9R6TcqHjDwDeYdAQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47245121"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47245121"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:34 -0800
X-CSE-ConnectionGUID: NL+1q0YYTsip/tdcKSLKPQ==
X-CSE-MsgGUID: UUFBbTB2RJiba+XfUHk2AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="134399007"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:28 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v4 2/6] net: napi: add internal ARFS rmap management
Date: Thu,  9 Jan 2025 16:31:03 -0700
Message-ID: <20250109233107.17519-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109233107.17519-1-ahmed.zaki@intel.com>
References: <20250109233107.17519-1-ahmed.zaki@intel.com>
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
 include/linux/netdevice.h |  4 +++
 lib/cpu_rmap.c            |  2 +-
 net/core/dev.c            | 73 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 77 insertions(+), 3 deletions(-)

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
index acf20191e114..c789218cca5d 100644
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
index 8373e4cf56d8..1d4378962857 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6733,7 +6733,20 @@ EXPORT_SYMBOL(netif_queue_set_napi);
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
@@ -6748,6 +6761,62 @@ int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
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
+	rmap->obj[napi->napi_rmap_idx] = NULL;
+	cpu_rmap_put(rmap);
+}
+
+static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
+{
+	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
+	int rc;
+
+	if (!napi || !rmap)
+		return -EINVAL;
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
@@ -6759,7 +6828,7 @@ void netif_napi_set_irq(struct napi_struct *napi, int irq)
 
 #ifdef CONFIG_RFS_ACCEL
 	if (napi->dev->rx_cpu_rmap && napi->dev->rx_cpu_rmap_auto) {
-		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
+		rc = napi_irq_cpu_rmap_add(napi, irq);
 		if (rc) {
 			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
 				    rc);
-- 
2.43.0


