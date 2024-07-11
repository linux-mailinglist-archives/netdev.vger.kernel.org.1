Return-Path: <netdev+bounces-110738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB992E092
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D02281CF6
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A412F385;
	Thu, 11 Jul 2024 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI8F6Cmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724961C14
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681827; cv=none; b=tRqTGKbsfmXJyXIZD860XdYCgwxdMvALNWZ3mMxQSN/gj+VuyY0vm+HVZ9QHwV1+LAcjXixTXq/kT1vzfFyTLmZCpECKr1N81U1tVLWCHPetMPR81aB+G3tp+Ax+b24R8F9wWgeduGS8WqR9mF74DBRXyfxRoLUnqMbBNA4PAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681827; c=relaxed/simple;
	bh=Jwgxn6QRrGIp4HnROBaTNzYccHHrQAdP0Gcpybn7FuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kkq4Rnf56PqsBLJdMz+2sgQG9dx8SiW7HCD6ZXqLwIH26m70naO/Hc6gKCgQSBHxkpALcdRm3EEp1NvZtoDvhgTRWnUh/TrzrnjMjLeuNL5KUQf1R62wnpg8ks7ekir0abbpfywJBRclYx5Y5aPZ5KFRdVpmsCYW2x6MIQY3QC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI8F6Cmn; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70446231242so272459a34.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720681823; x=1721286623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hlSpOsS5z8/Oo3Yn1Ax8pkJdp1fKe/m+nvSogPiPVo=;
        b=mI8F6Cmn4whg0Dh+yKCXszalS3stGh1W816yyxz5bZNnkzaVhGYzaNZwMohIsHn7c8
         PhLA4qoolM+f7WafcFK5eJre22zBpyr78FKd5/6gko/wp48/iZj+HKEN+7fdGIzvx8V9
         nCCtySc0AgafMvGEgHqZV36lUjNrQadBsdwbfN9+3KrmucK3RiKRNflW5t1FVrAxHL4a
         rmu7hZGUtI1aNCUYb48q08qIan8pdh5md9OroCH26Znixr5O0UGVeH4bU1zAjEdBZCva
         d7mYSfyNqSntP7r83uc1wo0CUPgF6a9zFQnVz6UGk3+yNy5Pnl5rcnkGlhWeDgeRzxc6
         ZyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681823; x=1721286623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hlSpOsS5z8/Oo3Yn1Ax8pkJdp1fKe/m+nvSogPiPVo=;
        b=jssFj+yqqkNhsyGyzMVu6hlgXWK4f4SYrGeVWHLbxoQcEsLIpIb5kxg1eilufvynKf
         xaDfWSDT0HPQBepklhtJenHHleCHfwtjYv7KXdptplPfmnA2T8vYZcYeqayLq8Gx7nYp
         IqZtpQoS/1pG0wYYxZJ6SP3OUonOspVFcuo9P0/bdxZtXG9Tuenz9kHEKI2wsx//DEp4
         oWtLnNrzf1C742UTtDi4NLT6gNAXsH4TSStaDbOYcaw+iCmFksiaJNFYax/qYgDt9FFB
         aKSe+9mgYH9P28rLc5nblli6TdJ9vrrqREEV2LMXLGpITJ1VnuB9ThKIq5qMtWwde0lx
         qo4g==
X-Gm-Message-State: AOJu0Ywj1K6CX3Y3jhtAr7q4dxghcM8KK6X0hsmc5MdHW2mdz5sHxvvz
	9oyF7FyxS2VfxBZYYfxsvPZCIyVjDZxBujgMpBdP1qqicoF42ZRw
X-Google-Smtp-Source: AGHT+IFtnzM5IkZFDLwzWAygoEDTCP1a5Vria+UgA3dN1E/wyden7Vpij0YWvir3CJRQ2Q9pqDjgGA==
X-Received: by 2002:a05:6870:fb8c:b0:25e:b813:1b5e with SMTP id 586e51a60fabf-25eb8132727mr5435103fac.5.1720681823278;
        Thu, 11 Jul 2024 00:10:23 -0700 (PDT)
Received: from ZANEHE-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5edcdec1sm3855595a12.6.2024.07.11.00.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:10:22 -0700 (PDT)
From: heze0908 <heze0908@gmail.com>
X-Google-Original-From: heze0908 <348067333@qq.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	heze0908@gmail.com,
	kernelxing@tencent.com
Subject: [PATCH net-next] inet: reduce the execution time of getsockname()
Date: Thu, 11 Jul 2024 15:10:17 +0800
Message-Id: <20240711071017.64104-1-348067333@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ze He <zanehe@tencent.com>

