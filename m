Return-Path: <netdev+bounces-123300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5AC964728
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20321C2329E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980761AE854;
	Thu, 29 Aug 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpmVy7Tu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AB1AE873
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939302; cv=none; b=eSXcEU0q/+ERlUlAJT0ZjckNEkDuRHf0AVbwUrPze9qJdfTGS4smsWKgUVNBkw9V5qHLUhgHnYCPIe5wlfJslZ+tM3Th3OKErMx3IwMlDQx/Iy1JjwTU21WYAM/Gt7iI9vWt1ol2vKqrlULqUimIW8KFoGeMlslNEfYAu4jnNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939302; c=relaxed/simple;
	bh=NQQnb0mdQeAwDkJ+tt4TlODZAXkhpqHEUsXC5mfDlpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqPcFnUEBXWx/b8rowUM7L7boMHWcBf7BkLCqcOxu509f2cwvy4wIUoo+AsAiN5K7bYBTrVn/2tRQBVG4AbM2CJR1E2h684Zt8bFwSQF7y/hducZq6PcS2Zai8SEzCzI2/QPq7HfvbbI8vhc/XDrqn5SEPnEpxRAqCr3uDLs3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpmVy7Tu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed05c0a2fso738865a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724939299; x=1725544099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX0mRihea/eOEM2bDEgw+c6t5XaEtyKuY95MXVEKelY=;
        b=KpmVy7Tu2peYaio1zvfTuJHnB71af+Zf9WiJqJm3w+IzsoHCf7VDJpPYXNkxM12j6F
         ZRNSzbVD9BFIohfBOdrpO4Wh2Ev6ydGeaKoK50MWcoMN7P+n3ggtYFqOR9ZO4DhzXAYQ
         Qs3Mea+CD50a/6F9wI/0a/ODtimx96pyrtpaw4gAYsZAU5hCSLe9kr29mxFj9VEUxp24
         N+tMgcSd8b9R9N4nudwaE1iQE5jRFcidHUNQFc8mOYSU1IUU1xBn4kcYHB8MnksB8txC
         rY1MqtDfum+ha/O9RqTzrz0wRuUgCs5rJQmQnXtntC6EFbEvgukQ+aOCh+Qw9TT6E4Z2
         1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939299; x=1725544099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX0mRihea/eOEM2bDEgw+c6t5XaEtyKuY95MXVEKelY=;
        b=RcnI5CMfkwMOu2WtMKwF7Nvchg/MIEyQO1g+IFgxWnTdewyBacrw+mct2wirFB6pGe
         U7F+zIvYJ4rsorDFrGxZaDwKcvFkM75S3c2kwoTLKgePhJJb2g/DtBbIcDeScl5bJdb1
         KKpdHtdbQXWYaLFAq7bvO60aTEo6xeTO3gh/qmwyBbtZqKbJZbCSHodxRHOPKnlvuXB4
         zSq+WTsemy4K4oyDb5Ko0+s9zZzrUqW4Xyt+3+0RrrCLV7RzHksA95jpWrnUBcIoU4IV
         4nPPQMFoq+BvJyWiTKC7mfCDLI3gjrNSGR4OL8ZtbvPL5kYYteSbTz/tfTdvy06VLtsm
         oxHQ==
X-Gm-Message-State: AOJu0YxowLWBUF4uXyrccYKmFdiiYWt4xyjuPDKZJPsKbqt/fb7LV5XX
	8vBHdbk9OuOSO6q2ysVm5hycvGmxx5jENgz6sYCJzMyoZEUQRMr5JI8uEDMNAnzLstlOXPgEsWA
	mSPkyAUKfDInaVL4RVVQ8ZEo6JA+9/hfe7sAm
X-Google-Smtp-Source: AGHT+IGOcNivpXC/CzP/IIjuKIi++oFey5BdxjtnXe4zrPEbUPeXOUx6YPCBPe6Qf6xI0C1S7VAQTOs7xTi/4dP00Pg=
X-Received: by 2002:a05:6402:27d2:b0:5be:f295:a1a5 with SMTP id
 4fb4d7f45d1cf-5c21ed406e6mr2789211a12.10.1724939297891; Thu, 29 Aug 2024
 06:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131214.169977-1-jdamato@fastly.com> <20240829131214.169977-4-jdamato@fastly.com>
In-Reply-To: <20240829131214.169977-4-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 15:48:05 +0200
Message-ID: <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com, 
	hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com, 
	skhawaja@google.com, kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:13=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Allow per-NAPI gro_flush_timeout setting.
>
> The existing sysfs parameter is respected; writes to sysfs will write to
> all NAPI structs for the device and the net_device gro_flush_timeout
> field.  Reads from sysfs will read from the net_device field.
>
> The ability to set gro_flush_timeout on specific NAPI instances will be
> added in a later commit, via netdev-genl.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
>  net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
>  net/core/net-sysfs.c      |  2 +-
>  3 files changed, 55 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7d53380da4c0..d00024d9f857 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -372,6 +372,7 @@ struct napi_struct {
>         int                     rx_count; /* length of rx_list */
>         unsigned int            napi_id;
>         int                     defer_hard_irqs;
> +       unsigned long           gro_flush_timeout;
>         struct hrtimer          timer;
>         struct task_struct      *thread;
>         /* control-path-only fields follow */
> @@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct *n,=
 int defer);
>   */
>  void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
>

Same remark :  dev->gro_flush_timeout is no longer read in the fast path.

Please move gro_flush_timeout out of net_device_read_txrx and update
Documentation/networking/net_cachelines/net_device.rst

