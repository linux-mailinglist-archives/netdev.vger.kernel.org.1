Return-Path: <netdev+bounces-154319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F49FCFCB
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7347A0651
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C835976;
	Fri, 27 Dec 2024 03:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="chCCE+NV"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B314F50F
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735269345; cv=none; b=nDgtQnTtMDpR3w6fa3kyLImLB5zncx2zJpqOzgFotKa29++kQ0lSuMNfTQnaPzxF4hcIDoHhDgH1YmVeypYLQWvgRIDKKdUpjOzByEnh5BLTOfKWeNYSSd32QPGSjwPI8th7BaRaugAXzAovsMB0YjVkNAgpIvbjM6ksx6wkhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735269345; c=relaxed/simple;
	bh=NuqZEEZYpyP7CXsdCdrvAvNGYHjuVQ4ARqCZDeRC1V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drXSQiXdi8dp3nFuGRy4zclGybU6SMygRwuP4k13c98E89dw03fKaY4DyTw3i9qhZx0BM3U2OA5vjuJNAQmUdQVSNqk62MEVZ9z9sLFnlO0cEF6NImqoXcqocQBIkVApp2nfJzpAJupGivsblh2VnoRBTivMo5VkOL6gX4pJQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=chCCE+NV; arc=none smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4422; q=dns/txt; s=iport;
  t=1735269344; x=1736478944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwJxi8Cye5/I6LCh20clnomwhtRsYxMDQYpTcQE5Aq4=;
  b=chCCE+NVGNcQTIUc00fpEU4fsiuwycnMizvLC0bc3gGzi8RBs5FbkULR
   Z48SXZR55uy91XvtSjYJlGy/BhTfyS5Y/X0q/MaoxTwsBWKthHsayPX3S
   YS30KAPHhvcofG0tfJKKh7H2JlDzXTFxjdonf04wOFBmm5BWiMLpeW5L+
   0=;
X-CSE-ConnectionGUID: a5kLBD6QQ02MLoEV+osroA==
X-CSE-MsgGUID: lnWDdiGhQLiRmaB50jiYYQ==
X-IPAS-Result: =?us-ascii?q?A0AnAADbGm5n/5T/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfiHKeGxSBEQNWDwEBAQ9EBAEBhQcCim4CJjQJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQU?=
 =?us-ascii?q?SsrBxKDAYJlA68VgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEglCBPm+EKoZdB?=
 =?us-ascii?q?IkVnnVIgSEDWSwBVRMNCgsHBYE5OgMiDAsMCxQcFQKBHoECFAYVBIELRT2CS?=
 =?us-ascii?q?mlJNwINAjaCICRYgk2FF4RhhFeCSVWCe4IXfIEdgiVAAwsYDUgRLDcGDhsGP?=
 =?us-ascii?q?m4HnGRGg3SBDxOCADEkApMVG5IVgTSfT4QkgWOfYxozqlKYA3kio1RQhGaBZ?=
 =?us-ascii?q?zyBWTMaCBsVgyJSGQ+IXIVRFha1fCUyPAIHCwEBAwmQV2ABAQ?=
IronPort-Data: A9a23:vh+BUKhNfATvnz2ZK1IwOU3rX161QhEKZh0ujC45NGQN5FlHY01je
 htvWziBMqzcYDT9Kt0nbdi2pEoAuJCGnNNgGwQ/qS1kQixjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD5Nsfjc8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqURp+VTK00Qz
 MVAchUpaT29xOWt2rWSH7wEasQLdKEHPasFsX1miDWcBvE8TNWaGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgd/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9II3TFZUKxBvCz
 o7A12D/PT0WNfOf8B6EyHelrLKXnyLKabtHQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMD7sXvrZ8bkB3CVJBgHbSzg9mzHiv/q
 w1mtwAkjLkVyMpO3KKh8BWe2nSnp4PCSUg+4QC/sn+Z0z6VrbWNP+SAgWU3J94ZRGpFZjFtZ
 EQ5pvU=
