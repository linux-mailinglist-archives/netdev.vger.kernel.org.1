Return-Path: <netdev+bounces-143449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4849C273A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E931F211FE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C920DD40;
	Fri,  8 Nov 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="FKbzNgeY"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248061A9B33;
	Fri,  8 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102625; cv=none; b=UutahZTwZqAmIQ8alZ0OrREdleCV9jGFuA3BT08k5HkGuySI8DVKECMpIy9qIhFWLj5e58u1d7wbs8rJuUQ2p+VbaKGd11ApFBskMHDITJ53rO1xBT4SfoBXy1upvJ9442Nsbg942r+v41rJh4wsp8MR6f8AIefy0K4L/azgoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102625; c=relaxed/simple;
	bh=mninbMArocvS6AE+lwVCGhfK4ejOfQE8gCkKXB/dNtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G29uzmu10Uf4yH4IuY8PC6lvCEO3kNkrEz5qgjqrMKDKjhUDvj1tRahHhd74s9Cdbz36D7qYSbcVg0QKea6G+ayRJa0ZoeY+kefgvsjqAyqVvnxKbHpcodV28QS/tvvrYG4VOXUauiEMK9S1XHKvXlFmpe+oEgwQ71AVvSA4K2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=FKbzNgeY; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5848; q=dns/txt; s=iport;
  t=1731102623; x=1732312223;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=I7OTkuoFHF/S5MDa31Q8DP6vHJIajVzvqL+oz+KRYPM=;
  b=FKbzNgeYmQdeBb+M5pSTZzrMPVdRzbV49Xumwja0x4GX4qZFb7Lp3+3g
   /7aPvOcfKT2aQty7ogJIQWVBpnWTogoR3hxVyWH5heUWEIDSrwcRZIY+C
   SPPmA79iQR8kOPK75S4p8wCb8xii0/VuMZ+Jo74HeOqRHour+FCbPuO6q
   s=;
X-CSE-ConnectionGUID: Lkfx0kXGQ8KIV4nzxTet2g==
X-CSE-MsgGUID: mhhIWeriTIiA/O7A37fHWg==
X-IPAS-Result: =?us-ascii?q?A0AGAAA5hi5nj4//Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYQaQkiEVYgdhzCOFpIjgSUDVg8BAQEPRAQBAYUHAoo6A?=
 =?us-ascii?q?iY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5B?=
 =?us-ascii?q?UmGCIZbAgEDIwRSECUCJgICKxsQBgESgwGCZQIBsFp6fzOBAd4zgW2BGi4Bi?=
 =?us-ascii?q?EsBgWyDfTuEPCcbgUlEgRQBg2iEG4QDgmkEhDEDgjh2JYkVW5d3CT+BBRwDW?=
 =?us-ascii?q?SERAVUTDQoLBwVjWD4DIm9pXHorgQ6BFzpDgTuBIi8bIQtcgTiBGhQGFQSBD?=
 =?us-ascii?q?kE/gkppSzcCDQI2giQkWYJPhR2Eb4RoghIdQAMLGA1IESw1Bg4bBj0BbgeeK?=
 =?us-ascii?q?UaDLYEOgScHgXWSa4NpjT2ha4QkoVkzqk2YdyKkG4RmgWc6gVszGggbFYMiU?=
 =?us-ascii?q?hkPji0NCRaTAAG1OkM1OwIHCwEBAwmQHYF8AQE?=
