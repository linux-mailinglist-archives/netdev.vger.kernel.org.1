Return-Path: <netdev+bounces-84736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5589837A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DDC28F61F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3771B4C;
	Thu,  4 Apr 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qj1zT2zs"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AE71B42
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220707; cv=none; b=BEaL9x9C3W1nb4UTlQmaqzlGG6+HtNGhYYf4dZbjVY+iJOUoYQKQiisvSZuKqHwVxGi9M4G1LjVvVxdUul9QA8E9fexV+/TK0D2IrBLuQVbv/a40Dsst0EJIpQuQ+sjPXEZ5ppX4B/8hzyh48gBmSk/k1ErzWa/4SPMl/EPG/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220707; c=relaxed/simple;
	bh=QV2oeWZERwN/CzhgKiCVdOUwTY7orAveVJ7ZAnLpr5I=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TnuaBIrJCpj/FuKgk4qlWTCZ+owDszz5W0XnJuhlV+u2tMTBKsvPIQsRYNUuxsWaDmfUQ67AmXfcnMdeiAuhb0kiE/z+/wpn441PBZSiDh4/FsdHwCSbMVDWM6GQll7BTUrWWRrQ7CmUKC1EfFpHUI6PuggJ1l64/sOVF/lGAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qj1zT2zs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0BBEC20893;
	Thu,  4 Apr 2024 10:51:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6cQCm5Z3l7F; Thu,  4 Apr 2024 10:51:41 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E3CC4201E5;
	Thu,  4 Apr 2024 10:51:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E3CC4201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712220700;
	bh=B1Ac4RcRnZ/bQLQE0gnsjmezgu2IrXFbH1TIZKPJ3ko=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=qj1zT2zs+wDZLI6iI1yYmzBR6voqpu32Opq7LkTfZpL7azG7sMkfLoY+owAyP+KL0
	 H0F2Ufm97ul6gekj5qyxLh+S4Ry0RVbSINTtfQngN5fe3cKbTwZRLengrFkNfQf6/I
	 hvsDXdBzic4FUO/gEE2qunYaCFHpSgcS1zlvwJboQc/MCKR9+NxRkB9R0Pm/CcXRax
	 x6JXPpz5BP37isaZCwC3qla30jnjSuVx/IlOacQeJ+bMFYkLq3gIYhRbJqT1cRdqN0
	 jfjJtTUPj5ZduMgHZgi8nQZb1OugPFUD5FKfpNTUIuhE5C4xjday21tl8cwpf0uJNu
	 QdV7h0ZLHABnA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id D6E3680004A;
	Thu,  4 Apr 2024 10:51:40 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 10:51:40 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 4 Apr
 2024 10:51:40 +0200
Date: Thu, 4 Apr 2024 10:51:31 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andreas Gruenbacher
	<agruenba@redhat.com>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: [PATCH ipsec-next v2] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <c873dc4dcaa0ab84b562f29751996db6bd37d440.1712220541.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
in 2004 [2], has remained inactive and obsolete for an extended period.

This mode was originally defined in an early version of an IETF draft
[1] from 2001. By the time it was integrated into the kernel in 2004 [2],
it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.

Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
known use cases.

With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
simplifying the codebase and eliminating unnecessary complexity.
Actually, we remove the functionality and wrap  UDP_ENCAP_ESPINUDP_NON_IKE
defination in "#ifndef __KERNEL__". If it is used again in kernel code
your build will fail.

References:
[1] https://datatracker.ietf.org/doc/html/draft-ietf-ipsec-udp-encaps-00.txt

