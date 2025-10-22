Return-Path: <netdev+bounces-231533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0256BBFA154
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692FD19A0051
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A922ECE84;
	Wed, 22 Oct 2025 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwAb3n0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506E2EC54E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111622; cv=none; b=DIwKImnJ2YORGuc1+OtRg6lJEIlIJ0k9BCcrVjP6rSYggCffCzZs2UeKeX/HlQb33/xRP21Hap61IxfFd5cs38daoeZ0SJesydI79YwJyG8agfP8vgcO0IlDnlP+IIMXBTUQHyF/gmahRf4yEHmVFSlSOmaOSw8y0YP30QZSwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111622; c=relaxed/simple;
	bh=EDC76k8OxKVorclMyVx69i2IKo2FCNnvWkZ33MMvNzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/YXdobaeYg/Eyjlt6Z41wBU65M7Cz+9aLc0SU5XUxYqTD1IB6NCeNeY+g+WUvZM5nsFyB1WR119Jk2SM3Yi8kF7Koifb6ZRdbB0VQKLWIC6+AHtCtGIs5KbdjYSxzJ8v65oGL/mW2kxXjtSdt0Mva2N2+ofTP0tIkrk//0H8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwAb3n0o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so5265824a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761111620; x=1761716420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz04VgWYi3yNnqNngdSsPvTIlsKcel1tMSBPIkeWESA=;
        b=RwAb3n0oFv/ns2yNVq9rw7PZ5GUjSFPTYBG6izy3SPWVuF+zqgyXKJJx0FWGnxBHBR
         rVHzd9x8KA4qbFbzBduO7vh3zrQmLBC0P5SkWl5g0zDapyiQMci5Fjo0pLYOCtxqS+GW
         vxzZ/TNxr+UeG3+/ouLAap3OWEX5kYH5BpyvclrmkKO9sUJ7rqb+2Tsq8HtnR/iE6rE0
         adDZkvYlSpVSzxT3pqY1NMsbbjK5YBoNRFlUJpZN6Iw6r4yiE5DwmOokTN7FS29XJykM
         ilf40473hJ6QTzGlKzyeNbO2CVRrSTjRxoIq563p7VavciO3WqSwDWXnKVnKQJalgVUM
         DH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111620; x=1761716420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz04VgWYi3yNnqNngdSsPvTIlsKcel1tMSBPIkeWESA=;
        b=saW9FA9wG7FtUMxkrEsTs37uh5Q/70BInZMpphbgQxNVdd8jbsialXMIpy8tSdnfph
         Y9aDalBxWMDQvr/DcI1WkSpr2Qf/YIW2Zoo1ErUgi0wIbc7YWdm1TjsNwyhfcsh3BUsW
         TV516e7pn+FtqQvkEfUJF6UsPa9uKzB9c2vclN5O4zi8Yio0v4qjBVGc2sBydqIj7R5z
         HtPouI1m/FCMPKkGw+B4XK6d1xyh5lTgLyxA3QRqtC5jBmqVLFj4mAMM29O7DbBcYqOu
         3ugsDCoa2xxVUZaS5Bhdz8uchGGo3alGXIMykXLcWKjU+0SJ4j4JS+Z4cl6TR1x0U7Dy
         /1kA==
X-Forwarded-Encrypted: i=1; AJvYcCU5mwBwNZn50txqJfaL0i7JKQyPN9+mYXaMACfJZmLb7MJJ6WeLn5HCpdUE7H8X+kd+N3ZNUPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QASfTh3WkMKLXetm4jM/QWcusCsYJGhJtdxx6AeJT0FAe2Qa
	oMcRCPmZNG12ouSrq12quZyRBcN9leQdeV3F5dicoz+yplKK67IiewzjDBrbQI1mVlinYo15Cta
	pDolK7w==
X-Google-Smtp-Source: AGHT+IEI3WHP7htz7jov9qoMOUYSpPuthBbi5bWfhRMIL/6BNE8Ez5An1vOrvPrH5MIW+rgM3hUC+Tj+8nc=
X-Received: from plot1.prod.google.com ([2002:a17:902:8c81:b0:290:28e2:ce65])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b90:b0:269:96db:94f
 with SMTP id d9443c01a7336-290cc9be353mr242189605ad.49.1761111620037; Tue, 21
 Oct 2025 22:40:20 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:39:47 +0000
