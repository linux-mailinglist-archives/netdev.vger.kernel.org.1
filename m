Return-Path: <netdev+bounces-305189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J0UqA2ryS2oOdgEAu9opvQ
	(envelope-from <netdev+bounces-305189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:22:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1DC71472B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b="U 5t9aNF";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=AQ0ibtJV;
	dmarc=pass (policy=none) header.from=fastmail.im;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305189-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305189-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E7183027795
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE343785B;
	Mon,  6 Jul 2026 18:20:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F426436BDA
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:20:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362058; cv=none; b=HhRCwrxSACz8yNDe0ir3VBGn5oBeAgSju+I2dcQ0aqVbzXVpBsiaMfD2RFTaJuhVlUvYRwgBHoWB6E9kwJQOjdcnnVq+0eawEsMh4JGjVjWGGtjZ562ftC6u8J8JXqL3tNVir0vdGWXr7IEOp2aymlG3GqLffXJM1BCbxfvPZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362058; c=relaxed/simple;
	bh=4cLp3Nd9t/h63ncK3R8vGWIBlvjRKzd2ACmlTxtnpx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9pj7edJXzZsKbD6YZ1jpvDLN1vHXCH1gHMCTnT4Acc6gI6O012yjj4KRss53htcEE2wgzdGHNV3qrtizeWFEdxk5YQeeHwqywmxhhTQQuekN4wv0tcx26LXWQs8reRQTWMXi6cM2bLvF0dfFXPOu+TwlYUjfOmhWdO62bpLj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=U5t9aNF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQ0ibtJV; arc=none smtp.client-ip=103.168.172.144
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 577FEEC007B;
	Mon,  6 Jul 2026 14:20:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 14:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1783362056; x=
	1783448456; bh=rZycrF6WDGMO95sKOxHtdI13cNDx2yfbCfkeAW9bNyI=; b=U
	5t9aNF637QchO7tA8ONQRwFmM2RdTzQZ5eFFs8mNkHLHVjrH/Ivm362QRFtG31L0
	wCwPwoZDKtxl3rxqPrH/9qFaDxKI9scWUhIDXSZajehDArbmP055KhYW1nt/9rWn
	kWnlNg1MOWH0njz5bImL/pKnPFRAyLVf0qPjHJfyLqv3rDhBkCTBteRpWhjX1hoL
	8YOoP7c08D3BJuUjHvW/m5qSDMfr1DEQsj8RUHGTRwYT8zlZ8VuR1wXv9BCQAl8j
	8KcsQv/xVXFTLXhJetBgXIefRIWnsjJXlNXTkPeG1NBRn8LzXKHa4kpasInnLtKo
	7QLtTX9ZUcBKMbZwi1ZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783362056; x=1783448456; bh=r
	ZycrF6WDGMO95sKOxHtdI13cNDx2yfbCfkeAW9bNyI=; b=AQ0ibtJVdgfLU+uKo
	9yoXI8uWDImW5Ry3beqcbHmrjkSZ3U4X59s/JdACKhCBpHk3GgwHSNYRwbyCHJR/
	ABMzQyZcsQUWCw4kTR3cqNFuhrcW0V+UF1Yg4DnO4cF4edVyU6nckp959g/zhIKH
	SxBBuHdtGc+71s8ERU/FLP/vJIKiDj+blnnLq7GEGuEll1a48HkPvELggi4Yy3DW
	sX+AfI8Q2TUD2eGPCoi1s4Usye01G6+VWglo9AebA4T/zKmkmFtwitg/N+A7ZXrw
	o5rpFFt82AKHudxI+QYGo7/lfBTC7oQvpk6uMURra/5r76GLDYwffEV7MQBGm8CF
	2/mmg==
X-ME-Sender: <xms:CPJLagoediiQkxo7Vq_SpGXNpzFJsZTMX86MUDbKUsxap0xzIetvtA>
    <xme:CPJLalIEBpajh83SdwgaMsnP9Vp3I9m2JqUU7nZI1nfWTauQaiZ6ebiDvt-EEENCo
    Ygjl_YBGXxgHbfAxLOT82qqgAVHMhKTXCSyQl4TAD8Pm97d2kF29RI>
X-ME-Received: <xmr:CPJLasCeBdburWOIrGtd1yEGX1Vg5sL6HVgaL5Enfdwo338EV4meZT3IylA>
X-ME-Proxy-Cause: dmFkZTGWAUF+cen4EG3lr+JYYAjR5zZiR36XD2CRGTscCjK1QbqrofIn2xy2SquVytavSj
    zheBFuvxjsBzWjnVfhyZNgoVOrvwXtv+KMTWQKRY46jDTcrbN5dTO1L5duAMAhQbbtYosO
    Qe/7LJoUFVOZT3ztREQWobc12AZIzSvCS5z1Gbjl9mWXd+GHg4ekN1BaTcCBVcQQTRtqm1
    l6XWj87fF/OxLh5klubHrHA7M+OysPo1FjlubNFelOAO6GQBXJYlotmMvUueFcKnTg8x/s
    JXrMmLujwm7hlF5vC6nDDDUcbCaNqHz90JVBL2Jj3djFGEo48YWLTiPoTwDfoKMsYE4bKB
    hrNHKVrYDMcBHjc2dA8c7eLY9odeg8QhEYBZn55lZ0f2i5UCa1NJpXo0V4PeMTLD0XuO24
    ery7awyZSM/7d61gDD4rKK05YTHaj7uovuWxyotHLv1ShW6rhqoQU5Hcrj/AMR3r83xBci
    J9qji4cyizOViLka57VFgnx7zdXH9JlHtM5HhopBHFTCJcbaQOTZ8CqoZ3Rokd+zKanHFq
    ujfOJYn0W3QUaNGeDMLSQ1o9fVVEGCQ1AnYrYDGpftKULsMShkEfCcm+SPuDWw7RS/Yv7f
    IvHSNfNO6SUcrJNGIK8IPxLerUbGvQ8AEFCq8rVIjfNJwnBCchoHE1xqmXgA
X-ME-Proxy: <xmx:CPJLan5ja9e3wC30VRMrI6YNc8Ph9Dl6eLWAojti6Sw5CQ6zlWHRdg>
    <xmx:CPJLaoHOQwCvr8-0wxog8FSmXKYzIDAOEQXCekuZ5ALSWBKVbJJy4w>
    <xmx:CPJLaiRRi4F3httadM7xt7Pm1gFPaKX4BnjOFpKhFqEilFRclfWOvg>
    <xmx:CPJLaifqFDd0rUzrO-3fnUKyCHObHXscfviIgMm9Xxv2nR-QoQnG8w>
    <xmx:CPJLaoxX5TwHI4T8F7zM2BX-9S55RB_RBm09uffOT4mCsKiP88XoYGr0>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 14:20:55 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v8 4/9] udp: Support gro_ipv4_max_size > 65536
