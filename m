Return-Path: <netdev+bounces-81532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604F88A26C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DDB2A782A
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CC14386D;
	Mon, 25 Mar 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjSFF8CN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909B143C65
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353405; cv=none; b=HNolsAJKUjuntU6hG6jsB8pVSUbmcovUymJSjQZG+Nk3bA8Q19aNrAAVmcOGEHy89f1hdrC0rPF70OrItrc9Xf5OlTqzEXbj4S9U646F5vU+mSFraMTevkNjQ6kSBvfOeitwqIWSm4PG43Phud/nVmD3muwezpoz0BdT/EFcqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353405; c=relaxed/simple;
	bh=lU4OSBkt/3LkRz6yEJhf8BKrnbEhDjeHaHo7SUbDdtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H49jhmt2ZIr+oqunYIt83bL7YhcVFr/X4iRUlHP42PqfzeE/bYZgqVVL6jZN9N/4Ux793rlzwSBobCDCFC8D9vIwlc1tlfTkppVg4xTCvRYuIiV+UqSLz1Poa94DvyLB7IfEKbxK/vVra4/Wf8E0LTJPmhSXj6Sa4KGqIK5jNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjSFF8CN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711353402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lU4OSBkt/3LkRz6yEJhf8BKrnbEhDjeHaHo7SUbDdtA=;
	b=EjSFF8CNzELjkzIfkf3BsztIp+YQ92hxube476Yh/tImxOjkBNbdzYao80yEQExGBaWN4x
	Utip28j+ARYmqhLxAWmDF4WFDuBS4JfngX/4Qggc96qDH44Tgn2GEKNXERJZxr70l7btQi
	3O1mitn9xI9PW1lVhE6TCrr15TPKmzE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622--KqCwzF5PGucqu4YGMerFw-1; Mon, 25 Mar 2024 03:56:39 -0400
X-MC-Unique: -KqCwzF5PGucqu4YGMerFw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e0b3aa4e39so6911065ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 00:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711353398; x=1711958198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU4OSBkt/3LkRz6yEJhf8BKrnbEhDjeHaHo7SUbDdtA=;
        b=Dm1RxBwX+hxjSTVJH/aj8DpfoszsTL7fjMmBnDdy8tv8PUg5l+n/lB1pTpE6IBrNC0
         PFv9O7otoWf/jPZG7aZVLbwA82ylDptXXkwG8pjfrx4nqtAasrqW+29D/j84Ymwsz2Vf
         G3D4SGhu2j2mXHz/2I8dBA6Es98qwfBlbcBIOxMv47hNHx7UGjiTJvXwwgtKW3v2PIPc
         rBnQfEh+7cNP8te7pEz2vX7n4NwGA7Z6iNeMjMU95HTrESjXWubVt1gRI3ggzcuW/j8/
         pPhYojSU/fiC9zggEfzxxCApr8aDdd03S48GIkCr81hZ0FJCCiOeA/t3/loQYKJSzzFC
         +RmQ==
X-Gm-Message-State: AOJu0YyXZRusrU26gf05YsbIZ41WK34IyW/67ep0l5J1N8i8wFrNMWer
	jwM33EbDJ1C2rt2aMwlMdRdAd7PaPQuX1I6t8WV0hU7QHj8W/ac2yOe4SvigFbfB1ONdCxgJrus
	W62Y+SX1SdZLJ+JsdgMWkjWVgoPwK9XVh9dw31k3W0URiNkXAkK7kD517fhRUyCRC1G9j95rXdI
	fO3bH+t/jsMB5RFqyEfOotqP0EeaPX
X-Received: by 2002:a17:902:db11:b0:1e0:b5d4:9f53 with SMTP id m17-20020a170902db1100b001e0b5d49f53mr4928399plx.7.1711353398052;
        Mon, 25 Mar 2024 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsYydG1l3Z9JQOMTYJBqCI5ISsQvkpaKkenKgFJj6VAKs/43eSGZyYxU88y4yAl8yrGgFXcHJSk2WFdezvSYk=
X-Received: by 2002:a17:902:db11:b0:1e0:b5d4:9f53 with SMTP id
 m17-20020a170902db1100b001e0b5d49f53mr4928382plx.7.1711353397735; Mon, 25 Mar
 2024 00:56:37 -0700 (PDT)
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
 <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com>
In-Reply-To: <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 15:56:26 +0800
Message-ID: <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:18=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=881:57, Jason Wang =E5=86=99=E9=81=93=
:
> > On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>> Currently, ctrlq processes commands in a synchronous manner,
> >>>> which increases the delay of dim commands when configuring
> >>>> multi-queue VMs, which in turn causes the CPU utilization to
> >>>> increase and interferes with the performance of dim.
> >>>>
> >>>> Therefore we asynchronously process ctlq's dim commands.
> >>>>
> >>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>> I may miss some previous discussions.
> >>>
> >>> But at least the changelog needs to explain why you don't use interru=
pt.
> >> Will add, but reply here first.
> >>
> >> When upgrading the driver's ctrlq to use interrupt, problems may occur
> >> with some existing devices.
> >> For example, when existing devices are replaced with new drivers, they
> >> may not work.
> >> Or, if the guest OS supported by the new device is replaced by an old
> >> downstream OS product, it will not be usable.
> >>
> >> Although, ctrlq has the same capabilities as IOq in the virtio spec,
> >> this does have historical baggage.
> > I don't think the upstream Linux drivers need to workaround buggy
> > devices. Or it is a good excuse to block configure interrupts.
>
> Of course I agree. Our DPU devices support ctrlq irq natively, as long
> as the guest os opens irq to ctrlq.
>
> If other products have no problem with this, I would prefer to use irq
> to solve this problem, which is the most essential solution.

Let's do that.

Thanks

>
> >
> > And I remember you told us your device doesn't have such an issue.
>
> YES.
>
> Thanks,
> Heng
>
> >
> > Thanks
> >
> >> Thanks,
> >> Heng
> >>
> >>> Thanks
>


