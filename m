Return-Path: <netdev+bounces-173089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE55A57234
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08580179D53
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43B25487A;
	Fri,  7 Mar 2025 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stPffzks"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2F1A3035
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376407; cv=none; b=r6ZhVpS5lkmXGtD2UzScl9WDOyNXAHgImLa18RRUmZ8Qebnn6dqsgwno5snEPZFqKKqSGM1pcAVdQZpEaWcc4k3exn26ZzzLOOe10FAAWsSiizpKZL4cJRDczE8kuZ6ZjhEO5Lu7bO+7S5nmFJXzzKtTek+tLsNFKyqZM7o7cG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376407; c=relaxed/simple;
	bh=oyRMjAqGnfQQHmLgjV78x/4R3peXUKoay360NwNzYfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKLN/t0vjWqhehEXTN+f+muNcvtfx9JnylMO6Acxcta5oEFL5aIgJUCzqOJxE40rDE5JuGEV83x6t14LzMJOoMsUSAu64lMCaFR2xRdu9F8zQMMnl6nMXX+HpRsFE4+nrs4voH6xld2KPZVZLbPkIiCc34R6AbyVqBhPtt/36tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stPffzks; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c3c9f7b1a6so218116185a.1
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741376404; x=1741981204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMJaSvLeeirPf/s58yRLtR6M+vJYyaJur+fzyjrXM2U=;
        b=stPffzksdoNpwHc3we9muxyOOqOrt+0Jyw6f/b1S3+4ODuGCXN0ycP3vAEAkwVh9lX
         y9V6U6HU3nMlhWa/8qN1cRYLUvw8uO+f9Kmq8jXcJ6xLtq37abdyJlGDOLlX19AJjjjK
         1Tjpxjb0HtBikICcJhQ1aB6L09KSIT0vnA1ru68uwFHI1QF/ulc0WR+kPJVGjtBE29w5
         WMoE4ar4IQ5CY3JUXwG9Oo2cnq+cUEpU9ZHQIWlZfa1Wi5DZ75Hh27zzaeFHNWnMC+n0
         8jANkE0F7mTb8PqAXPwMHCE2BiTHArjzz6JVB1ttuOlyBsZfAnPTijMJpvxBL/tR3PJv
         yLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376404; x=1741981204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMJaSvLeeirPf/s58yRLtR6M+vJYyaJur+fzyjrXM2U=;
        b=PeQlPIoEiAwosZEyYHMOsCpRnj5bKduriy3BCIMzCGAPypcrjGuJuJYTNYDLB3Yg5Y
         N2zdbe2+5pAi9g3sdpXQrUqmx08pyIT5ESAI76WbIq1L23Tx9k6kgWTj4xaH9A8ndib5
         ji4U/I6X1aGk0wRkKVGoH6bp2ps8YNMVqDcXr09/dWPhkemhKskfcLkSMYy0410Rcz0V
         ZWehT1nCv6+ZdXptdqlmY/A9vK61lQMItLarIUilbz9On8VW0Tcf7hkTcSr1oFPPbqIY
         uRHzKCWKgWHmfepVAy6UplDAmUGa4hWrK5/k/GzKAW4+wkRnvhszU7Uq3xBSjNXhuxsn
         DmyA==
X-Gm-Message-State: AOJu0Yx8/mRXFKFJcVKwSsD2VRm5ZKnp7Pz+FHewq0iR7zpqloBUSyHT
	MayW757g8vyObDET5o6GkkpBcM//SId7x+aSU32R7JdAgdFjMhnFW5lcD2r7FOc64KMriu3CHc2
	3200UrDHkNg+vx0Nb2nhPzFrFEpIGsbxV8i3t
X-Gm-Gg: ASbGncsnNDynnRdlnJkeGOXOxGJmXGGfQjNoapMXKY6X9uMlV0azJDrrDpvLHbVGpzX
	c/mDW1fPGgzQukqJc2fZu20gsJGEExt8oto5b0VRwyuvW2N96pGeCPUK/aIew0gp5xTYMhA/Z2L
	W9rQt9FqXG1r/1FBS5JV6ZR4qfweM=
X-Google-Smtp-Source: AGHT+IE9PWhHB/UGbrg+mOKX/PMS2ThEvK4aTWPU5vvRv6A/EIys1lPC14D7fdJ8fcsTZ4R4RcwaGlW6XHLzJHjkluQ=
X-Received: by 2002:a05:620a:2602:b0:7c0:b018:5934 with SMTP id
 af79cd13be357-7c53c8d9211mr98616385a.27.1741376404299; Fri, 07 Mar 2025
 11:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305163732.2766420-1-sdf@fomichev.me> <20250305163732.2766420-3-sdf@fomichev.me>
