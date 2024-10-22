Return-Path: <netdev+bounces-137716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4229A97BB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5341C22036
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3B823D1;
	Tue, 22 Oct 2024 04:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="hG3T7ZqP"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D17441A
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570741; cv=none; b=DK0glb+DSxs0JZdMLIQGo9mGFVBKyEu8Uvl5JKi6jhd6W6Mo6tSy4J+sHJiL3fwxXS4MGgHxJmaGJ3Ojj6wNBo8w5xfpC/TtoQ9oAvdUmkOa2MIrQHCGNoNi7ZDo0OGqVxSeHGQWO5vCsPAic7t8stQVS5+4Z9RpnwJXhIdsRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570741; c=relaxed/simple;
	bh=sZahI1qyZm1y50stL+D+KfTyu7n4sgpFOu1qmm+kIn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYbr8SpFvJbbmcHXs84AJWSt7/Kt7DKCg1dagLfp+DhtlQ0M15B64vk4dUz7ZgI/e+GBtSBtPS/gkhrXU0Dq2ED2MzVUlxXSx1ytUvZgiFDlOJ6fSnUjb9tjTSelPIOLXOW6w8mf0keiQsoSFj2ELfbyWBhjHTr47sYI8ut57uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=hG3T7ZqP; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7013; q=dns/txt; s=iport;
  t=1729570739; x=1730780339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WA8ghEKOr5jAfNLvGFwfJvJqlzmi9aenQqbE8to8Slc=;
  b=hG3T7ZqPS8KcpOxFQ1CcSG89nZ2b+0/SmLdwPgPc06kvpBDtcsgRKnm9
   66YB98X0eBINbUtNhRQ0cqRGDnaeWmiqUC/uz/qSZXY3xj/vb4fSlobrK
   pewllbZaZJMfnCgZ6nU6ZcpBXJDuTOcXmXNML7djtDuxkRVzjqTGDSsnL
   A=;
X-CSE-ConnectionGUID: oJpzYh9EQVS2eC88ueloEg==
X-CSE-MsgGUID: LFdPiHwPS4qSZvsNO3o82A==
X-IPAS-Result: =?us-ascii?q?A0ANAAC6Jhdn/4r/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkqBT0NIjHJfiHKLdZIiFIERA1YPAQEBD0QEAQGFBwKKI?=
 =?us-ascii?q?wImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQcFgQ4ThgiGWwIBA?=
 =?us-ascii?q?ycLAUYQUSsrGYMBgmUDr1uBeTOBAYR72TiBbIFIAY1FcIR3JxuBSUSBFYE7g?=
 =?us-ascii?q?T5vhCqGXQSUFYYcgW1VfCWBIAICAgcCiA5bkRtIgSEDWSECEQFVEw0KCwkFi?=
 =?us-ascii?q?TWDJimBa4EIgwiFJYFnCWGIR4EHLYERgR86ggOBNkqDaIFPRz+CT2pONwINA?=
 =?us-ascii?q?jeCJIEAglGGR0ADCxgNSBEsNRQbBj5uB6x6RoJfB4EPgSYHA2OBD5JYCpISg?=
 =?us-ascii?q?TSfSoQkoT8aM6pMmHejbU2EZoFnPIFZMxoIGxWDIlIZD44tFsw8JjI7AgcLA?=
 =?us-ascii?q?QEDCY4oAQE?=
IronPort-Data: A9a23:XQ/BMKqhcp3eLvlMGEolN6Qdc4BeBmJfZBIvgKrLsJaIsI4StFCzt
 garIBnUPfiNYmD0KtF2PoW/900BvJPWydZhTQRopXwyQXgRouPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOWn9z8kjPHgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQbNNwJcaDpOt/vb8kk35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0uFVGXN/9
 a01EQ42NB2o17Krzba8Z+Y506zPLOGzVG8ekmtrwTecCbMtRorOBv2To9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5MWPrSn8/w7pX7WztVpUmeoqA+y2PS1wd2lrPqNbI5f/TQGpsFxhvB9
 zOuE2LRJj8WDN2/1gK+rmuXtPHUuwSgX9JIPejtnhJtqBjJroAJMzUQWEe3rOeRlEGzQZRcJ
 lYS9y5oqrI9nHFHVfHnVBG+5XrBtRkGVp8ISqsx6RqGzezf5APx6nU4cwOtoecO7KceLQHGH
 HfQ9z81LVSDaIGodE8=
IronPort-HdrOrdr: A9a23:JRykh6xOQjTwWnXCAh3LKrPwK71zdoMgy1knxilNoNJuHfBw8P
 re+8jzuiWUtN98YhwdcJW7Scu9qBDnhPpICPcqXYtKNTOO0ADDEGgh1/qG/9SKIUPDH4BmuZ
 uIC5IOa+EZyTNB/L/HCM7SKadH/OW6
