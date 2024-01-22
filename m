Return-Path: <netdev+bounces-64566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A2835B52
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6573628104E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E874DDB6;
	Mon, 22 Jan 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7UidyCb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A949D282
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906717; cv=none; b=H+jqLg6A7LQLWun2flhBaI3yG8ydmqHiVjY7CFqDdH8rTrlxsICyhDH4/zQOKS/03MsZkxNO80cQBHKpu6Gg+pyGs9/v1Sdr+3ujBhzCG9G1tvlAYqi25jneuORirU10ibTmgHdFRd0JK3BtkeKdLri30g+UuUFA15mpsa3rtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906717; c=relaxed/simple;
	bh=4mwx/K/ZKYPr5h01zijQABIEvpyfPKmLpduw4ljxofU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUaWCzK55tqoTXNH7lj8lIU7U1iJ3flK6ROtFa/nJkS9Ib6++rJ2/GZW8MwXHZk/ubn1cShVCw9OUZB5TaVgquTBGcyJOlHV4C4SkkNEhrCLNXi8SHSAaBDLzSiAYypQkZHUNgMF7nNMp3l12wCMtRTw/ueYDj6Z79yCUxuN2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7UidyCb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705906715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02j9dw3Lf+4L5Y31Zl3/fTa1QTJheCfhM5Fidj3FaLw=;
	b=Q7UidyCbqPSy9bHNPv43qVITtsxCVbR0S6cBacC/NeneTsyobmwmP5VS1/Pi4qhnUD6Xur
	7WgPGPgzW9YHTPSd00+DoByE+S/DkwwDJURexdiAfcZxDjsaZzvDMtz40aPfD3XCeOGDvx
	4UhDwmwgtwxkXogSyIJSg2HKzSne094=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-FQwQKHl7OHyYImHe8BlD1Q-1; Mon, 22 Jan 2024 01:58:31 -0500
X-MC-Unique: FQwQKHl7OHyYImHe8BlD1Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6dbd35c052eso1936312b3a.0
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 22:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906710; x=1706511510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02j9dw3Lf+4L5Y31Zl3/fTa1QTJheCfhM5Fidj3FaLw=;
        b=gbbLRwZvPt2sRXRwM7CkoS9hBo7zq98nrXcCnDvtuMowCgWdzaGXurJpbUCJA75kQB
         hCBCT5Pfiht4V5aKqU96MLmjk1vq7BmqyxM7hHxRu7VWcCO6ahjg4izLQsyHUHFTOzqX
         u51l/d38NBVIpUGh5JCYLO4EFvY8umKy7NqcWnltf1Wv297HKz3IXCLGZyrYHlT5SiaK
         l8avMRPpQLrlcgfhcvNM4TEFDHkaE/Dt6tTlZ0XwK+PVMOBxUr3fqm2ChyPay9uohKTS
         MvXcMoqThNJAo04GrfEKYvXtOLSjKvCIGA15pLGr4/XX/lm2OG0Bt9z7b6mhu/YTfa53
         iVsw==
X-Gm-Message-State: AOJu0YxI0OuM+HFzt1/h3o+Va7ZUOrKHewdWR3xobdzziTyxA3M89VFU
	wIZXRZO3zqTz8pdgQvS8G5bG0AuyT/q6eVgkCGyvr7htDPGObqaUVUc7W5nLyq7RTXFuGd4AFor
	Jl+T1ywuAdkuv2OHcKfP4fRYyBd8E2k9ocmKPQ5RM/HS6bIP9yJdMinBCpg4JwTsUC2CFw+NtQo
	tP2dkWHzKKc7F6SGTkuWaQRZcSuZdkqncjrLFxZo4=
X-Received: by 2002:a05:6a00:1a8c:b0:6db:4b64:481c with SMTP id e12-20020a056a001a8c00b006db4b64481cmr5485349pfv.24.1705906710439;
        Sun, 21 Jan 2024 22:58:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEneNIqkylOjOgaqm62vgcmyRwD94cAwueI+HK359j9SOu6AGP9kK+Oypz+0b7e03uyqn5da+lS1sp8jMGlivc=
