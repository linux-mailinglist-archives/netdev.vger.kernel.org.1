Return-Path: <netdev+bounces-174749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C1A602AF
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B550D17B8B2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D01DF26B;
	Thu, 13 Mar 2025 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p//kH4v2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F2126C1E;
	Thu, 13 Mar 2025 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897938; cv=none; b=e4Y7nIsjdYEdUP4/f/IIBy9c8lcwxyPT1IryYe8TSZyUckgJX8cJCqs6385wBmcnAMY5EuvO4gF71KEEix02B8va0n1I06RxlY1/KGWWR4/7ajd9PkB6MbLUb+zTQZnrmpIkI6Cj+TYfGUycDQ2h2+eyCGQ/dxIcChZqJbtwT+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897938; c=relaxed/simple;
	bh=/s8TJKw85q/nQo/4ddv60E1KNTkR48/fWeXRP294mqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smh+8Vgyno5/iyTrwZS3lBvHiBiE6bq4ba+gAa9yBsdiUBhglLVqFEVvdWWudbNha2BjT5BtCMOK0zzFywy6OrJUT4NCcQD2AtHMl/RdwLTMZm3/TlzHH8Fc88nh3indLlOKqSE7BjvbJhaWcOlrvgLMSKAIsTjXd+ocnSaCl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p//kH4v2; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741897937; x=1773433937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lrm6FdRLaFw4XZAdUXRYfERlyI+ZFyf9ME26NLUfj48=;
  b=p//kH4v2r7W/yt7l6PyzDdB8q/umon3Gdco5OufynNL8/VFWJfZnffaV
   e3PIA7z0boZDk7IYBo5PE74WludEuEpNLQZPbl+yLKU88kCXTHUdZiIYr
   9NSQQUZwtX1cJbYoNAwEZeQ1vguLrURWovnpDrQuygoFXrdKC9QREpsR8
   k=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="31744189"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 20:32:13 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:42896]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id bd151f71-a1f6-4c09-9b2f-585098db9e05; Thu, 13 Mar 2025 20:32:12 +0000 (UTC)
X-Farcaster-Flow-ID: bd151f71-a1f6-4c09-9b2f-585098db9e05
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 20:32:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.242.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 20:32:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kangyan91@outlook.com>
CC: <aleksander.lobakin@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <florian.fainelli@broadcom.com>, <horms@kernel.org>,
	<kory.maincent@bootlin.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free [unbalanced refcount bug in dev_ifsioc]
Date: Thu, 13 Mar 2025 13:31:34 -0700
Message-ID: <20250313203158.45057-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
References: <SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: YAN KANG <kangyan91@outlook.com>
Date: Thu, 13 Mar 2025 16:18:22 +0000
> Dear maintainers,
> 
> I found a an unbalanced refcount bug titiled "unregister_netdevice:
> waiting for DEV to become free" while using modified syzkaller fuzzing
> tool. I tested it on the latest Linux upstream version (6.14.0-rc6) .
> I have repro to trigger it.
> 
> RootCause Analysis:
> function dev_ifsioc in /net/core/dev_ioctl.c  use netdev_hold and
> netdev_put  try to balance refcount but meet a concurrent Error.
> 	case SIOCBRDELIF:
> 		if (!netif_device_present(dev))
> 			return -ENODEV;
> 		if (!netif_is_bridge_master(dev))
> 			return -EOPNOTSUPP;
> 
> 		netdev_hold(dev, &dev_tracker, GFP_KERNEL); //dev_refcnt += 1 
> 		rtnl_net_unlock(net); //unlock 
> 
> 		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL); // lock --dosomething ---unlock
> 
> 		netdev_put(dev, &dev_tracker); //dev_refcnt -= 1
> 		rtnl_net_lock(net);
> 		return err;
> 
> Bug occurs:
> 
> Thread 1:                                                          Thread 2:
> 
> sock_ioctl:                                                      sock_ioctl:
>         dev_ifsioc:( cmd = SIOCBRDELIF)                 br_ioctl_call:
>             netdev_hold(dev...)                                         br_ioctl_stub: (cmd = SIOCBRDELBR)
>             rtnl_net_unlock(net)
>                      rtnl_unlock() [1]
>                                                                                      rtnl_lock() // lock [2]
>                                                                                           br_del_bridge:
>                                                                                                br_dev_delete:
>                                                                                                        unregister_netdevice_queue(br->dev, head); // add dev to net_todo_list
>                                                                                           rtnl_unlock() // trigger NETDEV_UNREGISTER event and check refcount [3]
>                                                                                                   refcount != 1   panic !
>               ...
>             rtnl_net_lock(net)[4]
>             netdev_put(dev...)

Thanks for the report !

This looks valid to me.


> 
> Fix Suggestion:
>  Remove netdev_hold and netdev_put in dev_ifsioc. Because br_ioctl_call will lock and getdev reference by net.

This doesn't work because we can't touch dev without refcnt bumped
after releaseing RTNL.  Note that the dev here is the bridge device,
not the slave that is looked up add_del_if().

The fix would be move SIOCBRDELIF into sock_ioctl().

I'll post a patch after checking if there was any reason to put
SIOCBRDELIF in dev_ioctl().

---8<---
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
index f213ed108361..4667635ff588 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -394,10 +394,28 @@ static int old_deviceless(struct net *net, void __user *data)
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
+		if (get_user_ifreq(&ifr, &data, uarg))
+			return -EFAULT;
+
+		ifr.ifr_name[IFNAMSIZ - 1] = 0;
+		colon = strchr(ifr.ifr_name, ':');
+		if (colon)
+			*colon = 0;
+
+		dev_load(net, ifr.ifr_name);
+	}
+	}
 
 	rtnl_lock();
 
@@ -430,9 +448,24 @@ int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
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
+
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
index 28bae5a94234..ad1f89b6ddf9 100644
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
---8<---

