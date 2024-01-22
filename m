Return-Path: <netdev+bounces-64565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FAB835B4D
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 07:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33E61F20C3D
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD6D282;
	Mon, 22 Jan 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hvc95bFy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2EF9E6
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906566; cv=none; b=n6YWhqPLkI30KBO6RIQ2aWHfbPAFW12tYpgZYCCR4vS9JPtwPwyxVX8SuV8GEMpAPZFMZDMrOoV1pVVJ3Dm3q+MKQ/Xks7+P76u0+2akpS44gkvGVss8ebXfGMI/8xhyJt3kXWEfSbEf53T1x2cAVj0P6kaNFKf6qIFfeg1Kbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906566; c=relaxed/simple;
	bh=yHGw2+v8p9VMvpwklHnBGyUJGqFxCS4szDR8xKpZYxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgwaqaYsH4zbm8KbuaFqbyECMw056RYLMphzVnEBfA/I14QgQEjejLFmqjIn5eD+e9D3VJ32hlzhSuK1XHKMo18hl9TpaGY2jiJ7Yaq206Q0wNLCcHwQ4Nser7ZCHZxKNG17FliL1YsY1VwxqjnLil7nV2A8u4CCk9khgYhKv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hvc95bFy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705906563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtLnLy8EYyovFLNBqJ/6kUkUH1TTl9B7z931Cm9/Gc4=;
	b=Hvc95bFyaqNWeb5RmR3gOc3xr0ftYaSIoCW/m2jjDJdqsVUgJS1JgYtNMaN60ji4hwr+xv
	M1KGyadjRP61P4YYqG+4IOasuuiNlid2PutcSP1oFzTKjqr9QK/FzEsTVItENFGiEe5jBF
	IGHW6eu6ijnRqZYxgGPN+wPNZOcxybg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-2AWPH7tBMZqnUm9aS7J7Qw-1; Mon, 22 Jan 2024 01:56:00 -0500
X-MC-Unique: 2AWPH7tBMZqnUm9aS7J7Qw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2904fe6c360so1181244a91.2
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 22:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906559; x=1706511359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtLnLy8EYyovFLNBqJ/6kUkUH1TTl9B7z931Cm9/Gc4=;
        b=YL3m1y+5+FkjgFKsBqNmnvpYBSFKzTzTJZghLO9kuystWaJwQhxf+tJxrNxZU7BH4Y
         Xx7na4QsoBB2vVtYTjT7uLtCmNqvk5cNf/iMD/lTaJxf4dym2BpyD61xyqVt7k1lSaot
         HygmhZbe//IFO0LmqVpj5mSwEaqV1AS25CPW6evMJh2OWEXyZcOKhZ6zl/qmD9CIclAE
         g9ddGThUH5LZqB0IKAPoqxgyKijYdVWJgTQl1No2hcf1Kay1WysIn1T+PMLlLSZh28nH
         hv7gOlD/R8bSUR+qpALZ93TH/t0d21ZoMPaoZGquzszGCzMXrvXAZr0YCXkaDGbBlm2s
         nsKQ==
X-Gm-Message-State: AOJu0Yx3QH3Vtj1dSj/bSr+HL+Y3WnwNXngMk7byT8dOympOiQaZPYFz
	qPyVyXYtfY40bF9H2kNT5lwFWAIjHdDk3qMOAt6dt3Z8TSOQ3kqH/IVKHK1JN4sKPg9LWUsUuxH
	fxymVO4SDT9KmLADwTJ4iI39XAig6YrVsd+zwGVkoGzdad56H1FaS6WA1KfJORPKLntN3GpO9Yp
	torlrCl2pAI/PkBJLAEJOoDsxxuVBK
X-Received: by 2002:a17:90b:216:b0:290:2921:6bcc with SMTP id fy22-20020a17090b021600b0029029216bccmr940831pjb.74.1705906559558;
        Sun, 21 Jan 2024 22:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu/tVICQ8Ja2Q+KITwjBCNBxyB+AjfEL4OA7NNG2AX136AjQZQlG5ehwfcxnyGKkxhDRcneCXb42vg0bmJrow=
