Return-Path: <netdev+bounces-44982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A27DA5E9
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5238F2827E5
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D35BE4B;
	Sat, 28 Oct 2023 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A589464
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:43:38 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D2129
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:43:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CA1DA20612;
	Sat, 28 Oct 2023 10:43:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPPU8hgCcakl; Sat, 28 Oct 2023 10:43:35 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0AAF320851;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id F252B80004A;
	Sat, 28 Oct 2023 10:43:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:43:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:43:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 56FFC3183D51; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/10] xfrm: Support GRO for IPv6 ESP in UDP encapsulation
Date: Sat, 28 Oct 2023 10:43:23 +0200
Message-ID: <20231028084328.3119236-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028084328.3119236-1-steffen.klassert@secunet.com>
References: <20231028084328.3119236-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This patch enables the GRO codepath for IPv6 ESP in UDP encapsulated
packets. Decapsulation happens at L2 and saves a full round through
the stack for each packet. This is also needed to support HW offload
for ESP in UDP encapsulation.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
---
 include/net/ipv6_stubs.h |  3 ++
 include/net/xfrm.h       |  2 +
 net/ipv4/udp.c           |  2 +
 net/ipv6/af_inet6.c      |  1 +
 net/ipv6/esp6_offload.c  | 10 ++++-
 net/ipv6/xfrm6_input.c   | 94 ++++++++++++++++++++++++++++++++--------
 6 files changed, 92 insertions(+), 20 deletions(-)

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index c48186bf4737..887d35f716c7 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -60,6 +60,9 @@ struct ipv6_stub {
 #if IS_ENABLED(CONFIG_XFRM)
 	void (*xfrm6_local_rxpmtu)(struct sk_buff *skb, u32 mtu);
 	int (*xfrm6_udp_encap_rcv)(struct sock *sk, struct sk_buff *skb);
+	struct sk_buff *(*xfrm6_gro_udp_encap_rcv)(struct sock *sk,
+						   struct list_head *head,
+						   struct sk_buff *skb);
 	int (*xfrm6_rcv_encap)(struct sk_buff *skb, int nexthdr, __be32 spi,
 			       int encap_type);
 #endif
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 2437a2e308de..4681ecfb85ac 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1712,6 +1712,8 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
 int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
 struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 					struct sk_buff *skb);
+struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
+					struct sk_buff *skb);
 int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval,
 		     int optlen);
 #else
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b8d7c5e86d0d..7fdc250e0679 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2632,6 +2632,8 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
 		if (family == AF_INET)
 			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
+		else if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
+			WRITE_ONCE(udp_sk(sk)->gro_receive, ipv6_stub->xfrm6_gro_udp_encap_rcv);
 	}
 #endif
 }
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index c6ad0d6e99b5..7dd8aeb555cf 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1049,6 +1049,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
 #if IS_ENABLED(CONFIG_XFRM)
 	.xfrm6_local_rxpmtu = xfrm6_local_rxpmtu,
 	.xfrm6_udp_encap_rcv = xfrm6_udp_encap_rcv,
+	.xfrm6_gro_udp_encap_rcv = xfrm6_gro_udp_encap_rcv,
 	.xfrm6_rcv_encap = xfrm6_rcv_encap,
 #endif
 	.nd_tbl	= &nd_tbl,
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 19ff2bceb4e1..527b7caddbc6 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -34,7 +34,9 @@ static __u16 esp6_nexthdr_esp_offset(struct ipv6hdr *ipv6_hdr, int nhlen)
 	int off = sizeof(struct ipv6hdr);
 	struct ipv6_opt_hdr *exthdr;
 
-	if (likely(ipv6_hdr->nexthdr == NEXTHDR_ESP))
+	/* ESP or ESPINUDP */
+	if (likely(ipv6_hdr->nexthdr == NEXTHDR_ESP ||
+		   ipv6_hdr->nexthdr == NEXTHDR_UDP))
 		return offsetof(struct ipv6hdr, nexthdr);
 
 	while (off < nhlen) {
@@ -54,10 +56,14 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	struct xfrm_offload *xo;
 	struct xfrm_state *x;
+	int encap_type = 0;
 	__be32 seq;
 	__be32 spi;
 	int nhoff;
 
+	if (NAPI_GRO_CB(skb)->proto == IPPROTO_UDP)
+		encap_type = UDP_ENCAP_ESPINUDP;
+
 	if (!pskb_pull(skb, offset))
 		return NULL;
 
@@ -104,7 +110,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 
 	/* We don't need to handle errors from xfrm_input, it does all
 	 * the error handling and frees the resources on error. */
-	xfrm_input(skb, IPPROTO_ESP, spi, 0);
+	xfrm_input(skb, IPPROTO_ESP, spi, encap_type);
 
 	return ERR_PTR(-EINPROGRESS);
 out_reset:
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4156387248e4..ccf79b84c061 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -16,6 +16,8 @@
 #include <linux/netfilter_ipv6.h>
 #include <net/ipv6.h>
 #include <net/xfrm.h>
+#include <net/protocol.h>
+#include <net/gro.h>
 
 int xfrm6_rcv_spi(struct sk_buff *skb, int nexthdr, __be32 spi,
 		  struct ip6_tnl *t)
@@ -67,14 +69,7 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	return 0;
 }
 
