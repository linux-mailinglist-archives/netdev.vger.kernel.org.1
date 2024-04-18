Return-Path: <netdev+bounces-89087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AF8A96AC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C779B22032
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9815B544;
	Thu, 18 Apr 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1VFsrO+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4715B147
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433871; cv=none; b=sPcvCsDnXTAMXM23DQSiLMCjfiDuaN1JpJayZA+F8PTfmbu5emAYN0tPfI4HBzAzdIzWSPUbH9qSZbNRbg7SSea74mTl6XcoG0CBzTCI3j1H/qX7VZmJPjlZotMTY5Fn30qIHBg9AULMlgG+iwhlg/LtABlvdmKTvAg3hMaWKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433871; c=relaxed/simple;
	bh=efemuQapptPIgWZgZont2xDvzRYkJAD2euLInaeiU5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gtY1EStOwAvuV6aPbQ05EdP6Chjc4XVWnaYjXEmT3HVVHAm5DzNbkNRrydUwWd2dFJI5U5jqJ4FHsf4VmxPuQXwFaaGC7MNCvHR8aIV5mzJELFyf/T6vkeBtWs54INT0QTWMUwHDml2GEWPSI8fx0I1E5sc//yRZwa3nZekDq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1VFsrO+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so1516693276.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713433869; x=1714038669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z50j+yEOvfh4aWHpc3ruom4JKMBVDFLvmRICv/rAfbM=;
        b=b1VFsrO+RwQ49GHXZ7GVowY5srugyNcw5VOW+9nBjk95XC0LCppnfEvw0KhTDda85V
         7WVg2fP33PJktiZt6vChrqiNHKjrc+Gp6ebtC3goglaRmcgG6bX5Rp/q5HE/xHmAA/Fz
         AwXNvo1bWLNw9O0oiFVOcJEguAkmR4dHAmOQY5flBLMxW1+7Ov0qyjCkQYB8dqlhRTCQ
         WOqDd/fUoYEFe7Jc1ipK9HpdwtbVpMwERwJKdDbRAcZmUJt4w0rcx8AP+WJwa6LHGpQY
         fqZaG9OR8gOzQPgm+pyWle1PTlKSaAzaAJgNs3mp+IzlYecYg1oCAu43rM26CXd9p3zw
         mK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433869; x=1714038669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z50j+yEOvfh4aWHpc3ruom4JKMBVDFLvmRICv/rAfbM=;
        b=ZcQQmuzRfpIWVmsk8B9F+socCaF7RfeWXBURMWvbn24xP7o4UCX3cxPoLAfSV+A7hu
         YC9t6yflel7IRRpe2uSFM+sdWX3WoumfuEBjK0mrLVyb/iwIHIKcq3OTLRG7jYjJQVo+
         qASqySlTDyt3ssG5llSfVy5SI7dDp7J6S7ymirwDQ53i9N4OMaBKi6KEFmU3hMFyExpg
         xBsFRg9HkLFAj0zNEWBDTcOIdI0OzuqOabUSo9Z02MF0yGMhj5tOd+DsIUF7KXrHxOnE
         XAzFUbTE1n2DEE1VtSt6UcmzkovTU+aKvEoDVUKCWFJGUb5aNAoaWAcVnPY13H9jQkxO
         Y9wQ==
X-Gm-Message-State: AOJu0YwNxNTBAaxHEqmIKYkmkgVPKCv9t1heaHriHO6BUY3GFMkiJ89s
	YVegitQBlza0KAg2E2FrquYtmJYceYkYaX7RJvnueaewoRbxjeoczj7a3SxELBsPSAe/Sr9ePO+
	qvbiAw2MQFQ==
X-Google-Smtp-Source: AGHT+IFMQaTELGIjSVHbj/lnSw4oKybzVlYpN/SJKbAfoE5pLH0iVl4hIT0Iz1AOdiUdMccu3ZyYFfR3j4AJwQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6804:0:b0:dc9:c54e:c5eb with SMTP id
 d4-20020a256804000000b00dc9c54ec5ebmr538175ybc.7.1713433869561; Thu, 18 Apr
 2024 02:51:09 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:51:04 +0000
