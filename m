Return-Path: <netdev+bounces-207350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D0B06BD5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 04:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A91AA707B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5F277013;
	Wed, 16 Jul 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ruo1JzCF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F81DB356
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752634057; cv=none; b=C4Djmzv2hEMwi0WR1MsTBojVMg5TICkxO8ANP1kL32KVlfxwp4UAk3WhwPDZPsd8ZqvoCAvxllWNX+/4kq/J7TY/dXRpan230SXz9Ssi8feB/1lnLgqFPhUT7jatfSThIOOoACJOMBj8rYChusv4tUJTnGYnTrCoLUWpI5gfR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752634057; c=relaxed/simple;
	bh=6tyFQG9ObMR6DQRml1mb/juchm0s9LQKambyFuaWRJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1Hg7syR0xIJHNF+mkQ4jt1Qpzr0wZ1W60OP+YgpFfJSh+gGB2fCzSB2P7AXfGdCvrhmZJ89/fAB8ylZMGtRPokRP4rqc9dFUCIG3KqS1DAlUxiz4b7KdXrqE4fx9z8YM8n/ujQ/t5RBB4FxVUVf9v9OTFh8CsSzWF1OlYgDGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ruo1JzCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752634053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6LOs3KwxAcMoFoSn4gzE7xIJQ2DUSqrbD9QaSjD71I=;
	b=Ruo1JzCFsYgin/C3Ef7SE1zn4IhsRZDjo5uqdmlYk6+QPjh/gJZn/yVcRKPuXhMboAAHAx
	55YmHaz+6ROFaEQnKD9chjyeiQ0SBY3+PRu3s6Dr906bdwmBKWOxR1qXGJ/0UDobUKtTdk
	vWLQrVUtlRF1omLb5tWRjih56/H3+lg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-enNGbKD6OmeZAnUiSNvCyA-1; Tue, 15 Jul 2025 22:47:32 -0400
X-MC-Unique: enNGbKD6OmeZAnUiSNvCyA-1
X-Mimecast-MFC-AGG-ID: enNGbKD6OmeZAnUiSNvCyA_1752634051
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so9986556a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 19:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752634051; x=1753238851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6LOs3KwxAcMoFoSn4gzE7xIJQ2DUSqrbD9QaSjD71I=;
        b=flbw9WMouVEJSyzXFE02Z8eSiIj7xozg7QMe/uLKLHmxRAEzYpIvJ+EPWWTqW5F3X6
         rqEuHatcJdPEjVsijJiY5LA3VbHUfOolFiDFs/NujOvfJzf3ofeiV9l2Tlxnzhc1sO7A
         77VeNUXu0ytHO68trz+TLLC+6KFCZXSMsIQaWmlLlQNl7vUIHmvXbvlHlt+5rWNbON4N
         mmxW05Q6U2NEr09Hol1qvjelMHfiKz3Yoo7piTraHRJqJ1vDkN5D3jdU5y7Gp9h8CRcK
         aOS/MOHu/CR12mwiypPLEzG1CAqaBHEVa46TZuKVpoHtb2OyRgv6n3+wKK0rV/cH4vR8
         3XTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU+OG3edA4qnc4+iz5BFlHCZoUbXHKpOzKuPkYHjYClPAlRinVRNGJcfBcMROYHqp+Dx08niE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzz7GF0E6nYPKB7xI1SghktLXwnTC6nIxvrvz7yY+OIkgj+qZ
	/fJtltH4xlW9M+sWLd+jJoJtHAqruqCRUG/IHY1eAiLo6UWDXPXnJIcU19U400gT3LT0WqrqY/c
	KolbHCa3zpFXqGRmMzNKEd0MUUD8Ed4ZXe260CkQTnvvPMDinUylhdRqsdHZmTulVagqgPsVt56
	3YxjSZAVsFoxDqCu0kgwjx+P0pmo5YKIN0
