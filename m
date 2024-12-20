Return-Path: <netdev+bounces-153818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF89F9C75
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AD3166265
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA2226194;
	Fri, 20 Dec 2024 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PdxoIcdA"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E1225764
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731552; cv=none; b=sIQ+imFFcMv6FPQUC6R9dmLIV3ZXRHKm9+THHLJ4JS3DuPVfQt0o3or1UUbLABZicYYxViQbiAJ7Bb2wwTIcdtCmAN81ddNATma2rxET57s9OO6ip9v8NKrjzj/0jKvJdqSJppw+VYx+rhmGzcpLW7E6BIpQVhRKJt07j7NM0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731552; c=relaxed/simple;
	bh=NuqZEEZYpyP7CXsdCdrvAvNGYHjuVQ4ARqCZDeRC1V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HO0ZXtcUxB2CfvSn6dwlTeugmV9dxRT/6YVasvSMJCaXg0aiZpJ9dIKaXDBcX9hY2hhK2Zg3gY/l9/lVMOgfA6fWmK1XkzuiyXZ5RT+gt9K6GE/J0UPIC9u8NrnHZSomQOzZ4f8dWAoYUAY6pImncl+0gH58a/AxvXcuLGCH50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PdxoIcdA; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4422; q=dns/txt; s=iport;
  t=1734731550; x=1735941150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwJxi8Cye5/I6LCh20clnomwhtRsYxMDQYpTcQE5Aq4=;
  b=PdxoIcdAFw6gB7knUqb8FhgMsJEABIp+ZcWToRL7NrWn+7jG+m3+j2fe
   u4ia99ZIvSlJl9hP4NP5QP+428k8R7POYnRGDZAPS0DlBVtuTTeWlyqZz
   Poub147aDT/HQTb6hMbZyjHjAWcrDDr2cqUVnw84g/kdpYqqaBcYGFPi4
   0=;
X-CSE-ConnectionGUID: sMZ50ebISMiPtqVybqxfRQ==
X-CSE-MsgGUID: CplXi8EpRgCUrc2gMO0HnA==
X-IPAS-Result: =?us-ascii?q?A0ANAAB75mVnj5P/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX4hynhsUgREDVg8BAQEPRAQBAYUHAopsAiY0CQ4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BUmGCIZbAgEDJ?=
 =?us-ascii?q?wsBRhBRKysHEoMBgmUDsCyBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSCUIE+b?=
 =?us-ascii?q?4Qqhl0EiReeTkiBIQNZLAFVEw0KCwcFgTk6AyIMCwwLFBwVAoEegQIUBhUEg?=
 =?us-ascii?q?QtFPYJKaUk3Ag0CNoIgJFiCTYUYhGGEV4JJVYJ8ghd8gR2BcUADCxgNSBEsN?=
 =?us-ascii?q?wYOGwY+bgecUEaDcIEPE4IAMSQCkxUbkhOBNJ9PhCSBY59jGjOqUpgCeSKjU?=
 =?us-ascii?q?1CEZoFnOoFbMxoIGxWDIlIZD4hchVENCRa6YyUyPAIHCwEBAwmQS2ABAQ?=
IronPort-Data: A9a23:pEqCnKoYR8ogm/Z6IbUTxGrDmiVeBmL8ZRIvgKrLsJaIsI4StFCzt
 garIBnXOP3bYmf9fIpxaY/n8UsO6sTdmoNlQQU/qX9hFitEoOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOt/vZ8ks35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0v1SMzwW+
 PY5ExUMVgyaufO82aK1cNA506zPLOGzVG8ekmtrwTecCbMtRorOBvySo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LV/rSn8/w7pX7Wz9fqFSZrK46y2PS1wd2lrPqNbI5f/TWHZ4OxRjA/
 TmuE2LRKQkeBN3P5CK//VmRnOSVkgbcAKIUPejtnhJtqAbOnjNIUkJ+uUGAifWwlEO7c95WN
 UER/i0gse40+VDDZtTxQhixsnOYlhEbXNVUHqsx7wTl4qnJ6Q+xBWUeSDNFLts8u6ceTDomz
 FKW3NXkGTBirpWRVHSbsLyUxRuqMCIYK24qfyIITQIZpdLkpekbiB/TQtt9OLC6g8ezGjzqx
 T2O6i8kiN0uYdUjza63+xXDxjmrvJWMF1Zz7QTMVWXj5QR8DGK4W2C2wUP+36sYIYy4dXyAh
 GQdpdmU9fAAN6jYwURhX94xNL2u4v+ENhjVjlhuA4Qt+lyRF5iLI9o4DNZWeh4BDyoURQIFd
 nM/ru+42XOyAJdIRfIuC25SI512pUQFKTgDfquJBjapSsMtHDJrBAk0OSatM5nFySDAa50XN
 5aBatqLBn0HE6lhxzfeb75CiuN1nXtkmD2JGciTI/GbPVy2OSH9pVAtbQvmUwzFxPneyOko2
 48Fb5DQk003vBPWP3eKrd57wa82wYgTXs2u9JcNKYZv0yJtGXoqDLfK0Kg9dol+16VTnaGgw
 51OchEw9bYLvlWecV/iQik6MNvHBM8vxVplZnZEFQjzhBAejXOHsPx3m20fIeJ/rLQLID8dZ
 6VtRvhs9dwVE2mXomhMNMOhxGGgHTzy7T+z0+OeSGBXV/Zdq8bho7cIoiOHGPEyMxeK
IronPort-HdrOrdr: A9a23:CnGQkahz/F1prdZakaNBwEuRpHBQXt0ji2hC6mlwRA09TyVXra
 +TdZMgpHjJYVkqOU3I9ersBEDEewK/yXcX2/h0AV7dZmnbUQKTRekIh7cKgQeQfhEWndQy6U
 4PScRD4aXLfDtHZQKQ2njALz7mq+P3lpyVuQ==
X-Talos-CUID: 9a23:bnH1I2x1/txVq/jGXbp2BgUPP/J4KnDX7Uz1InekEFh4QqSFR2WprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Ak7JuHA0Rcs7VMtzQQCmQqYUbeDUjyLyqOEFdvI0?=
 =?us-ascii?q?8tOK5LycqNBK61BSxa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,251,1728950400"; 
   d="scan'208";a="403336033"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Dec 2024 21:51:23 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTP id 652F818000263;
	Fri, 20 Dec 2024 21:51:23 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 40F1D20F2003; Fri, 20 Dec 2024 13:51:23 -0800 (PST)
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
Subject: [PATCH net-next 3/5] enic: Use function pointers for buf alloc, free and RQ service
Date: Fri, 20 Dec 2024 13:50:56 -0800
Message-Id: <20241220215058.11118-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241220215058.11118-1-johndale@cisco.com>
References: <20241220215058.11118-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com

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


