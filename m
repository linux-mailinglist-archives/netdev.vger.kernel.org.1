Return-Path: <netdev+bounces-237580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A4C4D5D7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760AD1886FC4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0782354AE4;
	Tue, 11 Nov 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ri6iFxC5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0A351FDF
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859548; cv=none; b=cXZMpvxPsX1p8JumH9OVjZYdKcoZGWd3Aj7pE3/IlidxfJ3jO8LjSP+RrvPgfGdqYCmeF7fFIL8DJdjMxnZcOBBYoU/cNCs79n3X9e3ueF3j691LmQsu2FoPeeZeYiQjTb7fjKMoVJrQZhYFQ2gW/lXjOEe8Hk5QnkgorCD73SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859548; c=relaxed/simple;
	bh=QKrLGEqMpIX6F2+C13PujYAUK9wkItB14mX2nA0jTks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHkv0s1RXSje7ovFQm0VVxq1UWYIWlw/fRumth4D7UOEGerQJOiPJFQW1xj3V+X8yNdLLOKO0rI66dJa9v0xBxY7hmwPEDLtmcMmvc24/oeC4QmytDCsmX8sXr7H/EM+q96GJ1CMMyz5oAmM/e88zACbfjf6AkQCbW/pe0e38Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ri6iFxC5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762859536; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZIudUGKGeWaGvoL3nliZIihGbTlmfrlvqzddtIqLUFc=;
	b=Ri6iFxC5Du/RGw1Marb8eY9Y1myz+sRQHTSY0y7a8DMl2/c+EwDg+XsB3BqaAJn8h6s021UB1peV6CiFhlTNAiotO8vFbcrXyUt1K+GLk+uN2io8FjuGeC4wr7zF1F2/qbyRYVcUeIG/dkGu+UUDKLnVCCcztocpGrXT72wlocQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsBStOH_1762859534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 19:12:14 +0800
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
Subject: [PATCH net v5 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Tue, 11 Nov 2025 19:12:12 +0800
Message-Id: <20251111111212.102083-3-xuanzhuo@linux.alibaba.com>
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
 include/linux/virtio_net.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 3cd8b2ebc197..432b17979d17 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -232,12 +232,23 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			return -EINVAL;
 
 		if (hdrlen_negotiated) {
-			hdr_len = skb_transport_offset(skb);
+			if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+					       SKB_GSO_UDP_TUNNEL_CSUM)) {
+				hdr_len = skb_inner_transport_offset(skb);
+
+				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+					hdr_len += sizeof(struct udphdr);
+				else
+					hdr_len += inner_tcp_hdrlen(skb);
+			} else {
+				hdr_len = skb_transport_offset(skb);
+
+				if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+					hdr_len += sizeof(struct udphdr);
+				else
+					hdr_len += tcp_hdrlen(skb);
+			}
 
-			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
-				hdr_len += sizeof(struct udphdr);
-			else
-				hdr_len += tcp_hdrlen(skb);
 		} else {
 			/* This is a hint as to how much should be linear. */
 			hdr_len = skb_headlen(skb);
@@ -421,11 +432,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
         vhdr->hash_hdr.hash_report = 0;
         vhdr->hash_hdr.padding = 0;
 
-	/* Let the basic parsing deal with plain GSO features. */
-	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, hdrlen_negotiated,
 				      vlan_hlen);
-	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
 
-- 
2.32.0.3.g01195cf9f


