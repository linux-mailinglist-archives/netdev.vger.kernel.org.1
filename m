Return-Path: <netdev+bounces-36250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F57AEA27
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 377681C20805
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC91BDE6;
	Tue, 26 Sep 2023 10:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC414F96
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 10:15:52 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2BD97
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 03:15:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B154420861;
	Tue, 26 Sep 2023 12:15:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8TPMbikoQnO; Tue, 26 Sep 2023 12:15:48 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DBA4B20860;
	Tue, 26 Sep 2023 12:15:48 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id D802580004A;
	Tue, 26 Sep 2023 12:15:48 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 12:15:48 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 26 Sep
 2023 12:15:48 +0200
Date: Tue, 26 Sep 2023 12:15:39 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: Eyal Birger <eyal.birger@gmail.com>, Eric Dumazet <edumazet@google.com>,
	<devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Antony Antony
	<antony.antony@secunet.com>
Subject: [PATCH v6 ipsec-next 3/3] xfrm: Support GRO for IPv6 ESP in UDP
 encapsulation
Message-ID: <d93b1f356b65a8f83c0110e05be330913a8aa232.1695722427.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1695722426.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1695722426.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Steffen Klassert <steffen.klassert@secunet.com>

This patch enables the GRO codepath for IPv6 ESP in UDP encapsulated
packets. Decapsulation happens at L2 and saves a full round through
the stack for each packet. This is also needed to support HW offload
for ESP in UDP encapsulation.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
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
index dd8b21cf62b4..4165ad01ef3b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1714,6 +1714,8 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
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
2.30.2


