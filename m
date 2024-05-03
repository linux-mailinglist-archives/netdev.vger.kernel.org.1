Return-Path: <netdev+bounces-93197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D552B8BA8B6
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D93283100
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B514A61A;
	Fri,  3 May 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RLwx9nOB"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9B14A0A5
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724868; cv=none; b=clx3JFJDtAU6n6lvkrdyfxqKghPf0AJk8WDfS4v6C6tpNYZLZYdYFPzdqn9edOKTYt6jlDcUmeR2nHf8RZfyOJwovFfFA7ITPZF0qYmcfJ4aVm6KTBH744Wq18qlgWOIGiLul+tQ4kP+ybUPe196wrmbbpBGjti0RvjTprfU128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724868; c=relaxed/simple;
	bh=Kya/LWAt0qYnEi6yhsUNHxWDqzNrCyP4jxOizEKp7JY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3apaR1kFRyVdKNf3MBxl7HTmrGTZxpJh0jvth69Gx3ysNSt8xXCtQRLGLiZ5qVtR/Xj92TZlBcpPdraOwpXR/C6v4whdYDParHWLVl67l1grp7hlvmICrxKOK37cxOPJ5QEOtcWYgzgXHhMdHChGdFjJiIrnGmCmh7YjLtfvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RLwx9nOB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0BB3220847;
	Fri,  3 May 2024 10:27:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFDvrSULLnH9; Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4E6F120849;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4E6F120849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714724857;
	bh=9kpI/VVRijQX299sAat3F527PTNl69uP4LgnqBBYYMI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=RLwx9nOBLcgGIQ7MRpZaLFgf0snn/ccK4XbVa6+9k8asSP9pXmA8PW0dA5679nS7L
	 xWk91EYOTR4l4yzcr2jgfXoaT/ND80cvpQ47mBv+xgoZillgkExTAJ5cFbN17knYI6
	 ArrebbqSZBhZ5+uJhrBlGCHBDO2tO9+Yb+qpzkwISPLTNhbVJ8/rxe+exaDEBkMw96
	 Z/7eNRB1EZMdjSY6peifxyMGCbM11A7B219ElVoPlkhHFp0GIxYpdowv0XC63NvbDo
	 lMtqanOzFaLklTouEuhr4ATTprL2NTFDUmHvvutTL+3ohuilzULUW5hj86B2j1ARz2
	 8dOMi8NyWZoRA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 404A380004A;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 3 May 2024 10:27:37 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 May
 2024 10:27:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0CCE631803D0; Fri,  3 May 2024 10:27:36 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/5] udpencap: Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support
Date: Fri, 3 May 2024 10:27:27 +0200
Message-ID: <20240503082732.2835810-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503082732.2835810-1-steffen.klassert@secunet.com>
References: <20240503082732.2835810-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Antony Antony <antony.antony@secunet.com>

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
Kernel will return an error -ENOPROTOOPT if the userspace tries to set
this option.

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/uapi/linux/udp.h |  2 +-
 net/ipv4/esp4.c          | 12 ------------
 net/ipv4/udp.c           |  2 --
 net/ipv4/xfrm4_input.c   | 13 -------------
 net/ipv6/esp6.c          | 12 ------------
 net/ipv6/xfrm6_input.c   | 13 -------------
 6 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 4828794efcf8..1a0fe8b151fb 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -36,7 +36,7 @@ struct udphdr {
 #define UDP_GRO		104	/* This socket can receive UDP GRO packets */
 
 /* UDP encapsulation types */
-#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* draft-ietf-ipsec-nat-t-ike-00/01 */
+#define UDP_ENCAP_ESPINUDP_NON_IKE	1 /* unused  draft-ietf-ipsec-nat-t-ike-00/01 */
 #define UDP_ENCAP_ESPINUDP	2 /* draft-ietf-ipsec-udp-encaps-06 */
 #define UDP_ENCAP_L2TPINUDP	3 /* rfc2661 */
 #define UDP_ENCAP_GTP0		4 /* GSM TS 09.60 */
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3d647c9a7a21..7d38ddd64115 100644
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
index 7613daa339b0..4ca781065a07 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2699,8 +2699,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
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
index fe8d53f5a5ee..27df148530a6 100644
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
2.34.1


