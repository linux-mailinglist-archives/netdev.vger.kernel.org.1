Return-Path: <netdev+bounces-136731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C59A2C3B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0281C20ACA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AC9185952;
	Thu, 17 Oct 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bk1TgMdC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377518133F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190027; cv=none; b=VW9HZ8um9SrvBBin5u5CKGASLrqbYcXXkZ3s3oVO7cQs4VsfQ4gO/vWug2HXPxj0ZP5THa2VUh7cPPVR1yJzcvCi8fGqRcwDBWCxUjxmnZLTl7H7+5VbbaNrsN0Ydo45FiUcqAy3Dj4SwFllkxxzgWpXT08+QTFRtLyLUnTYQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190027; c=relaxed/simple;
	bh=qKzLgKsv8lB6k+vG8A6MVLdbGSJfipUTj/px3lMMzRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1bbMt2G8hccOz2kXYwuOzhGeywFnNj7aStNnSdgzxCxx541hBqXKFBTDwSgk5V+Ah3mV4y+wJA/wlIoRsNX14ejfEziSWxaw0RBVkna3wOJ7aOQAmIoi2bLRQopx7icwoDH8hy6dRQjLCetk2WO1NfwxWaJJzDa5xiIdGmGNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bk1TgMdC; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729190026; x=1760726026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8CzjbES0r9em8jCjcu0BGaiXTPxChmEB7C+57S1uQo=;
  b=Bk1TgMdC1V0Oj+6XBjElW7VamI9EgBMrWskD9FfMmitbTkVpQ1sYYi3P
   hDkwgXcx57tonSVYOmCqyPkUbWlhLI2mJlfgviNi/seiOZSN6oySKoRIQ
   bI5Pqy+jwsMlAbG8jHZASYPMIiWt2I3zSi4kpsAuaHeIn2+mY7uRNG+Qh
   E=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="343907119"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:33:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:52507]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 59f63642-859e-4c86-bd6e-4e753f02fff1; Thu, 17 Oct 2024 18:33:44 +0000 (UTC)
X-Farcaster-Flow-ID: 59f63642-859e-4c86-bd6e-4e753f02fff1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:33:42 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:33:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/9] phonet: Pass ifindex to fill_route().
Date: Thu, 17 Oct 2024 11:31:37 -0700
Message-ID: <20241017183140.43028-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241017183140.43028-1-kuniyu@amazon.com>
References: <20241017183140.43028-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will convert route_doit() to RCU.

route_doit() will call rtm_phonet_notify() outside of RCU due
to GFP_KERNEL, so dev will not be available in fill_route().

Let's pass ifindex directly to fill_route().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/phonet/pn_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 14928fa04675..c9a4215ec560 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -170,8 +170,8 @@ static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 /* Routes handling */
 
-static int fill_route(struct sk_buff *skb, struct net_device *dev, u8 dst,
-			u32 portid, u32 seq, int event)
+static int fill_route(struct sk_buff *skb, u32 ifindex, u8 dst,
+		      u32 portid, u32 seq, int event)
 {
 	struct rtmsg *rtm;
 	struct nlmsghdr *nlh;
@@ -190,8 +190,7 @@ static int fill_route(struct sk_buff *skb, struct net_device *dev, u8 dst,
 	rtm->rtm_scope = RT_SCOPE_UNIVERSE;
 	rtm->rtm_type = RTN_UNICAST;
 	rtm->rtm_flags = 0;
-	if (nla_put_u8(skb, RTA_DST, dst) ||
-	    nla_put_u32(skb, RTA_OIF, READ_ONCE(dev->ifindex)))
+	if (nla_put_u8(skb, RTA_DST, dst) || nla_put_u32(skb, RTA_OIF, ifindex))
 		goto nla_put_failure;
 	nlmsg_end(skb, nlh);
 	return 0;
@@ -210,7 +209,8 @@ void rtm_phonet_notify(int event, struct net_device *dev, u8 dst)
 			nla_total_size(1) + nla_total_size(4), GFP_KERNEL);
 	if (skb == NULL)
 		goto errout;
-	err = fill_route(skb, dev, dst, 0, 0, event);
+
+	err = fill_route(skb, dev->ifindex, dst, 0, 0, event);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
@@ -286,7 +286,7 @@ static int route_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 		if (!dev)
 			continue;
 
-		err = fill_route(skb, dev, addr << 2,
+		err = fill_route(skb, READ_ONCE(dev->ifindex), addr << 2,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq, RTM_NEWROUTE);
 		if (err < 0)
-- 
2.39.5 (Apple Git-154)


