Return-Path: <netdev+bounces-285453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFglGgLR/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:50:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4D4ED130
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17EE3004C74
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD4330B0E;
	Thu,  7 May 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iy2c9FUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10E241CB7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175950; cv=none; b=n0MULVpmWqptoH+vBTkxg+6fWmIIyNxao1t/NSeDXBQumXtL/iCPOuBD5H+RxBEYuvWhDFmxiKvE5zqxUZptZz6Cd+1pat3+6fJZpFUfp0VVTfKAK9bQ04RHM5tsRaJoyLlTR4mfeaznMHpF8CgJOBVwkPOUTcd/RxmgYNPqOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175950; c=relaxed/simple;
	bh=LQnp6Qlb++8+uvQJyOOx/rfzXd4RMcR2UTZO5HcbheQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XjqkMemcn0RqP9p4MS8PlQvSwvikOYug5JYJe90r+ms5SdC7cYITDtYj3jdg5T4Ce941v4PKKFsRVabj4R9EQVE2dGz280un5xEK1iE+2bP0ksWl2tvEAAn6XdkfY5XjnWLw7XGrCBffIxTpb2qOSBNcSwtUgq0460IC2QeIatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iy2c9FUP; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50e2592ea3bso11253681cf.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778175948; x=1778780748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=am5up6xL0FwrVjmMJZRGMdIgHL9GBXoxyQ4ii5NQ6VU=;
        b=Iy2c9FUPC1jmAoWyyvkxubMWnwvGru2rzY2eFQDNBmATM+ZsCQXpooOroNZ6nRCziT
         ntWHZ73UJiSt3iBapbTUs3vh3j100SxndUJzjmmTmhkEvAe2ZosyyZDNpiqG51EdVyOz
         fWscAhIHpa7Ao/rgygvBYFeFAyqJnN6ututCoyROCGKQgiMi7Th9ZID1GGjuWrWSBKZp
         yY3XyRiDe/lAbbUrYU7jEJVIxsdHmUOxUX4E+mL86/r+TLr1rVJg7wiFdUlwbu5xSLhE
         0APImsbGK03Lu3UH6oY9diVOUSM8E51Ffk9wfYyArasF9AXj2zIFBXVMUCpoBFVLfcCo
         rjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175948; x=1778780748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am5up6xL0FwrVjmMJZRGMdIgHL9GBXoxyQ4ii5NQ6VU=;
        b=tB3NvO6ob6oh0cWaQIt+K6VgvrBAtAZ1NHtxT8boLfg8BicGz+N5K3qItJ/YxVvLJj
         w8WMpFTi+miNtUWFQDvVcY5xRMJLUnxgTu0J2zdzRccN7Qtbv48rbkxXBlwnIHI4yA8g
         vip1QCpzqAGl9YrJ64jyYg6+JILm5HX/YVK2LL6QtkYy8TCPkFPVOsi0MLPHXfMvSG/z
         Z67Qfs3SgL97yH9wzZq4kAKBpGbqDFdvvQpf3yVMNykY6h1/v5c+FwScC91ES04OXMIb
         Ddp64WSJk4e2Dq6DCTv9CJ8pCiRzZif9SR23U2g4pq2aH7R4tpZZqJnZHwE+hqcN7oGk
         LzQA==
X-Forwarded-Encrypted: i=1; AFNElJ/p938b0YpRjiBzgLCbq9IwYAuGheJmJFuP54KW5Jw2XXpa596jUivmG9ZaSPmQgv2GZ+VUtwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Os90DMC/IxdGEa2AME6iA7uAUL7CrLBBeOndxJZsuPSYIDO2
	c+B+YVSQQ0liS25m14xb9avrVREgn3x/jooBPYpxtmy1PwcIhm2a+sMOj1GR55RRoFWRs2u3H+N
	N+VXlYRsL7g+wmw==