[2] Commit that added UDP_ENCAP_ESPINUDP_NON_IKE to the Linux historic
    repository.

    Author: Andreas Gruenbacher <agruen@suse.de>
    Date: Fri Apr 9 01:47:47 2004 -0700

   [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls need it.

[3] Commit that added UDP_ENCAP_ESPINUDP to the Linux historic
    repository.

    Author: Derek Atkins <derek@ihtfp.com>
    Date: Wed Apr 2 13:21:02 2003 -0800

    [IPSEC]: Implement UDP Encapsulation framework.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v1 -> v2
- removed defination wrapped in #ifndef __KERNEL__ It would falsly
  let userspace appliction build and break when running.
RFC -> v1
- keep removed defination wrapped in #ifndef __KERNEL__
---
 include/uapi/linux/udp.h |  1 -
 net/ipv4/esp4.c          | 12 ------------
 net/ipv4/udp.c           |  2 --
 net/ipv4/xfrm4_input.c   | 13 -------------
 net/ipv6/esp6.c          | 12 ------------
 net/ipv6/xfrm6_input.c   | 13 -------------
 6 files changed, 53 deletions(-)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 4828794efcf8..1516f53698e0 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -36,7 +36,6 @@ struct udphdr {
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */

 /* UDP encapsulation types */
-#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
 #define UDP_ENCAP_GTP0		4 /* GSM TS 09.60 */
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..695f775640ac 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -347,7 +347,6 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,
 					       __be16 dport)
 {
 	struct udphdr *uh;
-	__be32 *udpdata32;
 	unsigned int len;

 	len = skb->len + esp->tailen - skb_transport_offset(skb);
@@ -362,12 +361,6 @@ static struct ip_esp_hdr *esp_output_udp_encap(struct sk_buff *skb,

 	*skb_mac_header(skb) = IPPROTO_UDP;

-	if (encap_type == UDP_ENCAP_ESPINUDP_NON_IKE) {
-		udpdata32 = (__be32 *)(uh + 1);
-		udpdata32[0] = udpdata32[1] = 0;
-		return (struct ip_esp_hdr *)(udpdata32 + 2);
-	}
-
 	return (struct ip_esp_hdr *)(uh + 1);
 }

@@ -423,7 +416,6 @@ static int esp_output_encap(struct xfrm_state *x, struct sk_buff *skb,
 	switch (encap_type) {
 	default:
 	case UDP_ENCAP_ESPINUDP:
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
 		esph = esp_output_udp_encap(skb, encap_type, esp, sport, dport);
 		break;
 	case TCP_ENCAP_ESPINTCP:
@@ -775,7 +767,6 @@ int esp_input_done2(struct sk_buff *skb, int err)
 			source = th->source;
 			break;
 		case UDP_ENCAP_ESPINUDP:
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			source = uh->source;
 			break;
 		default:
@@ -1179,9 +1170,6 @@ static int esp_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		case UDP_ENCAP_ESPINUDP:
 			x->props.header_len += sizeof(struct udphdr);
 			break;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
-			x->props.header_len += sizeof(struct udphdr) + 2 * sizeof(u32);
-			break;
 #ifdef CONFIG_INET_ESPINTCP
 		case TCP_ENCAP_ESPINTCP:
 			/* only the length field, TCP encap is done by
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 661d0e0d273f..16b6a9d59b02 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2688,8 +2688,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #ifdef CONFIG_XFRM
 		case UDP_ENCAP_ESPINUDP:
 			set_xfrm_gro_udp_encap_rcv(val, sk->sk_family, sk);
-			fallthrough;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				WRITE_ONCE(up->encap_rcv,
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index dae35101d189..0918b0682174 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -113,19 +113,6 @@ static int __xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
 			/* Must be an IKE packet.. pass it through */
 			return 1;
 		break;
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
-		/* Check if this is a keepalive packet.  If so, eat it. */
-		if (len == 1 && udpdata[0] == 0xff) {
-			return -EINVAL;
-		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
-			   udpdata32[0] == 0 && udpdata32[1] == 0) {
-
-			/* ESP Packet with Non-IKE marker */
-			len = sizeof(struct udphdr) + 2 * sizeof(u32);
-		} else
-			/* Must be an IKE packet.. pass it through */
-			return 1;
-		break;
 	}

 	/* At this point we are sure that this is an ESPinUDP packet,
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..cafb5746f4c7 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -383,7 +383,6 @@ static struct ip_esp_hdr *esp6_output_udp_encap(struct sk_buff *skb,
 					       __be16 dport)
 {
 	struct udphdr *uh;
-	__be32 *udpdata32;
 	unsigned int len;

 	len = skb->len + esp->tailen - skb_transport_offset(skb);
@@ -398,12 +397,6 @@ static struct ip_esp_hdr *esp6_output_udp_encap(struct sk_buff *skb,

 	*skb_mac_header(skb) = IPPROTO_UDP;

-	if (encap_type == UDP_ENCAP_ESPINUDP_NON_IKE) {
-		udpdata32 = (__be32 *)(uh + 1);
-		udpdata32[0] = udpdata32[1] = 0;
-		return (struct ip_esp_hdr *)(udpdata32 + 2);
-	}
-
 	return (struct ip_esp_hdr *)(uh + 1);
 }

@@ -459,7 +452,6 @@ static int esp6_output_encap(struct xfrm_state *x, struct sk_buff *skb,
 	switch (encap_type) {
 	default:
 	case UDP_ENCAP_ESPINUDP:
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
 		esph = esp6_output_udp_encap(skb, encap_type, esp, sport, dport);
 		break;
 	case TCP_ENCAP_ESPINTCP:
@@ -822,7 +814,6 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 			source = th->source;
 			break;
 		case UDP_ENCAP_ESPINUDP:
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			source = uh->source;
 			break;
 		default:
@@ -1232,9 +1223,6 @@ static int esp6_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		case UDP_ENCAP_ESPINUDP:
 			x->props.header_len += sizeof(struct udphdr);
 			break;
-		case UDP_ENCAP_ESPINUDP_NON_IKE:
-			x->props.header_len += sizeof(struct udphdr) + 2 * sizeof(u32);
-			break;
 #ifdef CONFIG_INET6_ESPINTCP
 		case TCP_ENCAP_ESPINTCP:
 			/* only the length field, TCP encap is done by
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index a17d783dc7c0..2c6aeb090b7a 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -109,19 +109,6 @@ static int __xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb, bool pull
 			/* Must be an IKE packet.. pass it through */
 			return 1;
 		break;
-	case UDP_ENCAP_ESPINUDP_NON_IKE:
-		/* Check if this is a keepalive packet.  If so, eat it. */
-		if (len == 1 && udpdata[0] == 0xff) {
-			return -EINVAL;
-		} else if (len > 2 * sizeof(u32) + sizeof(struct ip_esp_hdr) &&
-			   udpdata32[0] == 0 && udpdata32[1] == 0) {
-
-			/* ESP Packet with Non-IKE marker */
-			len = sizeof(struct udphdr) + 2 * sizeof(u32);
-		} else
-			/* Must be an IKE packet.. pass it through */
-			return 1;
-		break;
 	}

 	/* At this point we are sure that this is an ESPinUDP packet,
--
2.30.2


