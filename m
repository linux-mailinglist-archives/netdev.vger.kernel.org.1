Return-Path: <netdev+bounces-93349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F48BB3DA
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2171C2381A
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA354158D78;
	Fri,  3 May 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2P4f/pc1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECC158873
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764075; cv=none; b=rA/Y13S/QRQ8OWnJz8TDzAvGWk2Q43vEs2aSWUlwI1H6XOM/qHJK6wJr0GLdC8hSA4ozf7mrXkV6YOCnrWKFA9Jea1b64B+o4E+scfGYpXKB41NUarl8ATMj4yRMexPUI7lYJ/mcn/tMgVgpvi0uMz/hw0TaotGHCTmBqdvQPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764075; c=relaxed/simple;
	bh=nvsdQhsEhXKktIOdX+nnjFnxX4jjlW1EwDm1UUoWm1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=frtXXriQzGdGC4cQ4HUrL1WTq2qMBLN8+tL2Rj5YBv6NKvrrg2NmsONRKLXfAiPrcsF1EY+oBovYZWCJ4GbdjDQBbZ8FTdFEwEIsIp3P0mLDvDIAb5/oAHYxp/50ddMcFCa9uzw9TTF7tcZGAyl1qRMWU06pY4I6oo2NQAbbO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2P4f/pc1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be25000a4so102032037b3.2
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764073; x=1715368873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zk6JQ9TWgPWKV9n/jYU74muGrDtW2QHmeth5FkVCmA=;
        b=2P4f/pc19fdA6dVvsGBUNJ/9C9mjL37MC9taM68NYqIewciEMD0eofoK3te0faQOfp
         GIwiFWTwJVD1R6591qAOnAVb/+Tf0Z/XWGA+tWcI5UyZo5q6m9jxTZSfiIXbp1slIEne
         ynQSIh/SsCDKc6y7SWFwIaA5eXt6xJwvUYwoxmtVDSv/C2/PdkDQvdVUJ/y6hvfetzH6
         EVQ6t1c3pvEnhntn5xuYEr76Gex7DUTzYJoXHazS/UBEhYGnQB2eAnlHAS9ZH9f5PjXq
         bt7f8+6sxXgqAIUjTxweMi/BnDVyKBTym5xbwL65Nh4HxvepNNt/RfrX9j68wCHx+cC6
         lGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764073; x=1715368873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zk6JQ9TWgPWKV9n/jYU74muGrDtW2QHmeth5FkVCmA=;
        b=VM82DPhi9DPkqDxhyEL8jHwMOl3yw3BcLy5cW3SquVVdbkkqlAkeXrvGkGlnIB2MYs
         CUQ4eqQvAld3Fi22jRzq8lh8yh3fVsTFGWBo47SLSFs66w4jChzfGbTnrKcNRvMITbwI
         CG0Jo4zjyvblqHl6ybQiF505Y0hdwun8YhLQql+pNFVTvgzZiKGUuvIUdZaOqSQjCzj6
         R1V6RbyKFOlQFz0FS4XqienV/l+OlDx9TovU/QGCZqcBwprLeztA7Q7kHqkwyRl9xhPk
         OG6SBP4jERlgvR4yY84emZFVwcHuNx2dDH3JV+PuetQlkY/j+GeghZyID/cJNbkwkUaG
         JjKQ==
X-Gm-Message-State: AOJu0YwR18f6WOE43qFtAnaS9UYicTTwfj0QQDJdEoc03jpCrzs/DO1M
	a9VqxhLsUwRM4dAcyQAZpM+QLBIOnHS8i/w8NH9PnhT5+cq4+w5eUYCFHN1Ig7SyRK9jld7eRo7
	Pu1J6P0AmsQ==
