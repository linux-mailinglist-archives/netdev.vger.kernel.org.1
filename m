Return-Path: <netdev+bounces-161723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD6A23928
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 05:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BEE7A3444
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE92383A2;
	Fri, 31 Jan 2025 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQ8d96aL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB310E0
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738298043; cv=none; b=SIAugs2HQRiZEDAiMuTEiSDQ2H5S8fpQIu52I6DFZeWNAgvTXsyhaLFm7s6F4Yj8PoSnVPTJLRfAKNxYjndNhY4AINR4M0yuIjcypage3WWaQoj8mbEXhpy32ymQwyxJPNj7Ky6yBfkkVnM2HHvxgLHNCjRgSJHjbfoJFAqhIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738298043; c=relaxed/simple;
	bh=yDwkwaZQGviDgApLsk4GaCtYY0ivYgn87mWmA+4Tqvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMxa1ni/zTpLcwBe+5DV2UU9GIYLFinpGjnk9/uKcNbF418xEv0BN+35n82iTb3O2vxlPktaVi44da4RKceTxP+T/YgrRhsYma7CSOMxxJR3w+CiEbNR+q1pstGtN/NECoVDIp7lUwSUWy7JHCN1lkVeMilYjlZGK0pOQznj7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQ8d96aL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso2804917a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738298040; x=1738902840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5syUaHV4x/XSDGLVnMjJTwItKaCBRRSmRp99SCOjEc=;
        b=yQ8d96aLB9Fqf3I5spdEe1nfY5ctTuiOt9fU8pN/QGiZ8WhWfJDS7JIlLoBVlR56tg
         DY9TgQTSQFijFasfJJGjNmIIeZOsWZq9P3SF5a7OMZVtIeLVi3GZcM1LtjBg0dk+RZjk
         PrVMWb/pUimABCLoiGCXAT0uBjF+zjupp9oZgsdYYAzoB0btiK1od+zMCJrZZ7YEXtcm
         o84BYDLJ0T+lFDI70cGdvgjhV7eYk7dvR90w0+/bIV15dI6XlQQV6uVfe6lWMRCnzB/E
         R1ray9yy9uM5UPRKkX7PIv4yJFs4O4eEFflXczKx599W8NBJJEO6qpEeEYaGv+lSq9x3
         jFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738298040; x=1738902840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5syUaHV4x/XSDGLVnMjJTwItKaCBRRSmRp99SCOjEc=;
        b=a7YbLQsYHrQV8begbft7gwSdchI5j2MtWl2yQgfa4CVltnP0mtQV4l3ay0t5icQtY8
         Fiejy7d9xN5j1q3Q+lNwiYZHEDy6xsCjvv+HH1pP53KlVTOdFgB4LFnIj9zxhYFVuq3g
         6AbFEgscqXaN3xi3I+WzrqZV7jLQeKOwRa8sGBh3PUtbJxCzShF1KRycumOtbFFiE4Kq
         PScdkqBlwUqk4Zs6tJHNCx/h9b6B1w5Do7oz4zwnrnPpm7kwHHQP5KltKj4qsxslz90L
         3+v/QU/UUmHiDT1a7bweDUnnaBH5ALR97ih23P1+beKDJ6UjcCzRGVUWdVScSEX9SHvV
         FJzw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Vd0TO5OveZavUPVpCzKQJTSn2MFvlygHCXAobJO+i6ep2TZ3Zq88bmKgcamGQen0TTJsg0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzPqF/vWUbt4HQsasEqbgbr7f+Mf7g90l/czxvEhBipz8fGrd
	aryYYxScLxrej161R5HU0QeItkgiMbUniNjjbydXl8YItqE5o2Pk6r5oLDw6JLtjicwOV8KWiFa
	QLiWKHo6JN1lMmYtEV4YLe62bFUAZ0ndqFLql
