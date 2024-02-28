Return-Path: <netdev+bounces-75755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711586B0FA
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21FF1F216A9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E7155A55;
	Wed, 28 Feb 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqWffDuu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B6155A39
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128512; cv=none; b=bA8l4cgBlBJiY+3IRbBZSzpbe9ZVaUCpExpQ2cMXNB/IqTrpxr8AZ8LXag3x7mMjXB30TYxgyScVwIHYIU8kGs0cFhSYbLcwLMd4G5B8yljVNPQPVrDkkpd2EbWuKJRRqUckACOk1heBP9dV6nEXl5D+pi3aFAQxdykZq1onUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128512; c=relaxed/simple;
	bh=/Gk9VZIjSsQKrSNUHcR3haP/H4xsuiieqfVxguNqxnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWZnaTGMVgDLM3a6NL6aBPXqnwIjnLab2PDaaRQT6/OEvCIo26Q5pZdSaBM7g66qr/ImZ++7g9KETTYfmCT0P8FvOQgCcdRtzUca3ho2fPOx+HAHaSIyWqDTI7MQp57ngVtSIDVg+IVaueYQygEku/ZzeMNE5dtvFzJuPWGWBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqWffDuu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso10561349276.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128510; x=1709733310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqh87Fliy9ASVVOzwtH1bbNaiQsOHJXdPBTviCF3k04=;
        b=aqWffDuujKz0K+xrHy4J7Mir9pPIiqrTap1SbJbnRsEJT9Z2PZgF17CE26TNPdlrmz
         UsSFYrlmBCrjIz6zNsY/BUtceogBxDut+uQnLROnQxaP/lg8JNXGST5M/ujeVKpstq5w
         Oy7UTQCXgs9IsLUDo9tRUaCQVyogTvpQz5szl0Ra+9H2mGY/ag8FI5XCvOpy7WmoLSLG
         eETOdeUT8UipLuh+tUZL91JFm3YtEtMpxS+k08QQ8FSlUa83idss4bRAMWLrk/ooZq/a
         ZYsYKplXgzNAwUc5PwqqaM9/hyzR7RPFlsGRhLVtpjSYVtoMAxyZN9PTduuOlx6KPcBF
         GT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128510; x=1709733310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqh87Fliy9ASVVOzwtH1bbNaiQsOHJXdPBTviCF3k04=;
        b=dVupQHuQoRpq55sX//vWjLKNk1Na6Ahp/pwF3ep9B0jqYHQF3W+E6pUPI4Z+ADrVfU
         0ZO0wsiqAJsIicgGg05NcMOKLz9Bb0ZU8JUBZEmaN+dS8s6nIWedr4rem7AHjQUCGSky
         7GswJYxXrXsO1oz2bMY7fP/Hc5Es12H57DtVz47r0vX8Yi++TmE56QwhBXfPmL6rVFtT
         zB+79f0mgqtZDp6jZkxYAhGZocTgSNx/GLASBSM52mSh1oU7nPtLMHLkqT8NyXnO5zt5
         GE69AILqj4EvyRAh0mK0VniHwSJahCKgICxZrk3X9HJ1KwzbOM0n4kSW3vg/hU12akwE
         wnZQ==
X-Gm-Message-State: AOJu0Yy6TJGA0pwVYszn2prdHsfKhSqtjdGhhKkv71izmyi+Vr1af4rf
	4aI41dlm8C6KbpyPjSFceWEEWFalzYLToA8TxEJkOCnJvlfnv/PvDIEzmq1GQBSVlDlhwD74zLr
	TbDcZiRPsAQ==
X-Google-Smtp-Source: AGHT+IEXJpwgs/2LknYSl16kVEH4AeYmICJxdShv2dHBWa0ohdCWDvmJgYLW09sYle/8oZQPFfvy7W9UEJOd+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:814f:0:b0:dc6:cafd:dce5 with SMTP id
 j15-20020a25814f000000b00dc6cafddce5mr709251ybm.12.1709128510015; Wed, 28 Feb
 2024 05:55:10 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:39 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-16-edumazet@google.com>
Subject: [PATCH v3 net-next 15/15] ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

1) inet6_netconf_dump_devconf() can run under RCU protection
   instead of RTNL.

2) properly return 0 at the end of a dump, avoiding an
   an extra recvmsg() system call.

