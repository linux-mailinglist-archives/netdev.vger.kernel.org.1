Return-Path: <netdev+bounces-137715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B39A97BA
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248511C21A5F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C482D83;
	Tue, 22 Oct 2024 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="kSdDpDsf"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0004EB38
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570723; cv=none; b=qP6E7l7BEz/xak00i+LWwz+FJtO7aeUycK6MRg+c+pr25FkF7itdF4Yu72pOLlKf92Gd1/TLpTyvSNs07C8eBEkGFgoZ5NgmhBnxzpDeUrtwEYchLxCpGspAbHmUPv109Ar08ox/IKdpPWXcagzFUGeB61cSnwbP1IlA1vSyssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570723; c=relaxed/simple;
	bh=09cAVEe9j8qGzQFQF8pxQvRMeI2pYl1vhYnW2Al656c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYuzZL4nxBTjSznhgSS1O3a32Em2Hnb0c61v1mLe45bPu+nm5g0hagnxkK+9bvfDsn5+FCQmqgxY1Jb3t//vFOHn6hCF7DddjC2lMql7mI3dGbVrF+FM4haf+rbbI/MRe3MmMITYNlKtSZwpJxOAu6kjsuXcBhaTZI9dxeSMnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=kSdDpDsf; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3820; q=dns/txt; s=iport;
  t=1729570722; x=1730780322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RacxNF7c4jaMAjFcLtK9Bt2ej642MBqc/gXWznPvjSI=;
  b=kSdDpDsf5fi/C/JJAPKtsb8Ilw1yrWJMeVBLDZ2GiI6PhhBMUtYueN6l
   ISJ3tQ8DrDQV4Lk21DjrlRYn0mmYI9xqHmw9TYZmkSYst2BQVaDuOevGS
   c4DRZAXy1qGNwaml6hcqPCk6aHKE2K9Dwtc/WOZRlUzOcpZhikm9qNWMe
   c=;
X-CSE-ConnectionGUID: LcHaTsvOS8eU7KRe0F6/ew==
X-CSE-MsgGUID: qE09txZGRsC/QxEPwWG9Dw==
X-IPAS-Result: =?us-ascii?q?A0A8AABGJhdn/5X/Ja1aHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kqBT0NIjHJflGeSIoElA1YPAQEBD0QEAQGFBwKKIwImNAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQUSsrGYMBgmUDr?=
 =?us-ascii?q?1uBeTOBAYR72TiBbIFIAY1FcIR3JxuBSUSCUIE+b4sHBJxzfIlikXZIgSEDW?=
 =?us-ascii?q?SECEQFVEw0KCwkFgUyHaYMmKYFrgQiDCIUlgWcJYYhHgQctgRGBHzqCA4E2S?=
 =?us-ascii?q?oU3Rz+CT2pONwINAjeCJIEAglGGR0ADCxgNSBEsNRQbBj5uB6x6RoJfB4EPg?=
 =?us-ascii?q?hOBD6R0oH6EJKE/GjOEBZQBkkaYd6Q6hGaBZzyBWTMaCBsVgyJSGQ+OLRbMP?=
 =?us-ascii?q?iYyOwIHCwEBAwmOKAEB?=
IronPort-Data: A9a23:0ucvRa0JyVQSdC+bdvbD5ZRwkn2cJEfYwER7XKvMYLTBsI5bpzxRn
 GRMDGuBb6neZjPwe9l0bt/ipx8BsJHUnNJgSwNl3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yEzmG4E/0YtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 Lsen+WFYAX5gmYuaDpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGKEoWNLED5MFMUWxzq
 t8iJWgjMFeOmLfjqF67YrEEasULNsLnOsYb/3pn1zycVKxgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUiRC/FMEg9/5JYWmuqlnXL4eTRwo1OOrq1x6G/WpOB0+OKzaoqKJYfaH625mG6Bi
 zqX43TLLSsBH5um2Re97U2D18PQyHaTtIU6UefQGuRRqFue2mAeFjUIWlah5/q0kEizX5RYM
 UN8x8Y1hbI5+EruSpz2WAe15Sfe+BUdQNFXVeY97Wlh15bp3upQPUBcJhYpVTDsnJZeqeACv
 rNRo+7UOA==
IronPort-HdrOrdr: A9a23:3yXiwKmjqMAgHAOvAaDfKrf/MZ/pDfIr3DAbv31ZSRFFG/FwWf
 rAoB19726StN9/YhAdcLy7VZVoBEmsl6KdgrNhWYtKIjOHhILAFugLhuHfKn/bakjDH4Vmu5
 uIHZITNDSJNykYsS4/izPIaurJB7K8gcaVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3ADI05+Wji33jYeD6paqPkisnEczJuVnb9xUvLPWi?=
 =?us-ascii?q?DWWtUF56vRAe+puRpjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AFBsItA8Slx359TJl1+k8+PiQf95Fu/WyGHIiq44?=
 =?us-ascii?q?t/PCUGBRvBBjMoCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,222,1725321600"; 
   d="scan'208";a="262877382"
