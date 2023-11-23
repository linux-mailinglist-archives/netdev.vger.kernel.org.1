Return-Path: <netdev+bounces-50641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF77F6673
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98FA283BEC
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E9154A8;
	Thu, 23 Nov 2023 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itGC73JY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1AC1AE
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700764780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZcj6fHanb3mUK8r75E4vy8tt1GEMX0UQXL1edeKG8c=;
	b=itGC73JYmFVzOx/WryjQAWF+sr0rOoDrreTSsu/NgrF9kCuBoVhCVkhNy/WaqCCvOyy/El
	Xxp53y2IhJac/gSgVhpAiOB81kVvjRjEBVpDS0YHnG6xJyogAPu2wdsQ7vfMky4YMYNJ7A
	qBA1HLfrsUlH/pu+/fHTd55CgHtC5JM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-cTUNmn_TOK-r0VEDioyo3w-1; Thu, 23 Nov 2023 13:39:36 -0500
X-MC-Unique: cTUNmn_TOK-r0VEDioyo3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB341185A782;
	Thu, 23 Nov 2023 18:39:35 +0000 (UTC)
Received: from mpattric.remote.csb (unknown [10.22.33.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40B7C5028;
	Thu, 23 Nov 2023 18:39:35 +0000 (UTC)
From: Mike Pattrick <mkp@redhat.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Mike Pattrick <mkp@redhat.com>
Subject: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when virtio_net_hdr is enabled
Date: Thu, 23 Nov 2023 13:38:35 -0500
Message-Id: <20231123183835.635210-1-mkp@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Af_packet provides checksum offload offsets to usermode applications
through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on the
socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
af_packet will include the link level header and so csum_start needs
to be adjusted accordingly.

Fixes: fd3a88625844 ("net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload holds vlan")
Signed-off-by: Mike Pattrick <mkp@redhat.com>
---
 net/packet/af_packet.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..f6b602ffe383 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2092,15 +2092,23 @@ static unsigned int run_filter(struct sk_buff *skb,
 }
 
 static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
-			   size_t *len, int vnet_hdr_sz)
+			   size_t *len, int vnet_hdr_sz,
+			   const struct sock *sk)
 {
 	struct virtio_net_hdr_mrg_rxbuf vnet_hdr = { .num_buffers = 0 };
+	int vlan_hlen;
 
 	if (*len < vnet_hdr_sz)
 		return -EINVAL;
 	*len -= vnet_hdr_sz;
 
-	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr, vio_le(), true, 0))
+	if (sk->sk_type == SOCK_RAW && skb_vlan_tag_present(skb))
+		vlan_hlen = VLAN_HLEN;
+	else
+		vlan_hlen = 0;
+
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr,
+				    vio_le(), true, vlan_hlen))
 		return -EINVAL;
 
 	return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
@@ -2368,13 +2376,21 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		__set_bit(slot_id, po->rx_ring.rx_owner_map);
 	}
 
-	if (vnet_hdr_sz &&
-	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
-				    sizeof(struct virtio_net_hdr),
-				    vio_le(), true, 0)) {
-		if (po->tp_version == TPACKET_V3)
-			prb_clear_blk_fill_status(&po->rx_ring);
-		goto drop_n_account;
+	if (vnet_hdr_sz) {
+		int vlan_hlen;
+
+		if (sk->sk_type == SOCK_RAW && skb_vlan_tag_present(skb))
+			vlan_hlen = VLAN_HLEN;
+		else
+			vlan_hlen = 0;
+
+		if (virtio_net_hdr_from_skb(skb, h.raw + macoff -
+					    sizeof(struct virtio_net_hdr),
+					    vio_le(), true, vlan_hlen)) {
+			if (po->tp_version == TPACKET_V3)
+				prb_clear_blk_fill_status(&po->rx_ring);
+			goto drop_n_account;
+		}
 	}
 
 	if (po->tp_version <= TPACKET_V2) {
@@ -3464,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	packet_rcv_try_clear_pressure(pkt_sk(sk));
 
 	if (vnet_hdr_len) {
-		err = packet_rcv_vnet(msg, skb, &len, vnet_hdr_len);
+		err = packet_rcv_vnet(msg, skb, &len, vnet_hdr_len, sk);
 		if (err)
 			goto out_free;
 	}
-- 
2.40.1


