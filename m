Return-Path: <netdev+bounces-175137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A5A63723
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B07A4035
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF7153BE8;
	Sun, 16 Mar 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ltHlnf/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18C3FE4
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151714; cv=none; b=s+Sjn9VlwB6xHuX6NEgagDKmG8Libh8Af0sGfbThrCwgrKnbdt41UZsQSWsTKRJBtnj1PogfVoSuNkRg7eF6ijU3VJsXO+7czNXtUTBV3VuKH6TR/r2BvzOl286CKclF/juYTrmvLkaTqXmz5CuMbMWePj9wCc59EKJvt1QuB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151714; c=relaxed/simple;
	bh=Slz3zxAOn9uAseSECXcGEZ1IDI5JKvs0PF3SOWzD1/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwBbnXvhofIyhmJBk4ZiH/Qsw1uY4cUFjybQQ2yVdWx/lazSDpfuigEoRuU6aD9t2waN5jMkiPq5ngVvsl78QfcW90G9PpSY7oXZfWaTqIxjPDrJXmXnIGCU8VTgAZ0NNzyqUDwTNKf9k1OPAqlVkHD8tr/dLnmmkwb91u/A2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ltHlnf/G; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742151713; x=1773687713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s3SiFa/tMRAW3hsrmHvuMdZDkrtHjUyoOqHbA9iMzF4=;
  b=ltHlnf/G9h5WoHvnJopfgDEk12qjGtyF3DWgjkMSe3vTOlFQ+LcRw6kQ
   dVj2GVsEKgr1C2qdJqYoqzbj64BWo3P3REW80Yt498qiBU/l8fQnPBG4N
   w/NBLRNM7pBbWQyodsNWd/zR8SMvvEHbNoh3e6T+J3haBEFu9eNVXgUuv
   E=;
X-IronPort-AV: E=Sophos;i="6.14,252,1736812800"; 
   d="scan'208";a="387138031"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 19:01:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:29586]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id f0baa333-1477-42e3-bde5-bdd42e188249; Sun, 16 Mar 2025 19:01:50 +0000 (UTC)
X-Farcaster-Flow-ID: f0baa333-1477-42e3-bde5-bdd42e188249
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 16 Mar 2025 19:01:50 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.216.189) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 16 Mar 2025 19:01:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <idosch@idosch.org>, <stfomichev@gmail.com>
CC: <andrew+netdev@lunn.ch>, <bridge@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kangyan91@outlook.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<roopa@nvidia.com>, <samsun1006219@gmail.com>, <syzkaller@googlegroups.com>,
	<willemb@google.com>
Subject: Re: [PATCH v1 net] net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.
Date: Sun, 16 Mar 2025 12:01:26 -0700
Message-ID: <20250316190138.14440-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z9b5QAKtTSCv3DVZ@shredder>
References: <Z9b5QAKtTSCv3DVZ@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 16 Mar 2025 18:16:00 +0200
> On Thu, Mar 13, 2025 at 05:59:55PM -0700, Kuniyuki Iwashima wrote:
> > SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
> > br_ioctl_call(), which causes unnecessary RTNL dance and the splat
> > below [0] under RTNL pressure.
> > 
> > Let's say Thread A is trying to detach a device from a bridge and
> > Thread B is trying to remove the bridge.
> > 
> > In dev_ioctl(), Thread A bumps the bridge device's refcnt by
> > netdev_hold() and releases RTNL because the following br_ioctl_call()
> > also re-acquires RTNL.
> > 
> > In the race window, Thread B could acquire RTNL and try to remove
> > the bridge device.  Then, rtnl_unlock() by Thread B will release RTNL
> > and wait for netdev_put() by Thread A.
> > 
> > Thread A, however, must hold RTNL twice after the unlock in dev_ifsioc(),
> > which may take long under RTNL pressure, resulting in the splat by
> > Thread B.
> > 
> >   Thread A (SIOCBRDELIF)           Thread B (SIOCBRDELBR)
> >   ----------------------           ----------------------
> >   sock_ioctl                       sock_ioctl
> >   `- sock_do_ioctl                 `- br_ioctl_call
> >      `- dev_ioctl                     `- br_ioctl_stub
> >         |- rtnl_lock                     |
> >         |- dev_ifsioc                    '
> >         '  |- dev = __dev_get_by_name(...)
> >            |- netdev_hold(dev, ...)      .
> >        /   |- rtnl_unlock  ------.       |
> >        |   |- br_ioctl_call       `--->  |- rtnl_lock
> >   Race |   |  `- br_ioctl_stub           |- br_del_bridge
> >   Window   |     |                       |  |- dev = __dev_get_by_name(...)
> >        |   |     |  May take long        |  `- br_dev_delete(dev, ...)
> >        |   |     |  under RTNL pressure  |     `- unregister_netdevice_queue(dev, ...)
> >        |   |     |                |      `- rtnl_unlock
> >        |   |     |- rtnl_lock  <--|         `- netdev_run_todo
> >        |   |     |- ...           |            `- netdev_run_todo
> >        |   |     `- rtnl_unlock   |               |- __rtnl_unlock
> >        |   |                      |               |- netdev_wait_allrefs_any
> >        \   |- rtnl_lock  <--------'                  |
> >            |- netdev_put(dev, ...)  <----------------'  Wait refcnt decrement
> >                                                         and log splat below
> 
> Isn't the race window a bit smaller? dev_ifsioc() does netdev_put()
> before rtnl_lock().