3) Do not use inet6_base_seq() anymore, for_each_netdev_dump()
   has nice properties. Restarting a GETDEVCONF dump if a device has
   been added/removed or if net->ipv6.dev_addr_genid has changed is moot.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c | 102 +++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 58 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index b5c627253eb5e30a981dfd23dfc248ea00e3c557..de7b6b5922fe37a557a89a403425fb427710bad9 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -727,17 +727,18 @@ static u32 inet6_base_seq(const struct net *net)
 	return res;
 }
 
-
 static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 				      struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	int h, s_h;
-	int idx, s_idx;
+	struct {
+		unsigned long ifindex;
+		unsigned int all_default;
+	} *ctx = (void *)cb->ctx;
 	struct net_device *dev;
 	struct inet6_dev *idev;
-	struct hlist_head *head;
+	int err = 0;
 
 	if (cb->strict_check) {
 		struct netlink_ext_ack *extack = cb->extack;
@@ -754,64 +755,48 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 		}
 	}
 
-	s_h = cb->args[0];
-	s_idx = idx = cb->args[1];
-
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[h];
-		rcu_read_lock();
-		cb->seq = inet6_base_seq(net);
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			idev = __in6_dev_get(dev);
-			if (!idev)
-				goto cont;
-
-			if (inet6_netconf_fill_devconf(skb, dev->ifindex,
-						       &idev->cnf,
-						       NETLINK_CB(cb->skb).portid,
-						       nlh->nlmsg_seq,
-						       RTM_NEWNETCONF,
-						       NLM_F_MULTI,
-						       NETCONFA_ALL) < 0) {
-				rcu_read_unlock();
-				goto done;
-			}
-			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
-cont:
-			idx++;
-		}
-		rcu_read_unlock();
+	rcu_read_lock();
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		idev = __in6_dev_get(dev);
+		if (!idev)
+			continue;
+		err = inet6_netconf_fill_devconf(skb, dev->ifindex,
+					         &idev->cnf,
+						 NETLINK_CB(cb->skb).portid,
+						 nlh->nlmsg_seq,
+						 RTM_NEWNETCONF,
+						 NLM_F_MULTI,
+						 NETCONFA_ALL);
+		if (err < 0)
+			goto done;
 	}
-	if (h == NETDEV_HASHENTRIES) {
-		if (inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_ALL,
-					       net->ipv6.devconf_all,
-					       NETLINK_CB(cb->skb).portid,
-					       nlh->nlmsg_seq,
-					       RTM_NEWNETCONF, NLM_F_MULTI,
-					       NETCONFA_ALL) < 0)
+	if (ctx->all_default == 0) {
+		err = inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_ALL,
+						 net->ipv6.devconf_all,
+						 NETLINK_CB(cb->skb).portid,
+						 nlh->nlmsg_seq,
+						 RTM_NEWNETCONF, NLM_F_MULTI,
+						 NETCONFA_ALL);
+		if (err < 0)
 			goto done;
-		else
-			h++;
-	}
-	if (h == NETDEV_HASHENTRIES + 1) {
-		if (inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_DEFAULT,
-					       net->ipv6.devconf_dflt,
-					       NETLINK_CB(cb->skb).portid,
-					       nlh->nlmsg_seq,
-					       RTM_NEWNETCONF, NLM_F_MULTI,
-					       NETCONFA_ALL) < 0)
+		ctx->all_default++;
+	}
+	if (ctx->all_default == 1) {
+		err = inet6_netconf_fill_devconf(skb, NETCONFA_IFINDEX_DEFAULT,
+						 net->ipv6.devconf_dflt,
+						 NETLINK_CB(cb->skb).portid,
+						 nlh->nlmsg_seq,
+						 RTM_NEWNETCONF, NLM_F_MULTI,
+						 NETCONFA_ALL);
+		if (err < 0)
 			goto done;
-		else
-			h++;
+		ctx->all_default++;
 	}
 done:
-	cb->args[0] = h;
-	cb->args[1] = idx;
-
-	return skb->len;
+	if (err < 0 && likely(skb->len))
+		err = skb->len;
+	rcu_read_unlock();
+	return err;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -7502,7 +7487,8 @@ int __init addrconf_init(void)
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETNETCONF,
 				   inet6_netconf_get_devconf,
 				   inet6_netconf_dump_devconf,
-				   RTNL_FLAG_DOIT_UNLOCKED);
+				   RTNL_FLAG_DOIT_UNLOCKED |
+				   RTNL_FLAG_DUMP_UNLOCKED);
 	if (err < 0)
 		goto errout;
 	err = ipv6_addr_label_rtnl_register();
-- 
2.44.0.rc1.240.g4c46232300-goog


