Return-Path: <netdev+bounces-55263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2880A059
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE1B20C4D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466D14A99;
	Fri,  8 Dec 2023 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQLwUprn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142D511D
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:12:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3bdbf1fb5so22596547b3.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030367; x=1702635167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=621uGQ5jqOAzSgTDszVGuWrpJtkuxSHtUcfyApcIhnY=;
        b=PQLwUprnoaRKQ4H3x7/tVk4wDFlt1/AHaZMqsKBZhxT077+B3Pw74u+sW1pcTXJo1v
         8W7r+nzSG6oV1Ceo79RbTN07c6URheQCjveQ++UKO7FRl+LYahq4sbsgiNwA+losOqef
         RJPPkWfOQjqMzBq22t3QH32sm1ZZTSlV/RvivijjiL7UAVTGQPZ73whiI5trujuTCXcB
         rePt+GBbQVgl6YPK9MyE+tMK4Y8fSKYAMn1+LEMezAmJHR+AuPYv05CC1E9pQLPr9jCy
         U/5Co4IPcDOf2KpBulO2MoYqJeSRLzOMlG+69yveaTKVgqs/NUrDNRwKDhghJr7OtA2g
         PVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030367; x=1702635167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=621uGQ5jqOAzSgTDszVGuWrpJtkuxSHtUcfyApcIhnY=;
        b=BZiEpsinXiCZLCqzzFbfKq2HotyDN4yb2FfuoiB+txkaXfIgGsVQcxIiddkrQDiCQZ
         epw7uYyrUdtOOs8mU81HPAB6R5O9M2pdJ2zXm0me/WYqc50GVIUDJq9WaT4ws+r3kXMt
         AVX4e/8Z2li/AbHLO7TITVHZ+R0GpSwGFDkMifohIgZCyhjM2IWmy3xmz79kXiYilcis
         z4nq40Iw6PwSmPSsaAqxu0QrxevC+xSblJOsC2VZyXFhgP/qLWXNpJBge9VsnKh/wosj
         uM/kEvXbYFYq6Iu313YzGTK90gen+8KHqHlbDu9etnnRmx9BYbJ5rOUTC/wPdDzqu6Hh
         uFgw==
X-Gm-Message-State: AOJu0YzKYtSj2pa3tVr0COrEX8vuBEsrrS8/vmDAS4is9WcorBSFAo1E
	WaIQWGRITUyr1wvjCbHd3Ct42N7fkOtMVQ==
X-Google-Smtp-Source: AGHT+IEwTb5TsWR/DiA0tNn7RkAeE4nGLEIEwlS1meoG5jsuOqpwIW6fzuby1SQCO4+d/WjqKrKg842pwHo/Eg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:77d3:0:b0:da0:3a24:fe25 with SMTP id
 s202-20020a2577d3000000b00da03a24fe25mr44305ybc.9.1702030367265; Fri, 08 Dec
 2023 02:12:47 -0800 (PST)
Date: Fri,  8 Dec 2023 10:12:43 +0000
In-Reply-To: <20231208101244.1019034-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208101244.1019034-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208101244.1019034-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] ipv6: annotate data-races around np->mcast_oif
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

np->mcast_oif is read locklessly in some contexts.

Make all accesses to this field lockless, adding appropriate
annotations.

