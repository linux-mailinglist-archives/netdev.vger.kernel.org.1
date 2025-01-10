Return-Path: <netdev+bounces-157311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4EA09EB5
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B563C167D2B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C6222574;
	Fri, 10 Jan 2025 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JnvKXU7Y"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A20222572
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551981; cv=none; b=OLh1kKQHiAdXL8NqFFe2lq+CGUo07uomYEnriSTR72SBWsAvN4skW2OKg/HpBEQm1T0QigexFwJOOtjv8yrWToBYmd+ieynR8vpgaRKz4th+ma872fD9awUvgGWpAFOVp+9dC7ZriMH8h9Py9vEJcid6SrSms+qt9XcoilB81dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551981; c=relaxed/simple;
	bh=arGXb5Rus1cUc0CwA06aBsGq1d5jQ96aor8Qrc5jpOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8hi11RrQb+eU1DsWCbzhtDRvNub/xyWzXYIjnG7J5LNi5lW1VdQVYPDtVhkN84fzz+IjmF+DxROZ3gsg2Y6+itHcdQ73xDjasxWhxjiviPUOODT9AFOEECj141EItCirlYDWr6SFOFvXw+q/NhEmZy68wbEeYeL/kLdyUmZiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=JnvKXU7Y; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4447; q=dns/txt; s=iport;
  t=1736551979; x=1737761579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XtwlElowJ1XLKo9eSWoN9x2HL1wNbegz7k2yKy69syY=;
  b=JnvKXU7YhtjPj8AbMBNK6IXyVUCXbcX6facxPNdsSrF/yrwtFhxJgXUj
   EuhnLI005EEHqvH+VRd9XxxLGBcRaPwlwwbv5CLScL7/PWqW40FaVJ0KU
   PiCDH/QiY1eoAE1FsmGrT5H2niOF+kGS4bJQxIk+e4d3trB80W0giU8bw
   o=;
X-CSE-ConnectionGUID: uPS7pxIERp60vlphbLfa3w==
X-CSE-MsgGUID: 0kKjGZBGQUG2OZID7SbKMw==
X-IPAS-Result: =?us-ascii?q?A0ANAAD8rIFn/47/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBgkqBT0NIjHJfiHKeGxSBEQNWDwEBAQ9EBAEBhQcCinQCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBA?=
 =?us-ascii?q?ycLAUYQUSsrBxKDAYJlA7RNgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEglCBP?=
 =?us-ascii?q?m+EKoZdBIIyhTWeUkiBIQNZLAFVEw0KCwcFgTg6AyILCwwLFBwVAhUfEQYQB?=
 =?us-ascii?q?G1EN4JGaUs6Ag0CNYIeJFiCK4RchEeEVIJLVYJHghR6gRmEAUADCxgNSBEsN?=
 =?us-ascii?q?wYOGwY+bgebJzyDbgGBDxOCADEkApMVG5IVgTSKPpURhCWBY59jGjOqU5gDe?=
 =?us-ascii?q?SKjVVCEZoFnPIFZMxoIGxWDIlIZD4hchVEWFrxGJTI8AgcLAQEDCZA+YAEB?=
IronPort-Data: A9a23:beXn7ahgonrJey2kuiUfD/lhX161QhEKZh0ujC45NGQN5FlHY01je
 htvX2GHaK3ZZGXzLo9wa9/l8R9TvcXXyIIwGQpvrihmESJjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSFULOZ82QsaD9Msvvb8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUFwt0oGXFv2
 MYAdmgTagiDjca4yemkH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg1/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9IYTWFZ0Jxh3Hz
 o7A1zz6IRM1Bvaw8AeqqFWep8OQpinYfZ1HQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMD7sXvrZ8bkB3CVJBgHbSzg9mzHiv/q
 w1mtwAkjLkVyMpO3KKh8BWf3nSnp4PCSUg+4QC/sn+Z0z6VrbWNP+SAgWU3J94aRGpFZjFtZ
 EQ5pvU=
IronPort-HdrOrdr: A9a23:JvqOMqEiJbfyQmtFpLqE78eALOsnbusQ8zAXPo5KJiC9Ffbo8P
 xG88576faZslsssTQb6LK90cq7MBfhHOBOgbX5VI3KNGKNhILrFvAG0WKI+VPd8kPFmtK1rZ
 0QEJSXzLbLfCFHZQGQ2njfL+od
X-Talos-CUID: =?us-ascii?q?9a23=3AcOsdd2ihidGs3xLjR8AbsW2AszJub0Xmk2/AAmK?=
 =?us-ascii?q?CETgxVrmNSVW09qo/jJ87?=
X-Talos-MUID: 9a23:j2dk0AuwCl9vGC8XLs2n3DJBNuhayYuXNW9Xtqcnl5a/Pw9VJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="304804037"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 23:32:53 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTP id 1B1231800023B;
	Fri, 10 Jan 2025 23:32:53 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id E9F2B20F2006; Fri, 10 Jan 2025 15:32:52 -0800 (PST)
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
Subject: [PATCH net-next v5 3/4] enic: Use function pointers for buf alloc, free and RQ service
Date: Fri, 10 Jan 2025 15:32:48 -0800
Message-Id: <20250110233249.23258-4-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250110233249.23258-1-johndale@cisco.com>
References: <20250110233249.23258-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

In order to support more than one packet receive processing scheme, use
pointers for allocate, free and RQ descrptor processing functions.

No functional change.

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
index fd3d34c1d4d4..d3319f62ad1b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1550,7 +1550,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[0].vrq, enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[0].vrq, enic->rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling
 	 * mode so we can try to fill the ring again.
@@ -1678,7 +1678,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[rq].vrq, enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[rq].vrq, enic->rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling mode
 	 * so we can try to fill the ring again.
@@ -1883,6 +1883,10 @@ static int enic_open(struct net_device *netdev)
 	unsigned int i;
 	int err, ret;
 
+	enic->rq_buf_service = enic_rq_indicate_buf;
+	enic->rq_alloc_buf = enic_rq_alloc_buf;
+	enic->rq_free_buf = enic_free_rq_buf;
+
 	err = enic_request_intr(enic);
 	if (err) {
 		netdev_err(netdev, "Unable to request irq.\n");
@@ -1901,7 +1905,7 @@ static int enic_open(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++) {
 		/* enable rq before updating rq desc */
 		vnic_rq_enable(&enic->rq[i].vrq);
-		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
+		vnic_rq_fill(&enic->rq[i].vrq, enic->rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
 		if (vnic_rq_desc_used(&enic->rq[i].vrq) == 0) {
 			netdev_err(netdev, "Unable to alloc receive buffers\n");
@@ -1940,7 +1944,7 @@ static int enic_open(struct net_device *netdev)
 	for (i = 0; i < enic->rq_count; i++) {
 		ret = vnic_rq_disable(&enic->rq[i].vrq);
 		if (!ret)
-			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
+			vnic_rq_clean(&enic->rq[i].vrq, enic->rq_free_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -1999,7 +2003,7 @@ static int enic_stop(struct net_device *netdev)
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
2.44.0


