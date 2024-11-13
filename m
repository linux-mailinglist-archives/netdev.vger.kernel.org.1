Return-Path: <netdev+bounces-144616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A399C7F05
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C935B24DB7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA5193408;
	Wed, 13 Nov 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dUEh0PJh"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06721917C4;
	Wed, 13 Nov 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542223; cv=none; b=A7/zHBqoZQDMDP9LLDWCdLd9NWoc2SoLK4XyaKsRCDJkHL2WqCPCVF4mlIXV+R0oxZ73pBV+JeBL/fPXRoMTabGRyH3HdYjXPaUB4QMaMRdEuMLHCKFSD09HM7+qpjTj5q57fmETDo8MHMss7RhTI0BuecwxuvECCLAf3eDGVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542223; c=relaxed/simple;
	bh=5owxqDXstMN6SHOLEqqiW5l7qDBaLbB+d3MirCHt/8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4TGRx6U241XTvdAEL0I5TPqzf4kHR+cFqRhJqcPoqGQDM+YcloYZ94EiagE6eZC/dmlWCjJo5hlrxiGxxvGZf+emATnmaDhVinv42cNmOuoKmYk8wT+fLOpbmJQ3G9s4dgHFcpIZOv8ju1FXsJlDRNV/qI6atC8VueSnHPnD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=dUEh0PJh; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6960; q=dns/txt; s=iport;
  t=1731542220; x=1732751820;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xKLIfSrBTMEdou9XF+9pCY9FiWhEmlG0ZHo76FyHKjo=;
  b=dUEh0PJhNU9g2cYgWldTMPOmZmeBORl/C9vOYcIGsQSpLolcx+7Kqjgr
   3jIOQE2ZDJoVN1CrFn8elVXvG6SMQH/jMITliH0CsdECsFc42GOc99kmP
   1PgLTrcq4J2A2JuMM0A/30vJWB7jXBZCQUWI4eYfe3kvlwxy9d0bz2N9B
   k=;
X-CSE-ConnectionGUID: OnRzWLl7QLGGOGC+q/XR5A==
X-CSE-MsgGUID: Khr1ApE2Td2RbfZWkB4qMg==
X-IPAS-Result: =?us-ascii?q?A0AFAABLPDVn/4oQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJKgVBCSIRViB2HMIIhi3WSIxSBE?=
 =?us-ascii?q?QNWDwEBAQ9EBAEBhQcCikUCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThgiGWwIBAyMEUhAlAiYCAisbEAYBEoMBgmUCAbBten8zg?=
 =?us-ascii?q?QGEe9k4gW2BGi4BiEsBgWyDfTuEPCcbgUlEgRWBO4E+b4Qqg3SCaQSCQYNVU?=
 =?us-ascii?q?nYlgRMCAgIHAoN8g3lbmE4JP4EFHANZIREBVRMNCgsHBWNXPAMib2pceiuBD?=
 =?us-ascii?q?oEXOkOBO4EiLxshC1yBN4EZARQGFQSBDkY/gkppSzoCDQI2giQkWYJPhRqEb?=
 =?us-ascii?q?YRmglQvHUADCxgNSBEsNQYOGwY9AW4HnmVGgysHgQ+BJgcDYyxjklwKg3KNP?=
 =?us-ascii?q?oIfn0yEJKFcM6pNmHcio05OhGaBZzyBWTMaCBsVgyJSGQ+OLRYWkwABtj9DN?=
 =?us-ascii?q?TsCBwsBAQMJkEkBAQ?=
IronPort-Data: A9a23:t4p2qKNl01GsegPvrR12lsFynXyQoLVcMsEvi/4bfWQNrUorhjYDy
 zceWm3UPPreZTT2KNh1bt6+8kMEvsDVmIdkTXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZAb8gmUsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69JoNlMJGYlHw8JYLkZh3
 r8BbwA3MznW0opawJrjIgVtrs0nKM+uOMYUvWttiGmAS/0nWpvEBa7N4Le03h9p2ZsIRqiYP
 pRfMGE/BPjDS0Un1lM/Dp8zh+yvjHDXeDxDo1XTrq0yi4TW5FcgiuK3YICOJLRmQ+12nlzBj
 3rrpVj1WCsQOu6gyhDZ61ej07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH6DpBsHc9ldCes37EeK0KW8ywWEDGEsTTNbbtEi8sgsSlQC3
 1mFhd72RjpirLGYV1qZ67GS6ziyUQANJGUPYy4sVwYJ49D/5oo0i3rnStdlDb7wjdDvHzz06
 y6FoTJ4hLgJi8MPkaKh8jjvhT+wqpXXZhA66x+RXW+/6A59Iom/aOSVBUPz5PJEKsOdC1KGp
 nVBw5HY5+EVBpbLnyuIKAkQIIyUCz++GGW0qTZS81MJrlxBJ1bLkVhs3QxD
IronPort-HdrOrdr: A9a23:SsX8f62IMJ/+Pn7+uzPTkAqjBH8kLtp133Aq2lEZdPWaSL3+qy
 nIppQmPH7P6Qr5N0tNpTntAsS9qDbnhPtICOoqU4tKIjOW21dARbsKheCJ/9SjIVydygc378
 hdmsZFebnNJGk/oMrk7Ay/Cto6hPuK4MmT9J/j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZe
 OhD7J81lydkbB9VLXAOpHDNNKz3OH2qA==
X-Talos-CUID: =?us-ascii?q?9a23=3AMPQQxWusp6MSAlzYUhChlAbq6IsCdEfP81PUfHa?=
 =?us-ascii?q?cJklOZ5bWUBigwv5Nxp8=3D?=
X-Talos-MUID: 9a23:YFB5VAnbQE5pVn9GgHPGdnpBNN0xyryDUnwBy68Mtfu7NgYsIhKS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="392228236"
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:54 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 5BA671800019A;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id D5BCACC12A5; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:36 +0000
Subject: [PATCH net-next v4 4/7] enic: Allocate arrays in enic struct based
 on VIC config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-4-a34cf8570c67@cisco.com>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=7119;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=5owxqDXstMN6SHOLEqqiW5l7qDBaLbB+d3MirCHt/8w=;
 b=z5IZXmvKbmF9fvwHuFOjYqalykDRw8sn9jfD3FxtKqwNWWB4vl65qryJAj/Mew7SOeAig8QXy
 TA+kIiA/Tu7D1jGJnHRGwVQf6VbrlWOsOkfXIbkYOh7bwOxTHZ4PrJY
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com

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
index 98d6e0b825525a92f12776259c1c9c9730cb8a1e..10b7e02ba4d0ee37bf492eebf1b2556a745bee21 100644
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


