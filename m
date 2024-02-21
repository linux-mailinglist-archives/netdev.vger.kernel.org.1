Return-Path: <netdev+bounces-73625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C185D644
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852531C21C70
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE9F3FB1B;
	Wed, 21 Feb 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acGuSMFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213240C14
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513176; cv=none; b=Q0QAbZey2RVo2QvGa4QWhu+JIszL5VxctyaIiOeOcX8dtuRPDFcbONINoB+usfAbeM97Sbb4/1s0MFoo66t42qMGUaB8p3iw3cEezHiTEb9tXk+UWtMaRPryuGa2N2fAhrAMZorsv3aNCow3HepB9iSKGles3ijnkvdI1BiFI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513176; c=relaxed/simple;
	bh=4zVuHVhNHGsgRqHcQLTRtARLy+xlKCf2XPfVQl+N/rM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PBGRlnwK7r8rbiEgjylCNj3VyZUIr4GALrz4+Iwku0IindSVyNfQnU9B2DYNf9oA5iiQrM8fPG5ZQmkU/cQ0rf9auY20BD18edu1Q+RBpIx1svHnZhzhlOreylKlDKFMrbn8aUEzJIwUsnt0FnH/pGipnzO03s48EMwY6AUpW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=acGuSMFL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60878cf0cb2so15725367b3.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513174; x=1709117974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2QFNvKRYnwKvANDgY7qEDEI6cFtsEhy+qHigHXUFdQ=;
        b=acGuSMFLz551t+r8l6tgJrz3F1IijMYnM9pZt61vdiB06yh1bEw63MPAx+/xyNHfXc
         /AsNcrB7If12ogc6VU5IU4jDng5QNXRY9NM6yJ+cRP3plP3D34lh0s7W/YLxZTW0chyV
         ZX3RUBh7d8c1mfD2dVimv/h4SlQ+RND+fleJ0boHL12hr1h07d+OGx/KPWrimWVLzJ1a
         ayeaUSEz10C4ePXa2QYGn3TPzrM/IkM/Lcl+XmpTRoiI9n8WwwxxLunJx9MF/xcU2JY6
         gN4ZzX3BXi7W7pEdx8w9bHscrRiABzz0pXxX13P9ELRYq63IN7//JfCZOebiKOH7dnXp
         FpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513174; x=1709117974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2QFNvKRYnwKvANDgY7qEDEI6cFtsEhy+qHigHXUFdQ=;
        b=n8/iyJcZY2EFUcjgHWOsvC+HoYlLkoY6H183ZyXsYgVrK5riLGvhhAEkswvLfj7sZ5
         R/Xm3brlkcLiKKw1nhw7Igz5dlm8MVAeCu2vmUXCsRxmifU3zBf4R0A6J4Y8rfemqq/W
         tbY6nUuPzS86GVjqzwRNEkC0bi9srB2z15R7DdwWIUlcGFGWw5t5StJtAyrVMDHeJwhF
         yCZITVMvTETcbgYDEcrUEUGeEMU+xlmeD8Nhrh2NZ0T20W5qiVjXVsy6Tsw6UK06Dicb
         kUzFBCPTLfCx+lT023UCPob4yPFdhzJ4M7ZSVHxg1ywtKJ6Q96IyTeVaUr39+imyoiC4
         d9eA==
X-Gm-Message-State: AOJu0YxrP9iBGBo/BNGWZFWFR+C2u7AoYsLDjY8sJpMl0eGH/9PAGjyu
	INryfxDUf5emdPZpokP6ZOqGCmvXSNyfJY9qCSJ9MNBCRmWRc5GypfCtlbyw/h4T82uv3iUz74m
	Y/C+fZEn/Ow==
X-Google-Smtp-Source: AGHT+IF4dDgHKoD53LLHd9zrYcEvhCqlQckSPn19PKKGTmFktZYfklOmAE63qepJ7tR+JB+59IkzJ/siG9rmmw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:a8e:b0:dc7:6cfa:dc59 with SMTP
 id cd14-20020a0569020a8e00b00dc76cfadc59mr621415ybb.4.1708513173814; Wed, 21
 Feb 2024 02:59:33 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:12 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-11-edumazet@google.com>
