Return-Path: <netdev+bounces-126200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF3496FFC0
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 05:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B98281371
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3483208D1;
	Sat,  7 Sep 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJcGupuj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6BE571
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725678997; cv=none; b=PYczMTSUpdtSqmFomCPHTLPHTr+SrvsKvvGDcpXOEtQK4z9afiu/88fD8jpvvD5P0lQitWlcZU59WqJ4MuP01ch3rV6zmzxEIHyXsYJ1ODxYecWxW0Z4fUkW3RKV5hIebwaJtlIbb40lFNnPUF/iJKSddQI+Ilvsiuct7LNgtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725678997; c=relaxed/simple;
	bh=vOePgDBg1Nn9/MdMdp+jxzNIw6nOe2LkgwhjMwdKjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3GVi+SunqzSlatlQ8VaWz53nQ2ofK+iKvOQWtkNQU6qC6kRuHOlBJC3EX5uKk7zKbrWjHdsn65HLaYx48bDIKzIe0asIG1FoGV8ELffK1xhfKPhzC+LPQGY+qrq0XQ3OMnmTyS7qJv95oRsjKOOKH6nG1MKsx0Tj+bV/sAdgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJcGupuj; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso2831218276.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725678995; x=1726283795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOePgDBg1Nn9/MdMdp+jxzNIw6nOe2LkgwhjMwdKjFM=;
        b=VJcGupujP34hxyVqlt06aicClORIHRawkTak1UatTsVX3ouRU1G3BBX6iJod+xcVsr
         i+Hgzor9fi/tKXDmbJUv+WHNsgt6oNm9HxaPntjlZrVfIffJd3mEjFgPeU2wNRPUXKN3
         AfbIQtSDeYSLKUF3rG5v8ojrYV45EjKNExpxUFOkZr9okEN2KLvfpf1ysxNkoMg1E8kf
         qh38z425Wqc58Vyjt3e3oYeGeFUmClhO6SDXhrvRYv1aChflzXm/hTK4TZXFowdvYu+j
         J7H8rkA29LbMIJL/ikLMn2rRIzd1s9N8YCZqyO3qypURGZPJfCs30+aTuX+TqzGcx/wO
         Lkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725678995; x=1726283795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOePgDBg1Nn9/MdMdp+jxzNIw6nOe2LkgwhjMwdKjFM=;
        b=rn/scXbJ7jXMGwisJLW8yLsrhtehxk9zS2ZXftmVerWgHqDemlrlpSkkqPeAo+LjyD
         9I3p9LDhKBHH7HD9TMIYWjgwxvCdUQ7a/pDjUZKzTBLV23YlbfMsI+Sf0WVhoklA6/uS
         fg3nKyXTx/DvSXP1ftAep3t2/9aSNFehpYtkGXwX9MrdqtBhvmH13Qi5TPg/cPStxL8Y
         qf2YtRSiBrAav608ke7xQNtmPbUhPGt79K1FHEVouYt5YPqhbmEhUJdLvAs6iX0mq2p1
         8VolNnXSs97OJCZFO0UicOCCC6k6WBYKs91UFbn04NTUVQGKM3bNPy0Z6XYmDqKHC+Ht
         T/vQ==
X-Gm-Message-State: AOJu0YwlNt7QOATF6BtcHP/8gl+09oTL+qTdOgo+RHvp042jX3HW0Lo0
	TRF487lPdd63iWT8sw87HXVEZ92OpK7Bhyzjp53sukyFEUNrQkm+ufOOHO28Y0TwJLZy7fv2DDY
	MY1KujWGLYtQl5re18CQCw05psPU=
X-Google-Smtp-Source: AGHT+IEgJT/TcGf9mPlTKGK6gyliivAs2kJMdByLUCLCAAYiciJRxPeqtl/FS1znHM477NSLtXCIZOShHnwl2QfJyzs=
X-Received: by 2002:a05:6902:1145:b0:e11:7b7d:bd3a with SMTP id
 3f1490d57ef6-e1d349efc64mr5675831276.36.1725678994993; Fri, 06 Sep 2024
 20:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org> <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org> <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org> <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
 <20240906055236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240906055236-mutt-send-email-mst@kernel.org>
From: Takero Funaki <flintglass@gmail.com>
Date: Sat, 7 Sep 2024 12:16:24 +0900
Message-ID: <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B49=E6=9C=886=E6=97=A5(=E9=87=91) 18:55 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
> > On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
> > > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@re=
dhat.com> wrote:
> > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > > >
> > > > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > > > >
> > > > > > > > which could see reliable crashes or scp failure (scp a file=
 100M in size
> > > > > > > > to VM):
> > > > > > > >
> > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at t=
he beginning
> > > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > > > everything is fine. However, if the frag is only one page a=
nd the
> > > > > > > > total size of the buffer and virtnet_rq_dma is larger than =
one page, an
> > > > > > > > overflow may occur. In this case, if an overflow is possibl=
e, I adjust
> > > > > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, =
the maximum
> > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disa=
ble=3D0, only
> > > > > > > > the first buffer of the frag is affected.
> > > > > > > >
> > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode wh=
atever use_dma_api")
> > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-=
ba164a540c0a@oracle.com
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > >
> > > > > > >
> > > > > > > Guys where are we going with this? We have a crasher right no=
w,
> > > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > > work Xuan Zhuo just did.
> > > > > >
> > > > > > I think this patch can fix it and I tested it.
> > > > > > But Darren said this patch did not work.
> > > > > > I need more info about the crash that Darren encountered.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > So what are we doing? Revert the whole pile for now?
> > > > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > > > for this release.
> > > >
> > > > @Jason Could you review this?
> > > >
> > > > I think this problem is clear, though I do not know why it did not =
work
> > > > for Darren.
> > > >
> > > > Thanks.
> > > >
> > >
> > > No regressions is a hard rule. If we can't figure out the regression
> > > now, we should revert and you can try again for the next release.
> >
> > I see. I think I fixed it.
> >
> > Hope Darren can reply before you post the revert patches.
> >
> > Thanks.
> >
>
> It's very rushed anyway. I posted the reverts, but as RFC for now.
> You should post a debugging patch for Darren to help you figure
> out what is going on.
>
>

Hello,

My issue [1], which bisected to the commit f9dac92ba908, was resolved
after applying the patch on v6.11-rc6.
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219154

In my case, random crashes occur when receiving large data under heavy
memory/IO load. Although the crash details differ, the memory
corruption during data transfers is consistent.

If Darren is unable to confirm the fix, would it be possible to
consider merging this patch to close [1] instead?

Thanks.

