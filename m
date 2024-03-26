Return-Path: <netdev+bounces-81908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98D88BA2D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A451F3BDD6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269712AAE1;
	Tue, 26 Mar 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YACCxTXm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBA12AAD7
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433129; cv=none; b=cutcTB5NCHML3o859v6x0tWHQV6b0UHqFcVf26RJAz5GuMScWHDPxzReoSeUBcPDCJRAZzqFVuvhz/iCIfrDcJ/HwtAR23ZEqzCJgYeQwBwWoo2Dg9KbTkk/BUSDEUtjlMypmgUPNnENNH5/+ZMwxfzgvRo7m4CV562g7NVYnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433129; c=relaxed/simple;
	bh=/UuQim4TNo8+bHcaGBWGy50oKqS25e8RlfsgL259uTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIvoC3TWCXkAL8cwFyTB7MKmufnIHsiL7RjBjBHXNIHQNY4ZNe/yH4wLhBiwagKQnnTAKgrp5+bQ5aXWt8OIjcTVc/LSM4CG0Gfa7aB3exycW8A7JBT14lM2LTh1hzwh7sst8gsLkRJwagpf6xnHn2KGKCxUpWVTEzGQOrR7s8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YACCxTXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711433126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UuQim4TNo8+bHcaGBWGy50oKqS25e8RlfsgL259uTk=;
	b=YACCxTXm0Txh8h3voT3K4bZ95MzduKVZV123JEVS5O/kFox416lTEnrXUauzBh268EuPgg
	ir82AeQq/S36ocliP22TBldXcAW8IHir3M4SXfNnJN4YILdzcIjosw3LPihphF6Wr0M6v1
	nFQwuDBkdY5+9rmaoAxVZBht18KCg1k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-x4-JxxvKP02rmD_D2z4bWQ-1; Tue, 26 Mar 2024 02:05:23 -0400
X-MC-Unique: x4-JxxvKP02rmD_D2z4bWQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e0b5e55778so12984955ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711433122; x=1712037922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UuQim4TNo8+bHcaGBWGy50oKqS25e8RlfsgL259uTk=;
        b=Z3XOf2NgHXZmbXO+kuRKRZX5mHy/g/3iWa3gWGexIyzoo04QGnTJoiFzgsd2+plXCm
         W2gZLXaj7E3nZ2MQUb2N2Upb4l1x/MrUt0aNpRax7/GL9GlNW9kAK5BQO4NZJaSICGeQ
         /jMLKk/JFivMKHmm4Qdq/Rgv59JBL8smEXVxNEbDrv/tGxydVgEJtUpi1iBpyoMflNqj
         gfnNf+9vv2FoKTRLROw+0zBtRkVE+b3ZPotoGi5CM3b2ZnBYe+u8FNOqIgpbs77fY2sU
         ctDRJb0ihBjGExqxDYjKYeKCBnGYPrSsWbjZwqG3+IIXSzVXjosOyPCDNfUyBfk1v8uH
         1wZg==
X-Gm-Message-State: AOJu0Yx8xS1CesKS+hAwn79hgxtJhyVhWWpPwMMgJoPHVFH37vMibryg
	6gaieS6qVOwrs4zlgDi3yejuHpUHkkGNwji74iuWIK2NkQuHhASDQbD8FkNdv/8bKe92GvDSFrr
	E7PKP9Tprqe0kAKiK6aHgZOUMsBM2pzYbzeYPZHKi5IRxoJcLKBwOS0dVNtZFITCXKTneKz9nZX
	Y6bZvsbYx2+hVcUTqxQz+p3RRh01fN
X-Received: by 2002:a17:903:2308:b0:1e0:b862:5330 with SMTP id d8-20020a170903230800b001e0b8625330mr6066177plh.54.1711433122490;
        Mon, 25 Mar 2024 23:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8wS2TioZv9GZb5diTiHYGJ7YlvPO4XG5rsxvlIOTrDYOcrGIGHiMB1FI7+TVRifUwZlWcjMoAl0MboV+WG3E=
X-Received: by 2002:a17:903:2308:b0:1e0:b862:5330 with SMTP id
 d8-20020a170903230800b001e0b8625330mr6066156plh.54.1711433122040; Mon, 25 Mar
 2024 23:05:22 -0700 (PDT)
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
 <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com> <CACGkMEsvsmyUaTD35kp=4qJhMdDYG=hGVbT0JGGTwGTb3XRuLg@mail.gmail.com>
 <75f1ae35-aeee-404a-be1c-2ffa05126cdb@linux.alibaba.com>