X-Gm-Gg: ASbGnctm+WZ4xFU+3gb+qOdTDayQTn8p3u06PyXtW3PUQu6LTwcU2+Bf3KDSkqQIlSo
	ibpgAPAr8eU4THRnAg9KSrXZXTwaqYga0fwyn9vRUqVsnMzyeXPSXclDoAZV7XdGYRiFNe/Tfvg
	==
X-Google-Smtp-Source: AGHT+IFe5Baw6rQkNst9mbZkh925IA3q2EU/lxrNXamrrc7UmgdpagSKW3j04AUJJFrK5/EbrjGsYMuNUlIuXmM9Ygo=
X-Received: by 2002:a05:6402:4306:b0:5dc:eb2:570d with SMTP id
 4fb4d7f45d1cf-5dc6f498d60mr5954354a12.2.1738298040275; Thu, 30 Jan 2025
 20:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130232435.43622-1-kuniyu@amazon.com> <20250130232435.43622-2-kuniyu@amazon.com>
In-Reply-To: <20250130232435.43622-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 05:33:49 +0100
X-Gm-Features: AWEUYZl7IST8H-cIpmvgHZLk69iICoYDHSTJ8EiPgjs5jq9zk21B0LSqveURUPU
Message-ID: <CANn89iJzav0za=tJq7MvXpEXYNFY_+1D6==w2jbKd0-0mhKO4g@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Yael Chemla <ychemla@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:25=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> After the cited commit, dev_net(dev) is fetched before holding RTNL
> and passed to __unregister_netdevice_notifier_net().
>
> However, dev_net(dev) might be different after holding RTNL.
>
> In the reported case [0], while removing a VF device, its netns was
> being dismantled and the VF was moved to init_net.
>
> So the following sequence is basically illegal when dev was fetched
> without lookup:
>
>   net =3D dev_net(dev);
>   rtnl_net_lock(net);
>
> Let's use a new helper rtnl_net_dev_lock() to fix the race.
>
> It calls maybe_get_net() for dev_net(dev) and checks dev_net(dev)
> before/after rtnl_net_lock().
>
> The dev_net(dev) pointer itself is valid, thanks to RCU API, but the

I am pretty sure dev_net(net) is not always called under rcu_read_lock().

And RTNL would not help in the future either.

> netns might be being dismantled.  maybe_get_net() is to avoid the race.
> This can be done by holding pernet_ops_rwsem, but it will be overkill.
>
> [0]:

> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevic=
e_notifier_dev_net().")
> Reported-by: Yael Chemla <ychemla@nvidia.com>
> Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09b=
c3@nvidia.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Tested-by: Yael Chemla <ychemla@nvidia.com>
> ---
>  net/core/dev.c | 59 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0021cbd28fc..f91ddb7f8bdf 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2070,6 +2070,47 @@ static void __move_netdevice_notifier_net(struct n=
et *src_net,
>         __register_netdevice_notifier_net(dst_net, nb, true);
>  }
>
> +static bool from_cleanup_net(void)
> +{
> +#ifdef CONFIG_NET_NS
> +       return current =3D=3D cleanup_net_task;
> +#else
> +       return false;
> +#endif
> +}
> +
> +static void rtnl_net_dev_lock(struct net_device *dev)
> +{
> +       struct net *net;
> +
> +       DEBUG_NET_WARN_ON_ONCE(from_cleanup_net());
> +again:
> +       /* netns might be being dismantled. */

rcu_read_lock();

> +       net =3D maybe_get_net(dev_net(dev));

rcu_read_unlock();



> +       if (!net) {
> +               cond_resched();

cond_resched() can be a NOP on some kernel builds.

This loop might burn a lot of cpu cycles.

Perhaps msleep(1) instead.

> +               goto again;
> +       }
> +


> +       rtnl_net_lock(net);
> +
> +       /* dev might have been moved to another netns. */
> +       if (!net_eq(net, dev_net(dev))) {
> +               rtnl_net_unlock(net);
> +               put_net(net);
> +               cond_resched();

      This cond_resched() seems unnecessary, the net change can not
occur more than once per rcu grace period (an eternity)

> +               goto again;
> +       }
> +}

