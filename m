Return-Path: <netdev+bounces-178486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3674A77286
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 04:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF89A16B6FC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA27155335;
	Tue,  1 Apr 2025 02:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237D70820;
	Tue,  1 Apr 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743473177; cv=none; b=cp7L0bN7Cu2Ei4Ugq/OTap8nztb3i55MVRMa05xaLuSrEf20syrcs9AZUOJ3kl6EH6UHq7eKGeDEBPCn8rgbJxuazQ0UHsNedvL6Vtkx5LQTyDlktIBzdjsQEbsUJvamFfyN4Z4EUsg7Bb6oup3o9F7GS1NSGJ/+DTKnoacffag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743473177; c=relaxed/simple;
	bh=fcn3liMwudo0wN6f3rirmSwrVwuI5qiuPrbEm4PyqQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yiizq/M1mEhYSOfNEJv4GFA4QEUEu1ZMRySTOIcA2q/cZ/k681wD3nVT/mMwWlP8mQa5fTe5Y3zqUl80WCFWhVWw4KT9O7GJnWih1J8UXnYJzpm4zufp1UeSxPDMcqwafkBYnD6fTASBNtsRcPo6jnc6KMmTd0yOXfAJ7e2X2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZRWYW5tqGz1d10T;
	Tue,  1 Apr 2025 10:05:35 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B71AC14033A;
	Tue,  1 Apr 2025 10:06:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Apr
 2025 10:06:04 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@amazon.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v3] ipv6: sit: fix skb_under_panic with overflowed needed_headroom
Date: Tue, 1 Apr 2025 10:16:17 +0800
Message-ID: <20250401021617.1571464-1-wangliang74@huawei.com>
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
v3: rebase on the latest mainline.
v2: update stack trace with symbols.
---
 net/ipv6/sit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 9a0f32acb750..a88c2bb59e6b 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1096,7 +1096,7 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 }
 
-static void ipip6_tunnel_bind_dev(struct net_device *dev)
+static int ipip6_tunnel_bind_dev(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
@@ -1135,7 +1135,12 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
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
 	tunnel->dev = dev;
 	strcpy(tunnel->parms.name, dev->name);
 
-	ipip6_tunnel_bind_dev(dev);
+	err = ipip6_tunnel_bind_dev(dev);
+	if (err)
+		return err;
 
 	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
 	if (err)
-- 
2.34.1


