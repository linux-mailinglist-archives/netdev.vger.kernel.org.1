Return-Path: <netdev+bounces-175144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D176A63763
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B616188ED7B
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2321199931;
	Sun, 16 Mar 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YWsEiors"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19407143748
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742157311; cv=none; b=VClaDzc9TLIY21gEu1zOeNAtMYlm5dkS/agVP+NTx637Q/BGsl1eelypaxUFrHxPRhMObJcsZ1UB6WQEsKtNAbXxRrc6AHex2sfdK5ZobTGPzqQKUJLgXdFF0qOddftvBNezPg1zL7tBrEsSX4pyDLo78HzLVSnttDrnogtANQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742157311; c=relaxed/simple;
	bh=dKC6oKfJqlJWfKuMIbGGKu7ODihXEYGoPHTMMfdAuiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsAGOvh2MFLJO8pg4k19OSL0vTu6/9iAtPDEfgRFPLMMarVZ18xAEaS0w4xqT19LbiMvzdbm2RKkUn7P9Ds/TYAp8aCKlMR8rzzq0cMeZVoNSF9YmGAYS/xKpz5nzVxqy7y4FmkAs5sfO5ZZE1FiUUZY8JK/yMpQERv2zYsCPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YWsEiors; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913b539aabso2381833f8f.2
        for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742157308; x=1742762108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/qniutptUO6aG/4w6T50Q5l+k6GgQyiuG2YW9LxAFI=;
        b=YWsEiorsTlYqF1+4tPrWKJ/lhjwAiOaOYivM3FpDRKM0AtIU89voeGwqAx2mkVo6D1
         O2QaKSzSxpmWQrHEaSD9u/gfrioyr9W9lquBKiVkWLOPVouEJkZ+cjHtfADvAx1y+qpD
         8+glKtU6B5FcMz0EG68JVDdEq6/JI8j1knhw+AVyvS6k9SDhjJNh85my6awvdKWIPKR0
         nrQPYCX0PJQ+RYCXX19eGioysc0JeNSy6qmaLf7ZNSvDlnF+ND0bfBDvIDDUYZlsmGVE
         Cx1pHAfwkS+M5izcOCFtfOeTh11hJT6p363dLV+OqsxkFAaIUe8ohGIgiCqg/PSzGUh9
         /m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742157308; x=1742762108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/qniutptUO6aG/4w6T50Q5l+k6GgQyiuG2YW9LxAFI=;
        b=aXADDflOolkNaUm7Ox6wt50pzGtK1dbKS7PTlEn0WHA7hO6A+UzUO3doPwViCZdTeS
         cCmMqDbfD89Vk351f0uS4dus25PkITtQTi2OAbTSPsK41U+B6E43/OZ7Z52PRqessdl7
         YvGOiEsfV7KNaBU1wi6dKTG9Xcd0LKi7BdAn6C6DIvk4GvWpTx/MVE5IUutPaQrCd6/h
         aiel1REbxLV4wRs3zMPbWe67GD/ukh+Dvpp4D/9cWeWw+I3PN+1cbx2h5kxD1BBoRNPd
         JggDcA1QwHkF3JcCDCP3S0M7LCZmpUy3J9BoJ9uGpZZMQ1oTsfPa7apmJFyVnVdHPh4B
         pV9A==
X-Forwarded-Encrypted: i=1; AJvYcCWpcNy3tv3i+ZZT2x9DIrCUns/kP7jbCnwbDnp3VGW4GaSrzdYNdwdjtmYJgV9WxYnmnebHODw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoG0+BP37I7JdwJTiSee4T8hcEV2RRWgdafblLRizLqLbJfhZz
	VX6EjTTFTMbz0kCoVCqXhcHoU43AqgVOGjufQgr3UIjQzOf9dDv1roqpbuNcB5E=
X-Gm-Gg: ASbGncvWqc5qnmufZEIYsv19pXqRzrqCiciy14CP3cUyD9ZdIx/c1RoPLSCkDmOV6+5
	svj7CCAKHgrHqmTF/ULWnDCDiGMZZiXGUBblS+q8hbgYov1ZU9avIZecAhDBWZGBrC/TyfXxBFU
	bj49dS2jxzGzG5BM4lDDMt0sBmh6ib35ij25M8uyEMhx4wblEAkm7p3pq+iNWdceDvjBt1MEVbm
	KP19sW+Kaow5nny8JablL3Vy2GPmVTyEI0C7aLgYwAKgYYHKM4NSZHAioeYg0I1FfAmSb+Noscn
	TeIdIqKHj9tHKrhSMBlm67DUx5atrDr1dXNyKumyC6I8aAu/8utf9fVqMAVCnqyqTAj3JkM9AE9
	T
X-Google-Smtp-Source: AGHT+IEX4MsZy7CIHnz5nS7qR417zJFGnB5h/cnEE6O40fjH90DJYPmv+beoRj6eBarLH4rYx2UMvg==
X-Received: by 2002:a05:6000:1545:b0:391:2e6a:30de with SMTP id ffacd0b85a97d-3971e971991mr13080918f8f.19.1742157307990;
        Sun, 16 Mar 2025 13:35:07 -0700 (PDT)
Received: from [192.168.0.160] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm12690480f8f.44.2025.03.16.13.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 13:35:07 -0700 (PDT)
Message-ID: <d539500a-7fca-40c8-ba38-4e334a97f810@blackwall.org>
Date: Sun, 16 Mar 2025 22:35:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: Remove RTNL dance for SIOCBRADDIF and
 SIOCBRDELIF.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
 yan kang <kangyan91@outlook.com>, yue sun <samsun1006219@gmail.com>
References: <20250316192851.19781-1-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250316192851.19781-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 9:28 PM, Kuniyuki Iwashima wrote:
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
> Thread A, however, must hold RTNL after the unlock in dev_ifsioc(),
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
>        |   |     |               |       `- rtnl_unlock
>        \   |     |- rtnl_lock  <-'          `- netdev_run_todo
>            |     |- ...                        `- netdev_run_todo
>            |     `- rtnl_unlock                   |- __rtnl_unlock
>            |                                      |- netdev_wait_allrefs_any
>            |- netdev_put(dev, ...)  <----------------'
>                                                 Wait refcnt decrement
>                                                 and log splat below
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
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
> v2:
>   * Use if in br_ioctl_stub()
>   * Update diagram in commit message
> 
> v1: https://lore.kernel.org/netdev/20250314010501.75798-1-kuniyu@amazon.com/
> ---
>  include/linux/if_bridge.h |  6 ++----
>  net/bridge/br_ioctl.c     | 36 +++++++++++++++++++++++++++++++++---
>  net/bridge/br_private.h   |  3 +--
>  net/core/dev_ioctl.c      | 19 -------------------
>  net/socket.c              | 19 +++++++++----------
>  5 files changed, 45 insertions(+), 38 deletions(-)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


