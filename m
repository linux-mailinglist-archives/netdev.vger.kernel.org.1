Return-Path: <netdev+bounces-73626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E27985D646
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11C71C21F24
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD5C3E47C;
	Wed, 21 Feb 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVgip9jP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363C4122D
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513178; cv=none; b=szkhsZkWN530+/onpOU9r4xawzPz6i9KoBdnf3AWwg14K5VKgLxXK33dCEI+JCYVHtGewDh1rGrFAfvCYTk2Ng979evQhaHfq/enfpgVFCd5tFpvl0s/leCTYe4LGV/m3CmzONmUVvj7O7jOALEYXfkqnHdzgw4C/2ENKmB6MT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513178; c=relaxed/simple;
	bh=G1IJOOmceYR7xICiTPfem7LMSRPROleAUjq1Nbd84TI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GOwcTQE8Ldzm5orUnCpoIQK969lG2D9D3fYcq6rMZJJEcID5AxL5xF/R5E3dmojgCH/F+56mjXlL2v3/k3kJ1hfYq+q5eDpm+sZ8310QPvupVcOboHy9x/LMiU6FunTfIoyaC8DN+BHzpYBD8iaFddKgWTB/ZfTPVjtnYdlSmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVgip9jP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so8265387276.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513175; x=1709117975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m12SzjdIh/P1Ghw3NNokbVnXbsJrAc4osZEY9shh5Q0=;
        b=MVgip9jP6cS1bbq3M1XHARrY8aREPoTl4mEZ+yp6vN2uhgtX74Fhel4AXRViPaGRYK
         BMk5swNlvfGzkINqZjGlQHkfkEDtFaR3pzvmLreZQ7cdHR7bDRu8SdLa15KClraGjjnn
         MO00Gop3AzTxypQoMsQXNrmbURF/Vso3llYf6KeZ8aHETk1UgFWzMXBTD5QRVTT8xlhk
         iZbGs65zoRu/vN9xgSuycBzj5sfVeoRsmsAngHEpHGRGoa7Z7k9SB17iXkhl7JUyd+lf
         hD2EuNkbH2ODp0bZ5ZNToPzkJubNJgGNYsK/thFqDKPxZI3fOCVXgtZha7cOO9i9pDBz
         fsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513175; x=1709117975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m12SzjdIh/P1Ghw3NNokbVnXbsJrAc4osZEY9shh5Q0=;
        b=GZT+ItEQyMdtvK/dqHewyTAox+2Lcdgxn6/+7lfZ5iYXfHXGR7sUb/GnVK2NCEdtUV
         Av1UoU7VGyHzUK3sS7+4F/qSp0ESFhN4GZ4gPC7RkG0Xfy9lHkIkioo7KFyNiF70M9m7
         d7O08dnijSlMcbbDH3pi6Tz51SZB3sZcC3yLIboATl44ldhtcKyZ/nOqDD7lm6CBtbdl
         kYY7sBOel57PXWuutgtDYSPy7HXsMmhyF/9cyLaFJxEmG7dCwUF5MRCwjnFMJrDuEDjR
         L4Td62P4T3Fww0HmwJ47uHQ9KtZkSw2Kgyn1MqhgpAAw1if6YlX/LcPE8CKtCswdLpl6
         sgTw==
X-Gm-Message-State: AOJu0Yyon9uXrmmCc7oaCst2Yo247UJpgIKqqswGRf3twSqb+XWEJjmv
	xrbiMw/yCU9WYvF+lLbzhpmfpZfkbvlVzCHbK30biMuxqHHtqcSSLA4d7IoCCvczliG2AJ0Nubd
	zkfsc7BzwbA==
X-Google-Smtp-Source: AGHT+IFbutcJ8pCtxn+sPOEXZUQTYzgd4ad2Hmuxuo2Gbn4cCIQAZuoUPEl4Gsw+dUrhr+gciekwKuwmVbJgTg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1008:b0:dbe:a0c2:df25 with SMTP
 id w8-20020a056902100800b00dbea0c2df25mr1027819ybt.8.1708513175672; Wed, 21
 Feb 2024 02:59:35 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:13 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-12-edumazet@google.com>
Subject: [PATCH net-next 11/13] inet: switch inet_dump_fib() to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
2.44.0.rc0.258.g7320e95886-goog