In-Reply-To: <75f1ae35-aeee-404a-be1c-2ffa05126cdb@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:05:10 +0800
Message-ID: <CACGkMEusLdoKA7pBWnKCLR5yEJ4JN-ivEJquEgKjh3pfKSta8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:57=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/26 =E4=B8=8B=E5=8D=8812:08, Jason Wang =E5=86=99=E9=81=
=93:
> > On Tue, Mar 26, 2024 at 10:46=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=884:42, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Mon, Mar 25, 2024 at 4:22=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=883:56, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Mon, Mar 25, 2024 at 3:18=E2=80=AFPM Heng Qi <hengqi@linux.aliba=
ba.com> wrote:
> >>>>>> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=881:57, Jason Wang =E5=86=99=
=E9=81=93:
> >>>>>>> On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.al=
ibaba.com> wrote:
> >>>>>>>> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=
=E9=81=93:
> >>>>>>>>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.a=
libaba.com> wrote:
> >>>>>>>>>> Currently, ctrlq processes commands in a synchronous manner,
> >>>>>>>>>> which increases the delay of dim commands when configuring
> >>>>>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
> >>>>>>>>>> increase and interferes with the performance of dim.
> >>>>>>>>>>
> >>>>>>>>>> Therefore we asynchronously process ctlq's dim commands.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>>>> I may miss some previous discussions.
> >>>>>>>>>
> >>>>>>>>> But at least the changelog needs to explain why you don't use i=
nterrupt.
> >>>>>>>> Will add, but reply here first.
> >>>>>>>>
> >>>>>>>> When upgrading the driver's ctrlq to use interrupt, problems may=
 occur
> >>>>>>>> with some existing devices.
> >>>>>>>> For example, when existing devices are replaced with new drivers=
, they
> >>>>>>>> may not work.
> >>>>>>>> Or, if the guest OS supported by the new device is replaced by a=
n old
> >>>>>>>> downstream OS product, it will not be usable.
> >>>>>>>>
> >>>>>>>> Although, ctrlq has the same capabilities as IOq in the virtio s=
pec,
> >>>>>>>> this does have historical baggage.
> >>>>>>> I don't think the upstream Linux drivers need to workaround buggy
> >>>>>>> devices. Or it is a good excuse to block configure interrupts.
> >>>>>> Of course I agree. Our DPU devices support ctrlq irq natively, as =
long
> >>>>>> as the guest os opens irq to ctrlq.
> >>>>>>
> >>>>>> If other products have no problem with this, I would prefer to use=
 irq
> >>>>>> to solve this problem, which is the most essential solution.
> >>>>> Let's do that.
> >>>> Ok, will do.
> >>>>
> >>>> Do you have the link to the patch where you previously modified the
> >>>> control queue for interrupt notifications.
> >>>> I think a new patch could be made on top of it, but I can't seem to =
find it.
> >>> Something like this?
> >> YES. Thanks Jason.
> >>
> >>> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@red=
hat.com/t/
> >>>
> >>> Note that
> >>>
> >>> 1) some patch has been merged
> >>> 2) we probably need to drop the timeout logic as it's another topic
> >>> 3) need to address other comments
> >> I did a quick read of your patch sets from the previous 5 version:
> >> [1]
> >> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redh=
at.com/t/
> >> [2] https://lore.kernel.org/all/20221226074908.8154-1-jasowang@redhat.=
com/
> >> [3] https://lore.kernel.org/all/20230413064027.13267-1-jasowang@redhat=
.com/
> >> [4] https://lore.kernel.org/all/20230524081842.3060-1-jasowang@redhat.=
com/
> >> [5] https://lore.kernel.org/all/20230720083839.481487-1-jasowang@redha=
t.com/
> >>
> >> Regarding adding the interrupt to ctrlq, there are a few points where
> >> there is no agreement,
> >> which I summarize below.
> >>
> >> 1. Require additional interrupt vector resource
> >> https://lore.kernel.org/all/20230516165043-mutt-send-email-mst@kernel.=
org/
> > I don't think one more vector is a big problem. Multiqueue will
> > require much more than this.
> >
> > Even if it is, we can try to share an interrupt as Michael suggests.
> >
> > Let's start from something that is simple, just one more vector.
>
> OK, that puts my concerns to rest.
>
> >
> >> 2. Adding the interrupt for ctrlq may break some devices
> >> https://lore.kernel.org/all/f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redha=
t.com/
> > These devices need to be fixed. It's hard to imagine the evolution of
> > virtio-net is blocked by buggy devices.
>
> Agree.
>
> >
> >> 3. RTNL breaks surprise removal
> >> https://lore.kernel.org/all/20230720170001-mutt-send-email-mst@kernel.=
org/
> > The comment is for indefinite waiting for ctrl vq which turns out to
> > be another issue.
> >
> > For the removal, we just need to do the wakeup then everything is fine.
>
> Then I will make a patch set based on irq and without timeout.

Ok.

>
> >
> >> Regarding the above, there seems to be no conclusion yet.
> >> If these problems still exist, I think this patch is good enough and w=
e
> >> can merge it first.
> > I don't think so, poll turns out to be problematic for a lot of cases.
> >
> >> For the third point, it seems to be being solved by Daniel now [6], bu=
t
> >> spink lock is used,
> >> which I think conflicts with the way of adding interrupts to ctrlq.
> >>
> >> [6] https://lore.kernel.org/all/20240325214912.323749-1-danielj@nvidia=
.com/
> > I don't see how it conflicts with this.
>
> I'll just make changes on top of it. Can I?

It should be fine.

Thanks

>
> Thanks,
> Heng
>
> >
> > Thanks
> >
> >>
> >> Thanks,
> >> Heng
> >>
> >>> THanks
> >>>
> >>>
> >>>> Thanks,
> >>>> Heng
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>>> And I remember you told us your device doesn't have such an issue=
.
> >>>>>> YES.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Heng
> >>>>>>
> >>>>>>> Thanks
> >>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Heng
> >>>>>>>>
> >>>>>>>>> Thanks
>


