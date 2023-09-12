Return-Path: <netdev+bounces-33312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8879D5D4
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD561C21191
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913418C39;
	Tue, 12 Sep 2023 16:02:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86001DDCD
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:39 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497E1727
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so5509217276.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534558; x=1695139358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3UokpWe9JfVipQe+DYyi8ngg3N0Wmlo327GB+zbLKc=;
        b=YcPHF09BazosEjByLm16FeD1v90ai0O/RTN5DhYOVulviRd9cdcrgUUP1mq/sg4R7u
         xvyMzcii+t9NYHwf0vY6DehpNpj6ckfW41xt51C9gOPymt+0G1sJov1Tns90RB1pnx7j
         bsLf102ssNpicAHhftfXd+xFv87FXpEv/jzKREYkSjD51pE3eAeetC1+t8kpFKG/bp5D
         NRuPpplHtF5YwJnfug3Q0yY9fh5cpYTD7k2FgNOqa1ghrixa93abR47WQm82Ra+dAbKm
         6xarC0H3mPLo3FGd82Nwnow3gsHADaThjgPsQWJbPC2HuBoS/WeaiGoYLbVh/9mo5J6F
         qtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534558; x=1695139358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3UokpWe9JfVipQe+DYyi8ngg3N0Wmlo327GB+zbLKc=;
        b=TO9Agjv+hHi+2YYVPngGX9HgtoRNcFInrVKCrL6uzobT3FfDBxnctzuFhXrqrTNAvS
         Oey3sl+dORfEqsWtSRJ+dpmpcJ9gXqX3kfUNTiGgCUIxo0zer6Jwq8I1n4UJHQ5lBxlf
         K6wgtqP1YUX3y88QBHKPYLNIRwbXC0Nw18CVP5E07X+6C5upB+OoPnSojosebDC5H2GT
         d36r7MpMepdNFyKEzZhS38kSYyBlIFyio9VJp+siA1FN/NERgq2+C3i1vhrerTjBZjV1
         L7Myy3htwNzvhSizTLIkZRFKKJhRt2nXlN2UqiA4Jdg40VnVEpVGrKu/gTIahiiOkk+f
         D8Lg==
X-Gm-Message-State: AOJu0YzVgnlyvQcNqVQ0HzpXl+qqfYwShhDopGlGB/OYkKhoQh4kyTeH
	5yKWAOTx+ZXKfIfi1OaZGNPLmTsOSLjKkQ==
X-Google-Smtp-Source: AGHT+IGWS9Xt4c9n//2g6UG9XjSpiEhmJwCy6HSFODkRxJldGqLtF1k/kBlKZS8gc0uGpuyK80+hwRPVnjeQ7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1682:b0:d7b:8d0c:43f1 with SMTP
 id bx2-20020a056902168200b00d7b8d0c43f1mr314095ybb.9.1694534558397; Tue, 12
 Sep 2023 09:02:38 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:12 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-15-edumazet@google.com>
Subject: [PATCH net-next 14/14] ipv6: lockless IPV6_FLOWINFO_SEND implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

np->sndflow reads are racy.

Use one bit ftom atomic inet->inet_flags instead,
IPV6_FLOWINFO_SEND setsockopt() can be lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  3 +--
 include/net/inet_sock.h  |  1 +
 net/dccp/ipv6.c          |  2 +-
 net/ipv4/ping.c          |  3 +--
 net/ipv6/af_inet6.c      |  2 +-
 net/ipv6/datagram.c      |  7 ++++---
 net/ipv6/ipv6_sockglue.c | 13 ++++++-------
 net/ipv6/ping.c          |  2 +-
 net/ipv6/raw.c           |  2 +-
 net/ipv6/tcp_ipv6.c      |  2 +-
 net/ipv6/udp.c           |  2 +-
 net/l2tp/l2tp_ip6.c      |  4 ++--
 net/sctp/ipv6.c          |  3 ++-
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 10f521a6a9c8a881b4677d53597929622ae95b67..09253825c99c7a94c4c8a3f176f0ceecd0b166bc 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -243,8 +243,7 @@ struct ipv6_pinfo {
 	} rxopt;
 
 	/* sockopt flags */