Ah right, looks like I'm lost while writing.


> 
> > 
> > To avoid blocking SIOCBRDELBR unnecessarily, let's not call
> > dev_ioctl() for SIOCBRADDIF and SIOCBRDELIF.
> > 
> > In the dev_ioctl() path, we do the following:
> > 
> >   1. Copy struct ifreq by get_user_ifreq in sock_do_ioctl()
> >   2. Check CAP_NET_ADMIN in dev_ioctl()
> >   3. Call dev_load() in dev_ioctl()
> >   4. Fetch the master dev from ifr.ifr_name in dev_ifsioc()
> > 
> > 3. can be done by request_module() in br_ioctl_call(), so we move
> > 1., 2., and 4. to br_ioctl_stub().
> > 
> > Note that 2. is also checked later in add_del_if(), but it's better
> > performed before RTNL.
> > 
> > SIOCBRADDIF and SIOCBRDELIF have been processed in dev_ioctl() since
> > the pre-git era, and there seems to be no specific reason to process
> > them there.
> 
> I couldn't find an explanation as well.
> 
> Doesn't seem like we have any tests for the IOCTL path, but FWIW I
> verified that basic operations using brctl still work after this patch.

Thanks :)

> 
> > 
> > [0]:
> > unregister_netdevice: waiting for wpan3 to become free. Usage count = 2
> > ref_tracker: wpan3@ffff8880662d8608 has 1/1 users at
> >      __netdev_tracker_alloc include/linux/netdevice.h:4282 [inline]
> >      netdev_hold include/linux/netdevice.h:4311 [inline]
> >      dev_ifsioc+0xc6a/0x1160 net/core/dev_ioctl.c:624
> >      dev_ioctl+0x255/0x10c0 net/core/dev_ioctl.c:826
> >      sock_do_ioctl+0x1ca/0x260 net/socket.c:1213
> >      sock_ioctl+0x23a/0x6c0 net/socket.c:1318
> >      vfs_ioctl fs/ioctl.c:51 [inline]
> >      __do_sys_ioctl fs/ioctl.c:906 [inline]
> >      __se_sys_ioctl fs/ioctl.c:892 [inline]
> >      __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892
> >      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >      do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
> >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Fixes: 893b19587534 ("net: bridge: fix ioctl locking")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Reported-by: yan kang <kangyan91@outlook.com>
> > Reported-by: yue sun <samsun1006219@gmail.com>
> > Closes: https://lore.kernel.org/netdev/SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Thanks for the fix and the detailed commit message. One nit below.
> 
> > ---
> >  include/linux/if_bridge.h |  6 ++----
> >  net/bridge/br_ioctl.c     | 39 ++++++++++++++++++++++++++++++++++++---
> >  net/bridge/br_private.h   |  3 +--
> >  net/core/dev_ioctl.c      | 19 -------------------
> >  net/socket.c              | 19 +++++++++----------
> >  5 files changed, 48 insertions(+), 38 deletions(-)
> > 
> > diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> > index 3ff96ae31bf6..c5fe3b2a53e8 100644
> > --- a/include/linux/if_bridge.h
> > +++ b/include/linux/if_bridge.h
> > @@ -65,11 +65,9 @@ struct br_ip_list {
> >  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
> >  
> >  struct net_bridge;
> > -void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
> > -			     unsigned int cmd, struct ifreq *ifr,
> > +void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
> >  			     void __user *uarg));
> > -int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
> > -		  struct ifreq *ifr, void __user *uarg);
> > +int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg);
> >  
> >  #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
> >  int br_multicast_list_adjacent(struct net_device *dev,
> > diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> > index f213ed108361..b5a607f6da4e 100644
> > --- a/net/bridge/br_ioctl.c
> > +++ b/net/bridge/br_ioctl.c
> > @@ -394,10 +394,29 @@ static int old_deviceless(struct net *net, void __user *data)
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > -int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
> > -		  struct ifreq *ifr, void __user *uarg)
> > +int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg)
> >  {
> >  	int ret = -EOPNOTSUPP;
> > +	struct ifreq ifr;
> > +
> > +	switch (cmd) {
> > +	case SIOCBRADDIF:
> > +	case SIOCBRDELIF: {
> 
> Why not a simple if statement? Unlikely that we will add more commands
> to this switch statement.

Exactly, will use if in v2.
Then the funky }} will look cleaner too.

Thank you both !

