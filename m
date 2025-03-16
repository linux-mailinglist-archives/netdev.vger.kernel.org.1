Return-Path: <netdev+bounces-175132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564EA6365F
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 17:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE153AC974
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5A18DB0A;
	Sun, 16 Mar 2025 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5kA1jXe"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CF42A8B
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742141769; cv=none; b=IsmvtwKzGv5rnbWWaTMcXe0A6T5lrK9I026bpCOtg22ccY1Lp+8INUGDmwKmKbUHE9MLvsUog0Dn33CZIGtmMIk0Ggu0wmPuAOp4zE0GJksIpcFLHdgbUOEDn8qtlhO3/6y3Ssz3LqQRPB0LAJZURRiCOAyG9pVGAcYMAyvsuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742141769; c=relaxed/simple;
	bh=B2Mv0u9Xy1iTuTe7gJvsFVcD8O3qXeh510ZdDDO51aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5iXpk2HnLecWiPS1xVKYDQDLTNMiFOq9RLO4si3+kc/lwpMzbk22hg9J0TmWNwe9W3NZxBMS9gfN39DZf11YupyZ2wOJSeydBFi+JMqBc5bqtKpi2+BuGnZP0pvxnNVRiHVdSu/no6G9ChjPxMGLC99vMFNsqZtwNMbsmqADY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C5kA1jXe; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F83E2540127;
	Sun, 16 Mar 2025 12:16:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Mar 2025 12:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742141763; x=1742228163; bh=ESzR6vbQtgUfCVVzOfajXcGVGwL9jiVw/a7
	2XfUMx5U=; b=C5kA1jXe4Dn9Q+mjpOwJxdz6sghWw9W166mI8n38iX6rEFGc04H
	0i0r7Togb85aAGAR1izH7dW7HfahpsU40Td7W+sVy15Kn8aUHxjhaBBQAPni81dh
	Nr3XhUTzDw186On32t9X0tZj4PdFiiob7i64ptU9TZfQjBtD8AdPhr85Rgn50I3i
	uXXovB/IrImmDoRCUe0AsWSR7iOhqFxa8n7ZwOkRo4Qo5lA+rGYrq+/3qZJ918lm
	X6NxWLpMDTZJGg3L/xZtzDqmN2XmiabpacSJwiNIbmS7z1ILccpeoWFV6DnVZLwr
	NUMyHmKLmZlu1g6V6wWXgrV9/lWml3JrMLA==
X-ME-Sender: <xms:Q_nWZz8NNqA3Kxrw1xC0r5AWzkHLISDhan1eNhY444BHMO1v2MQ65A>
    <xme:Q_nWZ_tZ9OYdjzphthoV054mxowOS6Pho5aZV-zEpyBhisCxE5qwEkwW9itR3b9dw
    SOD1cPiIaQxn7I>
X-ME-Received: <xmr:Q_nWZxAqpnPn0CB47o3ZmUg_7N59-gNjF38GW6O5wcX5cvVKI620l5Hm37-F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeu
    gfduffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhoohhprgesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
    dprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Q_nWZ_e0LXPwtDf03Drt74sCSrcz0Sm4R2LcLPgLpWyLHXe1HqNA_A>
    <xmx:Q_nWZ4O7A10LgzFLQbpEHLYKZM__PAYnkC6-Q0uyoNgYhmsKjbw58w>
    <xmx:Q_nWZxkluexEs0Tm8mJTFTxwTOI08LfDYg1dwT4eEUVvision5IVzQ>
    <xmx:Q_nWZyvT0nX-jkXxztJriRS7TZvs4k7d9dapLKQUyWKeVP8nB3LcoQ>
    <xmx:Q_nWZ9vsQSHKBhZOt4oX9ZUNDw4u7BvAyvJohboRZJms9RB_q2-Nz4Fk>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 12:16:02 -0400 (EDT)
Date: Sun, 16 Mar 2025 18:16:00 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
	yan kang <kangyan91@outlook.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v1 net] net: Remove RTNL dance for SIOCBRADDIF and
 SIOCBRDELIF.
Message-ID: <Z9b5QAKtTSCv3DVZ@shredder>
References: <20250314010501.75798-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314010501.75798-1-kuniyu@amazon.com>

On Thu, Mar 13, 2025 at 05:59:55PM -0700, Kuniyuki Iwashima wrote:
> SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
> br_ioctl_call(), which causes unnecessary RTNL dance and the splat
> below [0] under RTNL pressure.
> 
> Let's say Thread A is trying to detach a device from a bridge and
> Thread B is trying to remove the bridge.
> 
> In dev_ioctl(), Thread A bumps the bridge device's refcnt by
> netdev_hold() and releases RTNL because the following br_ioctl_call()
> also re-acquires RTNL.
> 
> In the race window, Thread B could acquire RTNL and try to remove
> the bridge device.  Then, rtnl_unlock() by Thread B will release RTNL
> and wait for netdev_put() by Thread A.
> 
> Thread A, however, must hold RTNL twice after the unlock in dev_ifsioc(),
> which may take long under RTNL pressure, resulting in the splat by
> Thread B.
> 
>   Thread A (SIOCBRDELIF)           Thread B (SIOCBRDELBR)
>   ----------------------           ----------------------
>   sock_ioctl                       sock_ioctl
>   `- sock_do_ioctl                 `- br_ioctl_call
>      `- dev_ioctl                     `- br_ioctl_stub
>         |- rtnl_lock                     |
>         |- dev_ifsioc                    '
>         '  |- dev = __dev_get_by_name(...)
>            |- netdev_hold(dev, ...)      .
>        /   |- rtnl_unlock  ------.       |
>        |   |- br_ioctl_call       `--->  |- rtnl_lock
>   Race |   |  `- br_ioctl_stub           |- br_del_bridge
>   Window   |     |                       |  |- dev = __dev_get_by_name(...)
>        |   |     |  May take long        |  `- br_dev_delete(dev, ...)
>        |   |     |  under RTNL pressure  |     `- unregister_netdevice_queue(dev, ...)
>        |   |     |                |      `- rtnl_unlock
>        |   |     |- rtnl_lock  <--|         `- netdev_run_todo
>        |   |     |- ...           |            `- netdev_run_todo
>        |   |     `- rtnl_unlock   |               |- __rtnl_unlock
>        |   |                      |               |- netdev_wait_allrefs_any
>        \   |- rtnl_lock  <--------'                  |
>            |- netdev_put(dev, ...)  <----------------'  Wait refcnt decrement
>                                                         and log splat below

