Return-Path: <netdev+bounces-81896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A547288B943
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 05:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6F2E7EFD
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C64129E62;
	Tue, 26 Mar 2024 04:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvEFtq6L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D441292F5
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426114; cv=none; b=uSFl90E6FJIU1pBxSV2sB1ryyNZXqyTlV0QuVUJRKzSwwdVDuvTZrrnf80eQPXGPh4Ulmde9MSwnpWSh9b9218EAcU2XnFD4It4M2rVPPHTvZkaYhrUDsdF+YWBZojvwrR7xXLQbdVcTIYBO8P02RpEQvhbp3o4M5Qy9Gfa39ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426114; c=relaxed/simple;
	bh=StPWDnlpYhi+VnvUUlAezhM3U+Iq/7qgaasIGyswI6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kX6jXOVWxcoPj3Ba4mvgQYMngMaogd4XxUG60X7TpYRtBFQsUyEScopukMJSpjffY/N6T+xeF7VUic0Ki96G/fFRNhA8vERZpHpUuLR0opHRjjql9Pwg3nDmMmzbrmhDcx6az1SKB+8wLvNTCZITu4076sPiEEEIq4cYqpkCFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvEFtq6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711426110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StPWDnlpYhi+VnvUUlAezhM3U+Iq/7qgaasIGyswI6c=;
	b=dvEFtq6LGcYH777sjNhiGmyZzVc9zHI/qiCs/BLa76JoXq8flx8DebQPv3D+0v6SfgOPGZ
	uMuXzdQGsUbj79qiHPorLpBDEWGhJ5aI3aLV2aiWKozWddqp0cvGba2ADVsJ4LlTpDxabW
	gErEgIfc9DonIMZFm16TLi5jezF/u6k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-LUhDlw0INYqsHQjdZv7HfA-1; Tue, 26 Mar 2024 00:08:28 -0400
X-MC-Unique: LUhDlw0INYqsHQjdZv7HfA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e73833c7f6so3253459b3a.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426107; x=1712030907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StPWDnlpYhi+VnvUUlAezhM3U+Iq/7qgaasIGyswI6c=;
        b=Oe4A1L0E5hIXgkj3olVJm2WjrucQoljNGVOUPMZokFNUDNwMrFMTJDf4/LlOMHNZxr
         +o21MEypCTdTH3dQDt0lJ8CqtVgtMVU1TmbaCpvHuCqfYEd8zpVwTi/2z+/FjBuDNv2x
         MxfDV8ZOmPel444P3gahF8GB34cGfWNBGZg+13Hh/6uLiC/qx2/Q87z/xpFyOgOTy0aE
         c1En8+B302HczPFTC5bMkz0xJSgE5CS4lCowLxGEl2d3YoJEuv1Dhe5yL8/KJesO7Y4d
         qWHtCL5Hxts/WjqhJ3C/R1xjSzTCa6gERbC8Lmicq+ytlK5j4mj43YCGOesLCJbziW9k
         ABzA==
X-Gm-Message-State: AOJu0Yzn9P+XnqbzOr3YGMNVDtrY0aXkrMIQVaiqJG22J4kMLdRpZmTp
	ujqlkJ8rLdHURayPuWFzV2LtF13NkZFKqRlytIxdkX8oqHSIhZE36KMPVdoWB6KDUoepFGCON+5
	CE2rIpw+Yyju966ed5HjB4gfIEjXiXiQylrvtONoOSjW9l1t54ko/MLRSibQ7Hqd+1hVpH+Fb57
	sjE01WLWtmLRQyQlDIuOuEs9F4Z/ND
X-Received: by 2002:a05:6a20:2d21:b0:1a3:6a71:8282 with SMTP id g33-20020a056a202d2100b001a36a718282mr10074816pzl.0.1711426107684;
        Mon, 25 Mar 2024 21:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBlkL9Z9LCjG2AzHQwehG3CJAeH4UJ5fo1nk/Ns/ww09oy/aF6P2JJr07fKJQmaIcaJvaaZgBdaQGRm8gMtj0=
X-Received: by 2002:a05:6a20:2d21:b0:1a3:6a71:8282 with SMTP id
 g33-20020a056a202d2100b001a36a718282mr10074794pzl.0.1711426107315; Mon, 25
 Mar 2024 21:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
 <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com> <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
 <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com> <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
 <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com> <CACGkMEvShZKd7AvMFtmEWBVGQsQrGkQMTEx8yQYYU0uYqp=uMg@mail.gmail.com>
 <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com>
