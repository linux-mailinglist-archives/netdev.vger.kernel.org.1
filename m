Return-Path: <netdev+bounces-154401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1D9FD860
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2AD3A2949
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717AD801;
	Sat, 28 Dec 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Qk78ZLuI"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6ED9474
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344666; cv=none; b=i4HXIracInDwWNF1XhCl9yXU9VN8vODfLJ5uY9rMbvDibLzAd4WNV2r3zSd2zi+lbR2QYvWZm+EwJel1WlGhWj35Ptef/e3gcG65eY/gEM+/bT/yx05rLCNHl7hPTWAvZ9MdNiL/+XnyzcuB4uL/7rSx9N6dskVzFzs6jMV0OA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344666; c=relaxed/simple;
	bh=T4hWg15WZP+lApfrr9Y/thSG09sNb0ZXX0qr/vwtnN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBIvRYz88EZNln9kJ0bIVAhym09VcApZ4vSccSRvakeRHUJkjElV7DWLm8cuLojqbiZCjjKqYGBq6BUgAEwy/kpnP1PHAOM4fNfhrFmyJ0c94Xu7FgLrO25c78kajpL1HJfEJiYhamIon8jPwBrGlCyofWj57HUtbZB3uhw/4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Qk78ZLuI; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2510; q=dns/txt; s=iport;
  t=1735344664; x=1736554264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJaW4D8IoGJsrpAQ4RXWrveI+HMg7JYPf5VPwYrwcqs=;
  b=Qk78ZLuI8CiPEazRWikljk2JfWj2CWLr9f9+0N83wUEV+ODlf1Hxs4Uw
   /+aua5LwGGeTUZdw/apkUf6ZBphWVSiwq6NkBPXiiN02qOrpm4U8lxO9i
   +thFL3MwxrpQIhS8NvLOzi8uMQfp5hd0NzWQyDMx4/CjdmjyIdtEbFjiP
   0=;
X-CSE-ConnectionGUID: W3fhm9mmRtKAeOGuqhJOHg==
X-CSE-MsgGUID: 15QH/o2lQrG8v/Jo4i8Ajw==
X-IPAS-Result: =?us-ascii?q?A0ATAABNQW9nj4z/Ja1aHQEBAQEJARIBBQUBgX8IAQsBh?=
 =?us-ascii?q?BlDSIxyX6EwhV2BJQNWDwEBAQ9EBAEBhQcCim4CJjQJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBATkFSYYIhlsCAQMnCwFGEFErK?=
 =?us-ascii?q?wcSgwGCZQOxOoF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT5vhRCFdwSJF?=
 =?us-ascii?q?Z5ySIEhA1ksAVUTDQoLBwWBOToDIgwLDAsUHBUCgR6BAQEUBhUEgQtFPYJKa?=
 =?us-ascii?q?Uk3Ag0CNoIgJFiCTYUXhF6EVoJJVYJ7ghd8gRqCJUADCxgNSBEsNwYOGwY+b?=
 =?us-ascii?q?gecX0aDc4EPgiimB6EDhCSBY59jGjOqUi6HZJBqIqQkhGaBZzqBWzMaCBsVg?=
 =?us-ascii?q?yJSGQ+OLQ0JFrULJTI8AgcLAQEDCZEzAQE?=
IronPort-Data: A9a23:bR5Q96KVVZUC0oABFE+RNZUlxSXFcZb7ZxGr2PjKsXjdYENS0GNUz
 GQfWGjSOvneZjegc9F+O42w9UgCv8XWm4U2TQUd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgP8gWQraj58B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1RV082ONwd/9xrIkhD0
 tMFMTAvSTCM0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBVrAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEyojx5nYj/7DLo8m+euinD7fhVTqUmeouw85G27IAlZjOG0aYuEIozaLSlTth/Fn
 0KB+D79Ows1ZMLY6z3Z8yKFhPCayEsXX6pJSeXnraQ16LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAicxTmtvZPOCAUy4207Q15J8CtGP4ClYt2t7GLHzt9NC6mEV1mjm
 1gLzp32AP81MbmBkymEQeMoFb6v5uqYPDC0vbKJN8d6n9hK0yD/Fb288A1DyFFV3tHokAIFg
 XM/WysMvve/31PzMcebhr5d7ex2l8AM8vy+CpjpgiJmOMQZSeN+1HgGibSs927silMwtqo0J
 I2Wd82hZV5DVv86lmHpF7ZGgOJzrszb+Y81bc6ip/hA+efODEN5tZ9fazNik8hgtvrd+1SPm
 zqhH5bVl0oDOAEBXsUn2dVOdQ9RdydT6WHeoM1MfenLORt9BGwkELfQx7hnE7GJbIwL/tokC
 kqVAxcCoHKm3CWvAVzTOhhLNui1Nb4h9i1TAMDZFQrzs5TVSdr0tP9HH3b2FJF7nNFeIQlcF
 qlfJZjZXK0WFVwqOV01NPHAkWCrTzzz7SrmAsZvSGJXk0JIL+ARxuLZQw==
IronPort-HdrOrdr: A9a23:fwfnpqOM4W3r3sBcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: 9a23:Fb5kHGFqky5wzI1yqmJYr0AUH5Egd0fB717dBGClEGZLb52aHAo=
X-Talos-MUID: 9a23:p0ucbQkJ8AbmVGf1mnCjdno7af5IpKP0DHkXvsUY/OuDaS0gEjWC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,269,1728950400"; 
   d="scan'208";a="411199088"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Dec 2024 00:10:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTP id 99ABE180001E4;
	Sat, 28 Dec 2024 00:10:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 7C3AE20F2005; Fri, 27 Dec 2024 16:10:57 -0800 (PST)
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
Subject: [PATCH net-next v3 2/6] enic: Remove an unnecessary parameter from function enic_queue_rq_desc
Date: Fri, 27 Dec 2024 16:10:51 -0800
Message-Id: <20241228001055.12707-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241228001055.12707-1-johndale@cisco.com>
References: <20241228001055.12707-1-johndale@cisco.com>
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


