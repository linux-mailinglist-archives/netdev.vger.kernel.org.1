Return-Path: <netdev+bounces-147308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D729D908F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 03:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25548B26E58
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0743D96A;
	Tue, 26 Nov 2024 02:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9823EA69
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589917; cv=none; b=ALp3MGq/7/wcKiTIqd3LF88VyxXNM4asnHCXE20q0cNxB54fiCZ03y1mdztzkyjaNW6YyDCoFw6NTIcw3AVg8DGcWpIzRwe5G+QJcM18w4kHDZlD4pqqbLz0XELrsSEOrY1wgkJGHALHfgBL0Xbgpf//LwQLKgslAwGqpS/dLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589917; c=relaxed/simple;
	bh=GKqA2oNgjXpavWVTcpyAmDPiGN024i9162ozzInY++s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5YS6P6VGBsgO9rRSwnbLQjcsmeRcGdDGKs4towZS4C16pKlCfTo+Vg/0LMlm5Z5RN/OO2mkwB1goypCPTFCb89i6TW8vkQMPrOcRx7GhhxjWU+VwasjswkXZIwvHnAi5mRJ5BraC9u6LrxYy2fVvv9jzlg430xDUjuwNmsKqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xy6j16qHWz1yr3M;
	Tue, 26 Nov 2024 10:58:45 +0800 (CST)
Received: from kwepemd100023.china.huawei.com (unknown [7.221.188.33])
	by mail.maildlp.com (Postfix) with ESMTPS id E53C91402DA;
	Tue, 26 Nov 2024 10:58:31 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemd100023.china.huawei.com (7.221.188.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Nov 2024 10:58:30 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <herbert@gondor.apana.org.au>,
	<steffen.klassert@secunet.com>
CC: <netdev@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net v2] net: Fix icmp host relookup triggering ip_rt_bug
Date: Tue, 26 Nov 2024 10:59:43 +0800
Message-ID: <20241126025943.1223254-1-dongchenchen2@huawei.com>
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

For ICMP err triggered by locally generated packets, dst->dev of output
route is loopback. Generally, xfrm relookup verification is not required
on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).

Skip icmp relookup for locally generated packets to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
v2: Skip icmp relookup to fix bug
---
 net/ipv4/icmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4f088fa1c2f2..0d51f8434187 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -515,7 +515,10 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 			  flowi4_to_flowi(fl4), NULL, 0);
 	rt = dst_rtable(dst);
 	if (!IS_ERR(dst)) {
-		if (rt != rt2)
+		unsigned int addr_type = inet_addr_type_dev_table(net,
+							route_lookup_dev, fl4->daddr);
+
+		if (rt != rt2 || addr_type == RTN_LOCAL)
 			return rt;
 	} else if (PTR_ERR(dst) == -EPERM) {
 		rt = NULL;
-- 
2.25.1