In-Reply-To: <20240418095106.3680616-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418095106.3680616-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418095106.3680616-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] neighbour: add RCU protection to neigh_tables[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to remove RTNL protection from neightbl_dump_info()
and neigh_dump_info() later, we need to add
RCU protection to neigh_tables[].

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3d7869c49028f4c5c9102d1ae9b0a..33913dbf4023bcb1f18107fc3b5c26280dce7341 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1769,7 +1769,7 @@ static void neigh_parms_destroy(struct neigh_parms *parms)
 
 static struct lock_class_key neigh_table_proxy_queue_class;
 
-static struct neigh_table *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
+static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
 
 void neigh_table_init(int index, struct neigh_table *tbl)
 {
@@ -1826,13 +1826,19 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 	tbl->last_flush = now;
 	tbl->last_rand	= now + tbl->parms.reachable_time * 20;
 
-	neigh_tables[index] = tbl;
+	rcu_assign_pointer(neigh_tables[index], tbl);
 }
 EXPORT_SYMBOL(neigh_table_init);
 
+/*
+ * Only called from ndisc_cleanup(), which means this is dead code
+ * because we no longer can unload IPv6 module.
+ */
 int neigh_table_clear(int index, struct neigh_table *tbl)
 {
-	neigh_tables[index] = NULL;
+	RCU_INIT_POINTER(neigh_tables[index], NULL);
+	synchronize_rcu();
+
 	/* It is not clean... Fix it to unload IPv6 module safely */
 	cancel_delayed_work_sync(&tbl->managed_work);
 	cancel_delayed_work_sync(&tbl->gc_work);
@@ -1864,10 +1870,10 @@ static struct neigh_table *neigh_find_table(int family)
 
 	switch (family) {
 	case AF_INET:
-		tbl = neigh_tables[NEIGH_ARP_TABLE];
+		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ARP_TABLE]);
 		break;
 	case AF_INET6:
-		tbl = neigh_tables[NEIGH_ND_TABLE];
+		tbl = rcu_dereference_rtnl(neigh_tables[NEIGH_ND_TABLE]);
 		break;
 	}
 
@@ -2331,7 +2337,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 	ndtmsg = nlmsg_data(nlh);
 
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = neigh_tables[tidx];
+		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
 		if (!tbl)
 			continue;
 		if (ndtmsg->ndtm_family && tbl->family != ndtmsg->ndtm_family)
@@ -2519,7 +2525,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = neigh_tables[tidx];
+		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
 		if (!tbl)
 			continue;
 
@@ -2879,7 +2885,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	s_t = cb->args[0];
 
 	for (t = 0; t < NEIGH_NR_TABLES; t++) {
-		tbl = neigh_tables[t];
+		tbl = rcu_dereference_rtnl(neigh_tables[t]);
 
 		if (!tbl)
 			continue;
@@ -3143,14 +3149,15 @@ int neigh_xmit(int index, struct net_device *dev,
 	       const void *addr, struct sk_buff *skb)
 {
 	int err = -EAFNOSUPPORT;
+
 	if (likely(index < NEIGH_NR_TABLES)) {
 		struct neigh_table *tbl;
 		struct neighbour *neigh;
 
-		tbl = neigh_tables[index];
-		if (!tbl)
-			goto out;
 		rcu_read_lock();
+		tbl = rcu_dereference(neigh_tables[index]);
+		if (!tbl)
+			goto out_unlock;
 		if (index == NEIGH_ARP_TABLE) {
 			u32 key = *((u32 *)addr);
 
@@ -3166,6 +3173,7 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		}
 		err = READ_ONCE(neigh->output)(neigh, skb);
+out_unlock:
 		rcu_read_unlock();
 	}
 	else if (index == NEIGH_LINK_TABLE) {
-- 
2.44.0.683.g7961c838ac-goog