This also makes setsockopt( IPV6_MULTICAST_IF ) lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/dccp/ipv6.c                 |  2 +-
 net/ipv6/datagram.c             |  4 +-
 net/ipv6/icmp.c                 |  4 +-
 net/ipv6/ipv6_sockglue.c        | 74 +++++++++++++++++----------------
 net/ipv6/ping.c                 |  4 +-
 net/ipv6/raw.c                  |  2 +-
 net/ipv6/tcp_ipv6.c             |  2 +-
 net/ipv6/udp.c                  |  2 +-
 net/l2tp/l2tp_ip6.c             |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 net/rds/tcp_listen.c            |  2 +-
 11 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 4550b680665a57ab9648b12645a632d54af69ab4..06d7324276eccff4df93ae82acfd2ddd3fd8ccf2 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -669,7 +669,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 ipv6_pktoptions:
 	if (!((1 << sk->sk_state) & (DCCPF_CLOSED | DCCPF_LISTEN))) {
 		if (np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo)
-			np->mcast_oif = inet6_iif(opt_skb);
+			WRITE_ONCE(np->mcast_oif, inet6_iif(opt_skb));
 		if (np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim)
 			WRITE_ONCE(np->mcast_hops, ipv6_hdr(opt_skb)->hop_limit);
 		if (np->rxopt.bits.rxflow || np->rxopt.bits.rxtclass)
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index cc6a502db39d2e446c39656ccc398e6ac20abf6b..1804bd6f46840f39deb3ceeb7835cd167e1ec86c 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -60,7 +60,7 @@ static void ip6_datagram_flow_key_init(struct flowi6 *fl6,
 
 	if (!oif) {
 		if (ipv6_addr_is_multicast(&fl6->daddr))
-			oif = np->mcast_oif;
+			oif = READ_ONCE(np->mcast_oif);
 		else
 			oif = np->ucast_oif;
 	}
@@ -229,7 +229,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
 		}
 
 		if (!sk->sk_bound_dev_if && (addr_type & IPV6_ADDR_MULTICAST))
-			WRITE_ONCE(sk->sk_bound_dev_if, np->mcast_oif);
+			WRITE_ONCE(sk->sk_bound_dev_if, READ_ONCE(np->mcast_oif));
 
 		/* Connect to link-local address requires an interface */
 		if (!sk->sk_bound_dev_if) {
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index f62427097126984214e0c757b935eea5418ce541..f84a465c9759b6c3d43a80a65dac32d516219c60 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -584,7 +584,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	tmp_hdr.icmp6_pointer = htonl(info);
 
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
-		fl6.flowi6_oif = np->mcast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
 		fl6.flowi6_oif = np->ucast_oif;
 
@@ -770,7 +770,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	np = inet6_sk(sk);
 
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
-		fl6.flowi6_oif = np->mcast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
 		fl6.flowi6_oif = np->ucast_oif;
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 7d661735cb9d519ab4691979f30365acda0a28c3..fe7e96e69960c013e84b48242e309525f7f618da 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -509,6 +509,34 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		if (optlen < sizeof(int))
 			return -EINVAL;
 		return ip6_sock_set_addr_preferences(sk, val);
+	case IPV6_MULTICAST_IF:
+		if (sk->sk_type == SOCK_STREAM)
+			return -ENOPROTOOPT;
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val) {
+			struct net_device *dev;
+			int bound_dev_if, midx;
+
+			rcu_read_lock();
+
+			dev = dev_get_by_index_rcu(net, val);
+			if (!dev) {
+				rcu_read_unlock();
+				return -ENODEV;
+			}
+			midx = l3mdev_master_ifindex_rcu(dev);
+
+			rcu_read_unlock();
+
+			bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
+			if (bound_dev_if &&
+			    bound_dev_if != val &&
+			    (!midx || midx != bound_dev_if))
+				return -EINVAL;
+		}
+		WRITE_ONCE(np->mcast_oif, val);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -860,36 +888,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
-	case IPV6_MULTICAST_IF:
-		if (sk->sk_type == SOCK_STREAM)
-			break;
-		if (optlen < sizeof(int))
-			goto e_inval;
-
-		if (val) {
-			struct net_device *dev;
-			int midx;
-
-			rcu_read_lock();
-
-			dev = dev_get_by_index_rcu(net, val);
-			if (!dev) {
-				rcu_read_unlock();
-				retv = -ENODEV;
-				break;
-			}
-			midx = l3mdev_master_ifindex_rcu(dev);
-
-			rcu_read_unlock();
-
-			if (sk->sk_bound_dev_if &&
-			    sk->sk_bound_dev_if != val &&
-			    (!midx || midx != sk->sk_bound_dev_if))
-				goto e_inval;
-		}
-		np->mcast_oif = val;
-		retv = 0;
-		break;
 	case IPV6_ADD_MEMBERSHIP:
 	case IPV6_DROP_MEMBERSHIP:
 	{
@@ -1161,10 +1159,12 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		sockopt_release_sock(sk);
 		if (!skb) {
 			if (np->rxopt.bits.rxinfo) {
+				int mcast_oif = READ_ONCE(np->mcast_oif);
 				struct in6_pktinfo src_info;
-				src_info.ipi6_ifindex = np->mcast_oif ? np->mcast_oif :
+
+				src_info.ipi6_ifindex = mcast_oif ? :
 					np->sticky_pktinfo.ipi6_ifindex;
-				src_info.ipi6_addr = np->mcast_oif ? sk->sk_v6_daddr : np->sticky_pktinfo.ipi6_addr;
+				src_info.ipi6_addr = mcast_oif ? sk->sk_v6_daddr : np->sticky_pktinfo.ipi6_addr;
 				put_cmsg(&msg, SOL_IPV6, IPV6_PKTINFO, sizeof(src_info), &src_info);
 			}
 			if (np->rxopt.bits.rxhlim) {
@@ -1178,11 +1178,13 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 				put_cmsg(&msg, SOL_IPV6, IPV6_TCLASS, sizeof(tclass), &tclass);
 			}
 			if (np->rxopt.bits.rxoinfo) {
+				int mcast_oif = READ_ONCE(np->mcast_oif);
 				struct in6_pktinfo src_info;
-				src_info.ipi6_ifindex = np->mcast_oif ? np->mcast_oif :
+
+				src_info.ipi6_ifindex = mcast_oif ? :
 					np->sticky_pktinfo.ipi6_ifindex;
-				src_info.ipi6_addr = np->mcast_oif ? sk->sk_v6_daddr :
-								     np->sticky_pktinfo.ipi6_addr;
+				src_info.ipi6_addr = mcast_oif ? sk->sk_v6_daddr :
+								 np->sticky_pktinfo.ipi6_addr;
 				put_cmsg(&msg, SOL_IPV6, IPV6_2292PKTINFO, sizeof(src_info), &src_info);
 			}
 			if (np->rxopt.bits.rxohlim) {
@@ -1359,7 +1361,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_MULTICAST_IF:
-		val = np->mcast_oif;
+		val = READ_ONCE(np->mcast_oif);
 		break;
 
 	case IPV6_MULTICAST_ALL:
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index d2098dd4ceaea5545a8f23495039c16f1061cd94..465e8d0040671f689e0e5e1f24c024c356ce0fd1 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -107,7 +107,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		oif = np->sticky_pktinfo.ipi6_ifindex;
 
 	if (!oif && ipv6_addr_is_multicast(daddr))
-		oif = np->mcast_oif;
+		oif = READ_ONCE(np->mcast_oif);
 	else if (!oif)
 		oif = np->ucast_oif;
 
@@ -157,7 +157,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	rt = (struct rt6_info *) dst;
 
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
-		fl6.flowi6_oif = np->mcast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
 		fl6.flowi6_oif = np->ucast_oif;
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index dd0a4e73e60259403906757630fd2c1ce4f9d46a..59a1e269a82c1af6eb73570ef7a43e0f0f61ab80 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -876,7 +876,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	final_p = fl6_update_dst(&fl6, opt, &final);
 
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
-		fl6.flowi6_oif = np->mcast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
 		fl6.flowi6_oif = np->ucast_oif;
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 06a19fe2afd1a4882f2a690507208a7aea9704da..d1307d77a6f094e49ea14c525820ba7635d0aa7c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1702,7 +1702,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (TCP_SKB_CB(opt_skb)->end_seq == tp->rcv_nxt &&
 	    !((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 		if (np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo)
-			np->mcast_oif = tcp_v6_iif(opt_skb);
+			WRITE_ONCE(np->mcast_oif, tcp_v6_iif(opt_skb));
 		if (np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim)
 			WRITE_ONCE(np->mcast_hops,
 				   ipv6_hdr(opt_skb)->hop_limit);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 622b10a549f7510d72232fbe70dea5f07c1fe5ed..0b7c755faa77b1ddd4feb5dea185f6dd7be45091 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1541,7 +1541,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		connected = false;
 
 	if (!fl6->flowi6_oif && ipv6_addr_is_multicast(&fl6->daddr)) {
-		fl6->flowi6_oif = np->mcast_oif;
+		fl6->flowi6_oif = READ_ONCE(np->mcast_oif);
 		connected = false;
 	} else if (!fl6->flowi6_oif)
 		fl6->flowi6_oif = np->ucast_oif;
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index bb373e249237a77fb07c049478470d14360eb179..17301f9dd228db80be1bdc3cb858ac41d5268e36 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -599,7 +599,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	final_p = fl6_update_dst(&fl6, opt, &final);
 
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
-		fl6.flowi6_oif = np->mcast_oif;
+		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
 	else if (!fl6.flowi6_oif)
 		fl6.flowi6_oif = np->ucast_oif;
 
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index eaf9f2ed00675aba16a10b7470c0264996197b04..be74c0906dda92e13e2ddef6cebd268c955d5336 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1365,7 +1365,7 @@ static int set_mcast_if(struct sock *sk, struct net_device *dev)
 		struct ipv6_pinfo *np = inet6_sk(sk);
 
 		/* IPV6_MULTICAST_IF */
-		np->mcast_oif = dev->ifindex;
+		WRITE_ONCE(np->mcast_oif, dev->ifindex);
 	}
 #endif
 	release_sock(sk);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 53b3535a1e4a84c3e5ae9dee110af2df376c7f20..05008ce5c4219f8a23e08cd2a295b217697f5606 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -165,7 +165,7 @@ int rds_tcp_accept_one(struct socket *sock)
 		struct ipv6_pinfo *inet6;
 
 		inet6 = inet6_sk(new_sock->sk);
-		dev_if = inet6->mcast_oif;
+		dev_if = READ_ONCE(inet6->mcast_oif);
 	} else {
 		dev_if = new_sock->sk->sk_bound_dev_if;
 	}
-- 
2.43.0.472.g3155946c3a-goog


