Return-Path: <netdev+bounces-144614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9649C7EFF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA50F1F232CB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CB218D655;
	Wed, 13 Nov 2024 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="hw8OL7fM"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809218BB82;
	Wed, 13 Nov 2024 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542218; cv=none; b=j8FkDelmo5TlUXBNoegKKWSlepsK6ZtQugFoEUztrCzX+FQVhz7KJLzUxNZ3x1segOwWLbwEE7jg6jvDNszedA6y/5c8GQcJeYZI3zfUDI4EnTzKpZLUZidwLcefcHZcu2PxBmZCUbynAMti1r0THj0WV4sUW906YWkqpjwhXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542218; c=relaxed/simple;
	bh=hrWeRdXAZbogkSLfeHXbAXj699i49M8/2VzfMC2r0zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1u2urNMGOtSVicdaV2Zb3iavoaDom9J7sTw53AZQ1cu8+EhUn+Ib8yKczPPpWuNgWzUFt+31qm5l2Vm+yXO0qCCsnYVZbBI2LkmDOWQaZRkgSlFZfON3Bygb5cojrzn+Js/ZHGQ7IXQj0UCBzb1d+1noqHTsF89ItKBQfKMfrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=hw8OL7fM; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=18988; q=dns/txt;
  s=iport; t=1731542214; x=1732751814;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0ed6HZKdaPIq4JhbhBLvsC2gmejf3nvsoXzSRrm0gmg=;
  b=hw8OL7fMLm8IUsVTpyfnMUnq0Me7SfcfUK4TapD41BIQPU0KU80JBI3U
   nVKW0USAMvSCi+XhgVotJWu4tfqmdiCP3EG/rgxyrgSPVIeKoRy8UoQyk
   fHits96yyF1JFxqopWpK0GvIoeVoXgN7d/AWrOKXetwoGzUP8s5C3C8RD
   Y=;
X-CSE-ConnectionGUID: 1EZmtvDkSwifxkjG+gdy7w==
X-CSE-MsgGUID: 6E+5tM1OT1WqOm2NdrAe/Q==
X-IPAS-Result: =?us-ascii?q?A0ABAADHOzVnj5IQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYQaQkiEVYgdhzCCIYt1kiMUgREDV?=
 =?us-ascii?q?g8BAQEPRAQBAYUHAopFAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBRQBAQEBAQE5BQ47hgiGWwIBAyMEUhAlAiYCAisbEAYBEoMBgmUCA?=
 =?us-ascii?q?bBmen8zgQGEe9k4gW2BGi4BiEsBgWyDfTuEPCcbgUlEglCCLYQqg3SCaQSDO?=
 =?us-ascii?q?4JbUnYlgRMCAgIHAoN8g3mZKQk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalx6K?=
 =?us-ascii?q?4EOgRc6Q4E7gSIvGyELXIE3gRoUBhUEgQ5GP4JKaUs6Ag0CNoIkJFmCT4Uah?=
 =?us-ascii?q?G2EZoJULx1AAwsYDUgRLDUGDhsGPQFuB55lRoMyexR/gRQsBSY4klwJAQeDa?=
 =?us-ascii?q?40+gh+fTIQkoVwzqk0eEJhJIqQchGaBZzqBWzMaCBsVgyJSGQ+OKgMNCRaTA?=
 =?us-ascii?q?AG2P0M1OwIHCwEBAwmGS4keYAEB?=
