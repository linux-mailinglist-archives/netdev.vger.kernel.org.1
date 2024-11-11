Return-Path: <netdev+bounces-143738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16C9C3E8E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C671F21D6B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF8199938;
	Mon, 11 Nov 2024 12:39:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A417158DC8
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328767; cv=none; b=dDAgOYxFGahCqIQsIV8Qiob0lQ2jxard4kZPCjX921roZTZIPN878JxuWHZitNrJOqHa7JloPZhBYPMnPPPMFhFATYnQE9ZAZibC0XtqKEd7SEMj9N0tWgMOaW7ySA//MeBvLaUbIkw3kfBIns1NG6NfHsv76/Fl6Vy8RQtrTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328767; c=relaxed/simple;
	bh=1xGJiMx1/GNYO2oXy0LFFF5afr80INkTL/A7DZQL0II=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egAFYsry5BjeACIVZhxUQ7BjWrN6TrtEf5IkuZCJnETlr1xkysLH1chjPZfKn22YK6nHX/LilcxQRV9dvU3OQYwlPwHnzjPlReEVFJzRbkXmV+HXjRLJ71y01tEuRd60zXgWIZJq/oa15/cZxJ30VdsPoQbK2IE6wkvZVoWOed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xn8Fh2dVTzlXGn;
	Mon, 11 Nov 2024 20:37:28 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 73E6C140257;
	Mon, 11 Nov 2024 20:39:21 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 20:39:20 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net] net: Fix icmp host relookup triggering ip_rt_bug
Date: Mon, 11 Nov 2024 20:39:15 +0800
Message-ID: <20241111123915.3879488-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100023.china.huawei.com (7.221.188.33)

arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:

WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:ip_rt_bug+0x14/0x20
Call Trace:
 <IRQ>
 ip_send_skb+0x14/0x40
 __icmp_send+0x42d/0x6a0
 ipv4_link_failure+0xe2/0x1d0
 arp_error_report+0x3c/0x50
 neigh_invalidate+0x8d/0x100
 neigh_timer_handler+0x2e1/0x330
 call_timer_fn+0x21/0x120
 __run_timer_base.part.0+0x1c9/0x270
 run_timer_softirq+0x4c/0x80
 handle_softirqs+0xac/0x280
 irq_exit_rcu+0x62/0x80
 sysvec_apic_timer_interrupt+0x77/0x90

The script below reproduces this scenario:
ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
	dir out priority 0 ptype main flag localok icmp
ip l a veth1 type veth
ip a a 192.168.141.111/24 dev veth0
ip l s veth0 up
ping 192.168.141.155 -c 1

icmp_route_lookup() create input routes for locally generated packets
while xfrm relookup ICMP traffic.Then it will set input route
(dst->out = ip_rt_bug) to skb for DESTUNREACH.

Similar to commit ed6e4ef836d4("netfilter: Fix ip_route_me_harder
triggering ip_rt_bug"), avoid creating input routes with
icmp_route_lookup() to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/ipv4/icmp.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e1384e7331d8..11ef4eb5b659 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -490,6 +490,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	struct dst_entry *dst, *dst2;
 	struct rtable *rt, *rt2;
 	struct flowi4 fl4_dec;
+	unsigned int addr_type;
 	int err;
 
 	memset(fl4, 0, sizeof(*fl4));
@@ -528,31 +529,15 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	if (err)
 		goto relookup_failed;
 
-	if (inet_addr_type_dev_table(net, route_lookup_dev,
-				     fl4_dec.saddr) == RTN_LOCAL) {
-		rt2 = __ip_route_output_key(net, &fl4_dec);
-		if (IS_ERR(rt2))
-			err = PTR_ERR(rt2);
-	} else {
-		struct flowi4 fl4_2 = {};
-		unsigned long orefdst;
-
-		fl4_2.daddr = fl4_dec.saddr;
-		rt2 = ip_route_output_key(net, &fl4_2);
-		if (IS_ERR(rt2)) {
-			err = PTR_ERR(rt2);
-			goto relookup_failed;
-		}
-		/* Ugh! */
-		orefdst = skb_in->_skb_refdst; /* save old refdst */
-		skb_dst_set(skb_in, NULL);
-		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     tos, rt2->dst.dev);
-
-		dst_release(&rt2->dst);
-		rt2 = skb_rtable(skb_in);
-		skb_in->_skb_refdst = orefdst; /* restore old refdst */
-	}
+	addr_type = inet_addr_type_dev_table(net, route_lookup_dev, fl4_dec.saddr);
+	if (addr_type == RTN_LOCAL || addr_type == RTN_UNICAST)
+		fl4_dec.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+	else
+		fl4_dec.saddr = 0;
+
+	rt2 = __ip_route_output_key(net, &fl4_dec);
+	if (IS_ERR(rt2))
+		err = PTR_ERR(rt2);
 
 	if (err)
 		goto relookup_failed;
-- 
2.25.1