In-Reply-To: <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:08:16 +0800
Message-ID: <CACGkMEsvsmyUaTD35kp=4qJhMdDYG=hGVbT0JGGTwGTb3XRuLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:46=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=884:42, Jason Wang =E5=86=99=E9=81=93=
:
> > On Mon, Mar 25, 2024 at 4:22=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=883:56, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Mon, Mar 25, 2024 at 3:18=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=881:57, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> >>>>>> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=
=E9=81=93:
> >>>>>>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> >>>>>>>> Currently, ctrlq processes commands in a synchronous manner,
> >>>>>>>> which increases the delay of dim commands when configuring
> >>>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
> >>>>>>>> increase and interferes with the performance of dim.
> >>>>>>>>
> >>>>>>>> Therefore we asynchronously process ctlq's dim commands.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>> I may miss some previous discussions.
> >>>>>>>
> >>>>>>> But at least the changelog needs to explain why you don't use int=
errupt.
> >>>>>> Will add, but reply here first.
> >>>>>>
> >>>>>> When upgrading the driver's ctrlq to use interrupt, problems may o=
ccur
> >>>>>> with some existing devices.
> >>>>>> For example, when existing devices are replaced with new drivers, =
they
> >>>>>> may not work.
> >>>>>> Or, if the guest OS supported by the new device is replaced by an =
old
> >>>>>> downstream OS product, it will not be usable.
> >>>>>>
> >>>>>> Although, ctrlq has the same capabilities as IOq in the virtio spe=
c,
> >>>>>> this does have historical baggage.
> >>>>> I don't think the upstream Linux drivers need to workaround buggy
> >>>>> devices. Or it is a good excuse to block configure interrupts.
> >>>> Of course I agree. Our DPU devices support ctrlq irq natively, as lo=
ng
> >>>> as the guest os opens irq to ctrlq.
> >>>>
> >>>> If other products have no problem with this, I would prefer to use i=
rq
> >>>> to solve this problem, which is the most essential solution.
> >>> Let's do that.
> >> Ok, will do.
> >>
> >> Do you have the link to the patch where you previously modified the
> >> control queue for interrupt notifications.
> >> I think a new patch could be made on top of it, but I can't seem to fi=
nd it.
> > Something like this?
>
> YES. Thanks Jason.
>
> >
> > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redha=
t.com/t/
> >
> > Note that
> >
> > 1) some patch has been merged
> > 2) we probably need to drop the timeout logic as it's another topic
> > 3) need to address other comments
>
> I did a quick read of your patch sets from the previous 5 version:
> [1]
> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.=
com/t/
> [2] https://lore.kernel.org/all/20221226074908.8154-1-jasowang@redhat.com=
/
> [3] https://lore.kernel.org/all/20230413064027.13267-1-jasowang@redhat.co=
m/
> [4] https://lore.kernel.org/all/20230524081842.3060-1-jasowang@redhat.com=
/
> [5] https://lore.kernel.org/all/20230720083839.481487-1-jasowang@redhat.c=
om/
>
> Regarding adding the interrupt to ctrlq, there are a few points where
> there is no agreement,
> which I summarize below.
>
> 1. Require additional interrupt vector resource
> https://lore.kernel.org/all/20230516165043-mutt-send-email-mst@kernel.org=
/

I don't think one more vector is a big problem. Multiqueue will
require much more than this.

Even if it is, we can try to share an interrupt as Michael suggests.

Let's start from something that is simple, just one more vector.

> 2. Adding the interrupt for ctrlq may break some devices
> https://lore.kernel.org/all/f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.c=
om/

These devices need to be fixed. It's hard to imagine the evolution of
virtio-net is blocked by buggy devices.

> 3. RTNL breaks surprise removal
> https://lore.kernel.org/all/20230720170001-mutt-send-email-mst@kernel.org=
/

The comment is for indefinite waiting for ctrl vq which turns out to
be another issue.

For the removal, we just need to do the wakeup then everything is fine.

>
> Regarding the above, there seems to be no conclusion yet.
> If these problems still exist, I think this patch is good enough and we
> can merge it first.

I don't think so, poll turns out to be problematic for a lot of cases.

>
> For the third point, it seems to be being solved by Daniel now [6], but
> spink lock is used,
> which I think conflicts with the way of adding interrupts to ctrlq.
>
> [6] https://lore.kernel.org/all/20240325214912.323749-1-danielj@nvidia.co=
m/

I don't see how it conflicts with this.

Thanks

>
>
> Thanks,
> Heng
>
> >
> > THanks
> >
> >
> >> Thanks,
> >> Heng
> >>
> >>> Thanks
> >>>
> >>>>> And I remember you told us your device doesn't have such an issue.
> >>>> YES.
> >>>>
> >>>> Thanks,
> >>>> Heng
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>> Thanks,
> >>>>>> Heng
> >>>>>>
> >>>>>>> Thanks
>


