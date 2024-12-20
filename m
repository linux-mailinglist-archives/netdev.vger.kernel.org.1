Return-Path: <netdev+bounces-153819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752889F9C77
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDEE166463
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9FC227566;
	Fri, 20 Dec 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dJ3+mlsk"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349C225A57
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731553; cv=none; b=VH+I3YjZ73F5Sm28NtZN/ySudobGeG8b0fBMNkrOJ6fL1hpeQldzNMeb8UHrhK6ZCqemI23Zo+teUxenTpJXYj9DzIAgd4pkMh05b5zGX6ujwNha8OxTtUGAuAypeKAk6EycTJ5EVRap5u4AgJ2G+GQC8oO6x8RypW6GazvHSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731553; c=relaxed/simple;
	bh=T4hWg15WZP+lApfrr9Y/thSG09sNb0ZXX0qr/vwtnN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5M0K6qrxQ63JU2uZsxeptr4VqSxlVG29skVlfDB+vgVa9HQsrcCvDGEJY7MZZRU9gqycUGDpAtVfb6+FzRph5sO6XuaPhQoLoMbzrUZyult7aTD5bsQiGU/UULLbgdD7zDiSsn3AbypDshf//wOWGy5jycOhrAYFBxKQVsKmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=dJ3+mlsk; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2510; q=dns/txt; s=iport;
  t=1734731552; x=1735941152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJaW4D8IoGJsrpAQ4RXWrveI+HMg7JYPf5VPwYrwcqs=;
  b=dJ3+mlskY4ZoIl9KfTpR+wY/Waxp+b+Xdi29pmklqtLUqyEnKogqNaaP
   8BrSKj/3ol77Yge5jx89LppWGievjoo1qbOfI6woyf42sG1bVdd0k+7Dz
   vSe2xuQkkyJHiJDUQzozSA9SiznihHZOe0Sy7vDs0J7SBOAojSwbc18bT
   g=;
X-CSE-ConnectionGUID: ONP+TL/yQbCyLFIE7XKL5Q==
X-CSE-MsgGUID: vjxts3EYQYuRco5yk52soA==
X-IPAS-Result: =?us-ascii?q?A0ATAADu5WVnj5D/Ja1aHQEBAQEJARIBBQUBgX8IAQsBh?=
 =?us-ascii?q?BlDSIxyX6EwhV2BJQNWDwEBAQ9EBAEBhQcCimwCJjQJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhlsCAQMnCwFGEFErK?=
 =?us-ascii?q?wcSgwGCZQOwKYF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT5vhRCFdwSJF?=
 =?us-ascii?q?55OSIEhA1ksAVUTDQoLBwWBOToDIgwLDAsUHBUCgR6BAQEUBhUEgQtFPYJKa?=
 =?us-ascii?q?Uk3Ag0CNoIgJFiCTYUYhGGEV4JJVYJ8ghd8gR2BcUADCxgNSBEsNwYOGwY+b?=
 =?us-ascii?q?gecUEaDcIEPgiimBaEDhCSBY59jGjOqUi6HZJBpIqQjhGaBZzqBWzMaCBsVg?=
 =?us-ascii?q?yJSGQ+OLQ0JFrpkJTI8AgcLAQEDCZErAQE?=
IronPort-Data: A9a23:1K+VVKJAUHDNDHRYFE+RNZUlxSXFcZb7ZxGr2PjKsXjdYENS1zxSx
 zYfD22EaPuOZjOhfIp/PN+x/E0D75OByoRlTQsd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgP8gWQsajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1JKnl1Aalf6999KnBq2
 901dwAuSk260rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBUrAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEiojx5nYj/7DLo8m+euinD7fhVTqUmeouw85G27IAlZjOC9YYKOJIXWLSlTtliat
 n7dpEnIOyAHDteYlCuGryi3gcaayEsXX6pJSeXnraQ16LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAiYxTmtvZPOCAUy4207Q15J8CteQrbmW6jv+GHRxudkAqe0EWmim
 CU9zp32AP81MbmBkymEQeMoFb6v5uqYPDC0vbKJN8d7n9hK0yD6Fb288A1DyFFV3tHokAIFg
 XM/WysMvve/31PzMcebhr5d7exxkMAM8vy+CpjpgiJmOMQZSeN+1HgGibSs927silMwtqo0J
 I2Wd82hZV5DVv87kmHtHbpDi+Nzrszb+Y81bc2kp/hA+efODEN5tZ9fajNik8hgtvvf+l2Nm
 zqhH5bUlkkPOAEBXsUn2dVOdQ9RdydT6WHeoM1MfenLORt9BGwkELfQx7hnE7GJbIwL/tokC
 kqVAxcCoHKm3CWvAVzTOhhLNui1Nb4h9i1TAMDZFQrzs5TVSdr0tP9HH3b2FJF7nNFeIQlcF
 aBYK5zcU60VFlwqOV01NPHAkWCrTzzz7SrmAsZvSGFXk0JIL+ARxuLZQw==
