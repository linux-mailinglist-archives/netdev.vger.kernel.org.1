Return-Path: <netdev+bounces-170559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BA2A49055
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F123B0D5A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639A1A2554;
	Fri, 28 Feb 2025 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o6saptvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D419993D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716904; cv=none; b=eqvSV7d7mfs2BUowFRj79+yYdVreRIaEGS433gh5EmaD3kjK0pN4dKgvGUzYuPNjAADH1QtMIJSDy6MqhR88gKAZlwH7YNhbzLsfUOGPa8ox3vTWZO7H8a/By1rnvz7dzKQvFuA4byBYI5klL+mlDno472G7nUZsNsx7aaDMdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716904; c=relaxed/simple;
	bh=NOCEOsHGgXvgDmRQcg1G8XtMVxV4aXagCY4oAXbZ4OU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIb+Hb+vLHw3yvuacYx7LklK2amtveY76LeBwi4oigPmdOFw1jLbHwVjh9W1FjAVxuTmKIh1hGZvcGCMm2CGyiWyCbvt/n320TwBgym0g6WzF5q4c5lUXXUh0IC5/SX/l5IaKXR4+ZXbNJy0aKSJU2YbV/C6y9O89dQf8HAYdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=o6saptvO; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716903; x=1772252903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSVQqwwEpLS+uYT5epUrSCVZ3Z26f3wUCIwLmhDTdXU=;
  b=o6saptvOe/V5fLKNlr2+YbIpfQMojSsDOmDYD4ZtxQ1P1UECwTgYJmnv
   eDob/WUa+iDMXuRdnOT/ea00+UZ3PzqCkKSCrvI9VVGF90EaFiHJj8CM8
   Am/iC7bVNewI/uSTtCT+9OsQHFudYQPzKsG+cgGHeu7fetoGxktPwY/Ay
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="466519331"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:28:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:8832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.32:2525] with esmtp (Farcaster)
 id b81ee572-f03b-4a1b-8016-e05a701026d8; Fri, 28 Feb 2025 04:28:18 +0000 (UTC)
X-Farcaster-Flow-ID: b81ee572-f03b-4a1b-8016-e05a701026d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:28:18 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:28:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 11/12] ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
Date: Thu, 27 Feb 2025 20:23:27 -0800
Message-ID: <20250228042328.96624-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_valid_key_len() is called in the beginning of fib_table_insert()
or fib_table_delete() to check if the prefix length is valid.

fib_table_insert() and fib_table_delete() are called from 3 paths

  - ip_rt_ioctl()
  - inet_rtm_newroute() / inet_rtm_delroute()
  - fib_magic()

In the first ioctl() path, rtentry_to_fib_config() checks the prefix
length with bad_mask().  Also, fib_magic() always passes the correct
prefix: 32 or ifa->ifa_prefixlen, which is already validated.

Let's move fib_valid_key_len() to the rtnetlink path, rtm_to_fib_config().

While at it, 2 direct returns in rtm_to_fib_config() are changed to
goto to match other places in the same function

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_frontend.c | 18 ++++++++++++++++--
 net/ipv4/fib_trie.c     | 22 ----------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index a76dacc3e577..a6372d934e45 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -835,19 +835,33 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		}
 	}
 
+	if (cfg->fc_dst_len > 32) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
+	if (cfg->fc_dst_len < 32 && (ntohl(cfg->fc_dst) << cfg->fc_dst_len)) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix for given prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
 	if (cfg->fc_nh_id) {
 		if (cfg->fc_oif || cfg->fc_gw_family ||
 		    cfg->fc_encap || cfg->fc_mp) {
 			NL_SET_ERR_MSG(extack,
 				       "Nexthop specification and nexthop id are mutually exclusive");
-			return -EINVAL;
+			err = -EINVAL;
+			goto errout;
 		}
 	}
 
 	if (has_gw && has_via) {
 		NL_SET_ERR_MSG(extack,
 			       "Nexthop configuration can not contain both GATEWAY and VIA");
-		return -EINVAL;
+		err = -EINVAL;
+		goto errout;
 	}
 
 	if (!cfg->fc_table)
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index d6411ac81096..59a6f0a9638f 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1187,22 +1187,6 @@ static int fib_insert_alias(struct trie *t, struct key_vector *tp,
 	return 0;
 }
 
-static bool fib_valid_key_len(u32 key, u8 plen, struct netlink_ext_ack *extack)
-{
-	if (plen > KEYLENGTH) {
-		NL_SET_ERR_MSG(extack, "Invalid prefix length");
-		return false;
-	}
-
-	if ((plen < KEYLENGTH) && (key << plen)) {
-		NL_SET_ERR_MSG(extack,
-			       "Invalid prefix for given prefix length");
-		return false;
-	}
-
-	return true;
-}
-
 static void fib_remove_alias(struct trie *t, struct key_vector *tp,
 			     struct key_vector *l, struct fib_alias *old);
 
@@ -1223,9 +1207,6 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	pr_debug("Insert table=%u %08x/%d\n", tb->tb_id, key, plen);
 
 	fi = fib_create_info(cfg, extack);
@@ -1717,9 +1698,6 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	l = fib_find_node(t, &tp, key);
 	if (!l)
 		return -ESRCH;
-- 
2.39.5 (Apple Git-154)


