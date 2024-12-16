Return-Path: <netdev+bounces-152221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337729F31F0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE162188194D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC72556E;
	Mon, 16 Dec 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7MI4yG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825811E493
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356900; cv=none; b=Ds0DbJwN+t/B2KEkNvVZr8Cr0jFh5iAbdd6rHHJfrDiGbJ+kgjJg3YJLmOBk4dAPC+IgMivERqHN1SfqacFIN030WRVaEW/d2NYtkND32NYPtYBccjeRW2cBPHZJ8wiQacslV3ePmAZE44UoLq2v8zyn1AAt0NjlW72GZrVlj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356900; c=relaxed/simple;
	bh=hYHlwJaCSwge9EjdY6hriTvg4T/5tUbXTVy9v90cfqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw6EpYIxFnuhQvuXWiF1hUCShJKIf7BTRjUGtJeW39B+x+P2IxVr0ukZEcN7FiSVa+bhc/+jPlyHui1rc7YyjOpXc6u/aKh/z90Z7CuaufnQOKs5Yd3qSTBKprwoVwoFiaa/kLD+UtqN827YdbNsh5hyFe5yh1mn7DQHkREEElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7MI4yG2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so7033716a12.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 05:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734356896; x=1734961696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZFPkydpoRbYPI4KBZeMgu+qWShZdiODSScOlDgHMSQ=;
        b=x7MI4yG2DbMpXuh7l4TnvF7mg38wf4XA5+J8PLGsmgdzfhrNEbHW40bELGb52dLCM0
         ZwzWanSbWBqGaCT4HY1S+xIBjZttjmoCXkIOOAYswNiL5TOMzhTgHd0VNZGTYgw6zpjJ
         VJIutts8zKwFOL8rS6PtqRIYCr1+nQtpYVvWmmyVQWAwbzdopA3nFFxpwJvvONZ0NRFN
         gbwwkxDNcjg/gKdIi0N2wK9LUcLHgcWm6Fk3h01l3tUlj5LdU9gbFOpOUivt4kTgm9/3
         MFuGhUJqB+GNXwMLi5DUmYCvd6gAS5mN4GOalxRmZuKXHnmn+caGSaBMYsBpyj2dyB0e
         2Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734356896; x=1734961696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZFPkydpoRbYPI4KBZeMgu+qWShZdiODSScOlDgHMSQ=;
        b=RLMEC9Ff5AK0NzRKhUOtrRH5WyRjsVzzfD5hVX9GBhiVLXdFWnqj9eSePloLMdnXlE
         Zsw3QFNJFZqAJP24txJ5BKvCka3unllkIsCsp8IjOWk8YcHAE3Io7IufIObpnrUUkGmg
         fMTkdjb5EL/9g4OCkyUpyK05Stn5DFAzeEYU5hQBByYyjcSWsS9T1j5Jt+pAAOkUMH9G
         tlrmMZa85/rB3XbFly/Z6rLTDG0pL/R5iC79BhW7Ud8Eo2AtX5y16t7ax2M+r5Q/OIjU
         WQD7JvkEgssNnCitn91MHZepTrBBeaG76oLTb9EDAAyknRm8+oIPEk6NiVkcNy8N0lVz
         T9/Q==
X-Gm-Message-State: AOJu0YyummW+uTMnNlG+UX70hnSsHY8Yp3P2OXEdB5Mspy1ANZHo0V5u
	u7p8L7HTNn0sWLjsmS3MI1Dj2IexcXAQu8ItkK5sSGz5JuuB/wk6pvaswB/gNJ5pq3+cqrPWVzl
	7KMW13AtIbqlLAj+QLR0pzz2wltXoPTJTllrh
X-Gm-Gg: ASbGncufQpE5+bhw4eFxDkoG//kFn3OV9iPUH4V7qANbxBvkDSB7sJDL5xruHGSzJZv
	f8+XMTgciMc9rex9L5/3PKHrAAd9U+HkZ1rfw5/HndKhYUYmB0wbBeiAN5O5XhFAVd7Zub0n5
X-Google-Smtp-Source: AGHT+IE9P5pwrSRgKnHAbgxK610JaXaPprsauTFj62vzvwYcZnPS4egwr7tiWOhI7EpKiEcB6btan1tr7cwp+QmidpU=
X-Received: by 2002:a05:6402:5287:b0:5d1:2377:5b07 with SMTP id
 4fb4d7f45d1cf-5d63c2f8380mr9232557a12.6.1734356895715; Mon, 16 Dec 2024
 05:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216134207.165422-1-idosch@nvidia.com>
