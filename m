Return-Path: <netdev+bounces-75006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41041867AC8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1BF1C24C48
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDF12C55D;
	Mon, 26 Feb 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dob0Qoi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BFA12BF3C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962689; cv=none; b=s4TepG+9VFXpBTa5UmwasyUrBm7ybsZZuSTBPbm/uqRpm3VTD+NJDGJ4xVRlGN0BNLM4Drf/7jld6tE1cUXXZcG7JnE705PO76WMoycHXRmaG1q1qVWArSY5oWyhiElOpn2zG0EhnDszi8gwxtSv2bBaTuVygm4umkj9jTbWRB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962689; c=relaxed/simple;
	bh=gviFyM7gx3yNTl5QmKJk0NoVOtWhLpoA5zviLCIcSbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N9V5dBfVBYHdly50K82INTlp5cJ3lU0MPCUjewjGxjOhzGHupfZpuTxwBukBasFaTex1Wjls/uHLE54sV4sMC/ARGE88o5TZITv+5e9BYV/Qv7AnnQIr32XJn5/pPtD+e5Yn2un/Cg8nrNysG/bQ9o5zl3zW5eiIe/LWkMVCjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dob0Qoi/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607c9677a91so52450847b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962686; x=1709567486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mC+jl3uD2GuEYLGV1ug11qLzSBpZtAlx8KKLjb5ahaw=;
        b=dob0Qoi/rdt3QvcFv1yRVJHrBzD1OHylRXdwJHbighoYCPB+MHLfHRTmFjaP/VIS/Y
         7cnUrmi0H8lTc/ZO1sDC+9SCb8IPc/5N47rfCt+lTQ9NHE0q3H+QfCv3s8P6c+5DFYNd
         b24a/z0vykNCvupb2h/aSvBn0jc+x3GBuF8GavFmTorxMqoxgHtFWhovjLoLfPGikxKT
         JVab1HKH8+u72YAiuRgnqLNHdl2DplC2ja0teEnOqeLKv7EJc0Ja99PJfG3RzyMWnSLw
         iihkWlZzQgiJP4+ZaFo+rSv89caBG5yj7PLmiUR1oca2ygJUj+mwOE8lgzXbpjFEw5WR
         P/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962686; x=1709567486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC+jl3uD2GuEYLGV1ug11qLzSBpZtAlx8KKLjb5ahaw=;
        b=HEgSSWQAlEpbj3CjEHEJ5jvTN/k/uiZcOWLWD6rWEWItiiJBk4SC9xopE/RX70Vvrr
         9inG3z0GwH7q+ZFfcFnZ8gE/W+3JPVt08uhfQpQjsXezzhZrNV+PtFmCSMzH1fBtNv+u
         nYK1Gt8YC+jysdnO4UG5YpQuKJM97H/HHgq5cjjUlsyUW016AMbVqWe3OZIQA/2Fs9J/
         pW0L1vE60xfUTpVDYfP7iMJye6m/QCQu4qhAPQwFjNUrrH3WBORWW+HqjuUoh5M6+wqX
         uX42GTA2AGcTKpAVf7dwOnIwGQRWYqxknlVtGkXQzc+n41F0YGa4dKeNXvB82jIaJfeJ
         +tVw==
X-Forwarded-Encrypted: i=1; AJvYcCXXBlYzmQvMiIX92LP9LduRXE1Wqjr3qnjTB5BEBpa6TjW+2AwyFTp3T5o2K5XPVrgY5UBjplLQ6bNFO0IvZPGU5RbYwR5F
X-Gm-Message-State: AOJu0YwnbVaB9UZquu4bJpHOiS2dV3Ggnd4e7vI1BO58LUFn0xz83tBv
	k4aLDYfBuVJRPpMZoJvMbUnY9mVVWeg+/N0IY0YObdhSWuSO8SaKZ4rVLDYRt7qdHUyLWenF/+X
	0PbFonSYTyg==
X-Google-Smtp-Source: AGHT+IH4t3VLomFhWWUzhvgPHKcHNUSFIb7YyBSL1HbPtvebP3wSmw4yIYICJPGN7BNzWeZcuE9cg0j6/jkqrg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1009:b0:dc7:5aad:8965 with SMTP
 id w9-20020a056902100900b00dc75aad8965mr2211739ybt.0.1708962686527; Mon, 26
 Feb 2024 07:51:26 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:55 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-14-edumazet@google.com>
Subject: [PATCH net-next 13/13] ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
---
 net/ipv6/addrconf.c | 103 +++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 59 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 74c33b132073934290632a953bce8ee6a5124ca9..08b4728733e3ed16d139d2bd4b50328552b3c27f 100644
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
@@ -754,64 +755,47 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
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
-done:
-	cb->args[0] = h;
-	cb->args[1] = idx;
-
-	return skb->len;
+done:	if (err < 0 && likely(skb->len))
+		err = skb->len;
+	rcu_read_unlock();
+	return err;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -7503,7 +7487,8 @@ int __init addrconf_init(void)
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


