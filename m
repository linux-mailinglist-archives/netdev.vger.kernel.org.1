Return-Path: <netdev+bounces-143447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11B9C2736
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F91F21713
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F693202641;
	Fri,  8 Nov 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Rhnst6Sh"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0C1DFE1D;
	Fri,  8 Nov 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102624; cv=none; b=szksfpiixLznlx+sSq57308uEd3pqspqalQf7olUeAAV+cw8shrpzVwDtrSvyz1fu6mefLX4lel0+uGs7V53FqAejpR27Omtp5xQKVpCUqY9Z3j1XfXuqR5v3m0lA9BydXenSbuVGmR5GjzZm3dC1fFQd6ncQbD9HxfpyPHz1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102624; c=relaxed/simple;
	bh=SPkGkJwYMTv83BMMgZFjzq2iJG1yLa4FoLBit5GloU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idbbcn41dqJ2GAfxyoVcmUvI2l50aap/ScSh4+jry0cRLcMpUHCqJ2UjXnut5hJ8zjI1wT156iQlWZ6D6LuJsD+O8efljX+UMlT0s76snqzS2WxoZ2OX1aHb/pGEHqdglMNEIMdr8v7mZy3fVKuXL6xqnPMof7oypOUUb8dMmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Rhnst6Sh; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=18944; q=dns/txt;
  s=iport; t=1731102621; x=1732312221;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UFqXy0J1OEIolKkPnDz9umk/wJmr2e/IfWQp+BXm8WM=;
  b=Rhnst6ShFpW+SPbn9zDEmBVOujO9FQU17UfGjaMUdgr3IsGT7BrQAK+N
   fHUhF+VNYCXr55DhtEPAoSJsh1Mv1XvmrBZB8LmBbTrh8EVANUmG+oLAr
   OXkSGo9aVPgdKVdbQskG/NLPW5BrS0XYiDodxJCzlWMmqtGkTU4cUdCtn
   E=;
X-CSE-ConnectionGUID: /QysbxoYRY+RqyYYImuMUQ==
X-CSE-MsgGUID: Z5era5MYRU+lPuTuIHi6fA==
X-IPAS-Result: =?us-ascii?q?A0AHAACvhi5n/4//Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJKgVBCSIRViB2HMIIhi3WSIxSBEQNWDwEBA?=
 =?us-ascii?q?Q9EBAEBhQcCijoCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4ThgiGWwIBAyMEUhAlAiYCAisbEAYBEoMBgmUCAbBden8zgQGEe9k4g?=
 =?us-ascii?q?W2BGi4BiEsBgWyDfTuEPCcbgUlEglCCLYQqg3SCaQSDQoJYUnYlgRMCAgIHA?=
 =?us-ascii?q?odzmFIJP4EFHANZIREBVRMNCgsHBWNYPgMib2lceiuBDoEXOkOBO4EiLxshC?=
 =?us-ascii?q?1yBOIEaFAYVBIEOQT+CSmlLNwINAjaCJCRZgk+FHYRvhGiCEh1AAwsYDUgRL?=
 =?us-ascii?q?DUGDhsGPQFuB54pRoMtexR/gRQsBSY4kloJAQeDaY09gh+fTIQkoVkzqk0eE?=
 =?us-ascii?q?JhJIqQbhGaBZzyBWTMaCBsVgyJSGQ+OKgMWFpMAAbVAQzU7AgcLAQEDCYZLi?=
 =?us-ascii?q?m5gAQE?=
