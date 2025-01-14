Return-Path: <netdev+bounces-158111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC8A10796
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392263A5783
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391D234D1F;
	Tue, 14 Jan 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olW6Ak6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C5229633
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860793; cv=none; b=usWD2237aSxcJeCbwkmIwd4MpJFJthxaAKIKc8PwX1xtjZDiqg+DnDr1gMeEiDYyN+C/04wdksOEiPYEwIz5AhWjvExz83bp29be82rIqfsJyeetT59kpYHm85QjAIzU+b2ebIQRX49mb3UaumdThw1WRUam9ujV+dHy1mChrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860793; c=relaxed/simple;
	bh=rFxDuZif2Elch4wTUW5nHyfrMpbDrjtlSN1c6LEWq3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3kLIceAaQ/8Y8IS8BV1/TPkYS8G6yEwY0txkfJBRSWKSu4nxObn1LQc32UigMj+PRcxVAZmRfvwiFW50TmxAdqhTqIeVwTZh1q9EOHe1EXkP/lDzJH4y8uGvgbG65Qz4Gc7GD/OGuBkkY61bZkLw4/7ISQcx8Lj5F49fbs9+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olW6Ak6d; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6adb4so2716342a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860790; x=1737465590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nRGY24iBXloQKrFKuoPtP+nkLrvnOhFVMuHaed4bvo=;
        b=olW6Ak6danrQ2vPMYHocxp30knVVEjgjpDMXoh5HMTAlXWK+vHX1avJyHDTmKiy/ig
         PO0EAjCJyjbKpbuMOhqULwZ6ES5XK6r8KvBQTnkTGJRz18jUj4dx/Z+z2RfzH0fYNTGq
         Ya07zlP9DLssImyiipYC9eHZZh0kzagoim8YwZ07CDe4PRPdLLWo0fYeDzQ+8/uQ6ZJr
         aoYKqAZdMLCAxKLXs3PE6aSzi4L1b9QaOC/Dfw/+54I7sqHYTdlwILucGRaT2VGVQNLW
         RHEm+F9RIgIy7FdGZ+jS6FfiLYYC1mscLCYCcSY4VBHl0LP8vJVKSeIs7F611Akj/goP
         R0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860790; x=1737465590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nRGY24iBXloQKrFKuoPtP+nkLrvnOhFVMuHaed4bvo=;
        b=AT/ATdzuEsVVkV/t41uKBFpjmcwPJ6q4UtoQuzFoH42rYbHOrUh039QIX/nd/EVOq2
         JrKpkEc9QHsDVzAQnx3rlzxJhSjC68p5RykRXvwEqSBSuhgfB6+dNTMdSUelRudY0sy0
         ZtvS+9ecx49mhGYrpcMtVSzF/U9Y4pEGFAcSLTo1vgMkFaamGUgeETREkgsKMDipjT6S
         KeNmyHQpqnshV6RlHw66dQFUzQ9LEKwPGyvrJQ7POBaQC8cXZgnDlVHrnJzG28KReoH1
         rCS0ADVEaMw5ZBgQC5GmJKDRbhmo7UA99OAcHzlQsqpeCNVC7aEdD8PmKlek+s4nTRUu
         OIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEhQaGTsOmkYXJzK/f2I5sUVf6HPRBk2L9DikD15ct7VQP2gjXzdWEIOl6L9HzIgKbDse2gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyF2O17aUFdYykmcSSaSmqq/K7lOVlTt0swUQkG9Nomohx7Pvl
	DMNxNQhwMvtaMTW5ivGaPRq8eh4QqS75gue0oZUa/A3rkCw63vckkVTQayKA+a6TDICxJ6rrz0S
	Hc0eO3wGCLz5PgMweWPOY9E9ZbF5BP4ufvVnu
X-Gm-Gg: ASbGncvv9Ux9Pgsm6lUFkOOr+W/O9eyDXZ/9XAN7NkUp506kUwcKhgQiqVKGcrQFkbo
	uaoGSJidr4Ggp8AV/Wr7PtxCjwEUBNs2owNOMSQ==
X-Google-Smtp-Source: AGHT+IFQMD3VVtCXr4bh/3FFfL1kjRUt8365Qb27/CZB5XDTuUhAQ7Me1kAqxqFCIGOW+ShdvtsJrN6H56gzj0hpbWI=
X-Received: by 2002:a05:6402:4415:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5d972df6fecmr22310751a12.4.1736860790152; Tue, 14 Jan 2025
 05:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-9-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-9-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:19:38 +0100
