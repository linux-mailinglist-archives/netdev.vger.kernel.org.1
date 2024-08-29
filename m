Return-Path: <netdev+bounces-123299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5296471D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D551F2263E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5ED1AD417;
	Thu, 29 Aug 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bs2tp3gA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0F19306A
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939227; cv=none; b=j56J/f83jJnYLS2LWwL22Grso/NBdajsypOukN7F1IVo6rugCi6zG56qOV9SgZp/m8Kgw7KyCfnhOLoPe5h+9XbdV/F8b8+GdUv8ZgJYk1Wibo1nFTuBT7HucHoLJF/BOQUtX3Gj8MPkX0nyRuaDRSNmyaG1hsE+qxxmlGs1/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939227; c=relaxed/simple;
	bh=icpM5HSQMUbwBTLOMAn4qIF7PBhK7qPQKJT5Ls6YdCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3tGFGjD4s8PU0x/IIyAtplkYhTjtYyxYOWLMO7etDJwfirIISu3F24IL7rcRxw26cUGCtjCA8S42GnNQy/Mxm34Q7fkYZVunkRAn2HZpb1QJcD4RH6edLVZwsNOinabxzabDnPbbm4s92ycAJCgVvvbVfIy+qBmNwmJUsV/3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bs2tp3gA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371b098e699so564156f8f.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724939224; x=1725544024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfHgsMpSDF/Zbricg8IlQktiCdz20qwH+d+EW0V4rPA=;
        b=Bs2tp3gATN4XVQOd2CfLyo2yyUQY/UREWLjNJHvARl/cch3uZTPgfiGH/fpzk6Y+bL
         6niqH1ex0njOi7GyfcLbZXH6Oa25U4wjBVg4d2kriPk/wld5B7sb8QW6fSpklppzwLkD
         HM2rhgA0Jwpghyav+ovoIp7KMk1FqUd6CWbj2zsnLf0NKUWOW+Ce3Cqcrr0oLhPn0cN1
         4TS7kC3iFg4QRZtWkrFscTD/4puwhySTfbxfGkcXYn4Iitw/WQf4tAQU/mFPkp32Uj1Q
         wHQ49rdc3xEeGBOt7EbynwwBxJKKVQJ8E2EgK8e5obMG+Texr2FZhweaQYokaVpcxum0
         GXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939224; x=1725544024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfHgsMpSDF/Zbricg8IlQktiCdz20qwH+d+EW0V4rPA=;
        b=byA6GAwQJ/9HN9fBlz7w+1JjS4O1+Oe5m0oIacIRNHJ5003wkEo2IgWftSeaXNXal+
         pfNmmN424MAwkeBld/8CpsINvUO8UJYBFmt7hS5ImGeeVFbnNCDadto5oopnFX91wUUR
         NELdjnE9WZkv9ULkBD7SIRcn3/76U8xeCBACMWHsoHsbUcO8+zD46rkmd+s1i+2Q4TV6
         bB7cwV74S+z9kdYf9Br6EOyLGbz/xYLEyAkKab7gSIsmZy74uAu0D94gYJQfIqaiF1EF
         oz4LYeEFxYRaLFYu2efBoRAQRn7jaA1eJrBUnYOzMEkJkjU5/fcSYThtuGD0qy+cCRWt
         Q0xw==
X-Gm-Message-State: AOJu0YzGQHT0XaJDAuZI8gY//EtgJiBMzdZwhBBZNUQ8S1QU+u+Hq73y
	VMQ2LSWnUr/drcBTfbbhKY0xBIrJlHi8yC1DGbv2cWitjyBhHUN4bQs2z4Ic+iKGvBUkWJsICJs
	rNRwfLhuVfit0Wz+IEydSLCJTIp/abqLwH/YM
X-Google-Smtp-Source: AGHT+IFTUDzKWNte3r7uCfASU4SM/eBxE6dyfMY5RwW8gwKaR7yPuRti6cX944KpOqTgq0dlnRyi4s75+qKJVdRkeUs=
X-Received: by 2002:adf:e053:0:b0:368:3f6a:1dea with SMTP id
 ffacd0b85a97d-3749b5267fdmr2402509f8f.6.1724939223058; Thu, 29 Aug 2024
 06:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131214.169977-1-jdamato@fastly.com> <20240829131214.169977-2-jdamato@fastly.com>
In-Reply-To: <20240829131214.169977-2-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 15:46:31 +0200
Message-ID: <CANn89i+4=Prs24Cn3hTBpb70f9COJyXm8e19vkPs05LnqwFXtA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs per-NAPI
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com, 
	hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com, 
	skhawaja@google.com, kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:13=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Allow per-NAPI defer_hard_irqs setting.
>
> The existing sysfs parameter is respected; writes to sysfs will write to
> all NAPI structs for the device and the net_device defer_hard_irq field.
> Reads from sysfs will read from the net_device field.
>
> sysfs code was updated to guard against what appears to be a potential
> overflow as the field is an int, but the value passed in is an unsigned
> long.
>
> The ability to set defer_hard_irqs on specific NAPI instances will be
> added in a later commit, via netdev-genl.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  include/linux/netdevice.h | 23 +++++++++++++++++++++++
>  net/core/dev.c            | 29 ++++++++++++++++++++++++++---
>  net/core/net-sysfs.c      |  5 ++++-
>  3 files changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index fce70990b209..7d53380da4c0 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -371,6 +371,7 @@ struct napi_struct {
>         struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
>         int                     rx_count; /* length of rx_list */
>         unsigned int            napi_id;
> +       int                     defer_hard_irqs;
>         struct hrtimer          timer;
>         struct task_struct      *thread;
>         /* control-path-only fields follow */
> @@ -534,6 +535,28 @@ static inline void napi_schedule_irqoff(struct napi_=
struct *n)
>                 __napi_schedule_irqoff(n);
>  }
>