X-Talos-CUID: =?us-ascii?q?9a23=3A3RuB0GoaI1V497+azP6UgZTmUccHam/szCb9GnG?=
 =?us-ascii?q?DU2tCGO2IRFuX1awxxg=3D=3D?=
X-Talos-MUID: 9a23:D8EBOgTaUlwYekEdRXTIqj1aNed325/yEXs/j44gnJKDZXZZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,222,1725321600"; 
   d="scan'208";a="276805199"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2024 04:18:52 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTP id 6D8B818000295;
	Tue, 22 Oct 2024 04:18:51 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 412739)
	id 43B3A20F2003; Mon, 21 Oct 2024 21:18:51 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com,
	johndale@cisco.com,
	Nelson Escobar <neescoba@cisco.com>
Subject: [Patch net-next 4/5] enic: Allocate arrays in enic struct based on VIC config
Date: Mon, 21 Oct 2024 21:17:06 -0700
Message-Id: <20241022041707.27402-5-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241022041707.27402-1-neescoba@cisco.com>
References: <20241022041707.27402-1-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

Allocate wq, rq, cq, intr, and napi arrays based on the number of
resources configured in the VIC.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  24 ++---
 drivers/net/ethernet/cisco/enic/enic_main.c | 102 ++++++++++++++++++--
 2 files changed, 105 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 1f32413a8f7c..cfb4667953de 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -23,10 +23,8 @@
 
 #define ENIC_BARS_MAX		6
 
-#define ENIC_WQ_MAX		8
-#define ENIC_RQ_MAX		8
-#define ENIC_CQ_MAX		(ENIC_WQ_MAX + ENIC_RQ_MAX)
-#define ENIC_INTR_MAX		(ENIC_CQ_MAX + 2)
+#define ENIC_WQ_MAX		256
+#define ENIC_RQ_MAX		256
 
 #define ENIC_WQ_NAPI_BUDGET	256
 
