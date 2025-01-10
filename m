Return-Path: <netdev+bounces-157313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC31A09EB9
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADB0163409
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDF221D82;
	Fri, 10 Jan 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="brh7oudw"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25B24B23F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552064; cv=none; b=kT5DcVtj8V/S5Y9ejrYUcQu+TSCOZDDlW+fZAFDeDxytVYgvXvInskUqrQOwQhoLgZqsIDEY1ex6ot0UkV4eVHRjQfZm3ADVgA64UsBdh0te+GcbktmiJGm1QLmMBFjwsl+swbItLynqord1PxxnjOWeeGWtOSN4HVgvJ1x1qtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552064; c=relaxed/simple;
	bh=uH5xy4ZRJvldT/+YPhPTlJm4jZDopPH+Xm7opbQ7/as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLao45/VSU4QRWLHjdUFVdPbc66xQtn84IG4gI/Owj9G/dO4Sr8H2xpWRfd8urAeutvzNwyU0kbjhNLCwy6cc5OL1oO9GG+IlUjthiPE9yYD/hgYYSmgwHO2nB6qNCHOmlmNyOMU4iVj3r3o1v+OxpqTXZhaP4eM8+huyVKdqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=brh7oudw; arc=none smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2535; q=dns/txt; s=iport;
  t=1736552062; x=1737761662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSpELNyVGn5jvpckxKE40zn97qRO2jABqswfGC8qjLE=;
  b=brh7oudw+WarW0228GgxVEwqhwqdbXXsBOlmjpIOLKm2dxGo3QDgL+IJ
   jJ5mg27WNt1/r0TQMoJuc66QE3WzFrYdUueShHOK6oC0ospCamV0zDFV3
   gOHyXjKasFnDeV5dOTLvApZK//KFM5/XKbtJHIEn1wnuqvsLSPCn3zfWl
   I=;
X-CSE-ConnectionGUID: LhXrjWFcTkm4g1TnDEzYAQ==
X-CSE-MsgGUID: jJHcMUvTRz6txzo3q1PtQQ==
X-IPAS-Result: =?us-ascii?q?A0AnAAD5rYFn/4z/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfoTCFXYElA1YPAQEBD0QEAQGFBwKKdAImNAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAgEDJwsBRhBRK?=
 =?us-ascii?q?ysHEoMBgmUDtFWBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSCUIE+b4UQhXcEg?=
 =?us-ascii?q?jKFNZ5USIEhA1ksAVUTDQoLBwWBODoDIgsLDAsUHBUCFR4BEQYQBG1EN4JGa?=
 =?us-ascii?q?Us6Ag0CNYIeJFiCK4RchEeEVIJLVYJHghR6gRmEA0ADCxgNSBEsNwYOGwY+b?=
 =?us-ascii?q?gebKDyDbwGBD4IopgeLcpURhCWBY59jGjOqUy6HZJBqIqQlhGaBZzyBWTMaC?=
 =?us-ascii?q?BsVgyJSGQ+OLRYWvEYlMjwCBwsBAQMJkR4BAQ?=
IronPort-Data: A9a23:g4qXvKpqJAxNHDq9YDqWFFLuCmheBmI6ZBIvgKrLsJaIsI4StFCzt
 garIBmPPPqLY2r0ct5yYYy09BtS6J+Hx9c1TFE5pCE3RXkU+OPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOtvra8Us355wehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0sJ3MXtMy
 tITFDMIMh/au+Sa7aCKY9A506zPLOGzVG8ekmtrwTecCbMtRorOBv2Ro9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LUPrSn8/w7pX7Wz9fqFSZrK46y2PS1wd2lrPqNbI5f/TRHZkKwBrJ/
 DiuE2LRADM6P/mi1wa/4Cywlv3IxjqiYJ4rLejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U59QuE4qnZ+QCUAi4DVDEpQNUguNU7Wn8s2
 0OFks3BASFptvueSRq17r6eoDWzETIYIW8LeWkPSg5ty9/uvI0+kDrRQdt5Vq24lNv4HXf32
 T/ikcQlr68YgchO0+Cw+krKxmr34JPIVQUyoA7QWwpJ8z9EWWJsXKTwgXCz0BqKBNzxooWp1
 JTcp/Wj0Q==
IronPort-HdrOrdr: A9a23:Z2tjzKmnRzl7AviU5t1IlcU7LCHpDfIr3DAbv31ZSRFFG/FwWf
 rAoB19726StN9/YhAdcLy7VZVoBEmsl6KdgrNhWYtKIjOHhILAFugLhuHfKn/bakjDH4Vmu5
 uIHZITNDSJNykYsS4/izPIaurJB7K8gcaVuds=
X-Talos-CUID: 9a23:GhqMX260KYXItBvevNss0E4kAMIaXHbhz3KMLBaED0pEWoy8cArF
X-Talos-MUID: 9a23:VdVpWwmhX4Z+IYkQMLzddnpgFudjxpmwNHofz4kWqc7fLHVIJw6k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="304764922"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 23:32:53 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTP id 143EE180001FA;
	Fri, 10 Jan 2025 23:32:53 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id E34EF20F2005; Fri, 10 Jan 2025 15:32:52 -0800 (PST)
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
Subject: [PATCH net-next v5 2/4] enic: Remove an unnecessary parameter from function enic_queue_rq_desc
Date: Fri, 10 Jan 2025 15:32:47 -0800
Message-Id: <20250110233249.23258-3-johndale@cisco.com>
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
X-Outbound-Node: rcdn-l-core-03.cisco.com

The function enic_queue_rq_desc has a parameter os_buf_index which was
only called with a hard coded 0. Remove it.

No functional change.

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
index 2a1448e98466..fd3d34c1d4d4 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1332,14 +1332,11 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
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
@@ -1355,8 +1352,7 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
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
2.44.0


