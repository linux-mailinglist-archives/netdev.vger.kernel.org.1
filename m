Return-Path: <netdev+bounces-234105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B828AC1C7BF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2ABC64E2083
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7086354AE3;
	Wed, 29 Oct 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4fBx6Um"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F7354AC3
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759244; cv=none; b=igyOZiZ9AclJuObYK0ueNU9+5LLbz7t+1zguJMxnWwzBWUNuXUnTyeYrLwuZHWvLH/6qFCe1KaaBkR4dZIOqnfnVPCvkDta4oW8DFHnK9o20BVmuwwTGEp4rr68pRwgqoklUk6y9g18IO0QbfuB3ePdwmK6MP2fNyaEN2uvaHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759244; c=relaxed/simple;
	bh=hOgy4wPvRALVBW/qYIP4NVgTLMypyX6lKbDB5jvXOlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UHcLaW31xL/6n/W2hw/H7ixZeKpPsrVn8rgpOaacZ49RY2Hz41qFkNTGl6yVTR29GRV//a1pSOT1W3j2BwAL4uvjjDC8qagX9YkR6ektmoMy4bATJk7lFq947CqbPm7fXhTPW3uRMB2f2+3rpDKOC1AHYZGynlOIgqmxVshyznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4fBx6Um; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso317558a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759242; x=1762364042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1g0npKYvZy13A/MXtKX8IgDK2k8I9IElqeS76OLiKuU=;
        b=l4fBx6UmtR721R8POlKOeZFKtvYvUKOeYT6v/1h0Oe9L8YuAFutxjTgoXhnKWAXTev
         TvrrycDLQ7K1L7d44qySOjVfFqPc7yzcOFMXetNWg/2r+gbUb8qdPCyIwg/KS75ypeFb
         4C6j1dk0R2VV35ixrGowNQKKiK6phuqdBr/uO3hZKteC5glviPpycDnBlPiYb/AFKEW8
         5WNu2zVR/pLEkS8dW6t8URxnwMG5+qlaQKuCH/SRf5ELmwRcIrzjghCoewC2JkCFNTde
         ternxaqldLd+gf7bQR4rrsxmtNs0MUE3lMHzlT+I/XveqxCZhrwejQKOIUp32WQMWk+N
         7RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759242; x=1762364042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g0npKYvZy13A/MXtKX8IgDK2k8I9IElqeS76OLiKuU=;
        b=NDC0nczbmgv+gw+mVhiFt7SbAsq2RB7rYzsqDbNiIqSCbA5B9+r/q4ZfaZjdivNq+a
         1mZnncynBV/15fllWO2BA+Cf74SFLbtG6wnar3ysd1VAe7eJpz+oc11tMQCTa11lhYpn
         pm49ZTai7BZugZRWFkEwEh62zIufI+7fGh4oqT7XMyo7WGzPCtm2zWTz2qjHLPYtQimy
         acKeVDIXvT76DM/G4g99l1ZLbN/YAyNzjzQzageXZcsq564oJFDh/XNdy4cWIU/1dB7X
         RbjAhugweRahVFlc42o0CmvgpZhzwPriuHuNnf44odxotmValUXmAKOhohMB4abSpSqP
         6AKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGFantGRzE9b64Nz8CML71TGJAvpsEazBJBV6WeXa7WV6QEXpnfGtSy3HYVSF4kfZ90HIcBw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJlzWntN/kYfZjY1zw7U6NC2HlJzfKKZlDSlZK4560i5ojqRA
	If1lq11SdKs4JxKgNEI7tduOgiSMCxMW/a8+2ogoFUZH7RP7iV73Kbr1J7aIfiUiC4Mh5u/xmup
	4fDqiXw==
X-Google-Smtp-Source: AGHT+IG6DY5UsXPP/+rkLrrqth90TsiocxPIvQCllN3aUKJTDnSJ0alay4Nviyqwj+CM0HAjKqmB1sk7Wc4=
X-Received: from pjzn3.prod.google.com ([2002:a17:90b:d03:b0:339:ee99:5e9b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164d:b0:33f:eca0:47ae
 with SMTP id 98e67ed59e1d1-3404c46c10amr171043a91.28.1761759242312; Wed, 29
 Oct 2025 10:34:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:33:02 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/13] mpls: Convert mpls_dump_routes() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_dump_routes() sets fib_dump_filter.rtnl_held to true and
calls __dev_get_by_index() in mpls_valid_fib_dump_req().

This is the only RTNL dependant in mpls_dump_routes().

Also, synchronize_rcu() in resize_platform_label_table()
guarantees that net->mpls.platform_label is alive under RCU.

Let's convert mpls_dump_routes() to RCU and use dev_get_by_index_rcu().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Removed dup entry of RTM_GETROUTE in mpls_rtnl_msg_handlers[]
---
 net/mpls/af_mpls.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 35ae3dbd7bdc..f00f75c137dc 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2153,7 +2153,7 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 
 		if (i == RTA_OIF) {
 			ifindex = nla_get_u32(tb[i]);
-			filter->dev = __dev_get_by_index(net, ifindex);
+			filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
 				return -ENODEV;
 			filter->filter_set = 1;
@@ -2191,20 +2191,19 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	struct mpls_route __rcu **platform_label;
 	struct fib_dump_filter filter = {
-		.rtnl_held = true,
+		.rtnl_held = false,
 	};
 	unsigned int flags = NLM_F_MULTI;
 	size_t platform_labels;
 	unsigned int index;
+	int err;
 
-	ASSERT_RTNL();
+	rcu_read_lock();
 
 	if (cb->strict_check) {
-		int err;
-
 		err = mpls_valid_fib_dump_req(net, nlh, &filter, cb);
 		if (err < 0)
-			return err;
+			goto err;
 
 		/* for MPLS, there is only 1 table with fixed type and flags.
 		 * If either are set in the filter then return nothing.
@@ -2212,14 +2211,14 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 		if ((filter.table_id && filter.table_id != RT_TABLE_MAIN) ||
 		    (filter.rt_type && filter.rt_type != RTN_UNICAST) ||
 		     filter.flags)
-			return skb->len;
+			goto unlock;
 	}
 
 	index = cb->args[0];
 	if (index < MPLS_LABEL_FIRST_UNRESERVED)
 		index = MPLS_LABEL_FIRST_UNRESERVED;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
+	platform_label = rcu_dereference(net->mpls.platform_label);
 	platform_labels = net->mpls.platform_labels;
 
 	if (filter.filter_set)
@@ -2228,7 +2227,7 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	for (; index < platform_labels; index++) {
 		struct mpls_route *rt;
 
-		rt = rtnl_dereference(platform_label[index]);
+		rt = rcu_dereference(platform_label[index]);
 		if (!rt)
 			continue;
 
@@ -2243,7 +2242,13 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	cb->args[0] = index;
 
+unlock:
+	rcu_read_unlock();
 	return skb->len;
+
+err:
+	rcu_read_unlock();
+	return err;
 }
 
 static inline size_t lfib_nlmsg_size(struct mpls_route *rt)
@@ -2767,7 +2772,8 @@ static struct rtnl_af_ops mpls_af_ops __read_mostly = {
 static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_module = {
 	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
 	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
-	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
+	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes,
+	 RTNL_FLAG_DUMP_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
 	 RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.51.1.851.g4ebd6896fd-goog


