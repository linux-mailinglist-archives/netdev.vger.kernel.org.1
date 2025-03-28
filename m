Return-Path: <netdev+bounces-178049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03ABA74235
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7417A733
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690091A8F68;
	Fri, 28 Mar 2025 02:07:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EB22094;
	Fri, 28 Mar 2025 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743127666; cv=none; b=p9v1kFY1fhKZc0nMglQL5otwg8LyrqRakp82IPd6Nwob/4mmOu+Vw5iQkbSdqKHawC2jWMM0umThR4OfPqTd79YxnT0Q4ChcfmOCX3zTSWcfEkjY5QUdhoI2ZwkbMzakS8jf2FIK3tpmSdxlgxzfRNSPWHhWy9T7sSCRGB3lcL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743127666; c=relaxed/simple;
	bh=Z5pYoDNiDVm7XMpdfKhQtMR4KZUE7CrZAXeSfGmyJHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=StpRBSdkJcx6mHdU2p+NKX5jxdt9bTwq05IVDxDtlGW5lLKnGHgg8Mze6bxR36ZIPW1deV0SoYq51754WqiellyuLc46jCWoBkZ5M6GnpgqTWlYIiuuziWPHP1xZNPcikUER3eu9A65DZ1rgyBD32ZOYSpAottLWF8YJYPiUFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZP3jX2FbQzTgpT;
	Fri, 28 Mar 2025 10:04:00 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 01F321400D1;
	Fri, 28 Mar 2025 10:07:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Mar
 2025 10:07:38 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@amazon.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] ipv6: sit: fix skb_under_panic with overflowed needed_headroom
Date: Fri, 28 Mar 2025 10:18:03 +0800
Message-ID: <20250328021803.16379-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200005.china.huawei.com (7.202.181.32)

When create ipip6 tunnel, if tunnel->parms.link is assigned to the previous
created tunnel device, the dev->needed_headroom will increase based on the
previous one.

If the number of tunnel device is sufficient, the needed_headroom can be
overflowed. The overflow happens like this:

  ipip6_newlink
    ipip6_tunnel_create
      register_netdevice
        ipip6_tunnel_init
          ipip6_tunnel_bind_dev
            t_hlen = tunnel->hlen + sizeof(struct iphdr); // 40
            hlen = tdev->hard_header_len + tdev->needed_headroom; // 65496
            dev->needed_headroom = t_hlen + hlen; // 65536 -> 0

The value of LL_RESERVED_SPACE(rt->dst.dev) may be HH_DATA_MOD, that leads
to a small skb allocated in __ip_append_data(), which triggers a
skb_under_panic:

 ------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:209!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 CPU: 0 UID: 0 PID: 23587 Comm: test Tainted: G        W          6.14.0-00624-g2f2d52945852-dirty #15
 Tainted: [W]=WARN
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 RIP: 0010:skb_panic (net/core/skbuff.c:209 (discriminator 4))
 Call Trace:
  <TASK>
  skb_push (net/core/skbuff.c:2544)
  fou_build_udp (net/ipv4/fou_core.c:1041)
  gue_build_header (net/ipv4/fou_core.c:1085)
  ip_tunnel_xmit (net/ipv4/ip_tunnel.c:780)
  sit_tunnel_xmit__.isra.0 (net/ipv6/sit.c:1065)
  sit_tunnel_xmit (net/ipv6/sit.c:1076)
  dev_hard_start_xmit (net/core/dev.c:3816)
  __dev_queue_xmit (net/core/dev.c:4653)
  neigh_connected_output (net/core/neighbour.c:1543)
  ip_finish_output2 (net/ipv4/ip_output.c:236)
  __ip_finish_output (net/ipv4/ip_output.c:314)
  ip_finish_output (net/ipv4/ip_output.c:324)
  ip_mc_output (net/ipv4/ip_output.c:421)
  ip_send_skb (net/ipv4/ip_output.c:1502)
  udp_send_skb (net/ipv4/udp.c:1197)
  udp_sendmsg (net/ipv4/udp.c:1484)
  udpv6_sendmsg (net/ipv6/udp.c:1545)
  inet6_sendmsg (net/ipv6/af_inet6.c:659)
  ____sys_sendmsg (net/socket.c:2573)
  ___sys_sendmsg (net/socket.c:2629)
  __sys_sendmmsg (net/socket.c:2719)
  __x64_sys_sendmmsg (net/socket.c:2740)
  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>
 ---[ end trace 0000000000000000 ]---

Fix this by add check for needed_headroom in ipip6_tunnel_bind_dev().

Reported-by: syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c63f36709a642f801c5
Fixes: c88f8d5cd95f ("sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
v2: update stack trace with symbols.
---
 net/ipv6/sit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 39bd8951bfca..1662b735c5e3 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1095,7 +1095,7 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 }
 
-static void ipip6_tunnel_bind_dev(struct net_device *dev)
+static int ipip6_tunnel_bind_dev(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
@@ -1134,7 +1134,12 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		WRITE_ONCE(dev->mtu, mtu);
 		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
+
+	if (t_hlen + hlen > U16_MAX)
+		return -EOVERFLOW;
+
 	dev->needed_headroom = t_hlen + hlen;
+	return 0;
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t,
@@ -1452,7 +1457,9 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
-	ipip6_tunnel_bind_dev(dev);
+	err = ipip6_tunnel_bind_dev(dev);
+	if (err)
+		return err;
 
 	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
 	if (err)
-- 
2.34.1


