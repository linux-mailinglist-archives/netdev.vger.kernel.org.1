Return-Path: <netdev+bounces-201626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C5AEA243
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019201C63E69
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA752ECEA0;
	Thu, 26 Jun 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUD15pWr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04D2E5424
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949668; cv=none; b=Mem39360secJYmTE4roYVF1n4G0ZisVKZUVkyvfuC9ST4GWZQSIyKuAHuT9t6lcy6FEL29NCHE7eDiW6Gu2MIAqflbY/5qIOHV9KdqspZh/siErR1fOgK7AomlCQMjNJjmSDybjA+19zSfCv6DrdnbsWR+HObuQd6trTH6YsODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949668; c=relaxed/simple;
	bh=TR+qOVHT7CUrZOrLKoJKB9yz28SXXdZI3wP8VgE5Mn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6tTcneynYywc1gyHEUgejTcGeeaNptapgn/LU2P7TRRZoBWfJtGVJ1rfrteyfKGGydsinZ/HRKEeKbUTpI+Az3/jhOpWOulfR2qEBzY4OuoAMlqFQ5g1U84qKOAzpbG/Ezc60n7z8ORXrdgufo4Gay+qhdZXH7L0m5tNmiDaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUD15pWr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d094ef02e5so250055585a.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750949666; x=1751554466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/BJrhWkBcxOGYc37cgcwv8UoSF7ehbENcfA/PhhCgQ=;
        b=jUD15pWrHtX80nCZBSwaP8zxoy0TMg9cHIM+nM0SWZMH5QaNn4uy7Dt4SwlEcEzXYB
         hIg/H2mOfy87whvki0SmZZST2fFBrvX9UWcDP67coxDImMonyQF6sNQYD0n/3mcKRaMC
         vK7kr5u+z/iYjp3HAX0w4uM/UgjKdGSrMeQIojyYn7pDt1uKuix734jrphGaWbXHsG0K
         CmHlGSvcAJkOyBAZ48r3H4ItON5oolhd0j5OmXGNO6ddm/sTacfSa+QCBpfOr8+/z0zC
         EgBCim5+VduU1BJ0uosqDs/ST4/gnZgrrWgNXtWu1dtSIVhKg34FwJ2+qkHX0NKCg549
         +SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949666; x=1751554466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/BJrhWkBcxOGYc37cgcwv8UoSF7ehbENcfA/PhhCgQ=;
        b=jdlUVIcsZ0EeljmrslHYcee7qxIlUtZfn9LPLydSSjmugcUwgPGILQxZkwiExAOzWI
         uJrsnTGhMys0c1nFzWozpHwBjpO1jMGA10WWUq1RVI0F1hv9/QiWRgRpJkb9sTGPV5HM
         oOBmDHiLlTqfN6tdTW1egpTAxVyShmH0+Fn/bKQtNupL/m/8L318iA4807xEoEI8c4Lv
         p5ZRP4dh9O9oVfGn9CyorrvvEEWW3urffD0PQSSoYzfRrV+UQb8rf02GqTA3DaDp2bEx
         r9flmCVysaIKj5Ee40l/lqsuDpAIMIdvpzRTGH57dACLcC0DaFxH7roeU/SCC6qKhEtC
         /7PA==
X-Forwarded-Encrypted: i=1; AJvYcCXbvCCAAanKECbdvCIA9ear8WfBelgzdUXcGJeo9v3tFVCXA2ogrXJhyo7PlH39JxCtfaxrOWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDG5dPm9xRHXI440SMgUZ3Trc7bPxpbps5YjUIswHvFi5+AgI
	FGMKcxNhAzkhb8FPlDTK1Jx+iwz+kP/aegIpNGl3ZUu5VPhvp3640qfx7AXg0ZjNBR2cpmJGZsm
	OMfmxndaIgsO66YP8w7n0dUdozh3Zz3AJsl76peeU
