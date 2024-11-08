Return-Path: <netdev+bounces-143442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8979C272C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A0283AD8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC321D1519;
	Fri,  8 Nov 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="GFcrYCKq"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B819A28D;
	Fri,  8 Nov 2024 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102562; cv=none; b=JFB0nBN220wZqLQFD7WjJ11nkgKJG+sPEjeYHxhuKho6D+L43IO5zjSI+hrCBjH2oh2dvYEgmq+BiQP4W0UFXAwU/U3K9muOTcox7TnCmRAzG8KTO/Cq2mFEZ0SUu3BJno5wgPDW3ZiLBqA9UZk4oVLRHSCedeINLcfBzdOxWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102562; c=relaxed/simple;
	bh=zG0pnFfmCDMAJ+eK4a9AAcJEzHFseuHYHQmT/1eBiyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nM+vQG0vVU/t5UXhQmgYrVrKnVLncYGWYJB2ldfZRv3OjTVJvGpQ6VLpDlAuYPfGBISzrZKogfafP3uZSWjqHDHuUiD14qccitv42KOP61eAhd7DYoTmzmSQaaVmzTA/gySmFEfvbdidX6Pmvi/HM8QLTujXuzvsII07guWlGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=GFcrYCKq; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6960; q=dns/txt; s=iport;
  t=1731102560; x=1732312160;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R2A01fl2qoObns+t9iSIOEepQAEKaqoMSZq4LZWXw+Y=;
  b=GFcrYCKq4bIvByDjmRYKM0SXvH8qfH3SVxIToG3ehVhuvCl7MVwTGMUd
   u00/fJPV//G6ilDA9dM9HeZIp2Jz0i2gBS2SHwwNKttNjJLSuZuBl/ndb
   NS8jNw2G86N9a0m5KWHNhwe4GsnaTKWH9wYAlQBZvs9wP6oaNXejKn9Wq
   E=;
X-CSE-ConnectionGUID: oMyOmn41R2uAvifhKTx5vw==
X-CSE-MsgGUID: T5Fapq/nQMSOwOv9yGwxjQ==
X-IPAS-Result: =?us-ascii?q?A0AHAACvhi5n/4v/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJKgVBCSIRViB2HMIIhi3WSIxSBEQNWDwEBA?=
 =?us-ascii?q?Q9EBAEBhQcCijoCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4ThgiGWwIBAyMEUhAlAiYCAisbEAYBEoMBgmUCAbBden8zgQGEe9k4g?=
 =?us-ascii?q?W2BGi4BiEsBgWyDfTuEPCcbgUlEgRWBO4E+b4Qqg3SCaQSCRoNUUnYlgRMCA?=
 =?us-ascii?q?gIHAodzW5d3CT+BBRwDWSERAVUTDQoLBwVjWD4DIm9pXHorgQ6BFzpDgTuBI?=
 =?us-ascii?q?i8bIQtcgTiBGQEUBhUEgQ5BP4JKaUs3Ag0CNoIkJFmCT4UdhG+EaIISHUADC?=
 =?us-ascii?q?xgNSBEsNQYOGwY9AW4HnilGgyYHgQ+BJgcDYyxjkloKg3CNPYIfn0yEJKFZM?=
 =?us-ascii?q?6pNmHcio01OhGaBZzyBWTMaCBsVgyJSGQ+OLRYWkwABtUBDNTsCBwsBAQMJk?=
 =?us-ascii?q?hkBAQ?=
IronPort-Data: A9a23:SU3Z06y0f38awrJWrWp6t+flxyrEfRIJ4+MujC+fZmUNrF6WrkVWy
 mMbXDvTPv6IM2KhKoh1Poiy9R4C65CBytQ3SgNtqFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 ImaT/H3Ygf/h2ctajJMt8pvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJEYTLKod/LouOztT3
 OIZJjAuUgDemf3jldpXSsE07igiBNPgMIVavjRryivUSK58B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2bMnWjOX9PYH46tOGli2L0dDdRgFmUvqEwpWPUyWSd1ZC3b4KOJYTQFZw9ckCwm
 j/o9nzgRRcjEee41h2bo2ODmf/NpHauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYcXMBVCMU55RuLx66S5ByWbkAHUzRIQN8rrsk7QXotz
 FDht9rvCSZir/6TRG6R+6m8qS60P24eLQcqfSYOQA0Ey8PurIE6klTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Ejp7EUgI4+C3JUW+/qAB0foioY8qv81ez0BpbBJySQl/Eu
 D0PnNKTqbhUS5qMjyeKBu4KGdlF+sq4DdEVunY3d7FJythn0yfLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:SSMo/a8nhLv3Vl6NBb5uk+AVI+orL9Y04lQ7vn2ZhyYlFfBw8P
 rPoB17737JYVkqNE3I9ersBEDEewK4yXcX2+cs1MmZLWrbUQKTRekIh7cKgQeQeREWndQz6U
 4PSdkbNPTASXV3ksr+5hC1CJIDzMnvytHRuc7ui1pgUg1ubbht9ENCCgidGlBrXwUuP+tBKH
 Pl3Lsgm9JlEk5nFPhSwRI+LpP+m+E=
