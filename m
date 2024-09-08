Return-Path: <netdev+bounces-126301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE997091D
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 19:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9101F2157F
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06912176AAF;
	Sun,  8 Sep 2024 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSzmbFBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81BEAF9
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725818232; cv=none; b=PrtMA/2VO/AqTQ58HyLA0iFyEm18iR+LmvCwEvRglhw2uMheIGQCeJmv54GCPBbfF1vTYeQjZZ9P0et55mv1PFBJwNlLfjacqNcSG6BWi1TDHNTNemfvVL2TuI4K+hmVvRgfj46v55BQ2LaLXAiDkaiwHO1wLnVUzVby9Vdmjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725818232; c=relaxed/simple;
	bh=OaCQHJoykbEsxKAplnxvc1soId4XaFSZuU76TVD3vaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKkgXDqXow1Mk9FiHHe8UqytzUQTE847k9fkkbDE+4xVoSpxQ3CCYUcuMMydKdjtANsczeJjtpecpMV/dd16xRqxJpcQF6Qo4bkjaCJJsXUMayCR2jAkN1fAdcXcVj9kL0DI0oBheHO/rZAo2EV1DW9ewHKFgR920Yk57956Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSzmbFBv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1d0e1bffc8so3386742276.1
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725818230; x=1726423030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaCQHJoykbEsxKAplnxvc1soId4XaFSZuU76TVD3vaM=;
        b=kSzmbFBvLIcRcet3WuR7crzwNoZaKtrcWJx5RyGn1OikOlLUTeBBbhnvrt2CAPiWfL
         hOQb3z/Z+DwH+JJeHlOC3KYZ/AtHH/ET5Ohye+B3U1E9jYd74q1LdHf/i9jkgNcyh2zH
         MMx+NYZ71+FVO99XcbmjZ7kOoCnegrtK2El9TXcrfXK2nSG2m90Xn/IzquLztA68mwph
         wIygq8Z3DXWeRhYnwCOZvGgG26LSPp91vxExiD6sxRvdNRatOyq929HgvgebU9xxfG/5
         VFe+4wbyUDt+sf0/n8XLRo5/7PbIMpiuoeQMQdGdW0/nhtpw7buXh+pm2lf5e7krvD4d
         mTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725818230; x=1726423030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaCQHJoykbEsxKAplnxvc1soId4XaFSZuU76TVD3vaM=;
        b=pdGoUZ6V7RO2GajpocNSPlFoA2+IFBwdxhwsjEukZYthsXBKd6mOIV3o4nbWc+r2zS
         2GolWQi2UHYkFlP5UuBrUu6uckShy5JbQFUqVIyT373NtEGSIbJTJj9xgs98ImoXtkb1
         dzlWHb/8IWHFPXANgRr54JMSQ1nfWl45r9GkFZDKP1N7ffz/vx0SPLNMD1cZaO2hleMb
         miCOTFZkTdRCxAkprbbAH7HuZ43maw87MuuI95ERk9XrRaE23NFxCM8ptN9EGrP6rmX9
         wurHxvJumWSXltzmhMa634k71oY1ASZPy3Z03BNO1dZAT6FnhNw6cZ5wDu747a/Xw0/S
         IHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBeSyyUp5EeGElrE/pr3s+Ki5yare6DovBAQEze7TZaaJ9dvFqZynlqZiYbw4I9N28uhDc820=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHluGmlp8kunQy6J4VhSoGi/LELPZI8BBSzPn+yn0mrOdIzQUu
	RjqBcVM13HRR7wzqEa/zqYRV1jPGnD4VdcBfIsVcdt0hWLDqCr2HYnqh4DrQ4pAQE5uAOwHFm7e
	U+oN/bWhfFXmM3Tj1MMQHY06zfQk=
X-Google-Smtp-Source: AGHT+IGk3Og9LGLFwbr9PB8/DBzWRSD3yFkiFAV9EMMN2RKDYU/y5UDEebSPtlq+/apiQby0+YwVjXKC2Uxi092Gq1s=
X-Received: by 2002:a05:6902:1023:b0:e1c:f437:baee with SMTP id
 3f1490d57ef6-e1d346b1885mr8793151276.0.1725818230229; Sun, 08 Sep 2024
 10:57:10 -0700 (PDT)
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
 <20240906055236-mutt-send-email-mst@kernel.org> <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
 <20240908061810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240908061810-mutt-send-email-mst@kernel.org>
