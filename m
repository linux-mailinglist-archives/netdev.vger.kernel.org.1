Return-Path: <netdev+bounces-251051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC94D3A69D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA6233002B8A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE982EAB6B;
	Mon, 19 Jan 2026 11:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069C18A921
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821597; cv=none; b=IXJwXKxU0wvH8awPLNm93imp4BFHHPu5rPy85UXIt2mhyFGnXfPL+vOhi67OPg1/leSch/a2kMr25/6cPLoJHM+CtHkVIeHpjk0skrTRyfg47fOIJ2+YYXM0lSKNkLBiVHs+HuE47gRowN6K8DkIFODT4+2lWPrS/leoJQzZSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821597; c=relaxed/simple;
	bh=/ltd1+c5YWGyNpS6QpyjLfhudiWIpJGJB/Bwx90g930=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hS5aWf5mqafv0IcOdagBuxMO+cRv3nkCePLLZ1wpJnVpbZjcR5xq9Ajhux5UOY4Z2zY4zhKz2o9PVorve0JKvWYmGtqmErrFXHVLUXZ75oyD1Mg3g0N3A4vYzwlKd9q+m1vhUSLIP+LjqmaahIuBFuXiPVCZ0YD2T4Qip5wK9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60JBJlp0099231;
	Mon, 19 Jan 2026 20:19:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60JBJlag099225
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Jan 2026 20:19:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
Date: Mon, 19 Jan 2026 20:19:44 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Aviad Yehezkel <aviadye@mellnaox.com>, Aviv Heller <avivh@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, Guy Shapiro <guysh@mellanox.com>,
        Ilan Tayari <ilant@mellanox.com>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Yossi Kuperman <yossiku@mellanox.com>
Cc: Network Development <netdev@vger.kernel.org>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting that "struct xfrm_state" refcount is leaking.

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

Currently, the NETDEV_UNREGISTER case in xfrm_dev_event() is no-op
when (dev->features & NETIF_F_HW_ESP) == 0. Since xfrm_dev_state_add()
and xfrm_dev_policy_add() take a reference to "struct net_device", the
corresponding NETDEV_UNREGISTER handler must release that reference.
Flush dev state and dev policy, without checking whether to flush, when
NETDEV_UNREGISTER event fires.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
WARNING: This patch is just an analogy case of net/can/j1939 module.
This patch is completely untested and might not solve this problem, for
reproducer is not available for this problem. I appreciate if someone
can write a test code for this problem.

 drivers/net/bonding/bond_main.c |  2 +-
 include/net/xfrm.h              |  5 ++---
 net/xfrm/xfrm_device.c          | 15 ++++++++++++---
 net/xfrm/xfrm_policy.c          |  4 ++--
 net/xfrm/xfrm_state.c           |  4 ++--
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3d56339a8a10..bbb6bc4b30cd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3824,7 +3824,7 @@ static int bond_master_netdev_event(unsigned long event,
 	case NETDEV_UNREGISTER:
 		bond_remove_proc_entry(event_bond);
 #ifdef CONFIG_XFRM_OFFLOAD
-		xfrm_dev_state_flush(dev_net(bond_dev), bond_dev, true);
+		xfrm_dev_state_flush(dev_net(bond_dev), bond_dev, true, false);
 #endif /* CONFIG_XFRM_OFFLOAD */
 		break;
 	case NETDEV_REGISTER:
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 0a14daaa5dd4..b19e7b1fbda2 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1765,9 +1765,8 @@ struct xfrmk_spdinfo {
 struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 int xfrm_state_delete(struct xfrm_state *x);
 int xfrm_state_flush(struct net *net, u8 proto, bool task_valid);
-int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
-int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
-			  bool task_valid);
+int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid, bool force);
+int xfrm_dev_policy_flush(struct net *net, struct net_device *dev, bool task_valid, bool force);
 void xfrm_sad_getinfo(struct net *net, struct xfrmk_sadinfo *si);
 void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..ec094aeb1604 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -537,13 +537,21 @@ static int xfrm_api_check(struct net_device *dev)
 static int xfrm_dev_down(struct net_device *dev)
 {
 	if (dev->features & NETIF_F_HW_ESP) {
-		xfrm_dev_state_flush(dev_net(dev), dev, true);
-		xfrm_dev_policy_flush(dev_net(dev), dev, true);
+		xfrm_dev_state_flush(dev_net(dev), dev, true, false);
+		xfrm_dev_policy_flush(dev_net(dev), dev, true, false);
 	}
 
 	return NOTIFY_DONE;
 }
 
+static int xfrm_dev_unregister(struct net_device *dev)
+{
+	xfrm_dev_state_flush(dev_net(dev), dev, true, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true, true);
+
+	return NOTIFY_DONE;
+}
+
 static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
@@ -556,8 +564,9 @@ static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void
 		return xfrm_api_check(dev);
 
 	case NETDEV_DOWN:
-	case NETDEV_UNREGISTER:
 		return xfrm_dev_down(dev);
+	case NETDEV_UNREGISTER:
+		return xfrm_dev_unregister(dev);
 	}
 	return NOTIFY_DONE;
 }
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..a451dff25c52 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1855,14 +1855,14 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 EXPORT_SYMBOL(xfrm_policy_flush);
 
 int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
-			  bool task_valid)
+			  bool task_valid, bool forced)
 {
 	int dir, err = 0, cnt = 0;
 	struct xfrm_policy *pol;
 
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 
-	err = xfrm_dev_policy_flush_secctx_check(net, dev, task_valid);
+	err = forced ? 0 : xfrm_dev_policy_flush_secctx_check(net, dev, task_valid);
 	if (err)
 		goto out;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 98b362d51836..29a124291331 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -958,7 +958,7 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 }
 EXPORT_SYMBOL(xfrm_state_flush);
 
-int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid)
+int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid, bool forced)
 {
 	struct xfrm_state *x;
 	struct hlist_node *tmp;
@@ -966,7 +966,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	int i, err = 0, cnt = 0;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	err = xfrm_dev_state_flush_secctx_check(net, dev, task_valid);
+	err = forced ? 0 : xfrm_dev_state_flush_secctx_check(net, dev, task_valid);
 	if (err)
 		goto out;
 
-- 
2.47.3



