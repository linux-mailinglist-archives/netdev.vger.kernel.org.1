Return-Path: <netdev+bounces-174789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AADA606CD
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 02:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E083B7848
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B153AC;
	Fri, 14 Mar 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r13rmM/s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216B2E337F
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741914341; cv=none; b=uXzKx8lLZzgPaqu+mPyFK+mqqV0b6T6qOL478xzwGBfmCLQpMEPN8RtWdQQcf8+QwFAjDuPhKnMdKid55kKkNP7CDV90H83sVR4TA0mXIfgo/WDrqrTRlTaYxxN1sGrH3gwkZaipd/hq+ru3DmbzQ1VTHRAJKT7JybNoD48CFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741914341; c=relaxed/simple;
	bh=RWfHM04CRLSVakc/+Q7Ea9TmMuqzgXdCgeyNQqe4/7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E01fWdez/aEldAlC9w99YOMcc1Ot6bhiKizMgFXMpccHG8Ppii138iUv+R/tMft03hp3CMzHCrZlaH4bjLsSx9hBNPvEDnUJwd//+sv1MRq11VPCVpq0palGkCCjE9jpiALWHk5KkWKLxMdSUaSyQqGlzASde1LD/Darg0nZLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r13rmM/s; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741914340; x=1773450340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zoKpsU0KNMd6h7/WS3eBCRSJwEeXuhfFAALWP5WKWhQ=;
  b=r13rmM/s2HjrNqPMexArDaZauUjsy3TS4XYWaWd5IU8D0xCP7Vym1Tgn
   EXjsTotHWfiDTxSM8ZayCpboOnnt6LfgS34uqNNsusBjCF54KIunSAFPP
   AYOM48cJ6TaZkOBi0ilFFE6jl0CPHb1e5OM7IWbBR7UQA2G0V4dJ3IQhu
   k=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="502696723"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 01:05:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:48358]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 9bde055f-52eb-4aea-8944-756e683eff67; Fri, 14 Mar 2025 01:05:19 +0000 (UTC)
X-Farcaster-Flow-ID: 9bde055f-52eb-4aea-8944-756e683eff67
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 01:05:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.242.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 01:05:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Willem de
 Bruijn" <willemb@google.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <bridge@lists.linux.dev>,
	syzkaller <syzkaller@googlegroups.com>, yan kang <kangyan91@outlook.com>,
	"yue sun" <samsun1006219@gmail.com>
Subject: [PATCH v1 net] net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.
Date: Thu, 13 Mar 2025 17:59:55 -0700
Message-ID: <20250314010501.75798-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
br_ioctl_call(), which causes unnecessary RTNL dance and the splat
below [0] under RTNL pressure.

Let's say Thread A is trying to detach a device from a bridge and
Thread B is trying to remove the bridge.

In dev_ioctl(), Thread A bumps the bridge device's refcnt by
netdev_hold() and releases RTNL because the following br_ioctl_call()
also re-acquires RTNL.

In the race window, Thread B could acquire RTNL and try to remove
the bridge device.  Then, rtnl_unlock() by Thread B will release RTNL
and wait for netdev_put() by Thread A.

Thread A, however, must hold RTNL twice after the unlock in dev_ifsioc(),
which may take long under RTNL pressure, resulting in the splat by
Thread B.

  Thread A (SIOCBRDELIF)           Thread B (SIOCBRDELBR)
  ----------------------           ----------------------
  sock_ioctl                       sock_ioctl
  `- sock_do_ioctl                 `- br_ioctl_call
     `- dev_ioctl                     `- br_ioctl_stub
        |- rtnl_lock                     |
        |- dev_ifsioc                    '
        '  |- dev = __dev_get_by_name(...)
           |- netdev_hold(dev, ...)      .
       /   |- rtnl_unlock  ------.       |
       |   |- br_ioctl_call       `--->  |- rtnl_lock
  Race |   |  `- br_ioctl_stub           |- br_del_bridge
  Window   |     |                       |  |- dev = __dev_get_by_name(...)
       |   |     |  May take long        |  `- br_dev_delete(dev, ...)
       |   |     |  under RTNL pressure  |     `- unregister_netdevice_queue(dev, ...)
       |   |     |                |      `- rtnl_unlock
       |   |     |- rtnl_lock  <--|         `- netdev_run_todo
       |   |     |- ...           |            `- netdev_run_todo
       |   |     `- rtnl_unlock   |               |- __rtnl_unlock
       |   |                      |               |- netdev_wait_allrefs_any
       \   |- rtnl_lock  <--------'                  |
           |- netdev_put(dev, ...)  <----------------'  Wait refcnt decrement
                                                        and log splat below

