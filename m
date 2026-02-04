Return-Path: <netdev+bounces-256580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbrMoragmnkcwMAu9opvQ
	(envelope-from <netdev+bounces-256580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:35:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA1E202D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2DA330CBBE2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506E1C84DE;
	Wed,  4 Feb 2026 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrBVbzlu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF704369A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183026; cv=none; b=me8iOcmhrmzGizpQ3bI3/wZufGJ0JvXw3ThlFf26I8kQSJ5p2ZohNrZrJnyXf/bntqUAhb1pfUH4yFM6mgJNFdLRMqDO/dES1glgM/pHLCjd5ObHCpZVmIi2T11l1pDJeDGc+gG+5bmqeG3/Fq2unONG7KzVvrTHpd7eenCDpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183026; c=relaxed/simple;
	bh=m7bVyaWApKiZyRELm+eerrwnMDzU6w/ZZ2jiVpjG05I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fesA443GnBNk4Mlen8J/hephe/1iWMAVwfCgaK/+5AfOGLmcFFDCOmdsAfUdlYkBzKlDbB8tZVa/oLL6EtpatkY852RsqplBk+dE8URx855Zy+mZMqOHIq00/4Nc7HBQz8ADi5AKwD3ZoN0Lkw3aROa2PnWgJ/BNd/vPNfA5pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrBVbzlu; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6ae763d03so675433485a.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770183025; x=1770787825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9Tf+UsOO5j6sl1HmJrGgFZsBykAC5n9UJPqtV0YJ/c=;
        b=MrBVbzluFOrg4x+GSCBdcU89NFk2RIgJTvdnEI9/Cl9LqqYthFAUHgOrPb2EsXMxAV
         kLRIjDn93SIH0ku0hVewez+0YNSbbwKlOX9VJFvI/uYUBW0UdSYte/xkGGOGDbrzYjJj
         DuLCT88fTwTiYFTUiAspHYGpd8qTLJJAQxDv4pyvu2+Wp9J0SfwxtEM1vYiO8h6X1Rms
         I9Oya8i7Keqc7xVLJpWF2gVv0agYy2q1wVACc7h3W6qclYC/3BEQpaCdwLd6zolPp8/m
         3MJXEML9MLEESfQzXthFCTJDOcNeyzNCXmF/FQWsJItkAPd/NY+L9iGVZeCR3sthA62B
         QrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770183025; x=1770787825;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9Tf+UsOO5j6sl1HmJrGgFZsBykAC5n9UJPqtV0YJ/c=;
        b=a2GWPJJaDvEigLNFbQdrLpVyWfJYgahXIF4dsvnD6e7wNTfL8yZ+WJoIi1DGUy76Ml
         k0XByaP4UAgUQtZfLVWHfnTVB7vtm8bKmrTsjIHzVjurx2h3gXIC4+HN/YVxonHM61UW
         4G3JRts4plPI+tzKfy8o9vjlI2HKGwreQM9xiBPhrS6XWJGlkWPb6CazkHAY+x8wxi+L
         KrYCJWF1eNrr1jac3OrzzqCsX4PK5Sie7GwxwTyym784T5Wfnc19Fg0uvBT/a+pxKHUd
         QQ0kn9mb9HrWEmy4AE4dyrXYbIDS+/JLBGczvmQrlWwhN/urrwosrggaVSCNqhKCLvf3
         Q0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXraSYIe8sKPntwEL2JVbl/gONu+cxLRg6Ud33WC8tSL+dOfQdQEsh9hObvXPYBGzuXuICqmiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEfv1ZhWLqdxivUTGvPdIsgx5NEnEfNP+SQv4o8HHufd7Bqbi
	rF8XQdkOAMaGgURD76pm1fGjGJopfGXrZO50VzTEk3zCtwsFXhGDfm2YNF8axrdmUNiNw1AP+q9
	0nz1RuLeUXB2jeQ==
X-Received: from qkan21.prod.google.com ([2002:a05:620a:a715:b0:8c6:8f5f:57b7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7118:b0:8c7:f79:bd7b with SMTP id af79cd13be357-8ca2f82e400mr223038885a.9.1770183024731;
 Tue, 03 Feb 2026 21:30:24 -0800 (PST)
Date: Wed,  4 Feb 2026 05:30:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204053023.1622775-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: add vlan_get_protocol_offset_inline() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 29FA1E202D
X-Rspamd-Action: no action

skb_protocol() is bloated, and forces slow stack canaries in many
fast paths.

Add vlan_get_protocol_offset_inline() which deals with the non-vlan
common cases.

__vlan_get_protocol_offset() is now out of line.

It returns a vlan_type_depth struct to avoid stack canaries in callers.

struct vlan_type_depth {
       __be16 type;
       u16 depth;
};

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 0/22 up/down: 0/-6320 (-6320)
Function                                     old     new   delta
vlan_get_protocol_dgram                       61      59      -2
__pfx_skb_protocol                            16       -     -16
__vlan_get_protocol_offset                   307     273     -34
tap_get_user                                1374    1207    -167
ip_md_tunnel_xmit                           1625    1452    -173
tap_sendmsg                                  940     753    -187
netif_skb_features                          1079     866    -213
netem_enqueue                               3017    2800    -217
vlan_parse_protocol                          271      50    -221
tso_start                                    567     344    -223
fq_dequeue                                  1908    1685    -223
skb_network_protocol                         434     205    -229
ip6_tnl_xmit                                2639    2409    -230
br_dev_queue_push_xmit                       474     236    -238
skb_protocol                                 258       -    -258
packet_parse_headers                         621     357    -264
__ip6_tnl_rcv                               1306    1039    -267
skb_csum_hwoffload_help                      515     224    -291
ip_tunnel_xmit                              2635    2339    -296
sch_frag_xmit_hook                          1582    1233    -349
bpf_skb_ecn_set_ce                           868     457    -411
IP6_ECN_decapsulate                         1297     768    -529
ip_tunnel_rcv                               2121    1489    -632
ipip6_rcv                                   2572    1922    -650
Total: Before=24892803, After=24886483, chg -0.03%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: changed type_depth to vlan_type_depth (Jakub suggestion)
    added Simon's Reviewed-by: (Thanks Simon !)
v1: https://lore.kernel.org/netdev/20260202082200.650516-1-edumazet@google.com/

 include/linux/if_vlan.h | 51 ++++++++++++++++++-----------------------
 net/core/skbuff.c       | 36 +++++++++++++++++++++++++++++
 net/packet/af_packet.c  |  5 ++--
 3 files changed, 61 insertions(+), 31 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index f7f34eb15e068785e464303b60f2f050b3bec0ec..e6272f9c5e42cc8023e8ece45e5c7a6eed5338e0 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -594,8 +594,17 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 	}
 }
 
+struct vlan_type_depth {
+	__be16 type;
+	u16 depth;
+};
+
+struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
+						  __be16 type,
+						  int mac_offset);
+
 /**
- * __vlan_get_protocol_offset() - get protocol EtherType.
+ * vlan_get_protocol_offset_inline() - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
  * @mac_offset: MAC offset
@@ -604,40 +613,24 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * Returns: the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
-						__be16 type,
-						int mac_offset,
-						int *depth)
+static inline
+__be16 vlan_get_protocol_offset_inline(const struct sk_buff *skb,
+				       __be16 type,
+				       int mac_offset,
+				       int *depth)
 {
-	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
-
-	/* if type is 802.1Q/AD then the header should already be
-	 * present at mac_len - VLAN_HLEN (if mac_len > 0), or at
-	 * ETH_HLEN otherwise
-	 */
 	if (eth_type_vlan(type)) {
-		if (vlan_depth) {
-			if (WARN_ON(vlan_depth < VLAN_HLEN))
-				return 0;
-			vlan_depth -= VLAN_HLEN;
-		} else {
-			vlan_depth = ETH_HLEN;
-		}
-		do {
-			struct vlan_hdr vhdr, *vh;
+		struct vlan_type_depth res;
 
-			vh = skb_header_pointer(skb, mac_offset + vlan_depth,
-						sizeof(vhdr), &vhdr);
-			if (unlikely(!vh || !--parse_depth))
-				return 0;
+		res = __vlan_get_protocol_offset(skb, type, mac_offset);
 
-			type = vh->h_vlan_encapsulated_proto;
-			vlan_depth += VLAN_HLEN;
-		} while (eth_type_vlan(type));
+		if (depth && res.type)
+			*depth = res.depth;
+		return res.type;
 	}
 
 	if (depth)