Received: from rcdn-l-core-12.cisco.com ([173.37.255.149])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2024 04:18:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-12.cisco.com (Postfix) with ESMTP id 5D4661800026A;
	Tue, 22 Oct 2024 04:18:34 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 412739)
	id 3213D20F2003; Mon, 21 Oct 2024 21:18:34 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com,
	johndale@cisco.com,
	Nelson Escobar <neescoba@cisco.com>
Subject: [Patch net-next 3/5] enic: Save resource counts we read from HW
Date: Mon, 21 Oct 2024 21:17:05 -0700
Message-Id: <20241022041707.27402-4-neescoba@cisco.com>
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
X-Outbound-Node: rcdn-l-core-12.cisco.com

Save the resources counts for wq,rq,cq, and interrupts in *_avail variables
so that we don't lose the information when adjusting the counts we are
actually using.

Report the wq_avail and rq_avail as the channel maximums in 'ethtool -l'
output.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h        |  4 ++++
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  4 ++--
 drivers/net/ethernet/cisco/enic/enic_res.c    | 19 ++++++++++++-------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index ac7236f76a51..1f32413a8f7c 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -206,23 +206,27 @@ struct enic {
 
 	/* work queue cache line section */
 	____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
+	unsigned int wq_avail;
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
 	/* receive queue cache line section */
 	____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
+	unsigned int rq_avail;
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
 	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
 
 	/* interrupt resource cache line section */
 	____cacheline_aligned struct vnic_intr intr[ENIC_INTR_MAX];
+	unsigned int intr_avail;
 	unsigned int intr_count;
 	u32 __iomem *legacy_pba;		/* memory-mapped */
 
 	/* completion queue cache line section */
 	____cacheline_aligned struct vnic_cq cq[ENIC_CQ_MAX];
+	unsigned int cq_avail;
 	unsigned int cq_count;
 	struct enic_rfs_flw_tbl rfs_h;
 	u32 rx_copybreak;
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 909d6f7000e1..d607b4f0542c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -695,8 +695,8 @@ static void enic_get_channels(struct net_device *netdev,
 
 	switch (vnic_dev_get_intr_mode(enic->vdev)) {
 	case VNIC_DEV_INTR_MODE_MSIX:
-		channels->max_rx = ENIC_RQ_MAX;
-		channels->max_tx = ENIC_WQ_MAX;
+		channels->max_rx = min(enic->rq_avail, ENIC_RQ_MAX);
+		channels->max_tx = min(enic->wq_avail, ENIC_WQ_MAX);
 		channels->rx_count = enic->rq_count;
 		channels->tx_count = enic->wq_count;
 		break;
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 6910f83185c4..e26e43dbfa9c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -187,16 +187,21 @@ void enic_free_vnic_resources(struct enic *enic)
 
 void enic_get_res_counts(struct enic *enic)
 {
-	enic->wq_count = vnic_dev_get_res_count(enic->vdev, RES_TYPE_WQ);
-	enic->rq_count = vnic_dev_get_res_count(enic->vdev, RES_TYPE_RQ);
-	enic->cq_count = vnic_dev_get_res_count(enic->vdev, RES_TYPE_CQ);
-	enic->intr_count = vnic_dev_get_res_count(enic->vdev,
-		RES_TYPE_INTR_CTRL);
+	enic->wq_avail = vnic_dev_get_res_count(enic->vdev, RES_TYPE_WQ);
+	enic->rq_avail = vnic_dev_get_res_count(enic->vdev, RES_TYPE_RQ);
+	enic->cq_avail = vnic_dev_get_res_count(enic->vdev, RES_TYPE_CQ);
+	enic->intr_avail = vnic_dev_get_res_count(enic->vdev,
+						  RES_TYPE_INTR_CTRL);
+
+	enic->wq_count = enic->wq_avail;
+	enic->rq_count = enic->rq_avail;
+	enic->cq_count = enic->cq_avail;
+	enic->intr_count = enic->intr_avail;
 
 	dev_info(enic_get_dev(enic),
 		"vNIC resources avail: wq %d rq %d cq %d intr %d\n",
-		enic->wq_count, enic->rq_count,
-		enic->cq_count, enic->intr_count);
+		enic->wq_avail, enic->rq_avail,
+		enic->cq_avail, enic->intr_avail);
 }
 
 void enic_init_vnic_resources(struct enic *enic)
-- 
2.35.2