X-Received: by 2002:a05:6a00:1a8c:b0:6db:4b64:481c with SMTP id
 e12-20020a056a001a8c00b006db4b64481cmr5485340pfv.24.1705906710148; Sun, 21
 Jan 2024 22:58:30 -0800 (PST)
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
In-Reply-To: <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 14:58:09 +0800
Message-ID: <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu@l=
inux.dev> wrote:
> > > > > >
> > > > > >
> > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > >>>>> +        if (timeout)
> > > > > > >>>>> +            timeout--;
> > > > > > >>>> This is not really a timeout, just a loop counter. 200 ite=
rations could
> > > > > > >>>> be a very short time on reasonable H/W. I guess this avoid=
 the soft
> > > > > > >>>> lockup, but possibly (likely?) breaks the functionality wh=
en we need to
> > > > > > >>>> loop for some non negligible time.
> > > > > > >>>>
> > > > > > >>>> I fear we need a more complex solution, as mentioned by Mi=
cheal in the
> > > > > > >>>> thread you quoted.
> > > > > > >>> Got it. I also look forward to the more complex solution to=
 this problem.
> > > > > > >> Can we add a device capability (new feature bit) such as ctr=
q_wait_timeout
> > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > The usual solution to this is include/linux/iopoll.h. If you =
can sleep
> > > > > > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> > > > > >
> > > > > > I read carefully the functions read_poll_timeout() and
> > > > > > read_poll_timeout_atomic(). The timeout is set by the caller of=
 the 2
> > > > > > functions.
> > > > >
> > > > > FYI, in order to avoid a swtich of atomic or not, we need convert=
 rx
> > > > > mode setting to workqueue first:
> > > > >
> > > > > https://www.mail-archive.com/virtualization@lists.linux-foundatio=
n.org/msg60298.html
> > > > >
> > > > > >
> > > > > > As such, can we add a module parameter to customize this timeou=
t value
> > > > > > by the user?
> > > > >
> > > > > Who is the "user" here, or how can the "user" know the value?
> > > > >
> > > > > >
> > > > > > Or this timeout value is stored in device register, virtio_net =
driver
> > > > > > will read this timeout value at initialization?
> > > > >
> > > > > See another thread. The design needs to be general, or you can po=
st a RFC.
> > > > >
> > > > > In another thought, we've already had a tx watchdog, maybe we can=
 have
> > > > > something similar to cvq and use timeout + reset in that case.
> > > >
> > > > But we may block by the reset ^_^ if the device is broken?
> > >
> > > I mean vq reset here.
> >
> > I see.
> >
> > I mean when the deivce is broken, the vq reset also many be blocked.
> >
> >         void vp_modern_set_queue_reset(struct virtio_pci_modern_device =
*mdev, u16 index)
> >         {
> >                 struct virtio_pci_modern_common_cfg __iomem *cfg;
> >
> >                 cfg =3D (struct virtio_pci_modern_common_cfg __iomem *)=
mdev->common;
> >
> >                 vp_iowrite16(index, &cfg->cfg.queue_select);
> >                 vp_iowrite16(1, &cfg->queue_reset);
> >
> >                 while (vp_ioread16(&cfg->queue_reset))
> >                         msleep(1);
> >
> >                 while (vp_ioread16(&cfg->cfg.queue_enable))
> >                         msleep(1);
> >         }
> >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> >
> > In this function, for the broken device, we can not expect something.
>
> Yes, it's best effort, there's no guarantee then. But it doesn't harm to =
try.
>
> Thanks
>
> >
> >
> > >
> > > It looks like we have multiple goals here
> > >
> > > 1) avoid lockups, using workqueue + cond_resched() seems to be
> > > sufficient, it has issue but nothing new
> > > 2) recover from the unresponsive device, the issue for timeout is tha=
t
> > > it needs to deal with false positives
> >
> >
> > I agree.
> >
> > But I want to add a new goal, cvq async. In the netdim, we will
> > send many requests via the cvq, so the cvq async will be nice.

Then you need an interrupt for cvq.

FYI, I've posted a series that use interrupt for cvq in the past:

https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.co=
m/t/

Haven't found time in working on this anymore, maybe we can start from
this or not.

Thanks

> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Thans
> > > > >
> > > > > >
> > > > > > Zhu Yanjun
> > > > > >
> > > > > > >
> > > > > > >       Andrew
> > > > > >
> > > > >
> > > >
> > >
> >


