Return-Path: <netdev+bounces-22316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FD767021
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8CF2822F3
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614514A94;
	Fri, 28 Jul 2023 15:03:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304115495
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:48 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE82115
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56cf9a86277so21710807b3.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556621; x=1691161421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnAw1rBXJ9A8tSxeUzSRBobIP1ItV7w7jQIdz6xgu4E=;
        b=UPWSr0Z74+g+kR1ZH+4ywaznXdjbxImnoIM/4L19C9z/nHGSbj1ySrDbOoFSFIOaE/
         hfEQTKWVHSMta97g0nMJk0TWb/uw/k2Qi42v28gIj+OhfQG1zRh4tUnjVdT9XT2/ydUE
         eAKrta6YqJVumRbF51gvoZgq+Rfgd90q3m32ADqUobKxaAwzqoIIQ0QqMRglIMqFChxJ
         UbYhWPlbjg7S2xOmRkuWGdoEM1IC+9WDb/QJPbyDUlthFEi5hUelRwUOdLq5ZkQDJvJA
         P0achecZC9ejOh4KF+wKrgea2Jx6cDI8W9kC6X9FSslqLgpJZFs4kxBd6EOFhM6Rh/B5
         8I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556621; x=1691161421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnAw1rBXJ9A8tSxeUzSRBobIP1ItV7w7jQIdz6xgu4E=;
        b=ZII7Q2JoV95YZqQ5z6iRWrDjI8/f7BlaACbRjfuYAuM0R/27ioWQFCE0kvv1gWS7cF
         1pU7k6w5Paky/X92cSfDixSdLCW+aSTJDZn5s8mM4tx42n/PkXSxeAfUjr0x4F9oWM2C
         O1G/Ljjdk4KzeFdarmo6WO6hqeiz1m8pIHl+m9m3Fp0wrjdYYOoQuTZ9Pk4U0LWaHQl6
         jr0mqnWrKZ3D0V5J6mSqLTxyeOsvOAzkweMjiEADuq8n5TsaC/xu54cM+AM/vu+YQbuO
         J/uCaF8cqfBL/MvlQYjGTIbTSsPetJcRKK/LNSYy63MNy1bzmt9bZw3AZvDM36sJQqcO
         8i3g==
X-Gm-Message-State: ABy/qLaVQbXlOYeWztlk52hdaMb9KJIu8BggTSKHT4HRMg62rZFEphDO
	yvaYe92ZFtG+gnNyy+ufdbPieh1aNV7chw==
X-Google-Smtp-Source: APBJJlHtMXE9UkNi+4tH+e1ZqM1qqtxiy63SBmo3CDU/ktmQQZtlpsqoPVPWi1wAVv58Cxts+BHco88HWi4K4A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:711:b0:583:591d:3d6c with SMTP
 id bs17-20020a05690c071100b00583591d3d6cmr14956ywb.0.1690556620818; Fri, 28
 Jul 2023 08:03:40 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:18 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-12-edumazet@google.com>
Subject: [PATCH net 11/11] net: annotate data-races around sk->sk_priority
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_getsockopt() runs locklessly. This means sk->sk_priority
can be read while other threads are changing its value.

Other reads also happen without socket lock being held.

Add missing annotations where needed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c        | 6 +++---
 net/ipv4/ip_output.c   | 4 ++--
 net/ipv4/ip_sockglue.c | 2 +-
 net/ipv4/raw.c         | 2 +-
 net/ipv4/tcp_ipv4.c    | 2 +-
 net/ipv6/raw.c         | 2 +-
 net/ipv6/tcp_ipv6.c    | 3 ++-
 net/packet/af_packet.c | 6 +++---
 8 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f11e19c7edfb46475b32cee3d1af1df45442f40c..6d4f28efe29a7f154948848b5bde377e781a9135 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -806,7 +806,7 @@ EXPORT_SYMBOL(sock_no_linger);
 void sock_set_priority(struct sock *sk, u32 priority)
 {
 	lock_sock(sk);
-	sk->sk_priority = priority;
+	WRITE_ONCE(sk->sk_priority, priority);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(sock_set_priority);
@@ -1216,7 +1216,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		if ((val >= 0 && val <= 6) ||
 		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
 		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-			sk->sk_priority = val;
+			WRITE_ONCE(sk->sk_priority, val);
 		else
 			ret = -EPERM;
 		break;
@@ -1685,7 +1685,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PRIORITY:
-		v.val = sk->sk_priority;
+		v.val = READ_ONCE(sk->sk_priority);
 		break;
 
 	case SO_LINGER:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index bcdbf448324a9c28ceff55764c54074763873296..54d2d3a2d850ed8eccb683c2012557c065d8bbab 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -184,7 +184,7 @@ int ip_build_and_send_pkt(struct sk_buff *skb, const struct sock *sk,
 		ip_options_build(skb, &opt->opt, daddr, rt);
 	}
 
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	if (!skb->mark)
 		skb->mark = READ_ONCE(sk->sk_mark);
 
@@ -528,7 +528,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 			     skb_shinfo(skb)->gso_segs ?: 1);
 
 	/* TODO : should we use skb->sk here instead of sk ? */
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 
 	res = ip_local_out(net, sk, skb);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 8e97d8d4cc9d910a0cc29897be4820b53b019433..d41bce8927b2cca825a804dc113450b62262cc94 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -592,7 +592,7 @@ void __ip_sock_set_tos(struct sock *sk, int val)
 	}
 	if (inet_sk(sk)->tos != val) {
 		inet_sk(sk)->tos = val;
-		sk->sk_priority = rt_tos2priority(val);
+		WRITE_ONCE(sk->sk_priority, rt_tos2priority(val));
 		sk_dst_reset(sk);
 	}
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 7782ff5e65399b4d0c8ac5d25b8d999b0a1a2e71..cb381f5aa46438394cdec520a99f7a8bc67fcfb9 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -348,7 +348,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto error;
 	skb_reserve(skb, hlen);
 
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
 	skb_dst_set(skb, &rt->dst);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 894653be033a508d2169738ec32831438fbc614f..a59cc4b8386113577d966a3efce53a13f51e8b06 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -933,7 +933,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_mark : READ_ONCE(sk->sk_mark);
 	ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
-			   inet_twsk(sk)->tw_priority : sk->sk_priority;
+			   inet_twsk(sk)->tw_priority : READ_ONCE(sk->sk_priority);
 	transmit_time = tcp_transmit_time(sk);
 	ip_send_unicast_reply(ctl_sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 39b7d727ba40793a61f2e02044666551dd091eda..49381f35b623c4fd717e44f7a6058965bb54a56f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -614,7 +614,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3ec563742ac4f2c630b961960adc3e5f26976d92..6e86721e1cdbb8d47b754a2675f6ab1643c7342c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1128,7 +1128,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
-			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
+			ipv6_get_dsfield(ipv6_hdr(skb)), 0,
+			READ_ONCE(sk->sk_priority),
 			READ_ONCE(tcp_rsk(req)->txhash));
 }
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d9aa21a2b3a16c96416feca6b195769e6b9a91f7..a4631cb457a91f04b9acffcecbddc1624f423257 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2050,7 +2050,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
@@ -2585,7 +2585,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = po->sk.sk_priority;
+	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
 	skb->tstamp = sockc->transmit_time;
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
@@ -3061,7 +3061,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
 	skb->tstamp = sockc.transmit_time;
 
-- 
2.41.0.585.gd2178a4bd4-goog


