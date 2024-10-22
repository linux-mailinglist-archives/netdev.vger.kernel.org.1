Return-Path: <netdev+bounces-137717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57AC9A97BC
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39291B21467
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 04:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4083CD5;
	Tue, 22 Oct 2024 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KfhmdS1S"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709E824AD
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729570756; cv=none; b=KZJ2lHv582XBi6TzYbMyKV3UzO6ntLKXq1TNTKzNRfvJS2RGxxMlOKa0rGm5dFLaM9sfkkoZfy2Kw+BmD8YSkD87ylatu241uN2uCuMLjqiRGmI7FDgKTk20teIWhbyRhTqBDIg2kT4xu4y1frH9zqhHZ1Ey5TCZq0zPD6j23PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729570756; c=relaxed/simple;
	bh=wyERo6IQcqy01fB6Ygzvjz29FTVXeiVgStzGDnlhayo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Exgl05OFORGzX7HpEDWoLuIq7i73QukXHKYTKJLegz9QTAQTKVhL6zIaiyfJKSBg9gi2VSEg8IRrj7lG8wdFz1dVwp2BgNbvpVwTGgZdZf72ThowbP+a8A74a5jZW/aBcuxI8ehMS5UOHky1ALuFgzLOIq/axO7WSuiKQmRHxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=KfhmdS1S; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7865; q=dns/txt; s=iport;
  t=1729570754; x=1730780354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=euHFmU7yDdilMuv1aryHVx1KbTA00sOv9ElUY5NBvcQ=;
  b=KfhmdS1SWFv/udANUMJz8xDWZ38m7PfRvVzDCXDUPqKfs1BwE5dL9pMz
   zX43l1FMtzm+GkH52lOUq5JJo/Cv4b01JLh5J9uoQzIdhjeBYLuJ4Gc3d
   ey+bB+8+w5fUMB6lgd8p1SDCy69/V+lK+n3AGZcC+ENYMC4MtdT6Eg+l2
   A=;
X-CSE-ConnectionGUID: hqWQ2Hw2RVm6YyVu+9I73w==
X-CSE-MsgGUID: uzdVCsbeQzindMJtemvZXw==
X-IPAS-Result: =?us-ascii?q?A0ApAABGJhdn/5D/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfiHKLdZIigSUDVg8BAQEPRAQBAYUHAoojAiY0CQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBBwWBDhOGCIZbAgEDJwsBRhBRK?=
 =?us-ascii?q?ysZgwGCZQOvW4F5M4EB3jOBbIFIAY1FcIR3JxuBSUSBFAGDaIsHBI0qhmuGD?=
 =?us-ascii?q?gOCTXwliT1bkRtIgSEDWSECEQFVEw0KCwkFiTWCA4EjKYFrgQiDCIUlgWcJY?=
 =?us-ascii?q?YhHgQctgRGBHzqCA4E2SoU3Rz+CT2pONwINAjeCJIEAglGGR0ADCxgNSBEsN?=
 =?us-ascii?q?RQbBj5uB6x6RoJfB4EOei0HA4FyklgRkguBNJ9KhCShPxozqkyYd6Q6hGaBZ?=
 =?us-ascii?q?zyBWTMaCBsVgyJSGQ+OLRYWzCgmMjsCBwsBAQMJjigBAQ?=
IronPort-Data: A9a23:FZPx8KjfQDN3Fvrq+ZpJIsiMX161JxEKZh0ujC45NGQN5FlHY01je
 htvXD2GOq7eYzT1LYgna9vgo0hT6JKEzYcyS1Zs+Cs3FyNjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1HwdOKn9SAsvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSGULOZ82QsaD5Ns/jZ8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUY49lOW0FRr
 8YmLW48fy6exLOXn+mkH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHOPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgt/5JEWxI9EglH5fjBDo1WfrII84nPYy0p6172F3N/9IIPVHJkPzhjBz
 o7A13nrDi8xL9aS8CiE9H6JpPPCmD3JaJ1HQdVU8dYv2jV/3Fc7DhAKWValiee2h1T4WN9FL
 UEQvC00osAPGFeDVNLxWVi85XWDpBNZA4UWGOwh4wbLwa3Ri+qEOlU5ovd6QIROnKcLqfYCj
 DdlQ/uB6eRTjYCo
