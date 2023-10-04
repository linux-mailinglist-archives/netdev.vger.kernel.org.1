Return-Path: <netdev+bounces-37959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887DA7B8035
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 1C5B11F2252E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBF1400D;
	Wed,  4 Oct 2023 13:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA911C93
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:05:38 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D842A1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 06:05:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 33F122082B;
	Wed,  4 Oct 2023 15:05:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hp7CDMuwqorp; Wed,  4 Oct 2023 15:05:34 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 58CA8205E5;
	Wed,  4 Oct 2023 15:05:34 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 55FFE80004A;
	Wed,  4 Oct 2023 15:05:34 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 15:05:34 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 4 Oct
 2023 15:05:33 +0200
Date: Wed, 4 Oct 2023 15:05:27 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: Eyal Birger <eyal.birger@gmail.com>, <devel@linux-ipsec.org>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>, Antony Antony
	<antony.antony@secunet.com>
Subject: [PATCH v7 ipsec-next 2/3] xfrm: Support GRO for IPv4 ESP in UDP
 encapsulation
Message-ID: <d1208d1b8609215074c44d93918d418208756896.1696423735.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1696423735.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1696423735.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Steffen Klassert <steffen.klassert@secunet.com>

This patch enables the GRO codepath for IPv4 ESP in UDP encapsulated
packets. Decapsulation happens at L2 and saves a full round through
the stack for each packet. This is also needed to support HW offload
for ESP in UDP encapsulation.

Enabling this would imporove performance for ESP in UDP datapath, i.e
IPsec with NAT in between.

By default GRP for ESP-in-UDP is disabled for UDP sockets.
To enable this feature for an ESP socket, the following two options
need to be set:
1. enable ESP-in-UDP: (this is already set by an IKE daemon).
   int type = UDP_ENCAP_ESPINUDP;
   setsockopt(fd, SOL_UDP, UDP_ENCAP, &type, sizeof(type));

2. To enable GRO for ESP in UDP socket:
   type = true;
   setsockopt(fd, SOL_UDP, UDP_GRO, &type, sizeof(type));

Enabling ESP-in-UDP has the side effect of preventing the Linux stack from
seeing ESP packets at the L3 (when ESP OFFLOAD is disabled), as packets are
immediately decapsulated from UDP and decrypted.
This change may affect nftable rules that match on ESP packets at L3.
Also tcpdump won't see the ESP packet.

Developers/admins are advised to review and adapt any nftable rules
accordingly before enabling this feature to prevent potential rule breakage.
Also tcpdump will not see from ESP packets from a ESP in UDP flow, when this
is enabled.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/gro.h       |  2 +-
 include/net/xfrm.h      |  2 +
 net/ipv4/esp4_offload.c |  6 ++-
 net/ipv4/udp.c          | 14 ++++++
 net/ipv4/xfrm4_input.c  | 94 +++++++++++++++++++++++++++++++++--------
 5 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 88644b3ca660..b435f0ddbf64 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -41,7 +41,7 @@ struct napi_gro_cb {
 	/* Number of segments aggregated. */
 	u16	count;

-	/* Used in ipv6_gro_receive() and foo-over-udp */
+	/* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
 	u16	proto;

 /* Used in napi_gro_cb::free */
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 98d7aa78adda..dd8b21cf62b4 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1712,6 +1712,8 @@ int xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 void xfrm6_local_rxpmtu(struct sk_buff *skb, u32 mtu);
 int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
 int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
+struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
+					struct sk_buff *skb);
 int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval,
 		     int optlen);
 #else
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 5b487d12d0cf..b3271957ad9a 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -33,6 +33,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	struct xfrm_offload *xo;
 	struct xfrm_state *x;
+	int encap_type = 0;
 	__be32 seq;
 	__be32 spi;

@@ -70,6 +71,9 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,

 	xo->flags |= XFRM_GRO;

+	if (NAPI_GRO_CB(skb)->proto == IPPROTO_UDP)
+		encap_type = UDP_ENCAP_ESPINUDP;
+
 	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
@@ -77,7 +81,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,

 	/* We don't need to handle errors from xfrm_input, it does all
 	 * the error handling and frees the resources on error. */