-/* If it's a keepalive packet, then just eat it.
- * If it's an encapsulated packet, then pass it to the
- * IPsec xfrm input.
- * Returns 0 if skb passed to xfrm or was dropped.
- * Returns >0 if skb should be passed to UDP.
- * Returns <0 if skb should be resubmitted (-ret is protocol)
- */
-int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
+static int __xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull)
 {
 	struct udp_sock *up = udp_sk(sk);
 	struct udphdr *uh;
@@ -109,7 +104,7 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	case UDP_ENCAP_ESPINUDP:
 		/* Check if this is a keepalive packet.  If so, eat it. */
 		if (len == 1 && udpdata[0] == 0xff) {
-			goto drop;
+			return -EINVAL;
 		} else if (len > sizeof(struct ip_esp_hdr) && udpdata32[0] != 0) {
 			/* ESP Packet without Non-ESP header */
 			len = sizeof(struct udphdr);
@@ -120,7 +115,7 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	case UDP_ENCAP_ESPINUDP_NON_IKE:
 		/* Check if this is a keepalive packet.  If so, eat it. */
 		if (len == 1 && udpdata[0] == 0xff) {
-			goto drop;
+			return -EINVAL;
 		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
 			   udpdata32[0] == 0 && udpdata32[1] == 0) {
 
@@ -138,31 +133,94 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	 * protocol to ESP, and then call into the transform receiver.
 	 */
 	if (skb_unclone(skb, GFP_ATOMIC))
-		goto drop;
+		return -EINVAL;
 
 	/* Now we can update and verify the packet length... */
 	ip6h = ipv6_hdr(skb);
 	ip6h->payload_len = htons(ntohs(ip6h->payload_len) - len);
 	if (skb->len < ip6hlen + len) {
 		/* packet is too small!?! */
-		goto drop;
+		return -EINVAL;
 	}
 
 	/* pull the data buffer up to the ESP header and set the
 	 * transport header to point to ESP.  Keep UDP on the stack
 	 * for later.
 	 */
-	__skb_pull(skb, len);
-	skb_reset_transport_header(skb);
+	if (pull) {
+		__skb_pull(skb, len);
+		skb_reset_transport_header(skb);
+	} else {
+		skb_set_transport_header(skb, len);
+	}
 
 	/* process ESP */
-	return xfrm6_rcv_encap(skb, IPPROTO_ESP, 0, encap_type);
-
-drop:
-	kfree_skb(skb);
 	return 0;
 }
 
+/* If it's a keepalive packet, then just eat it.
+ * If it's an encapsulated packet, then pass it to the
+ * IPsec xfrm input.
+ * Returns 0 if skb passed to xfrm or was dropped.
+ * Returns >0 if skb should be passed to UDP.
+ * Returns <0 if skb should be resubmitted (-ret is protocol)
+ */
+int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	int ret;
+
+	ret = __xfrm6_udp_encap_rcv(sk, skb, true);
+	if (!ret)
+		return xfrm6_rcv_encap(skb, IPPROTO_ESP, 0,
+				       udp_sk(sk)->encap_type);
+
+	if (ret < 0) {
+		kfree_skb(skb);
+		return 0;
+	}
+
+	return ret;
+}
+
+struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
+					struct sk_buff *skb)
+{
+	int offset = skb_gro_offset(skb);
+	const struct net_offload *ops;
+	struct sk_buff *pp = NULL;
+	int ret;
+
+	offset = offset - sizeof(struct udphdr);
+
+	if (!pskb_pull(skb, offset))
+		return NULL;
+
+	rcu_read_lock();
+	ops = rcu_dereference(inet6_offloads[IPPROTO_ESP]);
+	if (!ops || !ops->callbacks.gro_receive)
+		goto out;
+
+	ret = __xfrm6_udp_encap_rcv(sk, skb, false);
+	if (ret)
+		goto out;
+
+	skb_push(skb, offset);
+	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
+
+	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
+	rcu_read_unlock();
+
+	return pp;
+
+out:
+	rcu_read_unlock();
+	skb_push(skb, offset);
+	NAPI_GRO_CB(skb)->same_flow = 0;
+	NAPI_GRO_CB(skb)->flush = 1;
+
+	return NULL;
+}
+
 int xfrm6_rcv_tnl(struct sk_buff *skb, struct ip6_tnl *t)
 {
 	return xfrm6_rcv_spi(skb, skb_network_header(skb)[IP6CB(skb)->nhoff],
-- 
2.34.1