IronPort-Data: A9a23:qoFvmaACzPhguBVW/7zjw5YqxClBgxIJ4kV8jS/XYbTApGlzhj0Pz
 msfWj+EO/6OZGP2f9F+O4+19RkEvcPTyoJiOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWWthh
 fuo+5eDYQb8gGYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEmthcCV0oEY4j5ed5EWJM2
 r8XJCFScUXW7w626OrTpuhEj8AnKozveYgYoHwllWCfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWQHgBfoO3WjPn8RBZ8ll+Cij1H0ciZTrxSeoq9fD237l1wpjei0b4aKEjCMbZt43RuEg
 zvhwz3GGzYfbvqT0xOItUv504cjmgugBdpNT+fnnhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYcXMBVCMU55RuLx66S5ByWbkAHUzRIQN8rrsk7QXotz
 FDht9rvCSZir/6TRG6R+6m8qS60P24eLQcqfSYOQA0Ey8PurIE6klTESdMLOKq0iMDlXDL92
 TaHqAAgiLgJy80GzaO2+RbAmT3Ejp7EUgI4+C3JUW+/qAB0foioY8qv81ez0BpbBI+dSl/Eu
 D0PnNKTqbhfS5qMjyeKBu4KGdlF+sppLhWFrGxqA4cN9A+y+nCzfoJ/oz5yNRh2Z5NslSDSX
 GffvgZY5Zl2NXSsbLNqb4/ZNyjM5fa8fTgCfq6JBueicqRMmBm7EDaCjHN8PlwBcmBwwcnT2
 r/CLa5A6Er274w8k1JaoM9GjdcWKtgWnz+7eHwC503PPUCiTHCUU6wZF1CFc/o06qiJyC2Mr
 I0GapHQlUUPDbSkCsUyzWL1BQ1URZTcLc2nw/G7isbac2KK5Ul4UaaImuJ7E2Cbt/8Fz7yWl
 p1CZqOo4AGi3SKcc1rihoFLY7L0VpE3tmMgISEpJh6p3XNlCbtDH49BH6bbiYIPrbQ5pdYtF
 qFtU5zZXpxnFG+dkxxDNsaVkWCXXEjw7e54F3b+OGBnF3OhLiSVkuLZkvzHr3lSUHHv7pRh8
 tVNFGrzGPI+euirN+6OANrH8r97lSF1dD5aN6cQHuRuRQ==
IronPort-HdrOrdr: A9a23:RhDw9KMddDZzn8BcTsejsMiBIKoaSvp037B87TEWdfU1SL39qy
 nAppgmPHPP5wr5HUtBpTmMAsK9qBDnhPtICOsqXItKBzOWwVdARbsKheGO/9SjIVycygc379
 YDT0ERMrPN5VYTt7ec3DWF
X-Talos-CUID: 9a23:w8EiFGFDcT47aLLEqmI+2XwRBt4JcUbCzXnAIE2XSmllWeKKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AJ+46BgyKpG/1o0OhUMUFXhuw3M6aqPqDSx0RtMw?=
 =?us-ascii?q?hh5C7LAt1YRGRlh26BbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="380581747"
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Nov 2024 23:56:53 +0000
Received: from neescoba-vicdev.cisco.com (neescoba-vicdev.cisco.com [171.70.41.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 498B018000441;
	Wed, 13 Nov 2024 23:56:53 +0000 (GMT)
Received: by neescoba-vicdev.cisco.com (Postfix, from userid 412739)
	id C5339CC128E; Wed, 13 Nov 2024 23:56:52 +0000 (GMT)
From: Nelson Escobar <neescoba@cisco.com>
Date: Wed, 13 Nov 2024 23:56:33 +0000
Subject: [PATCH net-next v4 1/7] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-remove_vic_resource_limits-v4-1-a34cf8570c67@cisco.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731542212; l=19533;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=hrWeRdXAZbogkSLfeHXbAXj699i49M8/2VzfMC2r0zo=;
 b=5zh65VENJHypMD/X7lA60ML16jcRVicTRtK1D9EJWpllO+7XYxuyxWncZnfjlxRLkd8obro+B
 Sln6p+aHZyOAqtP1vX0pqWnpNb1LPpZj/i8Cnh9G41Lq5LarPe3ILXl
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=

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
index 0cc3644ee8554f52401a0be7f44a1475ab2ea2b9..07459eac2592ce5185321a619577404232cfbc2c 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -162,6 +162,17 @@ struct enic_rq_stats {
 	u64 desc_skip;			/* Rx pkt went into later buffer */
 };
 
+struct enic_wq {
+	spinlock_t lock;		/* spinlock for wq */
+	struct vnic_wq vwq;
+	struct enic_wq_stats stats;
+} ____cacheline_aligned;
+
+struct enic_rq {
+	struct vnic_rq vrq;
+	struct enic_rq_stats stats;
+} ____cacheline_aligned;
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