Since dev->napi_defer_hard_irqs is no longer used in fast path,
please move it outside of the net_device_read_rx group.

Also update Documentation/networking/net_cachelines/net_device.rst

> +/**
> + * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
> + * @n: napi struct to get the defer_hard_irqs field from
> + *
> + * Returns the per-NAPI value of the defar_hard_irqs field.
> + */
> +int napi_get_defer_hard_irqs(const struct napi_struct *n);
> +
> +/**
> + * napi_set_defer_hard_irqs - set the defer_hard_irqs for a napi
> + * @n: napi_struct to set the defer_hard_irqs field
> + * @defer: the value the field should be set to
> + */
> +void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
> +
> +/**
> + * netdev_set_defer_hard_irqs - set defer_hard_irqs for all NAPIs of a n=
etdev
> + * @netdev: the net_device for which all NAPIs will have their defer_har=
d_irqs set
> + * @defer: the defer_hard_irqs value to set
> + */
> +void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
> +
>  /**
>   * napi_complete_done - NAPI processing complete
>   * @n: NAPI context
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 63987b8b7c85..f7baff0da057 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6212,6 +6212,28 @@ void __napi_schedule_irqoff(struct napi_struct *n)
>  }
>  EXPORT_SYMBOL(__napi_schedule_irqoff);
>
> +int napi_get_defer_hard_irqs(const struct napi_struct *n)
> +{
> +       return READ_ONCE(n->defer_hard_irqs);
> +}
> +EXPORT_SYMBOL_GPL(napi_get_defer_hard_irqs);
> +
> +void napi_set_defer_hard_irqs(struct napi_struct *n, int defer)
> +{
> +       WRITE_ONCE(n->defer_hard_irqs, defer);
> +}
> +EXPORT_SYMBOL_GPL(napi_set_defer_hard_irqs);
> +
> +void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer)
> +{
> +       struct napi_struct *napi;
> +
> +       WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
> +       list_for_each_entry(napi, &netdev->napi_list, dev_list)
> +               napi_set_defer_hard_irqs(napi, defer);
> +}
> +EXPORT_SYMBOL_GPL(netdev_set_defer_hard_irqs);
> +
>  bool napi_complete_done(struct napi_struct *n, int work_done)
>  {
>         unsigned long flags, val, new, timeout =3D 0;
> @@ -6230,7 +6252,7 @@ bool napi_complete_done(struct napi_struct *n, int =
work_done)
>         if (work_done) {
>                 if (n->gro_bitmask)
>                         timeout =3D READ_ONCE(n->dev->gro_flush_timeout);
> -               n->defer_hard_irqs_count =3D READ_ONCE(n->dev->napi_defer=
_hard_irqs);
> +               n->defer_hard_irqs_count =3D napi_get_defer_hard_irqs(n);
>         }
>         if (n->defer_hard_irqs_count > 0) {
>                 n->defer_hard_irqs_count--;
> @@ -6368,7 +6390,7 @@ static void busy_poll_stop(struct napi_struct *napi=
, void *have_poll_lock,
>         bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
>
>         if (flags & NAPI_F_PREFER_BUSY_POLL) {
> -               napi->defer_hard_irqs_count =3D READ_ONCE(napi->dev->napi=
_defer_hard_irqs);
> +               napi->defer_hard_irqs_count =3D napi_get_defer_hard_irqs(=
napi);
>                 timeout =3D READ_ONCE(napi->dev->gro_flush_timeout);
>                 if (napi->defer_hard_irqs_count && timeout) {
>                         hrtimer_start(&napi->timer, ns_to_ktime(timeout),=
 HRTIMER_MODE_REL_PINNED);
> @@ -6650,6 +6672,7 @@ void netif_napi_add_weight(struct net_device *dev, =
struct napi_struct *napi,
>         INIT_HLIST_NODE(&napi->napi_hash_node);
>         hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINN=
ED);
>         napi->timer.function =3D napi_watchdog;
> +       napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irq=
s));
>         init_gro_hash(napi);
>         napi->skb =3D NULL;
>         INIT_LIST_HEAD(&napi->rx_list);
> @@ -11032,7 +11055,7 @@ void netdev_sw_irq_coalesce_default_on(struct net=
_device *dev)
>
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                 dev->gro_flush_timeout =3D 20000;
> -               dev->napi_defer_hard_irqs =3D 1;
> +               netdev_set_defer_hard_irqs(dev, 1);
>         }
>  }
>  EXPORT_SYMBOL_GPL(netdev_sw_irq_coalesce_default_on);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e2084ce7b75..8272f0144d81 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -425,7 +425,10 @@ NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
>
>  static int change_napi_defer_hard_irqs(struct net_device *dev, unsigned =
long val)
>  {
> -       WRITE_ONCE(dev->napi_defer_hard_irqs, val);
> +       if (val > S32_MAX)
> +               return -EINVAL;
> +
> +       netdev_set_defer_hard_irqs(dev, (int)val);
>         return 0;
>  }
>
> --
> 2.25.1
>