X-Google-Smtp-Source: AGHT+IFhuwZ28m4xko2Oo/h6oBS9i5iWnhd96fDnYlY+aCqzo7P27HA8dablygGnjb/1me4PmxrC2rOsO9E/yg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:10c1:b0:de5:3003:4b7d with SMTP
 id w1-20020a05690210c100b00de530034b7dmr1079076ybu.0.1714764073087; Fri, 03
 May 2024 12:21:13 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:59 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] rtnetlink: allow rtnl_fill_link_netnsid() to run
 under RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to be able to run rtnl_fill_ifinfo() under RCU protection
instead of RTNL in the future.

All rtnl_link_ops->get_link_net() methods already using dev_net()
are ready. I added READ_ONCE() annotations on others.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ppp/ppp_generic.c  | 2 +-
 drivers/net/vxlan/vxlan_core.c | 2 +-
 net/core/rtnetlink.c           | 5 ++---
 net/ipv4/ip_tunnel.c           | 2 +-
 net/ipv6/ip6_tunnel.c          | 2 +-
 net/xfrm/xfrm_interface_core.c | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index fe380fe196e7b4a1ab4a6f15569d258132c00bac..0a65b6d690feb9fb5d4f1a2046d6195ac0bd39f9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1357,7 +1357,7 @@ static struct net *ppp_nl_get_link_net(const struct net_device *dev)
 {
 	struct ppp *ppp = netdev_priv(dev);
 
-	return ppp->ppp_net;
+	return READ_ONCE(ppp->ppp_net);
 }
 
 static struct rtnl_link_ops ppp_link_ops __read_mostly = {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8884913e04738b32848b951c671ae3ede9a828e7..7e3a7d1f2018120fbe729eb5c53a6783f492ead6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4569,7 +4569,7 @@ static struct net *vxlan_get_link_net(const struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 
-	return vxlan->net;
+	return READ_ONCE(vxlan->net);
 }
 
 static struct rtnl_link_ops vxlan_link_ops __read_mostly = {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 66e5be7b92686deb03f58ee43c9707470b8c70d6..91ba27e9169664126f15d19be0299151ce722cd4 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1923,9 +1923,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			goto nla_put_failure;
 	}
 
-	if (rtnl_fill_link_netnsid(skb, dev, src_net, gfp))
-		goto nla_put_failure;
-
 	if (new_nsid &&
 	    nla_put_s32(skb, IFLA_NEW_NETNSID, *new_nsid) < 0)
 		goto nla_put_failure;
@@ -1938,6 +1935,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure;
 
 	rcu_read_lock();
+	if (rtnl_fill_link_netnsid(skb, dev, src_net, GFP_ATOMIC))
+		goto nla_put_failure_rcu;
 	qdisc = rcu_dereference(dev->qdisc);
 	if (qdisc && nla_put_string(skb, IFLA_QDISC, qdisc->ops->id))
 		goto nla_put_failure_rcu;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index ba46cf7612f4fc2cba33c098933b6578dd885587..f1c5f6c3f2f82e19b8e9b696c6900948a946bacc 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1120,7 +1120,7 @@ struct net *ip_tunnel_get_link_net(const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	return tunnel->net;
+	return READ_ONCE(tunnel->net);
 }
 EXPORT_SYMBOL(ip_tunnel_get_link_net);
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 57bb3b3ea0c5a463f0c90659fcffe9358a4084b2..5aec79c2af1a58ed1c57cca6d06951403e087d62 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2146,7 +2146,7 @@ struct net *ip6_tnl_get_link_net(const struct net_device *dev)
 {
 	struct ip6_tnl *tunnel = netdev_priv(dev);
 
-	return tunnel->net;
+	return READ_ONCE(tunnel->net);
 }
 EXPORT_SYMBOL(ip6_tnl_get_link_net);
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 4df5c06e3ece834039e1713377538bd7f4d12a3e..e50e4bf993fa473769a0062ffcc661daefaf1b6b 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -926,7 +926,7 @@ static struct net *xfrmi_get_link_net(const struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
 
-	return xi->net;
+	return READ_ONCE(xi->net);
 }
 
 static const struct nla_policy xfrmi_policy[IFLA_XFRM_MAX + 1] = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


