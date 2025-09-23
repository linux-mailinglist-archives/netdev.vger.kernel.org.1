Return-Path: <netdev+bounces-225717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F16AB977D1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3025619C85A7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557B30FC2D;
	Tue, 23 Sep 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HBvkmu2x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4430FC0B
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659005; cv=none; b=L4Y+/63vSTiEQ7zLCh98ttVWEVoZ5mqaeSWPz6vSggrEDIdj+MoPNX17/SbmzwvxyF80wAw6ToEYppR/bje7etM9bglt9MipS1tAsiErhOSL6Jn188vTFeCmfKcMmQbfO4769NJLzHorxt6Hz01ZltvcaL9V1o+pBm0XhVsUZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659005; c=relaxed/simple;
	bh=IceakvOaggMPUYsKLAdHdeVuyQMjc5l28+Stg3yh6XI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMWaKjVVLb8piBS4ebFZk6zL1k1sUMvfdnuMZRNAD7OjZw6WlLfD2yJ8XjsGJir4CYXDwPiDCJO+y+LlI4EuaaGOaaKmdejUlwm/RpYOupX2/8hpjXkefgPw+v28aBWE2eWJmRqTE3r1l4jLT+ooCM8Ebs/MRmvK3q60Z0QY24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HBvkmu2x; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NIm13U016712;
	Tue, 23 Sep 2025 13:23:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	8+MIe6TP86YLoOoNB1Vg1heguvOxIanTKUSmx1Po/w=; b=HBvkmu2xB8KPGqgnP
	GRoOWinlGIhwNQ6xbXo6XHdq7FQjEAqUbZxQLO+zjSQlI8aTpZ5/M2/Tq1Jw7bia
	lsuneqjX5yo2hWCs4pAVFt2jilLMGV71QA7QcB3x+fZkeaaLLHnV300XcjOthf5z
	TMQz9UNQib/UUdetvmZ11rWBB/szURURf6DxXB49HLQWen+QQOQHP/TD9wWBcFfT
	NjIVmQ2Oudo/PKeYqtWdjBbwCDrcelEGuYy2rYh8v7JVE7mFiBPzcAjhdU0AB6u/
	UK6zMF36FnZmeib3tMEtORLVakKDQyhYCrpf9G6az423L5LuDJLdKp1rJd268aOs
	4ApAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49bg5raew9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 13:23:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 13:23:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 13:23:11 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id D3D473F7064;
	Tue, 23 Sep 2025 13:23:07 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v1 net-next  2/3] virtio_net: enable outer nw header offset support.
Date: Wed, 24 Sep 2025 01:52:57 +0530
Message-ID: <20250923202258.2738717-3-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923202258.2738717-1-kshankar@marvell.com>
References: <20250923202258.2738717-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDIyNyBTYWx0ZWRfX6Jj+cPteZS9K AwJveTZgiCkwzWZXI6Ys81WqlDPfsrWHsY9zqpTLys1e5clp/izYSB17MSNlu+Gc4yVCDCkW2I5 veCs1IfhcrT7KC2zQVtiCMAsXtRmdgUFRUt0Gom7z/YSuTiGoE+7ZR1mWGkCRQN6YuhoMgoQPMV
 cxXDnwjEpN8s6cID65SAfqUdFpbkYpiROBZnEJAaHX9KErItv7dIMXBEZrqeTU1rakPvy+xdtgq 7UQW+M+sAFbyH/9Tzmg8VH0iZBYRtdgzNgNdyQs+5C9UUZXh/B8toT1N01zK4beqDeZ3ERcJjF3 oewqONeKjIjR6i/wM5Cr4i4ZlQoUoISme44xzuP8zPCs4B257gWTQf2HvD0m6CpCiAJzGL8qz4J 3q/44oY9
X-Proofpoint-GUID: EnV0dLgnd2wti4VQu-tibnhtk4BT0LUh
X-Authority-Analysis: v=2.4 cv=D8hHKuRj c=1 sm=1 tr=0 ts=68d301b0 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=jGR1pZPCcwd-RLdNFkEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EnV0dLgnd2wti4VQu-tibnhtk4BT0LUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01

If outer network header feature is set, update header offset
in ingress and egress path.

If feature is not set, reset header offset to zero.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7da5a37917e9..0b60cbbb3d33 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -451,6 +451,9 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
+	/* Outer network header support */
+	bool out_net_hdr_negotiated;
+
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
@@ -511,6 +514,7 @@ struct virtio_net_common_hdr {
 		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
 		struct virtio_net_hdr_v1_hash hash_v1_hdr;
 		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
+		struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr out_net_hdr;
 	};
 };
 
@@ -2576,8 +2580,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	hdr->hdr.flags = flags;
 	if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csum)) {
 		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csum %d\n",
-				     dev->name, hdr->hdr.flags,
-				     hdr->hdr.gso_type, vi->rx_tnl_csum);
+				dev->name, hdr->hdr.flags,
+				hdr->hdr.gso_type, vi->rx_tnl_csum);
 		goto frame_err;
 	}
 
@@ -2591,6 +2595,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 		goto frame_err;
 	}
 
+	virtio_net_out_net_header_to_skb(skb, &hdr->out_net_hdr, vi->out_net_hdr_negotiated,
+					 virtio_is_little_endian(vi->vdev));
 	skb_record_rx_queue(skb, vq2rxq(rq->vq));
 	skb->protocol = eth_type_trans(skb, dev);
 	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
@@ -3317,6 +3323,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	else
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
+	virtio_net_out_net_header_from_skb(skb, &skb_vnet_common_hdr(skb)->out_net_hdr,
+					   vi->out_net_hdr_negotiated,
+					   virtio_is_little_endian(vi->vdev));
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
 					virtio_is_little_endian(vi->vdev), 0))
 		return -EPROTO;
@@ -6915,8 +6924,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_OUT_NET_HEADER))
+		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr);
+	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
+		 virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
 	else if (vi->has_rss_hash_report)
 		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
@@ -6933,6 +6944,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
 		vi->tx_tnl = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_OUT_NET_HEADER))
+		vi->out_net_hdr_negotiated = true;
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -7247,6 +7261,7 @@ static unsigned int features[] = {
 	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
 	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
 	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
+	VIRTIO_NET_F_OUT_NET_HEADER,
 };
 
 static unsigned int features_legacy[] = {
-- 
2.48.1