IronPort-Data: A9a23:6zQLPqtH0uONpgruSROQ0AGnzOfnVIRfMUV32f8akzHdYApBsoF/q
 tZmKTqEbPmJZWCkeo90aYnk9xlV6sDVmoQwQQU/rSoyEnkQgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhIsvvb+Esz1BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwvd9mGmte8
 s0iGXM3dwGytsOz3ZeGc7w57igjBJGD0II3oHpsy3TdSP0hW52GG/uM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwtMYH49tL/Aan3XdTBVs1mSr6Mf6GnIxws327/oWDbQUofaFZ8ExBvA+
 goq+UzLXxwAPYG6+AC4sXaUm9PSvAP6Bow7QejQGvlCxQf7KnYoIBEfS1a+ifWwlEO7X9VRN
 woS9zZGhaU+6UmiXNThdxK/p3GAs1gXXN84O+098gSW4qnZ+QCUAi4DVDEpQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpp
 nMInY2aqesJF5zIzHLLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4uVmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:UZ2NOqhVcRl6fB6By8RaajiqPnBQXhcji2hC6mlwRA09TyVXrb
 HIoB1973/JYVcqOU3I9urtBEDtex7hHNtOkOws1NSZMjUOxlHYT72KhLGKq1aLJ8S9zJ8+6U
 4KScdD4bPLfDxHpPe/zQWmH9Mn2dWdtIKllY7lvg9QZDAvRq1+4wJ+EwqBVnd3Sg5PGIYjGP
 Onl7N6TkKbCBIqhgDRPAh+YwAFzOe7767bXQ==
X-Talos-CUID: 9a23:0WAc+m8bVjDbD5Sz+MSVvwktC9svYnrs9kaTGVapOFdITaCwdGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A2RBpag2nJNYPKx0jDI5U6Vo4GTUj0fmjEklQtKQ?=
 =?us-ascii?q?8hoqADTFMJha9jWq5a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,139,1728950400"; 
   d="scan'208";a="388292504"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Nov 2024 21:49:13 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 798C718000252;
	Fri,  8 Nov 2024 21:49:12 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id F17D1CC128E; Fri,  8 Nov 2024 21:49:11 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Fri, 08 Nov 2024 21:47:47 +0000
Subject: [PATCH net-next v3 1/7] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-remove_vic_resource_limits-v3-1-3ba8123bcffc@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731102551; l=19489;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=SPkGkJwYMTv83BMMgZFjzq2iJG1yLa4FoLBit5GloU8=;
 b=jvM7gjbSFQeiWiuSkEX925wET1bFLwsVqBdixZusITO+YZiBJWdxg33UFnyjI9ydGqMMTRLTr
 nv4DnSF+dSpD839JwTimNyntJNYN2rclaVMxNsbcSQ9gcgGQRwcw+6I
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Outbound-SMTP-Client: 171.70.41.192, neescoba-vicdev.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

Bundling the wq/rq specific data into dedicated enic_wq/rq structures
cleans up the enic structure and simplifies future changes related to
wq/rq.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic.h         |  18 ++--
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |   4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    | 120 ++++++++++++-------------
 drivers/net/ethernet/cisco/enic/enic_res.c     |  12 +--
 4 files changed, 81 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 0cc3644ee8554f52401a0be7f44a1475ab2ea2b9..e6edb43515b97feeb21a9b55a1eeaa9b9381183f 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -162,6 +162,17 @@ struct enic_rq_stats {
 	u64 desc_skip;			/* Rx pkt went into later buffer */
 };
 
