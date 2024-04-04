Return-Path: <netdev+bounces-84888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E18E8988B9
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781AC1F23142
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813461272D3;
	Thu,  4 Apr 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hptzp/Lx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11C53E30
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237061; cv=none; b=KgBUM42GPKkXPTTTawFh8Z4Nt7TcItNWQB9CU+mxh7vpTUy+abfo2KbOGG7Ktgq74GJ6vTyxLquQPVbRfxvHOOr8uB21qYbo7esmrdzWPsRjcYNyj6D/k68jgamOiy8zmTPULWLwlOz67zmMVFZdHYbn5Eddl7tEcjGiSgkxAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237061; c=relaxed/simple;
	bh=KjUxjkX9h/D1TanlEVt1nFRrEbVPPpBL+vnL+olkIgI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Yba1YgmQ+ZG1YIqyvgVb6BXup1cFTGRhLGAlGsKgXqWxVIN/Azc65sqXelBWo5sVVrpIBn6ZaOwA6+uXKZF9aeJVt2BpkHcgGD4CKBGSd1kbkpXvWh4afwPIo0bK45tHweGSqTp1IFAd5tLbTDjhs9JRJCNJhd3GQe+ye+FvgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hptzp/Lx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150dcdf83fso18082257b3.2
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712237059; x=1712841859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SU4eDsRCf7Z2gwIvqe7XP+V+zUElZuRXatTC3F4VV6w=;
        b=Hptzp/LxVx9qhS0jOs5nlBDo+zzH24ejsJ7tuvEhfNxZ34c2635OoOfgVCvd9OV7r2
         X/wCzuEKne8ngaLgsFxV9F6UTM2jc5grddQhw7188oleuIgNjkv2RLsZnwRS3Hf3clY4
         MzN4DH5XcxSvXvq6i6jxKS+uVZxPA+l+GfKeRHTUzksZWGkLBFFfBqqFIUkQTKgTpsJ6
         XDtcksmCfwnsb5SAvW450yLQGXKC+cTeViUnxLCg1BLbGfnDpK5rkXCvRh6L4/FEdYBb
         I9Ogv1LMGrQPr5F8pjkwSg6fNeKXk3g15oGkoJsh9t+XKmh0SksxxcweP9tr3A8zm8LL
         bZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237059; x=1712841859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SU4eDsRCf7Z2gwIvqe7XP+V+zUElZuRXatTC3F4VV6w=;
        b=BFZzqrqkyolCUs4M5KDRlnj4RBmSCU9bmlNTqUY1y95sYI0IBrIq/hqBdwKkcpOLpS
         /iVUpB/nyqURJ6MfdahboLK06ad94dTPDXLBcghHGnZL04xdY0LYS+7W3vpAfn55xgWs
         qQICKdOIAIX28LaC8CS4so7RG3GUHz2MUGu3AhwTRWSTPVYDRAvm2uO4y2b6bqJ1JV4w
         iPoPJK/fehcJwbsyDIN2IM4TrnNOIIMzE0v0kIQCgIghllvJJLUonN0pEKP9eY8Ze8kl
         WLAlItb4jXH48ba8kTf85t3Gv1MTH/mLxbGlyaEF+1XPyxxAFzLL9YA01GC5s7fBVee/
         fhwQ==
X-Gm-Message-State: AOJu0YzI1yFN9Cu5315dklx+1BJXGE7GeASYdHkCzHy3akaexow2ZiH0
	pATKbksuUsJ5/etwOL0EyOWhygQs/+wkd1DDUHswyvKa+womrreemgH4y7LoxPjblq/s+QF+JxT
	6GhS3v0N+fw==
X-Google-Smtp-Source: AGHT+IFfixs16qCO0AYCdybkI0Lqg80sPbTlWNzMoFa6jNc/UOc/iyEuO4NjD7rB+wKyhyn5vgK4s/WBSVrlcA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:cb07:0:b0:615:378a:112c with SMTP id
 n7-20020a0dcb07000000b00615378a112cmr594680ywd.5.1712237058991; Thu, 04 Apr
 2024 06:24:18 -0700 (PDT)
