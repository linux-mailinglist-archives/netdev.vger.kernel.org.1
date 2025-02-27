Return-Path: <netdev+bounces-170223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE56A47DCF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24957A73ED
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22918224B1A;
	Thu, 27 Feb 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSPXZi8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BA27003F;
	Thu, 27 Feb 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659614; cv=none; b=EP1fcjSgUsyrj45wY7wrfLLsgCJed3c0OeAP7KyLdw/CtHnP/tsMv0YPq+UZDuBUaGqf3mhpZKnrAUNEFku9r62x/ssa5c9qK4SJgFsprxyGq7OqBJi/nL1R/vpYyXr/a7pMD/Iib1qOREFT5RkfNbHRTYrU/m3WWScDTHrF19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659614; c=relaxed/simple;
	bh=eNCnDk3o13zHYhDmGLY3PfMS8o3BX2U8JaG67s0LvAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sb2/KUoQWSMmAChbfVLtnQ6FyBs+PxrggSOI851hts9JRjJWxvcPFZNwAmiXyIcYsNyByS9if3fztwFJg+k5s1J+2Wt+c0CsWCIpPoWzt8h7OOmOTbIoJIpZ7ldFqoK1mrJZxwHHkwq/TU2U2kmP2sFhUCWja3XWnwCeouqfj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSPXZi8i; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22349dc31bcso13574165ad.3;
        Thu, 27 Feb 2025 04:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740659609; x=1741264409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1UPW0Km5K8LrkkofbxPBeAljxlRf+qjqAALOT7M8Zw=;
        b=nSPXZi8iW+ArB1SsTYka+EFlslyp/okKilHbHYPj7/NGlLbFfhtwtSIGRI5oMkQnJ7
         AA+PgJAgp3xF4RU0O8M4ne16nIqCUeBSDKL6yfczwGEXQnBZZ92MpdhzlKqLgptvfvA+
         OULbYWPk4LfPSRQvqiqnwRa1qgoWatAhLqroA/T1+Js2byMW7nUhJY/IiWoNwtSivq1g
         DugnrvCZhPbuAUFSajwRsHf9vvJM/bL+ORkrshr3cn5MPTclu6BXkVGyT5grOeLeyinh
         DAaFRkgau0NsgHjBnWmS/08Nv/mFMu3kXmNBSDhxqggxkT9hJdIB++xpp7+B4FliiSqX
         +uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659609; x=1741264409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1UPW0Km5K8LrkkofbxPBeAljxlRf+qjqAALOT7M8Zw=;
        b=vzHfs0ALT8NVAnNB+YefkMfhuO6dsCaj/VeBmOpfcIA2UkuOA66vaVH1qLbK3OuQJz
         5x6GmKsMrvTp2YoLlbVtgjDomTO8kjpwbHxTGJeuoP127UAP1at4de3Re7q0fbgz+OcR
         29vYRiWzjtHRntZHxe5NRy//PAE10k/5OUQMXLEYugffx5W2ZTS+wZsIYMEQ7Ud/G6sY
         4geL/akWjNaOJHgmTOh4oY9E7o2oyxLiTiF3VSF2QkuGZhe3Sa50oWr+zbcZ3jytMZkU
         GWIURmjUIeslVceXhtc6O0XizPUrWIlWgLXd9U1GfRW19mtP24v+gQBCbGfP7v6rNc6e
         gOVg==
X-Forwarded-Encrypted: i=1; AJvYcCWue/O4DqIef4k3qrKaWKgoDmDSrcYcLhIOXmaauGxcswfCI6rhPP77qcxpdJsWyxYGiSfO6Fy1@vger.kernel.org, AJvYcCXeUFrZMxtssfZlBBqEpxk/9rFtiCQnPS3LLZl9Xg5Qy5Z06sdLidVltaGeM60Ek6Jf7h9RtwrLe68xQ38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjKDhc2ek3f8pd6m0++ZKNz+FV9XRzwqLSaukTG58vGMWquPD
	CJTtGI7aMog+UbFs0JYlMHFTxPkLIwcPvdoB5ixTZNn6W1HwNtuo
X-Gm-Gg: ASbGncsJ5NaKlu8UxR22bobtL432iRVZMVr/O4LKPhkhWWGU1nmO0Yji2hh1OqfY5mb
	VFqgVhlkGLJL39OCK7DY67Ca2zYX9FdlljhE0/Qw3XIhbICxI7w1rotbrc+5Zs+J6R//Odh5WCX
	8qID6irplFH1QzNiSCdx6ywDCp3fiXIqXzb9Y/EGfBC72w2o0VJsmaQcOiOosFtX2y40kjVkLnx
	k7QyEySJjXqxvZh0KqU1I9Hx4q/rqOJCbIY+VocJ9ziixBy3Z7METVSFplCXrRJ8IN5peuQm7iU
	GYKfPtRiwDvgJ/h617H4dLay0nKQKZcF50ygZ8CL6go=
