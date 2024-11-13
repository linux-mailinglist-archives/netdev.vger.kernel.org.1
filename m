Return-Path: <netdev+bounces-144618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E79C7F09
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EE41F2257D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377419B5B8;
	Wed, 13 Nov 2024 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="X1Y3S/kg"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEA1946BC;
	Wed, 13 Nov 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542225; cv=none; b=fCATG7VN7CCQOnGu447G+z9S7Ou6cfXPvVVAINcNeY6pxOwg+9O/dz5f0NSWIGT+PFcZ2M59OGs3gBB7Hw8yzjg8aswH04PX7RA/e6zra8LDNWS29RYCPP25gUauSq/Hm/r/rmRegr1UZDjukyDoCM7EKxGciCg7wDxfwp/kqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542225; c=relaxed/simple;
	bh=MvXjUBEvjB7eEJ/Bu4ljMT1zyOIo5CsddFBMJVwXGt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHRvc1mI63FwdkBdQtZmG7YbfSfHWxt/3Yj1Z/OpA+uT+qt914JnxIo856PuRZGPBK8i6DQx/okZmoLr77/bgwigw2gjytVNOaUO14w4lCvjhOPYxgm5ZHBcS5YvpX3TOKww5KduFK1wO7JPELBqLEDKXhHqHWLuc28F/N7CPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=X1Y3S/kg; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6237; q=dns/txt; s=iport;
  t=1731542223; x=1732751823;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qftcgMzV0lob1J7dAZRYb3pGAgaYy5n0qlEWTtW7384=;
  b=X1Y3S/kgyjXjPUSeOYCuTlKdln1kVEmHADoueDMJWt0DjKIU4FhteWgt
   4SErKZ2b5UxZBY5wk/9JB/oq7qUSZiExZEM+A9R+q260nEkKvFPSI/klu
   hL6DZOLM/ot12RtqFuaou/UxbDfPLVnx3btsAy+GFTzwBsozLFtDb36K+
   k=;
X-CSE-ConnectionGUID: 8+eQtAfQQhuA6AjI8I9wJA==
X-CSE-MsgGUID: na9MQZNdSZyTzNH2iE9tAg==
X-IPAS-Result: =?us-ascii?q?A0AHAABLPDVn/40QJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJKgVBCSIRViB2HMI4WkiOBJQNWDwEBAQ9EB?=
 =?us-ascii?q?AEBhQcCikUCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFg?=
 =?us-ascii?q?Q4ThgiGWwIBAyMEUhAlAiYCAisbEAYBEoMBgmUCAbBten8zgQGEe9k4gW2BG?=
 =?us-ascii?q?i4BiEsBgWyDfTuEPCcbgUlEgRSDaYgegmkEh14lhR6DeZAsiH0JP4EFHANZI?=
 =?us-ascii?q?REBVRMNCgsHBWNXPAMib2pceiuBDoEXOkOBO4EiLxshC1yBN4EZARQGFQSBD?=
 =?us-ascii?q?kY/gkppSzoCDQI2giQkWYJPhRqEbYRmglQvHUADCxgNSBEsNQYOGwY9AW4Hn?=
 =?us-ascii?q?mVGgysHgQ6BMYEPkz8Rg2uNPoIfn0yEJKFcM6pNmHcipByEZoFnPIFZMxoIG?=
 =?us-ascii?q?xWDIlIZD44tFhaTAAG2P0M1OwIHCwEBAwmQSQEB?=
