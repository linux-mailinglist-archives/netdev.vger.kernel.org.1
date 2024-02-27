Return-Path: <netdev+bounces-75368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC86869A04
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39183B2A839
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F915531E;
	Tue, 27 Feb 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJn/co9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EA154BF5
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046149; cv=none; b=NJ+oMg7YVJobHdLuDl8Ha8+x7GNKaT4BNX2bYaRMdwBUZOr2H+uSk1GgQJSj5KUJaPY10hUeOQsaRFpNZzOlXoOsGXC3sn6gUaPqtCYWWJAHLGiPovcuLJtPpCg40ab4R8tJ2oQtwI5Ehw/rzoB0VIwhtW5FR+wcck1R803A0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046149; c=relaxed/simple;
	bh=/w1tGiSExrEEcbqGcr8drLdmQbgqhaWXy+dJjymUQ88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MqntdrOY3X5/tnLjGeBpPa5Laetrvsj3HIjAYbRj7o+uzrZoDGColS2Kqz7cknEaLSlGIx4eva+3oOKOu/32e/QgWi2kj1FKTHjAGbHdxIbs+rMRUcb58H8USheDAY1fMd4hHwUEYqYOQMl9bzkzaTY5WN0NxwCv5KN05fbJOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJn/co9K; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso7554335276.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046147; x=1709650947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0G0CyX4CQ5ljiYrKGDEXVi11Tlwwkwp8GwME2qjbfU=;
        b=iJn/co9KNOowYPFIaQPRWovz78xEWL5eedjuD2gwz+33Vl3e78u+gGz8thv13/McpA
         G7+e6qRGUSIdId4JZiRvJqqrEKZ9khmCtzTUIk+IH1XQmriQ7Unr8hNmvRInUuv+UB7I
         3NitmXKJRwOBPGGORmLdaJunpss8LIFK+VLo+80YEqy5+IYDpsEDi9UudGDiBUf8ebUV
         Cz51bPnslmpx9pXfRkCJLRU+5AUb1U6LYMUWaBJtWlSFT5DoWVDOYjKQksHOe+CSrfAg
         6oCs0Bp1UGGngNkHVZNse81tVjC+uLnjKc9FBCuhUdEF3dsmwCEcITLZuEGJZP9KrhlF
         PqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046147; x=1709650947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0G0CyX4CQ5ljiYrKGDEXVi11Tlwwkwp8GwME2qjbfU=;
        b=RW/F0No5FRXF8BAMTOMH8WEKkx9chxhtFAITc0NjVM8DxXy8tTmv+Zaj+VuGvjMQp3
         GPxaUzU0PLVVMvBXY+5RzfjdxyXyBo2Db6hUrW1SpsggOQIlbZKtB27FBd1Lxj7ikdo7
         pm7k/BYALR3e9PPSo3gjog32ml9ct6v5beE1uFbVKJy9hAXD0Psjg1lpD73YdmHgoMqA
         s7QBRefURIS63wKWDF6Jcd7ujwsB1bALlGluwLsPQRAETJR7CHYsodEOJqwqFRyroVc2
         4PjY5i82pEWIU3kScVdxPq1xfPvclieqGSP/MQNAjbAOvFEuSAafMOauZI5t9+KNHauY
         2LZA==
X-Forwarded-Encrypted: i=1; AJvYcCVlbm8k863mnA2BfB7hR7Fni7vWlsjhs4nUtHXkAmDuoKzGl1tVLpoZlEGSwQIcG7VZliLrlXnH6Qd1GUgT55eE9GrDomuf
X-Gm-Message-State: AOJu0Yx8upgEocGqbTfqIxA4i6ahCy6NsgheNRwF00Onpxm9WJK0KJaB
	goMWkopno5kbI3fr3J2QP5+sgpKmTQjL1+5KyHVWeO1aeTuI2H5FXVZyb9PCPECoAAmzqao7Eym
	DjTDxxssgqA==
X-Google-Smtp-Source: AGHT+IGvF7ngQiLuVrE1WUuaf37H66vrOfpuRM1nFARYf6EgJLB+DBOnVXnH/49JuWk5NeEMY3ohVwIyVA893Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1542:b0:dc2:1f34:fac4 with SMTP
 id r2-20020a056902154200b00dc21f34fac4mr629803ybu.2.1709046147146; Tue, 27
 Feb 2024 07:02:27 -0800 (PST)
Date: Tue, 27 Feb 2024 15:02:00 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-16-edumazet@google.com>
Subject: [PATCH v2 net-next 15/15] ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

1) inet6_netconf_dump_devconf() can run under RCU protection
   instead of RTNL.

2) properly return 0 at the end of a dump, avoiding an
   an extra recvmsg() system call.

3) Do not use inet6_base_seq() anymore, for_each_netdev_dump()
   has nice properties. Restarting a GETDEVCONF dump if a device has
   been added/removed or if net->ipv6.dev_addr_genid has changed is moot.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 102 +++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 58 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 35246a1c42ea53b3410fab84ae037cbae4b76060..ae53c13ca12c1e05bba6c218ca20f6d66ab2c303 100644
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
@@ -7501,7 +7486,8 @@ int __init addrconf_init(void)
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


