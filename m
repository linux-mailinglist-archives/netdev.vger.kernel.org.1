Return-Path: <netdev+bounces-88379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288DB8A6ECA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480791C22E5E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126F12EBD7;
	Tue, 16 Apr 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCQeHuRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAD12E1C7
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278806; cv=none; b=rdg/cIwGEkP5JPqSYlvD64dygGs7xOZRHJ5rEnd+cavC0goj+6rXMgWvNdmiUoMGyeV+V+M3Gi93ms2nZLkCGs/3+qWs4sxV8zuqcz2Tj6pmPBM3HbhZhYppdYpgTlagkrmokXFOAcj9JRcxOF9FuCZGYPJIFAJ58Wl1pFOFOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278806; c=relaxed/simple;
	bh=SjFK7lLw08XXYd8La56ucbZ4biYVUyvt++bSZx1oOfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8bE/8NX6Bl67jzSOpDOnD2PKGpS4tuzIXeoZ9ieswxNXBxNQao+5W3ncpPp68n3/h1RYK3cZGT4pY/07hTYtUsxTaggoVky5xPNySiCk8nOj0m6w0VvLJTxO08IY5/zfBVkvPfM8/vJK2AGhsZf2bdV/aq8dFg4OEVup/G5vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCQeHuRQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-346b146199eso3225717f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713278803; x=1713883603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWupoMxW1DCsGvmyMgJRrqtgkTLDgLgOv8+w4mjO5vc=;
        b=CCQeHuRQZbFMVIso3z5egm+H1U6TMSE346KvZYysHH18YjHVc9N3WEO3gcTPxW+RrY
         4cQOM3gfWNT9c7StGeBxla6GTN+avjkL3Nzy0BgEPuZd19L0dDn+4ujNg/IJLbOosDDN
         ExEIQVqTnxjgyBdfj8nz97T2xVYCG4UiL/nabT1kCn8jHxhcxmFwe4Az22I66DTW3fpv
         U+pTqwbCZ4aGkIYQAvHecgBPpZhumoWWNnmCESOB+3s/N9BWzsIgz2WqO5oyZ/wo1ewC
         wQhIZYhrSmO4p32FfQ6zfJ+ltTml3dBZgdIXZo3hSs48z8cxsITwAtnmFNJR42yGNByr
         AsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278803; x=1713883603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWupoMxW1DCsGvmyMgJRrqtgkTLDgLgOv8+w4mjO5vc=;
        b=AwVMNJxSn8vwXQjZE6n3NVK/AXA3c90GQne8bRQXoMFZ/kXmLVx5v8diIMbvbkzokV
         9pH8dI9P9rdCFpf2NinfcswV3avlUDZycsoZ3XGHgwu/WTd/pL39LvszRWJpOzZqQXiM
         IHoSnouI57Q/2giwTxZHCAQaoVfFDOJNZZHxE9oEEvnWRpv+z1Y0E2WElMxf373uUhql
         +F4sf/yXYUq6+LNa974/7/ReNROJY0WhdrFQM2Bgrw/X6JNYOPA0HqA1S+z06eYnTgqP
         IZjDo18B8bplD5JnhGDCRIna/lboRxp8/foxvCLvCOYBqBO3XR10hgDE6rK3DF8n9Vch
         OEuw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/ca38jZ5M8MUERucJMmPl0DL1y2uB7d1HiTviO8rG8fkFpZijA6dF4I1VkKTUgJUbFPsbnU029VdEIzgRPWobx+x+sp4
X-Gm-Message-State: AOJu0YwSwL9/eRm/XYtazHCFJ7VwUvFsdz0IvgPV9gQXo5vAcEuVlUi2
	WMF3ovq40NGX0JDkqHdzAYN0LB8K9yfeJNNYT+1imx5FKxnAs4WKjLC3w5Rn5r3x2kognlz4njT
	WUH9mTkaRd4sQKHR51X8qJtdJah0=
