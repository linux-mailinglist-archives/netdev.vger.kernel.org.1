Return-Path: <netdev+bounces-160600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EFBA1A7AD
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D693A121E
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB911CAA75;
	Thu, 23 Jan 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv5lsdOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476513A8D0
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648970; cv=none; b=cbHBkP80F5yjB2G6AdNPxa6ST50/Qz9p5jM7xkRbFBlKkRzHwcpZgjxlj0chY2jQVJtSiStw3Z9NYC2UlQE1KrzvJBYBnQ83bYj0Fz+PL7NBGqKJ9wH/fst9k/RKeVpn0iqyYQ6IYwkWMkc+LCOJ9g/I+4RBTn5Tp6xeCpQ0864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648970; c=relaxed/simple;
	bh=rHA1gBgGHNWxOYd+ew+Kwh5kkZ4/xnOnt1lli/vyNnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvOwcgogGGGnNKUPjQetpqis58/IcZytuuoSXEkQ5AF+vlqpLnBK16atNjmpfFhW+lHpRKSBk3ZcCODkFZ8MwyKHbPpe+EA9zNkfhNZXqhVXrsBYTWYBro3WeHyuVYwidK0swo4Qd8APGU362OvO4FEQfeb7U3zFSNhzCs7Bolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv5lsdOl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso2250247a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737648966; x=1738253766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TkkbZ2st1pK7HRL+QRfJcLUwFj6tv3jpIdUOFAOdAs=;
        b=Xv5lsdOl/DAt790KbINhAXNdyXXZrkU4YtjeoX9sNXHobFHu9B5hq/MbElhOyLX751
         lK8pnwHahN4hM1S5dC0wRanRcP4/kvv4D+aDw1i99D5eklLYs/a0buc0bSD6FOqhCfpK
         0Jk3/3uWkugbTtcJfmmEcQLJHG+Tq5kiBAl++qjCbpD67QgN7b1No9tY5sMQocA1olzc
         hTTNLvNrK3RQbAhzYfEk3Qes/ImYw3VB2gS2QMit7oocVLGLfLiZJywhHavjpFJs4sR5
         4Mwl0PSjp/OefXqJagT0oflC+7yGRuoFx6ocmDlC8cr2bS/xWU4KB8/1cdNG+/4QbL/9
         WlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648966; x=1738253766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TkkbZ2st1pK7HRL+QRfJcLUwFj6tv3jpIdUOFAOdAs=;
        b=XUb/ACJxs4P3szKa/tARD9FdtZw2+Ojqj1b/rUr1q/DjbS9h1SHT/XqgxW7apdMGvF
         Miw96gcRi93uc5UDF3rBr7k4v8fIWXadqMPVCWz1vrROhkFaUjAg3KbRxOHsNbQpurQp
         XBDxQ+sjWrH+B4xaOt1FfQOt5oyxWevC0xzLEZbfG1PifkzkSXO4CYAvI8Y0d0zxGbny
         hXLAoDvJy4OS8/lN1hp326AzEgifKBNCYkwZQ6fiIMM+zQNM3exhJxb/em+uBTqEftel
         OU48926IXdgUUas+SGuEStNuP2gzDZW1nS8HH7t6h4reKUOjqOg2QuGur1sRNYdMBUH6
         Cc2A==
X-Forwarded-Encrypted: i=1; AJvYcCXvBJ9Kwl6wuq5knOTTnXqlX9Mru+DfV80xzfaNVO2vADIpA5QA+9pNTViqDrI2uNCEPLO6bsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrKoB4VzYUU0u8ILcQ5t7G9DC5QuGjTIfDonKDRHWuSUJAsSyR
	eVB14ZpI1LuIg0QPvxChqrIGBPzuKO0JW2XuXSpGOczzPU24tGO7/qiGxrnEyx5ALNXlHs0EcK4
	1CFteREUTVmP2KVDlCURf7+PC2XkGGnJOusKG
X-Gm-Gg: ASbGncvuQJipQ7CzG3SwOvoll9vNuwWv/q0pNj9cK7zDi5M5OKTUJUnR+XSDUnIJvse
	APhhmlrUHF2PyKE4DbiAbP0SJYzWwEtfD8rcsngkd3zbO5Lm5/VJwHmAoGxmxPCY=
X-Google-Smtp-Source: AGHT+IHqVZqDzm5NxiDsbJgB2Q+66ZRaCbyUg6uy9mcmVEj9xE2GGdrv6Ovb759wBwv8E2/S1E7JYya9z+A5vSJWVn8=
X-Received: by 2002:a05:6402:5188:b0:5db:67a7:e74e with SMTP id
 4fb4d7f45d1cf-5db7d2f9de2mr26758223a12.13.1737648966375; Thu, 23 Jan 2025
 08:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119020518.1962249-1-kuba@kernel.org> <20250119020518.1962249-6-kuba@kernel.org>