In-Reply-To: <20241216134207.165422-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Dec 2024 14:48:04 +0100
Message-ID: <CANn89iLt9uKxzcceP=xWp5gr+VmghsZROwjHtK=878zDQ+7BpA@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: Avoid accessing uninitialized memory during xmit
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, gnault@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 2:43=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> The VXLAN driver does not verify that transmitted packets have an
> Ethernet header in the linear part of the skb, which can result in the
> driver accessing uninitialized memory while processing the Ethernet
> header [1]. Issue can be reproduced using [2].
>
> Fix by checking that we can pull the Ethernet header into the linear
> part of the skb. Note that the driver can transmit IP packets, but this
> is handled earlier in the xmit path.
>
> [1]
> CPU: 6 UID: 0 PID: 404 Comm: bpftool Tainted: G    B              6.12.0-=
rc7-custom-g10d3437464d3 #232
> Tainted: [B]=3DBAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40=
 04/01/2014
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __vxlan_find_mac+0x449/0x450
>  __vxlan_find_mac+0x449/0x450
>  vxlan_xmit+0x1265/0x2f70
>  dev_hard_start_xmit+0x239/0x7e0
>  __dev_queue_xmit+0x2d65/0x45e0
>  __bpf_redirect+0x6d2/0xf60
>  bpf_clone_redirect+0x2c7/0x450
>  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
>  bpf_test_run+0x60f/0xca0
>  bpf_prog_test_run_skb+0x115d/0x2300
>  bpf_prog_test_run+0x3b3/0x5c0
>  __sys_bpf+0x501/0xc60
>  __x64_sys_bpf+0xa8/0xf0
>  do_syscall_64+0xd9/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  __vxlan_find_mac+0x442/0x450
>  vxlan_xmit+0x1265/0x2f70
>  dev_hard_start_xmit+0x239/0x7e0
>  __dev_queue_xmit+0x2d65/0x45e0
>  __bpf_redirect+0x6d2/0xf60
>  bpf_clone_redirect+0x2c7/0x450
>  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
>  bpf_test_run+0x60f/0xca0
>  bpf_prog_test_run_skb+0x115d/0x2300
>  bpf_prog_test_run+0x3b3/0x5c0
>  __sys_bpf+0x501/0xc60
>  __x64_sys_bpf+0xa8/0xf0
>  do_syscall_64+0xd9/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  kmem_cache_alloc_node_noprof+0x4a8/0x9e0
>  kmalloc_reserve+0xd1/0x420
>  pskb_expand_head+0x1b4/0x15f0
>  skb_ensure_writable+0x2ee/0x390
>  bpf_clone_redirect+0x16a/0x450
>  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
>  bpf_test_run+0x60f/0xca0
>  bpf_prog_test_run_skb+0x115d/0x2300
>  bpf_prog_test_run+0x3b3/0x5c0
>  __sys_bpf+0x501/0xc60
>  __x64_sys_bpf+0xa8/0xf0
>  do_syscall_64+0xd9/0x1b0
>
> [2]
>  $ cat mac_repo.bpf.c
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>
>  SEC("lwt_xmit")
>  int mac_repo(struct __sk_buff *skb)
>  {
>          return bpf_clone_redirect(skb, 100, 0);
>  }
>
>  $ clang -O2 -target bpf -c mac_repo.bpf.c -o mac_repo.o
>
>  # ip link add name vx0 up index 100 type vxlan id 10010 dstport 4789 loc=
al 192.0.2.1
>
>  # bpftool prog load mac_repo.o /sys/fs/bpf/mac_repo
>
>  # echo -ne "\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41=
" | \
>         bpftool prog run pinned /sys/fs/bpf/mac_repo data_in - repeat 10
>
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6735d39a.050a0220.1324f8.0096.GAE@=
google.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> If this is accepted, I will change dev_core_stats_tx_dropped_inc() to
> dev_dstats_tx_dropped() in net-next.
> ---
>  drivers/net/vxlan/vxlan_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_cor=
e.c
> index 9ea63059d52d..4cbde7a88205 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2722,6 +2722,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, =
struct net_device *dev)
>         struct vxlan_dev *vxlan =3D netdev_priv(dev);
>         struct vxlan_rdst *rdst, *fdst =3D NULL;
>         const struct ip_tunnel_info *info;
> +       enum skb_drop_reason reason;
>         struct vxlan_fdb *f;
>         struct ethhdr *eth;
>         __be32 vni =3D 0;
> @@ -2746,6 +2747,15 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>                 }
>         }
>
> +       reason =3D pskb_may_pull_reason(skb, ETH_HLEN);
> +       if (unlikely(reason !=3D SKB_NOT_DROPPED_YET)) {
> +               dev_core_stats_tx_dropped_inc(dev);
> +               vxlan_vnifilter_count(vxlan, vni, NULL,
> +                                     VXLAN_VNI_STATS_TX_DROPS, 0);
> +               kfree_skb_reason(skb, reason);
> +               return NETDEV_TX_OK;
> +       }

I think the plan was to use dev->min_header_len, in the generic part
of networking stack,
instead of having to copy/paste this code in all drivers.