IronPort-Data: A9a23:rpd7CKLBSrY9dpIcFE+RK5UlxSXFcZb7ZxGr2PjKsXjdYENS1mcBm
 DZMWTiObqneY2T0e4siOorl9B5XucDVzdRgSFAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgP8gmYkaj58B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1KD08mZY4o1d8nIkBwq
 foKOAwAckqM0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBU7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2ME+ojx5nYj/7DLo4keqzjX71ehVTqUmeouw85G27IAlZi+ezYYWLI4fSLSlTtkOYp
 kP58n74PjAbHZu4lhPerXyMueCayEsXX6pJSeXnraQ16LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ8E5cTz5YI+lBTCSv59H6OvyN74Azf9x
 3aNtidWr7MekcIGyY2l8l3dxTGhvJ7ESkgy/Aq/Y46+xhlyaIjgY8mj7kLWqK4eao2YVVKG+
 nMDnqBy8dziE7mplyKdGOY9M4j5xNe7bDvOkWJiA8MuomHFF2GYQahc5zR3JUFMO8kCeCP0b
 EK7he+3zMEOVJdNRfErC79dG/gXIb7c+cMJv804j+aigLAtJWdrHwk3OSZ8OlwBdmB3z8nT3
 r/AL66R4Y4yU/gP8dZPb751PUUX7i4/33jPYpvw0g6q17GTDFbMFuxcaAPSNLFhvPvZyOkwz
 zq5H5XSo/m4eLCuChQ7DaZKcDjm0FBiX8mv8J0NHgJ9ClA7Qjt8YxMu/V/RU9c4x/sOzLigE
 oCVUU5Dw123nmzcNQiPcThibripNauTXlplVRHAyW2AgiB5Ca72tf93X8JuLdEPqrc5pdYqF
 KZtRil1KqgUItgx02hGNcGlxGGjHTz37T+z092NO2hlJsI5HFSZpLcJvGLHrUEzM8Z+juNmy
 5XI6+8RacNrq9hKZCoOVM+S8g==
IronPort-HdrOrdr: A9a23:wuFh66rRTPx6lEB2rSf7kDMaV5oaeYIsimQD101hICG9E/b0qy
 nKpp9w6faaskd1ZJheo6HlBEDiex/hHPxOkOss1N6ZNWHbUWKTXeZfxIHpqgeBJ8VZm9Qy6Y
 56f7F6GJnsCzFB/KXHyROlGNUtysTvys+VrPrZpk0NcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3AKcIu5GgHygZ0482E4tK5Dq0MLzJuVn7T3C/TE2C?=
 =?us-ascii?q?BWUVIduGTW0+s9b8+nJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZX/yLQ4JaH7JI81D2CBoHxhoxoxt46SPN00XkKk?=
 =?us-ascii?q?nuuDDEnNZYGiTrAu4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="376976130"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 19D451800025E;
	Fri,  8 Nov 2024 21:49:13 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id 1831ECC12AC; Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:51 +0000
Subject: [PATCH net-next v3 5/7] enic: Adjust used MSI-X wq/rq/cq/interrupt
 resources in a more robust way
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-5-3ba8123bcffc@cisco.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=6178;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=mninbMArocvS6AE+lwVCGhfK4ejOfQE8gCkKXB/dNtQ=;
 b=+yzgWnRSapdfT2l++y6UIMmE3mJebyXBv5qnv4mTkZMCih1qaaQcB7id4AzRO2vAFsQcf8Ffg
 HBolPohbrD8CDnOKcEKNGolYk9TlPr+G9/GwJ5rCCPW3dBfsx4H6tnv
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