Recently, we received feedback regarding an increase
in the time consumption of getsockname() in production.
Therefore, we conducted tests based on the
"getsockname" test item in libmicro. The test results
indicate that compared to the kernel 5.4, the latest
kernel indeed has an increased time consumption
in getsockname().
The test results are as follows:

case_name	kernel 5.4	latest kernel	  diff
----------	-----------	-------------	--------
getsockname	  0.12278 	  0.18246	+48.61%

It was discovered that the introduction of lock_sock() in
commit 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
to solve the data race problem between __inet_hash_connect()
and inet_getname() has led to the increased time consumption.
This patch attempts to propose a lockless solution to replace
the spinlock solution.

We have to solve the race issue without heavy spin lock:
one reader is reading some members in struct inet_sock
while the other writer is trying to modify them. Those
members are "inet_sport" "inet_saddr" "inet_dport"
"inet_rcv_saddr". Therefore, in the path of getname, we
use READ_ONCE to read these data, and correspondingly,
in the path of tcp connect, we use WRITE_ONCE to write
these data.

Using this patch, we conducted the getsockname test again,
and the results are as follows:

case_name       latest kernel   latest kernel(patched)
----------      -----------     ---------------------
getsockname       0.18246             0.14423

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Ze He <zanehe@tencent.com>
---
 include/net/ip.h            |  3 ++-
 net/ipv4/af_inet.c          | 27 +++++++++++++--------------
 net/ipv4/inet_hashtables.c  |  8 ++++----
 net/ipv4/tcp_ipv4.c         |  4 ++--
 net/ipv6/af_inet6.c         | 22 ++++++++++------------
 net/ipv6/inet6_hashtables.c |  2 +-
 net/ipv6/tcp_ipv6.c         |  6 +++---
 7 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index c5606cadb1a5..cec1919cfdd0 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -663,7 +663,8 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 
 static __inline__ void inet_reset_saddr(struct sock *sk)
 {
-	inet_sk(sk)->inet_rcv_saddr = inet_sk(sk)->inet_saddr = 0;
+	WRITE_ONCE(inet_sk(sk)->inet_rcv_saddr, 0);
+	WRITE_ONCE(inet_sk(sk)->inet_saddr, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == PF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..e8c035f23078 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -803,28 +803,27 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
 	int sin_addr_len = sizeof(*sin);
 
 	sin->sin_family = AF_INET;
-	lock_sock(sk);
 	if (peer) {
-		if (!inet->inet_dport ||
+		__be16 dport = READ_ONCE(inet->inet_dport);
+
+		if (!dport ||
 		    (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_SYN_SENT)) &&
-		     peer == 1)) {
-			release_sock(sk);
+		     peer == 1))
 			return -ENOTCONN;
-		}
-		sin->sin_port = inet->inet_dport;
+		sin->sin_port = dport;
 		sin->sin_addr.s_addr = inet->inet_daddr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
-				       CGROUP_INET4_GETPEERNAME);
+		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
+					    CGROUP_INET4_GETPEERNAME, NULL);
 	} else {
-		__be32 addr = inet->inet_rcv_saddr;
+		__be32 addr = READ_ONCE(inet->inet_rcv_saddr);
+
 		if (!addr)
-			addr = inet->inet_saddr;
-		sin->sin_port = inet->inet_sport;
+			addr = READ_ONCE(inet->inet_saddr);
+		sin->sin_port = READ_ONCE(inet->inet_sport);
 		sin->sin_addr.s_addr = addr;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
-				       CGROUP_INET4_GETSOCKNAME);
+		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
+					    CGROUP_INET4_GETSOCKNAME, NULL);
 	}
-	release_sock(sk);
 	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
 	return sin_addr_len;
 }
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 48d0d494185b..9398dbf625b4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -577,7 +577,7 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
 	 * in hash table socket with a funny identity.
 	 */
 	inet->inet_num = lport;
-	inet->inet_sport = htons(lport);
+	WRITE_ONCE(inet->inet_sport, htons(lport));
 	sk->sk_hash = hash;
 	WARN_ON(!sk_unhashed(sk));
 	__sk_nulls_add_node_rcu(sk, &head->chain);