In-Reply-To: <20250305163732.2766420-3-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Mar 2025 20:39:53 +0100
X-Gm-Features: AQ5f1JrIATmH567IbjVVYL1ZwPo1bnHykRjZCQobzjsXzbFFR_szQbIgdN0rihs
Message-ID: <CANn89iJemkvpsQ6LgefYvBBC_foXr=1wrwf7QN25wpX-2QZPiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: hold netdev instance lock during
 nft ndo_setup_tc
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:37=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> Introduce new dev_setup_tc for nft ndo_setup_tc paths.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c |  2 --
>  include/linux/netdevice.h                   |  2 ++
>  net/core/dev.c                              | 18 ++++++++++++++++++
>  net/netfilter/nf_flow_table_offload.c       |  2 +-
>  net/netfilter/nf_tables_offload.c           |  2 +-
>  5 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index 9f4d223dffcf..032e1a58af6f 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3894,10 +3894,8 @@ static int __iavf_setup_tc(struct net_device *netd=
ev, void *type_data)
>         if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
>                 return 0;
>
> -       netdev_lock(netdev);
>         netif_set_real_num_rx_queues(netdev, total_qps);
>         netif_set_real_num_tx_queues(netdev, total_qps);
> -       netdev_unlock(netdev);
>
>         return ret;
>  }
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 33066b155c84..69951eeb96d2 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3353,6 +3353,8 @@ int dev_alloc_name(struct net_device *dev, const ch=
ar *name);
>  int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
>  void dev_close(struct net_device *dev);
>  void dev_close_many(struct list_head *head, bool unlink);
> +int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +                void *type_data);
>  void dev_disable_lro(struct net_device *dev);
>  int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *=
newskb);
>  u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7a327c782ea4..57af25683ea1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1786,6 +1786,24 @@ void dev_close(struct net_device *dev)
>  }
>  EXPORT_SYMBOL(dev_close);
>
> +int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +                void *type_data)
> +{
> +       const struct net_device_ops *ops =3D dev->netdev_ops;
> +       int ret;
> +
> +       ASSERT_RTNL();
> +
> +       if (!ops->ndo_setup_tc)
> +               return -EOPNOTSUPP;
> +
> +       netdev_lock_ops(dev);
> +       ret =3D ops->ndo_setup_tc(dev, type, type_data);
> +       netdev_unlock_ops(dev);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(dev_setup_tc);
>
>  /**
>   *     dev_disable_lro - disable Large Receive Offload on a device
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flo=
w_table_offload.c
> index e06bc36f49fe..0ec4abded10d 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -1175,7 +1175,7 @@ static int nf_flow_table_offload_cmd(struct flow_bl=
ock_offload *bo,
>         nf_flow_table_block_offload_init(bo, dev_net(dev), cmd, flowtable=
,
>                                          extack);
>         down_write(&flowtable->flow_block_lock);
> -       err =3D dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
> +       err =3D dev_setup_tc(dev, TC_SETUP_FT, bo);
>         up_write(&flowtable->flow_block_lock);
>         if (err < 0)
>                 return err;
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_=
offload.c
> index 64675f1c7f29..b761899c143c 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -390,7 +390,7 @@ static int nft_block_offload_cmd(struct nft_base_chai=
n *chain,
>
>         nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extac=
k);
>
> -       err =3D dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
> +       err =3D dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
>         if (err < 0)
>                 return err;
>

It seems RTNL was not taken in this path, can you take a look ?

syzbot reported :

RTNL: assertion failed at net/core/dev.c (1769)
WARNING: CPU: 1 PID: 9148 at net/core/dev.c:1769
dev_setup_tc+0x315/0x360 net/core/dev.c:1769
Modules linked in:
CPU: 1 UID: 0 PID: 9148 Comm: syz.3.1494 Not tainted
6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 02/12/2025
RIP: 0010:dev_setup_tc+0x315/0x360 net/core/dev.c:1769
Code: cc 49 89 ee e8 dc da f7 f7 c6 05 c0 39 5d 06 01 90 48 c7 c7 a0
5e 2e 8d 48 c7 c6 80 5e 2e 8d ba e9 06 00 00 e8 3c 97 b7 f7 90 <0f> 0b
90 90 e9 66 fd ff ff 89 d1 80 e1 07 38 c1 0f 8c aa fd ff ff
RSP: 0018:ffffc9000be3eed0 EFLAGS: 00010246
RAX: eea924c6092c5700 RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9000c979000 RSI: 000000000000491b RDI: 000000000000491c
RBP: ffff88802a810008 R08: ffffffff81818e32 R09: fffffbfff1d3a67c
R10: dffffc0000000000 R11: fffffbfff1d3a67c R12: ffffc9000be3f070
R13: ffffffff8d4ab1e0 R14: ffff88802a810008 R15: ffff88802a810000
FS: 00007fbe7aece6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2b5042 CR3: 0000000024cd0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
nf_flow_table_offload_cmd net/netfilter/nf_flow_table_offload.c:1178 [inlin=
e]
nf_flow_table_offload_setup+0x2ff/0x710
net/netfilter/nf_flow_table_offload.c:1198
nft_register_flowtable_net_hooks+0x24c/0x570 net/netfilter/nf_tables_api.c:=
8918
nf_tables_newflowtable+0x19f4/0x23d0 net/netfilter/nf_tables_api.c:9139
nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
nfnetlink_rcv+0x14e3/0x2ab0 net/netfilter/nfnetlink.c:665
netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
sock_sendmsg_nosec net/socket.c:709 [inline]
__sock_sendmsg+0x221/0x270 net/socket.c:724
____sys_sendmsg+0x53a/0x860 net/socket.c:2564
___sys_sendmsg net/socket.c:2618 [inline]
__sys_sendmsg+0x269/0x350 net/socket.c:2650
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbe79f8d169

