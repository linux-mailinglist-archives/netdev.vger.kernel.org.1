Return-Path: <netdev+bounces-154846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B12A00129
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E593A3A1A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337C1A8F71;
	Thu,  2 Jan 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="QugoD8Yj"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A6282E1
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856721; cv=none; b=kEbbX4TdS+t35m1/UFkxUNm0AMBuA7w88/4e84hFNctn+xR6b33ZiDGVGgYUMXpb0wUdlUcaJu1gAYm+MgMLWzfWYwJMin1rN0W5scoqXElCRUk/NQKPxrBo+TNgXdJQQbS9GC2101umUlU4Z3hiGJkFlaN0Bt8nf5OY5p4Xy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856721; c=relaxed/simple;
	bh=T4hWg15WZP+lApfrr9Y/thSG09sNb0ZXX0qr/vwtnN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4+ENpvHK5ch2czyF69qEhQ4yfwVAa1wszUrZt+mF6dr8sa5VHFDEhyp04YV8xv83HUF3nWR5dFHHkfNasvfKlSkkE+ut7feUj3apaUWAdmTyYip7oYudF/bj8eV0/JZKroTN/2g9n04/mABaALtfgmEycf1ULaFYKPvKak9GsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=QugoD8Yj; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2510; q=dns/txt; s=iport;
  t=1735856719; x=1737066319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJaW4D8IoGJsrpAQ4RXWrveI+HMg7JYPf5VPwYrwcqs=;
  b=QugoD8Yja1OuAUGYUwtQB3ltsIYe9Cy+pueXOBE0VEoABjv9jmjjytPo
   2h1n3BBjPf7igD0SSeQgOQP/Pqh8Hz2kW5GXCMkQpSvFM2WqvQagksIQp
   l+uLreuAM1t6D+CIDR3AZO3xrLPx/NsTgkbDsmDMFhD9oLoFid+uSL6qE
   E=;
X-CSE-ConnectionGUID: vlSTnewbTT6TaI1O/Uz25w==
X-CSE-MsgGUID: XaaTmbSeQv2eBDoi1R1d3Q==
X-IPAS-Result: =?us-ascii?q?A0ANAADxEHdnj48QJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6EwhV2BJQNWDwEBAQ9EBAEBhQcCim8CJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFDjuGCIZbAgEDJ?=
 =?us-ascii?q?wsBRhBRKysHEoMBgmUDsxaBeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSCUIE+b?=
 =?us-ascii?q?4UQhXcEiQidV0iBIQNZLAFVEw0KCwcFgTk6AyILCwwLFBwVAoEagQEBFAYVB?=
 =?us-ascii?q?IELRT2CSGlJNwINAjaCICRYgiuEXYRHhFaCSVWCSIIXfIEagipAAwsYDUgRL?=
 =?us-ascii?q?DcGDhsGPm4Hm3k8g26BD4IopgehA4QkgWOfYxozqlIuh2SQaiKkJIRmgWc6g?=
 =?us-ascii?q?VszGggbFYMiUhkPji0NCRawXCUyPAIHCwEBAwmRVgEB?=
IronPort-Data: A9a23:a19+ra0toKivUGyt6vbD5TZxkn2cJEfYwER7XKvMYLTBsI5bpzVWn
 GodCGyDM/fbMGOnet91YdjjpktS7cOBz9FrTFFu3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmE4E/watANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXU4
 7sen+WFYAX4g2csaDpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGEkUNAYsV5exLPT9y/
 N1BD3cwfEremLfjqF67YrEEasULJc3vOsYb/3pn1zycVahgSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2ME+ojx5nYj/7DLo8m+euinD7fhVTqUmeouw85G27IAlZjOCzb4qPJoTXLSlTtnaRr
 17D9V/0Ow9AOfazzjvcyCug3daayEsXX6pJSeXnraQ16LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhCE6g7NWiYsA0L+2uAiZxTmtvZPOCAUy4207Q15J8CtnYLWZYYG342Tns8pJDd++CWST5
 iUbzp32AP81MbmBkymEQeMoFb6v5uqYPDC0vbKJN8d6n9hK0yD/Fb288A1DyFFV3tHokAIFg
 XM/WysMvfe/31PzMcebhr5d7exxk8AM8vy+DZjpgiJmOMQZSeN+1HgGibSs927silMwtqo0J
 I2Wd82hZV5DVv86k2foHLtGgOBxrszb+Y81bc2qp/hA+efPDEN5tZ9fazNik8hgtvrd+1SPm
 zqhH5bVl0sHOAEBXsUn2dVOdQ9RdydT6WHeoM1MfenLORt9BGwkELfQx7hnE7GJbIwL/tokC
 kqVAxcCoHKm3CWvAVzTNhhLNui1Nb4h9i1TAMDZFQrzs5TVSdr0tP9HH3b2FJF7nNFeIQlcF
 qBUK5jZU60VGlwqOV01NPHAkWCrTzzz7SrmAsZvSGFXk0JIL+ARxuLZQw==
IronPort-HdrOrdr: A9a23:n5Q62amgPXM1y0Y/Lg60ojSk2szpDfIr3DAbv31ZSRFFG/FwWf
 rAoB19726StN9/YhAdcLy7VZVoBEmsl6KdgrNhWYtKIjOHhILAFugLhuHfKn/bakjDH4Vmu5
 uIHZITNDSJNykYsS4/izPIaurJB7K8gcaVuds=
X-Talos-CUID: 9a23:5WYsxWFqV12/1N4mqmJ58HUoHM06eEHhkkvZAhafTlt7EuCKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AQSdqlw04rtnXi6AFIwVxbx4ktTUj062nNEUHqpg?=
 =?us-ascii?q?/pZOJHwB3Om6n1Tjse9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="406782405"
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jan 2025 22:25:12 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-06.cisco.com (Postfix) with ESMTP id 4FF9518000110;
	Thu,  2 Jan 2025 22:25:12 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 2450C20F2005; Thu,  2 Jan 2025 14:25:12 -0800 (PST)
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
Subject: [PATCH net-next v4 2/6] enic: Remove an unnecessary parameter from function enic_queue_rq_desc
Date: Thu,  2 Jan 2025 14:24:23 -0800
Message-Id: <20250102222427.28370-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250102222427.28370-1-johndale@cisco.com>
References: <20250102222427.28370-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-06.cisco.com

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


