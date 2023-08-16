Return-Path: <netdev+bounces-28004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6518477DDFD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C561C20D35
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12ECFBF6;
	Wed, 16 Aug 2023 09:57:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0165DF71
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:57:52 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CAFD1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:57:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 585B3206E9;
	Wed, 16 Aug 2023 11:57:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wd1fGyfrgMY4; Wed, 16 Aug 2023 11:57:48 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 63969206DF;
	Wed, 16 Aug 2023 11:57:48 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 5DA9480004A;
	Wed, 16 Aug 2023 11:57:48 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 11:57:48 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 11:57:47 +0200
Date: Wed, 16 Aug 2023 11:57:40 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: Eyal Birger <eyal.birger@gmail.com>, Antony Antony
	<antony.antony@secunet.com>, <devel@linux-ipsec.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 ipsec-next 2/3] xfrm: Support GRO for IPv4 ESP in UDP
 encapsulation.
Message-ID: <36dc1203db9169f553797a6e2d2a46265f19dd8b.1692172297.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
 <cover.1692172297.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1692172297.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
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

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/gro.h       |  2 +-
 include/net/xfrm.h      |  4 ++
 net/ipv4/esp4_offload.c |  6 ++-
 net/ipv4/udp.c          | 16 ++++++-
 net/ipv4/xfrm4_input.c  | 98 ++++++++++++++++++++++++++++++++---------
 5 files changed, 103 insertions(+), 23 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index a4fab706240d..41c12c5d1ea1 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -29,7 +29,7 @@ struct napi_gro_cb {
 	/* Number of segments aggregated. */
 	u16	count;

-	/* Used in ipv6_gro_receive() and foo-over-udp */
+	/* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
 	u16	proto;

 	/* jiffies when first packet was created/queued */
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 33ee3f5936e6..e980f442ddcd 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1671,6 +1671,8 @@ void xfrm_local_error(struct sk_buff *skb, int mtu);
 int xfrm4_extract_input(struct xfrm_state *x, struct sk_buff *skb);
 int xfrm4_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 		    int encap_type);
+struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
+					struct sk_buff *skb);
 int xfrm4_transport_finish(struct sk_buff *skb, int async);
 int xfrm4_rcv(struct sk_buff *skb);

@@ -1711,6 +1713,8 @@ int xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 void xfrm6_local_rxpmtu(struct sk_buff *skb, u32 mtu);
 int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
 int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb);
+struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
+					struct sk_buff *skb);
 int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval,
 		     int optlen);
 #else
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 77bb01032667..34ebfdf0e986 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -32,6 +32,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	struct xfrm_offload *xo;
 	struct xfrm_state *x;
+	int encap_type = 0;
 	__be32 seq;
 	__be32 spi;

@@ -69,6 +70,9 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,

 	xo->flags |= XFRM_GRO;

+	if (NAPI_GRO_CB(skb)->proto == IPPROTO_UDP)
+		encap_type = UDP_ENCAP_ESPINUDP;
+
 	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
@@ -76,7 +80,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,

 	/* We don't need to handle errors from xfrm_input, it does all
 	 * the error handling and frees the resources on error. */
-	xfrm_input(skb, IPPROTO_ESP, spi, 0);
+	xfrm_input(skb, IPPROTO_ESP, spi, encap_type);

 	return ERR_PTR(-EINPROGRESS);
 out_reset:
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index aa32afd871ee..337607b17ebd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2681,6 +2681,17 @@ void udp_destroy_sock(struct sock *sk)
 	}
 }

+static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
+				       struct udp_sock *up)
+{
+#ifdef CONFIG_XFRM
+	if (up->gro_enabled && encap_type == UDP_ENCAP_ESPINUDP) {
+		if (family == AF_INET)
+			up->gro_receive = xfrm4_gro_udp_encap_rcv;
+	}
+#endif
+}
+
 /*
  *	Socket option code for UDP
  */
@@ -2730,12 +2741,14 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case 0:
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
+			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, up);
+			fallthrough;
 		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				up->encap_rcv = ipv6_stub->xfrm6_udp_encap_rcv;
-			else
 #endif
+			if (sk->sk_family == AF_INET)
 				up->encap_rcv = xfrm4_udp_encap_rcv;
 #endif
 			fallthrough;
@@ -2773,6 +2786,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			udp_tunnel_encap_enable(sk->sk_socket);
 		up->gro_enabled = valbool;
 		up->accept_udp_l4 = valbool;
+		set_xfrm_gro_udp_encap_rcv(up->encap_type, sk->sk_family, up);
 		release_sock(sk);
 		break;

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index ad2afeef4f10..b57f477c745e 100644
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
@@ -90,8 +85,8 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	__be32 *udpdata32;
 	__u16 encap_type = up->encap_type;

-	/* if this is not encapsulated socket, then just return now */
-	if (!encap_type)
+	/* if unknown encap_type then just return now */
+	if (encap_type != UDP_ENCAP_ESPINUDP && encap_type != UDP_ENCAP_ESPINUDP_NON_IKE)
 		return 1;

 	/* If this is a paged skb, make sure we pull up
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
@@ -147,24 +142,87 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
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


