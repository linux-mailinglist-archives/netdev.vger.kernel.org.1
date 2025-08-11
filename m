Return-Path: <netdev+bounces-212436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06EBB20541
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889544220A8
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AC214812;
	Mon, 11 Aug 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="KNL4ECDi"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071C1BD035;
	Mon, 11 Aug 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907954; cv=none; b=c6Q+psRjsEkaHrdrVjVNzHYcZo3btyoZok852g4j1ismhShLFJHjnQTmGE5SAM4NVQeoBj5xxd5u5mg1Lai2fYdRV8VHrZRcE6mqXOGQRcdnp7YvF5ZpyrehLHW9AQzcMzrM3JmmzVunCn74qNs7NKpnCwTiW6Vu5qcsdKvpDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907954; c=relaxed/simple;
	bh=WUFJaClt5A1A0E/z56Bv2phNlvk64lAEZVnpfKHjVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3clJDCi1sU+u9hzsXK9oAqZ4HUV+UqaRVtVLuK88habv9yN7Ppg9BYFvQtuZwVxrm+1KhIqzwcA6zbmey9a67XJBiX74PnHYvr3yup/dItpS1/U7NtBmVL3mDms3h0etc1K/uM2uZrwE/NnuRGrmjGURPiOPuOmqcpHh5+FyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=KNL4ECDi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rUXBcZclaa5p7dx86NOsbKhNhMlRIII02pORjXX5jDo=; b=KNL4ECDin1/0F6RT/nrl7AgsSR
	OHZ3p/zt/j2QEm+GQQoITnDbnQLiefa1/2LcOO35Bdf92of6FRrto1m2jW3+apLVAG5MWweC3mAbQ
	83o/RNnxWs6XbiejmtKFjpigBymQA5L008oNW0oh/toxZAeDNeqV94NiAGV2uPlJo/9o=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ulPHb-008fA3-1P;
	Mon, 11 Aug 2025 11:57:35 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
Date: Mon, 11 Aug 2025 11:57:33 +0200
Message-ID: <20250811095734.71019-1-nbd@nbd.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only handles packets where the pppoe header length field matches the exact
packet length. Significantly improves rx throughput.

When running NAT traffic through a MediaTek MT7621 devices from a host
behind PPPoE to a host directly connected via ethernet, the TCP throughput
that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
using fraglist GRO.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix compile error
v3:
  - increase priority value
  - implement GSO support
  - use INDIRECT_CALL_INET
  - update pppoe length field
  - remove unnecessary network_offsets update

 drivers/net/ppp/pppoe.c | 160 +++++++++++++++++++++++++++++++++++++++-
 net/ipv4/af_inet.c      |   2 +
 net/ipv6/ip6_offload.c  |   2 +
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42ade..a8d8eb870bce 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -77,6 +77,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/gro.h>
 
 #include <linux/uaccess.h>
 
@@ -435,7 +436,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb->len < len)
 		goto drop;
 
-	if (pskb_trim_rcsum(skb, len))
+	if (!skb_is_gso(skb) && pskb_trim_rcsum(skb, len))
 		goto drop;
 
 	ph = pppoe_hdr(skb);
@@ -1173,6 +1174,161 @@ static struct pernet_operations pppoe_net_ops = {
 	.size = sizeof(struct pppoe_net),
 };
 