In-Reply-To: <20251022054004.2514876-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251022054004.2514876-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/5] neighbour: Convert RTM_GETNEIGHTBL to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neightbl_dump_info() calls these functions for each neigh_tables[]
entry:

  1. neightbl_fill_info() for tbl->parms
  2. neightbl_fill_param_info() for tbl->parms_list (except tbl->parms)

Both functions rely on the table lock (read_lock_bh(&tbl->lock))
and RTNL is not needed.

Let's fetch the table under RCU and convert RTM_GETNEIGHTBL to RCU.

Note that the first entry of tbl->parms_list is tbl->parms.list and
embedded in neigh_table, so list_next_entry() is safe.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b08a9df31a15b..0c5170438c51e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2176,7 +2176,7 @@ static int neightbl_fill_parms(struct sk_buff *skb, struct neigh_parms *parms)
 		return -ENOBUFS;
 
 	if ((parms->dev &&
-	     nla_put_u32(skb, NDTPA_IFINDEX, parms->dev->ifindex)) ||
+	     nla_put_u32(skb, NDTPA_IFINDEX, READ_ONCE(parms->dev->ifindex))) ||
 	    nla_put_u32(skb, NDTPA_REFCNT, refcount_read(&parms->refcnt)) ||
 	    nla_put_u32(skb, NDTPA_QUEUE_LENBYTES,
 			NEIGH_VAR(parms, QUEUE_LEN_BYTES)) ||
@@ -2228,8 +2228,6 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 		return -EMSGSIZE;
 
 	ndtmsg = nlmsg_data(nlh);
-
-	read_lock_bh(&tbl->lock);
 	ndtmsg->ndtm_family = tbl->family;
 	ndtmsg->ndtm_pad1   = 0;
 	ndtmsg->ndtm_pad2   = 0;
@@ -2255,11 +2253,9 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
 		};
 
-		rcu_read_lock();
 		nht = rcu_dereference(tbl->nht);
 		ndc.ndtc_hash_rnd = nht->hash_rnd[0];
 		ndc.ndtc_hash_mask = ((1 << nht->hash_shift) - 1);
-		rcu_read_unlock();
 
 		if (nla_put(skb, NDTA_CONFIG, sizeof(ndc), &ndc))
 			goto nla_put_failure;
@@ -2297,12 +2293,10 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 	if (neightbl_fill_parms(skb, &tbl->parms) < 0)
 		goto nla_put_failure;
 
-	read_unlock_bh(&tbl->lock);
 	nlmsg_end(skb, nlh);
 	return 0;
 
 nla_put_failure:
-	read_unlock_bh(&tbl->lock);
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
 }
@@ -2321,8 +2315,6 @@ static int neightbl_fill_param_info(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	ndtmsg = nlmsg_data(nlh);
-
-	read_lock_bh(&tbl->lock);
 	ndtmsg->ndtm_family = tbl->family;
 	ndtmsg->ndtm_pad1   = 0;
 	ndtmsg->ndtm_pad2   = 0;
@@ -2331,11 +2323,9 @@ static int neightbl_fill_param_info(struct sk_buff *skb,
 	    neightbl_fill_parms(skb, parms) < 0)
 		goto errout;
 
-	read_unlock_bh(&tbl->lock);
 	nlmsg_end(skb, nlh);
 	return 0;
 errout:
-	read_unlock_bh(&tbl->lock);
 	nlmsg_cancel(skb, nlh);
 	return -EMSGSIZE;
 }
@@ -2575,10 +2565,12 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
 
+	rcu_read_lock();
+
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
 		struct neigh_parms *p;
 
-		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
+		tbl = rcu_dereference(neigh_tables[tidx]);
 		if (!tbl)
 			continue;
 
@@ -2592,7 +2584,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 		nidx = 0;
 		p = list_next_entry(&tbl->parms, list);
-		list_for_each_entry_from(p, &tbl->parms_list, list) {
+		list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
@@ -2612,6 +2604,8 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		neigh_skip = 0;
 	}
 out:
+	rcu_read_unlock();
+
 	cb->args[0] = tidx;
 	cb->args[1] = nidx;
 
@@ -3913,7 +3907,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
 	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
 	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
-	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
+	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
 };
 
-- 
2.51.0.915.g61a8936c21-goog


