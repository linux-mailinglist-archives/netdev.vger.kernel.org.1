Return-Path: <netdev+bounces-144620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E939C7F0E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BB62846BD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605818F2F2;
	Wed, 13 Nov 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="lUCb2rG2"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792118DF91;
	Wed, 13 Nov 2024 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542285; cv=none; b=MV11Ask9pyJwnS/YtFxBZXVXT5FOoMcuheK895d+7dL8v81Ri1J2XVJqogWEdXN72Gn1IHxxKtdG0VSCLU/avQXQEdPAFOhiWjCKUpxzowx0nXVHDa+7/4sZZsfiKODH3aNeNcT8uFM5caImTPid5DjEmfVXVNxrNOzB4aS0lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542285; c=relaxed/simple;
	bh=BaAMDPDZS2YT6jrU8+AmVF8L/RZgKYuGDX5Aoh7FqDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glGK535gxQ3z5ODWkXG0kvoT/K2ytGy9+hJPWFfpR/9ct0lorntLeNqSoYh9Boo4TfQSMVtAkMfUTCntlLBxWsCEQF6bBuqO9NtLEujYR8/eQiWRuVCH8ls+kFpxR3kScC+D3oCDh1+aDmefKQ0LnAVgQ2IU5yNX7m1cpQoYiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=lUCb2rG2; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5894; q=dns/txt; s=iport;
  t=1731542283; x=1732751883;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7faiQRGgmp7GL149R+szlt5/BOnQOPfLqxK1XaSDFqE=;
  b=lUCb2rG2qtfwSQYnyOdQdsSJdANMCWp4fIP/yxyCjAvRv70b7BcCmM9i
   zm4sQoio4SrcQ9iT5a3liMFYQM5UMMuuhL1t/IZg1oi5R1Utlp2lWeQrO
   jf+eO7xNuCdrfmVgtawrEvy/cFxBjZhE6Q8taDml/mj43U9q3RIjMVNhp
   g=;
X-CSE-ConnectionGUID: FafY/dQyQBCNKHq8cJzebQ==
X-CSE-MsgGUID: Opc5s8N3R0+vSp7+1roukQ==
X-IPAS-Result: =?us-ascii?q?A0AGAADHOzVnj44QJK1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYQaQkiEVYgdhzCOFpIjgSUDVg8BAQEPRAQBAYUHAopFA?=
 =?us-ascii?q?iY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5B?=
 =?us-ascii?q?Q47hgiGWwIBAyMEUhAlAiYCAisbEAYBEoMBgmUCAbBmen8zgQHeM4FtgRouA?=
 =?us-ascii?q?YhLAYFsg307hDwnG4FJRIEUAYNohBuEA4JpBIQtA4I4diWFHoN5W49RiH0JP?=
 =?us-ascii?q?4EFHANZIREBVRMNCgsHBWNXPAMib2pceiuBDoEXOkOBO4EiLxshC1yBN4EaF?=
 =?us-ascii?q?AYVBIEORj+CSmlLOgINAjaCJCRZgk+FGoRthGaCVC8dQAMLGA1IESw1Bg4bB?=
 =?us-ascii?q?j0BbgeeZUaDMoEOgScHgRJjkm2Da40+oWuEJKFcM6pNmHcipByEZoFnOoFbM?=
 =?us-ascii?q?xoIGxWDIlIZD44tDQkWkwABtj9DNTsCBwsBAQMJjk2BfAEB?=
IronPort-Data: A9a23:986sfazTWRfacTBMbdl6t+eixirEfRIJ4+MujC+fZmUNrF6WrkUHn
 GNKW2yHO/uKM2ajeo92b4zl8xwP7cPVxtZkQVE+r1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 ImaT/H3Ygf/h2ctazlMsMpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJG8/M7xf9t9mOEtl0
 984MWAGTAKOjdvjldpXSsE07igiBMDvOIVavjRryivUSK57B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUiaC/FMEg9/5JYWmuqlnXL4eTRwo1OOrq1x6G/WpOB0+OOyYIOJIIPSHq25mG6/v
 mmb5DTfWStCd8Kk0WXGq2irm+z2yHaTtIU6T+DgqaUw3zV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4E+og7RqlyafO5QudQG8eQVZpa8Esvec1SCYs2
 1vPmMnmbRRmtrGPRG3e8LqIoT6sESwIK2lEbi9sZRMM6dTloakpgx7PR8olG6mw5vXxGDft0
 3WJoTI4irE7k8EGzeO48ErBjjbqoYLGJiYz6xnbU3yN8Ax0fsimapau5Fyd6uxPRLt1VXGIu
 HwC3szb5+cUANTVyWqGQf4GG/ei4PPt3CDgbUBHMZAvxnOhwm+aV6t2wxFndExLIMsOQGq8C
 KPMgj956JhWNXqsSKZ4ZYOtFsgnpZQM8/y7Cpg4ifIQP/BMmB+7wc14WaKHM4nQfKkQfUMXZ
 cfznSWEVCpy5UFbINyeHLx1PVgDnXxW+I8rbcqnpylLKJLHDJJvdZ8LMUGVcscy576erQPe/
 r53bpTRkkgFCrOuMnSOq+b/yGzmy1BmW/gaTOQKJ4a+zvZOQTBJ5wL5mOl4Itc0xcy5aM+Tr
 ijmBCe0N2YTdVWcdF3VMSo8AF8edZ1+tnk8dTc9Jkql3mNrYICkqs8im2gfI9EaGBhY5acsF
 ZEtIpzYatwWE2iv02pGN/HV8tc9HClHcCrSZEJJlhBjJMY4H2QkO7bMImPSycX5JnHn6ZVl+
 +b/iVKzrFhqb10KMfs6ocmHlzuZ1UXxUsorN6cUCrG/oHnRzbU=
IronPort-HdrOrdr: A9a23:/HD1GawDuJ0DiUOGHjbCKrPwT71zdoMgy1knxilNoH1uEvBw8v
 rEoB1173LJYVoqMk3I+urgBED/exzhHPdOiOEs1NyZMDUO1lHHEL1f
X-Talos-CUID: =?us-ascii?q?9a23=3AXjTGBmgXsAT73AVH4XBCATuE0TJuXHTT/TDcGl6?=
 =?us-ascii?q?BI01Pa52MGVSy6q5uqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9lcODQyaVVWWihoY0giD/r8XhbWaqIO2Ax0WwbN?=
 =?us-ascii?q?dgZHHKxdoZHTEljOqQbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="378142703"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:54 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-05.cisco.com (Postfix) with ESMTPS id E234718000154;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id DB17CCC12AC; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:37 +0000
Subject: [PATCH net-next v4 5/7] enic: Adjust used MSI-X wq/rq/cq/interrupt
 resources in a more robust way
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-5-a34cf8570c67@cisco.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=6224;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=BaAMDPDZS2YT6jrU8+AmVF8L/RZgKYuGDX5Aoh7FqDg=;
 b=HgsBZACqfp16Yl9sxU5GphVHAlD2V68FhjLESi8FK1rVsCFClszHWGGi6FJdGABvoMNiSIe1n
 FqrDRJFP4lCDJ8zcGYVYtlRzi3D2zXfgdNKxKyysF5Al6MGR5TvjJqR
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com

Instead of failing to use MSI-X if resources aren't configured exactly
right, use the resources we do have.  Since we could start using large
numbers of rq resources, we do limit the rq count to what
netif_get_num_default_rss_queues() recommends.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