X-Talos-CUID: =?us-ascii?q?9a23=3AI/LW32mT7mbl8UxKqyJ3t34uO2/XOXr43VDVJRP?=
 =?us-ascii?q?hMzx0YaOUR1+zxLM5jdU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AGCK79w3XFc3VZzLSbHnJr8o8hjUj3/mAAVgU1pM?=
 =?us-ascii?q?/nvKjKgtuaiaykyS1e9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="270370281"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 88D7918000222;
	Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 101FBCC12A5; Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:50 +0000
Subject: [PATCH net-next v3 4/7] enic: Allocate arrays in enic struct based
 on VIC config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-4-3ba8123bcffc@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=7119;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=zG0pnFfmCDMAJ+eK4a9AAcJEzHFseuHYHQmT/1eBiyY=;
 b=SRxdr4iquTxQOmdNqsM2pV80RA6xBTGJQsUEhfZJNhq4tcvimE3INgnAQIsSHrO9JGUL/Gh2H
 GNrdd7nCBDnAxNZMettCdDp+JQFnPxkuKnnvJYdeJsGj7OE1q9lxF4M
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

Allocate wq, rq, cq, intr, and napi arrays based on the number of
resources configured in the VIC.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic.h      | 24 ++++-----
 drivers/net/ethernet/cisco/enic/enic_main.c | 84 ++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 1f32413a8f7c690060fe385b50f7447943e72596..cfb4667953de2c578911aad138a1d392fa9d3bdc 100644
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
index eb00058b6c68ec5c1ac433b54b5bc6f3fb613777..564202e81a711a6791bef7e848627f0a439cc6f3 100644
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
@@ -2674,6 +2673,71 @@ static const struct netdev_stat_ops enic_netdev_stat_ops = {
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
+	enic->wq = kcalloc(enic->wq_avail, sizeof(struct enic_wq), GFP_KERNEL);
+	if (!enic->wq)
+		goto free_queues;
+
+	enic->rq = kcalloc(enic->rq_avail, sizeof(struct enic_rq), GFP_KERNEL);
+	if (!enic->rq)
+		goto free_queues;
+
+	enic->cq = kcalloc(enic->cq_avail, sizeof(struct vnic_cq), GFP_KERNEL);
+	if (!enic->cq)
+		goto free_queues;
+
+	enic->napi = kcalloc(enic->wq_avail + enic->rq_avail,
+			     sizeof(struct napi_struct), GFP_KERNEL);
+	if (!enic->napi)
+		goto free_queues;
+
+	enic->msix_entry = kcalloc(enic->intr_avail, sizeof(struct msix_entry),
+				   GFP_KERNEL);
+	if (!enic->msix_entry)
+		goto free_queues;
+
+	enic->msix = kcalloc(enic->intr_avail, sizeof(struct enic_msix_entry),
+			     GFP_KERNEL);
+	if (!enic->msix)
+		goto free_queues;
+
+	enic->intr = kcalloc(enic->intr_avail, sizeof(struct vnic_intr),
+			     GFP_KERNEL);
+	if (!enic->intr)
+		goto free_queues;
+
+	return 0;
+
+free_queues:
+	enic_free_enic_resources(enic);
+	return -ENOMEM;
+}
+
 static void enic_dev_deinit(struct enic *enic)
 {
 	unsigned int i;
@@ -2691,6 +2755,7 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_vnic_resources(enic);
 	enic_clear_intr_mode(enic);
 	enic_free_affinity_hint(enic);
+	enic_free_enic_resources(enic);
 }
 
 static void enic_kdump_kernel_config(struct enic *enic)
@@ -2734,6 +2799,12 @@ static int enic_dev_init(struct enic *enic)
 
 	enic_get_res_counts(enic);
 
+	err = enic_alloc_enic_resources(enic);
+	if (err) {
+		dev_err(dev, "Failed to allocate enic resources\n");
+		return err;
+	}
+
 	/* modify resource count if we are in kdump_kernel
 	 */
 	enic_kdump_kernel_config(enic);
@@ -2746,7 +2817,7 @@ static int enic_dev_init(struct enic *enic)
 	if (err) {
 		dev_err(dev, "Failed to set intr mode based on resource "
 			"counts and system capabilities, aborting\n");
-		return err;
+		goto err_out_free_vnic_resources;
 	}
 
 	/* Allocate and configure vNIC resources
@@ -2788,6 +2859,7 @@ static int enic_dev_init(struct enic *enic)
 	enic_free_affinity_hint(enic);
 	enic_clear_intr_mode(enic);
 	enic_free_vnic_resources(enic);
+	enic_free_enic_resources(enic);
 
 	return err;
 }

-- 
2.35.6


