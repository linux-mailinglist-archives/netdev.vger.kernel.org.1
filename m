Return-Path: <netdev+bounces-177881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E465A7285B
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 02:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0810117BA8D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733231A8F98;
	Thu, 27 Mar 2025 01:48:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFED45C14;
	Thu, 27 Mar 2025 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040090; cv=none; b=d3wKD7EJjg8n7Obhg1LOGYUqI92QKAQkYKH+ua4HeVDGF/na7J65/TCZ14MN7q5hR4lvxqxVg6HYTIQxNCMWAxb6+eExgEGaecE69vfTANQUpiEVBO7undZz6TRJhO9jb4Mfcx5hvcRpmcbPZ0b6wvSm4HDpEePiWGe9CSk6JIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040090; c=relaxed/simple;
	bh=YExHr+2mn/5PLGawiihdqqA9Qe1EXHQUBAkBpbg9IW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZoKrJp/3Zn36wcQ+BcVi3UlpaMD8CYQWN1z2Qpfg1mlO8aLOp6arpi0OtXB3fznsdM1a+nrdPb/Hmk4XoTxV+f7LUMlf2CVkLT8IUvQXLIuypqZwMDEBwc5RUb5wGhiZz81zf4Xb7SYqfF5xqbk7Qx/cRStlSqaVXjTz83iuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZNRK06Z0tzvX0F;
	Thu, 27 Mar 2025 09:44:04 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id F17111800B4;
	Thu, 27 Mar 2025 09:48:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 27 Mar
 2025 09:48:00 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@amazon.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed needed_headroom
Date: Thu, 27 Mar 2025 09:58:27 +0800
Message-ID: <20250327015827.2729554-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
  CPU: 0 UID: 0 PID: 24133 Comm: test Tainted: G W 6.14.0-rc7-00067-g76b6905c11fd-dirty #1
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
  RIP: 0010:skb_panic+0x156/0x1d0
  Call Trace:
   <TASK>
   skb_push+0xc8/0xe0
   fou_build_udp+0x31/0x3a0
   gue_build_header+0xf7/0x150
   ip_tunnel_xmit+0x684/0x3660
   sit_tunnel_xmit__.isra.0+0xeb/0x150
   sit_tunnel_xmit+0x2e3/0x2930
   dev_hard_start_xmit+0x1a6/0x7b0
   __dev_queue_xmit+0x2fa9/0x4120
   neigh_connected_output+0x39e/0x590
   ip_finish_output2+0x7bb/0x1f00
   __ip_finish_output+0x442/0x940
   ip_finish_output+0x31/0x380
   ip_mc_output+0x1c4/0x6a0
   ip_send_skb+0x339/0x570
   udp_send_skb+0x905/0x1540
   udp_sendmsg+0x17c8/0x28f0
   udpv6_sendmsg+0x17f1/0x2c30
   inet6_sendmsg+0x105/0x140
   ____sys_sendmsg+0x801/0xc70
   ___sys_sendmsg+0x110/0x1b0
   __sys_sendmmsg+0x1f2/0x410
   __x64_sys_sendmmsg+0x99/0x100
   do_syscall_64+0x6e/0x1c0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ---[ end trace 0000000000000000 ]---

Fix this by add check for needed_headroom in ipip6_tunnel_bind_dev().

Reported-by: syzbot+4c63f36709a642f801c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c63f36709a642f801c5
Fixes: c88f8d5cd95f ("sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
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


