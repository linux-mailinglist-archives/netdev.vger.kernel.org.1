Return-Path: <netdev+bounces-255777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHeIIzVfgGlj7AIAu9opvQ
	(envelope-from <netdev+bounces-255777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:24:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD7C9A78
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3754F301724F
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBCE34F49B;
	Mon,  2 Feb 2026 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyW643KH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C334D3B2
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020531; cv=none; b=rB3CkWwTAoM0hapkgSZk7H2aKWLkw+hdoRyBeKMw4SNtgIDEsJdzSZkgsq4Wjpa5AXlFdOHD28vilavwPRu1ySCkSbTHOtvAsanZhI8C6G+ZQuXtH8LFkXSTwqxED0uKGVGThWgG04W4zzCO7vV2dBEPE+iBYVDoTDkdQSnhclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020531; c=relaxed/simple;
	bh=13+24GoN9Q7NR6ShhitKGzXCeAt20nkk7/iOX+J+m2E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=enUcIy0lrs/ewc5KRUAqisIpNIUtOIL0Dk9jC90Nd9eeCcqSBCuz9ukB8Ix1hbD1kk2oHmP7MO4ykNDMZAmKc6L9nw4/l/TC7cjekcE4ADFGxUG0h4SzBm6fxftUQJswsXX3QuE67PlWMHFfERq3SlLi9eZYDFG714q63rRp83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyW643KH; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5014b22d678so55317251cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770020522; x=1770625322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TJJaRGodZX4XraMP9lCrBN/Y/C2KPyXRQPk9jNGAz6k=;
        b=LyW643KHjltD9BLUva2xQ7VtzmY01riKV6+ifUeQMc9hC0ij26/9PV4tjLOyYzJbXe
         DAten4C1wExdxc0ZUVpGMxP+YYUefJxLUWF6sMX7GoqqlKgfGoQ7fQLqD3j+vRH7nkU7
         kBlzrKPtR646PGNZ7l6OKzDqPYNBvX+UuHZnWVHPvPYzS6PeoQm/Lb+pM9giGpSK41t3
         L/LqBaDeuKjl3+xk2oBnWR9Nht0IyAYaIP/PrTGdxroufEPJOwx/ypIn7sagXEnBT3FB
         +zfEIEMiJrewusA07yudGHlVtpCo7DClzhet3goq3fcmmKsbkUMWhtje6ntn25wNwhb0
         Z+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770020522; x=1770625322;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJJaRGodZX4XraMP9lCrBN/Y/C2KPyXRQPk9jNGAz6k=;
        b=p+6K7x6/n9IidzZoeibXWaWtxT0Mbz4Xr0LwCKUhmE8PkkRJ0RPuftcRmoQYnbnQIx
         eq6bLt8yAL1ovDbMw5tlodQtOI3fa1wc+N+phz6x2tcQxxyURxue1oGQl3z5usco+v+I
         Mvt44l9hgyrUk0sbi0EbbmRoK6Zo0tHdzUvi0/nexVYGuUcpHN1XxOhO7kAHK811jt7k
         bFpxiPsNLhxLkhdFgV7QaOCpppM32Wy1OGuPR7YY6Wkq8/qyzB7oTUTbglqcm+enTJvz
         aRYS77Xt6OtTeLDxepfDDnS7eV44i4FVGw7sfHfUK2mhA1vUuFfahHCcuaPdWxnnESBb
         j9SA==
X-Forwarded-Encrypted: i=1; AJvYcCW3E03Fe3ebvkoTBQqGJDb1U6SrgdkHYqvvX2g43qkcuP2oXYjjcCp4EKAeSZtg35S9tzCMfr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfe9BYy8m/9JbvhjZwapJGlbBPCggrgHwo8XRZOhuC0wkF4ich
	AjPuapRfMJZQ30dNdmEXjbp3NcXza0i9E+HlO2+8C0f38TrKFoKF1nvVqr5k7X22Xtv1Rpqa7r3
	HOtJ05rVqn6PMKg==
X-Received: from qtbay22.prod.google.com ([2002:a05:622a:2296:b0:4f4:d5be:49eb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:342:b0:501:5281:5388 with SMTP id d75a77b69052e-505d2263cd3mr149782311cf.48.1770020521884;
 Mon, 02 Feb 2026 00:22:01 -0800 (PST)
Date: Mon,  2 Feb 2026 08:22:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202082200.650516-1-edumazet@google.com>
Subject: [PATCH net-next] net: add vlan_get_protocol_offset_inline() helper
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
	TAGGED_FROM(0.00)[bounces-255777-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0AD7C9A78
X-Rspamd-Action: no action

skb_protocol() is bloated, and forces slow stack canaries in many
fast paths.

Add vlan_get_protocol_offset_inline() which deals with the non-vlan
common cases.

__vlan_get_protocol_offset() is now out of line.

It returns a type_depth struct to avoid stack canaries in callers.

struct type_depth {
       __be16 type;
       u16 depth;
};

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
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
---
 include/linux/if_vlan.h | 51 +++++++++++++++++------------------------
 net/core/skbuff.c       | 36 +++++++++++++++++++++++++++++
 net/packet/af_packet.c  |  5 ++--
 3 files changed, 60 insertions(+), 32 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index f7f34eb15e068785e464303b60f2f050b3bec0ec..f5e70e0a38256c23ef731ff8d7d6cc1449db42e3 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -594,8 +594,17 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 	}
 }
 
+struct type_depth {
+	__be16 type;
+	u16 depth;
+};
+
+struct type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
+					     __be16 type,
+					     int mac_offset);
+
 /**
- * __vlan_get_protocol_offset() - get protocol EtherType.
+ * vlan_get_protocol_offset_inline() - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
  * @mac_offset: MAC offset
@@ -604,40 +613,22 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
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
-
-			vh = skb_header_pointer(skb, mac_offset + vlan_depth,
-						sizeof(vhdr), &vhdr);
-			if (unlikely(!vh || !--parse_depth))
-				return 0;
+		struct type_depth res = __vlan_get_protocol_offset(skb, type, mac_offset);
 
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
@@ -645,7 +636,7 @@ static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
 static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 					 int *depth)
 {
-	return __vlan_get_protocol_offset(skb, type, 0, depth);
+	return vlan_get_protocol_offset_inline(skb, type, 0, depth);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4d3920e5b141a02117186c3095f15f4f7a35b1df..35984a54b36fdf0b1b2590993ba08cdb403216e7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7440,3 +7440,39 @@ void __put_netmem(netmem_ref netmem)
 		net_devmem_put_net_iov(netmem_to_net_iov(netmem));
 }
 EXPORT_SYMBOL(__put_netmem);
+
+struct type_depth __vlan_get_protocol_offset(const struct sk_buff *skb,
+					     __be16 type,
+					     int mac_offset)
+{
+	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
+
+	/* if type is 802.1Q/AD then the header should already be
+	 * present at mac_len - VLAN_HLEN (if mac_len > 0), or at
+	 * ETH_HLEN otherwise
+	 */
+	if (vlan_depth) {
+		if (WARN_ON_ONCE(vlan_depth < VLAN_HLEN))
+			return (struct type_depth) { 0 };
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
+			return (struct type_depth) { 0 };
+
+		type = vh->h_vlan_encapsulated_proto;
+		vlan_depth += VLAN_HLEN;
+	} while (eth_type_vlan(type));
+
+	return (struct type_depth) {
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
2.53.0.rc1.225.gd81095ad13-goog