X-Gm-Gg: ASbGncv/IkL4YL9/wChGYZMy9o3vlTkEAlft3wEcz+/61BsNaXzSsObdqwG1v/sTNrU
	FGcVO77keZHy8FF9kqS5R2WZvWD3qmZdGpadaOZqzUwXkJfDbNbLvQ/pAQUlMY5uWwJqLEzQqgm
	ExdHBVZV9lotG+D5SPJ+o=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr1236233a91.27.1752634050874;
        Tue, 15 Jul 2025 19:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSgy3Q6uvDcv+dh57LPDBZNKo40hU3FNxj6pWecHXujau5F/JesmVv4D6IJmpzKmuDlsaWm5Df3O5TB62z2j0=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id
 98e67ed59e1d1-31c9f43747emr1236201a91.27.1752634050348; Tue, 15 Jul 2025
 19:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
 <CACGkMEvjXBZ-Q77-8YRyd_EV0t9xMT8R8-FT5TKJBnqAOed=pQ@mail.gmail.com> <d5ad1b10-f485-4939-b9de-918b378362b9@bytedance.com>
In-Reply-To: <d5ad1b10-f485-4939-b9de-918b378362b9@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Jul 2025 10:47:19 +0800
X-Gm-Features: Ac12FXwY0618meZM7op6lRwCQ2ykvxYxmr5LBy2rowmHFXBgfqqUkpEG1gaprFg
Message-ID: <CACGkMEvZ5dqjc6+1uwoq98x-78eymGFHXpOJtbViG3U9mOyn8g@mail.gmail.com>
Subject: Re: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during probing
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zigit:

On Tue, Jul 15, 2025 at 7:00=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.com> =
wrote:
>
> On 7/15/25 5:31 PM, Jason Wang wrote:
> > On Wed, Jul 2, 2025 at 6:37=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.co=
m> wrote:
> >>
> >> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request whil=
e
> >> the virtio-net driver is still probing with rtnl_lock() hold, this wil=
l
> >> cause a recursive mutex in netdev_notify_peers().
> >>
> >> Fix it by temporarily save the announce status while probing, and then=
 in
> >> virtnet_open(), if it sees a delayed announce work is there, it starts=
 to