-	xfrm_input(skb, IPPROTO_ESP, spi, 0);
+	xfrm_input(skb, IPPROTO_ESP, spi, encap_type);

 	return ERR_PTR(-EINPROGRESS);
 out_reset:
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c3ff984b6354..b8d7c5e86d0d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2625,6 +2625,17 @@ void udp_destroy_sock(struct sock *sk)
 	}
 }

+static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
+				       struct sock *sk)
+{
+#ifdef CONFIG_XFRM
+	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
+		if (family == AF_INET)
+			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
+	}
+#endif
+}
+
 /*
  *	Socket option code for UDP
  */
@@ -2674,6 +2685,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case 0:
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
+			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, sk);
+			fallthrough;
 		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
@@ -2716,6 +2729,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			udp_tunnel_encap_enable(sk);
 		udp_assign_bit(GRO_ENABLED, sk, valbool);
 		udp_assign_bit(ACCEPT_L4, sk, valbool);
+		set_xfrm_gro_udp_encap_rcv(up->encap_type, sk->sk_family, sk);
 		break;

 	/*
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 183f6dc37242..42879c5e026a 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -17,6 +17,8 @@
 #include <linux/netfilter_ipv4.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
+#include <net/protocol.h>
+#include <net/gro.h>

 static int xfrm4_rcv_encap_finish2(struct net *net, struct sock *sk,
 				   struct sk_buff *skb)
@@ -72,14 +74,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	return 0;
 }

-/* If it's a keepalive packet, then just eat it.
- * If it's an encapsulated packet, then pass it to the
- * IPsec xfrm input.
- * Returns 0 if skb passed to xfrm or was dropped.
- * Returns >0 if skb should be passed to UDP.
- * Returns <0 if skb should be resubmitted (-ret is protocol)
- */
-int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
+static int __xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull)
 {
 	struct udp_sock *up = udp_sk(sk);
 	struct udphdr *uh;
@@ -110,7 +105,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	case UDP_ENCAP_ESPINUDP:
 		/* Check if this is a keepalive packet.  If so, eat it. */
 		if (len == 1 && udpdata[0] == 0xff) {
-			goto drop;
+			return -EINVAL;
 		} else if (len > sizeof(struct ip_esp_hdr) && udpdata32[0] != 0) {
 			/* ESP Packet without Non-ESP header */
 			len = sizeof(struct udphdr);
@@ -121,7 +116,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	case UDP_ENCAP_ESPINUDP_NON_IKE:
 		/* Check if this is a keepalive packet.  If so, eat it. */
 		if (len == 1 && udpdata[0] == 0xff) {
-			goto drop;
+			return -EINVAL;
 		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
 			   udpdata32[0] == 0 && udpdata32[1] == 0) {

@@ -139,7 +134,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	 * protocol to ESP, and then call into the transform receiver.
 	 */
 	if (skb_unclone(skb, GFP_ATOMIC))
-		goto drop;
+		return -EINVAL;

 	/* Now we can update and verify the packet length... */
 	iph = ip_hdr(skb);
@@ -147,25 +142,88 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	iph->tot_len = htons(ntohs(iph->tot_len) - len);
 	if (skb->len < iphlen + len) {
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
-	return xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, encap_type);
-
-drop:
-	kfree_skb(skb);
 	return 0;
 }
 EXPORT_SYMBOL(xfrm4_udp_encap_rcv);

+/* If it's a keepalive packet, then just eat it.
+ * If it's an encapsulated packet, then pass it to the
+ * IPsec xfrm input.
+ * Returns 0 if skb passed to xfrm or was dropped.
+ * Returns >0 if skb should be passed to UDP.
+ * Returns <0 if skb should be resubmitted (-ret is protocol)
+ */
+int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	int ret;
+
+	ret = __xfrm4_udp_encap_rcv(sk, skb, true);
+	if (!ret)
+		return xfrm4_rcv_encap(skb, IPPROTO_ESP, 0,
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
+struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
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
+	ops = rcu_dereference(inet_offloads[IPPROTO_ESP]);
+	if (!ops || !ops->callbacks.gro_receive)
+		goto out;
+
+	ret = __xfrm4_udp_encap_rcv(sk, skb, false);
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
 int xfrm4_rcv(struct sk_buff *skb)
 {
 	return xfrm4_rcv_spi(skb, ip_hdr(skb)->protocol, 0);
--
2.30.2