X-Google-Smtp-Source: AGHT+IHbN+BZckJ+0jjRPlpmszaz/VaHtnknrWt71UWIDmqfJaql6oSUzuNp9uuWeO754PkxMFPphA==
X-Received: by 2002:a17:902:e752:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-2233bf6806bmr71862745ad.12.1740659609193;
        Thu, 27 Feb 2025 04:33:29 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050ceb0sm13132615ad.203.2025.02.27.04.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:33:28 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com,
	dsahern@kernel.org,
	kerneljasonxing@gmail.com,
	yyd@google.com,
	dongml2@chinatelecom.cn,
	petrm@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: ip: add sysctl_ip_reuse_exact_match
Date: Thu, 27 Feb 2025 20:31:37 +0800
Message-Id: <20250227123137.138778-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the socket lookup will terminate if the socket is reuse port in
inet_lhash2_lookup(), which makes the socket is not the best match.

For example, we have socket1 listening on "0.0.0.0:1234" and socket2
listening on "192.168.1.1:1234", and both of them enabled reuse port. The
socket1 will always be matched when a connection with the peer ip
"192.168.1.xx" comes if the socket1 is created later than socket2. This
is not expected, as socket2 has higher priority.

This can cause unexpected behavior if TCP MD5 keys is used, as described
in Documentation/networking/vrf.rst -> Applications.

Introduce the sysctl_ip_reuse_exact_match to make it find a best matched
socket when reuse port is used.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/netns/ipv4.h    |  1 +
 net/ipv4/inet_hashtables.c  | 22 ++++++++++++++++++----
 net/ipv4/sysctl_net_ipv4.c  |  9 +++++++++
 net/ipv6/inet6_hashtables.c | 22 ++++++++++++++++++----
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 45ac125e8aeb..5e4b63c40e1c 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -142,6 +142,7 @@ struct netns_ipv4 {
 	u8 sysctl_ip_fwd_update_priority;
 	u8 sysctl_ip_nonlocal_bind;
 	u8 sysctl_ip_autobind_reuse;
+	u8 sysctl_ip_reuse_exact_match;
 	/* Shall we try to damage output packets if routing dev changes? */
 	u8 sysctl_ip_dynaddr;
 #ifdef CONFIG_NET_L3_MASTER_DEV
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18..5ca495361484 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -384,20 +384,34 @@ static struct sock *inet_lhash2_lookup(const struct net *net,
 	struct sock *sk, *result = NULL;
 	struct hlist_nulls_node *node;
 	int score, hiscore = 0;
+	bool reuse_exact_match;
 
+	reuse_exact_match = READ_ONCE(net->ipv4.sysctl_ip_reuse_exact_match);
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = inet_lookup_reuseport(net, sk, skb, doff,
-						       saddr, sport, daddr, hnum, inet_ehashfn);
-			if (result)
-				return result;
+			if (!reuse_exact_match) {
+				result = inet_lookup_reuseport(net, sk, skb,
+							       doff, saddr,
+							       sport, daddr,
+							       hnum, inet_ehashfn);
+				if (result)
+					return result;
+			}
 
 			result = sk;
 			hiscore = score;
 		}
 	}
 
+	if (reuse_exact_match) {
+		sk = inet_lookup_reuseport(net, result, skb, doff, saddr,
+					   sport, daddr, hnum,
+					   inet_ehashfn);
+		if (sk)
+			return sk;
+	}
+
 	return result;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3a43010d726f..be93b2c22d91 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -838,6 +838,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
+	{
+		.procname	= "ip_reuse_exact_match",
+		.data		= &init_net.ipv4.sysctl_ip_reuse_exact_match,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 	{
 		.procname	= "fwmark_reflect",
 		.data		= &init_net.ipv4.sysctl_fwmark_reflect,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 9ec05e354baa..b8f130a2a135 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -157,20 +157,34 @@ static struct sock *inet6_lhash2_lookup(const struct net *net,
 	struct sock *sk, *result = NULL;
 	struct hlist_nulls_node *node;
 	int score, hiscore = 0;
+	bool reuse_exact_match;
 
+	reuse_exact_match = READ_ONCE(net->ipv4.sysctl_ip_reuse_exact_match);
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = inet6_lookup_reuseport(net, sk, skb, doff,
-							saddr, sport, daddr, hnum, inet6_ehashfn);
-			if (result)
-				return result;
+			if (!reuse_exact_match) {
+				result = inet6_lookup_reuseport(net, sk, skb,
+								doff, saddr,
+								sport, daddr,
+								hnum, inet6_ehashfn);
+				if (result)
+					return result;
+			}
 
 			result = sk;
 			hiscore = score;
 		}
 	}
 
+	if (reuse_exact_match) {
+		sk = inet6_lookup_reuseport(net, result, skb, doff, saddr,
+					    sport, daddr, hnum,
+					    inet6_ehashfn);
+		if (sk)
+			return sk;
+	}
+
 	return result;
 }
 
-- 
2.39.5


