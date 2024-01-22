Return-Path: <netdev+bounces-64569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08020835B6A
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D191F21EED
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12924E554;
	Mon, 22 Jan 2024 07:12:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E18DF6E
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907539; cv=none; b=ewrrLYkEV7Ihctpm0uOuO61SunSDGjZ4S94RhWviHtHYFQWm/K6O9PAuWhU0HtV98l1+lY1bUjPkxy6329Mi5Oo9VQFcMPPtURMrB0kxcDYA8ZkCBpgtonZAEfJ8XkgDdOqzgm2STz6F9yny0vBGbJRR3gJx9kkwCKN/tnIMCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907539; c=relaxed/simple;
	bh=5TKqAWVs55lchICqxGsxk0ZeT7m9HqP3li9rplBM75g=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=rbUFuw5++VMyepqHR6bU1oJ1Go/e/7AWB1u9G4lgnys2app2TY6VdoHFrkGz4DL0pIEP9+44oxbEixpEh0I32wrb+GS7/sdp625GCQ76tL4y0zLynUZsBbZlWukEQvmN9UijTrnfjSSoER3tJGmlh4Mv/I60ov2dr4r9pFbuCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W.2pvmj_1705907214;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.2pvmj_1705907214)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 15:06:55 +0800
Message-ID: <1705906930.2143333-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
Date: Mon, 22 Jan 2024 15:02:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Heng Qi <hengqi@linux.alibaba.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev>
 <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
 <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
 <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
 <1705895881.6990144-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvvn76w+BZArOWK-c1gsqNNx6bH8HPoqPAqpJG_7EYntA@mail.gmail.com>
 <1705904164.7020166-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
 <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com>
In-Reply-To: <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu=
@linux.dev> wrote:
> > > > > > >
> > > > > > >
> > > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > > >>>>> +        if (timeout)
> > > > > > > >>>>> +            timeout--;
> > > > > > > >>>> This is not really a timeout, just a loop counter. 200 i=
terations could
> > > > > > > >>>> be a very short time on reasonable H/W. I guess this avo=
id the soft
> > > > > > > >>>> lockup, but possibly (likely?) breaks the functionality =
when we need to
> > > > > > > >>>> loop for some non negligible time.
> > > > > > > >>>>
> > > > > > > >>>> I fear we need a more complex solution, as mentioned by =
Micheal in the
> > > > > > > >>>> thread you quoted.
> > > > > > > >>> Got it. I also look forward to the more complex solution =
to this problem.
> > > > > > > >> Can we add a device capability (new feature bit) such as c=
trq_wait_timeout
> > > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > > The usual solution to this is include/linux/iopoll.h. If yo=
u can sleep
> > > > > > > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> > > > > > >
> > > > > > > I read carefully the functions read_poll_timeout() and
> > > > > > > read_poll_timeout_atomic(). The timeout is set by the caller =
of the 2
> > > > > > > functions.
> > > > > >
> > > > > > FYI, in order to avoid a swtich of atomic or not, we need conve=
rt rx
> > > > > > mode setting to workqueue first:
> > > > > >
> > > > > > https://www.mail-archive.com/virtualization@lists.linux-foundat=
ion.org/msg60298.html
> > > > > >
> > > > > > >
> > > > > > > As such, can we add a module parameter to customize this time=
out value
> > > > > > > by the user?
> > > > > >
> > > > > > Who is the "user" here, or how can the "user" know the value?
> > > > > >
> > > > > > >
> > > > > > > Or this timeout value is stored in device register, virtio_ne=
t driver
> > > > > > > will read this timeout value at initialization?
> > > > > >
> > > > > > See another thread. The design needs to be general, or you can =
post a RFC.
> > > > > >
> > > > > > In another thought, we've already had a tx watchdog, maybe we c=
an have
> > > > > > something similar to cvq and use timeout + reset in that case.
> > > > >
> > > > > But we may block by the reset ^_^ if the device is broken?
> > > >
> > > > I mean vq reset here.
> > >
> > > I see.
> > >
> > > I mean when the deivce is broken, the vq reset also many be blocked.
> > >
> > >         void vp_modern_set_queue_reset(struct virtio_pci_modern_devic=
e *mdev, u16 index)
> > >         {
> > >                 struct virtio_pci_modern_common_cfg __iomem *cfg;
> > >
> > >                 cfg =3D (struct virtio_pci_modern_common_cfg __iomem =
*)mdev->common;
> > >
> > >                 vp_iowrite16(index, &cfg->cfg.queue_select);
> > >                 vp_iowrite16(1, &cfg->queue_reset);
> > >
> > >                 while (vp_ioread16(&cfg->queue_reset))
> > >                         msleep(1);
> > >
> > >                 while (vp_ioread16(&cfg->cfg.queue_enable))
> > >                         msleep(1);
> > >         }
> > >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > >
> > > In this function, for the broken device, we can not expect something.
> >
> > Yes, it's best effort, there's no guarantee then. But it doesn't harm t=
o try.
> >
> > Thanks
> >
> > >
> > >
> > > >
> > > > It looks like we have multiple goals here
> > > >
> > > > 1) avoid lockups, using workqueue + cond_resched() seems to be
> > > > sufficient, it has issue but nothing new
> > > > 2) recover from the unresponsive device, the issue for timeout is t=
hat
> > > > it needs to deal with false positives
> > >
> > >
> > > I agree.
> > >
> > > But I want to add a new goal, cvq async. In the netdim, we will
> > > send many requests via the cvq, so the cvq async will be nice.
>
> Then you need an interrupt for cvq.
>
> FYI, I've posted a series that use interrupt for cvq in the past:
>
> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.=
com/t/

I know this. But the interrupt maybe not a good solution without new space.

>
> Haven't found time in working on this anymore, maybe we can start from
> this or not.


I said async, but my aim is to put many requests to the cvq before getting =
the
response.

Heng Qi posted this https://lore.kernel.org/all/1705410693-118895-4-git-sen=
d-email-hengqi@linux.alibaba.com/

Thanks.


>
> Thanks
>
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Thans
> > > > > >
> > > > > > >
> > > > > > > Zhu Yanjun
> > > > > > >
> > > > > > > >
> > > > > > > >       Andrew
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>

