Return-Path: <netdev+bounces-232371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DAC04C7D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E389435AC03
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC632E9EDF;
	Fri, 24 Oct 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qlkjyxO/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52526ED35
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291699; cv=none; b=B5ahF4+rzNf5xLxk167K3FSxt5Ng9y8/MzccnC83koWHXVIXQLmDBC1j6sxTUKQrqyPw5AUg7SRx9GE7+FbgWzQdzpVdzScJJRcFgjTFMWWwKzZzdqU6HgNdTMm6eYcxY2rQAT8TQozpjvHR5yHkec9n/cUZ9ylJ7fWxi9+wTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291699; c=relaxed/simple;
	bh=ly/m+/EpIdsgFGYRxTQnqaiQYC1jp0N2nQI2+W/5S0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nECgmZZkAYzL1+SklP+UHx+SrsFHh90GASPX92O1pR7KifP6y6cdQjODqZyGkBRIce84xwgeRw/+vSvvf1OMRIhNE5WTidwGdtN5D24jYh6BK7yANKThgerTzXtUKgUrC3dXsOMu/7rk//psqCc8S/YFjedbFNSNOfs2B+KwWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qlkjyxO/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761291693; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WM9DTHdBfzgWZ38Bf1NDNauL/QpcXbOARPaZPxThJwQ=;
	b=qlkjyxO/tNdC3mLtK2pbJAQG5xELW05NZzNFnXbn36nUGp8tQ//bZ2+YZvSe3lvzuSe3lx+eqnuKUJYc/Tw0O8ZDUVzzinE2BHBG4PCZnAnUGSU35XAhQar5Dq4sYvlyopr22nSqosk2t+iLBQS/knjAgUcD5q+phwOolvMsGsE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wqtai5f_1761291692 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 15:41:32 +0800
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
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v3 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Fri, 24 Oct 2025 15:41:30 +0800
Message-Id: <20251024074130.65580-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
References: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: deaf684dfaeb
Content-Transfer-Encoding: 8bit

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a2ade702b369..2b6012bcc57d 100644
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
@@ -217,24 +225,32 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		bool tnl = false;
 		u16 hdr_len = 0;
 
-		/* In certain code paths (such as the af_packet.c receive path),
-		 * this function may be called without a transport header.
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
@@ -419,10 +435,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
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


