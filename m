Return-Path: <netdev+bounces-35647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D477AA75D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 76631282392
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9B81E;
	Fri, 22 Sep 2023 03:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB3ECA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:27 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48371E8
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8486b5e780so2303769276.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354145; x=1695958945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7M/Q/7T6x/PN9/kWnzP0hBNjWHtea6n5jMX/+gU5lM=;
        b=pX10+jINJgkeAIJcphq38Wi/3h/frK2UEw+uLZgTrra1IVzQC2fGmjeDS7n3UwdZAs
         K8cmWRGmv2Ar5IhEi+HD7LMfhaU7zzaGcc8+qXEA+kM9xrXZ3KX/rWTecerhJ1FOMDpU
         esTt61lityxnas/OhrlnilRP6MU4Fy38UyJjBaDBSXS1+PPkW4mkrkomj/2gD8SoKP4s
         auYMo60eDxVzVsqinykgglbAjKCaUjAFMWi7pyK/5/Bo9FrJ7D6X30qIUSnYip9ncvXf
         fbuZquQlEYxYoUl1XGp6lEsENw/fD02FVG0mkWOwm6vFAxGwSFBvmTVdrP3jFHZPZxX6
         up0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354145; x=1695958945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7M/Q/7T6x/PN9/kWnzP0hBNjWHtea6n5jMX/+gU5lM=;
        b=fdlPoeRV/dHBPp/DHSap3P5D+wYFMEh1/2Lw5ajIkpgBcizGIQsGM3tOaN1onER7Oa
         lEv5rXZ1FKERHSObxjtU13rUDzBgJfJ+wglKBf5PgW1z5pSMEKEqD6kEi791gh9Bp1Hx
         9wE1WDhRoPBrM0S8weGZtKtmCKjb0NcIwIjFb1QId01VKcGd4CuuFbvfHq2ge7Xj/T4h
         os7sTiTGWjKYmZYSXxws/eceGQPaI9eyeS1Po3y1cF6oj+eKMg6GnuJjVjZwiqjem56p
         PEUc6JB3fvE5jem9ZSrUnULUJYMkWOeMbCwCRWBLwz0992JjNccCu7RD7wEX6hKdbhFC
         sjZA==
X-Gm-Message-State: AOJu0YwS58zhVSdD0t8hUVsjm4QK0FFg3dhN3v6WJwxVDKiobvGpMUXf
	yOzU6zqKKq99bA0hmHrYDTtPeDDB856Npg==
X-Google-Smtp-Source: AGHT+IFuQWyVuRopUEowbLfIhynKssCoDVKwdwKvdM/hvgE/WmU3O7c69Yhr6XMuwQ5MKAlRSuw1tginMFDaRg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:a8a:b0:d80:183c:92b9 with SMTP
 id cd10-20020a0569020a8a00b00d80183c92b9mr104703ybb.4.1695354145236; Thu, 21
 Sep 2023 20:42:25 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:14 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/8] inet: implement lockless IP_MULTICAST_TTL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->mc_ttl can be read locklessly.

Implement proper lockless reads and writes to inet->mc_ttl

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/ip_output.c            |  2 +-
 net/ipv4/ip_sockglue.c          | 31 ++++++++++++++++---------------
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4ab877cf6d35f229761986d5c6a17eb2a3ad4043..adad16f1e872ce20941a087b3965fdb040868d4e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1430,7 +1430,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	if (cork->ttl != 0)
 		ttl = cork->ttl;
 	else if (rt->rt_type == RTN_MULTICAST)
-		ttl = inet->mc_ttl;
+		ttl = READ_ONCE(inet->mc_ttl);
 	else
 		ttl = ip_select_ttl(inet, &rt->dst);
 
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cce9cb25f3b31cd57fa883ae0dedb6829d8da2fa..4ad3003378ae6b186513000264f77b54a7babe6d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1039,6 +1039,17 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 
 		WRITE_ONCE(inet->min_ttl, val);
 		return 0;
+	case IP_MULTICAST_TTL:
+		if (sk->sk_type == SOCK_STREAM)
+			return -EINVAL;
+		if (optlen < 1)
+			return -EINVAL;
+		if (val == -1)
+			val = 1;
+		if (val < 0 || val > 255)
+			return -EINVAL;
+		WRITE_ONCE(inet->mc_ttl, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1101,17 +1112,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->pmtudisc = val;
 		break;
-	case IP_MULTICAST_TTL:
-		if (sk->sk_type == SOCK_STREAM)
-			goto e_inval;
-		if (optlen < 1)
-			goto e_inval;
-		if (val == -1)
-			val = 1;
-		if (val < 0 || val > 255)
-			goto e_inval;
-		inet->mc_ttl = val;
-		break;
 	case IP_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1592,6 +1592,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MINTTL:
 		val = READ_ONCE(inet->min_ttl);
 		goto copyval;
+	case IP_MULTICAST_TTL:
+		val = READ_ONCE(inet->mc_ttl);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1649,9 +1652,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		}
 		break;
 	}
-	case IP_MULTICAST_TTL:
-		val = inet->mc_ttl;
-		break;
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) inet->uc_index);
 		break;
@@ -1718,7 +1718,8 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			put_cmsg(&msg, SOL_IP, IP_PKTINFO, sizeof(info), &info);
 		}
 		if (inet_test_bit(TTL, sk)) {
-			int hlim = inet->mc_ttl;
+			int hlim = READ_ONCE(inet->mc_ttl);
+
 			put_cmsg(&msg, SOL_IP, IP_TTL, sizeof(hlim), &hlim);
 		}
 		if (inet_test_bit(TOS, sk)) {
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 5820a8156c4701bb163f569d735c389d7a8e3820..3eed1670224888acf639cff06537ddf2505461bb 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1316,7 +1316,7 @@ static void set_mcast_ttl(struct sock *sk, u_char ttl)
 
 	/* setsockopt(sock, SOL_IP, IP_MULTICAST_TTL, &ttl, sizeof(ttl)); */
 	lock_sock(sk);
-	inet->mc_ttl = ttl;
+	WRITE_ONCE(inet->mc_ttl, ttl);
 #ifdef CONFIG_IP_VS_IPV6
 	if (sk->sk_family == AF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
-- 
2.42.0.515.g380fc7ccd1-goog