X-Received: by 2002:a17:90b:216:b0:290:2921:6bcc with SMTP id
 fy22-20020a17090b021600b0029029216bccmr940825pjb.74.1705906559293; Sun, 21
 Jan 2024 22:55:59 -0800 (PST)
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
 <1705904164.7020166-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705904164.7020166-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 14:55:46 +0800
Message-ID: <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu@lin=
ux.dev> wrote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > >>>>> +        if (timeout)
> > > > > >>>>> +            timeout--;
> > > > > >>>> This is not really a timeout, just a loop counter. 200 itera=
tions could
> > > > > >>>> be a very short time on reasonable H/W. I guess this avoid t=
he soft
> > > > > >>>> lockup, but possibly (likely?) breaks the functionality when=
 we need to
> > > > > >>>> loop for some non negligible time.
> > > > > >>>>
> > > > > >>>> I fear we need a more complex solution, as mentioned by Mich=
eal in the
> > > > > >>>> thread you quoted.
> > > > > >>> Got it. I also look forward to the more complex solution to t=
his problem.
> > > > > >> Can we add a device capability (new feature bit) such as ctrq_=
wait_timeout
> > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > The usual solution to this is include/linux/iopoll.h. If you ca=
n sleep
> > > > > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> > > > >
> > > > > I read carefully the functions read_poll_timeout() and
> > > > > read_poll_timeout_atomic(). The timeout is set by the caller of t=
he 2
> > > > > functions.
> > > >
> > > > FYI, in order to avoid a swtich of atomic or not, we need convert r=
x
> > > > mode setting to workqueue first:
> > > >
> > > > https://www.mail-archive.com/virtualization@lists.linux-foundation.=
org/msg60298.html
> > > >
> > > > >
> > > > > As such, can we add a module parameter to customize this timeout =
value
> > > > > by the user?
> > > >
> > > > Who is the "user" here, or how can the "user" know the value?
> > > >
> > > > >
> > > > > Or this timeout value is stored in device register, virtio_net dr=
iver
> > > > > will read this timeout value at initialization?
> > > >
> > > > See another thread. The design needs to be general, or you can post=
 a RFC.
> > > >
> > > > In another thought, we've already had a tx watchdog, maybe we can h=
ave
> > > > something similar to cvq and use timeout + reset in that case.
> > >
> > > But we may block by the reset ^_^ if the device is broken?
> >
> > I mean vq reset here.
>
> I see.
>
> I mean when the deivce is broken, the vq reset also many be blocked.
>
>         void vp_modern_set_queue_reset(struct virtio_pci_modern_device *m=
dev, u16 index)
>         {
>                 struct virtio_pci_modern_common_cfg __iomem *cfg;
>
>                 cfg =3D (struct virtio_pci_modern_common_cfg __iomem *)md=
ev->common;
>
>                 vp_iowrite16(index, &cfg->cfg.queue_select);
>                 vp_iowrite16(1, &cfg->queue_reset);
>
>                 while (vp_ioread16(&cfg->queue_reset))
>                         msleep(1);
>
>                 while (vp_ioread16(&cfg->cfg.queue_enable))
>                         msleep(1);
>         }
>         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
>
> In this function, for the broken device, we can not expect something.

Yes, it's best effort, there's no guarantee then. But it doesn't harm to tr=
y.

Thanks

>
>
> >
> > It looks like we have multiple goals here
> >
> > 1) avoid lockups, using workqueue + cond_resched() seems to be
> > sufficient, it has issue but nothing new
> > 2) recover from the unresponsive device, the issue for timeout is that
> > it needs to deal with false positives
>
>
> I agree.
>
> But I want to add a new goal, cvq async. In the netdim, we will
> send many requests via the cvq, so the cvq async will be nice.
>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thans
> > > >
> > > > >
> > > > > Zhu Yanjun
> > > > >
> > > > > >
> > > > > >       Andrew
> > > > >
> > > >
> > >
> >
>


