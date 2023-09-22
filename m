Return-Path: <netdev+bounces-35694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5437AAADF
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 06650B20A84
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B1D19BD9;
	Fri, 22 Sep 2023 07:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AE18C2D
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:55:23 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF534FB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 00:55:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c434c33ec0so15217725ad.3
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695369319; x=1695974119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi5tM1p283u6tpFpdDf7WKoelQH/s6EjyG0WmWE+KAQ=;
        b=nlAc9h6wQmHRftQxbrPjbWIzoZAkHtEdlZYDEjGhfne8OB9PNpZL+Eivpd1cUKxb9A
         EFNbNCRmLFDaaM961gNnz55gcdBQc+JHSbNlvXCuyn4ND6B/BRTupl7zR1W8lyTvmcCP
         jAVXg75AOzSjhOJZyx0CGOlnA1hBFFQWSk9uEP2ybBFQa66NnfqUUO5cBbpMQ2dA1rwb
         x6wZl31s9+GEs4Cr7VAU4pBoS/s+dAI9noqvfCbZ8iJBYhhinzQ4vgIdYW+Unj2sdVYd
         xXXPA9ev7nLjZmAsZVliG3AUCd1wnZaW9YMT7tQEWf1NKFJ9r0paN3r+dszWbb3ejZIe
         FQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369319; x=1695974119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yi5tM1p283u6tpFpdDf7WKoelQH/s6EjyG0WmWE+KAQ=;
        b=JjMvIf3KE2iwtvuPBwVBcaH+CEBkJUa2l2OzI62Fz0qWYrJbPnp0q1Gwmjo1JC5yXR
         bt4+hCBjv29UhKLljklfOgIoJHkDR4XIcYuxppzNZEUtnrK67y/0jxiNsLvWbipI2M67
         T4eH7Bfba8b9JPxZxdThUPmrouLOY7BYgfa33/+xCpxdsvX59ZMZw+q7UDMUZV8Sj0s+
         okkiZDjpbTy+ZaKeigf3ypE+TyVq1gG4kp21mJvoqlDHPJnW+j+W9PIfGnl14gB4yRl0
         2TvXpNSFG+YSP7BKRp+yIU4up24UFNKZzGuckOqdcdhaUeMSLjs27TlF9ojvtmUQb8YR
         Dacw==
X-Gm-Message-State: AOJu0Yzhj2sdCvX8Ow4QKM9oXn4ESLJnXYs4K2e5qrGuYxVT2L1zXg4t
	LWn8qMXj1M86OCCS1JTJfjccrZ7RKFJxnlXQ
X-Google-Smtp-Source: AGHT+IEStEB261egJBvkklN+YXh4+QwV05deR2LeGwV8vyZ/8+XrYRJ0+sKC/zwIdEUEHslcC2mylA==
X-Received: by 2002:a17:903:1cd:b0:1bf:3c10:1d72 with SMTP id e13-20020a17090301cd00b001bf3c101d72mr9524674plh.66.1695369319185;
        Fri, 22 Sep 2023 00:55:19 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001b881a8251bsm2831804plb.106.2023.09.22.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:55:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net] ipv4/fib: send notify when delete source address routes
Date: Fri, 22 Sep 2023 15:55:08 +0800
Message-ID: <20230922075508.848925-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an interface address in fib_del_ifaddr(), the function
scans the fib_info list for stray entries and calls fib_flush() and
fib_table_flush(). Then the stray entries will be deleted silently and no
RTM_DELROUTE notification will be sent.

This lack of notification can make routing daemons, or monitor like
`ip monitor route` miss the routing changes. e.g.

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 192.168.5.5/24 dev dummy1
+ ip route add 7.7.7.0/24 dev dummy2 src 192.168.5.5
+ ip -4 route
7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5

As Ido reminded, fib_table_flush() isn't only called when an address is
deleted, but also when an interface is deleted or put down. The lack of
notification in these cases is deliberate. And commit 7c6bb7d2faaf
("net/ipv6: Add knob to skip DELROUTE message on device down") introduced
a sysctl to make IPv6 behave like IPv4 in this regard. So we can't send
the route delete notify blindly in fib_table_flush().

To fix this issue, let's add a new flag in "struct fib_info" to track the
deleted prefer source address routes, and only send notify for them.

After update:
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
Deleted 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5

Suggested-by: Thomas Haller <thaller@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v4: As David Ahern said, do not use bitfield as it has higher overhead.
v3: update patch description
v2: Add a bit in fib_info to mark the deleted src route.
---
 include/net/ip_fib.h     | 1 +
 net/ipv4/fib_semantics.c | 1 +
 net/ipv4/fib_trie.c      | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index f0c13864180e..15de07d36540 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -154,6 +154,7 @@ struct fib_info {
 	int			fib_nhs;
 	bool			fib_nh_is_v6;
 	bool			nh_updated;
+	bool			pfsrc_removed;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
 	struct fib_nh		fib_nh[];
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index eafa4a033515..1ea82bc33ef1 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1887,6 +1887,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 			continue;
 		if (fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
+			fi->pfsrc_removed = true;
 			ret++;
 		}
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index d13fb9e76b97..9bdfdab906fe 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2027,6 +2027,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2089,6 +2090,9 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			if (fi->pfsrc_removed)
+				rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+					  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
-- 
2.41.0


