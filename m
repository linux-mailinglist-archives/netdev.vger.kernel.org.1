Return-Path: <netdev+bounces-104283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797190C0C5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 02:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B6EB20E50
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 00:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0F4A35;
	Tue, 18 Jun 2024 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJgb+gvK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23EEEA5
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671976; cv=none; b=e5hAFyhGB4w3UL0Z42ZRSCTasQn8VFB/x2Ajh4IqSxAqkJKsyIawU1uGt6bNMrQdx1jzBVJ/q6TPFnka8axnUdIOOuaTG6pe21A4G6TLPVwpomAnd+/5mDoZOdzT0mTLTYfcSVyec8bG97ZN78sQ6I396+Y/4PqNku55c5p/N+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671976; c=relaxed/simple;
	bh=nFPe7Fr7NrrvclcHrrJyLIKOE3ordfgnei6PYt9cMbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzF9cmiKQJYFAgGtCczFMQUfBeuCGTDwdIV2yE1q4ukBs5u6dOSfH/4bunD/iP1yC7Ttce1aHRQkpet6sEwa0X7GH96HfeReYkYO1iVIhGHtMc9FfQlnToqaUWCbJ6gp45QXIgQ+GzRoJrzBXHpSJ7olDiOFx6kGivXe07rP52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJgb+gvK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718671973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbitODA8/gAi63tAtWbfOg6cnaUyUUcJ7N8r21Res4w=;
	b=fJgb+gvKQVO79qRrWWBBMG9Aw3o2+ZCKoZzliCeokBqA7zYOGPHE5kQrkSAGRp5vwD8PTp
	lzWxYowvTt2la7O4EPYC3Bv5h2Pz8/yrdmM0Gf1OqO8xtpvCFDRBAoDVRTMAkDZZSJaSEP
	hUZIVUxN6G63jmB7w1h9RmD4EG+ANRI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-i6lCV57GNrCysKjt537QaA-1; Mon, 17 Jun 2024 20:52:51 -0400
X-MC-Unique: i6lCV57GNrCysKjt537QaA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c30144b103so3976133a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718671970; x=1719276770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbitODA8/gAi63tAtWbfOg6cnaUyUUcJ7N8r21Res4w=;
        b=SbP6xZbdDtlkJNpat8vbWmDZSRpMdZ2KrxlI2CEiVv/ONVJ/kaPRhfVEIkl6pHK/pB
         eyUfjX6exUqNlOPSo7b8xYDwTX8SpST9YpoJd4LTuy3/gqo6eiEkeEqWDCDLKXWL7yI9
         o4FGhajzpUXfR1ulVLqOTE8/5A+E7WsfGFdbnduSkyFXgxh1gbvP8SOOcyJvp1r1baPy
         GwazIVW8o7rjbCyL6G+ZJ+1DrB+OljTvSK8ZeOeL12KqMFrnk+O37fuP/O2VLjwF26Ik
         e6b/ucxDDVFNfrtITftq/vh5kCyCXWG4ySXonPvnebMGvOv7wTfSrVUnQbgxkyJH6VCx
         m/uA==
X-Forwarded-Encrypted: i=1; AJvYcCUwR8X1HWIouieKwPzcRwQUIHf9Tu104xhV/0j71X7Pq5CbR+8qP5/N8YdrH6WNODSpoPzGTuVIuoAPtcFWF8FoJ4Wc+T+P
X-Gm-Message-State: AOJu0Yyq95dljAljE8nYAf+9meHEmTh1KSodbLviFSrZBIUnAYu+MS99
	p/9e6p1SB7HkD1IeXJk0NNmjInKmWEXPqb4oySFqehrJwhBSrEbF3AotCg7bOOvXVo0ZpNfm3BC
	3oVyYVUmGV2ZOWOxaqfwy68dYbom1z94ojUmR/KpXhpb8GGo43YFvh/XcNH4gT/PNBxglb2ny5z
	x9I9Q522B+bC7n4ioiRl+9TS/2ABOZ
X-Received: by 2002:a17:90a:c688:b0:2c2:d73e:2a93 with SMTP id 98e67ed59e1d1-2c6c8b2cc53mr1679763a91.5.1718671970476;
        Mon, 17 Jun 2024 17:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFY13tM/YuCaVcyGgJAl0trnmQdTmH5/e7E3aknmgTUjeYb9pzBSwU3i0tkRQHPm/ryt/rSyjtel1uPPIEAMU=
X-Received: by 2002:a17:90a:c688:b0:2c2:d73e:2a93 with SMTP id
 98e67ed59e1d1-2c6c8b2cc53mr1679741a91.5.1718671970118; Mon, 17 Jun 2024
 17:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion> <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion> <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com> <ZnACPN-uDHZAwURl@nanopsycho.orion>
In-Reply-To: <ZnACPN-uDHZAwURl@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 08:52:38 +0800
Message-ID: <CACGkMEvYC0vV9McY=G6V9K56yqtc5=9RVk7XbVX495GYyRcQcg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:30=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
> >On Mon, Jun 10, 2024 at 10:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >>
> >> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> >> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> >> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> >> > >> >True. Personally, I would like to just drop orphan mode. But I'm=
 not
> >> > >> >sure others are happy with this.
> >> > >>
> >> > >> How about to do it other way around. I will take a stab at sendin=
g patch
> >> > >> removing it. If anyone is against and has solid data to prove orp=
han
> >> > >> mode is needed, let them provide those.
> >> > >
> >> > >Break it with no warning and see if anyone complains?
> >> >
> >> > This is now what I suggested at all.
> >> >
> >> > >No, this is not how we handle userspace compatibility, normally.
> >> >
> >> > Sure.
> >> >
> >> > Again:
> >> >
> >> > I would send orphan removal patch containing:
> >> > 1) no module options removal. Warn if someone sets it up
> >> > 2) module option to disable napi is ignored
> >> > 3) orphan mode is removed from code
> >> >
> >> > There is no breakage. Only, hypotetically performance downgrade in s=
ome
> >> > hypotetical usecase nobody knows of.
> >>
> >> Performance is why people use virtio. It's as much a breakage as any
> >> other bug. The main difference is, with other types of breakage, they
> >> are typically binary and we can not tolerate them at all.  A tiny,
> >> negligeable performance regression might be tolarable if it brings
> >> other benefits. I very much doubt avoiding interrupts is
> >> negligeable though. And making code simpler isn't a big benefit,
> >> users do not care.
> >
> >It's not just making code simpler. As discussed in the past, it also
> >fixes real bugs.
> >
> >>
> >> > My point was, if someone presents
> >> > solid data to prove orphan is needed during the patch review, let's =
toss
> >> > out the patch.
> >> >
> >> > Makes sense?
> >>
> >> It's not hypothetical - if anything, it's hypothetical that performanc=
e
> >> does not regress.  And we just got a report from users that see a
> >> regression without.  So, not really.
> >
> >Probably, but do we need to define a bar here? Looking at git history,
> >we didn't ask a full benchmark for a lot of commits that may touch
>
> Moreover, there is no "benchmark" to run anyway, is it?

Yes, so my point is to have some agreement on

1) what kind of test needs to be run for a patch like this.
2) what numbers are ok or not

Thanks

>
>
> >performance.
> >
> >Thanks
> >
> >>
> >> >
> >> > >
> >> > >--
> >> > >MST
> >> > >
> >>
> >
>