IronPort-Data: A9a23:OZe/CajAjdkV7S2f/wOAUaeLX161sxEKZh0ujC45NGQN5FlHY01je
 htvXW+FbvvZYDTzfN0gPI22900AvpeBy9RlGQM5+Sk2QiNjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD5NsvvY8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqVIuetOHUhAz
 MUYNRlTRxKi18Pn35CSH7wEasQLdKEHPasWvnVmiDWcBvE8TNWbH+PB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQTYz/7C7pm9Ausrn/yfiZTr1icjaE2+GPUigd21dABNfKOK4bQH5UPwhzwS
 mTu+W2oJygoEtCk+yu54FSM3O7izD/SV9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JQFPc/8ymOx7DS7gLfAXILJhZCddYvnMw7Xzon0
 hmOhdyBLTVpvKeYVjGb+6uYoC2aPTUTKykJZUcsVQIP7t/iiJs+ghLGUpBoF6vdptn0Hyzgh
 jOHti4zg50NgsMRkaa251bKh3SrvJehZgg4+gnaQEq74Q5jIo2ofYql7R7c9/koEWqCZlCFu
 H5Bn42V6/oDSMnR0ieMW+4KWrqu4p5pLQHhvLKmJLF5nxzFxpJpVdo4DO1WTKuxDvs5RA==
IronPort-HdrOrdr: A9a23:D0EVna3+/xVfHJZHYgywGgqjBH8kLtp133Aq2lEZdPWaSL3+qy
 nIppQmPH7P6Qr5N0tNpTntAsS9qDbnhPtICOoqU4tKIjOW21dARbsKheCJ/9SjIVydygc378
 hdmsZFebnNJGk/oMrk7Ay/Cto6hPuK4MmT9J/j5kYoYA10Z6Rn9gtjTjyaHEp/WRVcCfMCZe
 OhD7J81lydkbB9VLXAOpHDNNKz3OH2qA==
X-Talos-CUID: 9a23:L3DX0GHLjExQN9KgqmI3t0MtBukrS0Td0V6OCk2ZWUc4V5+8HAo=
X-Talos-MUID: 9a23:x3eqKgke2RKInEMme2DUdnpkPZZN2paIBHs/gKkUneneNAEhJx6S2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="392228242"
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:54 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-04.cisco.com (Postfix) with ESMTPS id E29831800019B;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id E05D2CC12AD; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:38 +0000
Subject: [PATCH net-next v4 6/7] enic: Move enic resource adjustments to
 separate function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-6-a34cf8570c67@cisco.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=6495;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=MvXjUBEvjB7eEJ/Bu4ljMT1zyOIo5CsddFBMJVwXGt4=;
 b=0+l8IXnRLM++s0wDhN0hoSr9zcpo0gFpjIgv2G4j3yiyVFCOy9zjxvhJrGPUVTv0Jwxe3ISLb
 vQIST5l5ZggDkf9xSLqy9kdBkyBB0HYTjvCBDvmiMAEbN7aKga2vFIq
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com

Move the enic resource adjustments out of enic_set_intr_mode() and into
its own function, enic_adjust_resources().

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 127 +++++++++++++++-------------
 1 file changed, 70 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 8b07899462d0671843579d16c8c935d9ebbe447b..84e85c9e2bf52f0089c0a8d03fb6d22ada4d086c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2448,30 +2448,11 @@ static int enic_set_intr_mode(struct enic *enic)
 	/* Set interrupt mode (INTx, MSI, MSI-X) depending
 	 * on system capabilities.
 	 *
-	 * We need a minimum of 1 RQ, 1 WQ, and 2 CQs
-	 *
+	 * Try MSI-X first
 	 */
 