-	__u8			sndflow:1,
-				srcprefs:3;	/* 001: prefer temporary address
+	__u8			srcprefs:3;	/* 001: prefer temporary address
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index befee0f66c0555f3ac4524fd8f7780ff21c04aaa..98e11958cdff688249fddf1893ce06b45ecb68d9 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -277,6 +277,7 @@ enum {
 	INET_FLAGS_RECVERR6	= 26,
 	INET_FLAGS_REPFLOW	= 27,
 	INET_FLAGS_RTALERT_ISOLATE = 28,
+	INET_FLAGS_SNDFLOW	= 29,
 };
 
 /* cmsg flags for inet */
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index d7e63eea705dfe5c40d374301f93987e1c34748b..4803f06148488b07ba027138c93014d2b5fa28db 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -844,7 +844,7 @@ static int dccp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	memset(&fl6, 0, sizeof(fl6));
 
-	if (np->sndflow) {
+	if (inet6_test_bit(SNDFLOW, sk)) {
 		fl6.flowlabel = usin->sin6_flowinfo & IPV6_FLOWINFO_MASK;
 		IP6_ECN_flow_init(fl6.flowlabel);
 		if (fl6.flowlabel & IPV6_FLOWLABEL_MASK) {
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index bc01ad5fc01ab97f71f7704a671eaf644ec040be..4dd809b7b18867154df42bc28809b886913e253c 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -899,7 +899,6 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (family == AF_INET6) {
-		struct ipv6_pinfo *np = inet6_sk(sk);
 		struct ipv6hdr *ip6 = ipv6_hdr(skb);
 		DECLARE_SOCKADDR(struct sockaddr_in6 *, sin6, msg->msg_name);
 
@@ -908,7 +907,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 			sin6->sin6_port = 0;
 			sin6->sin6_addr = ip6->saddr;
 			sin6->sin6_flowinfo = 0;
-			if (np->sndflow)
+			if (inet6_test_bit(SNDFLOW, sk))
 				sin6->sin6_flowinfo = ip6_flowinfo(ip6);
 			sin6->sin6_scope_id =
 				ipv6_iface_scope_id(&sin6->sin6_addr,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 48737363377fef32f471075fd3f000bc742fd4e4..c6ad0d6e99b5e2259648e260e2cad54f34c90cfd 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -537,7 +537,7 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 		}
 		sin->sin6_port = inet->inet_dport;
 		sin->sin6_addr = sk->sk_v6_daddr;
-		if (np->sndflow)
+		if (inet6_test_bit(SNDFLOW, sk))
 			sin->sin6_flowinfo = np->flow_label;
 		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin,
 				       CGROUP_INET6_GETPEERNAME);
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 74673a5eff319f23871e64584a33f5299fa7b521..cc6a502db39d2e446c39656ccc398e6ac20abf6b 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -80,7 +80,8 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 	struct flowi6 fl6;
 	int err = 0;
 
-	if (np->sndflow && (np->flow_label & IPV6_FLOWLABEL_MASK)) {
+	if (inet6_test_bit(SNDFLOW, sk) &&
+	    (np->flow_label & IPV6_FLOWLABEL_MASK)) {
 		flowlabel = fl6_sock_lookup(sk, np->flow_label);
 		if (IS_ERR(flowlabel))
 			return -EINVAL;
@@ -163,7 +164,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
 	if (usin->sin6_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
-	if (np->sndflow)
+	if (inet6_test_bit(SNDFLOW, sk))
 		fl6_flowlabel = usin->sin6_flowinfo & IPV6_FLOWINFO_MASK;
 
 	if (ipv6_addr_any(&usin->sin6_addr)) {
@@ -491,7 +492,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 			const struct ipv6hdr *ip6h = container_of((struct in6_addr *)(nh + serr->addr_offset),
 								  struct ipv6hdr, daddr);
 			sin->sin6_addr = ip6h->daddr;
-			if (np->sndflow)
+			if (inet6_test_bit(SNDFLOW, sk))
 				sin->sin6_flowinfo = ip6_flowinfo(ip6h);
 			sin->sin6_scope_id =
 				ipv6_iface_scope_id(&sin->sin6_addr,
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 85ea42644dcbbe3ed8f625e51ffc6d55ada40156..e9dc6f881bb92db267903a71f3f3e4de4c557819 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -500,6 +500,11 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(np->pmtudisc, val);
 		return 0;
+	case IPV6_FLOWINFO_SEND:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		inet6_assign_bit(SNDFLOW, sk, valbool);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -948,12 +953,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		retv = ip6_ra_control(sk, val);
 		break;
-	case IPV6_FLOWINFO_SEND:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		np->sndflow = valbool;
-		retv = 0;
-		break;
 	case IPV6_FLOWLABEL_MGR:
 		retv = ipv6_flowlabel_opt(sk, optval, optlen);
 		break;
@@ -1381,7 +1380,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_FLOWINFO_SEND:
-		val = np->sndflow;
+		val = inet6_test_bit(SNDFLOW, sk);
 		break;
 
 	case IPV6_FLOWLABEL_MGR:
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 4444b61eb23bbf483068d2b119a7559e49ba3880..e8fb0d275cc2d9adf997f944a42a8fc456f8b950 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -89,7 +89,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			return -EAFNOSUPPORT;
 		}
 		daddr = &(u->sin6_addr);
-		if (np->sndflow)
+		if (inet6_test_bit(SNDFLOW, sk))
 			fl6.flowlabel = u->sin6_flowinfo & IPV6_FLOWINFO_MASK;
 		if (__ipv6_addr_needs_scope_id(ipv6_addr_type(daddr)))
 			oif = u->sin6_scope_id;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 47372cceb98f6e606346b74230b03e76e303822c..a2aa54a2baaec0169fecd490588a2cd4e8a2f2d7 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -795,7 +795,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			return -EINVAL;
 
 		daddr = &sin6->sin6_addr;
-		if (np->sndflow) {
+		if (inet6_test_bit(SNDFLOW, sk)) {
 			fl6.flowlabel = sin6->sin6_flowinfo&IPV6_FLOWINFO_MASK;
 			if (fl6.flowlabel&IPV6_FLOWLABEL_MASK) {
 				flowlabel = fl6_sock_lookup(sk, fl6.flowlabel);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 201caf88bb99e4ff87048fab3d89b6ea22269df3..94afb8d0f2d0e4974c3dbe4e3301f0152b5cb9e1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -163,7 +163,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	memset(&fl6, 0, sizeof(fl6));
 
-	if (np->sndflow) {
+	if (inet6_test_bit(SNDFLOW, sk)) {
 		fl6.flowlabel = usin->sin6_flowinfo&IPV6_FLOWINFO_MASK;
 		IP6_ECN_flow_init(fl6.flowlabel);
 		if (fl6.flowlabel&IPV6_FLOWLABEL_MASK) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 97fabbd7e7aa8bf66bfe21a98f97d4408af13d2b..b55e23ba1da53eba2ee4c468e30f9428a6fee3a7 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1427,7 +1427,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		fl6->fl6_dport = sin6->sin6_port;
 		daddr = &sin6->sin6_addr;
 
-		if (np->sndflow) {
+		if (inet6_test_bit(SNDFLOW, sk)) {
 			fl6->flowlabel = sin6->sin6_flowinfo&IPV6_FLOWINFO_MASK;
 			if (fl6->flowlabel & IPV6_FLOWLABEL_MASK) {
 				flowlabel = fl6_sock_lookup(sk, fl6->flowlabel);
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 40af2431e73aad74ab64e97db8a5ee79dda0879d..44cfb72bbd18a34e83e50bebca09729c55df524f 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -431,7 +431,7 @@ static int l2tp_ip6_getname(struct socket *sock, struct sockaddr *uaddr,
 			return -ENOTCONN;
 		lsa->l2tp_conn_id = lsk->peer_conn_id;
 		lsa->l2tp_addr = sk->sk_v6_daddr;
-		if (np->sndflow)
+		if (inet6_test_bit(SNDFLOW, sk))
 			lsa->l2tp_flowinfo = np->flow_label;
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -529,7 +529,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			return -EAFNOSUPPORT;
 
 		daddr = &lsa->l2tp_addr;
-		if (np->sndflow) {
+		if (inet6_test_bit(SNDFLOW, sk)) {
 			fl6.flowlabel = lsa->l2tp_flowinfo & IPV6_FLOWINFO_MASK;
 			if (fl6.flowlabel & IPV6_FLOWLABEL_MASK) {
 				flowlabel = fl6_sock_lookup(sk, fl6.flowlabel);
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 42b5b853ea01c767e1fe878772eeabe5c05adb6d..5c0ed5909d85a1fc137e8652e32df75d8bef28ac 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -296,7 +296,8 @@ static void sctp_v6_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	if (t->flowlabel & SCTP_FLOWLABEL_SET_MASK)
 		fl6->flowlabel = htonl(t->flowlabel & SCTP_FLOWLABEL_VAL_MASK);
 
-	if (np->sndflow && (fl6->flowlabel & IPV6_FLOWLABEL_MASK)) {
+	if (inet6_test_bit(SNDFLOW, sk) &&
+	    (fl6->flowlabel & IPV6_FLOWLABEL_MASK)) {
 		struct ip6_flowlabel *flowlabel;
 
 		flowlabel = fl6_sock_lookup(sk, fl6->flowlabel);
-- 
2.42.0.283.g2d96d420d3-goog