IronPort-HdrOrdr: A9a23:wPf7LalGmVZaG4QiY1uZEaJfi73pDfIr3DAbv31ZSRFFG/FwWf
 rAoB19726StN9/YhAdcLy7VZVoBEmsl6KdgrNhWYtKIjOHhILAFugLhuHfKn/bakjDH4Vmu5
 uIHZITNDSJNykYsS4/izPIaurJB7K8gcaVuds=
X-Talos-CUID: =?us-ascii?q?9a23=3A6EDI4WuLvfwV3lV+R1jzdKbK6IssL3755luOGnb?=
 =?us-ascii?q?gU0NNT5CrCliL4qRNxp8=3D?=
X-Talos-MUID: 9a23:lC3gXgr5Ujzt+XYTjKMezzVkC+tk4ouuMWQMq5APkZTcNy1BCg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,268,1728950400"; 
   d="scan'208";a="291887252"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Dec 2024 03:14:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTP id DD65B18000256;
	Fri, 27 Dec 2024 03:14:33 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id B9EC520F2006; Thu, 26 Dec 2024 19:14:33 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 3/5] enic: Use function pointers for buf alloc, free and RQ service
Date: Thu, 26 Dec 2024 19:14:08 -0800
Message-Id: <20241227031410.25607-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241227031410.25607-1-johndale@cisco.com>
References: <20241227031410.25607-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-11.cisco.com

In order to support more than one packet receive processing scheme, use
pointers for allocate, free and RQ descrptor processing functions.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  5 +++++
 drivers/net/ethernet/cisco/enic/enic_main.c | 14 +++++++++-----
 drivers/net/ethernet/cisco/enic/enic_rq.c   |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 10b7e02ba4d0..51f80378d928 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -226,6 +226,11 @@ struct enic {
 	u32 rx_copybreak;
 	u8 rss_key[ENIC_RSS_LEN];
 	struct vnic_gen_stats gen_stats;
+	void (*rq_buf_service)(struct vnic_rq *rq, struct cq_desc *cq_desc,
+			       struct vnic_rq_buf *buf, int skipped,
+			       void *opaque);
+	int (*rq_alloc_buf)(struct vnic_rq *rq);
+	void (*rq_free_buf)(struct vnic_rq *rq, struct vnic_rq_buf *buf);
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index f8d0011486d7..45ab6b670563 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1519,7 +1519,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[0].vrq, enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[0].vrq, enic->rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling
 	 * mode so we can try to fill the ring again.
@@ -1647,7 +1647,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[rq].vrq, enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[rq].vrq, enic->rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling mode
 	 * so we can try to fill the ring again.
@@ -1882,6 +1882,10 @@ static int enic_open(struct net_device *netdev)
 	unsigned int i;
 	int err, ret;
 
+	enic->rq_buf_service = enic_rq_indicate_buf;
+	enic->rq_alloc_buf = enic_rq_alloc_buf;
+	enic->rq_free_buf = enic_free_rq_buf;
+
 	err = enic_request_intr(enic);
 	if (err) {
 		netdev_err(netdev, "Unable to request irq.\n");
@@ -1900,7 +1904,7 @@ static int enic_open(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++) {
 		/* enable rq before updating rq desc */
 		vnic_rq_enable(&enic->rq[i].vrq);
-		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
+		vnic_rq_fill(&enic->rq[i].vrq, enic->rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
 		if (vnic_rq_desc_used(&enic->rq[i].vrq) == 0) {
 			netdev_err(netdev, "Unable to alloc receive buffers\n");
@@ -1939,7 +1943,7 @@ static int enic_open(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);
 		if (!ret)
-			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+			vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -1998,7 +2002,7 @@ static int enic_stop(struct net_device *netdev)
 	for (i = 0; i < enic->wq_count; i++)
 		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
 	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+		vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index 571af8f31470..ae2ab5af87e9 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -114,7 +114,7 @@ int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 	struct enic *enic = vnic_dev_priv(vdev);
 
 	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc, completed_index,
-			VNIC_RQ_RETURN_DESC, enic_rq_indicate_buf, opaque);
+			VNIC_RQ_RETURN_DESC, enic->rq_buf_service, opaque);
 
 	return 0;
 }
-- 
2.35.2


