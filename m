Return-Path: <netdev+bounces-64606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639B5835DE5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12101281FB5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002039856;
	Mon, 22 Jan 2024 09:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF93984F
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915016; cv=none; b=r8K023KSRXPL3miWxj1HBn1x7Vc5dLzFvWe7mORn9Hn59Hs8e9+uFYM18jjT3TwEyVbGPh9BAHW6QeZi7zJTugyQhPAidhCPP+3btqSia4mxPsNu16N9CElJCy/hcWSEe9n6av5nE0Fw0pRwjPfi3NYI7T1jQ2idmzQPKQDvBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915016; c=relaxed/simple;
	bh=HpNVXgyTdzt7tGWGUoRz7wtnHgt4ex5FhcPLj7FKQPs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=mccX3gkRc8QJuKWKhd/BlyGBvIFRMW432ZVLhX4FSVfbj6CBQwfnnAVMGLSND9SxRNuCTZtXltfU83BIJEEFDsyeidksl6r7hKoX+JegOzNSPFz/hJkJn4+Xi1qb1Mt0aJ0v0HLCinxjS9XnZj3PXAi5rBz1Jrd/5Wz6GiLAfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W.5aV37_1705915003;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.5aV37_1705915003)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 17:16:43 +0800
Message-ID: <1705914702.0358708-10-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
Date: Mon, 22 Jan 2024 17:11:42 +0800
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
 <1705908305.1535513-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEvRQfSN0S0r4nXNHS1A2LzjhSfL4-1bFrYx4y0yM9yOag@mail.gmail.com>
 <1705910488.8207285-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEu5bO_TeBuKGv0gyaUCnq=euq81y9xJ-MK=VBoCxhVe-Q@mail.gmail.com>
In-Reply-To: <CACGkMEu5bO_TeBuKGv0gyaUCnq=euq81y9xJ-MK=VBoCxhVe-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 22 Jan 2024 16:32:46 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 22, 2024 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 22 Jan 2024 15:57:08 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Jan 22, 2024 at 3:36=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Mon, 22 Jan 2024 15:19:12 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Jan 22, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xua=
nzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > > > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun=
 <yanjun.zhu@linux.dev> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=
=E9=81=93:
> > > > > > > > > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &=
tmp) &&
> > > > > > > > > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > > > > >>>>> +        if (timeout)
> > > > > > > > > > > > > >>>>> +            timeout--;
> > > > > > > > > > > > > >>>> This is not really a timeout, just a loop co=
unter. 200 iterations could
> > > > > > > > > > > > > >>>> be a very short time on reasonable H/W. I gu=
ess this avoid the soft
> > > > > > > > > > > > > >>>> lockup, but possibly (likely?) breaks the fu=
nctionality when we need to
> > > > > > > > > > > > > >>>> loop for some non negligible time.
> > > > > > > > > > > > > >>>>
> > > > > > > > > > > > > >>>> I fear we need a more complex solution, as m=
entioned by Micheal in the
> > > > > > > > > > > > > >>>> thread you quoted.
> > > > > > > > > > > > > >>> Got it. I also look forward to the more compl=
ex solution to this problem.
> > > > > > > > > > > > > >> Can we add a device capability (new feature bi=
t) such as ctrq_wait_timeout
> > > > > > > > > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > > > > > > > > The usual solution to this is include/linux/iop=
oll.h. If you can sleep
> > > > > > > > > > > > > > read_poll_timeout() otherwise read_poll_timeout=
_atomic().
> > > > > > > > > > > > >
> > > > > > > > > > > > > I read carefully the functions read_poll_timeout(=
) and
> > > > > > > > > > > > > read_poll_timeout_atomic(). The timeout is set by=
 the caller of the 2
