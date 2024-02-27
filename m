Return-Path: <netdev+bounces-75233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80351868C1A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2129C1F236F0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8C136667;
	Tue, 27 Feb 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZB/yHFXq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0C13667A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025861; cv=none; b=ogoCzsyQF2S4oxl6q0Hdi0pQJbzFmMxZdNpjYDT4suzJTAPOnpFv4M3H/Bz/1+DGwAAux1OyGVIiklrsXcjEW7Kv2s+w21UntcTty6y4oMO1xzz1ESMar+Q9zLoI2C6S3aFFYfq/JeMk5Wa1li7Zv2yrQ3XhX1wIdA7xnGApTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025861; c=relaxed/simple;
	bh=kpSbrNlRFH9J/0vV6hV2zAOKBJurYLJ9YpqWsa5xki4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VPdS27SVTSC5qvhqmKk8D8uoX6eU9gy2HKUIDs2UNYzSjlpTqBjh/qTX/xrTSiLflL08pgoP0bC3u1/qFXRHWqpJ7k9aSVNy/9jtgcnCzL7OL0BgDuE+OWf7EftymDBuj1r04jDCOtgFu2WgM96nudwDclnpU7Ach/W5QSzX968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZB/yHFXq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608cf88048eso52475717b3.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709025859; x=1709630659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Wt7meqEI/IcJrOvTVAAv27qvK/oK7X8exmus6uRQE=;
        b=ZB/yHFXqfTCGhacI/BwcB969uvFROc0dHnCsXL2+NrCKS8usXALwuxdTZ0a2JAakyF
         t85Twsis3zB80gDIGn8act3+NUFunDW/FI3o6V4wP9BOBXIOTKkFrWWGPrCcWV1qt5l/
         VUBNlDfVgR4+vBfee6o5oyHO8oZaTILvZn/IZt1jUQMWCqYGcfOR9w3EhkTMwoTMAPDs
         1LL7svez3aSuhhgldGgbXnD8MYRXViR71T0E4nr8g9MXqoFQOiKQvXBl80k/d71e40ML
         37MnkcS4PufkNFJkIgdUC02ZMdrg7KLFMQnE8nA06JZu26QEZjhzV9B5+eo0LTMe7G+U
         dGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025859; x=1709630659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Wt7meqEI/IcJrOvTVAAv27qvK/oK7X8exmus6uRQE=;
        b=iGU7UbC5h9b+3r1YUUeYosO2XG4LcdJh3e2wMKfNi/1GZPrB+pWtTiZjtOF9kKfRdd
         d57RgDDUO9wuxhWxKVn8wwyJ7dLeek5dZ9PAXZ/4cClCak2OSBILDU95L1pfqCuR50x4
         QrqWoHC22nb7JAGQQImphYKLaGGetngm3MO5wMtuJqc7DrorRSXmWGFddGG/hHnFew11
         HZ7eW/GO+3IqzfqhBgfwp2IuGTGkdfHq11w/Jzz1x+aGPquRdbapq8zUtJrwluzbN+zW
         xuPx+IMnTUgyiV52XVweCi+7NdS9rM2I8rmRWQYnkB9qrp4sk8KhWgOqYu4WK1Ne/AFf
         w3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWivFJMybmTq5wd45iEJDv5VKWm+6MJrHuJImTkoFbHKeqyc2OgjLZv01+jWcQOugPWNaJliBMD5cLWpq1eYVJjERNS4iEz
X-Gm-Message-State: AOJu0YxntpSRLxscIW06iXBYfmTQ1sMb0n3Ydp1kcJN//hKpWIAjl8N1
	DdNIz3OwqtqT0AeSYul3po4MqCVckkDRmapQyspYGNyMAHaiitu6QtbzBsnLmaWGW1zCkh8/mHs
	9Ed16HVdlWw==
X-Google-Smtp-Source: AGHT+IFiOXtYcVcrbcpQ+f4ssuc9TOBBpG0L7tajwErpBOPiqssJ0HbexIzBbNF1z2N7ygVdZdCrKERQ9I8q9g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:10c2:b0:dcd:5e5d:458b with SMTP
 id w2-20020a05690210c200b00dcd5e5d458bmr384798ybu.3.1709025858743; Tue, 27
 Feb 2024 01:24:18 -0800 (PST)
Date: Tue, 27 Feb 2024 09:24:11 +0000
In-Reply-To: <20240227092411.2315725-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227092411.2315725-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227092411.2315725-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] inet: use xa_array iterator to implement inet_netconf_dump_devconf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

