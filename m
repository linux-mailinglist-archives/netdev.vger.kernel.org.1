Return-Path: <netdev+bounces-175134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8449A6366F
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EEF1887961
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD61A840A;
	Sun, 16 Mar 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP5ROHj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550E187FFA
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143319; cv=none; b=jrAG01o8PGKC49B/6zyRySrZcte7maOtmGspBk5VVp/Eb1bpqYgQ+8JEb9wKTpz5Zi9FyvISasbNJ5K9LmLXJIOiX8vusQTMBopdE9ttVu0w0+9mF8f+Lp406v+kh00fbParRP2nfcSDZjTHot/0Pi8ZRG3BjsQTGYJ4AsCNSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143319; c=relaxed/simple;
	bh=BA2PaE3NYW+aVBBLWMmVbiWA/xSnqlWWpzhT5hvQzg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/y/FAqt5L/XBpHy02C7y4GxVt+Iz13h9faim0D9SVdOiWx4CtRcZtn2d1/KfqiTMvj8pWFwIw9kDlcBC7Yy4OcOJ2OTKdeTfhP79NXHBgANlNSJFFxr03DvpwYTuZaR8mrdhNk97AjYC8hF/R3jgC8KRPeRjTr2Q5JYiDT7Z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP5ROHj8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224019ad9edso12521205ad.1
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742143317; x=1742748117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1t7i2k+qpddSOT6lrsF95vAec+0YDsSW3ORX2scnraI=;
        b=VP5ROHj8+xyMdBZ/pSrEX9lmDa1ORfHv62ctOJpanHXSD3ZgCmCSBkUb0jZSFWA6Yi
         V9E1ZfxHRZCWMMWhbjI37XEtvHUHAdqaHCVNLRAAUsGd+/ugrEJEv/VI63Cr4S0SQPhI
         eGg9H1tNcyJDAEno8ZCsr6V0obIxltI59hleAYcWygMMkbx7QzECyuaV6UHSfKWbqTiy
         bpgLMs34HxbepTtH9BXOBy4NFOmT8p+AoGIqRQ6JP0D56rseLlCcEuH3ZKpyUde77JQ1
         gcZRsEJtY74QFu5DRE24UvXcg3lsX4ONxwPZ8t58LNZEbOpc7FpMcjoNVDArW4j4AAKg
         XuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742143317; x=1742748117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t7i2k+qpddSOT6lrsF95vAec+0YDsSW3ORX2scnraI=;
        b=hYpGxXcyPgunovdXQtK670gXARN32MMAgRZnBbSRXLj8+shJZ2ZdlfIwkDsEYR6zfR
         MfsKNsib7R74q8NqIG5NpLQNmcCu++9uTrrAAz43jUnW5kLge7tpNl+DwVCJxiLBHg0f
         vjk0qe4HtedtCLswMdi46ZV4qVgnG4ey96kNRiRc1B1k91f8YgYJYAJSk6Ig8S0y3+AJ
         mzrv6bFFQePo5A6xlSPjuItUfg+ZWskhC1SHrqVqtiWOl0gF+Ga9dnNiMVSVZL/i4Y5e
         0lJsVKi2QtnXkZtUeuXOq9b5yhz9viW5eedgstSlKElIhT0QaZFRYQ+SkX3j1kvv67t7
         FHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNPzaNgcmKamkqKN9C+S201VdsurvoyOydj8ZRs8C0ajSizG8qtsAUJmXDYDt9aov5IwzQv+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WFvffMdjFdjKMUs0DQLc4htFDHcv34zVsfovc4Wy2CCRVdpR
	4pFMj0ipYzCutH3iATRimz+j0EZd1i8BMfxG1NMsYWj7fHIn+7s=
X-Gm-Gg: ASbGncvH769umg9SDOmUG/z2c2aOrGFvGYVzDj/hEwgrdN8BwzPgUYAIBIxM86uCfTo
	8Z4ll+lmCIOXZXb/NDUBFSLuqX9AJsdJOp+2O4/MvGRJszjUVLCr5NCzNLxsI9mmLRTPLegYA0X
	a5+N3U/FF5EHWKl8idD5osZxt9k8jYXb3+1FMCUptiRRqzOxojrolY0QybKsCi0oWV4ejQmr2d0
	9v6Ek1+6h1Q943uCU6yvQFxNHx4CZlAAR138bNm+oukIaKYqu7HWpyGxwlDciBMaoyAj0GpOlj5
	vVhJloFIBuk6f8XjdTr4GgVz314/KM1+mXKqR3k1qR4Y
X-Google-Smtp-Source: AGHT+IH+gC5/AF7fQ/nODds+CLzi/mSoDdhCQD4zxfJmTqOpndJJjUsBKADkQTXD988rSMfcIE5Qxg==
X-Received: by 2002:a17:902:f686:b0:223:397f:46be with SMTP id d9443c01a7336-225e0aff8abmr118629555ad.47.1742143317261;
        Sun, 16 Mar 2025 09:41:57 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c688841fsm59623795ad.26.2025.03.16.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 09:41:56 -0700 (PDT)
Date: Sun, 16 Mar 2025 09:41:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
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
Message-ID: <Z9b_VP-F_3iAKvCw@mini-arch>
References: <20250314010501.75798-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314010501.75798-1-kuniyu@amazon.com>

On 03/13, Kuniyuki Iwashima wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Although these double } } look funky. Maybe properly declare variables
at the top instead?

