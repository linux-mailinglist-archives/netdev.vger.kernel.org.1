Return-Path: <netdev+bounces-64534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D1835A02
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 05:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B88E281817
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B223F139E;
	Mon, 22 Jan 2024 04:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6tY3Ec1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD91FA1
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897005; cv=none; b=up/1etAZuNs1o3nIoYj2Ebw/BexCZMCIZomEgObKj5anVvZaLowYb/NFSQcoajyopFodLmFlJBIVH/fya3vV0erQ65YyqQDC4fAjpS4ES1pGshARotBOc5SZMp50CKqDCw2eYT4p5NkDQpYdErULN8IyF33NUBMpDVsv0uDGKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897005; c=relaxed/simple;
	bh=o0x5h+EZcHHtSi0Rep8lXojTkt6ouTC2kgcK48szp7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN0nbKCf1XR8TDW1sxVTDeTLN6TwHKgdbihHgoKQ/LfLvDPyKVyjACwrIKzTknCABEyPciuPYwuw2psEUy09TsyM3Fu1OTeXrNVJfr03oZYL/i8aPGLtrs2Xu+2IkGa4VVsdymEJOvQPmGiwqb+gvwztYu/kj6WmtCeNyMmGj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6tY3Ec1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705897002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3crGAohu+7BwIzyRFrlv6M4BXYDfV4ImBlP2pM4YuE=;
	b=P6tY3Ec1LyKqL4fo4zZR2+CSbtTYex4oiphbrqYiV9O6beaD1IgVDR/+Lu7Pf97HsNwPSj
	sZgqTvvcMZvvFRL6sY2oPNrHVntNAjFkFgyiJ8U5wcWEwYHE8o/6EAOG8ROmounDWeiBUf
	CO0sBrbsvHErXQJJcU7QXDI5QMYb91I=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-LunNDfMmOqyuC7gNeTNuLw-1; Sun, 21 Jan 2024 23:16:39 -0500
X-MC-Unique: LunNDfMmOqyuC7gNeTNuLw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6dbd35c052eso1796701b3a.0
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 20:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896999; x=1706501799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3crGAohu+7BwIzyRFrlv6M4BXYDfV4ImBlP2pM4YuE=;
        b=dzp/Yy5Uqx1MYGVrcroatDOpbhhJ8LWmP3qG2mXxFHKTwHVeJKk8p1T7O5GSjExzgj
         V2iwo30BDwpKhcq9bvspxsOaVCKBIse7ZPvSbD236Fet2+ioNtwN/lkTHufiIvHHgeZ5
         DdK2F5XsjpZt21lCJtCCLdnxnW2o2qcwqGtAAlDmJOo+JDTBOZQx+W24Au7d6xjg2nqG
         caNp63ONamPCYa+vgv9947DMU3I6PbyEKXe0yvS+EtAMjf6nvfrRb1ouHsv0Pphcmwee
         4SGAmdkFKyM7zXajmbeR7boJukbs9lMHWLkbX61kXl73n4UjP7IRDjCBB7AtQG+v1ut+
         CDIQ==
X-Gm-Message-State: AOJu0Yw6xZa1r+2zcZTbKX22OmscDQ+BJbhixcOCAiMicOxVm47LfNYp
	gVtfaEIvsru0sBpchVTNYerzOVb0gYLkiZmera43iVZ+SsT5iujW+8Y3hjP4Xp2gmnWsu+7/0D7
	+wur+EIdQYJczzvhvzWR1elSAWh/YI+zUSYh5RCzZOaiarZzDtEJRMk9a/dWTYSfmhyepWleaHJ
	HiOmAd64jP7+YDdqwY4y+hulIAHUNk
X-Received: by 2002:a05:6a20:72ab:b0:19b:1d49:e005 with SMTP id o43-20020a056a2072ab00b0019b1d49e005mr5458155pzk.19.1705896998797;
        Sun, 21 Jan 2024 20:16:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3TCK5fXtq2Iiecmr18J5qitwAabNt/hIQQRE5SugYxQ60rn0z7tf+QsTxW6u9/J00CMbZqmQeuGdN7rOzgtE=
X-Received: by 2002:a05:6a20:72ab:b0:19b:1d49:e005 with SMTP id
 o43-20020a056a2072ab00b0019b1d49e005mr5458150pzk.19.1705896998521; Sun, 21
 Jan 2024 20:16:38 -0800 (PST)
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
 <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com> <1705895881.6990144-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705895881.6990144-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:16:27 +0800
Message-ID: <CACGkMEvvn76w+BZArOWK-c1gsqNNx6bH8HPoqPAqpJG_7EYntA@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.d=
ev> wrote:
> > >
> > >
> > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > >>>>> +        if (timeout)
> > > >>>>> +            timeout--;
> > > >>>> This is not really a timeout, just a loop counter. 200 iteration=
s could
> > > >>>> be a very short time on reasonable H/W. I guess this avoid the s=
oft
> > > >>>> lockup, but possibly (likely?) breaks the functionality when we =
need to
> > > >>>> loop for some non negligible time.
> > > >>>>
> > > >>>> I fear we need a more complex solution, as mentioned by Micheal =
in the
> > > >>>> thread you quoted.
> > > >>> Got it. I also look forward to the more complex solution to this =
problem.
> > > >> Can we add a device capability (new feature bit) such as ctrq_wait=
_timeout
> > > >> to get a reasonable timeout=EF=BC=9F
> > > > The usual solution to this is include/linux/iopoll.h. If you can sl=
eep
> > > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> > >
> > > I read carefully the functions read_poll_timeout() and
> > > read_poll_timeout_atomic(). The timeout is set by the caller of the 2
> > > functions.
> >
> > FYI, in order to avoid a swtich of atomic or not, we need convert rx
> > mode setting to workqueue first:
> >
> > https://www.mail-archive.com/virtualization@lists.linux-foundation.org/=
msg60298.html
> >
> > >
> > > As such, can we add a module parameter to customize this timeout valu=
e
> > > by the user?
> >
> > Who is the "user" here, or how can the "user" know the value?
> >
> > >
> > > Or this timeout value is stored in device register, virtio_net driver
> > > will read this timeout value at initialization?
> >
> > See another thread. The design needs to be general, or you can post a R=
FC.
> >
> > In another thought, we've already had a tx watchdog, maybe we can have
> > something similar to cvq and use timeout + reset in that case.
>
> But we may block by the reset ^_^ if the device is broken?

I mean vq reset here.

It looks like we have multiple goals here

1) avoid lockups, using workqueue + cond_resched() seems to be
sufficient, it has issue but nothing new
2) recover from the unresponsive device, the issue for timeout is that
it needs to deal with false positives

Thanks

>
> Thanks.
>
>
> >
> > Thans
> >
> > >
> > > Zhu Yanjun
> > >
> > > >
> > > >       Andrew
> > >
> >
>