> >> schedule the virtnet_config_changed_work().
> >>
> >> Another possible solution is to directly check whether rtnl_is_locked(=
)
> >> and call __netdev_notify_peers(), but in that way means we need to rel=
ies
> >> on netdev_queue to schedule the arp packets after ndo_open(), which we
> >> thought is not very intuitive.
> >>
> >> We've observed a softlockup with Ubuntu 24.04, and can be reproduced w=
ith
> >> QEMU sending the announce_self rapidly while booting.
> >>
> >> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 second=
s.
> >> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> >> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
> >> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid=
:1     ppid:0      flags:0x00004000
> >> [  494.168260] Call Trace:
> >> [  494.168329]  <TASK>
> >> [  494.168389]  __schedule+0x27c/0x6b0
> >> [  494.168495]  schedule+0x33/0x110
> >> [  494.168585]  schedule_preempt_disabled+0x15/0x30
> >> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> >> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> >> [  494.168949]  mutex_lock+0x3c/0x50
> >> [  494.169039]  rtnl_lock+0x15/0x20
> >> [  494.169128]  netdev_notify_peers+0x12/0x30
> >> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> >> [  494.169377]  virtnet_probe+0xa48/0xe00
> >> [  494.169484]  ? vp_get+0x4d/0x100
> >> [  494.169574]  virtio_dev_probe+0x1e9/0x310
> >> [  494.169682]  really_probe+0x1c7/0x410
> >> [  494.169783]  __driver_probe_device+0x8c/0x180
> >> [  494.169901]  driver_probe_device+0x24/0xd0
> >> [  494.170011]  __driver_attach+0x10b/0x210
> >> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> >> [  494.170237]  bus_for_each_dev+0x8d/0xf0
> >> [  494.170341]  driver_attach+0x1e/0x30
> >> [  494.170440]  bus_add_driver+0x14e/0x290
> >> [  494.170548]  driver_register+0x5e/0x130
> >> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> >> [  494.170788]  register_virtio_driver+0x20/0x40
> >> [  494.170905]  virtio_net_driver_init+0x97/0xb0
> >> [  494.171022]  do_one_initcall+0x5e/0x340
> >> [  494.171128]  do_initcalls+0x107/0x230
> >> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> >> [  494.171340]  kernel_init_freeable+0x134/0x210
> >> [  494.171462]  kernel_init+0x1b/0x200
> >> [  494.171560]  ret_from_fork+0x47/0x70
> >> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> >> [  494.171769]  ret_from_fork_asm+0x1b/0x30
> >> [  494.171875]  </TASK>
> >>
> >> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin sta=
te on up/down")
> >> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> >> ---
> >> v1 -> v2:
> >> - Check vi->status in virtnet_open().
> >> v1:
> >> - https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@byt=
edance.com/
> >> ---
> >>  drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++---------------=
-
> >>  1 file changed, 26 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index e53ba600605a..859add98909b 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
> >>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> >>                 if (vi->status & VIRTIO_NET_S_LINK_UP)
> >>                         netif_carrier_on(vi->dev);
> >> +               if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
> >> +                       vi->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
> >> +                       schedule_work(&vi->config_work);
> >> +               }
> >>                 virtio_config_driver_enable(vi->vdev);
> >
> > Instead of doing tricks like this.
> >
> > I wonder if the fix is as simple as calling
> > virtio_config_driver_disable() before init_vqs()?
> >
> > Thanks
> >
>
> That might not work as the device like QEMU will set the VIRTIO_NET_S_ANN=
OUNCE
> regardless of most of the driver status, QEMU only checks whether the dri=
ver has
> finalized it's features with VIRTIO_NET_F_GUEST_ANNOUNCE & VIRTIO_NET_F_C=
TRL_VQ.
>
> We've made a little patch to verify, don't know if it matches your though=
t, but
> it does not seem to work :(
>
>     diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>     index e53ba600605a..f309ce3fe243 100644
>     --- a/drivers/net/virtio_net.c
>     +++ b/drivers/net/virtio_net.c
>     @@ -6903,6 +6903,9 @@ static int virtnet_probe(struct virtio_device *=
vdev)
>                     vi->curr_queue_pairs =3D num_online_cpus();
>             vi->max_queue_pairs =3D max_queue_pairs;
>
>     +       /* Disable config change notification until ndo_open. */
>     +       virtio_config_driver_disable(vi->vdev);
>     +
>             /* Allocate/initialize the rx/tx queues, and invoke find_vqs =
*/
>             err =3D init_vqs(vi);
>             if (err)
>     @@ -6965,9 +6968,6 @@ static int virtnet_probe(struct virtio_device *=
vdev)
>                     goto free_failover;
>             }
>
>     -       /* Disable config change notification until ndo_open. */
>     -       virtio_config_driver_disable(vi->vdev);
>     -
>             virtio_device_ready(vdev);
>
>             if (vi->has_rss || vi->has_rss_hash_report) {
>
> For reproduce details,
>
> 1. Spawn qemu with monitor, like `-monitor unix:qemu.sock,server`
> 2. In another window, run `while true; echo "announce_self"; end | socat =
- unix-connect:qemu.sock > /dev/null`
> 3. The boot up will get hanged when probing the virtio_net
>
> The simplest version we've made is to revert the usage of
> `virtnet_config_changed_work()` back to the `schedule_work()`, but as in =
v1,
> we're still trying to understand the impact, making sure that it won't br=
eak
> other things.
>
> Regards,
>

Thanks for the clarification. Now I see the issue.

It looks like the root cause is to call virtio_config_changed_work()
directly during probe().

Let's switch to use virtio_config_changed() instead so that we can
properly check the config_driver_disabled.

Thanks


