Return-Path: <netdev+bounces-152154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768569F2E7C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FC01881155
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E999203707;
	Mon, 16 Dec 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="smaTKDxB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D82AF03
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346057; cv=none; b=YuxofTSH5+k3nwdHebtqmfSF3XshXhSjtSV7Seu5pvJiAOvi4aBIGZD+6LIlqwNWheVmAy4CEyaMEsa8q9b3S0kRoIUfU/xUVyxgMZMSMUQJ0EsZjwzH0/jUu3iz5CpSOuHH8fFUHZoWW9M+n8Rwu+6kbohf3xQRI6oaA4oMKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346057; c=relaxed/simple;
	bh=25INFod25r02Tb2AINb07dTD48hmsD99r7N6PcxFaF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBYDar8I8zVMk/BiW15AsT7q5HCRdgBmPVAIYdb2tvUVYdgYgASt6trfR9zO1iITHPVjJNjv33eNq3pWchptpBZtltPbphtAQDdM5WtZvaUCPq2t2YD0yIXO+z0nHzELOKDCj6kujrZ4AJO18Ikmoe2hnZv/7Mt4ZrjS29Hr0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=smaTKDxB; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734346056; x=1765882056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JpF6UDjgEI2WVejsLaf5w9glffWhp3LOCnUv8XJGus=;
  b=smaTKDxBAV0HJ5bR15QvQA6xxqzjc6u5vQewS6IQT73ZygINvuPz/Tnn
   vjMwlJ9QXDQ2IG2PcMG/yeZbgEs1C535vsqXuvgFmy4uQssvnIY2+3VFw
   rFN5+QrkEWQ+aspjNYwmtUBH/CFyhPFLQINzP0JD0KkL3hvGNx1T3sHcH
   k=;
X-IronPort-AV: E=Sophos;i="6.12,238,1728950400"; 
   d="scan'208";a="456363540"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 10:47:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:65415]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.211:2525] with esmtp (Farcaster)
 id e1c41078-400a-4384-b560-00125e7f1260; Mon, 16 Dec 2024 10:47:31 +0000 (UTC)
X-Farcaster-Flow-ID: e1c41078-400a-4384-b560-00125e7f1260
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 16 Dec 2024 10:47:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 16 Dec 2024 10:47:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <cong.wang@bytedance.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>,
	<xiyou.wangcong@gmail.com>
Subject: Re: [Patch net v2] rtnetlink: fix double call of rtnl_link_get_net_ifla()
Date: Mon, 16 Dec 2024 19:47:24 +0900
Message-ID: <20241216104724.49813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CABAhCORBVVU8P6AHcEkENMj+gD2d3ce9t=A_o48E0yOQp8_wUQ@mail.gmail.com>
References: <CABAhCORBVVU8P6AHcEkENMj+gD2d3ce9t=A_o48E0yOQp8_wUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Mon, 16 Dec 2024 18:24:39 +0800
> > @@ -3812,40 +3818,33 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
> >         goto out;
> >  }
> >
> > -static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
> > -                            const struct rtnl_link_ops *ops,
> > -                            struct nlattr *data[],
> > -                            struct netlink_ext_ack *extack)
> > +static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
> > +                                    struct nlattr *data[],
> > +                                    struct netlink_ext_ack *extack)
> >  {
> >         struct nlattr *tb[IFLA_MAX + 1];
> > -       struct net *net;
> >         int err;
> >
> >         if (!data || !data[ops->peer_type])
> > -               return 0;
> > +               return NULL;
> 
> I was adding some tests about the link netns stuff, and found
> a behavior change. Prior to this patch, veth, vxcan and netkit
> were trying the outer tb if peer info was not set. But returning
> NULL here skips this part of logic. Say if we have:
> 
>     ip link add netns ns1 foo type veth
> 
> The peer link is changed from ns1 to current netns.

Good catch, we need the following diff.

---8<---
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ebcfc2debf1a..d9f959c619d9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3819,6 +3819,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 }
 
 static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
+				     struct nlattr *tbp[],
 				     struct nlattr *data[],
 				     struct netlink_ext_ack *extack)
 {
@@ -3826,7 +3827,7 @@ static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
 	int err;
 
 	if (!data || !data[ops->peer_type])
-		return NULL;
+		return rtnl_link_get_net_ifla(tbp);
 
 	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
 	if (err < 0)
@@ -3971,7 +3972,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			peer_net = rtnl_get_peer_net(ops, data, extack);
+			peer_net = rtnl_get_peer_net(ops, tb, data, extack);
 			if (IS_ERR(peer_net)) {
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
---8<---