Date: Thu,  4 Apr 2024 13:24:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404132413.2633866-1-edumazet@google.com>
Subject: [PATCH v2 net-next] ipv6: remove RTNL protection from ip6addrlbl_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No longer hold RTNL while calling ip6addrlbl_dump()
("ip addrlabel show")

ip6addrlbl_dump() was already mostly relying on RCU anyway.

Add READ_ONCE()/WRITE_ONCE() annotations around
net->ipv6.ip6addrlbl_table.seq

Note that ifal_seq value is currently ignored in iproute2,
and a bit weak.

We might user later cb->seq  / nl_dump_check_consistent()
protocol if needed.

Also change return value for a completed dump,
so that NLMSG_DONE can be appended to current skb,
saving one recvmsg() system call.

v2: read net->ipv6.ip6addrlbl_table.seq once, (David Ahern)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link:https://lore.kernel.org/netdev/67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org/
---
 net/ipv6/addrlabel.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
index 17ac45aa7194ce9c148ed95e14dd575d17feeb98..acd70b5992a7b9c1aadcfb9a279da7fe6aebfed9 100644
--- a/net/ipv6/addrlabel.c
+++ b/net/ipv6/addrlabel.c
@@ -234,7 +234,8 @@ static int __ip6addrlbl_add(struct net *net, struct ip6addrlbl_entry *newp,
 		hlist_add_head_rcu(&newp->list, &net->ipv6.ip6addrlbl_table.head);
 out:
 	if (!ret)
-		net->ipv6.ip6addrlbl_table.seq++;
+		WRITE_ONCE(net->ipv6.ip6addrlbl_table.seq,
+			   net->ipv6.ip6addrlbl_table.seq + 1);
 	return ret;
 }
 
@@ -445,7 +446,7 @@ static void ip6addrlbl_putmsg(struct nlmsghdr *nlh,
 };
 
 static int ip6addrlbl_fill(struct sk_buff *skb,
-			   struct ip6addrlbl_entry *p,
+			   const struct ip6addrlbl_entry *p,
 			   u32 lseq,
 			   u32 portid, u32 seq, int event,
 			   unsigned int flags)
@@ -498,7 +499,8 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	struct ip6addrlbl_entry *p;
 	int idx = 0, s_idx = cb->args[0];
-	int err;
+	int err = 0;
+	u32 lseq;
 
 	if (cb->strict_check) {
 		err = ip6addrlbl_valid_dump_req(nlh, cb->extack);
@@ -507,10 +509,11 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	rcu_read_lock();
+	lseq = READ_ONCE(net->ipv6.ip6addrlbl_table.seq);
 	hlist_for_each_entry_rcu(p, &net->ipv6.ip6addrlbl_table.head, list) {
 		if (idx >= s_idx) {
 			err = ip6addrlbl_fill(skb, p,
-					      net->ipv6.ip6addrlbl_table.seq,
+					      lseq,
 					      NETLINK_CB(cb->skb).portid,
 					      nlh->nlmsg_seq,
 					      RTM_NEWADDRLABEL,
@@ -522,7 +525,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rcu_read_unlock();
 	cb->args[0] = idx;
-	return skb->len;
+	return err;
 }
 
 static inline int ip6addrlbl_msgsize(void)
@@ -614,7 +617,7 @@ static int ip6addrlbl_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	rcu_read_lock();
 	p = __ipv6_addr_label(net, addr, ipv6_addr_type(addr), ifal->ifal_index);
-	lseq = net->ipv6.ip6addrlbl_table.seq;
+	lseq = READ_ONCE(net->ipv6.ip6addrlbl_table.seq);
 	if (p)
 		err = ip6addrlbl_fill(skb, p, lseq,
 				      NETLINK_CB(in_skb).portid,
@@ -647,6 +650,7 @@ int __init ipv6_addr_label_rtnl_register(void)
 		return ret;
 	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDRLABEL,
 				   ip6addrlbl_get,
-				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED);
+				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED |
+						    RTNL_FLAG_DUMP_UNLOCKED);
 	return ret;
 }
-- 
2.44.0.478.gd926399ef9-goog


