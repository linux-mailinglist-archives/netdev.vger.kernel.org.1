Return-Path: <netdev+bounces-195423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE12AD016A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31697189A7EF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD12882DC;
	Fri,  6 Jun 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNZMoRot"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E35288C2D
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210416; cv=none; b=QLxnn5GkiD4pEdVBz9NiAyjkrRe0AR2WQI2/nEG0kdjEA5ZgShLWWZCBrXnevRlOph+f2fXCbe2f3fcRrsr9uMEiUiMntrUZnjRwG4zgXCQro21IHIfVqeyCxB55G9N4FCEWC1WHu0aAnQJSPbCV1laee+OTTfHvpDN0L7LiZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210416; c=relaxed/simple;
	bh=k78fdh+JX0qZ7oL3anZuTraspskhqPk+ALraycKUKag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1ZdEDu8IS0VhWywehBTLwCjo/u3RqiPSIo7n1Zie+ZL5ddRts0f2l3QjzJFpRNqKo6RrWIaUBpB8WOHc/r9kSCo0hfmoBz/Gk7kbv2VHskCIu+oZROWureulKP7OZCTi6vqsMDbdrW6juNje/O0W56YF0OCF+e19YPVCy5GhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNZMoRot; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqPHgs9Sb3HKsMstBx1AdHleGKJRprwnnfHPHhVV4r8=;
	b=VNZMoRotbaZWiL2mqf+XvkUWaCK8+2MYxjvT+6DzXg9qpKdBIGoPd6uylfauEfkooMRB2K
	/URdM/A3rcMNPnO3ZY5vn+ntmc49J5WiO7lnJkwu8cTFPS9Q2SStlMenWQbJZxRFh6Xaqh
	jKFdnPsnlicgpZCmfYc8cMVsNbJ7eow=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-yucsw4IbPCe-3tJ9b3saDg-1; Fri,
 06 Jun 2025 07:46:50 -0400
X-MC-Unique: yucsw4IbPCe-3tJ9b3saDg-1
X-Mimecast-MFC-AGG-ID: yucsw4IbPCe-3tJ9b3saDg_1749210409
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F9C81800871;
	Fri,  6 Jun 2025 11:46:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.1])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA96818002B5;
	Fri,  6 Jun 2025 11:46:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RFC v3 6/8] virtio_net: enable gso over UDP tunnel support.
Date: Fri,  6 Jun 2025 13:45:43 +0200
Message-ID: <d10b01bd14473ad95fb8d7f83ab1cd7c40c2a10e.1749210083.git.pabeni@redhat.com>
In-Reply-To: <cover.1749210083.git.pabeni@redhat.com>
References: <cover.1749210083.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If the related virtio feature is set, enable transmission and reception
of gso over UDP tunnel packets.

Most of the work is done by the previously introduced helper, just need
to determine the UDP tunnel features inside the virtio_net_hdr and
update accordingly the virtio net hdr size.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - drop the VIRTIO_HAS_EXTENDED_FEATURES conditionals

v1 -> v2:
  - test for UDP_TUNNEL_GSO* only on builds with extended features support
  - comment indentation cleanup
  - rebased on top of virtio helpers changes
  - dump more information in case of bad offloads
---
 drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 18ad50de4928..0b234f318e39 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -78,15 +78,19 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
 	VIRTIO_NET_F_GUEST_USO6,
-	VIRTIO_NET_F_GUEST_HDRLEN
+	VIRTIO_NET_F_GUEST_HDRLEN,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED,
 };
 
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
-				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
-				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
-				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
-				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
-				(1ULL << VIRTIO_NET_F_GUEST_USO6))
+			(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
+			(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
+			(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
+			(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
+			(1ULL << VIRTIO_NET_F_GUEST_USO6) | \
+			(1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) | \
+			(1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED))
 
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
@@ -436,9 +440,14 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
+	/* UDP tunnel support */
+	u8 tnl_offset;
+
 	/* Work struct for delayed refilling if we run low on memory. */
 	struct delayed_work refill;
 
+	bool rx_tnl_csum;
+
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
@@ -2531,14 +2540,22 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
 		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
 
-	if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	/* restore the received value */
+	hdr->hdr.flags = flags;
+	if (virtio_net_chk_data_valid(skb, &hdr->hdr, vi->rx_tnl_csum)) {
+		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x rx_tnl_csum %d\n",
+				     dev->name, hdr->hdr.flags,
+				     hdr->hdr.gso_type, vi->rx_tnl_csum);
+		goto frame_err;
+	}
 
-	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
-				  virtio_is_little_endian(vi->vdev))) {
-		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
+	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->hdr, vi->tnl_offset,
+				      vi->rx_tnl_csum,
+				      virtio_is_little_endian(vi->vdev))) {
+		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
-				     hdr->hdr.gso_size);
+				     hdr->hdr.gso_size, hdr->hdr.flags,
+				     vi->tnl_offset, vi->rx_tnl_csum);
 		goto frame_err;
 	}
 
@@ -3269,9 +3286,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	else
 		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
 
-	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
-				    virtio_is_little_endian(vi->vdev), false,
-				    0))
+	if (virtio_net_hdr_tnl_from_skb(skb, &hdr->hdr, vi->tnl_offset,
+					virtio_is_little_endian(vi->vdev), 0))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
@@ -6775,10 +6791,20 @@ static int virtnet_probe(struct virtio_device *vdev)
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
 			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
+			dev->hw_features |= NETIF_F_GSO_UDP_TUNNEL;
+			dev->hw_enc_features = dev->hw_features;
+		}
+		if (dev->hw_features & NETIF_F_GSO_UDP_TUNNEL &&
+		    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM)) {
+			dev->hw_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
+			dev->hw_enc_features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
+		}
+
 		dev->features |= NETIF_F_GSO_ROBUST;
 
 		if (gso)
-			dev->features |= dev->hw_features & NETIF_F_ALL_TSO;
+			dev->features |= dev->hw_features;
 		/* (!csum && gso) case will be fixed by register_netdev() */
 	}
 
@@ -6879,6 +6905,14 @@ static int virtnet_probe(struct virtio_device *vdev)
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+		vi->tnl_offset = vi->hdr_len;
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
+		vi->rx_tnl_csum = true;
+	if (vi->tnl_offset)
+		vi->hdr_len += sizeof(struct virtio_net_hdr_tunnel);
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -7189,6 +7223,10 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
 };
 
 static unsigned int features_legacy[] = {
-- 
2.49.0


