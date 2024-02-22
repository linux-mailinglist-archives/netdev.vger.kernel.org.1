Return-Path: <netdev+bounces-73943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180785F61D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4BB287430
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368AC3FB39;
	Thu, 22 Feb 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+b/L3E1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E246B9A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599045; cv=none; b=dmMqnAjQETlgsmeXtegkj8Igo0iCoAS6UxQ0deb3H+m7aGQ50Y61uvTprbdpGyH2S/i6onu6wMci3ilaJ9RI1qPt5uo7iZ2dnsQH3WYnOnMHTdkR6ArAnNVXfwzt1Mt3ptXg0SSy0MdHI2BzaiFW9oVSvKhdTg9lWi3+BoZUwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599045; c=relaxed/simple;
	bh=N+Bs28a6pnhNv8XtNlSZ6imQjDe7vJeNMiFm1O4ruY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A+aTT5I1qgNHXwp78/e+lHHGKxa7dB5VX0Pt/ClbNvqjQbhCC6iAdBie9Z2LzJF/NY4HbWJ3pFaP3jtmhghVPuyVh0fCu2AT4j9/9Mkil35bcRfTzGtPocc/14zqSl5a+XClZUyby0p32jR8MmYqB2jIFcAYGD4ODf4oTcvhbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+b/L3E1; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6800aa45af1so110888586d6.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599042; x=1709203842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wE2z4Jpfg0ONY9A2wjnpJ/o8pBYO62Ymup9yjreC9KI=;
        b=j+b/L3E1u0a8tbd07mgULSFgqZj9pr+D1DZ1u1XXMbOymwzHqIAzEgukz4rJ7pPoxs
         jN+pIxBS7RpM4JJKG/30gd7kJ7WW3HFfNsxpbauVPVvO2rvL6OQqC68hcIT1xF9j7NEW
         GwoO1H7RwLPypVu1g9sHyiPgwLH+RB1cO8Mo1/8NcboY56LFJIYoQ1M8uXygaoN6DRJR
         gp0JSSZ2jiYu2YkBVYMmkxOUgSHlMoZpLNhdlu/xU7bSx8x2yAJgjeJDs6mlJhFO1ipC
         uFhYTmzAqULqfbhRaJXScRsui13zbDIJQBdu8d0my4Ba97GPwDOkqadlYakgkGtyeoFX
         ZX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599042; x=1709203842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wE2z4Jpfg0ONY9A2wjnpJ/o8pBYO62Ymup9yjreC9KI=;
        b=JfkaWL/zJOisCNRyfxw6oIkOuUnXOy4ufdG/keYscQkJdi5/VuSFXiTr9Jqu5JaoKY
         V0M+hCPb4FY8UsSPlsBVaiVLYk1D7CXvnBxj9yp/Zsy0pUpHixK6ePZK+gZNbv08+rOc
         I4za4JYjpbD2szi5rNVZIQgU3mhaRWBpLvGTc5khDhrDrxeTieGvhTRvVANHbetYjSvG
         ZKmjgPnZ02Gi3Xli3lq49SFhRYQKNMzlo9Y4malQPDOh901gT/XFkr2INQSIo/n0LuY/
         MmqaokQZuASghvEGBgW6T1QAl4H21nCc+0qznN+4/qoKhmqIKerk2UCPUXIPV4wBvHnp
         vY0w==
X-Gm-Message-State: AOJu0YxurxYDvDr8eLIy6gfuyRZLgxXUAmqx4ErVsgv0h0MUMtxXVlJG
	ii9BQs6CkS2/umabTgzf/nSMw/XrpS/JNv8vxu2B/o7c0xEeCCEfr7fR9wpAmk8SRQY8wjcNog1
	vqI9WKqqWvg==
X-Google-Smtp-Source: AGHT+IEzafyWo3HVxBaEtb0RWu8Na7kU87ggmLJn2+y1Ivm8xV1yIhynHUOfs5WKfRbBoIbvYLaZ2dZGUdGWXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ad4:5c87:0:b0:68f:7ac1:2b3e with SMTP id
 o7-20020ad45c87000000b0068f7ac12b3emr302581qvh.8.1708599042565; Thu, 22 Feb
 2024 02:50:42 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:19 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/14] inet: switch inet_dump_fib() to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No longer hold RTNL while calling inet_dump_fib().

Also change return value for a completed dump:

Returning 0 instead of skb->len allows NLMSG_DONE
to be appended to the skb. User space does not have
to call us again to get a standalone NLMSG_DONE marker.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_frontend.c | 37 ++++++++++++++++++-------------------
 net/ipv4/fib_trie.c     |  4 ++--
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 39f67990e01c19b73a622dced0220a1bba21d5e6..bf3a2214fe29b6f9b494581b293259e6c5ce6f8c 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -990,7 +990,7 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	struct fib_dump_filter filter = {
 		.dump_routes = true,
 		.dump_exceptions = true,
-		.rtnl_held = true,
+		.rtnl_held = false,
 	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
@@ -998,12 +998,13 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned int e = 0, s_e;
 	struct fib_table *tb;
 	struct hlist_head *head;
-	int dumped = 0, err;
+	int dumped = 0, err = 0;
 
+	rcu_read_lock();
 	if (cb->strict_check) {
 		err = ip_valid_fib_dump_req(net, nlh, &filter, cb);
 		if (err < 0)
-			return err;
+			goto unlock;
 	} else if (nlmsg_len(nlh) >= sizeof(struct rtmsg)) {
 		struct rtmsg *rtm = nlmsg_data(nlh);
 
@@ -1012,29 +1013,28 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 
 	/* ipv4 does not use prefix flag */
 	if (filter.flags & RTM_F_PREFIX)
-		return skb->len;
+		goto unlock;
 
 	if (filter.table_id) {
 		tb = fib_get_table(net, filter.table_id);
 		if (!tb) {
 			if (rtnl_msg_family(cb->nlh) != PF_INET)
-				return skb->len;
+				goto unlock;
 
 			NL_SET_ERR_MSG(cb->extack, "ipv4: FIB table does not exist");
-			return -ENOENT;
+			err = -ENOENT;
+			goto unlock;
 		}
-
-		rcu_read_lock();
 		err = fib_table_dump(tb, skb, cb, &filter);
-		rcu_read_unlock();
-		return skb->len ? : err;
+		if (err < 0 && skb->len)
+			err = skb->len;
+		goto unlock;
 	}
 
 	s_h = cb->args[0];
 	s_e = cb->args[1];
 
-	rcu_read_lock();
-
+	err = 0;
 	for (h = s_h; h < FIB_TABLE_HASHSZ; h++, s_e = 0) {
 		e = 0;
 		head = &net->ipv4.fib_table_hash[h];
@@ -1047,9 +1047,8 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 			err = fib_table_dump(tb, skb, cb, &filter);
 			if (err < 0) {
 				if (likely(skb->len))
-					goto out;
-
-				goto out_err;
+					err = skb->len;
+				goto out;
 			}
 			dumped = 1;
 next:
@@ -1057,13 +1056,12 @@ static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 	}
 out:
-	err = skb->len;
-out_err:
-	rcu_read_unlock();
 
 	cb->args[1] = e;
 	cb->args[0] = h;
 
+unlock:
+	rcu_read_unlock();
 	return err;
 }
 
@@ -1666,5 +1664,6 @@ void __init ip_fib_init(void)
 
 	rtnl_register(PF_INET, RTM_NEWROUTE, inet_rtm_newroute, NULL, 0);
 	rtnl_register(PF_INET, RTM_DELROUTE, inet_rtm_delroute, NULL, 0);
-	rtnl_register(PF_INET, RTM_GETROUTE, NULL, inet_dump_fib, 0);
+	rtnl_register(PF_INET, RTM_GETROUTE, NULL, inet_dump_fib,
+		      RTNL_FLAG_DUMP_UNLOCKED);
 }
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 0fc7ab5832d1ae00e33fdf6fad4ef379c7d0bd4d..f474106464d2f2a52fa6b7ecaf2146977d05eecc 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2368,7 +2368,7 @@ int fib_table_dump(struct fib_table *tb, struct sk_buff *skb,
 	 * and key == 0 means the dump has wrapped around and we are done.
 	 */
 	if (count && !key)
-		return skb->len;
+		return 0;
 
 	while ((l = leaf_walk_rcu(&tp, key)) != NULL) {
 		int err;
@@ -2394,7 +2394,7 @@ int fib_table_dump(struct fib_table *tb, struct sk_buff *skb,
 	cb->args[3] = key;
 	cb->args[2] = count;
 
-	return skb->len;
+	return 0;
 }
 
 void __init fib_trie_init(void)
-- 
2.44.0.rc1.240.g4c46232300-goog