IronPort-HdrOrdr: A9a23:Tq/s76AJ7OFz/QvlHemr55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT0C7Y+eAdGSTSq3BkW+FL+o=
X-Talos-CUID: 9a23:v5xsAWBNx+BdLpr6Eyl+y3dOOt9/SEPYkkbBHVL7WEc2E6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3APzf2DQ3TJJmgD39Jl+NeMWrv9DUj/raiNmsWm5g?=
 =?us-ascii?q?/qciCOQlSJzqYkgaHXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,222,1725321600"; 
   d="scan'208";a="277142861"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Oct 2024 04:19:08 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTP id 9249A1800022B;
	Tue, 22 Oct 2024 04:19:07 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 412739)
	id 6739A20F2003; Mon, 21 Oct 2024 21:19:07 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com,
	johndale@cisco.com,
	Nelson Escobar <neescoba@cisco.com>
Subject: [Patch net-next 5/5] enic: Adjust used MSI-X wq/rq/cq/interrupt resources in a more robust way
Date: Mon, 21 Oct 2024 21:17:07 -0700
Message-Id: <20241022041707.27402-6-neescoba@cisco.com>
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
X-Outbound-Node: rcdn-l-core-07.cisco.com

Instead of erroring out on probe if the resources are not configured
exactly right in hardware, try to make due with the resources we do have.

To accomplish this do the following:
- Make enic_set_intr_mode() only set up interrupt related stuff.
- Move resource adjustment out of enic_set_intr_mode() into its own
  function, and basing the resources used on the most constrained
  resource.
- Move the kdump resources limitations into the new function too.

Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 197 ++++++++++----------
 1 file changed, 96 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index a5d607be66b7..094112ab5e4a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2440,113 +2440,120 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static int enic_set_intr_mode(struct enic *enic)