Date: Mon,  6 Jul 2026 21:19:36 +0300
Message-ID: <20260706181941.385672-5-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181941.385672-1-alice.kernel@fastmail.im>
References: <20260706181941.385672-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[fastmail.im];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fastmail.im:from_mime,fastmail.im:dkim,fastmail.im:mid,isovalent.com:email,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A1DC71472B

From: Alice Mikityanska <alice@isovalent.com>

Currently, gro_max_size and gro_ipv4_max_size can be set to values
bigger than 65536, and GRO will happily aggregate UDP to the configured
size (for example, with TCP traffic in VXLAN tunnels). However,
udp_gro_complete uses the 16-bit length field in the UDP header to store
the length of the aggregated packet. It leads to the packet truncation
later in udp_rcv.

Fix this by storing 0 to the UDP length field and by restoring the real
length from skb->len in udp_rcv. IP GRO already can store 0 to the IP
length field, and iph_totlen()/ipv6_payload_len() are capable of
restoring the real length, because the relevant packets (BIG TCP
tunneled in UDP tunnels) will have skb_is_gso_tcp == true.

Additionally, restrict handling uh->len=0 in udpv6_rcv to BIG TCP and
jumbograms only by using the udp_get_len helper.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c         | 4 ++--
 net/ipv4/udp_offload.c | 4 ++--
 net/ipv6/udp.c         | 4 ++--
 net/ipv6/udp_offload.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cb86124fd963..2b9b55a14758 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2592,8 +2592,8 @@ int udp_rcv(struct sk_buff *skb)
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
-	unsigned short ulen;
 	__be32 saddr, daddr;
+	unsigned int ulen;
 	struct udphdr *uh;
 	bool refcounted;
 	int drop_reason;
@@ -2607,7 +2607,7 @@ int udp_rcv(struct sk_buff *skb)
 		goto drop;		/* No space for header. */
 
 	uh   = udp_hdr(skb);
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len(skb, uh, 0);
 	saddr = ip_hdr(skb)->saddr;
 	daddr = ip_hdr(skb)->daddr;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 493e2b9e16fb..4f9a3922937c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	struct sock *sk;
 	int err;
 
-	udp_set_len_short(uh, newlen);
+	udp_set_len(uh, newlen);
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
@@ -956,7 +956,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8bbd55546b6e..02272466f4c2 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1081,12 +1081,12 @@ INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 	daddr = &ipv6_hdr(skb)->daddr;
 	uh = udp_hdr(skb);
 
-	ulen = ntohs(uh->len);
+	ulen = udp_get_len(skb, uh, 0);
 	if (ulen > skb->len)
 		goto short_packet;
 
 	/* Check for jumbo payload */
-	if (ulen == 0)
+	if (ulen == 0 && inet6_is_jumbogram(skb))
 		ulen = skb->len;
 
 	if (ulen < sizeof(*uh))
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index c92cf5ee3e6a..7370bcb80332 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -171,7 +171,7 @@ int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
-		udp_set_len_short(uh, skb->len - nhoff);
+		udp_set_len(uh, skb->len - nhoff);
 
 		skb_shinfo(skb)->gso_type |= (SKB_GSO_FRAGLIST|SKB_GSO_UDP_L4);
 		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
-- 
2.54.0