X-Gm-Features: AbW1kvZXbOXQXVDFt2-ljOy0hcwjHSgvasJMeSilzUcvxr-C3L9k-1lll9o9phY
Message-ID: <CANn89iLrzg0hGgNS0PRxaJKvoi4_-siv439x6erpDzb4az3X9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 08/11] net: protect threaded status of NAPI with netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com, 
	leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Now that NAPI instances can't come and go without holding
> netdev->lock we can trivially switch from rtnl_lock() to
> netdev_lock() for setting netdev->threaded via sysfs.
>
> Note that since we do not lock netdev_lock around sysfs
> calls in the core we don't have to "trylock" like we do
> with rtnl_lock.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: leitao@debian.org
> ---
>  include/linux/netdevice.h | 13 +++++++++++--
>  net/core/dev.c            |  2 ++
>  net/core/net-sysfs.c      | 32 +++++++++++++++++++++++++++++++-
>  3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d3108a12e562..75c30404657b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -384,7 +384,7 @@ struct napi_struct {
>         int                     rx_count; /* length of rx_list */
>         unsigned int            napi_id; /* protected by netdev_lock */
>         struct hrtimer          timer;
> -       struct task_struct      *thread;
> +       struct task_struct      *thread; /* protected by netdev_lock */
>         unsigned long           gro_flush_timeout;
>         unsigned long           irq_suspend_timeout;
>         u32                     defer_hard_irqs;
> @@ -2451,10 +2451,12 @@ struct net_device {
>          * Drivers are free to use it for other protection.
>          *
>          * Protects:
> -        *      @napi_list, @net_shaper_hierarchy, @reg_state
> +        *      @napi_list, @net_shaper_hierarchy, @reg_state, @threaded
>          * Partially protects (readers hold either @lock or rtnl_lock,
>          * writers must hold both for registered devices):
>          *      @up
> +        * Also protects some fields in struct napi_struct.
> +        *
>          * Ordering: take after rtnl_lock.
>          */
>         struct mutex            lock;
> @@ -2696,6 +2698,13 @@ static inline void netdev_assert_locked(struct net=
_device *dev)
>         lockdep_assert_held(&dev->lock);
>  }
>
> +static inline void netdev_assert_locked_or_invisible(struct net_device *=
dev)
> +{
> +       if (dev->reg_state =3D=3D NETREG_REGISTERED ||
> +           dev->reg_state =3D=3D NETREG_UNREGISTERING)
> +               netdev_assert_locked(dev);
> +}
> +
>  static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
>  {
>         napi->irq =3D irq;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1151baaedf4d..5872f0797cc3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6784,6 +6784,8 @@ int dev_set_threaded(struct net_device *dev, bool t=
hreaded)
>         struct napi_struct *napi;
>         int err =3D 0;
>
> +       netdev_assert_locked_or_invisible(dev);
> +
>         if (dev->threaded =3D=3D threaded)
>                 return 0;
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 2d9afc6e2161..5602a3c12e9a 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -108,6 +108,36 @@ static ssize_t netdev_store(struct device *dev, stru=
ct device_attribute *attr,
>         return ret;
>  }
>
> +/* Same as netdev_store() but takes netdev_lock() instead of rtnl_lock()=
 */
> +static ssize_t
> +netdev_lock_store(struct device *dev, struct device_attribute *attr,
> +                 const char *buf, size_t len,
> +                 int (*set)(struct net_device *, unsigned long))
> +{
> +       struct net_device *netdev =3D to_net_dev(dev);
> +       struct net *net =3D dev_net(netdev);
> +       unsigned long new;
> +       int ret;
> +
> +       if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
> +               return -EPERM;
> +
> +       ret =3D kstrtoul(buf, 0, &new);
> +       if (ret)
> +               return ret;
> +
> +       netdev_lock(netdev);
> +
> +       if (dev_isalive(netdev)) {

nit: dev_isalive() is supposed to be called with RCU or RTNL, I guess
we should update its comment:

/* Caller holds RTNL or RCU */

Reviewed-by: Eric Dumazet <edumazet@google.com>