> +/**
> + * napi_get_gro_flush_timeout - get the gro_flush_timeout
> + * @n: napi struct to get the gro_flush_timeout from
> + *
> + * Returns the per-NAPI value of the gro_flush_timeout field.
> + */
> +unsigned long napi_get_gro_flush_timeout(const struct napi_struct *n);
> +
> +/**
> + * napi_set_gro_flush_timeout - set the gro_flush_timeout for a napi
> + * @n: napi struct to set the gro_flush_timeout
> + * @timeout: timeout value to set
> + *
> + * napi_set_gro_flush_timeout sets the per-NAPI gro_flush_timeout
> + */
> +void napi_set_gro_flush_timeout(struct napi_struct *n, unsigned long tim=
eout);
> +
> +/**
> + * netdev_set_gro_flush_timeout - set gro_flush_timeout for all NAPIs of=
 a netdev
> + * @netdev: the net_device for which all NAPIs will have their gro_flush=
_timeout set
> + * @timeout: the timeout value to set
> + */
> +void netdev_set_gro_flush_timeout(struct net_device *netdev,
> +                                 unsigned long timeout);
> +
>  /**
>   * napi_complete_done - NAPI processing complete
>   * @n: NAPI context
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f7baff0da057..3f7cb1085efa 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6234,6 +6234,29 @@ void netdev_set_defer_hard_irqs(struct net_device =
*netdev, int defer)
>  }
>  EXPORT_SYMBOL_GPL(netdev_set_defer_hard_irqs);
>
> +unsigned long napi_get_gro_flush_timeout(const struct napi_struct *n)
> +{
> +       return READ_ONCE(n->gro_flush_timeout);
> +}
> +EXPORT_SYMBOL_GPL(napi_get_gro_flush_timeout);
> +
> +void napi_set_gro_flush_timeout(struct napi_struct *n, unsigned long tim=
eout)
> +{
> +       WRITE_ONCE(n->gro_flush_timeout, timeout);
> +}
> +EXPORT_SYMBOL_GPL(napi_set_gro_flush_timeout);
> +
> +void netdev_set_gro_flush_timeout(struct net_device *netdev,
> +                                 unsigned long timeout)
> +{
> +       struct napi_struct *napi;
> +
> +       WRITE_ONCE(netdev->gro_flush_timeout, timeout);
> +       list_for_each_entry(napi, &netdev->napi_list, dev_list)
> +               napi_set_gro_flush_timeout(napi, timeout);
> +}
> +EXPORT_SYMBOL_GPL(netdev_set_gro_flush_timeout);
> +
>  bool napi_complete_done(struct napi_struct *n, int work_done)
>  {
>         unsigned long flags, val, new, timeout =3D 0;
> @@ -6251,12 +6274,12 @@ bool napi_complete_done(struct napi_struct *n, in=
t work_done)
>
>         if (work_done) {
>                 if (n->gro_bitmask)
> -                       timeout =3D READ_ONCE(n->dev->gro_flush_timeout);
> +                       timeout =3D napi_get_gro_flush_timeout(n);
>                 n->defer_hard_irqs_count =3D napi_get_defer_hard_irqs(n);
>         }
>         if (n->defer_hard_irqs_count > 0) {
>                 n->defer_hard_irqs_count--;
> -               timeout =3D READ_ONCE(n->dev->gro_flush_timeout);
> +               timeout =3D napi_get_gro_flush_timeout(n);
>                 if (timeout)
>                         ret =3D false;
>         }
> @@ -6391,7 +6414,7 @@ static void busy_poll_stop(struct napi_struct *napi=
, void *have_poll_lock,
>
>         if (flags & NAPI_F_PREFER_BUSY_POLL) {
>                 napi->defer_hard_irqs_count =3D napi_get_defer_hard_irqs(=
napi);
> -               timeout =3D READ_ONCE(napi->dev->gro_flush_timeout);
> +               timeout =3D napi_get_gro_flush_timeout(napi);
>                 if (napi->defer_hard_irqs_count && timeout) {
>                         hrtimer_start(&napi->timer, ns_to_ktime(timeout),=
 HRTIMER_MODE_REL_PINNED);
>                         skip_schedule =3D true;
> @@ -6673,6 +6696,7 @@ void netif_napi_add_weight(struct net_device *dev, =
struct napi_struct *napi,
>         hrtimer_init(&napi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINN=
ED);
>         napi->timer.function =3D napi_watchdog;
>         napi_set_defer_hard_irqs(napi, READ_ONCE(dev->napi_defer_hard_irq=
s));
> +       napi_set_gro_flush_timeout(napi, READ_ONCE(dev->gro_flush_timeout=
));
>         init_gro_hash(napi);
>         napi->skb =3D NULL;
>         INIT_LIST_HEAD(&napi->rx_list);
> @@ -11054,7 +11078,7 @@ void netdev_sw_irq_coalesce_default_on(struct net=
_device *dev)
>         WARN_ON(dev->reg_state =3D=3D NETREG_REGISTERED);
>
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> -               dev->gro_flush_timeout =3D 20000;
> +               netdev_set_gro_flush_timeout(dev, 20000);
>                 netdev_set_defer_hard_irqs(dev, 1);
>         }
>  }
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 8272f0144d81..ff545a422b1f 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -408,7 +408,7 @@ NETDEVICE_SHOW_RW(tx_queue_len, fmt_dec);
>
>  static int change_gro_flush_timeout(struct net_device *dev, unsigned lon=
g val)
>  {
> -       WRITE_ONCE(dev->gro_flush_timeout, val);
> +       netdev_set_gro_flush_timeout(dev, val);
>         return 0;
>  }
>
> --
> 2.25.1
>

