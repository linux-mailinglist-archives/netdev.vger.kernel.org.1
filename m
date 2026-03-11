Return-Path: <netdev+bounces-266625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L86MgRYsWmGtwIAu9opvQ
	(envelope-from <netdev+bounces-266625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:54:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ED126336C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D6ED301E3E4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C963DE423;
	Wed, 11 Mar 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MOT4Y9Js"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DF3D9035
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230062; cv=none; b=VsndsxQp9ICWBCDpVLhjM2EyD3hx/CE2tci9L+5MYnHZ6EQVW5+Coojl1a8FvK/hJyW/TkbtDukSInUSj6VbPuiHmNsEcmqrS1XZ0eMUKpXUjyqd6J0/VY+pVtJ16byU4o8ItLTQY0RShs+CSzYcaDnVUNfp2otaNgkx4kEpAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230062; c=relaxed/simple;
	bh=nFFcO2cjSFilSh0gdxu3xt5JV+ZSzRo+Bg1sSuCKN8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYDujqTlJvj2GRj2L/i3lnzAbOjBxaOYgBz3b7Y+YkkM7Y1LHtnHhBQmyASfmXch7pCsX4G7dlKAD5pTRqvDLGWsr/MhhZvegTebSp8314c0R3ziljUPZhofQcM8+I/dUMoaMeBT8DYN0zBEjHiAsscxB/s3ctq/ctQBEzktBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MOT4Y9Js; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773230058; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j7lZTkK3C5F7Pd+Y07T3lUUGjG3+7QGV13ZA0xLtcF0=;
	b=MOT4Y9JsWlNciA0uitjs82YNLr8ScOFq62uh3oQWWBQ4O9AXiNiR36KZD5mIx+ajJw5EzplQ6WB2UapJArUnUpZ38mzNeRyTStvPkzKGW1qiyUi4z3CXrdNV6RD3SSPo7mR20aiuQCfMR42CDx05TGulOhCBW9eV5AKgfeuvnAQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-k-jU8_1773230056 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 19:54:16 +0800
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
Subject: [PATCH net v9 2/2] virtio-net: correct hdr_len handling for tunnel gso
Date: Wed, 11 Mar 2026 19:54:14 +0800
Message-Id: <20260311115414.31243-3-xuanzhuo@linux.alibaba.com>
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
X-Rspamd-Queue-Id: 27ED126336C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266625-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email]
X-Rspamd-Action: no action

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
 include/linux/virtio_net.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 48de4a16a96a..0fe69876d839 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -223,6 +223,21 @@ static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
 	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
 }
 
+static inline void virtio_net_set_tnl_hdrlen(const struct sk_buff *skb,
+					     struct virtio_net_hdr *hdr)
+{
+	u16 hdr_len;
+
+	hdr_len = skb_inner_transport_offset(skb);
+
+	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		hdr_len += sizeof(struct udphdr);
+	else
+		hdr_len += inner_tcp_hdrlen(skb);
+
+	hdr->hdr_len = cpu_to_le16(hdr_len);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -439,6 +454,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (ret)
 		return ret;
 
+	if (feature_hdrlen && hdr->hdr_len)
+		virtio_net_set_tnl_hdrlen(skb, hdr);
+
 	if (skb->protocol == htons(ETH_P_IPV6))
 		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
 	else
-- 
2.32.0.3.g01195cf9f