+struct enic_wq {
+	struct vnic_wq vwq;
+	struct enic_wq_stats stats;
+	spinlock_t lock;		/* spinlock for wq */
+};
+
+struct enic_rq {
+	struct vnic_rq vrq;
+	struct enic_rq_stats stats;
+};
+
 /* Per-instance private data structure */
 struct enic {
 	struct net_device *netdev;
@@ -194,16 +205,13 @@ struct enic {
 	struct enic_port_profile *pp;
 
 	/* work queue cache line section */
-	____cacheline_aligned struct vnic_wq wq[ENIC_WQ_MAX];
-	spinlock_t wq_lock[ENIC_WQ_MAX];
-	struct enic_wq_stats wq_stats[ENIC_WQ_MAX];
+	____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
 	/* receive queue cache line section */
-	____cacheline_aligned struct vnic_rq rq[ENIC_RQ_MAX];
-	struct enic_rq_stats rq_stats[ENIC_RQ_MAX];
+	____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
 	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f7986f2b6a1794144909ffad9e3e09c32ea44c93..909d6f7000e160cf2e15de4660c1034cad7d51ba 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -337,7 +337,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 	for (i = 0; i < NUM_ENIC_GEN_STATS; i++)
 		*(data++) = ((u64 *)&enic->gen_stats)[enic_gen_stats[i].index];
 	for (i = 0; i < enic->rq_count; i++) {
-		struct enic_rq_stats *rqstats = &enic->rq_stats[i];
+		struct enic_rq_stats *rqstats = &enic->rq[i].stats;
 		int index;
 
 		for (j = 0; j < NUM_ENIC_PER_RQ_STATS; j++) {
@@ -346,7 +346,7 @@ static void enic_get_ethtool_stats(struct net_device *netdev,
 		}
 	}
 	for (i = 0; i < enic->wq_count; i++) {
-		struct enic_wq_stats *wqstats = &enic->wq_stats[i];
+		struct enic_wq_stats *wqstats = &enic->wq[i].stats;
 		int index;
 
 		for (j = 0; j < NUM_ENIC_PER_WQ_STATS; j++) {
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index ffed14b63d41d1737c577fe1662eb1c2c8aea808..eb00058b6c68ec5c1ac433b54b5bc6f3fb613777 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -342,8 +342,8 @@ static void enic_wq_free_buf(struct vnic_wq *wq,
 {
 	struct enic *enic = vnic_dev_priv(wq->vdev);
 
-	enic->wq_stats[wq->index].cq_work++;
-	enic->wq_stats[wq->index].cq_bytes += buf->len;
+	enic->wq[wq->index].stats.cq_work++;
+	enic->wq[wq->index].stats.cq_bytes += buf->len;
 	enic_free_wq_buf(wq, buf);
 }
 
@@ -352,20 +352,20 @@ static int enic_wq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 {
 	struct enic *enic = vnic_dev_priv(vdev);
 
-	spin_lock(&enic->wq_lock[q_number]);
+	spin_lock(&enic->wq[q_number].lock);
 
-	vnic_wq_service(&enic->wq[q_number], cq_desc,
+	vnic_wq_service(&enic->wq[q_number].vwq, cq_desc,
 		completed_index, enic_wq_free_buf,
 		opaque);
 
 	if (netif_tx_queue_stopped(netdev_get_tx_queue(enic->netdev, q_number)) &&
-	    vnic_wq_desc_avail(&enic->wq[q_number]) >=
+	    vnic_wq_desc_avail(&enic->wq[q_number].vwq) >=
 	    (MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS)) {
 		netif_wake_subqueue(enic->netdev, q_number);
-		enic->wq_stats[q_number].wake++;
+		enic->wq[q_number].stats.wake++;
 	}
 
-	spin_unlock(&enic->wq_lock[q_number]);
+	spin_unlock(&enic->wq[q_number].lock);
 
 	return 0;
 }
@@ -377,7 +377,7 @@ static bool enic_log_q_error(struct enic *enic)
 	bool err = false;
 
 	for (i = 0; i < enic->wq_count; i++) {
-		error_status = vnic_wq_error_status(&enic->wq[i]);
+		error_status = vnic_wq_error_status(&enic->wq[i].vwq);
 		err |= error_status;
 		if (error_status)
 			netdev_err(enic->netdev, "WQ[%d] error_status %d\n",
@@ -385,7 +385,7 @@ static bool enic_log_q_error(struct enic *enic)
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
-		error_status = vnic_rq_error_status(&enic->rq[i]);
+		error_status = vnic_rq_error_status(&enic->rq[i].vrq);
 		err |= error_status;
 		if (error_status)
 			netdev_err(enic->netdev, "RQ[%d] error_status %d\n",
@@ -598,9 +598,9 @@ static int enic_queue_wq_skb_vlan(struct enic *enic, struct vnic_wq *wq,
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
 	/* The enic_queue_wq_desc() above does not do HW checksum */
-	enic->wq_stats[wq->index].csum_none++;
-	enic->wq_stats[wq->index].packets++;
-	enic->wq_stats[wq->index].bytes += skb->len;
+	enic->wq[wq->index].stats.csum_none++;
+	enic->wq[wq->index].stats.packets++;
+	enic->wq[wq->index].stats.bytes += skb->len;
 
 	return err;
 }
@@ -634,9 +634,9 @@ static int enic_queue_wq_skb_csum_l4(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
-	enic->wq_stats[wq->index].csum_partial++;
-	enic->wq_stats[wq->index].packets++;
-	enic->wq_stats[wq->index].bytes += skb->len;
+	enic->wq[wq->index].stats.csum_partial++;
+	enic->wq[wq->index].stats.packets++;
+	enic->wq[wq->index].stats.bytes += skb->len;
 
 	return err;
 }
@@ -699,11 +699,11 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	if (skb->encapsulation) {
 		hdr_len = skb_inner_tcp_all_headers(skb);
 		enic_preload_tcp_csum_encap(skb);
-		enic->wq_stats[wq->index].encap_tso++;
+		enic->wq[wq->index].stats.encap_tso++;
 	} else {
 		hdr_len = skb_tcp_all_headers(skb);
 		enic_preload_tcp_csum(skb);
-		enic->wq_stats[wq->index].tso++;
+		enic->wq[wq->index].stats.tso++;
 	}
 
 	/* Queue WQ_ENET_MAX_DESC_LEN length descriptors
@@ -757,8 +757,8 @@ static int enic_queue_wq_skb_tso(struct enic *enic, struct vnic_wq *wq,
 	pkts = len / mss;
 	if ((len % mss) > 0)
 		pkts++;
-	enic->wq_stats[wq->index].packets += pkts;
-	enic->wq_stats[wq->index].bytes += (len + (pkts * hdr_len));
+	enic->wq[wq->index].stats.packets += pkts;
+	enic->wq[wq->index].stats.bytes += (len + (pkts * hdr_len));
 
 	return 0;
 }
@@ -792,9 +792,9 @@ static inline int enic_queue_wq_skb_encap(struct enic *enic, struct vnic_wq *wq,
 	if (!eop)
 		err = enic_queue_wq_skb_cont(enic, wq, skb, len_left, loopback);
 
-	enic->wq_stats[wq->index].encap_csum++;
-	enic->wq_stats[wq->index].packets++;
-	enic->wq_stats[wq->index].bytes += skb->len;
+	enic->wq[wq->index].stats.encap_csum++;
+	enic->wq[wq->index].stats.packets++;
+	enic->wq[wq->index].stats.bytes += skb->len;
 
 	return err;
 }
@@ -812,7 +812,7 @@ static inline int enic_queue_wq_skb(struct enic *enic,
 		/* VLAN tag from trunking driver */
 		vlan_tag_insert = 1;
 		vlan_tag = skb_vlan_tag_get(skb);
-		enic->wq_stats[wq->index].add_vlan++;
+		enic->wq[wq->index].stats.add_vlan++;
 	} else if (enic->loop_enable) {
 		vlan_tag = enic->loop_tag;
 		loopback = 1;
@@ -859,11 +859,11 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	struct netdev_queue *txq;
 
 	txq_map = skb_get_queue_mapping(skb) % enic->wq_count;
-	wq = &enic->wq[txq_map];
+	wq = &enic->wq[txq_map].vwq;
 
 	if (skb->len <= 0) {
 		dev_kfree_skb_any(skb);
-		enic->wq_stats[wq->index].null_pkt++;
+		enic->wq[wq->index].stats.null_pkt++;
 		return NETDEV_TX_OK;
 	}
 
@@ -878,19 +878,19 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 	    skb_shinfo(skb)->nr_frags + 1 > ENIC_NON_TSO_MAX_DESC &&
 	    skb_linearize(skb)) {
 		dev_kfree_skb_any(skb);
-		enic->wq_stats[wq->index].skb_linear_fail++;
+		enic->wq[wq->index].stats.skb_linear_fail++;
 		return NETDEV_TX_OK;
 	}
 
-	spin_lock(&enic->wq_lock[txq_map]);
+	spin_lock(&enic->wq[txq_map].lock);
 
 	if (vnic_wq_desc_avail(wq) <
 	    skb_shinfo(skb)->nr_frags + ENIC_DESC_MAX_SPLITS) {
 		netif_tx_stop_queue(txq);
 		/* This is a hard error, log it */
 		netdev_err(netdev, "BUG! Tx ring full when queue awake!\n");
-		spin_unlock(&enic->wq_lock[txq_map]);
-		enic->wq_stats[wq->index].desc_full_awake++;
+		spin_unlock(&enic->wq[txq_map].lock);
+		enic->wq[wq->index].stats.desc_full_awake++;
 		return NETDEV_TX_BUSY;
 	}
 
@@ -899,14 +899,14 @@ static netdev_tx_t enic_hard_start_xmit(struct sk_buff *skb,
 
 	if (vnic_wq_desc_avail(wq) < MAX_SKB_FRAGS + ENIC_DESC_MAX_SPLITS) {
 		netif_tx_stop_queue(txq);
-		enic->wq_stats[wq->index].stopped++;
+		enic->wq[wq->index].stats.stopped++;
 	}
 	skb_tx_timestamp(skb);
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
 		vnic_wq_doorbell(wq);
 
 error:
-	spin_unlock(&enic->wq_lock[txq_map]);
+	spin_unlock(&enic->wq[txq_map].lock);
 
 	return NETDEV_TX_OK;
 }
@@ -941,9 +941,9 @@ static void enic_get_stats(struct net_device *netdev,
 	net_stats->multicast = stats->rx.rx_multicast_frames_ok;
 
 	for (i = 0; i < ENIC_RQ_MAX; i++) {
-		struct enic_rq_stats *rqs = &enic->rq_stats[i];
+		struct enic_rq_stats *rqs = &enic->rq[i].stats;
 
-		if (!enic->rq->ctrl)
+		if (!enic->rq[i].vrq.ctrl)
 			break;
 		pkt_truncated += rqs->pkt_truncated;
 		bad_fcs += rqs->bad_fcs;
@@ -1313,7 +1313,7 @@ static int enic_rq_alloc_buf(struct vnic_rq *rq)
 	}
 	skb = netdev_alloc_skb_ip_align(netdev, len);
 	if (!skb) {
-		enic->rq_stats[rq->index].no_skb++;
+		enic->rq[rq->index].stats.no_skb++;
 		return -ENOMEM;
 	}
 
@@ -1366,7 +1366,7 @@ static void enic_rq_indicate_buf(struct vnic_rq *rq,
 	struct net_device *netdev = enic->netdev;
 	struct sk_buff *skb;
 	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
-	struct enic_rq_stats *rqstats = &enic->rq_stats[rq->index];
+	struct enic_rq_stats *rqstats = &enic->rq[rq->index].stats;
 
 	u8 type, color, eop, sop, ingress_port, vlan_stripped;
 	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
@@ -1512,7 +1512,7 @@ static int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc,
 {
 	struct enic *enic = vnic_dev_priv(vdev);
 
-	vnic_rq_service(&enic->rq[q_number], cq_desc,
+	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc,
 		completed_index, VNIC_RQ_RETURN_DESC,
 		enic_rq_indicate_buf, opaque);
 
@@ -1609,7 +1609,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[0], enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[0].vrq, enic_rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling
 	 * mode so we can try to fill the ring again.
@@ -1621,7 +1621,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 		/* Call the function which refreshes the intr coalescing timer
 		 * value based on the traffic.
 		 */
-		enic_calc_int_moderation(enic, &enic->rq[0]);
+		enic_calc_int_moderation(enic, &enic->rq[0].vrq);
 
 	if ((rq_work_done < budget) && napi_complete_done(napi, rq_work_done)) {
 
@@ -1630,11 +1630,11 @@ static int enic_poll(struct napi_struct *napi, int budget)
 		 */
 
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
-			enic_set_int_moderation(enic, &enic->rq[0]);
+			enic_set_int_moderation(enic, &enic->rq[0].vrq);
 		vnic_intr_unmask(&enic->intr[intr]);
-		enic->rq_stats[0].napi_complete++;
+		enic->rq[0].stats.napi_complete++;
 	} else {
-		enic->rq_stats[0].napi_repoll++;
+		enic->rq[0].stats.napi_repoll++;
 	}
 
 	return rq_work_done;
@@ -1683,7 +1683,7 @@ static int enic_poll_msix_wq(struct napi_struct *napi, int budget)
 	struct net_device *netdev = napi->dev;
 	struct enic *enic = netdev_priv(netdev);
 	unsigned int wq_index = (napi - &enic->napi[0]) - enic->rq_count;
-	struct vnic_wq *wq = &enic->wq[wq_index];
+	struct vnic_wq *wq = &enic->wq[wq_index].vwq;
 	unsigned int cq;
 	unsigned int intr;
 	unsigned int wq_work_to_do = ENIC_WQ_NAPI_BUDGET;
@@ -1737,7 +1737,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 			0 /* don't unmask intr */,
 			0 /* don't reset intr timer */);
 
-	err = vnic_rq_fill(&enic->rq[rq], enic_rq_alloc_buf);
+	err = vnic_rq_fill(&enic->rq[rq].vrq, enic_rq_alloc_buf);
 
 	/* Buffer allocation failed. Stay in polling mode
 	 * so we can try to fill the ring again.
@@ -1749,7 +1749,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 		/* Call the function which refreshes the intr coalescing timer
 		 * value based on the traffic.
 		 */
-		enic_calc_int_moderation(enic, &enic->rq[rq]);
+		enic_calc_int_moderation(enic, &enic->rq[rq].vrq);
 
 	if ((work_done < budget) && napi_complete_done(napi, work_done)) {
 
@@ -1758,11 +1758,11 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 		 */
 
 		if (enic->rx_coalesce_setting.use_adaptive_rx_coalesce)
-			enic_set_int_moderation(enic, &enic->rq[rq]);
+			enic_set_int_moderation(enic, &enic->rq[rq].vrq);
 		vnic_intr_unmask(&enic->intr[intr]);
-		enic->rq_stats[rq].napi_complete++;
+		enic->rq[rq].stats.napi_complete++;
 	} else {
-		enic->rq_stats[rq].napi_repoll++;
+		enic->rq[rq].stats.napi_repoll++;
 	}
 
 	return work_done;
@@ -1989,10 +1989,10 @@ static int enic_open(struct net_device *netdev)
 
 	for (i = 0; i < enic->rq_count; i++) {
 		/* enable rq before updating rq desc */
-		vnic_rq_enable(&enic->rq[i]);
-		vnic_rq_fill(&enic->rq[i], enic_rq_alloc_buf);
+		vnic_rq_enable(&enic->rq[i].vrq);
+		vnic_rq_fill(&enic->rq[i].vrq, enic_rq_alloc_buf);
 		/* Need at least one buffer on ring to get going */
-		if (vnic_rq_desc_used(&enic->rq[i]) == 0) {
+		if (vnic_rq_desc_used(&enic->rq[i].vrq) == 0) {
 			netdev_err(netdev, "Unable to alloc receive buffers\n");
 			err = -ENOMEM;
 			goto err_out_free_rq;
@@ -2000,7 +2000,7 @@ static int enic_open(struct net_device *netdev)
 	}
 
 	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_enable(&enic->wq[i]);
+		vnic_wq_enable(&enic->wq[i].vwq);
 
 	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
 		enic_dev_add_station_addr(enic);
@@ -2027,9 +2027,9 @@ static int enic_open(struct net_device *netdev)
 
 err_out_free_rq:
 	for (i = 0; i < enic->rq_count; i++) {
-		ret = vnic_rq_disable(&enic->rq[i]);
+		ret = vnic_rq_disable(&enic->rq[i].vrq);
 		if (!ret)
-			vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+			vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
 	}
 	enic_dev_notify_unset(enic);
 err_out_free_intr:
@@ -2071,12 +2071,12 @@ static int enic_stop(struct net_device *netdev)
 		enic_dev_del_station_addr(enic);
 
 	for (i = 0; i < enic->wq_count; i++) {
-		err = vnic_wq_disable(&enic->wq[i]);
+		err = vnic_wq_disable(&enic->wq[i].vwq);
 		if (err)
 			return err;
 	}
 	for (i = 0; i < enic->rq_count; i++) {
-		err = vnic_rq_disable(&enic->rq[i]);
+		err = vnic_rq_disable(&enic->rq[i].vrq);
 		if (err)
 			return err;
 	}
@@ -2086,9 +2086,9 @@ static int enic_stop(struct net_device *netdev)
 	enic_free_intr(enic);
 
 	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_clean(&enic->wq[i], enic_free_wq_buf);
+		vnic_wq_clean(&enic->wq[i].vwq, enic_free_wq_buf);
 	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
+		vnic_rq_clean(&enic->rq[i].vrq, enic_free_rq_buf);
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_clean(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
@@ -2576,7 +2576,7 @@ static void enic_get_queue_stats_rx(struct net_device *dev, int idx,
 				    struct netdev_queue_stats_rx *rxs)
 {
 	struct enic *enic = netdev_priv(dev);
-	struct enic_rq_stats *rqstats = &enic->rq_stats[idx];
+	struct enic_rq_stats *rqstats = &enic->rq[idx].stats;
 
 	rxs->bytes = rqstats->bytes;
 	rxs->packets = rqstats->packets;
@@ -2590,7 +2590,7 @@ static void enic_get_queue_stats_tx(struct net_device *dev, int idx,
 				    struct netdev_queue_stats_tx *txs)
 {
 	struct enic *enic = netdev_priv(dev);
-	struct enic_wq_stats *wqstats = &enic->wq_stats[idx];
+	struct enic_wq_stats *wqstats = &enic->wq[idx].stats;
 
 	txs->bytes = wqstats->bytes;
 	txs->packets = wqstats->packets;
@@ -2993,7 +2993,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
 
 	for (i = 0; i < enic->wq_count; i++)
-		spin_lock_init(&enic->wq_lock[i]);
+		spin_lock_init(&enic->wq[i].lock);
 
 	/* Register net device
 	 */
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 1c48aebdbab02b88293544dcabda2d90d1a71a70..60be09acb9fd56b642b7cabc77fac01f526b29a2 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -176,9 +176,9 @@ void enic_free_vnic_resources(struct enic *enic)
 	unsigned int i;
 
 	for (i = 0; i < enic->wq_count; i++)
-		vnic_wq_free(&enic->wq[i]);
+		vnic_wq_free(&enic->wq[i].vwq);
 	for (i = 0; i < enic->rq_count; i++)
-		vnic_rq_free(&enic->rq[i]);
+		vnic_rq_free(&enic->rq[i].vrq);
 	for (i = 0; i < enic->cq_count; i++)
 		vnic_cq_free(&enic->cq[i]);
 	for (i = 0; i < enic->intr_count; i++)
@@ -233,7 +233,7 @@ void enic_init_vnic_resources(struct enic *enic)
 
 	for (i = 0; i < enic->rq_count; i++) {
 		cq_index = i;
-		vnic_rq_init(&enic->rq[i],
+		vnic_rq_init(&enic->rq[i].vrq,
 			cq_index,
 			error_interrupt_enable,
 			error_interrupt_offset);
@@ -241,7 +241,7 @@ void enic_init_vnic_resources(struct enic *enic)
 
 	for (i = 0; i < enic->wq_count; i++) {
 		cq_index = enic->rq_count + i;
-		vnic_wq_init(&enic->wq[i],
+		vnic_wq_init(&enic->wq[i].vwq,
 			cq_index,
 			error_interrupt_enable,
 			error_interrupt_offset);
@@ -322,7 +322,7 @@ int enic_alloc_vnic_resources(struct enic *enic)
 	 */
 
 	for (i = 0; i < enic->wq_count; i++) {
-		err = vnic_wq_alloc(enic->vdev, &enic->wq[i], i,
+		err = vnic_wq_alloc(enic->vdev, &enic->wq[i].vwq, i,
 			enic->config.wq_desc_count,
 			sizeof(struct wq_enet_desc));
 		if (err)
@@ -330,7 +330,7 @@ int enic_alloc_vnic_resources(struct enic *enic)
 	}
 
 	for (i = 0; i < enic->rq_count; i++) {
-		err = vnic_rq_alloc(enic->vdev, &enic->rq[i], i,
+		err = vnic_rq_alloc(enic->vdev, &enic->rq[i].vrq, i,
 			enic->config.rq_desc_count,
 			sizeof(struct rq_enet_desc));
 		if (err)

-- 
2.35.6