To avoid blocking SIOCBRDELBR unnecessarily, let's not call
dev_ioctl() for SIOCBRADDIF and SIOCBRDELIF.

In the dev_ioctl() path, we do the following:

  1. Copy struct ifreq by get_user_ifreq in sock_do_ioctl()
  2. Check CAP_NET_ADMIN in dev_ioctl()
  3. Call dev_load() in dev_ioctl()
  4. Fetch the master dev from ifr.ifr_name in dev_ifsioc()

3. can be done by request_module() in br_ioctl_call(), so we move
1., 2., and 4. to br_ioctl_stub().

Note that 2. is also checked later in add_del_if(), but it's better
performed before RTNL.

SIOCBRADDIF and SIOCBRDELIF have been processed in dev_ioctl() since
the pre-git era, and there seems to be no specific reason to process
them there.

[0]:
unregister_netdevice: waiting for wpan3 to become free. Usage count = 2
ref_tracker: wpan3@ffff8880662d8608 has 1/1 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4282 [inline]
     netdev_hold include/linux/netdevice.h:4311 [inline]
     dev_ifsioc+0xc6a/0x1160 net/core/dev_ioctl.c:624
     dev_ioctl+0x255/0x10c0 net/core/dev_ioctl.c:826
     sock_do_ioctl+0x1ca/0x260 net/socket.c:1213
     sock_ioctl+0x23a/0x6c0 net/socket.c:1318
     vfs_ioctl fs/ioctl.c:51 [inline]
     __do_sys_ioctl fs/ioctl.c:906 [inline]
     __se_sys_ioctl fs/ioctl.c:892 [inline]
     __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892
     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
     do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 893b19587534 ("net: bridge: fix ioctl locking")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Reported-by: yan kang <kangyan91@outlook.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/netdev/SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/if_bridge.h |  6 ++----
 net/bridge/br_ioctl.c     | 39 ++++++++++++++++++++++++++++++++++++---
 net/bridge/br_private.h   |  3 +--
 net/core/dev_ioctl.c      | 19 -------------------
 net/socket.c              | 19 +++++++++----------
 5 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 3ff96ae31bf6..c5fe3b2a53e8 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -65,11 +65,9 @@ struct br_ip_list {
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
 struct net_bridge;
-void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
-			     unsigned int cmd, struct ifreq *ifr,
+void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
 			     void __user *uarg));
-int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg);
+int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg);
 
 #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
 int br_multicast_list_adjacent(struct net_device *dev,
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index f213ed108361..b5a607f6da4e 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -394,10 +394,29 @@ static int old_deviceless(struct net *net, void __user *data)
 	return -EOPNOTSUPP;
 }
 
-int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg)
+int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg)
 {
 	int ret = -EOPNOTSUPP;
+	struct ifreq ifr;
+
+	switch (cmd) {
+	case SIOCBRADDIF:
+	case SIOCBRDELIF: {
+		void __user *data;
+		char *colon;
+
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+
+		if (get_user_ifreq(&ifr, &data, uarg))
+			return -EFAULT;
+
+		ifr.ifr_name[IFNAMSIZ - 1] = 0;
+		colon = strchr(ifr.ifr_name, ':');
+		if (colon)
+			*colon = 0;
+	}
+	}
 
 	rtnl_lock();
 
@@ -430,9 +449,23 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
 		break;
 	case SIOCBRADDIF:
 	case SIOCBRDELIF:
-		ret = add_del_if(br, ifr->ifr_ifindex, cmd == SIOCBRADDIF);
+	{
+		struct net_device *dev;
+
+		dev = __dev_get_by_name(net, ifr.ifr_name);
+		if (!dev || !netif_device_present(dev)) {
+			ret = -ENODEV;
+			break;
+		}
+		if (!netif_is_bridge_master(dev)) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		ret = add_del_if(netdev_priv(dev), ifr.ifr_ifindex, cmd == SIOCBRADDIF);
 		break;
 	}
+	}
 
 	rtnl_unlock();
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1054b8a88edc..d5b3c5936a79 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -949,8 +949,7 @@ br_port_get_check_rtnl(const struct net_device *dev)
 /* br_ioctl.c */
 int br_dev_siocdevprivate(struct net_device *dev, struct ifreq *rq,
 			  void __user *data, int cmd);
