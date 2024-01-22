Return-Path: <netdev+bounces-64573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78910835BB4
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BDC1F21F69
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FD111BB;
	Mon, 22 Jan 2024 07:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48802107B2
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908950; cv=none; b=KKeGy3ai6JL06htfQ/UEyA26VOLsC0Wdcv/6jR+/icE7aM1tYybtayl+Sj1qaRFGxh817zvT+5CaMJw7hw7LT1sr+Y0ISiwceoEyVq101fKrHkk3OHd9mbXdbSjoBKrrLq9QUA+Ei1A7n2isf31XXFI+jVyult1kdo8VgH5lCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908950; c=relaxed/simple;
	bh=k8z2Iik+KlmAB+9Xa/+jhUTSPbRw4llxLfLbtQ3LfoY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=fwC04QOzkZysqvYwrlf0lNnHz6IF9SztP6sVTQotTQ2+qRbKpyi9Sg3NH1LBp8FLGtVSM3NzNs6y4EeBCfIfgTZjAGpDLb7yhlTCUNI0AyhHy2w2rpzyGH6eQVl4PNnNbVV3GoY4TbLCSWxswqUlP/jYQMYRqbXCdm+z6cQWTFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W.3mrKp_1705908942;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.3mrKp_1705908942)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 15:35:43 +0800
Message-ID: <1705908305.1535513-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
Date: Mon, 22 Jan 2024 15:25:05 +0800
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
 <1705906930.2143333-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEuO2wO-kwMWdR9hFSCJwLUN5jwKxCCaAmxJOB8sm5bfoA@mail.gmail.com>
In-Reply-To: <CACGkMEuO2wO-kwMWdR9hFSCJwLUN5jwKxCCaAmxJOB8sm5bfoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 22 Jan 2024 15:19:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 22, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun=
.zhu@linux.dev> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > > > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > >>>>> +        if (timeout)
> > > > > > > > > >>>>> +            timeout--;
> > > > > > > > > >>>> This is not really a timeout, just a loop counter. 2=
00 iterations could
> > > > > > > > > >>>> be a very short time on reasonable H/W. I guess this=
 avoid the soft
> > > > > > > > > >>>> lockup, but possibly (likely?) breaks the functional=
ity when we need to
> > > > > > > > > >>>> loop for some non negligible time.
> > > > > > > > > >>>>
> > > > > > > > > >>>> I fear we need a more complex solution, as mentioned=
 by Micheal in the
> > > > > > > > > >>>> thread you quoted.
> > > > > > > > > >>> Got it. I also look forward to the more complex solut=
ion to this problem.
> > > > > > > > > >> Can we add a device capability (new feature bit) such =
as ctrq_wait_timeout
> > > > > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > > > > The usual solution to this is include/linux/iopoll.h. I=
f you can sleep
> > > > > > > > > > read_poll_timeout() otherwise read_poll_timeout_atomic(=
).
> > > > > > > > >
> > > > > > > > > I read carefully the functions read_poll_timeout() and
> > > > > > > > > read_poll_timeout_atomic(). The timeout is set by the cal=
ler of the 2
> > > > > > > > > functions.
> > > > > > > >
> > > > > > > > FYI, in order to avoid a swtich of atomic or not, we need c=
onvert rx
> > > > > > > > mode setting to workqueue first:
> > > > > > > >
> > > > > > > > https://www.mail-archive.com/virtualization@lists.linux-fou=
ndation.org/msg60298.html
> > > > > > > >
> > > > > > > > >
> > > > > > > > > As such, can we add a module parameter to customize this =
timeout value
> > > > > > > > > by the user?
> > > > > > > >
> > > > > > > > Who is the "user" here, or how can the "user" know the valu=
e?
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Or this timeout value is stored in device register, virti=
o_net driver
> > > > > > > > > will read this timeout value at initialization?
> > > > > > > >
> > > > > > > > See another thread. The design needs to be general, or you =
can post a RFC.
> > > > > > > >
> > > > > > > > In another thought, we've already had a tx watchdog, maybe =
we can have
> > > > > > > > something similar to cvq and use timeout + reset in that ca=
se.
> > > > > > >
> > > > > > > But we may block by the reset ^_^ if the device is broken?
> > > > > >
> > > > > > I mean vq reset here.
> > > > >
> > > > > I see.
> > > > >
> > > > > I mean when the deivce is broken, the vq reset also many be block=
ed.
> > > > >
> > > > >         void vp_modern_set_queue_reset(struct virtio_pci_modern_d=
evice *mdev, u16 index)
> > > > >         {
> > > > >                 struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > > >
> > > > >                 cfg =3D (struct virtio_pci_modern_common_cfg __io=
mem *)mdev->common;
> > > > >
> > > > >                 vp_iowrite16(index, &cfg->cfg.queue_select);
> > > > >                 vp_iowrite16(1, &cfg->queue_reset);
> > > > >
> > > > >                 while (vp_ioread16(&cfg->queue_reset))
> > > > >                         msleep(1);
> > > > >
> > > > >                 while (vp_ioread16(&cfg->cfg.queue_enable))
> > > > >                         msleep(1);
> > > > >         }
> > > > >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > > >
> > > > > In this function, for the broken device, we can not expect someth=
ing.
> > > >
> > > > Yes, it's best effort, there's no guarantee then. But it doesn't ha=
rm to try.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > It looks like we have multiple goals here
> > > > > >
> > > > > > 1) avoid lockups, using workqueue + cond_resched() seems to be
> > > > > > sufficient, it has issue but nothing new
> > > > > > 2) recover from the unresponsive device, the issue for timeout =
is that
> > > > > > it needs to deal with false positives
> > > > >
> > > > >
> > > > > I agree.
> > > > >
> > > > > But I want to add a new goal, cvq async. In the netdim, we will
> > > > > send many requests via the cvq, so the cvq async will be nice.
> > >
> > > Then you need an interrupt for cvq.
> > >
> > > FYI, I've posted a series that use interrupt for cvq in the past:
> > >
> > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@red=
hat.com/t/
> >
> > I know this. But the interrupt maybe not a good solution without new sp=
ace.
>
> What do you mean by "new space"?

Yes, I know, the cvq can work with interrupt by the virtio spec.
But as I know, many hypervisors implement the cvq without supporting interr=
upt.
If we let the cvq work with interrupt without negotiation then
many hypervisors will hang on the new kernel.

>
> We can introduce something like enable_cb_delayed(), then you will
> only get notified after several requests.
>
> >
> > >
> > > Haven't found time in working on this anymore, maybe we can start from
> > > this or not.
> >
> >
> > I said async, but my aim is to put many requests to the cvq before gett=
ing the
> > response.
>
> It doesn't differ from TX/RX in this case.
>
> >
> > Heng Qi posted this https://lore.kernel.org/all/1705410693-118895-4-git=
-send-email-hengqi@linux.alibaba.com/
> >
>
> This seems like a hack, if interrupt is used, you can simply do that
> in the callback.

YES.

I also want to change the code, I just want to say the async is a goal.

For the rx mode, we have introduce a work queue, I want to move the
sending command job to the work queue. The caller just wakeup
the work queue.

If the caller want to got the result sync, then the caller can wait for it.
If not, the caller can register an function to the work queue.

And I think it will be easy to implement the timeout inside the workqueue.

Thanks.


>
> Thanks
>
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thans
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Zhu Yanjun
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >       Andrew
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > >
> >
>

