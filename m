Return-Path: <netdev+bounces-266627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIsAFCxYsWmGtwIAu9opvQ
	(envelope-from <netdev+bounces-266627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:55:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A8263390
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444303112BEB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF33DCD87;
	Wed, 11 Mar 2026 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JpAISn0S"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9863D9035
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230067; cv=none; b=dBas2dl7xWOt1A9DSe4qxc1qenN+ZXYQTeEkxIm/L0+PT6IlZS957UvZYnfLvTY5t89V0tbHliOiFeXIPOtpxX9guMftT1e+dfvRr3sgtgYiYJuaVZEUur8/4XLEbRgwa1SkiLlSXcGKrPeBGe2shblLkqUrnQC2HsToHua4fkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230067; c=relaxed/simple;
	bh=t5Cj9Hjao+ATei27nDWwiyDKCHRpoeswz0HbhQvSCjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekLmVlUvZfnWvdDTJy6kHmt71RNimOfUYBvA54teUJas9YNbaeCk3Nn2dzF3VIB8OVk+B3bZKcNoadOis37EZKTLbEzTMxuGTFujnsWQ7a7A++YvYxc/P0Hfd8ta+FUfTWWWw9n5N8CVtemxv9USXIrALcM5ut6yf6c5gY/67oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JpAISn0S; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773230057; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eTaVkesOnz00TagXXUlebaD5E34dJ6Qyn5C7uPARsVA=;
	b=JpAISn0SHGaW8dsqkYQcMmT8DwIKN1yZUy4zt3MJzmQyX9E/g3AanfyElUW+LyW47OEOOuNcz/5lfnVw8Cf96kGjHGP3Ujo/TzU2cOpU+8QteOVx5zBnysMvm61se8Hyps4zW7Hocr2omTt0+6QRd2kSBJ8LKhsa6oGBMcbdqa8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-jzDbv_1773230055 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 19:54:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v9 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 11 Mar 2026 19:54:13 +0800
Message-Id: <20260311115414.31243-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260311115414.31243-1-xuanzhuo@linux.alibaba.com>
References: <20260311115414.31243-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: e88adc2e5a2a
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD1A8263390
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266627-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,resnulli.us,solid-run.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Action: no action

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
 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 +++++-
 include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index a5f93b6c4482..fa5cab9d3e55 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen, true)) {
+					vlan_hlen, true, false)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..7106333ef904 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	struct virtio_net_hdr_v1_hash_tunnel *hdr;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
+	bool feature_hdrlen;
 	bool can_push;
 
+	feature_hdrlen = virtio_has_feature(vi->vdev,
+					    VIRTIO_NET_F_GUEST_HDRLEN);
+
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
 	/* Make sure it's safe to cast between formats */
@@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
 					virtio_is_little_endian(vi->vdev), 0,
-					false))
+					false, feature_hdrlen))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 75dabb763c65..48de4a16a96a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
+static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
+					 struct virtio_net_hdr *hdr,
+					 bool little_endian)
+{
+	u16 hdr_len;
+
+	hdr_len = skb_transport_offset(skb);
+
+	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		hdr_len += sizeof(struct udphdr);
+	else
+		hdr_len += tcp_hdrlen(skb);
+
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
 			    int vlan_hlen,
-			    bool has_data_valid)
+			    bool has_data_valid,
+			    bool feature_hdrlen)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
-	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
-					       has_data_valid, vlan_hlen);
+	if (!tnl_gso_type) {
+		ret = virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					      has_data_valid, vlan_hlen);
+		if (ret)
+			return ret;
+
+		if (feature_hdrlen && hdr->hdr_len)
+			virtio_net_set_hdrlen(skb, hdr, little_endian);
+
+		return ret;
+	}
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.32.0.3.g01195cf9f