X-Google-Smtp-Source: AGHT+IF7qx2ADZsEgrCe3iiORQD7p5asYsU/jyVC2cs++BSarBA7rJjKdPTXrjV8Itu1SB7wp2GFiHEzdhPu+UF8Y6Y=
X-Received: by 2002:a05:6000:12cc:b0:345:daff:97e0 with SMTP id
 l12-20020a05600012cc00b00345daff97e0mr7987052wrx.16.1713278802897; Tue, 16
 Apr 2024 07:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com> <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com> <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com> <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org> <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com>
In-Reply-To: <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 16 Apr 2024 07:46:06 -0700
Message-ID: <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:05=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Mon, 15 Apr 2024 11:03:13 -0700
>
> > On Mon, Apr 15, 2024 at 10:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> >>
> >> On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
> >>>>> The advantage of being a purpose built driver is that we aren't
> >>>>> running on any architectures where the PAGE_SIZE > 4K. If it came t=
o
> >>>>
> >>>> I am not sure if 'being a purpose built driver' argument is strong e=
nough
> >>>> here, at least the Kconfig does not seems to be suggesting it is a p=
urpose
> >>>> built driver, perhaps add a 'depend on' to suggest that?
> >>>
> >>> I'm not sure if you have been following the other threads. One of the
> >>> general thoughts of pushback against this driver was that Meta is
> >>> currently the only company that will have possession of this NIC. As
> >>> such Meta will be deciding what systems it goes into and as a result
> >>> of that we aren't likely to be running it on systems with 64K pages.
> >>
> >> Didn't take long for this argument to float to the surface..
> >
> > This wasn't my full argument. You truncated the part where I
> > specifically called out that it is hard to justify us pushing a
> > proprietary API that is only used by our driver.
> >
> >> We tried to write some rules with Paolo but haven't published them, ye=
t.
> >> Here is one that may be relevant:
> >>
> >>   3. External contributions
> >>   -------------------------
> >>
> >>   Owners of drivers for private devices must not exhibit a stronger
> >>   sense of ownership or push back on accepting code changes from
> >>   members of the community. 3rd party contributions should be evaluate=
d
> >>   and eventually accepted, or challenged only on technical arguments
> >>   based on the code itself. In particular, the argument that the owner
> >>   is the only user and therefore knows best should not be used.
> >>
> >> Not exactly a contribution, but we predicted the "we know best"
> >> tone of the argument :(
> >
> > The "we know best" is more of an "I know best" as someone who has
> > worked with page pool and the page fragment API since well before it
> > existed. My push back is based on the fact that we don't want to
>
> I still strongly believe Jesper-style arguments like "I've been working
> with this for aeons", "I invented the Internet", "I was born 3 decades
> before this API was introduced" are not valid arguments.

Sorry that is a bit of my frustration with Yunsheng coming through. He
has another patch set that mostly just moves my code and made himself
the maintainer. Admittedly I am a bit annoyed with that. Especially
since the main drive seems to be to force everything to use that one
approach and then optimize for his use case for vhost net over all
others most likely at the expense of everything else.

It seems like it is the very thing we were complaining about in patch
0 with other drivers getting penalized at the cost of optimizing for
one specific driver.

> > allocate fragments, we want to allocate pages and fragment them
> > ourselves after the fact. As such it doesn't make much sense to add an
> > API that will have us trying to use the page fragment API which holds
> > onto the page when the expectation is that we will take the whole
> > thing and just fragment it ourselves.
>
> [...]
>
> Re "this HW works only on x86, why bother" -- I still believe there
> shouldn't be any hardcodes in any driver based on the fact that the HW
> is deployed only on particular systems. Page sizes, Endianness,
> 32/64-bit... It's not difficult to make a driver look like it's
> universal and could work anywhere, really.

It isn't that this only works on x86. It is that we can only test it
on x86. The biggest issue right now is that I wouldn't have any
systems w/ 64K pages that I could test on, and the worst that could
happen based on the current code is that the NIC driver will be a
memory hog.

I would much prefer the potential of being a memory hog on an untested
hardware over implementing said code untested and introducing
something like a memory leak or page fault issue.

That is why I am more than willing to make this an x86_64 only driver
for now and we can look at expanding out as I get time and get
equipment to to add support and test for other architectures.

