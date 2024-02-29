Return-Path: <netdev+bounces-76150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B93E86C839
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B77A28ADBE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96FD7D062;
	Thu, 29 Feb 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGjab8e8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D497CF14
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206830; cv=none; b=K1/Gb5DczGwMXZ6QBEn4IQFW87GtfP3k+4Mjkp9A8i0P1MwO2I0fgZwv4ce35yD91srUQQ0gA0+2J2h8WgvDHe202XXb3yWkcetejZyVc8FJM3voTGI7cbGN6pVDuhp+u71BIQTDWHgIYaZf+nZv4v43yUw86xfxrUNaeiqWAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206830; c=relaxed/simple;
	bh=Q/d6r2e7neNbuMCijf5MwA6RNUg58qGEZ3RyhMV5DsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bXwIqhTCZUCgxrWVIxDc8jEiZiXMg9MR5ux2K0sB79j9NqeZ07MCGGiCDzfA7zP1tQs0niLjZIIt1G7Rv4RMe0UTqj8xlHETR+oHSrJxXw0OvSvRyz3tDl5++7Ig6NCVNr8hG7BiQPAAxHDxsY8YxCZb/G0QHzEzT/Pj6FR9R2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGjab8e8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so1321303276.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206828; x=1709811628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMnvZ5q5D73jPy3slV8eCUFNP+BTjJ5VxCVihBSQwCc=;
        b=oGjab8e8SZpdvmAllGB2YmerNalgLiw9OHCimX5k91i4zD3XWGtReU9CR6tPq5HYAF
         2mumqZMuzcUsoFnHmU8awGZVuZz6xeytWLFtsd/+7P0GPQ/NEOIWSrk5QrZkFdINuoWP
         AZ7G4wdNBF3b+WcFQHG4MuQ1g6fO2DUYjeIMOp8W+i/GSeY775v6tJe66wz9bOtA66Kc
         UvQWf5sTM5Lbs4OJ70ilUqNoQXjFADUb2gSzRrv873xYfL2KtlH3ZZjYeGvS+R3Mwm9m
         g5tduA35bNMcVFCHTlC4HDtZJUiOuMp2Xsg889rWv+Rxxvt6iMuno5FZE7eLPUUP5f5B
         FCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206828; x=1709811628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMnvZ5q5D73jPy3slV8eCUFNP+BTjJ5VxCVihBSQwCc=;
        b=r9XAFy/oAu4D0jc4DAaVTsTriTcItAwlgcxDKOFLxXh91CereTZRaC4VHItXS5m8qm
         bfBZLacL9TElvF7v0ZX12nxbV+qnxmwTksekcxShxKty8SPnP7vjGsPMvjJrcSdu+Txd
         DKLnAxCH2K/5VKOsg8AC+Q2ixg0XFbpNAJh7YbEDnIcp1b+0PtKdGqrxOdkNAijlInlL
         xXD08IoVkvuodMhNsVFruQWVrZ2OGDyTyi25OtEnXzOXC+YvK//zKXhc8vZN/9APmtdD
         1xDadtV9KMdTRcpk93UffhzsChx5zMhnzgq5zpsBJ+QIQxe/lECeNoMoO/QRsIstpdKc
         BX5w==
X-Forwarded-Encrypted: i=1; AJvYcCXnEkE5OEZw/XoTaWRmMjNAA2WF83veCjaPwfwZJU6RQLbhxVc1GkPLQ4tYS+Ni1Cfr+Psx/j5e7U5SUKHDrcuJrU6BP6eu
X-Gm-Message-State: AOJu0YwkseASpSQh/I89lim0fYDVqpNth+CDpVwzYUdDzO7W60c/bAZd
	uLowkJTn0JeuZAcuciZyKArIehe3ApdUWqefopHSGcLd9uYxDccXfeSIEGA0Z1H7LueeEusOCA/
	JtIAoomtJew==
X-Google-Smtp-Source: AGHT+IE6dGq28hgtJQ9z22W6R9+8cRRmMj6fIuNi3TVltQgiVgVLhmpVj0ew/Qtlln6wuWVW3T7NsMF/LjpdFg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1244:b0:dc6:e20f:80cb with SMTP
 id t4-20020a056902124400b00dc6e20f80cbmr75598ybu.3.1709206828330; Thu, 29 Feb
 2024 03:40:28 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:16 +0000
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-7-edumazet@google.com>
Subject: [PATCH net-next 6/6] inet: use xa_array iterator to implement inet_dump_ifaddr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

1) inet_dump_ifaddr() can can run under RCU protection
   instead of RTNL.

2) properly return 0 at the end of a dump, avoiding an
   an extra recvmsg() system call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 95 ++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 2afe78dfc3c2f6c0394925f1c35532a2dfd26d71..4daa8124f247c256c4f8c1ff29ac621570af0755 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1676,7 +1676,7 @@ static int put_cacheinfo(struct sk_buff *skb, unsigned long cstamp,
 	return nla_put(skb, IFA_CACHEINFO, sizeof(ci), &ci);
 }
 