Isn't the race window a bit smaller? dev_ifsioc() does netdev_put()
before rtnl_lock().

> 
> To avoid blocking SIOCBRDELBR unnecessarily, let's not call
> dev_ioctl() for SIOCBRADDIF and SIOCBRDELIF.
> 
> In the dev_ioctl() path, we do the following:
> 
>   1. Copy struct ifreq by get_user_ifreq in sock_do_ioctl()
>   2. Check CAP_NET_ADMIN in dev_ioctl()
>   3. Call dev_load() in dev_ioctl()
>   4. Fetch the master dev from ifr.ifr_name in dev_ifsioc()
> 
> 3. can be done by request_module() in br_ioctl_call(), so we move
> 1., 2., and 4. to br_ioctl_stub().
> 
> Note that 2. is also checked later in add_del_if(), but it's better
> performed before RTNL.
> 
> SIOCBRADDIF and SIOCBRDELIF have been processed in dev_ioctl() since
> the pre-git era, and there seems to be no specific reason to process
> them there.

I couldn't find an explanation as well.

Doesn't seem like we have any tests for the IOCTL path, but FWIW I
verified that basic operations using brctl still work after this patch.

> 
> [0]:
> unregister_netdevice: waiting for wpan3 to become free. Usage count = 2
> ref_tracker: wpan3@ffff8880662d8608 has 1/1 users at
>      __netdev_tracker_alloc include/linux/netdevice.h:4282 [inline]
>      netdev_hold include/linux/netdevice.h:4311 [inline]
>      dev_ifsioc+0xc6a/0x1160 net/core/dev_ioctl.c:624
>      dev_ioctl+0x255/0x10c0 net/core/dev_ioctl.c:826
>      sock_do_ioctl+0x1ca/0x260 net/socket.c:1213
>      sock_ioctl+0x23a/0x6c0 net/socket.c:1318
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:906 [inline]
>      __se_sys_ioctl fs/ioctl.c:892 [inline]
>      __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 893b19587534 ("net: bridge: fix ioctl locking")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/netdev/SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks for the fix and the detailed commit message. One nit below.

> ---
>  include/linux/if_bridge.h |  6 ++----
>  net/bridge/br_ioctl.c     | 39 ++++++++++++++++++++++++++++++++++++---
>  net/bridge/br_private.h   |  3 +--
>  net/core/dev_ioctl.c      | 19 -------------------
>  net/socket.c              | 19 +++++++++----------
>  5 files changed, 48 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 3ff96ae31bf6..c5fe3b2a53e8 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -65,11 +65,9 @@ struct br_ip_list {
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
>  struct net_bridge;
> -void brioctl_set(int (*hook)(struct net *net, struct net_bridge *br,
> -			     unsigned int cmd, struct ifreq *ifr,
> +void brioctl_set(int (*hook)(struct net *net, unsigned int cmd,
>  			     void __user *uarg));
> -int br_ioctl_call(struct net *net, struct net_bridge *br, unsigned int cmd,
> -		  struct ifreq *ifr, void __user *uarg);
> +int br_ioctl_call(struct net *net, unsigned int cmd, void __user *uarg);
>  
>  #if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
>  int br_multicast_list_adjacent(struct net_device *dev,
> diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
> index f213ed108361..b5a607f6da4e 100644
> --- a/net/bridge/br_ioctl.c
> +++ b/net/bridge/br_ioctl.c
> @@ -394,10 +394,29 @@ static int old_deviceless(struct net *net, void __user *data)
>  	return -EOPNOTSUPP;
>  }
>  
> -int br_ioctl_stub(struct net *net, struct net_bridge *br, unsigned int cmd,
> -		  struct ifreq *ifr, void __user *uarg)
> +int br_ioctl_stub(struct net *net, unsigned int cmd, void __user *uarg)
>  {
>  	int ret = -EOPNOTSUPP;
> +	struct ifreq ifr;
> +
> +	switch (cmd) {
> +	case SIOCBRADDIF:
> +	case SIOCBRDELIF: {

Why not a simple if statement? Unlikely that we will add more commands
to this switch statement.

> +		void __user *data;
> +		char *colon;
> +
> +		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		if (get_user_ifreq(&ifr, &data, uarg))
> +			return -EFAULT;
> +
> +		ifr.ifr_name[IFNAMSIZ - 1] = 0;
> +		colon = strchr(ifr.ifr_name, ':');
> +		if (colon)
> +			*colon = 0;
> +	}
> +	}
>  
>  	rtnl_lock();

