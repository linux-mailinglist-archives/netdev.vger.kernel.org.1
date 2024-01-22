Return-Path: <netdev+bounces-64581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0F835C2A
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1DBB278FC
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877317BD2;
	Mon, 22 Jan 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmKrCXyC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8B374E7
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910246; cv=none; b=Mvagd6vSrm7/9NM/6mVl5kKoULPEH/4qMjaj1qG397vzK3CrS+2Q9tmBLVx9qNsRbBPtYS97KlIZiC6vkGlmPJrsmyGYJJDpHOVCZi0Z8EriRLvx42VH14eB5irp+KdrpmFtADgKfxZfI7xaFCLkwC35PcL+n+WUQlHEy4Z9anA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910246; c=relaxed/simple;
	bh=8/D8aMjhRKPSV1/ngJ5OSp6Ih/06N83ZJrJW1yvTrEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbLzC+0CCIElTinYri2mC24xaZ9JXRdk6iwBHtovtFazJbVcimDhkJzBWTg7/0ruQfGPvtyX3XEkAX5DRY0UnL/Bl99QOEYjGI8cKYmnK8jaWA6C/OSNh3Xq+LWQXi5kdBuGi2urvW7Sqzfr1t0Cn27xLnIXdXFbGMzmwmDUtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmKrCXyC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705910244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcjJhXadeqF54swuXOqN0DiEs6FdnKgQxq8VgnzlUIY=;
	b=PmKrCXyC4/kiS9VPC8ZNRY3oDgD6lf8G6M7iN8dMn0Pre6ROYXeD316TUJ9kCo16sEOPtg
	fPdVqOawRqs/j8AK/4TwsP9pY6M13CUkeGryBhExK6Er0CJ5dX0AzzSwdJ/dZ7Ym7Z8MvV
	EJl5A5y4HJ7RvcjDJqUraMpDMVTzGxA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-H5rvpJ08NViHgriaizW-iw-1; Mon, 22 Jan 2024 02:57:22 -0500
X-MC-Unique: H5rvpJ08NViHgriaizW-iw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dbd093c2baso529635b3a.3
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 23:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910241; x=1706515041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcjJhXadeqF54swuXOqN0DiEs6FdnKgQxq8VgnzlUIY=;
        b=HFqMYi/0wAChnZUbLRk+KVZlGVJJA/WIY01S0fDkAu5sZcXcAFIrqGiwTS7+YaeF3V
         MSc9ivrxJ/WNnVfTPdkqwlj9buexO0dv98OTfNfrFrtUFxDy+wlpBBQ8prouXILRqF97
         km8wnz6C1TNdMzW+a5uS21tf7S0wizwOVpMlXyzwQzQabdtBVzj51rhvvB6QyAqBRQrC
         QPH2Rv7/ch5t3Q39f9YoMwHfp1icyGnOk+on87fIqH2QyIBxUZ2ZsrC+jyDHJ9CNv6yo
         O7dUA68KatvG83Cj1Inec9v4KsxmFVjxTHbPe8YIxunwtcies5sExPq5gqHPGS0vWBot
         ltgg==
X-Gm-Message-State: AOJu0Yxq1RjEG2J7sGLuSvd23nl47/CuneGO1/2nToIFViMdQGM9elti
	UkO/UYY9OP9SuFN/JHKYL/XS8PIB6l8akr2LiMdxvRCnrUQZrQiV/KKmRIaBw/wJHT3hf6EeBHG
	9E3OGq17nxx/GSdLAlQKPFiAqKrS9gFLeEARoyh41FreXAdCFn9kOjSf7BFI8hoEc/rvsezmZwe
	ddb8y2JqHgRFPkOptAxT21Prk8XzYu
X-Received: by 2002:aa7:930c:0:b0:6db:cade:b92 with SMTP id cz12-20020aa7930c000000b006dbcade0b92mr1426598pfb.32.1705910241322;
        Sun, 21 Jan 2024 23:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNnN2g54ReIVGG+knzMh6IZCuuvqs6WaseAc0H/OQAqAWfr/UZZ30+mTt3EjAbXPMBVV+XJp/go8S/nPthdlU=
X-Received: by 2002:aa7:930c:0:b0:6db:cade:b92 with SMTP id
 cz12-20020aa7930c000000b006dbcade0b92mr1426588pfb.32.1705910240975; Sun, 21
 Jan 2024 23:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev> <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch> <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
 <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
 <1705895881.6990144-1-xuanzhuo@linux.alibaba.com> <CACGkMEvvn76w+BZArOWK-c1gsqNNx6bH8HPoqPAqpJG_7EYntA@mail.gmail.com>
 <1705904164.7020166-3-xuanzhuo@linux.alibaba.com> <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
 <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com>
 <1705906930.2143333-5-xuanzhuo@linux.alibaba.com> <CACGkMEuO2wO-kwMWdR9hFSCJwLUN5jwKxCCaAmxJOB8sm5bfoA@mail.gmail.com>
 <1705908305.1535513-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705908305.1535513-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 15:57:08 +0800
Message-ID: <CACGkMEvRQfSN0S0r4nXNHS1A2LzjhSfL4-1bFrYx4y0yM9yOag@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:36=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 22 Jan 2024 15:19:12 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jan 22, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@=
linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanj=
un.zhu@linux.dev> wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=
=93:
> > > > > > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &=
&
> > > > > > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > >>>>> +        if (timeout)
> > > > > > > > > > >>>>> +            timeout--;
> > > > > > > > > > >>>> This is not really a timeout, just a loop counter.=
 200 iterations could