Instead of failing to use MSI-X if resources aren't configured exactly
right, use the resources we do have.  Since we could start using large
numbers of rq resources, we do limit the rq count to what
netif_get_num_default_rss_queues() recommends.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 116 ++++++++++++++--------------
 1 file changed, 57 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 564202e81a711a6791bef7e848627f0a439cc6f3..8b07899462d0671843579d16c8c935d9ebbe447b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2442,85 +2442,86 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 static int enic_set_intr_mode(struct enic *enic)
 {
-	unsigned int n = min_t(unsigned int, enic->rq_count, ENIC_RQ_MAX);
-	unsigned int m = min_t(unsigned int, enic->wq_count, ENIC_WQ_MAX);
 	unsigned int i;
+	int num_intr;
 
 	/* Set interrupt mode (INTx, MSI, MSI-X) depending
 	 * on system capabilities.
 	 *
-	 * Try MSI-X first
+	 * We need a minimum of 1 RQ, 1 WQ, and 2 CQs
 	 *
-	 * We need n RQs, m WQs, n+m CQs, and n+m+2 INTRs
-	 * (the second to last INTR is used for WQ/RQ errors)
-	 * (the last INTR is used for notifications)
 	 */
 
-	for (i = 0; i < enic->intr_avail; i++)
-		enic->msix_entry[i].entry = i;
-
-	/* Use multiple RQs if RSS is enabled
-	 */
-
-	if (ENIC_SETTING(enic, RSS) &&
-	    enic->config.intr_mode < 1 &&
-	    enic->rq_count >= n &&
-	    enic->wq_count >= m &&
-	    enic->cq_count >= n + m &&
-	    enic->intr_count >= n + m + 2) {
-
-		if (pci_enable_msix_range(enic->pdev, enic->msix_entry,
-					  n + m + 2, n + m + 2) > 0) {
-
-			enic->rq_count = n;
-			enic->wq_count = m;
-			enic->cq_count = n + m;
-			enic->intr_count = n + m + 2;
-
-			vnic_dev_set_intr_mode(enic->vdev,
-				VNIC_DEV_INTR_MODE_MSIX);
-
-			return 0;
-		}
+	if (enic->rq_avail < 1 || enic->wq_avail < 1 || enic->cq_avail < 2) {
+		dev_err(enic_get_dev(enic),
+			"Not enough resources available rq: %d wq: %d cq: %d\n",
+			enic->rq_avail, enic->wq_avail,
+			enic->cq_avail);
+		return -ENOSPC;
 	}
 
+	/* if RSS isn't set, then we can only use one RQ */
+	if (!ENIC_SETTING(enic, RSS))
+		enic->rq_avail = 1;
+
+	/* Try MSI-X first */
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
+	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
+		unsigned int max_queues;
+		unsigned int rq_default;
+		unsigned int rq_avail;
+		unsigned int wq_avail;
+
+		for (i = 0; i < enic->intr_avail; i++)
+			enic->msix_entry[i].entry = i;
+
+		num_intr = pci_enable_msix_range(enic->pdev, enic->msix_entry,
+						 ENIC_MSIX_MIN_INTR,
+						 enic->intr_avail);
+		if (num_intr > 0) {
+			wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
+			rq_default = netif_get_num_default_rss_queues();
+			rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
+			max_queues = min(enic->cq_avail,
+					 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+
+			if (wq_avail + rq_avail <= max_queues) {
+				enic->rq_count = rq_avail;
+				enic->wq_count = wq_avail;
+			} else {
+				/* recalculate wq/rq count */
+				if (rq_avail < wq_avail) {
+					enic->rq_count = min(rq_avail, max_queues / 2);
+					enic->wq_count = max_queues - enic->rq_count;
+				} else {
+					enic->wq_count = min(wq_avail, max_queues / 2);
+					enic->rq_count = max_queues - enic->wq_count;
+				}
+			}
+			enic->cq_count = enic->rq_count + enic->wq_count;
+			enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
 			vnic_dev_set_intr_mode(enic->vdev,
-				VNIC_DEV_INTR_MODE_MSIX);
-
+					       VNIC_DEV_INTR_MODE_MSIX);
+			enic->intr_avail = num_intr;
 			return 0;
 		}
 	}
 
 	/* Next try MSI
 	 *
-	 * We need 1 RQ, 1 WQ, 2 CQs, and 1 INTR
+	 * We need 1 INTR
 	 */
 
 	if (enic->config.intr_mode < 2 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= 1 &&
-	    enic->cq_count >= 2 &&
-	    enic->intr_count >= 1 &&
+	    enic->intr_avail >= 1 &&
 	    !pci_enable_msi(enic->pdev)) {
 
 		enic->rq_count = 1;
 		enic->wq_count = 1;
 		enic->cq_count = 2;
 		enic->intr_count = 1;
-
+		enic->intr_avail = 1;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_MSI);
 
 		return 0;
@@ -2528,23 +2529,20 @@ static int enic_set_intr_mode(struct enic *enic)
 
 	/* Next try INTx
 	 *
-	 * We need 1 RQ, 1 WQ, 2 CQs, and 3 INTRs
+	 * We need 3 INTRs
 	 * (the first INTR is used for WQ/RQ)
 	 * (the second INTR is used for WQ/RQ errors)
 	 * (the last INTR is used for notifications)
 	 */
 
 	if (enic->config.intr_mode < 3 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= 1 &&
-	    enic->cq_count >= 2 &&
-	    enic->intr_count >= 3) {
+	    enic->intr_avail >= 3) {
 
 		enic->rq_count = 1;
 		enic->wq_count = 1;
 		enic->cq_count = 2;
 		enic->intr_count = 3;
-
+		enic->intr_avail = 3;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_INTX);
 
 		return 0;
@@ -2762,8 +2760,8 @@ static void enic_kdump_kernel_config(struct enic *enic)
 {
 	if (is_kdump_kernel()) {
 		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
-		enic->rq_count = 1;
-		enic->wq_count = 1;
+		enic->rq_avail = 1;
+		enic->wq_avail = 1;
 		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
 		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
 		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);

-- 
2.35.6