1) inet_netconf_dump_devconf() can run under RCU protection
   instead of RTNL.

2) properly return 0 at the end of a dump, avoiding an
   an extra recvmsg() system call.

3) Do not use inet_base_seq() anymore, for_each_netdev_dump()
   has nice properties. Restarting a GETDEVCONF dump if a device has
   been added/removed or if net->ipv4.dev_addr_genid has changed is moot.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 101 +++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 58 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f045a34e90b974b17512a30c3b719bdfc3cba153..af741af61830aeb695e7e75608515547dade8f39 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2267,11 +2267,13 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	int h, s_h;
-	int idx, s_idx;
+	struct {
+		unsigned long ifindex;
+		unsigned int all_default;
+	} *ctx = (void *)cb->ctx;
+	const struct in_device *in_dev;
 	struct net_device *dev;
-	struct in_device *in_dev;
-	struct hlist_head *head;
+	int err = 0;
 
 	if (cb->strict_check) {
 		struct netlink_ext_ack *extack = cb->extack;
@@ -2288,64 +2290,47 @@ static int inet_netconf_dump_devconf(struct sk_buff *skb,
 		}
 	}
 
-	s_h = cb->args[0];
-	s_idx = idx = cb->args[1];
-
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[h];
-		rcu_read_lock();
-		cb->seq = inet_base_seq(net);
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			in_dev = __in_dev_get_rcu(dev);
-			if (!in_dev)
-				goto cont;
-
-			if (inet_netconf_fill_devconf(skb, dev->ifindex,
-						      &in_dev->cnf,
-						      NETLINK_CB(cb->skb).portid,
-						      nlh->nlmsg_seq,
-						      RTM_NEWNETCONF,
-						      NLM_F_MULTI,
-						      NETCONFA_ALL) < 0) {
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
+		in_dev = __in_dev_get_rcu(dev);
+		if (!in_dev)
+			continue;
+		err = inet_netconf_fill_devconf(skb, dev->ifindex,
+						&in_dev->cnf,
+						NETLINK_CB(cb->skb).portid,
+						nlh->nlmsg_seq,
+						RTM_NEWNETCONF, NLM_F_MULTI,
+						NETCONFA_ALL);
+		if (err < 0)
+			goto done;
 	}
-	if (h == NETDEV_HASHENTRIES) {
-		if (inet_netconf_fill_devconf(skb, NETCONFA_IFINDEX_ALL,
-					      net->ipv4.devconf_all,
-					      NETLINK_CB(cb->skb).portid,
-					      nlh->nlmsg_seq,
-					      RTM_NEWNETCONF, NLM_F_MULTI,
-					      NETCONFA_ALL) < 0)
+	if (ctx->all_default == 0) {
+		err = inet_netconf_fill_devconf(skb, NETCONFA_IFINDEX_ALL,
+						net->ipv4.devconf_all,
+						NETLINK_CB(cb->skb).portid,
+						nlh->nlmsg_seq,
+						RTM_NEWNETCONF, NLM_F_MULTI,
+						NETCONFA_ALL);
+		if (err < 0)
 			goto done;
-		else
-			h++;
-	}
-	if (h == NETDEV_HASHENTRIES + 1) {
-		if (inet_netconf_fill_devconf(skb, NETCONFA_IFINDEX_DEFAULT,
-					      net->ipv4.devconf_dflt,
-					      NETLINK_CB(cb->skb).portid,
-					      nlh->nlmsg_seq,
-					      RTM_NEWNETCONF, NLM_F_MULTI,
-					      NETCONFA_ALL) < 0)
+		ctx->all_default++;
+	}
+	if (ctx->all_default == 1) {
+		err = inet_netconf_fill_devconf(skb, NETCONFA_IFINDEX_DEFAULT,
+						net->ipv4.devconf_dflt,
+						NETLINK_CB(cb->skb).portid,
+						nlh->nlmsg_seq,
+						RTM_NEWNETCONF, NLM_F_MULTI,
+						NETCONFA_ALL);
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
@@ -2829,5 +2814,5 @@ void __init devinet_init(void)
 	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr, 0);
 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
 		      inet_netconf_dump_devconf,
-		      RTNL_FLAG_DOIT_UNLOCKED);
+		      RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED);
 }
-- 
2.44.0.rc1.240.g4c46232300-goog