> > > > > > > > > > > > > functions.
> > > > > > > > > > > >
> > > > > > > > > > > > FYI, in order to avoid a swtich of atomic or not, w=
e need convert rx
> > > > > > > > > > > > mode setting to workqueue first:
> > > > > > > > > > > >
> > > > > > > > > > > > https://www.mail-archive.com/virtualization@lists.l=
inux-foundation.org/msg60298.html
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > As such, can we add a module parameter to customi=
ze this timeout value
> > > > > > > > > > > > > by the user?
> > > > > > > > > > > >
> > > > > > > > > > > > Who is the "user" here, or how can the "user" know =
the value?
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Or this timeout value is stored in device registe=
r, virtio_net driver
> > > > > > > > > > > > > will read this timeout value at initialization?
> > > > > > > > > > > >
> > > > > > > > > > > > See another thread. The design needs to be general,=
 or you can post a RFC.
> > > > > > > > > > > >
> > > > > > > > > > > > In another thought, we've already had a tx watchdog=
, maybe we can have
> > > > > > > > > > > > something similar to cvq and use timeout + reset in=
 that case.
> > > > > > > > > > >
> > > > > > > > > > > But we may block by the reset ^_^ if the device is br=
oken?
> > > > > > > > > >
> > > > > > > > > > I mean vq reset here.
> > > > > > > > >
> > > > > > > > > I see.
> > > > > > > > >
> > > > > > > > > I mean when the deivce is broken, the vq reset also many =
be blocked.
> > > > > > > > >
> > > > > > > > >         void vp_modern_set_queue_reset(struct virtio_pci_=
modern_device *mdev, u16 index)
> > > > > > > > >         {
> > > > > > > > >                 struct virtio_pci_modern_common_cfg __iom=
em *cfg;
> > > > > > > > >
> > > > > > > > >                 cfg =3D (struct virtio_pci_modern_common_=
cfg __iomem *)mdev->common;
> > > > > > > > >
> > > > > > > > >                 vp_iowrite16(index, &cfg->cfg.queue_selec=
t);
> > > > > > > > >                 vp_iowrite16(1, &cfg->queue_reset);
> > > > > > > > >
> > > > > > > > >                 while (vp_ioread16(&cfg->queue_reset))
> > > > > > > > >                         msleep(1);
> > > > > > > > >
> > > > > > > > >                 while (vp_ioread16(&cfg->cfg.queue_enable=
))
> > > > > > > > >                         msleep(1);
> > > > > > > > >         }
> > > > > > > > >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > > > > > > >
> > > > > > > > > In this function, for the broken device, we can not expec=
t something.
> > > > > > > >
> > > > > > > > Yes, it's best effort, there's no guarantee then. But it do=
esn't harm to try.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > It looks like we have multiple goals here
> > > > > > > > > >
> > > > > > > > > > 1) avoid lockups, using workqueue + cond_resched() seem=
s to be
> > > > > > > > > > sufficient, it has issue but nothing new
> > > > > > > > > > 2) recover from the unresponsive device, the issue for =
timeout is that
> > > > > > > > > > it needs to deal with false positives
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I agree.
> > > > > > > > >
> > > > > > > > > But I want to add a new goal, cvq async. In the netdim, w=
e will
> > > > > > > > > send many requests via the cvq, so the cvq async will be =
nice.
> > > > > > >
> > > > > > > Then you need an interrupt for cvq.
> > > > > > >
> > > > > > > FYI, I've posted a series that use interrupt for cvq in the p=
ast:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a8036=
8621@redhat.com/t/
> > > > > >
> > > > > > I know this. But the interrupt maybe not a good solution withou=
t new space.
> > > > >
> > > > > What do you mean by "new space"?
> > > >
> > > > Yes, I know, the cvq can work with interrupt by the virtio spec.
> > > > But as I know, many hypervisors implement the cvq without supportin=
g interrupt.
> > >
> > > It's a bug of the hypervisor that needs to be fix. Interrupt is
> > > provided by transport not the virtio itself.
> >
> > YES. I agree.
> >
> > But I still think we should not work with interrupt without any negotia=
tion
> > directly. I more like to introduce a new feature to enable this.
>
> I can hardly believe we need to workaround the issue of specific
> hypervisors like this...

Maybe we should hear others.

We are ok for this. I just think for other hypervisors.

Thanks.



>
> Thanks
>
> >
> > Thanks.
> >
> >
>