-		*depth = vlan_depth;
+		*depth = skb->mac_len;
 
 	return type;
 }
@@ -645,7 +638,7 @@ static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
 static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 					 int *depth)
 {
-	return __vlan_get_protocol_offset(skb, type, 0, depth);
+	return vlan_get_protocol_offset_inline(skb, type, 0, depth);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4d3920e5b141a02117186c3095f15f4f7a35b1df..0b5be7800dc76e3e0acb3d002b9a960471dbe3b9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7440,3 +7440,39 @@ void __put_netmem(netmem_ref netmem)
 		net_devmem_put_net_iov(netmem_to_net_iov(netmem));
 }
 EXPORT_SYMBOL(__put_netmem);
+
+struct vlan_type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
+						  __be16 type,
+						  int mac_offset)
+{
+	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
+
+	/* if type is 802.1Q/AD then the header should already be
+	 * present at mac_len - VLAN_HLEN (if mac_len > 0), or at
+	 * ETH_HLEN otherwise
+	 */
+	if (vlan_depth) {
+		if (WARN_ON_ONCE(vlan_depth < VLAN_HLEN))
+			return (struct vlan_type_depth) { 0 };
+		vlan_depth -= VLAN_HLEN;
+	} else {
+		vlan_depth = ETH_HLEN;
+	}
+	do {
+		struct vlan_hdr vhdr, *vh;
+
+		vh = skb_header_pointer(skb, mac_offset + vlan_depth,
+					sizeof(vhdr), &vhdr);
+		if (unlikely(!vh || !--parse_depth))
+			return (struct vlan_type_depth) { 0 };
+
+		type = vh->h_vlan_encapsulated_proto;
+		vlan_depth += VLAN_HLEN;
+	} while (eth_type_vlan(type));
+
+	return (struct vlan_type_depth) {
+		.type = type,
+		.depth = vlan_depth
+	};
+}
+EXPORT_SYMBOL(__vlan_get_protocol_offset);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 494d628d10a5105a6a32788b4673993f218ec881..a1005359085a8336edc3c95eceaf101025e75489 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -572,8 +572,9 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 	__be16 proto = skb->protocol;
 
 	if (unlikely(eth_type_vlan(proto)))
-		proto = __vlan_get_protocol_offset(skb, proto,
-						   skb_mac_offset(skb), NULL);
+		proto = vlan_get_protocol_offset_inline(skb, proto,
+							skb_mac_offset(skb),
+							NULL);
 
 	return proto;
 }
-- 
2.53.0.rc2.204.g2597b5adb4-goog


