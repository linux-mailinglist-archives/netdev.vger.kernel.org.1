Return-Path: <netdev+bounces-147542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DD9DA156
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AFF168B8E
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D174374F1;
	Wed, 27 Nov 2024 04:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14462282FE
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680464; cv=none; b=sXqqFwhtVUXKC2V7S7uZESIsGUWKt48T94qnGhA5680YL8tShLx0OAGer6gXHAC1hB2dZtBTfYVt4oOvy++EE9oiCaJQJBRynJy9+dFClGuhseH4zeDYl6RDoivepxTwtVzKOk6r1JgLkACyzdh73wEFJm9RYsLrCfYK3mQrrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680464; c=relaxed/simple;
	bh=0/w7rwNn/2fstFBKW3oBN7x1wTpjkGarDO/a/S1sbpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XnJVZbDmUkuG5bBezaX7sV+gAQ3kMswamCz9fof9ZsOea+xX3wilSlIgdInhn1XfIGab/glf6uraoW6Cw/Jt4RrZjfVYnyYJB9bYVeEQobXGz/hCiENrLSMknBVLHGHNyG0oUs3sbq9/5r2dM95PlydO9HmUxLaUbfyDiBisj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xym7b4dHGz1k0bG;
	Wed, 27 Nov 2024 12:05:31 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BDE91A016C;
	Wed, 27 Nov 2024 12:07:39 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Nov 2024 12:07:37 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <herbert@gondor.apana.org.au>,
	<steffen.klassert@secunet.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net v3] net: Fix icmp host relookup triggering ip_rt_bug
Date: Wed, 27 Nov 2024 12:08:50 +0800
Message-ID: <20241127040850.1513135-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

For ICMP err triggered by locally generated packets, dst->dev of output
route is loopback. Generally, xfrm relookup verification is not required
on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).

Skip icmp relookup for locally generated packets to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
v3: avoid the expensive call to  inet_addr_type_dev_table()
and addr_type variable suggested by Eric
v2: Skip icmp relookup to fix bug
---
 net/ipv4/icmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4f088fa1c2f2..963a89ae9c26 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -517,6 +517,9 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 	if (!IS_ERR(dst)) {
 		if (rt != rt2)
 			return rt;
+		if (inet_addr_type_dev_table(net, route_lookup_dev,
+					     fl4->daddr) == RTN_LOCAL)
+			return rt;
 	} else if (PTR_ERR(dst) == -EPERM) {
 		rt = NULL;
 	} else {
-- 
2.25.1