@@ -877,7 +877,7 @@ inet_bhash2_addr_any_hashbucket(const struct sock *sk, const struct net *net, in
 static void inet_update_saddr(struct sock *sk, void *saddr, int family)
 {
 	if (family == AF_INET) {
-		inet_sk(sk)->inet_saddr = *(__be32 *)saddr;
+		WRITE_ONCE(inet_sk(sk)->inet_saddr, *(__be32 *)saddr);
 		sk_rcv_saddr_set(sk, inet_sk(sk)->inet_saddr);
 	}
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1115,7 +1115,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	inet_bind_hash(sk, tb, tb2, port);
 
 	if (sk_unhashed(sk)) {
-		inet_sk(sk)->inet_sport = htons(port);
+		WRITE_ONCE(inet_sk(sk)->inet_sport, htons(port));
 		inet_ehash_nolisten(sk, (struct sock *)tw, NULL);
 	}
 	if (tw)
@@ -1140,7 +1140,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		spin_unlock(lock);
 
 		sk->sk_hash = 0;
-		inet_sk(sk)->inet_sport = 0;
+		WRITE_ONCE(inet_sk(sk)->inet_sport, 0);
 		inet_sk(sk)->inet_num = 0;
 
 		if (tw)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288..041a29d8a0fb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -279,7 +279,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 			WRITE_ONCE(tp->write_seq, 0);
 	}
 
-	inet->inet_dport = usin->sin_port;
+	WRITE_ONCE(inet->inet_dport, usin->sin_port);
 	sk_daddr_set(sk, daddr);
 
 	inet_csk(sk)->icsk_ext_hdr_len = 0;
@@ -348,7 +348,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	inet_bhash2_reset_saddr(sk);
 	ip_rt_put(rt);
 	sk->sk_route_caps = 0;
-	inet->inet_dport = 0;
+	WRITE_ONCE(inet->inet_dport, 0);
 	return err;
 }
 EXPORT_SYMBOL(tcp_v4_connect);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index e03fb9a1dbeb..241bc6d2d0a2 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -532,32 +532,30 @@ int inet6_getname(struct socket *sock, struct sockaddr *uaddr,
 	sin->sin6_family = AF_INET6;
 	sin->sin6_flowinfo = 0;
 	sin->sin6_scope_id = 0;
-	lock_sock(sk);
 	if (peer) {
-		if (!inet->inet_dport ||
+		__be16 dport = READ_ONCE(inet->inet_dport);
+
+		if (!dport ||
 		    (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_SYN_SENT)) &&
-		    peer == 1)) {
-			release_sock(sk);
+		    peer == 1))
 			return -ENOTCONN;
-		}
-		sin->sin6_port = inet->inet_dport;
+		sin->sin6_port = dport;
 		sin->sin6_addr = sk->sk_v6_daddr;
 		if (inet6_test_bit(SNDFLOW, sk))
 			sin->sin6_flowinfo = np->flow_label;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
-				       CGROUP_INET6_GETPEERNAME);
+		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
+					    CGROUP_INET6_GETPEERNAME, NULL);
 	} else {
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 			sin->sin6_addr = np->saddr;
 		else
 			sin->sin6_addr = sk->sk_v6_rcv_saddr;
-		sin->sin6_port = inet->inet_sport;
-		BPF_CGROUP_RUN_SA_PROG(sk, (struct sockaddr *)sin, &sin_addr_len,
-				       CGROUP_INET6_GETSOCKNAME);
+		sin->sin6_port = READ_ONCE(inet->inet_sport);
+		BPF_CGROUP_RUN_SA_PROG_LOCK(sk, (struct sockaddr *)sin, &sin_addr_len,
+					    CGROUP_INET6_GETSOCKNAME, NULL);
 	}
 	sin->sin6_scope_id = ipv6_iface_scope_id(&sin->sin6_addr,
 						 sk->sk_bound_dev_if);
-	release_sock(sk);
 	return sin_addr_len;
 }
 EXPORT_SYMBOL(inet6_getname);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 6db71bb1cd30..d5b191db9dfe 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -302,7 +302,7 @@ static int __inet6_check_established(struct inet_timewait_death_row *death_row,
 	 * in hash table socket with a funny identity.
 	 */
 	inet->inet_num = lport;
-	inet->inet_sport = htons(lport);
+	WRITE_ONCE(inet->inet_sport, htons(lport));
 	sk->sk_hash = hash;
 	WARN_ON(!sk_unhashed(sk));
 	__sk_nulls_add_node_rcu(sk, &head->chain);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 200fea92f12f..f78ab704378a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -293,7 +293,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	/* set the source address */
 	np->saddr = *saddr;
-	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
+	WRITE_ONCE(inet->inet_rcv_saddr, LOOPBACK4_IPV6);
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
 	ip6_dst_store(sk, dst, NULL, NULL);
@@ -305,7 +305,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 
 	tp->rx_opt.mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
 
-	inet->inet_dport = usin->sin6_port;
+	WRITE_ONCE(inet->inet_dport, usin->sin6_port);
 
 	tcp_set_state(sk, TCP_SYN_SENT);
 	err = inet6_hash_connect(tcp_death_row, sk);
@@ -340,7 +340,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	tcp_set_state(sk, TCP_CLOSE);
 	inet_bhash2_reset_saddr(sk);
 failure:
-	inet->inet_dport = 0;
+	WRITE_ONCE(inet->inet_dport, 0);
 	sk->sk_route_caps = 0;
 	return err;
 }
-- 
2.43.5


