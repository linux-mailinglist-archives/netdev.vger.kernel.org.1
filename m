Return-Path: <netdev+bounces-273332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B/dzO/jyymlaBwYAu9opvQ
	(envelope-from <netdev+bounces-273332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54162361B86
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EDB303FFEE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F13A8729;
	Mon, 30 Mar 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWab94tu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D63A7F4A
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907834; cv=none; b=J3rPmAyzZj6byM9LgIywM8d7OChSe97ALDrGAANHPkfgyoESqFSQXwcbMcSWFZh4J8HQ8BzOYrGtzksxnm7/mj1D+TRZfb1oYqsQgj0iGyiO2uVGsf3C/7XO/qfWOeJtclsnofmb4RO+Ewvp9t7WSoEW4BQOqkOEaMiZfNSK0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907834; c=relaxed/simple;
	bh=pz86PmEpfzQN9js8IsuHqblvmjM03Ljb/l6bvN9B5Ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jayst7dxWohwk+dO4ZBNyputOeY/ow1+9LqQl5E91zV8KlMrgVeGKT5C0g7KCtoUKonaCPgRYUjHo0ZW9HmbjZFERb3myeZJCMtMxUkC2CqFL5xhZsLRXQcV46A/n6qJEg4lLqDaOAGiERfhZrZYPvzwObNDrz5Ac38Y9zZuN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWab94tu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b15a3ccfso41076a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907831; x=1775512631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DR2NV2QHTTPddHUWacFog7WO7giZkfHr/2vqRIpwBGM=;
        b=IWab94tuiYPgSu5VWUAq8rtCYBUgGNScAaTJO7B5bAHld/Oc5VVHPx99DPFtBfl5tn
         uWPtguVjaxZZtPRLBHhiUiaPmCwfF7ecUuIcbau7Jw/I0ZYCy9jyDw993GwryOqDoxaR
         3+dUCgB31izbB1jXHimalHiGiKqiDms/foCVBXZE8fLEnSspd8s9tvRv8mVqkE16Xezj
         pPe8bXjD8ifT71CCJ2ye5KwpYA3jTe+rKRXvPa5jgIomCcUi8PS14P9Rn1AtQAxM7mvO
         gCEHM8ejmKsx4r+MAQKlHONhpnLqRI11uAp/iikBvjBQ1YFKZGUF/syjfW3btZFYU9Tj
         SoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907831; x=1775512631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR2NV2QHTTPddHUWacFog7WO7giZkfHr/2vqRIpwBGM=;
        b=IAMl5pVMsdWMriTuzaGAc5IOXHkDpaY1CSpe7h8u/X2JrySn90hgPCH1IZvzQ6Qf3G
         A7CKwTQcREypBJ+6x2MOI/4QLWF/MQzFD41ECgTFa9Ilvs/3wHoItMXUXQSUSjX1rrpl
         gmxW9R0a4msuY0kR5DBTNDE7SxjqPDJgaYdb5sPBV+KHhJAG9YVIU8Og8pq71qEDeZ9x
         5WH3Kb76XU8WFXn5lqwyF6oJawhP2DPkbrR60Obvm56LRdOSNM2x0MVfRwx99hcBtn/b
         GZVqrpYgj+0gGAr5Zabxw4fFL1EucpCyVyWBHJybGczAcBif9hjR2xSfGDDQY/aB0uvl
         Hz0w==
X-Gm-Message-State: AOJu0Yyc2rV1Iwq0O3uXJszHrHmYC12okxkmh5Rta0hEO1wcC9KIIv1w
	ZEOxmY4AhxbQ7IZ+kA/oP9OkTUYJA+TdBLLpG3v7Of0HTscvghTXrtz+1WEyKDroGsYe/o269nY
	CyqKSwz+DOwc5qlz96C1SW4jc3SvvuAzxVEl7cfpE57KzWnsYT+Lft64o4eHe9B1shrMEaQlOgN
	wNfb9Yve9w7dj1jtrdB0+ykrPamszt3m0=
X-Received: from pgg12.prod.google.com ([2002:a05:6a02:4d8c:b0:c73:bade:9641])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9187:b0:398:4c9f:d970
 with SMTP id adf61e73a8af0-39c877a9973mr13050112637.14.1774907830685; Mon, 30
 Mar 2026 14:57:10 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:01 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-2-jrife@google.com>
Subject: [PATCH net-next v3 1/4] udp: Only compare daddr/dport when sk_state
 == TCP_ESTABLISHED
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54162361B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adjust lookups and scoring to keep their results equivalent to before
even if inet_daddr+inet_dport are left intact after disconnecting a
socket (sk_state == TCP_CLOSE). sk_state == TCP_ESTABLISHED implies that
*daddr is non-zero, so remove redundant checks for that at the same
time. Note that __udp6_lib_demux_lookup already checks if sk_state ==
TCP_ESTABLISHED, so no change was needed there [1].

I could find no discernible difference in performance in
udp4_lib_lookup2 before and after the change in compute_score.

(AMD Ryzen 9 9900X)

kprobe:udp4_lib_lookup2 {
        @start[cpu] = nsecs;
}
kretprobe:udp4_lib_lookup2 {
        @lookup[cpu] = hist(nsecs - @start[cpu], 2);
}

BEFORE
======
@lookup[11]:
[80, 96)         1387077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[96, 112)         364973 |@@@@@@@@@@@@@                                       |
[112, 128)         34261 |@                                                   |
[128, 160)          7246 |                                                    |
[160, 192)           215 |                                                    |
[192, 224)           126 |                                                    |

AFTER
=====
@lookup[11]:
[80, 96)         1408594 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[96, 112)         340568 |@@@@@@@@@@@@                                        |
[112, 128)         30753 |@                                                   |
[128, 160)          8019 |                                                    |
[160, 192)           231 |                                                    |
[192, 224)           157 |                                                    |

[1]: https://lore.kernel.org/netdev/20170623222537.130493-1-tracywwnj@gmail.com/

Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 20 +++++++++++---------
 net/ipv6/udp.c | 18 +++++++++---------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b60fad393e18..d91c587c3657 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -385,16 +385,16 @@ static int compute_score(struct sock *sk, const struct net *net,
 	score = (sk->sk_family == PF_INET) ? 2 : 1;
 
 	inet = inet_sk(sk);
-	if (inet->inet_daddr) {
+	if (sk->sk_state == TCP_ESTABLISHED) {
 		if (inet->inet_daddr != saddr)
 			return -1;
 		score += 4;
-	}
 
-	if (inet->inet_dport) {
-		if (inet->inet_dport != sport)
-			return -1;
-		score += 4;
+		if (inet->inet_dport) {
+			if (inet->inet_dport != sport)
+				return -1;
+			score += 4;
+		}
 	}
 
 	dev_match = udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if,
@@ -796,8 +796,9 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
 
 	if (!net_eq(sock_net(sk), net) ||
 	    udp_sk(sk)->udp_port_hash != hnum ||
-	    (inet->inet_daddr && inet->inet_daddr != rmt_addr) ||
-	    (inet->inet_dport != rmt_port && inet->inet_dport) ||
+	    (sk->sk_state == TCP_ESTABLISHED &&
+	     (inet->inet_daddr != rmt_addr ||
+	     (inet->inet_dport != rmt_port && inet->inet_dport))) ||
 	    (inet->inet_rcv_saddr && inet->inet_rcv_saddr != loc_addr) ||
 	    ipv6_only_sock(sk) ||
 	    !udp_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
@@ -2854,7 +2855,8 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 	ports = INET_COMBINED_PORTS(rmt_port, hnum);
 
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		if (inet_match(net, sk, acookie, ports, dif, sdif))
+		if (sk->sk_state == TCP_ESTABLISHED &&
+		    inet_match(net, sk, acookie, ports, dif, sdif))
 			return sk;
 		/* Only check first socket in chain */
 		break;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd..b93a9a3e7678 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -147,16 +147,16 @@ static int compute_score(struct sock *sk, const struct net *net,
 	score = 0;
 	inet = inet_sk(sk);
 
-	if (inet->inet_dport) {
+	if (sk->sk_state == TCP_ESTABLISHED) {
 		if (inet->inet_dport != sport)
 			return -1;
 		score++;
-	}
 
-	if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
-		if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
-			return -1;
-		score++;
+		if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
+			if (!ipv6_addr_equal(&sk->sk_v6_daddr, saddr))
+				return -1;
+			score++;
+		}
 	}
 
 	bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
@@ -949,9 +949,9 @@ static bool __udp_v6_is_mcast_sock(struct net *net, const struct sock *sk,
 
 	if (udp_sk(sk)->udp_port_hash != hnum ||
 	    sk->sk_family != PF_INET6 ||
-	    (inet->inet_dport && inet->inet_dport != rmt_port) ||
-	    (!ipv6_addr_any(&sk->sk_v6_daddr) &&
-		    !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr)) ||
+	    (sk->sk_state == TCP_ESTABLISHED &&
+	     ((inet->inet_dport && inet->inet_dport != rmt_port) ||
+	     !ipv6_addr_equal(&sk->sk_v6_daddr, rmt_addr))) ||
 	    !udp_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif, sdif) ||
 	    (!ipv6_addr_any(&sk->sk_v6_rcv_saddr) &&
 		    !ipv6_addr_equal(&sk->sk_v6_rcv_saddr, loc_addr)))
-- 
2.53.0.1118.gaef5881109-goog