Subject: [PATCH net-next 10/13] inet: allow ip_valid_fib_dump_req() to be
 called with RTNL or RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new field into struct fib_dump_filter, to let callers
tell if they use RTNL locking or RCU.

This is used in the following patch, when inet_dump_fib()
no longer holds RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_fib.h    |  1 +
 net/ipv4/fib_frontend.c | 15 +++++++++++----
 net/ipv4/ipmr.c         |  4 +++-
 net/ipv6/ip6_fib.c      |  7 +++++--
 net/ipv6/ip6mr.c        |  4 +++-
 net/mpls/af_mpls.c      |  4 +++-
 6 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index d4667b7797e3e4591f3ff1fe641f168295e0a894..9b2f69ba5e4981fb108581c229ff008d04750ade 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -264,6 +264,7 @@ struct fib_dump_filter {
 	bool			filter_set;
 	bool			dump_routes;
 	bool			dump_exceptions;
+	bool			rtnl_held;
 	unsigned char		protocol;
 	unsigned char		rt_type;
 	unsigned int		flags;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 390f4be7f7bec20f33aa80e9bf12d5e2f3760562..39f67990e01c19b73a622dced0220a1bba21d5e6 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -916,7 +916,8 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	struct rtmsg *rtm;
 	int err, i;
 
-	ASSERT_RTNL();
+	if (filter->rtnl_held)
+		ASSERT_RTNL();
 
 	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
 		NL_SET_ERR_MSG(extack, "Invalid header for FIB dump request");
@@ -961,7 +962,10 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 			break;
 		case RTA_OIF:
 			ifindex = nla_get_u32(tb[i]);
-			filter->dev = __dev_get_by_index(net, ifindex);
+			if (filter->rtnl_held)
+				filter->dev = __dev_get_by_index(net, ifindex);
+			else
+				filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
 				return -ENODEV;
 			break;
@@ -983,8 +987,11 @@ EXPORT_SYMBOL_GPL(ip_valid_fib_dump_req);
 
 static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct fib_dump_filter filter = { .dump_routes = true,
-					  .dump_exceptions = true };
+	struct fib_dump_filter filter = {
+		.dump_routes = true,
+		.dump_exceptions = true,
+		.rtnl_held = true,
+	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int h, s_h;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3622298365105d99c0277f1c1616fb5fc63cdc2d..792726671dd39ace276189ea643e7b5a555dd987 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2587,7 +2587,9 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct fib_dump_filter filter = {};
+	struct fib_dump_filter filter = {
+		.rtnl_held = true,
+	};
 	int err;
 
 	if (cb->strict_check) {
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 805bbf26b3efd0239c04c0d7a658b5eac26efd34..10ab771bd89d02cd471014112a46067ea3757cb7 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -620,8 +620,11 @@ static int fib6_dump_table(struct fib6_table *table, struct sk_buff *skb,
 
 static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct rt6_rtnl_dump_arg arg = { .filter.dump_exceptions = true,
-					 .filter.dump_routes = true };
+	struct rt6_rtnl_dump_arg arg = {
+		.filter.dump_exceptions = true,
+		.filter.dump_routes = true,
+		.filter.rtnl_held = true,
+	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int h, s_h;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9782c180fee646ab0fad7f0f911254b4b3a592c4..4af0e03fdd520f6bf5bedd64074fc1ee63abd09d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2595,7 +2595,9 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
-	struct fib_dump_filter filter = {};
+	struct fib_dump_filter filter = {
+		.rtnl_held = true,
+	};
 	int err;
 
 	if (cb->strict_check) {
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 1af29af65388584e9666f4fcb73a16e8ff159587..6dab883a08dda46ff6ddc1e6e407e6f48a10c8aa 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2179,7 +2179,9 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	struct mpls_route __rcu **platform_label;
-	struct fib_dump_filter filter = {};
+	struct fib_dump_filter filter = {
+		.rtnl_held = true,
+	};
 	unsigned int flags = NLM_F_MULTI;
 	size_t platform_labels;
 	unsigned int index;
-- 
2.44.0.rc0.258.g7320e95886-goog


