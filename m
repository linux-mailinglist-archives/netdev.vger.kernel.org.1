Return-Path: <netdev+bounces-113756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA293FC93
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 19:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D02DB21C3F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B41586DB;
	Mon, 29 Jul 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ba9xDLOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A978C76
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275194; cv=none; b=u83ANf9DtMfJAdtqJfU/JkCLx/uPoPn0xCQlomhEPLySXtzBrrgl3ifzAFm07fKqardvTsb+04mUKOQSfbx3zKcaEFcw/xQV7ZfNz+fp9aQ5WNAEqeKO4jwyE3emWJ2UTp4lOh4dgiF7iAZOrbqX5aMjePdnPXBREA9wkENgsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275194; c=relaxed/simple;
	bh=x54E6CsVNHB8nlMMNY3p9jMlRbphqBDzrlOcojJrB+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5E6wtDm0A+zhrlBzvImxRHIt1hoa0bYWucsWNzdWe27GQ6DdHd6tUA61LMmi5md+22wW+8hMpOLQYLV9zLb8TQhZ8OFT3jgl+1SXnNENnyW/51QBcYDDxk5qFSjjD5cofx+E/68AKRmFa+VnFg7FNS+nqyM8R68TVewDaAXky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ba9xDLOn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so1297a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722275191; x=1722879991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH1DiYL4kdG8EVj9AsvFV25K/u74YDHNoemmf3irk7A=;
        b=ba9xDLOnc6mGzgW+oWpD4qBuF+LiInUdeVcuYnR7oO3xZ1DThyRRXSmp2cPrYdhLjN
         Vi8cVjhEcjgid1zIH8k0YhJ/lvJ3YLEXROxUNtc7YNesnX7MhoURl+7cbz2kaHcAPezM
         zP5P8uBEpUWZrQHTgatpQtA4UdXSGkhvbNynks9sB05B4I+jnRDMLYxwn9nEwDyLa7pf
         7qbTAS2ljgnljdhgFXL2Glfs+cR4i9a7zot+qcrxvysdydrnnOcOBjmhKOegoy42+cAO
         05ISP08XmkvqqxSNMC54YGi20MHnzY+HNAKjR2n4cVKyWfZ7NYHsouWJED98xXIpSBAO
         lylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275191; x=1722879991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH1DiYL4kdG8EVj9AsvFV25K/u74YDHNoemmf3irk7A=;
        b=VSL49WXmet2pXFyxTpl7VT8Q7yoppNAk29Nk8SH9kCv5XldbdA4xp5cnGzQ2xS3y/T
         NRPO1AqTZ0DSGdWLebcmfTFPgl/CBNfPQ4fpStefNkN+K4/IAmpq1kXfk+Wra5X8ewNG
         v875+4qHZdy+CSdRbAIh3uGymIxvtuLlalBy0Pj/6P6FInZjKJtQlIBJ/zrxW+wI5s1F
         yZRtTPhDO4Lucfjx7RTZx5TI2BY0LH1cL7g76NTMSf4qsW7sLzn2vAHpFxeq1icKI3Os
         NDNvDcXX2sCPbj1/HUTF5/R3eGJBv2VsH2WXzVGo2mYy8W2erNulvIz8tcHbmOXMB+wE
         UyhA==
X-Forwarded-Encrypted: i=1; AJvYcCVnj7b3CMAznIYcbIgSdJh7bmblXuKJBBapJSIIGFBMHOOhIf27ZbMxltlRf2lGx1eUFHAGaSuZZvrTH7IEzapGgI5jTtQz
X-Gm-Message-State: AOJu0YwHByi7zwbkEHyGqNvmRP1vyIeIc6XMpug29R/Mpk1c4r+5Rh5u
	48tgLYXPf6A2zZJNaTHHpNsfmxXVbP98MR3jq3CFugghwRA6v5K2W+fZOp61k6ZnqnDnE56czvw
	EuvNTLsRpf9p6e1EJFAwZzgWBbhrY9+rJ+5cu
X-Google-Smtp-Source: AGHT+IF8TSv1Ug1AIHMZ96AEE7sYh9pBStaEEW0UjSF63jl4lvS9Dm0d9y/JZ49L9hgFK+kwJqihL2kmCwpyXk2q3x8=
X-Received: by 2002:a05:6402:51d0:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5b40d4a2ad8mr35907a12.6.1722275190338; Mon, 29 Jul 2024
 10:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729163326.16386-1-aha310510@gmail.com>