In-Reply-To: <20250119020518.1962249-6-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jan 2025 17:15:55 +0100
X-Gm-Features: AWEUYZmU6nGSWakSf47vxZT3KflVDW8MvER14WdBiGkRHi9q7XV7TEigrJCVWtc
Message-ID: <CANn89i+a_DfERsqHbi6Uu9uzCsN+wKh7WXr6Xh957Cs86ThS9A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: ethtool: populate the default HDS
 params in the core
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 19, 2025 at 3:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The core has the current HDS config, it can pre-populate the values
> for the drivers. While at it, remove the zero-setting in netdevsim.
> Zero are the default values since the config is zalloc'ed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 1 -
>  drivers/net/netdevsim/ethtool.c                   | 5 -----
>  net/ethtool/rings.c                               | 4 ++++
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 0a6d47d4d66b..9c5820839514 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -835,7 +835,6 @@ static void bnxt_get_ringparam(struct net_device *dev=
,
>         ering->rx_jumbo_pending =3D bp->rx_agg_ring_size;
>         ering->tx_pending =3D bp->tx_ring_size;
>
> -       kernel_ering->hds_thresh =3D dev->cfg->hds_thresh;
>         kernel_ering->hds_thresh_max =3D BNXT_HDS_THRESHOLD_MAX;
>  }
>
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/etht=
ool.c
> index 189793debdb7..3b23f3d3ca2b 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -72,8 +72,6 @@ static void nsim_get_ringparam(struct net_device *dev,
>         struct netdevsim *ns =3D netdev_priv(dev);
>
>         memcpy(ring, &ns->ethtool.ring, sizeof(ns->ethtool.ring));
> -       kernel_ring->tcp_data_split =3D dev->cfg->hds_config;
> -       kernel_ring->hds_thresh =3D dev->cfg->hds_thresh;
>         kernel_ring->hds_thresh_max =3D NSIM_HDS_THRESHOLD_MAX;
>
>         if (kernel_ring->tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_UNK=
NOWN)
> @@ -190,9 +188,6 @@ static void nsim_ethtool_ring_init(struct netdevsim *=
ns)
>         ns->ethtool.ring.rx_jumbo_max_pending =3D 4096;
>         ns->ethtool.ring.rx_mini_max_pending =3D 4096;
>         ns->ethtool.ring.tx_max_pending =3D 4096;
> -
> -       ns->netdev->cfg->hds_config =3D ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
> -       ns->netdev->cfg->hds_thresh =3D 0;
>  }
>
>  void nsim_ethtool_init(struct netdevsim *ns)
> diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> index 5e8ba81fbb3e..7839bfd1ac6a 100644
> --- a/net/ethtool/rings.c
> +++ b/net/ethtool/rings.c
> @@ -39,6 +39,10 @@ static int rings_prepare_data(const struct ethnl_req_i=
nfo *req_base,
>         ret =3D ethnl_ops_begin(dev);
>         if (ret < 0)
>                 return ret;
> +
> +       data->kernel_ringparam.tcp_data_split =3D dev->cfg->hds_config;
> +       data->kernel_ringparam.hds_thresh =3D dev->cfg->hds_thresh;
> +
>         dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
>                                         &data->kernel_ringparam, info->ex=
tack);
>         ethnl_ops_complete(dev);
> --
> 2.48.1

This patch makes syzbot unhappy [1]

I am unsure how to fix this, should all callers to
dev->ethtool_ops->get_ringparam()
have to populate  tcp_data_split and hds_thresh from dev->cfg,
or would the following fix be enough ?

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7bb94875a7ec87b3e2d882cb5df2416b9fad9d9..70461ff5c54cb787c2047ac4d67c=
6b0305db2b6
100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2060,7 +2060,7 @@ static int ethtool_get_ringparam(struct
net_device *dev, void __user *useraddr)
 static int ethtool_set_ringparam(struct net_device *dev, void __user *user=
addr)
 {
        struct ethtool_ringparam ringparam, max =3D { .cmd =3D ETHTOOL_GRIN=
GPARAM };
-       struct kernel_ethtool_ringparam kernel_ringparam;
+       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
        int ret;

        if (!dev->ethtool_ops->set_ringparam ||
!dev->ethtool_ops->get_ringparam)

[1]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
BUG: KMSAN: uninit-value in nsim_get_ringparam+0xa8/0xe0
drivers/net/netdevsim/ethtool.c:77
nsim_get_ringparam+0xa8/0xe0 drivers/net/netdevsim/ethtool.c:77
ethtool_set_ringparam+0x268/0x570 net/ethtool/ioctl.c:2072
__dev_ethtool net/ethtool/ioctl.c:3209 [inline]
dev_ethtool+0x126d/0x2a40 net/ethtool/ioctl.c:3398
dev_ioctl+0xb0e/0x1280 net/core/dev_ioctl.c:759
sock_do_ioctl+0x28c/0x540 net/socket.c:1208
sock_ioctl+0x721/0xd70 net/socket.c:1313
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:906 [inline]
__se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
__x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable kernel_ringparam created at:
ethtool_set_ringparam+0x96/0x570 net/ethtool/ioctl.c:2063
__dev_ethtool net/ethtool/ioctl.c:3209 [inline]
dev_ethtool+0x126d/0x2a40 net/ethtool/ioctl.c:3398

CPU: 0 UID: 0 PID: 5807 Comm: syz-executor164 Not tainted
6.13.0-syzkaller-04788-g7004a2e46d16 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 12/27/2024