@@ -184,8 +182,8 @@ struct enic {
 	struct work_struct reset;
 	struct work_struct tx_hang_reset;
 	struct work_struct change_mtu_work;
-	struct msix_entry msix_entry[ENIC_INTR_MAX];
-	struct enic_msix_entry msix[ENIC_INTR_MAX];
+	struct msix_entry *msix_entry;
+	struct enic_msix_entry *msix;
 	u32 msg_enable;
 	spinlock_t devcmd_lock;
 	u8 mac_addr[ETH_ALEN];
@@ -204,28 +202,24 @@ struct enic {
 	bool enic_api_busy;
 	struct enic_port_profile *pp;
 
-	/* work queue cache line section */
-	____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
+	struct enic_wq *wq;
 	unsigned int wq_avail;
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
-	/* receive queue cache line section */
-	____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
+	struct enic_rq *rq;
 	unsigned int rq_avail;
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
-	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
+	struct napi_struct *napi;
 
-	/* interrupt resource cache line section */
-	____cacheline_aligned struct vnic_intr intr[ENIC_INTR_MAX];
+	struct vnic_intr *intr;
 	unsigned int intr_avail;
 	unsigned int intr_count;
 	u32 __iomem *legacy_pba;		/* memory-mapped */
 
-	/* completion queue cache line section */
-	____cacheline_aligned struct vnic_cq cq[ENIC_CQ_MAX];
+	struct vnic_cq *cq;
 	unsigned int cq_avail;
 	unsigned int cq_count;
 	struct enic_rfs_flw_tbl rfs_h;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index eb00058b6c68..a5d607be66b7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -940,7 +940,7 @@ static void enic_get_stats(struct net_device *netdev,
 	net_stats->rx_errors = stats->rx.rx_errors;
 	net_stats->multicast = stats->rx.rx_multicast_frames_ok;
 
-	for (i = 0; i < ENIC_RQ_MAX; i++) {
+	for (i = 0; i < enic->rq_count; i++) {
 		struct enic_rq_stats *rqs = &enic->rq[i].stats;
 
 		if (!enic->rq[i].vrq.ctrl)
@@ -1792,7 +1792,7 @@ static void enic_free_intr(struct enic *enic)
 		free_irq(enic->pdev->irq, enic);
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
-		for (i = 0; i < ARRAY_SIZE(enic->msix); i++)
+		for (i = 0; i < enic->intr_count; i++)
 			if (enic->msix[i].requested)
 				free_irq(enic->msix_entry[i].vector,
 					enic->msix[i].devid);
@@ -1859,7 +1859,7 @@ static int enic_request_intr(struct enic *enic)
 		enic->msix[intr].isr = enic_isr_msix_notify;
 		enic->msix[intr].devid = enic;
 
-		for (i = 0; i < ARRAY_SIZE(enic->msix); i++)
+		for (i = 0; i < enic->intr_count; i++)
 			enic->msix[i].requested = 0;
 
 		for (i = 0; i < enic->intr_count; i++) {
@@ -2456,8 +2456,7 @@ static int enic_set_intr_mode(struct enic *enic)
 	 * (the last INTR is used for notifications)
 	 */
 
-	BUG_ON(ARRAY_SIZE(enic->msix_entry) < n + m + 2);
-	for (i = 0; i < n + m + 2; i++)
+	for (i = 0; i < enic->intr_avail; i++)
 		enic->msix_entry[i].entry = i;
 
 	/* Use multiple RQs if RSS is enabled
@@ -2674,6 +2673,89 @@ static const struct netdev_stat_ops enic_netdev_stat_ops = {
 	.get_base_stats		= enic_get_base_stats,
 };
 
+static void enic_free_enic_resources(struct enic *enic)
+{
+	kfree(enic->wq);
+	enic->wq = NULL;
+
+	kfree(enic->rq);
+	enic->rq = NULL;
+
+	kfree(enic->cq);
+	enic->cq = NULL;
+
+	kfree(enic->napi);
+	enic->napi = NULL;
+
+	kfree(enic->msix_entry);
+	enic->msix_entry = NULL;
+
+	kfree(enic->msix);
+	enic->msix = NULL;
+
+	kfree(enic->intr);
+	enic->intr = NULL;
+}
+
+static int enic_alloc_enic_resources(struct enic *enic)
+{
+	int ret;
+
+	enic->wq = NULL;
+	enic->rq = NULL;
+	enic->cq = NULL;
+	enic->napi = NULL;
+	enic->msix_entry = NULL;
+	enic->msix = NULL;
+	enic->intr = NULL;
+
+	enic->wq = kcalloc(enic->wq_avail, sizeof(struct enic_wq), GFP_KERNEL);
+	if (!enic->wq) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+	enic->rq = kcalloc(enic->rq_avail, sizeof(struct enic_rq), GFP_KERNEL);
+	if (!enic->rq) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+	enic->cq = kcalloc(enic->cq_avail, sizeof(struct vnic_cq), GFP_KERNEL);
+	if (!enic->cq) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+	enic->napi = kcalloc(enic->wq_avail + enic->rq_avail,
+			     sizeof(struct napi_struct), GFP_KERNEL);
+	if (!enic->napi) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+	enic->msix_entry = kcalloc(enic->intr_avail, sizeof(struct msix_entry),
+				   GFP_KERNEL);
+	if (!enic->msix_entry) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+	enic->msix = kcalloc(enic->intr_avail, sizeof(struct enic_msix_entry),
+			     GFP_KERNEL);
+	if (!enic->msix) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+	enic->intr = kcalloc(enic->intr_avail, sizeof(struct vnic_intr),
+			     GFP_KERNEL);
+	if (!enic->intr) {
+		ret = -ENOMEM;
+		goto free_queues;
+	}
+
+	return 0;
+
+free_queues:
+	enic_free_enic_resources(enic);
+	return ret;
+}
+
 static void enic_dev_deinit(struct enic *enic)
 {
 	unsigned int i;
@@ -2691,6 +2773,7 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_vnic_resources(enic);
 	enic_clear_intr_mode(enic);
 	enic_free_affinity_hint(enic);
+	enic_free_enic_resources(enic);
 }
 
 static void enic_kdump_kernel_config(struct enic *enic)
@@ -2734,6 +2817,12 @@ static int enic_dev_init(struct enic *enic)
 
 	enic_get_res_counts(enic);
 
+	err = enic_alloc_enic_resources(enic);
+	if (err) {
+		dev_err(dev, "Failed to allocate queues, aborting\n");
+		return err;
+	}
+
 	/* modify resource count if we are in kdump_kernel
 	 */
 	enic_kdump_kernel_config(enic);
@@ -2746,7 +2835,7 @@ static int enic_dev_init(struct enic *enic)
 	if (err) {
 		dev_err(dev, "Failed to set intr mode based on resource "
 			"counts and system capabilities, aborting\n");
-		return err;
+		goto err_out_free_vnic_resources;
 	}
 
 	/* Allocate and configure vNIC resources
@@ -2788,6 +2877,7 @@ static int enic_dev_init(struct enic *enic)
 	enic_free_affinity_hint(enic);
 	enic_clear_intr_mode(enic);
 	enic_free_vnic_resources(enic);
+	enic_free_enic_resources(enic);
 
 	return err;
 }
-- 
2.35.2