-static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
+static int inet_fill_ifaddr(struct sk_buff *skb, const struct in_ifaddr *ifa,
 			    struct inet_fill_args *args)
 {
 	struct ifaddrmsg *ifm;
@@ -1805,15 +1805,15 @@ static int inet_valid_dump_ifaddr_req(const struct nlmsghdr *nlh,
 }
 
 static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
-			    struct netlink_callback *cb, int s_ip_idx,
+			    struct netlink_callback *cb, int *s_ip_idx,
 			    struct inet_fill_args *fillargs)
 {
 	struct in_ifaddr *ifa;
 	int ip_idx = 0;
 	int err;
 
-	in_dev_for_each_ifa_rtnl(ifa, in_dev) {
-		if (ip_idx < s_ip_idx) {
+	in_dev_for_each_ifa_rcu(ifa, in_dev) {
+		if (ip_idx < *s_ip_idx) {
 			ip_idx++;
 			continue;
 		}
@@ -1825,9 +1825,9 @@ static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
 		ip_idx++;
 	}
 	err = 0;
-
+	ip_idx = 0;
 done:
-	cb->args[2] = ip_idx;
+	*s_ip_idx = ip_idx;
 
 	return err;
 }
@@ -1859,75 +1859,53 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 	};
 	struct net *net = sock_net(skb->sk);
 	struct net *tgt_net = net;
-	int h, s_h;
-	int idx, s_idx;
-	int s_ip_idx;
-	struct net_device *dev;
+	struct {
+		unsigned long ifindex;
+		int ip_idx;
+	} *ctx = (void *)cb->ctx;
 	struct in_device *in_dev;
-	struct hlist_head *head;
+	struct net_device *dev;
 	int err = 0;
 
-	s_h = cb->args[0];
-	s_idx = idx = cb->args[1];
-	s_ip_idx = cb->args[2];
-
+	rcu_read_lock();
 	if (cb->strict_check) {
 		err = inet_valid_dump_ifaddr_req(nlh, &fillargs, &tgt_net,
 						 skb->sk, cb);
 		if (err < 0)
-			goto put_tgt_net;
+			goto done;
 
-		err = 0;
 		if (fillargs.ifindex) {
-			dev = __dev_get_by_index(tgt_net, fillargs.ifindex);
-			if (!dev) {
-				err = -ENODEV;
-				goto put_tgt_net;
-			}
-
-			in_dev = __in_dev_get_rtnl(dev);
-			if (in_dev) {
-				err = in_dev_dump_addr(in_dev, skb, cb, s_ip_idx,
-						       &fillargs);
-			}
-			goto put_tgt_net;
-		}
-	}
-
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &tgt_net->dev_index_head[h];
-		rcu_read_lock();
-		cb->seq = inet_base_seq(tgt_net);
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			if (h > s_h || idx > s_idx)
-				s_ip_idx = 0;
+			err = -ENODEV;
+			dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
+			if (!dev)
+				goto done;
 			in_dev = __in_dev_get_rcu(dev);
 			if (!in_dev)
-				goto cont;
-
-			err = in_dev_dump_addr(in_dev, skb, cb, s_ip_idx,
-					       &fillargs);
-			if (err < 0) {
-				rcu_read_unlock();
 				goto done;
-			}
-cont:
-			idx++;
+			err = in_dev_dump_addr(in_dev, skb, cb, &ctx->ip_idx,
+					       &fillargs);
+			goto done;
 		}
-		rcu_read_unlock();
 	}
 
+	cb->seq = inet_base_seq(tgt_net);
+
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		in_dev = __in_dev_get_rcu(dev);
+		if (!in_dev)
+			continue;
+		err = in_dev_dump_addr(in_dev, skb, cb, &ctx->ip_idx,
+				       &fillargs);
+		if (err < 0)
+			goto done;
+	}
 done:
-	cb->args[0] = h;
-	cb->args[1] = idx;
-put_tgt_net:
+	if (err < 0 && likely(skb->len))
+		err = skb->len;
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
-
-	return skb->len ? : err;
+	rcu_read_unlock();
+	return err;
 }
 
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
@@ -2818,7 +2796,8 @@ void __init devinet_init(void)
 
 	rtnl_register(PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0);
 	rtnl_register(PF_INET, RTM_DELADDR, inet_rtm_deladdr, NULL, 0);
-	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr, 0);
+	rtnl_register(PF_INET, RTM_GETADDR, NULL, inet_dump_ifaddr,
+		      RTNL_FLAG_DUMP_UNLOCKED);
 	rtnl_register(PF_INET, RTM_GETNETCONF, inet_netconf_get_devconf,
 		      inet_netconf_dump_devconf,
 		      RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED);
-- 
2.44.0.278.ge034bb2e1d-goog