+static int enic_adjust_resources(struct enic *enic)
 {
-	unsigned int n = min_t(unsigned int, enic->rq_count, ENIC_RQ_MAX);
-	unsigned int m = min_t(unsigned int, enic->wq_count, ENIC_WQ_MAX);
-	unsigned int i;
+	unsigned int max_queues;
+	unsigned int rq_avail;
+	unsigned int wq_avail;
 
-	/* Set interrupt mode (INTx, MSI, MSI-X) depending
-	 * on system capabilities.
-	 *
-	 * Try MSI-X first
-	 *
-	 * We need n RQs, m WQs, n+m CQs, and n+m+2 INTRs
-	 * (the second to last INTR is used for WQ/RQ errors)
-	 * (the last INTR is used for notifications)
-	 */
+	if (enic->rq_avail < 1 || enic->wq_avail < 1 || enic->cq_avail < 2) {
+		dev_err(enic_get_dev(enic),
+			"Not enough resources available rq: %d wq: %d cq: %d\n",
+			enic->rq_avail, enic->wq_avail,
+			enic->cq_avail);
+		return -ENOSPC;
+	}
 
-	for (i = 0; i < enic->intr_avail; i++)
-		enic->msix_entry[i].entry = i;
+	if (is_kdump_kernel()) {
+		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
+		enic->rq_avail = 1;
+		enic->wq_avail = 1;
+		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
+		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
+		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
+	}
 
-	/* Use multiple RQs if RSS is enabled
-	 */
+	/* if RSS isn't set, then we can only use one RQ */
+	if (!ENIC_SETTING(enic, RSS))
+		enic->rq_avail = 1;
 
-	if (ENIC_SETTING(enic, RSS) &&
-	    enic->config.intr_mode < 1 &&
-	    enic->rq_count >= n &&
-	    enic->wq_count >= m &&
-	    enic->cq_count >= n + m &&
-	    enic->intr_count >= n + m + 2) {
+	switch (vnic_dev_get_intr_mode(enic->vdev)) {
+	case VNIC_DEV_INTR_MODE_INTX:
+	case VNIC_DEV_INTR_MODE_MSI:
+		enic->rq_count = 1;
+		enic->wq_count = 1;
+		enic->cq_count = 2;
+		enic->intr_count = enic->intr_avail;
+		break;
+	case VNIC_DEV_INTR_MODE_MSIX:
+		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
+		 * used based on which resource is the most constrained
+		 */
+		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
+		rq_avail = min(enic->rq_avail, ENIC_RQ_MAX);
+		max_queues = min(enic->cq_avail,
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+		if (wq_avail + rq_avail <= max_queues) {
+			/* we have enough cq and interrupt resources to cover
+			 *  the number of wqs and rqs
+			 */
+			enic->rq_count = rq_avail;
+			enic->wq_count = wq_avail;
+		} else {
+			/* recalculate wq/rq count */
+			if (rq_avail < wq_avail) {
+				enic->rq_count = min(rq_avail, max_queues / 2);
+				enic->wq_count = max_queues - enic->rq_count;
+			} else {
+				enic->wq_count = min(wq_avail, max_queues / 2);
+				enic->rq_count = max_queues - enic->wq_count;
+			}
+		}
+		enic->cq_count = enic->rq_count + enic->wq_count;
+		enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
-		if (pci_enable_msix_range(enic->pdev, enic->msix_entry,
-					  n + m + 2, n + m + 2) > 0) {
+		break;
+	default:
+		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
+		return -EINVAL;
+	}
 
-			enic->rq_count = n;
-			enic->wq_count = m;
-			enic->cq_count = n + m;
-			enic->intr_count = n + m + 2;
+	return 0;
+}
 
-			vnic_dev_set_intr_mode(enic->vdev,
-				VNIC_DEV_INTR_MODE_MSIX);
+static int enic_set_intr_mode(struct enic *enic)
+{
+	unsigned int i;
+	int num_intr;
 
-			return 0;
-		}
-	}
+	/* Set interrupt mode (INTx, MSI, MSI-X) depending
+	 * on system capabilities.
+	 *
+	 * Try MSI-X first
+	 */
 
 	if (enic->config.intr_mode < 1 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= m &&
-	    enic->cq_count >= 1 + m &&
-	    enic->intr_count >= 1 + m + 2) {
-		if (pci_enable_msix_range(enic->pdev, enic->msix_entry,
-					  1 + m + 2, 1 + m + 2) > 0) {
-
-			enic->rq_count = 1;
-			enic->wq_count = m;
-			enic->cq_count = 1 + m;
-			enic->intr_count = 1 + m + 2;
-
+	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
+		for (i = 0; i < enic->intr_avail; i++)
+			enic->msix_entry[i].entry = i;
+
+		num_intr = pci_enable_msix_range(enic->pdev, enic->msix_entry,
+						 ENIC_MSIX_MIN_INTR,
+						 enic->intr_avail);
+		if (num_intr > 0) {
 			vnic_dev_set_intr_mode(enic->vdev,
-				VNIC_DEV_INTR_MODE_MSIX);
-
+					       VNIC_DEV_INTR_MODE_MSIX);
+			enic->intr_avail = num_intr;
 			return 0;
 		}
 	}
 
-	/* Next try MSI
-	 *
-	 * We need 1 RQ, 1 WQ, 2 CQs, and 1 INTR
-	 */
+	/* Next try MSI */
 
 	if (enic->config.intr_mode < 2 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= 1 &&
-	    enic->cq_count >= 2 &&
-	    enic->intr_count >= 1 &&
+	    enic->intr_avail >= 1 &&
 	    !pci_enable_msi(enic->pdev)) {
-
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->cq_count = 2;
-		enic->intr_count = 1;
-
+		enic->intr_avail = 1;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_MSI);
-
 		return 0;
 	}
 
-	/* Next try INTx
-	 *
-	 * We need 1 RQ, 1 WQ, 2 CQs, and 3 INTRs
-	 * (the first INTR is used for WQ/RQ)
-	 * (the second INTR is used for WQ/RQ errors)
-	 * (the last INTR is used for notifications)
-	 */
+	/* Next try INTx */
 
 	if (enic->config.intr_mode < 3 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= 1 &&
-	    enic->cq_count >= 2 &&
-	    enic->intr_count >= 3) {
-
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->cq_count = 2;
-		enic->intr_count = 3;
-
+	    enic->intr_avail >= 3) {
+		enic->intr_avail = 3;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_INTX);
-
 		return 0;
 	}
 
@@ -2776,18 +2783,6 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_enic_resources(enic);
 }
 
-static void enic_kdump_kernel_config(struct enic *enic)
-{
-	if (is_kdump_kernel()) {
-		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
-		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
-		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
-	}
-}
-
 static int enic_dev_init(struct enic *enic)
 {
 	struct device *dev = enic_get_dev(enic);
@@ -2823,14 +2818,7 @@ static int enic_dev_init(struct enic *enic)
 		return err;
 	}
 
-	/* modify resource count if we are in kdump_kernel
-	 */
-	enic_kdump_kernel_config(enic);
-
-	/* Set interrupt mode based on resource counts and system
-	 * capabilities
-	 */
-
+	/* Set interrupt mode based on system capabilities */
 	err = enic_set_intr_mode(enic);
 	if (err) {
 		dev_err(dev, "Failed to set intr mode based on resource "
@@ -2838,6 +2826,13 @@ static int enic_dev_init(struct enic *enic)
 		goto err_out_free_vnic_resources;
 	}
 
+	/* Adjust resource counts based on most constrained resources */
+	err = enic_adjust_resources(enic);
+	if (err) {
+		dev_err(dev, "Failed to adjust resources\n");
+		goto err_out_free_vnic_resources;
+	}
+
 	/* Allocate and configure vNIC resources
 	 */
 
-- 
2.35.2


