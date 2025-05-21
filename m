Return-Path: <netdev+bounces-192249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F641ABF1BA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C2C8E317C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DBC25FA0F;
	Wed, 21 May 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl33Vb2Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55825F99E
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823647; cv=none; b=CkZ9oI8U3tFn4CGRIt85MqY99qdsK61MgBPk0Z5IHDYn+EbRawJgvCL3w3Gmonu2uCD8QmJXmHvfRazGQyarzBxOWgW0it8ldwpUga3OBGcxNibP+uqpuhpy48F+iYYuUIaiS02U1jq1AGnffQQWMUcizGBX69yd0ybfghqxTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823647; c=relaxed/simple;
	bh=IoY+OzuzQsUCFkuY5fHFRMcFUyISxomeov6nm8Yp2Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWyYvYIDiXSZTNmym7RXfcIBAUGT09vb1pKERawzkHKr3/nfWQBNntj+LPv8ytRw9dA79GiujClIQJX1NvGu1fVSojIbNPWnP5IEV7ElV+x13n1i2vmSx48+jmylhIZ9cmDKrlkjI+uckni0GkEp2N0wV+X1DnIF2MNhHFWLtS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl33Vb2Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbvhNiJdV+20bjxfVF1eZhkZV/9i7/iQF5ji2CXQRi0=;
	b=cl33Vb2ZeFmjBAzDMn6A7HxZCCt/XshUbgGQkFG1EDtluh6e/D3mMCU2FcAq8SGxQ0TfR2
	pb40Fgxaj4zebPolS5SR66M1zgUTxQO+PK3GrbDRdGyniQwHZxOsa5Ek/kHrDyooQkLDA0
	woZeHvuM3uVCTCcbDxkzMAsBHLUCdeU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-QZ0NBcaiPcuwXatjRpRkiA-1; Wed,
 21 May 2025 06:34:02 -0400
X-MC-Unique: QZ0NBcaiPcuwXatjRpRkiA-1
X-Mimecast-MFC-AGG-ID: QZ0NBcaiPcuwXatjRpRkiA_1747823640
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A5BE19560AE;
	Wed, 21 May 2025 10:34:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 545EA195608F;
	Wed, 21 May 2025 10:33:57 +0000 (UTC)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net-next 6/8] virtio_net: enable gso over UDP tunnel support.
Date: Wed, 21 May 2025 12:32:40 +0200
Message-ID: <239bacdac9febd6f604f43fa8571aa2c44fd0f0b.1747822866.git.pabeni@redhat.com>
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If the related virtio feature is set, enable transmission and reception
of gso over UDP tunnel packets.

Most of the work is done by the previously introduced helper, just need
to determine the UDP tunnel features inside the virtio_net_hdr and
update accordingly the virtio net hdr size.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 71a972f20f19b..3ca275ab887fe 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -46,11 +46,6 @@ static bool virtio_is_mapped_offload(unsigned int obit)
 	       obit <= VIRTIO_OFFLOAD_MAP_MAX;
 }
 
-#define VIRTIO_FEATURE_TO_OFFLOAD(fbit)	\
-	({								\
-		unsigned int __f = fbit;				\
-		__f >= VIRTIO_FEATURES_MAP_MIN ? __f - VIRTIO_O2F_DELTA : __f; \
-	})
 #define VIRTIO_OFFLOAD_TO_FEATURE(obit)	\
 	({								\
 		unsigned int __o = obit;				\
@@ -85,16 +80,30 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
 	VIRTIO_NET_F_GUEST_USO6,
-	VIRTIO_NET_F_GUEST_HDRLEN
+	VIRTIO_NET_F_GUEST_HDRLEN,
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED,
+#endif
 };
 
-#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
+#define __GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
 				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
 				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_USO6))
 
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+
+#define GUEST_OFFLOAD_GRO_HW_MASK (__GUEST_OFFLOAD_GRO_HW_MASK | \
+	(1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED) | \
+	(1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED))
+#else
+
+#define GUEST_OFFLOAD_GRO_HW_MASK __GUEST_OFFLOAD_GRO_HW_MASK
+#endif
+
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
 	size_t offset;
@@ -443,9 +452,14 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
+	/* UDP tunnel support*/
+	u8 tnl_offset;
+
 	/* Work struct for delayed refilling if we run low on memory. */
 	struct delayed_work refill;
 
+	bool rx_tnl_csum;
+
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
@@ -2538,12 +2552,19 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
 		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
 
-	if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	/* restore the received value */
+	hdr->hdr.flags = flags;
+	if (virtio_net_chk_data_valid(skb, &hdr->hdr, vi->rx_tnl_csum)) {
+		net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: %x\n",
+				     dev->name, hdr->hdr.flags,
+				     hdr->hdr.gso_type);
+		goto frame_err;
+	}
 
-	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
-				  virtio_is_little_endian(vi->vdev))) {
-		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
+	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->hdr, vi->tnl_offset,
+				      vi->rx_tnl_csum,
+				      virtio_is_little_endian(vi->vdev))) {
+		net_warn_ratelimited("%s: bad gso: type: %x, size: %u\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size);
 		goto frame_err;
@@ -3276,9 +3297,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	else
 		hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
 
-	if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
-				    virtio_is_little_endian(vi->vdev), false,
-				    0))
+	if (virtio_net_hdr_tnl_from_skb(skb, &hdr->hdr, vi->tnl_offset,
+					virtio_is_little_endian(vi->vdev), 0))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
@@ -6782,10 +6802,20 @@ static int virtnet_probe(struct virtio_device *vdev)
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
 
@@ -6886,6 +6916,16 @@ static int virtnet_probe(struct virtio_device *vdev)
 	else
 		vi->hdr_len = sizeof(struct virtio_net_hdr);
 
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
+	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
+		vi->tnl_offset = vi->hdr_len;
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
+		vi->rx_tnl_csum = true;
+	if (vi->tnl_offset)
+		vi->hdr_len += sizeof(struct virtio_net_hdr_tunnel);
+#endif
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
@@ -7196,6 +7236,12 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
+#ifdef VIRTIO_HAS_EXTENDED_FEATURES
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
+#endif
 };
 
 static unsigned int features_legacy[] = {
-- 
2.49.0