X-Received: from qtbka24.prod.google.com ([2002:a05:622a:4418:b0:50e:5e0a:d8a7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a93:b0:50f:c2f8:4081 with SMTP id d75a77b69052e-514621d45c7mr124818791cf.53.1778175947893;
 Thu, 07 May 2026 10:45:47 -0700 (PDT)
Date: Thu,  7 May 2026 17:45:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507174547.4125412-1-edumazet@google.com>
Subject: [PATCH net] rtnetlink: add RTEXT_FILTER_TERSE_DUMP support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C2D4D4ED130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285453-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

iproute2 can spend considerable amount of time in ll_init_map()
or ll_link_get() to dump verbose netdev attributes, contributing
to RTNL pressure.

Add RTEXT_FILTER_TERSE_DUMP new flag so that rtnl_fill_ifinfo()
limits its output to:

- struct nlmsghdr
- IFLA_IFNAME
- IFLA_PROP_LIST

We can later avoid using RTNL when RTEXT_FILTER_TERSE_DUMP
is requested, as none of these attributes need RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/rtnetlink.h |  1 +
 net/core/rtnetlink.c           | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index dab9493c791b8465c6476990f42c4ee5ae82da2d..4b1dbd554e5c72c90d2416f7ade37956ad5472b7 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -840,6 +840,7 @@ enum {
 #define RTEXT_FILTER_CFM_CONFIG	(1 << 5)
 #define RTEXT_FILTER_CFM_STATUS	(1 << 6)
 #define RTEXT_FILTER_MST	(1 << 7)
+#define RTEXT_FILTER_TERSE_DUMP	(1 << 8)
 
 /* End of information exported to user level */
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b613bb6e07df6586aa06e7a59c8384dcedffeeef..7a9a769d142b6826d7fb01b599a4d9e0ae09a97d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1295,7 +1295,12 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 
 	size = NLMSG_ALIGN(sizeof(struct ifinfomsg))
 	       + nla_total_size(IFNAMSIZ) /* IFLA_IFNAME */
-	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
+	       + rtnl_prop_list_size(dev);
+
+	if (ext_filter_mask & RTEXT_FILTER_TERSE_DUMP)
+		return size;
+
+	size += nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
 	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
 	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
@@ -1342,7 +1347,6 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
 	       + nla_total_size(4)  /* IFLA_MIN_MTU */
 	       + nla_total_size(4)  /* IFLA_MAX_MTU */
-	       + rtnl_prop_list_size(dev)
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size(dev)
@@ -1940,15 +1944,18 @@ static int rtnl_fill_alt_ifnames(struct sk_buff *skb,
 	struct netdev_name_node *name_node;
 	int count = 0;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(name_node, &dev->name_node->list, list) {
-		if (nla_put_string(skb, IFLA_ALT_IFNAME, name_node->name))
+		if (nla_put_string(skb, IFLA_ALT_IFNAME, name_node->name)) {
+			rcu_read_unlock();
 			return -EMSGSIZE;
+		}
 		count++;
 	}
+	rcu_read_unlock();
 	return count;
 }
 
-/* RCU protected. */
 static int rtnl_fill_prop_list(struct sk_buff *skb,
 			       const struct net_device *dev)
 {
@@ -2071,13 +2078,20 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	ifm->ifi_flags = netif_get_flags(dev);
 	ifm->ifi_change = change;
 
-	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
-		goto nla_put_failure;
-
 	netdev_copy_name(dev, devname);
 	if (nla_put_string(skb, IFLA_IFNAME, devname))
 		goto nla_put_failure;
 
+	if (rtnl_fill_prop_list(skb, dev))
+		goto nla_put_failure;
+
+	if (ext_filter_mask & RTEXT_FILTER_TERSE_DUMP)
+		goto end;
+
+	if (tgt_netnsid >= 0 &&
+	    nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
+		goto nla_put_failure;
+
 	if (nla_put_u32(skb, IFLA_TXQLEN, READ_ONCE(dev->tx_queue_len)) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
@@ -2190,8 +2204,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure_rcu;
 	if (rtnl_fill_link_ifmap(skb, dev))
 		goto nla_put_failure_rcu;
-	if (rtnl_fill_prop_list(skb, dev))
-		goto nla_put_failure_rcu;
 	rcu_read_unlock();
 
 	if (dev->dev.parent &&
@@ -2210,6 +2222,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (rtnl_fill_dpll_pin(skb, dev))
 		goto nla_put_failure;
 
+end:
 	nlmsg_end(skb, nlh);
 	return 0;
 
-- 
2.54.0.563.g4f69b47b94-goog