+static u16
+compare_pppoe_header(struct pppoe_hdr *phdr, struct pppoe_hdr *phdr2)
+{
+	return (__force __u16)((phdr->sid ^ phdr2->sid) |
+			       (phdr->tag[0].tag_type ^ phdr2->tag[0].tag_type));
+}
+
+static __be16 pppoe_hdr_proto(struct pppoe_hdr *phdr)
+{
+	switch (phdr->tag[0].tag_type) {
+	case cpu_to_be16(PPP_IP):
+		return cpu_to_be16(ETH_P_IP);
+	case cpu_to_be16(PPP_IPV6):
+		return cpu_to_be16(ETH_P_IPV6);
+	default:
+		return 0;
+	}
+
+}
+
+static struct sk_buff *pppoe_gro_receive(struct list_head *head,
+					 struct sk_buff *skb)
+{
+	const struct packet_offload *ptype;
+	unsigned int hlen, off_pppoe;
+	struct sk_buff *pp = NULL;
+	struct pppoe_hdr *phdr;
+	struct sk_buff *p;
+	int flush = 1;
+	__be16 type;
+
+	off_pppoe = skb_gro_offset(skb);
+	hlen = off_pppoe + sizeof(*phdr);
+	phdr = skb_gro_header(skb, hlen + 2, off_pppoe);
+	if (unlikely(!phdr))
+		goto out;
+
+	/* ignore packets with padding or invalid length */
+	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen)
+		goto out;
+
+	type = pppoe_hdr_proto(phdr);
+	if (!type)
+		goto out;
+
+	ptype = gro_find_receive_by_type(type);
+	if (!ptype)
+		goto out;
+
+	flush = 0;
+
+	list_for_each_entry(p, head, list) {
+		struct pppoe_hdr *phdr2;
+
+		if (!NAPI_GRO_CB(p)->same_flow)
+			continue;
+
+		phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
+		if (compare_pppoe_header(phdr, phdr2))
+			NAPI_GRO_CB(p)->same_flow = 0;
+	}
+
+	skb_gro_pull(skb, sizeof(*phdr) + 2);
+	skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
+
+	pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
+					    ipv6_gro_receive, inet_gro_receive,
+					    head, skb);
+
+out:
+	skb_gro_flush_final(skb, pp, flush);
+
+	return pp;
+}
+
+static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
+{
+	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
+	__be16 type = pppoe_hdr_proto(phdr);
+	struct packet_offload *ptype;
+	int len, err;
+
+	ptype = gro_find_complete_by_type(type);
+	if (!ptype)
+		return -ENOENT;
+
+	err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
+				 ipv6_gro_complete, inet_gro_complete,
+				 skb, nhoff + sizeof(*phdr) + 2);
+	if (err)
+		return err;
+
+	len = skb->len - (nhoff + sizeof(*phdr));
+	phdr->length = cpu_to_be16(len);
+
+	return 0;
+}
+
+static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
+					 netdev_features_t features)
+{
+	unsigned int pppoe_hlen = sizeof(struct pppoe_hdr) + 2;
+	struct sk_buff *segs = ERR_PTR(-EINVAL);
+	u16 mac_offset = skb->mac_header;
+	struct packet_offload *ptype;
+	u16 mac_len = skb->mac_len;
+	struct pppoe_hdr *phdr;
+	__be16 orig_type, type;
+	int len, nhoff;
+
+	skb_reset_network_header(skb);
+	nhoff = skb_network_header(skb) - skb_mac_header(skb);
+
+	if (unlikely(!pskb_may_pull(skb, pppoe_hlen)))
+		goto out;
+
+	phdr = (struct pppoe_hdr *)skb_network_header(skb);
+	type = pppoe_hdr_proto(phdr);
+	ptype = gro_find_complete_by_type(type);
+	if (!ptype)
+		goto out;
+
+	orig_type = skb->protocol;
+	__skb_pull(skb, pppoe_hlen);
+	segs = ptype->callbacks.gso_segment(skb, features);
+	if (IS_ERR_OR_NULL(segs)) {
+		skb_gso_error_unwind(skb, orig_type, pppoe_hlen, mac_offset,
+				     mac_len);
+		goto out;
+	}
+
+	skb = segs;
+	do {
+		phdr = (struct pppoe_hdr *)(skb_mac_header(skb) + nhoff);
+		len = skb->len - (nhoff + sizeof(*phdr));
+		phdr->length = cpu_to_be16(len);
+		skb->network_header = (u8 *)phdr - skb->head;
+		skb->protocol = orig_type;
+		skb_reset_mac_len(skb);
+	} while ((skb = skb->next));
+
+out:
+	return segs;
+}
+
+static struct packet_offload pppoe_packet_offload __read_mostly = {
+	.type = cpu_to_be16(ETH_P_PPP_SES),
+	.priority = 20,
+	.callbacks = {
+		.gro_receive = pppoe_gro_receive,
+		.gro_complete = pppoe_gro_complete,
+		.gso_segment = pppoe_gso_segment,
+	},
+};
+
 static int __init pppoe_init(void)
 {
 	int err;
@@ -1189,6 +1345,7 @@ static int __init pppoe_init(void)
 	if (err)
 		goto out_unregister_pppoe_proto;
 
+	dev_add_offload(&pppoe_packet_offload);
 	dev_add_pack(&pppoes_ptype);
 	dev_add_pack(&pppoed_ptype);
 	register_netdevice_notifier(&pppoe_notifier);
@@ -1208,6 +1365,7 @@ static void __exit pppoe_exit(void)
 	unregister_netdevice_notifier(&pppoe_notifier);
 	dev_remove_pack(&pppoed_ptype);
 	dev_remove_pack(&pppoes_ptype);
+	dev_remove_offload(&pppoe_packet_offload);
 	unregister_pppox_proto(PX_PROTO_OE);
 	proto_unregister(&pppoe_sk_proto);
 	unregister_pernet_device(&pppoe_net_ops);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..0480a6d4f203 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1533,6 +1533,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	return pp;
 }
+EXPORT_INDIRECT_CALLABLE(inet_gro_receive);
 
 static struct sk_buff *ipip_gro_receive(struct list_head *head,
 					struct sk_buff *skb)
@@ -1618,6 +1619,7 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 out:
 	return err;
 }
+EXPORT_INDIRECT_CALLABLE(inet_gro_complete);
 
 static int ipip_gro_complete(struct sk_buff *skb, int nhoff)
 {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a..9e3640b018a4 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -306,6 +306,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 
 	return pp;
 }
+EXPORT_INDIRECT_CALLABLE(ipv6_gro_receive);
 
 static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
 					      struct sk_buff *skb)
@@ -388,6 +389,7 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 out:
 	return err;
 }
+EXPORT_INDIRECT_CALLABLE(ipv6_gro_complete);
 
 static int sit_gro_complete(struct sk_buff *skb, int nhoff)
 {
-- 
2.50.1


