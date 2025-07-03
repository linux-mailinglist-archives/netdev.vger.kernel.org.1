Return-Path: <netdev+bounces-203678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD73AF6C19
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15DD7AFAFF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A32BD033;
	Thu,  3 Jul 2025 07:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689C29B783;
	Thu,  3 Jul 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529269; cv=none; b=RswG9GqyfjgF6VQnAI3tfVfcKaq6RD99l2n+5ILJnjYyvKaTG4URkem3wRx0Scvmrdmf4OxtQ+PJlHG3z3wNZHuXUi91pOBkZ29/M2cddtdNRCzlkZwC002pabmS9urWAVxVUdyUUbllJrikkkzkOTN+i43YuXheUWbp6iCKrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529269; c=relaxed/simple;
	bh=lt+M87RByfReAxvdmnUfBWNo3o235T3tR6JtwxzdkGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz6r4CdWLgrtMRsjWW3rBq9zqqVQdIGmgJ0mVkpPXOcB8HvhXQ7n8W/jXby+nmeOhk//zTqlQzR8KnJh/KLGf9z1bDaoMA/9pBohYOkSWu8U9OZJ0WbwKIZFJZle7PzUYq8zu3kxKFkdBy6K5DE3pCxVb1GeGxPmllIOxOzlo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXpr70gs8z1R8fv;
	Thu,  3 Jul 2025 15:51:51 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8903E1A016C;
	Thu,  3 Jul 2025 15:54:22 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 15:54:22 +0800
Received: from localhost.localdomain (10.175.104.82) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 15:54:21 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <jiri@resnulli.us>,
	<oscmaes92@gmail.com>, <linux@treblig.org>, <pedro.netdev@dondevamos.com>,
	<idosch@idosch.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
Subject: [PATCH net v2 1/2] net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime
Date: Thu, 3 Jul 2025 15:57:01 +0800
Message-ID: <20250703075702.1063149-2-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703075702.1063149-1-dongchenchen2@huawei.com>
References: <20250703075702.1063149-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200002.china.huawei.com (7.202.195.90)

8021q(vlan_device_event) will add VLAN 0 when enabling the device, and
remove it on disabling it if NETIF_F_HW_VLAN_CTAG_FILTER set.
However, if changing filter feature during netdev runtime,
null-ptr-unref[1] or bug_on[2] will be triggered by unregister_vlan_dev()
for refcount imbalance.

[1]
BUG: KASAN: null-ptr-deref in unregister_vlan_dev (net/8021q/vlan.h:90 net/8021q/vlan.c:110)
Write of size 8 at addr 0000000000000000 by task ip/382
CPU: 2 UID: 0 PID: 382 Comm: ip Not tainted 6.16.0-rc3 #60 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:123)
kasan_report (mm/kasan/report.c:636)
unregister_vlan_dev (net/8021q/vlan.h:90 net/8021q/vlan.c:110)
rtnl_dellink (net/core/rtnetlink.c:3511 net/core/rtnetlink.c:3553)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6945)
netlink_rcv_skb (net/netlink/af_netlink.c:2535)
netlink_unicast (net/netlink/af_netlink.c:1314 net/netlink/af_netlink.c:1339)
netlink_sendmsg (net/netlink/af_netlink.c:1883)
____sys_sendmsg (net/socket.c:712 net/socket.c:727 net/socket.c:2566)

[2]
kernel BUG at net/8021q/vlan.c:99!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 382 Comm: ip Not tainted 6.16.0-rc3 #61 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:unregister_vlan_dev (net/8021q/vlan.c:99 (discriminator 1))
RSP: 0018:ffff88810badf310 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88810da84000 RCX: ffffffffb47ceb9a
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88810e8b43c8
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff6cefe80
R10: ffffffffb677f407 R11: ffff88810badf3c0 R12: ffff88810e8b4000
R13: 0000000000000000 R14: ffff88810642a5c0 R15: 000000000000017e
FS:  00007f1ff68c20c0(0000) GS:ffff888163a24000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ff5dad240 CR3: 0000000107e56000 CR4: 00000000000006f0
Call Trace:
 <TASK>
