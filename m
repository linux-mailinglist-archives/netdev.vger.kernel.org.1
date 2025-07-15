Return-Path: <netdev+bounces-207066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51CB05817
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 12:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AF5562E59
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127302D8DBE;
	Tue, 15 Jul 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="pGcYvD2F"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B912D837E;
	Tue, 15 Jul 2025 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576290; cv=none; b=qfT8Z5tL+M7bUAYN3naMqBj+Pz28am5LL/ei4FoR0EucFkosPb6DX3843PPmomVNcJLlUlDI11vAswx3lNJT9GWYQO03szlQr7fdMGVK7xlFU120nBK0wuN8qpyXzVKByci1EoLwt/OTtDAcvjnS9tMsDryPwXILKgPrE4HrZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576290; c=relaxed/simple;
	bh=tAAyI6btdERrX7kxlEMiQsdnF9Ia2Q+2uiKMlGybJto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKbwiFgGm2vj5ude2xMVSVle6LHcxwPfY1LIZnEYJF3YCxVGUfzWhyhzUi7pz/fG0OWk3Q+1w3jGnMBdu/Nc9Ww8uZXww3D9xPjOJywg2vi/uSHwRDKhBcgzSJOe1kKUGIbU6vvm0eJyXXARNR/1BS/iCjpD1E0+cyzoa4+jWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=pGcYvD2F; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=i7fP8BcumApPjNSeUMxVqB2p8QkYDUChQH+pYPCBu/Y=; b=pGcYvD2FVp5ZZCcjNbSDGj0dyn
	PBc8FaOmgTXGhfEg3yEFABbrdF2zBftBEkIemTa5gymhaOGp9Qez/Q8jowo4ypPFZYIxl911FOCMm
	8g/grdjGZ/t4lo1Davy0nZagwXff8nRI5gmQuXHaRbTtif1jnbPkwPefie2NLrlhQmiw=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ubd9D-00C9uA-1j;
	Tue, 15 Jul 2025 12:44:31 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] net: pppoe: implement GRO support
Date: Tue, 15 Jul 2025 12:44:24 +0200
Message-ID: <20250715104425.8688-1-nbd@nbd.name>
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
 drivers/net/ppp/pppoe.c | 107 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42ade..3595f2d35de6 100644
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
@@ -1173,6 +1174,108 @@ static struct pernet_operations pppoe_net_ops = {
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
+	__be16 type;
+	int flush = 1;
+
+	off_pppoe = skb_gro_offset(skb);
+	hlen = off_pppoe + sizeof(*phdr) + 2;
+	phdr = skb_gro_header(skb, hlen, off_pppoe);
+	if (unlikely(!phdr))
+		goto out;
+
+	/* ignore packets with padding or invalid length */
+	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
+		goto out;
+
+	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
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
+	int err = -ENOENT;
+
+	ptype = gro_find_complete_by_type(type);
+	if (ptype)
+		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
+					 ipv6_gro_complete, inet_gro_complete,
+					 skb, nhoff + sizeof(*phdr) + 2);
+
+	return err;
+}
+
+static struct packet_offload pppoe_packet_offload __read_mostly = {
+	.type = cpu_to_be16(ETH_P_PPP_SES),
+	.priority = 10,
+	.callbacks = {
+		.gro_receive = pppoe_gro_receive,
+		.gro_complete = pppoe_gro_complete,
+	},
+};
+
 static int __init pppoe_init(void)
 {
 	int err;
@@ -1189,6 +1292,7 @@ static int __init pppoe_init(void)
 	if (err)
 		goto out_unregister_pppoe_proto;
 
+	dev_add_offload(&pppoe_packet_offload);
 	dev_add_pack(&pppoes_ptype);
 	dev_add_pack(&pppoed_ptype);
 	register_netdevice_notifier(&pppoe_notifier);
@@ -1208,6 +1312,7 @@ static void __exit pppoe_exit(void)
 	unregister_netdevice_notifier(&pppoe_notifier);
 	dev_remove_pack(&pppoed_ptype);
 	dev_remove_pack(&pppoes_ptype);
+	dev_remove_offload(&pppoe_packet_offload);
 	unregister_pppox_proto(PX_PROTO_OE);
 	proto_unregister(&pppoe_sk_proto);
 	unregister_pernet_device(&pppoe_net_ops);
-- 
2.50.1