-	if (enic->rq_avail < 1 || enic->wq_avail < 1 || enic->cq_avail < 2) {
-		dev_err(enic_get_dev(enic),
-			"Not enough resources available rq: %d wq: %d cq: %d\n",
-			enic->rq_avail, enic->wq_avail,
-			enic->cq_avail);
-		return -ENOSPC;
-	}
-
-	/* if RSS isn't set, then we can only use one RQ */
-	if (!ENIC_SETTING(enic, RSS))
-		enic->rq_avail = 1;
-
-	/* Try MSI-X first */
 	if (enic->config.intr_mode < 1 &&
 	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
-		unsigned int max_queues;
-		unsigned int rq_default;
-		unsigned int rq_avail;
-		unsigned int wq_avail;
-
 		for (i = 0; i < enic->intr_avail; i++)
 			enic->msix_entry[i].entry = i;
 
@@ -2479,28 +2460,6 @@ static int enic_set_intr_mode(struct enic *enic)
 						 ENIC_MSIX_MIN_INTR,
 						 enic->intr_avail);
 		if (num_intr > 0) {
-			wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
-			rq_default = netif_get_num_default_rss_queues();
-			rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
-			max_queues = min(enic->cq_avail,
-					 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
-
-			if (wq_avail + rq_avail <= max_queues) {
-				enic->rq_count = rq_avail;
-				enic->wq_count = wq_avail;
-			} else {
-				/* recalculate wq/rq count */
-				if (rq_avail < wq_avail) {
-					enic->rq_count = min(rq_avail, max_queues / 2);
-					enic->wq_count = max_queues - enic->rq_count;
-				} else {
-					enic->wq_count = min(wq_avail, max_queues / 2);
-					enic->rq_count = max_queues - enic->wq_count;
-				}
-			}
-			enic->cq_count = enic->rq_count + enic->wq_count;
-			enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
-
 			vnic_dev_set_intr_mode(enic->vdev,
 					       VNIC_DEV_INTR_MODE_MSIX);
 			enic->intr_avail = num_intr;
@@ -2516,14 +2475,8 @@ static int enic_set_intr_mode(struct enic *enic)
 	if (enic->config.intr_mode < 2 &&
 	    enic->intr_avail >= 1 &&
 	    !pci_enable_msi(enic->pdev)) {
-
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->cq_count = 2;
-		enic->intr_count = 1;
 		enic->intr_avail = 1;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_MSI);
-
 		return 0;
 	}
 
@@ -2537,14 +2490,8 @@ static int enic_set_intr_mode(struct enic *enic)
 
 	if (enic->config.intr_mode < 3 &&
 	    enic->intr_avail >= 3) {
-
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->cq_count = 2;
-		enic->intr_count = 3;
 		enic->intr_avail = 3;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_INTX);
-
 		return 0;
 	}
 
@@ -2569,6 +2516,67 @@ static void enic_clear_intr_mode(struct enic *enic)
 	vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_UNKNOWN);
 }
 
+static int enic_adjust_resources(struct enic *enic)
+{
+	unsigned int max_queues;
+	unsigned int rq_default;
+	unsigned int rq_avail;
+	unsigned int wq_avail;
+
+	if (enic->rq_avail < 1 || enic->wq_avail < 1 || enic->cq_avail < 2) {
+		dev_err(enic_get_dev(enic),
+			"Not enough resources available rq: %d wq: %d cq: %d\n",
+			enic->rq_avail, enic->wq_avail,
+			enic->cq_avail);
+		return -ENOSPC;
+	}
+
+	/* if RSS isn't set, then we can only use one RQ */
+	if (!ENIC_SETTING(enic, RSS))
+		enic->rq_avail = 1;
+
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
+		rq_default = netif_get_num_default_rss_queues();
+		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
+		max_queues = min(enic->cq_avail,
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+		if (wq_avail + rq_avail <= max_queues) {
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
+
+		break;
+	default:
+		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void enic_get_queue_stats_rx(struct net_device *dev, int idx,
 				    struct netdev_queue_stats_rx *rxs)
 {
@@ -2807,9 +2815,7 @@ static int enic_dev_init(struct enic *enic)
 	 */
 	enic_kdump_kernel_config(enic);
 
-	/* Set interrupt mode based on resource counts and system
-	 * capabilities
-	 */
+	/* Set interrupt mode based on system capabilities */
 
 	err = enic_set_intr_mode(enic);
 	if (err) {
@@ -2818,6 +2824,13 @@ static int enic_dev_init(struct enic *enic)
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
2.35.6