rtnl_dellink (net/core/rtnetlink.c:3511 net/core/rtnetlink.c:3553)
rtnetlink_rcv_msg (net/core/rtnetlink.c:6945)
netlink_rcv_skb (net/netlink/af_netlink.c:2535)
netlink_unicast (net/netlink/af_netlink.c:1314 net/netlink/af_netlink.c:1339)
netlink_sendmsg (net/netlink/af_netlink.c:1883)
____sys_sendmsg (net/socket.c:712 net/socket.c:727 net/socket.c:2566)
___sys_sendmsg (net/socket.c:2622)
__sys_sendmsg (net/socket.c:2652)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)

Root cause is as below:
step1: add vlan0 for real_dev, such as bond, team.
register_vlan_dev
    vlan_vid_add(real_dev,htons(ETH_P_8021Q),0) //refcnt=1
step2: disable vlan filter feature and enable real_dev
step3: change filter from 0 to 1
vlan_device_event
    vlan_filter_push_vids
    	ndo_vlan_rx_add_vid //No refcnt added to real_dev vlan0
step4: real_dev down
vlan_device_event
    vlan_vid_del(dev, htons(ETH_P_8021Q), 0); //refcnt=0
        vlan_info_rcu_free //free vlan0
step5: real_dev up
vlan_device_event
    vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
        vlan_info_alloc //alloc new empty vid0. refcnt=1
step6: delete vlan0
unregister_vlan_dev
    BUG_ON(!vlan_info); //will trigger it if step5 was not executed
    vlan_group_set_device
        array = vg->vlan_devices_arrays
	//null-ptr-ref will be triggered after step5

E.g. the following sequence can reproduce null-ptr-ref

$ ip link add bond0 type bond mode 0
$ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
$ ethtool -K bond0 rx-vlan-filter off
$ ifconfig bond0 up
$ ethtool -K bond0 rx-vlan-filter on
$ ifconfig bond0 down
$ ifconfig bond0 up
$ ip link del vlan0

Add the auto_vid0 flag to track the refcount of vlan0, and use this
flag to determine whether to dec refcount while disabling real_dev.

Fixes: ad1afb003939 ("vlan_dev: VLAN 0 should be treated as "no vlan tag" (802.1p packet)")
Reported-by: syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a8b046e462915c65b10b
Co-developed-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/8021q/vlan.c | 42 +++++++++++++++++++++++++++++++++---------
 net/8021q/vlan.h |  1 +
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 06908e37c3d9..9a6df8c1daf9 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -357,6 +357,35 @@ static int __vlan_device_event(struct net_device *dev, unsigned long event)
 	return err;
 }
 
+static void vlan_vid0_add(struct net_device *dev)
+{
+	struct vlan_info *vlan_info;
+	int err;
+
+	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return;
+
+	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);
+
+	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
+	if (err)
+		return;
+
+	vlan_info = rtnl_dereference(dev->vlan_info);
+	vlan_info->auto_vid0 = true;
+}
+
+static void vlan_vid0_del(struct net_device *dev)
+{
+	struct vlan_info *vlan_info = rtnl_dereference(dev->vlan_info);
+
+	if (!vlan_info || !vlan_info->auto_vid0)
+		return;
+
+	vlan_info->auto_vid0 = false;
+	vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+}
+
 static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			     void *ptr)
 {
@@ -378,15 +407,10 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			return notifier_from_errno(err);
 	}
 
-	if ((event == NETDEV_UP) &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
-		pr_info("adding VLAN 0 to HW filter on device %s\n",
-			dev->name);
-		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
-	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
-		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+	if (event == NETDEV_UP)
+		vlan_vid0_add(dev);
+	else if (event == NETDEV_DOWN)
+		vlan_vid0_del(dev);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
 	if (!vlan_info)
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..c7ffe591d593 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -33,6 +33,7 @@ struct vlan_info {
 	struct vlan_group	grp;
 	struct list_head	vid_list;
 	unsigned int		nr_vids;
+	bool			auto_vid0;
 	struct rcu_head		rcu;
 };
 
-- 
2.25.1