X-Gm-Gg: ASbGncvjV4WAGv5YIFYOzT9oLaIbl4CU78awhXUPSEKtj4EZYWEuQ3Em/4pJXSCIxte
	p1mQn2sJX7fVEvdwkCgah8ipHAxgYLz52bsxgFeRvx9W1621xD4Ri+cZHMZj3qcnxQiCuYZ5om7
	6+8zChHJYX+dFMETocFakoysrdo7I+elepNT09ejdB+YM=
X-Google-Smtp-Source: AGHT+IFJY4K7R2svweRHUXF859nnrizO5ZRn2sZRz2XpDeCTT77/Ew5KVB+MaPtRDkoI8zHo/87GNUQkbp0y1cpyGz4=
X-Received: by 2002:a05:622a:5805:b0:4a7:937:4620 with SMTP id
 d75a77b69052e-4a7f2db5efbmr62577131cf.1.1750949665408; Thu, 26 Jun 2025
 07:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-15-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-15-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:54:14 -0700
X-Gm-Features: Ac12FXyc1MV2OdwzKij04cnOdg_PwXjQJyqk-OXGHn6fz7JTzb3Da_ONnyhj-hY
Message-ID: <CANn89iJvxPyYprrUjdD3JOkU-nEcEwmMDiSF0izXHkfi5MLYyw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 14/15] ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> inet6_sk(sk)->ipv6_ac_list is protected by lock_sock().
>
> In ipv6_sock_ac_join(), only __dev_get_by_index(), __dev_get_by_flags(),
> and __in6_dev_get() require RTNL.
>
> __dev_get_by_flags() is only used by ipv6_sock_ac_join() and can be
> converted to RCU version.
>
> Let's replace RCU version helper and drop RTNL from IPV6_JOIN_ANYCAST.
>
> setsockopt_needs_rtnl() will be removed in the next patch.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Hold rcu_read_lock() around rt6_lookup & dev_hold()
> ---
>  include/linux/netdevice.h |  4 ++--
>  net/core/dev.c            | 38 ++++++++++++++++++--------------------
>  net/ipv6/anycast.c        | 20 +++++++++++++-------
>  net/ipv6/ipv6_sockglue.c  |  4 ----
>  4 files changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 03c26bb0fbbe..68f874a58c92 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3339,8 +3339,8 @@ int dev_get_iflink(const struct net_device *dev);
>  int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
>  int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>                           struct net_device_path_stack *stack);
> -struct net_device *__dev_get_by_flags(struct net *net, unsigned short fl=
ags,
> -                                     unsigned short mask);
> +struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short =
flags,
> +                                       unsigned short mask);
>  struct net_device *dev_get_by_name(struct net *net, const char *name);
>  struct net_device *dev_get_by_name_rcu(struct net *net, const char *name=
);
>  struct net_device *__dev_get_by_name(struct net *net, const char *name);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 7ee808eb068e..553c654e6f77 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1267,33 +1267,31 @@ struct net_device *dev_getfirstbyhwtype(struct ne=
t *net, unsigned short type)
>  EXPORT_SYMBOL(dev_getfirstbyhwtype);
>
>  /**
> - *     __dev_get_by_flags - find any device with given flags
> - *     @net: the applicable net namespace
> - *     @if_flags: IFF_* values
> - *     @mask: bitmask of bits in if_flags to check
> + * dev_get_by_flags_rcu - find any device with given flags
> + * @net: the applicable net namespace
> + * @if_flags: IFF_* values
> + * @mask: bitmask of bits in if_flags to check
>   *
> - *     Search for any interface with the given flags. Returns NULL if a =
device
> - *     is not found or a pointer to the device. Must be called inside
> - *     rtnl_lock(), and result refcount is unchanged.
> + * Search for any interface with the given flags.
> + *
> + * Context: rcu_read_lock() must be held.
> + * Returns: NULL if a device is not found or a pointer to the device.
>   */
> -
> -struct net_device *__dev_get_by_flags(struct net *net, unsigned short if=
_flags,
> -                                     unsigned short mask)
> +struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short =
if_flags,
> +                                       unsigned short mask)
>  {
> -       struct net_device *dev, *ret;
> -
> -       ASSERT_RTNL();
> +       struct net_device *dev;
>
> -       ret =3D NULL;
> -       for_each_netdev(net, dev) {
> -               if (((dev->flags ^ if_flags) & mask) =3D=3D 0) {
> -                       ret =3D dev;
> -                       break;
> +       for_each_netdev_rcu(net, dev) {
> +               if (((READ_ONCE(dev->flags) ^ if_flags) & mask) =3D=3D 0)=
 {
> +                       dev_hold(dev);
> +                       return dev;
>                 }
>         }
> -       return ret;
> +
> +       return NULL;
>  }
> -EXPORT_SYMBOL(__dev_get_by_flags);
> +EXPORT_IPV6_MOD(dev_get_by_flags_rcu);
>
>  /**
>   *     dev_valid_name - check if name is okay for network device
> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
> index e0a1f9d7622c..427fa95018b7 100644
> --- a/net/ipv6/anycast.c
> +++ b/net/ipv6/anycast.c
> @@ -73,15 +73,13 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, c=
onst struct in6_addr *addr)
>         struct inet6_dev *idev;
>         int err =3D 0, ishost;
>
> -       ASSERT_RTNL();
> -
>         if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>                 return -EPERM;
>         if (ipv6_addr_is_multicast(addr))
>                 return -EINVAL;
>
>         if (ifindex)
> -               dev =3D __dev_get_by_index(net, ifindex);
> +               dev =3D dev_get_by_index(net, ifindex);
>
>         if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTAT=
IVE)) {
>                 err =3D -EINVAL;
> @@ -102,18 +100,22 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex,=
 const struct in6_addr *addr)
>         if (ifindex =3D=3D 0) {
>                 struct rt6_info *rt;
>
> +               rcu_read_lock();
>                 rt =3D rt6_lookup(net, addr, NULL, 0, NULL, 0);
>                 if (rt) {
>                         dev =3D rt->dst.dev;

READ_ONCE(rt->dst.dev)

Reviewed-by: Eric Dumazet <edumazet@google.com>

> +                       dev_hold(dev);
>                         ip6_rt_put(rt);
>                 } else if (ishost) {
> +                       rcu_read_unlock();
>                         err =3D -EADDRNOTAVAIL;
>                         goto error;
>                 } else {
>                         /* router, no matching interface: just pick one *=
/
> -                       dev =3D __dev_get_by_flags(net, IFF_UP,
> -                                                IFF_UP | IFF_LOOPBACK);
> +                       dev =3D dev_get_by_flags_rcu(net, IFF_UP,
> +                                                  IFF_UP | IFF_LOOPBACK)=
;
>                 }
> +               rcu_read_unlock();
>         }
>
>         if (!dev) {
> @@ -121,7 +123,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, c=
onst struct in6_addr *addr)
>                 goto error;
>         }
>
> -       idev =3D __in6_dev_get(dev);
> +       idev =3D in6_dev_get(dev);
>         if (!idev) {
>                 if (ifindex)
>                         err =3D -ENODEV;
> @@ -143,7 +145,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, c=
onst struct in6_addr *addr)
>                 if (ishost)
>                         err =3D -EADDRNOTAVAIL;
>                 if (err)
> -                       goto error;
> +                       goto error_idev;
>         }
>
>         err =3D __ipv6_dev_ac_inc(idev, addr);
> @@ -153,7 +155,11 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, =
const struct in6_addr *addr)
>                 pac =3D NULL;
>         }
>
> +error_idev:
> +       in6_dev_put(idev);
>  error:
> +       dev_put(dev);
> +
>         if (pac)
>                 sock_kfree_s(sk, pac, sizeof(*pac));
>         return err;
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 3d891aa6e7f5..702dc33e50ad 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -119,10 +119,6 @@ struct ipv6_txoptions *ipv6_update_options(struct so=
ck *sk,
>
>  static bool setsockopt_needs_rtnl(int optname)
>  {
> -       switch (optname) {
> -       case IPV6_JOIN_ANYCAST:
> -               return true;
> -       }
>         return false;
>  }
>
> --
> 2.49.0
>

