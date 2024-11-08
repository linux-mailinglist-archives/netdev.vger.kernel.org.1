Return-Path: <netdev+bounces-143446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB69C2734
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B301F21EAB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC81F5821;
	Fri,  8 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lErp51ra"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25131F26CD;
	Fri,  8 Nov 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102623; cv=none; b=G0142/dvinu3tHvDpiHHG8RjV4kAEhHLX7TfW7vbWzy+FTa2JR5Vf+DdVcsuXu6s+cPeJWzkDRBpoX8fU57+SyV+Z7YEkWGJKeYEoOtT6gK/sRlBZk+pQeZqTOmozIv/58IuZHQtF6IPS5zz6LH+nKZ0Yu8t2YHtPClUO/NyvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102623; c=relaxed/simple;
	bh=QtIVFbVGBYj5JREn7vN0UZu7VcWRmQYTsiHdSKZGm+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuIqQwa5mizBfKBzp4uzdKi7hmg2JnQwtZrPrQrdcQ/TVN1AchR7p8XQHgQmK05RRFU3f29DGA1DLHZX0PTJ7LbPhmR2WCEA03yXvqNfeoI847vHSAbLg2+vvS5xtmmAMWCUZikRCr8V8yvsaLCTtP4mQQCN9KWptjO+oESwTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=lErp51ra; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6191; q=dns/txt; s=iport;
  t=1731102622; x=1732312222;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PyWtOUrxpB55r8TtBgwj7aFJpNi+G9Fo6NJ2RK4oWeo=;
  b=lErp51rasrO2cZsDr1Gji4q8fr0T4lq+3DWbjI2zxvqfWAZX7yK3U04E
   tENf18jo315ZhnERBZTPQGY4eETMZRzzIu/xHJ4tQgptlGjUmEDLNANx1
   Lx+AvqeUx53ece5TtsjS7BuPotLs0p9jGra9P/TQZjxB67724nUc4WC5n
   8=;
X-CSE-ConnectionGUID: reZh0nw+RU2XBF6fwJDOpQ==
X-CSE-MsgGUID: Wg4NDScEQ56GiIhbCB96Vw==
X-IPAS-Result: =?us-ascii?q?A0ACAAA5hi5nj47/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYQaQkiEVYgdhzCOFpIjgSUDVg8BAQEPRAQBA?=
 =?us-ascii?q?YUHAoo6AiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBA?=
 =?us-ascii?q?QEBAQE5BUmGCIZbAgEDIwRSECUCJgICKxsQBgESgwGCZQIBsFp6fzOBAYR72?=
 =?us-ascii?q?TiBbYEaLgGISwGBbIN9O4Q8JxuBSUSBFINpiB6CaQSHYiWJFZhSCT+BBRwDW?=
 =?us-ascii?q?SERAVUTDQoLBwVjWD4DIm9pXHorgQ6BFzpDgTuBIi8bIQtcgTiBGQEUBhUEg?=
 =?us-ascii?q?Q5BP4JKaUs3Ag0CNoIkJFmCT4UdhG+EaIISHUADCxgNSBEsNQYOGwY9AW4Hn?=
 =?us-ascii?q?ilGgyYHgQ6BMZRMEYNpjT2CH59MhCShWTOqTZh3IqQbhGaBZzqBWzMaCBsVg?=
 =?us-ascii?q?yJSGQ+OLQ0JFpMAAbU6QzU7AgcLAQEDCZIZAQE?=
IronPort-Data: A9a23:KF21Iq/Pln6xmARr5pOSDrUDen6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 mNLD2zUa/qIYGbxcoonPNu0pktUsJaByIIyGQtr/H9EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qoyyHjEAX9gWItazpEs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2ksML8YouBoQltzr
 8wyBm4DcTKvoPqPlefTpulE3qzPLeHxN48Z/3UlxjbDALN+HNbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0cn1lQ/UPrSmM+ui3TkeDpSoXqepLE85C7YywkZPL3Fa4WKIYDTHZkK9qqej
 l3Jo0LVORo3DYHB5juk8niHrL6RozyuDer+E5Xjq6Y12wfMroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U59QuE4qnZ+QCUAi4DVDEpQNUguNU7Wn8s2
 0OFks3BASFptvueSRq17r6eoDWzETIYIW8LeWkPSg5ty93ippwjyxHCVNBuFIargdDvXzL92
 TaHqG45nbp7pcgGy6m243jZjD+24JvEVAg44kPQRG3N0+9iTJSua4rt7R3Q6uxNad7ECFKAp
 3MD3cOZ6YjiEK1higSXTdcNRLe2pMy4ag32rwBhALsN0CyUrivLkZ9r3BlyI0JgM8AhcDDvY
 VPOtQ452HO1FCX3BUOQS9ztY/nG3ZTd+cLZuuc4h+eig6SdlifapEmChmbJgwgBdXTAd4lka
 f93lu73Ux4n5VxPlmbeegvk+eZDKtoC7W3SX4vn6B+szKCTYnWYIZ9cbwDXNrhltvLc8F2Im
 zq6Cyds40sHOAEZSnSHmbP/0XhTcBDX+Liv8ZUOLb/ZSuaYMDt8UaWMqV/eR2CVt/8IzriTp
 C7Vtr5ww1vkjnqPMhSRdn1mc/vuW505xU/XzgRyVWtEL0MLON71hI9GLsNfVeB+pIRLk6UuJ
 9FbIJroPxi6Ymick9jrRcWm9NQ6HPlq7CrSVxeYjM8XJM46HlCQoYe0IGMCNkAmV0KKiCf3m
 JX4viuzfHbJb14K4Br+AB53826MgA==
IronPort-HdrOrdr: A9a23:l09c/6BFYkHZ+FblHemd55DYdb4zR+YMi2TDtnoddfUxSKfzqy
 nApoV/6faKskd0ZJhCo7y90cu7MBHhHPdOiOEs1L6ZLW7bkWGjRbsD0WNFrgePJwTk+vdZxe
 N8dcFFeb7NJEJnhsX36hTQKbkd6cSAmZrIudvj
X-Talos-CUID: 9a23:IKFN5mAsSTxtuDr6EzNqxk5MHN9mSECH/F3+fUGnK0pOUITAHA==
X-Talos-MUID: 9a23:KxsisAtyv1NA/vEdAc2nuz4+EutT6ImXVR4ikLQGseKuZHJOJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="377341047"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id 1921C1800022F;
	Fri,  8 Nov 2024 21:49:13 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 1EEEECC12AD; Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:52 +0000
Subject: [PATCH net-next v3 6/7] enic: Move enic resource adjustments to
 separate function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-6-3ba8123bcffc@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=6449;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=QtIVFbVGBYj5JREn7vN0UZu7VcWRmQYTsiHdSKZGm+M=;
 b=XuxHNRo6IxLMgAmjKzcgjAstDXlIOQliLABTauG6dkMfNOd+G3BExcHiWcHrIesERB8scLzWI
 UlsVcJID4a5D/6zoM8caD+at4Ca1NviY2Lp4BpkRmW2/WpV7ENU/pWv
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=

Move the enic resource adjustments out of enic_set_intr_mode() and into
its own function, enic_adjust_resources().

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
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


