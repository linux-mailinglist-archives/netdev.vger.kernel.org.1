Return-Path: <netdev+bounces-237578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CCC4D5CB
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002581885C08
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70A354710;
	Tue, 11 Nov 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WPtcpDgL"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DD351FCB
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859547; cv=none; b=Ffyr5D9S9rsIaQorF/dnSAnAWQ3f1z2SvKTgZS0P6Fis7ZXGA2UrSkAPvOVNkXP1dSNLnSbXwIV5rvQOWPl699gQHrupVZf4fM1pEbqZsNeea6LFZ+gMoXio4Mgk96hrG9D/6G01RpxzH3uYGku4x2EytaGAmM76jIm6i06xgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859547; c=relaxed/simple;
	bh=CYvvWgiTyXdrV7fUFSbOOj3l3H35I5W45ffrx5Lo7aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bm715BPzyj6oZnD8Jt6jNa6fvBhF6kOJGcHu3W5KK3+dKg4vZAZcBfW29PkRSI/achk5LQ5A6Qk8qz48y8+N2PTseuf1Xh/NfpJvmHVJQfvl1MqP5Sb+fyn7lQRVDneBPUUkRefY4b2SKGto/1D3pdYl7UBtB3+POMuAqMKNvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WPtcpDgL; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762859535; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hb8E0LxEopN7KchhuUM3VGcoPrdbUuKOTnH2b0CXl6Y=;
	b=WPtcpDgLxnf4FaAEhiMZHRCQkeWwzfXqepOJulktAPsqg2LSIJaJnwdze8eoz3RFpyguyJ3rhap+hec8f34/wAaaepRmlxihDoeQ9NbFO83z+iNmGBDS1yXjtn6mcvFHIp5IJkP+KNQpFv0Kk+j0KazwjhCC+K3FWRMyPD5mYu0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsBKHX7_1762859533 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 19:12:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Tue, 11 Nov 2025 19:12:11 +0800
Message-Id: <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: feb36a32054d
Content-Transfer-Encoding: 8bit

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This commit fixes that issue.

Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 arch/um/drivers/vector_transports.c |  1 +
 drivers/net/tun_vnet.h              |  4 ++--
 drivers/net/virtio_net.c            |  9 +++++++--
 include/linux/virtio_net.h          | 26 +++++++++++++++++++++-----
 net/packet/af_packet.c              |  5 +++--
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index 0794d23f07cb..03c5baa1d0c1 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -121,6 +121,7 @@ static int raw_form_header(uint8_t *header,
 		vheader,
 		virtio_legacy_is_little_endian(),
 		false,
+		false,
 		0
 	);
 
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 81662328b2c7..0d376bc70dd7 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -214,7 +214,7 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_from_skb(skb, hdr,
 				    tun_vnet_is_little_endian(flags), true,
-				    vlan_hlen)) {
+				    false, vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
 		if (net_ratelimit()) {
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen)) {
+					false, vlan_hlen)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0369dda5ed60..b335c88a8cd6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3317,9 +3317,13 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtio_net_hdr_v1_hash_tunnel *hdr;
-	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
+	bool hdrlen_negotiated;
 	bool can_push;
+	int num_sg;
+
+	hdrlen_negotiated = virtio_has_feature(vi->vdev,
+					       VIRTIO_NET_F_GUEST_HDRLEN);
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
@@ -3339,7 +3343,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
-					virtio_is_little_endian(vi->vdev), 0))
+					virtio_is_little_endian(vi->vdev),
+					hdrlen_negotiated, 0))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..3cd8b2ebc197 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -211,16 +211,15 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
 					  bool has_data_valid,
+					  bool hdrlen_negotiated,
 					  int vlan_hlen)
 {
 	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u16 hdr_len;
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
 		if (sinfo->gso_type & SKB_GSO_TCPV4)
@@ -231,6 +230,21 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
+
+		if (hdrlen_negotiated) {
+			hdr_len = skb_transport_offset(skb);
+
+			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+				hdr_len += sizeof(struct udphdr);
+			else
+				hdr_len += tcp_hdrlen(skb);
+		} else {
+			/* This is a hint as to how much should be linear. */
+			hdr_len = skb_headlen(skb);
+		}
+
+		hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
@@ -384,6 +398,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
+			    bool hdrlen_negotiated,
 			    int vlan_hlen)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
@@ -395,7 +410,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
 		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
-					       vlan_hlen);
+					       hdrlen_negotiated, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
@@ -408,7 +423,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 
 	/* Let the basic parsing deal with plain GSO features. */
 	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
-	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
+	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, hdrlen_negotiated,
+				      vlan_hlen);
 	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 173e6edda08f..6982f4ab1c73 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2093,7 +2093,8 @@ static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
 		return -EINVAL;
 	*len -= vnet_hdr_sz;
 
-	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr, vio_le(), true, 0))
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr,
+				    vio_le(), true, false, 0))
 		return -EINVAL;
 
 	return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
@@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (vnet_hdr_sz &&
 	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
 				    sizeof(struct virtio_net_hdr),
-				    vio_le(), true, 0)) {
+				    vio_le(), true, false, 0)) {
 		if (po->tp_version == TPACKET_V3)
 			prb_clear_blk_fill_status(&po->rx_ring);
 		goto drop_n_account;
-- 
2.32.0.3.g01195cf9f