IronPort-HdrOrdr: A9a23:mFMF3aq4OECulybCYz1Mox8aV5oseYIsimQD101hICG9vPb2qy
 nIpoV96faaslcssR0b9OxofZPwI080lqQFhbX5Q43DYOCOggLBR+tfBMnZsljd8kbFmNK1u5
 0NT0EHMqySMbC/5vyKmTVR1L0bsb+6zJw=
X-Talos-CUID: 9a23:jqHNRGPfjjwUrO5Dfw9ft3IwXdEceFbM6FnxDhCIKkI0cejA
X-Talos-MUID: 9a23:wVfC4wYyOU/JuOBTqT38mCo5GfZR0rmUA0dQgJZb4dKDHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,251,1728950400"; 
   d="scan'208";a="408903614"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Dec 2024 21:51:22 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTP id 42CB81800022D;
	Fri, 20 Dec 2024 21:51:22 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 1F4A120F2003; Fri, 20 Dec 2024 13:51:22 -0800 (PST)
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
Subject: [PATCH net-next 2/5] enic: Remove an unnecessary parameter from function enic_queue_rq_desc
Date: Fri, 20 Dec 2024 13:50:55 -0800
Message-Id: <20241220215058.11118-3-johndale@cisco.com>
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
X-Outbound-Node: rcdn-l-core-07.cisco.com

The function enic_queue_rq_desc has a parameter os_buf_index which was
only called with a hard coded 0. Remove it.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |  8 ++------
 drivers/net/ethernet/cisco/enic/enic_res.h  | 10 +++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 33890e26b8e5..f8d0011486d7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1301,14 +1301,11 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	unsigned int len = netdev->mtu + VLAN_ETH_HLEN;
-	unsigned int os_buf_index = 0;
 	dma_addr_t dma_addr;
 	struct vnic_rq_buf *buf = rq->to_use;
 
 	if (buf->os_buf) {
-		enic_queue_rq_desc(rq, buf->os_buf, os_buf_index, buf->dma_addr,
-				   buf->len);
-
+		enic_queue_rq_desc(rq, buf->os_buf, buf->dma_addr, buf->len);
 		return 0;
 	}
 	skb = netdev_alloc_skb_ip_align(netdev, len);
@@ -1324,8 +1321,7 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 		return -ENOMEM;
 	}
 
-	enic_queue_rq_desc(rq, skb, os_buf_index,
-		dma_addr, len);
+	enic_queue_rq_desc(rq, skb, dma_addr, len);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.h b/drivers/net/ethernet/cisco/enic/enic_res.h
index b8ee42d297aa..dad5c45b684a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.h
+++ b/drivers/net/ethernet/cisco/enic/enic_res.h
@@ -107,19 +107,15 @@ static inline void enic_queue_wq_desc_tso(struct vnic_wq *wq,
 }
 
 static inline void enic_queue_rq_desc(struct vnic_rq *rq,
-	void *os_buf, unsigned int os_buf_index,
-	dma_addr_t dma_addr, unsigned int len)
+	void *os_buf, dma_addr_t dma_addr, unsigned int len)
 {
 	struct rq_enet_desc *desc = vnic_rq_next_desc(rq);
-	u64 wrid = 0;
-	u8 type = os_buf_index ?
-		RQ_ENET_TYPE_NOT_SOP : RQ_ENET_TYPE_ONLY_SOP;
 
 	rq_enet_desc_enc(desc,
 		(u64)dma_addr | VNIC_PADDR_TARGET,
-		type, (u16)len);
+		RQ_ENET_TYPE_ONLY_SOP, (u16)len);
 
-	vnic_rq_post(rq, os_buf, os_buf_index, dma_addr, len, wrid);
+	vnic_rq_post(rq, os_buf, 0, dma_addr, len, 0);
 }
 
 struct enic;
-- 
2.35.2