From: Takero Funaki <flintglass@gmail.com>
Date: Mon, 9 Sep 2024 02:56:58 +0900
Message-ID: <CAPpoddeQo3tJL4hiC4Y_RjrHVQkbbaDGB3ngoCj4EAZur=LqBw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=97=A5) 19:19 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Sat, Sep 07, 2024 at 12:16:24PM +0900, Takero Funaki wrote:
> > 2024=E5=B9=B49=E6=9C=886=E6=97=A5(=E9=87=91) 18:55 Michael S. Tsirkin <=
mst@redhat.com>:
> > >
> > > On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > > > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@re=
dhat.com> wrote:
> > > > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <ms=
t@redhat.com> wrote:
> > > > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote=
:
> > > > > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > > > > >
> > > > > > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > > > > > >
> > > > > > > > > > which could see reliable crashes or scp failure (scp a =
file 100M in size
> > > > > > > > > > to VM):
> > > > > > > > > >
> > > > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes =
at the beginning
> > > > > > > > > > of a new frag. When the frag size is larger than PAGE_S=
IZE,
> > > > > > > > > > everything is fine. However, if the frag is only one pa=
ge and the
> > > > > > > > > > total size of the buffer and virtnet_rq_dma is larger t=
han one page, an
> > > > > > > > > > overflow may occur. In this case, if an overflow is pos=
sible, I adjust
> > > > > > > > > > the buffer size. If net.core.high_order_alloc_disable=
=3D1, the maximum
> > > > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_=
disable=3D0, only
> > > > > > > > > > the first buffer of the frag is affected.
> > > > > > > > > >
> > > > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mod=
e whatever use_dma_api")
> > > > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8=
e87-ba164a540c0a@oracle.com
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Guys where are we going with this? We have a crasher righ=
t now,
> > > > > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > > > > work Xuan Zhuo just did.
> > > > > > > >
> > > > > > > > I think this patch can fix it and I tested it.
> > > > > > > > But Darren said this patch did not work.
> > > > > > > > I need more info about the crash that Darren encountered.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > >
> > > > > > > So what are we doing? Revert the whole pile for now?
> > > > > > > Seems to be a bit of a pity, but maybe that's the best we can=
 do
> > > > > > > for this release.
> > > > > >
> > > > > > @Jason Could you review this?
> > > > > >
> > > > > > I think this problem is clear, though I do not know why it did =
not work
> > > > > > for Darren.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > > No regressions is a hard rule. If we can't figure out the regress=
ion
> > > > > now, we should revert and you can try again for the next release.
> > > >
> > > > I see. I think I fixed it.
> > > >
> > > > Hope Darren can reply before you post the revert patches.
> > > >
> > > > Thanks.
> > > >
> > >
> > > It's very rushed anyway. I posted the reverts, but as RFC for now.
> > > You should post a debugging patch for Darren to help you figure
> > > out what is going on.
> > >
> > >
> >
> > Hello,
> >
> > My issue [1], which bisected to the commit f9dac92ba908, was resolved
> > after applying the patch on v6.11-rc6.
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219154
> >
> > In my case, random crashes occur when receiving large data under heavy
> > memory/IO load. Although the crash details differ, the memory
> > corruption during data transfers is consistent.
> >
> > If Darren is unable to confirm the fix, would it be possible to
> > consider merging this patch to close [1] instead?
> >
> > Thanks.
>
>
> Could you also test
> https://lore.kernel.org/all/cover.1725616135.git.mst@redhat.com/
>
> please?
>

I have confirmed that both your patchset [1] and Xuan's patchset [2]
on v6.11-rc6 successfully resolved my issue.
[1] https://lore.kernel.org/all/cover.1725616135.git.mst@redhat.com/
[2] https://lore.kernel.org/netdev/20240906123137.108741-1-xuanzhuo@linux.a=
libaba.com/

It seems that simply reverting the original patchset would suffice to
resolve the crash.