-int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg);
+int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg);
 
 /* br_multicast.c */
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 4c2098ac9d72..57f79f8e8466 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -551,7 +551,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	int err;
 	struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
 	const struct net_device_ops *ops;
-	netdevice_tracker dev_tracker;
 
 	if (!dev)
 		return -ENODEV;
@@ -614,22 +613,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 	case SIOCWANDEV:
 		return dev_siocwandev(dev, &ifr->ifr_settings);
 
-	case SIOCBRADDIF:
-	case SIOCBRDELIF:
-		if (!netif_device_present(dev))
-			return -ENODEV;
-		if (!netif_is_bridge_master(dev))
-			return -EOPNOTSUPP;
-
-		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
-		rtnl_net_unlock(net);
-
-		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
-
-		netdev_put(dev, &dev_tracker);
-		rtnl_net_lock(net);
-		return err;
-
 	case SIOCDEVPRIVATE ... SIOCDEVPRIVATE + 15:
 		return dev_siocdevprivate(dev, ifr, data, cmd);
 
@@ -812,8 +795,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	case SIOCBONDRELEASE:
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
-	case SIOCBRADDIF:
-	case SIOCBRDELIF:
 	case SIOCSHWTSTAMP:
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
diff --git a/net/socket.c b/net/socket.c
index 28bae5a94234..38227d00d198 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1145,12 +1145,10 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
  */
 
 static DEFINE_MUTEX(br_ioctl_mutex);
-static int (*br_ioctl_hook)(struct net *net, struct net_bridge *br,
-			    unsigned int cmd, struct ifreq *ifr,
+static int (*br_ioctl_hook)(struct net *net, unsigned int cmd,
 			    void __user *uarg);
 
-void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
-			     unsigned int cmd, struct ifreq *ifr,
+void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
 			     void __user *uarg))
 {
 	mutex_lock(&br_ioctl_mutex);
@@ -1159,8 +1157,7 @@ void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
 }
 EXPORT_SYMBOL(brioctl_set);
 
-int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
-		  struct ifreq *ifr, void __user *uarg)
+int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg)
 {
 	int err = -ENOPKG;
 
@@ -1169,7 +1166,7 @@ int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
 
 	mutex_lock(&br_ioctl_mutex);
 	if (br_ioctl_hook)
-		err = br_ioctl_hook(net, br, cmd, ifr, uarg);
+		err = br_ioctl_hook(net, cmd, uarg);
 	mutex_unlock(&br_ioctl_mutex);
 
 	return err;
@@ -1269,7 +1266,9 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		case SIOCSIFBR:
 		case SIOCBRADDBR:
 		case SIOCBRDELBR:
-			err = br_ioctl_call(net, NULL, cmd, NULL, argp);
+		case SIOCBRADDIF:
+		case SIOCBRDELIF:
+			err = br_ioctl_call(net, cmd, argp);
 			break;
 		case SIOCGIFVLAN:
 		case SIOCSIFVLAN:
@@ -3429,6 +3428,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCGPGRP:
 	case SIOCBRADDBR:
 	case SIOCBRDELBR:
+	case SIOCBRADDIF:
+	case SIOCBRDELIF:
 	case SIOCGIFVLAN:
 	case SIOCSIFVLAN:
 	case SIOCGSKNS:
@@ -3468,8 +3469,6 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCGIFPFLAGS:
 	case SIOCGIFTXQLEN:
 	case SIOCSIFTXQLEN:
-	case SIOCBRADDIF:
-	case SIOCBRDELIF:
 	case SIOCGIFNAME:
 	case SIOCSIFNAME:
 	case SIOCGMIIPHY:
-- 
2.48.1


