Return-Path: <netdev+bounces-81536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED988A2C3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051E81F3B5CD
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8BE13CAAE;
	Mon, 25 Mar 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLnDPGKL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CC156665
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356165; cv=none; b=YDzqIC+gDCsbxYHGY31vnmShlxGKaIc3NGFPj+eh5wMwF2w1ZrckeUFsX1CWPaMPMuYrZu9Cz/996AXtxMAc2hIdiWx4Nz41IQ4A0U02Qna0TBbfyMV5E03zCGHjXSqAq7Zu9G0Yh/VAMqmV1FEJIsUL1Egc7Ze5HN8SkD+ok34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356165; c=relaxed/simple;
	bh=oXU7ckQoT03iIwSgY+/Yw50N4YgwYhAfKqf6VUawMcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aH2J7+1S4qsKA0e+vo6toC/rFEFhTFAKRTOuM8QM8GkAPpajb4/RDYvgLXhsvmqIgvx5WBgGCKN8On5CUlJH2fugxeyUMVr/quIt94LN0WXxp8u2YPALa9EvtASk63a+9oTPdbrvqXLbrrVWI529P/59bp9R9PGbUa7NB5RMMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLnDPGKL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711356162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXU7ckQoT03iIwSgY+/Yw50N4YgwYhAfKqf6VUawMcM=;
	b=eLnDPGKLV/ov5rXmg7KmpPeoa0XLDT7DTJzgNTPg5qwDt5m6iCRDKJCBWeUKMvJqIKs0kY
	nMoJYgPPreQEZ1uplPevsC2/Z66Okp+AqEjvSKxcd3mB67Js+66oW24Do7CyxbsqC1u9gU
	DrENrshsIX8f3mDwRbAPTFaTFq0zYDE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-lMsNELlxMY6vYgi-8aAAVQ-1; Mon, 25 Mar 2024 04:42:39 -0400
X-MC-Unique: lMsNELlxMY6vYgi-8aAAVQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e6fd169871so3108516b3a.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 01:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356159; x=1711960959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXU7ckQoT03iIwSgY+/Yw50N4YgwYhAfKqf6VUawMcM=;
        b=uUc7PdOl6XnEOD/56qGPiRiTTBl0pTcWK6TpXpiD23hRsTt+dAn0uSGefw8/hzsFyt
         zuxYThA1xYi/hMum7QbN+7xH2Yqa3XigKKn4vPmcqczfgvxSgbtKAgqWP1iVbgDR0m0K
         EMcL4+Mzvy3Al1WPnq+WibYdTu6q2ktcvE+G+xxayNdvCLObKUu36TlhIOaCvL1yvG/d
         S24qulR1+XITq2mEpc3LVK1YI6l+wtlGECl/wtBkhnEMmRjrFywTEo4Mf/k78l7SiIvH
         L6ZYYJ5khcNCLgp3gkZLLWmyexjk0ZNmcmODgxqjK3LiB6XZVVhjR4TV1+wS956ComyP
         bqKg==
X-Gm-Message-State: AOJu0YwjJ4wx9iYg1Y0yE0thcQQoSaXFcAdkT3TfgbcHm4wY99FShCA3
	IUDGwAqVawi3bzCK5isWSuo0WTJO82vwwoWJpzMMvL8dkIGDryPTgszxDQaC9jnHlXm+aSu8enh
	9JUAWxMcNWvLD/v95lnOhMV5BOQ6eJXsTPRwvW8fp4kUWvJqAOkVfeIgKsNIvXnPiHNjPGVATU1
	PaCGO5yNJTQYpw8RZOijfhfY2lZdYQ
X-Received: by 2002:a05:6a20:9184:b0:1a3:be68:e82b with SMTP id v4-20020a056a20918400b001a3be68e82bmr3726514pzd.45.1711356158859;
        Mon, 25 Mar 2024 01:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEcFZTXK36RSyaqBDeK/teguwjP6mlf/+qJH5HAomDln/q9KuV4M9MW6TPMhY9sBOFlRp3rT9gSdzobf7oRA=
X-Received: by 2002:a05:6a20:9184:b0:1a3:be68:e82b with SMTP id
 v4-20020a056a20918400b001a3be68e82bmr3726504pzd.45.1711356158570; Mon, 25 Mar
 2024 01:42:38 -0700 (PDT)
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
 <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com>
In-Reply-To: <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 16:42:27 +0800
Message-ID: <CACGkMEvShZKd7AvMFtmEWBVGQsQrGkQMTEx8yQYYU0uYqp=uMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:22=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=883:56, Jason Wang =E5=86=99=E9=81=93=
:
> > On Mon, Mar 25, 2024 at 3:18=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=881:57, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.aliba=
ba.com> wrote:
> >>>>>> Currently, ctrlq processes commands in a synchronous manner,
> >>>>>> which increases the delay of dim commands when configuring
> >>>>>> multi-queue VMs, which in turn causes the CPU utilization to
> >>>>>> increase and interferes with the performance of dim.
> >>>>>>
> >>>>>> Therefore we asynchronously process ctlq's dim commands.
> >>>>>>
> >>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>> I may miss some previous discussions.
> >>>>>
> >>>>> But at least the changelog needs to explain why you don't use inter=
rupt.
> >>>> Will add, but reply here first.
> >>>>
> >>>> When upgrading the driver's ctrlq to use interrupt, problems may occ=
ur
> >>>> with some existing devices.
> >>>> For example, when existing devices are replaced with new drivers, th=
ey
> >>>> may not work.
> >>>> Or, if the guest OS supported by the new device is replaced by an ol=
d
> >>>> downstream OS product, it will not be usable.
> >>>>
> >>>> Although, ctrlq has the same capabilities as IOq in the virtio spec,
> >>>> this does have historical baggage.
> >>> I don't think the upstream Linux drivers need to workaround buggy
> >>> devices. Or it is a good excuse to block configure interrupts.
> >> Of course I agree. Our DPU devices support ctrlq irq natively, as long
> >> as the guest os opens irq to ctrlq.
> >>
> >> If other products have no problem with this, I would prefer to use irq
> >> to solve this problem, which is the most essential solution.
> > Let's do that.
>
> Ok, will do.
>
> Do you have the link to the patch where you previously modified the
> control queue for interrupt notifications.
> I think a new patch could be made on top of it, but I can't seem to find =
it.

Something like this?

https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.co=
m/t/

Note that

1) some patch has been merged
2) we probably need to drop the timeout logic as it's another topic
3) need to address other comments

THanks


>
> Thanks,
> Heng
>
> >
> > Thanks
> >
> >>> And I remember you told us your device doesn't have such an issue.
> >> YES.
> >>
> >> Thanks,
> >> Heng
> >>
> >>> Thanks
> >>>
> >>>> Thanks,
> >>>> Heng
> >>>>
> >>>>> Thanks
>