In-Reply-To: <20240729163326.16386-1-aha310510@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 19:46:15 +0200
Message-ID: <CANn89i+SgDaA-vkTXxziA3OLZncgYUTViC-WaX6dGVx_0kLUww@mail.gmail.com>
Subject: Re: [PATCH net] net: annotate data race around dev->flags in __dev_change_flags
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:34=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> According to KCSAN report, there is a read/write race between
> __dev_change_flags and netif_is_bond_master for dev->flags.
>
> Thereforce, __dev_change_flags() needs protection.
>
> <syzbot>
> BUG: KCSAN: data-race in __dev_change_flags / is_upper_ndev_bond_master_f=
ilter
>
> read-write to 0xffff888112d970b0 of 4 bytes by task 4888 on cpu 0:
>  __dev_change_flags+0x9a/0x410 net/core/dev.c:8755
>  rtnl_configure_link net/core/rtnetlink.c:3321 [inline]
>  rtnl_newlink_create net/core/rtnetlink.c:3518 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
>  rtnl_newlink+0x121e/0x1690 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x85e/0x910 net/core/rtnetlink.c:6635
>  netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2564
>  rtnetlink_rcv+0x1c/0x30 net/core/rtnetlink.c:6653
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x58d/0x660 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x5ca/0x6e0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x140/0x180 net/socket.c:745
>  ____sys_sendmsg+0x312/0x410 net/socket.c:2585
>  ___sys_sendmsg net/socket.c:2639 [inline]
>  __sys_sendmsg+0x1e9/0x280 net/socket.c:2668
>  __do_sys_sendmsg net/socket.c:2677 [inline]
>  __se_sys_sendmsg net/socket.c:2675 [inline]
>  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2675
>  x64_sys_call+0xb25/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:4=
7
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888112d970b0 of 4 bytes by task 11 on cpu 1:
>  netif_is_bond_master include/linux/netdevice.h:5020 [inline]
>  is_upper_ndev_bond_master_filter+0x2b/0xb0 drivers/infiniband/core/roce_=
gid_mgmt.c:275
>  ib_enum_roce_netdev+0x124/0x1d0 drivers/infiniband/core/device.c:2310
>  ib_enum_all_roce_netdevs+0x8a/0x100 drivers/infiniband/core/device.c:233=
7
>  netdevice_event_work_handler+0x15b/0x3c0 drivers/infiniband/core/roce_gi=
d_mgmt.c:626
>  process_one_work kernel/workqueue.c:3248 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3329
>  worker_thread+0x526/0x720 kernel/workqueue.c:3409
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> value changed: 0x00001002 -> 0x00000202
>
> Reported-by: syzbot+113b65786d8662e21ff7@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  net/core/dev.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ea1d20676fb..3b9626cdfd9a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8799,7 +8799,7 @@ EXPORT_SYMBOL(dev_get_flags);
>  int __dev_change_flags(struct net_device *dev, unsigned int flags,
>                        struct netlink_ext_ack *extack)
>  {
> -       unsigned int old_flags =3D dev->flags;
> +       unsigned int old_flags =3D READ_ONCE(dev->flags);
>         int ret;
>
>         ASSERT_RTNL();
> @@ -8808,12 +8808,13 @@ int __dev_change_flags(struct net_device *dev, un=
signed int flags,
>          *      Set the flags on our device.
>          */
>
> -       dev->flags =3D (flags & (IFF_DEBUG | IFF_NOTRAILERS | IFF_NOARP |
> -                              IFF_DYNAMIC | IFF_MULTICAST | IFF_PORTSEL =
|
> -                              IFF_AUTOMEDIA)) |
> -                    (dev->flags & (IFF_UP | IFF_VOLATILE | IFF_PROMISC |
> -                                   IFF_ALLMULTI));
> +       unsigned int new_flags =3D (flags & (IFF_DEBUG | IFF_NOTRAILERS |=
 IFF_NOARP |
> +                                          IFF_DYNAMIC | IFF_MULTICAST | =
IFF_PORTSEL |
> +                                          IFF_AUTOMEDIA)) |
> +                                (READ_ONCE(dev->flags) & (IFF_UP | IFF_V=
OLATILE | IFF_PROMISC |
> +                                               IFF_ALLMULTI));
>
> +       WRITE_ONCE(dev->flags, new_flags);
>         /*
>          *      Load in the correct multicast list now the flags have cha=
nged.
>          */
> @@ -8839,12 +8840,12 @@ int __dev_change_flags(struct net_device *dev, un=
signed int flags,
>
>         if ((flags ^ dev->gflags) & IFF_PROMISC) {
>                 int inc =3D (flags & IFF_PROMISC) ? 1 : -1;
> -               unsigned int old_flags =3D dev->flags;
> +               unsigned int old_flags =3D READ_ONCE(dev->flags);
>
>                 dev->gflags ^=3D IFF_PROMISC;
>
>                 if (__dev_set_promiscuity(dev, inc, false) >=3D 0)
> -                       if (dev->flags !=3D old_flags)
> +                       if (READ_ONCE(dev->flags) !=3D old_flags)
>                                 dev_set_rx_mode(dev);
>         }
>

These READ_ONCE() in RTNL protected regions are not necessary, because
dev->flags can not be changed by another thread.

