Return-Path: <netdev+bounces-233777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C607EC18204
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05F1C4F4989
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0EB2EF652;
	Wed, 29 Oct 2025 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gTpZJUX/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B12ECE9D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707362; cv=none; b=jMHcZkr6l+CO9uwirOB4PVTQG1STcqZGchNpe/tFo21zT8BLndrZaz/uqmoYX20YyfCGNIBIEYV47pOOaPcUK02t0rDdPpn4H96RwOYUqGlQPZJK1Mp1K1FKlRRbeOnawpD6olofMIO1CeRwow7QyHqzs9v93buh8o8eoR9/La8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707362; c=relaxed/simple;
	bh=1YW58QgayFmSUHqzy+TtUzKESlTmy1vvg0HTeLN9ERI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e900gY9DrHGrJcX3Rrf54deaiNYMSBfR82wA16C9lC0r5y8Yumuqh5CCoUXGgTeiGJw3PVOFhWdpanuCSgcsgs8wLYv5E6jt2fY7IGcQKNg7zh8VD508AihxwKi5Sxs2VbF8ZNctMSYzLlvt7TOu5ouXrt9LuSxcCey7fOcqvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gTpZJUX/; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761707358; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1nUoYjEZsh8y791sLMqd3ihWNhyzCLQjeEWSAzDpkX8=;
	b=gTpZJUX/OGpATrsopiKYjCwLLSGEi62ws69bgNV+BPar+fTVKZxlYLfL9GKThnA1c2m0/qk81jwxyMLgzA8VyndcnjNhD0ruRtszEAM2JGcl/Dr7M42YnelAgpxKEPiTFi3I0g9uLkv16Wyio0vCHRUSjOu2WLSpOBxGgjhYVaE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrE9NAP_1761707356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 11:09:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 4/4] virtio-net: correct hdr_len handling for tunnel gso
Date: Wed, 29 Oct 2025 11:09:13 +0800
Message-Id: <20251029030913.20423-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: eb1fbe1c38ee
Content-Transfer-Encoding: 8bit

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

I observed that the "hdr_len" is 116 for this packet:

    17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
        192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
    fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
        192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796

116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6ef0b737d548..46b04816d333 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,6 +207,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
+static inline int virtio_net_tcp_hdrlen(const struct sk_buff *skb, bool tnl)
+{
+	if (tnl)
+		return inner_tcp_hdrlen(skb);
+
+	return tcp_hdrlen(skb);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -217,25 +225,33 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		bool tnl = false;
 		u16 hdr_len = 0;
 
-		/* In certain code paths (such as the af_packet.c receive path),
-		 * this function may be called without a transport header.
-		 * In this case, we do not need to set the hdr_len.
-		 */
-		if (skb_transport_header_was_set(skb))
-			hdr_len = skb_transport_offset(skb);
+		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+				       SKB_GSO_UDP_TUNNEL_CSUM)) {
+			tnl = true;
+			hdr_len = skb_inner_transport_offset(skb);
+
+		} else {
+			/* In certain code paths (such as the af_packet.c receive path),
+			 * this function may be called without a transport header.
+			 * In this case, we do not need to set the hdr_len.
+			 */
+			if (skb_transport_header_was_set(skb))
+				hdr_len = skb_transport_offset(skb);
+		}
 
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
 		if (sinfo->gso_type & SKB_GSO_TCPV4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
 			if (hdr_len)
-				hdr_len += tcp_hdrlen(skb);
+				hdr_len += virtio_net_tcp_hdrlen(skb, tnl);
 		} else if (sinfo->gso_type & SKB_GSO_TCPV6) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
 			if (hdr_len)
-				hdr_len += tcp_hdrlen(skb);
+				hdr_len += virtio_net_tcp_hdrlen(skb, tnl);
 		} else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 			if (hdr_len)
@@ -420,10 +436,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
         vhdr->hash_hdr.hash_report = 0;
         vhdr->hash_hdr.padding = 0;
 
-	/* Let the basic parsing deal with plain GSO features. */
-	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
-	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
 
-- 
2.32.0.3.g01195cf9f