> > > > > > > > > > >>>> be a very short time on reasonable H/W. I guess th=
is avoid the soft
> > > > > > > > > > >>>> lockup, but possibly (likely?) breaks the function=
ality when we need to
> > > > > > > > > > >>>> loop for some non negligible time.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> I fear we need a more complex solution, as mention=
ed by Micheal in the
> > > > > > > > > > >>>> thread you quoted.
> > > > > > > > > > >>> Got it. I also look forward to the more complex sol=
ution to this problem.
> > > > > > > > > > >> Can we add a device capability (new feature bit) suc=
h as ctrq_wait_timeout
> > > > > > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > > > > > The usual solution to this is include/linux/iopoll.h.=
 If you can sleep
> > > > > > > > > > > read_poll_timeout() otherwise read_poll_timeout_atomi=
c().
> > > > > > > > > >
> > > > > > > > > > I read carefully the functions read_poll_timeout() and
> > > > > > > > > > read_poll_timeout_atomic(). The timeout is set by the c=
aller of the 2
> > > > > > > > > > functions.
> > > > > > > > >
> > > > > > > > > FYI, in order to avoid a swtich of atomic or not, we need=
 convert rx
> > > > > > > > > mode setting to workqueue first:
> > > > > > > > >
> > > > > > > > > https://www.mail-archive.com/virtualization@lists.linux-f=
oundation.org/msg60298.html
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > As such, can we add a module parameter to customize thi=
s timeout value
> > > > > > > > > > by the user?
> > > > > > > > >
> > > > > > > > > Who is the "user" here, or how can the "user" know the va=
lue?
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Or this timeout value is stored in device register, vir=
tio_net driver
> > > > > > > > > > will read this timeout value at initialization?
> > > > > > > > >
> > > > > > > > > See another thread. The design needs to be general, or yo=
u can post a RFC.
> > > > > > > > >
> > > > > > > > > In another thought, we've already had a tx watchdog, mayb=
e we can have
> > > > > > > > > something similar to cvq and use timeout + reset in that =
case.
> > > > > > > >
> > > > > > > > But we may block by the reset ^_^ if the device is broken?
> > > > > > >
> > > > > > > I mean vq reset here.
> > > > > >
> > > > > > I see.
> > > > > >
> > > > > > I mean when the deivce is broken, the vq reset also many be blo=
cked.
> > > > > >
> > > > > >         void vp_modern_set_queue_reset(struct virtio_pci_modern=
_device *mdev, u16 index)
> > > > > >         {
> > > > > >                 struct virtio_pci_modern_common_cfg __iomem *cf=
g;
> > > > > >
> > > > > >                 cfg =3D (struct virtio_pci_modern_common_cfg __=
iomem *)mdev->common;
> > > > > >
> > > > > >                 vp_iowrite16(index, &cfg->cfg.queue_select);
> > > > > >                 vp_iowrite16(1, &cfg->queue_reset);
> > > > > >
> > > > > >                 while (vp_ioread16(&cfg->queue_reset))
> > > > > >                         msleep(1);
> > > > > >
> > > > > >                 while (vp_ioread16(&cfg->cfg.queue_enable))
> > > > > >                         msleep(1);
> > > > > >         }
> > > > > >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > > > >
> > > > > > In this function, for the broken device, we can not expect some=
thing.
> > > > >
> > > > > Yes, it's best effort, there's no guarantee then. But it doesn't =
harm to try.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > It looks like we have multiple goals here
> > > > > > >
> > > > > > > 1) avoid lockups, using workqueue + cond_resched() seems to b=
e
> > > > > > > sufficient, it has issue but nothing new
> > > > > > > 2) recover from the unresponsive device, the issue for timeou=
t is that
> > > > > > > it needs to deal with false positives
> > > > > >
> > > > > >
> > > > > > I agree.
> > > > > >
> > > > > > But I want to add a new goal, cvq async. In the netdim, we will
> > > > > > send many requests via the cvq, so the cvq async will be nice.
> > > >
> > > > Then you need an interrupt for cvq.
> > > >
> > > > FYI, I've posted a series that use interrupt for cvq in the past:
> > > >
> > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@r=
edhat.com/t/
> > >
> > > I know this. But the interrupt maybe not a good solution without new =
space.
> >
> > What do you mean by "new space"?
>
> Yes, I know, the cvq can work with interrupt by the virtio spec.
> But as I know, many hypervisors implement the cvq without supporting inte=
rrupt.

It's a bug of the hypervisor that needs to be fix. Interrupt is
provided by transport not the virtio itself.

Otherwise it can only support for Linux but not other OSes.

> If we let the cvq work with interrupt without negotiation then
> many hypervisors will hang on the new kernel.
>
> >
> > We can introduce something like enable_cb_delayed(), then you will
> > only get notified after several requests.
> >
> > >
> > > >
> > > > Haven't found time in working on this anymore, maybe we can start f=
rom
> > > > this or not.
> > >
> > >
> > > I said async, but my aim is to put many requests to the cvq before ge=
tting the
> > > response.
> >
> > It doesn't differ from TX/RX in this case.
> >
> > >
> > > Heng Qi posted this https://lore.kernel.org/all/1705410693-118895-4-g=
it-send-email-hengqi@linux.alibaba.com/
> > >
> >
> > This seems like a hack, if interrupt is used, you can simply do that
> > in the callback.
>
> YES.
>
> I also want to change the code, I just want to say the async is a goal.
>
> For the rx mode, we have introduce a work queue, I want to move the
> sending command job to the work queue. The caller just wakeup
> the work queue.
>
> If the caller want to got the result sync, then the caller can wait for i=
t.
> If not, the caller can register an function to the work queue.
>
> And I think it will be easy to implement the timeout inside the workqueue=
.

Looks much more complicated than a simple interrupt + timer/watchdog etc.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thans
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Zhu Yanjun
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >       Andrew
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > >
> > >
> >
>


