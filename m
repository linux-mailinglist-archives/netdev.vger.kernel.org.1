Return-Path: <netdev+bounces-88567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208788A7B6B
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50E81F225E9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CCE572;
	Wed, 17 Apr 2024 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDadu4kg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579E47F48
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328582; cv=none; b=WkQxX/F2WEfaCjZYxM8RqSi6Cwp1KVNtEn1eNk1NSzg3WIQphJhKvmp13ZN7ZiCjviXvmalhVaavzygYEXsH7/fPU9jXGBeuek83oEXXMxVmr0lKfRWASFVPjspV4tPOS5Nxsus/E9r3sSeglPmmNkIxDqFvNp7qgmNmrE9AdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328582; c=relaxed/simple;
	bh=07AmZo3EeffGWAJRhafnqkERI9t97s5fvtC2DEmMUtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOCpvvsJsUMLM5jcQM4miPS4mbPCosnqkkJy0Eka8GarlQVg6hl3V6J7qWisou0IZKR3tutoZtrFIBnIM9RtQOAyRxay3a4vN3U1ED8v5hmzxZ8X9W8zsVr6SscH9RhJR1V6gFn78pMFRlSHhwP0okBAD17X5x3AeT4t8LK4OVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDadu4kg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713328579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqKFHdI2odwaw7PHtETZldCfD0Dqi9Slkq7HCXLMMmM=;
	b=EDadu4kg7is9ycAtT/c7g3kPhWoedxPmHoxTElE7d0IDZCG2nCBpNjG4Yfq5pshZMKDka6
	uO7GAPwRuPf0R7WoOKE5uPcretofC6HT7lq18X9NK3CQji/A9GHh1xzjhcXRXCZuP5V4F8
	09aCiLWEMuow2gvD4jtp4YkXMQFhNf0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-AsxHAkpSOvWbXmr7sCdeEw-1; Wed, 17 Apr 2024 00:36:15 -0400
X-MC-Unique: AsxHAkpSOvWbXmr7sCdeEw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ee0d64070aso4024470b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328575; x=1713933375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqKFHdI2odwaw7PHtETZldCfD0Dqi9Slkq7HCXLMMmM=;
        b=fgoqMCw28dM8/wUD0syLljfvc/hLPnsajmfp7Q+/55ClzzS3wdZHqEMOzrrlCs18Ha
         tDV5xdNOdDRoZh3yZAskCQ+NxIIOUstm+TzXAnjbbBk4FT/BYX/neSc9V3UONnI4Jjn1
         5Y9EdxIoL2hM4MZeVSyOvjRENmhBSlrNJsaaqMnwn7zVFvLMjShj2TLBjh3/NqdSEpib
         HCeCtECsJ5BIzV/s0TXCyw8tSLe4SH2UpZGQFN1aBnmovxwFsWD7Fsxnypj9nw2MqvlQ
         +Bu7izb3Lv+r3OSElmIz2X+bpAM1IgkWpawSro3KrSVBF1w8EqZJV/oM7bcfxzwsNeW7
         Unxg==
X-Forwarded-Encrypted: i=1; AJvYcCXAYyu9qFQLEYDB1MeIkFSTH5iRVQXPl5meP686G/Tybrrj42lt6lcZazsrIPirHrBspfNfED1VnJurlia3MHeJx+ViZ8yG
X-Gm-Message-State: AOJu0YymjZRV8ZN4ecUdiJOS0flXUL3jAHQopdjS+wWO6gqhM5waG6vd
	z0FYQmdJHAaNyiUHDwuYYbEctcLId07CWLsq6+BaGjj2taOwolLdWAlqdoa6QEo+cxqaGs86efJ
	ZZa9RStyxPnBdFS2+1r4MY+Tt1NlW449HAmZY9ghWWgvdPSPzkUYKbFr2hToOwIPGBt1Lbis6Z7
	sVi89nJFrh+RN1FmES0eUMUbjtKJNQ
X-Received: by 2002:a05:6a21:3996:b0:1aa:2285:2cd0 with SMTP id ad22-20020a056a21399600b001aa22852cd0mr8664701pzc.23.1713328574816;
        Tue, 16 Apr 2024 21:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEthYd/NR7I6LztjY+R/ZunydFmwxQEGRLNW/tO7Y1pLsWdaDy6vNPLnV0mjO0aqBq4fAhomkkRrDH7gafDGrA=
X-Received: by 2002:a05:6a21:3996:b0:1aa:2285:2cd0 with SMTP id
 ad22-20020a056a21399600b001aa22852cd0mr8664694pzc.23.1713328574549; Tue, 16
 Apr 2024 21:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412151314.3365034-1-jiri@resnulli.us> <20240412180428.35b83923@kernel.org>
 <ZhqHadH3G5kfGO8H@nanopsycho> <20240415102659.7f72ae8d@kernel.org>
 <Zh5Kn5OnDdzgB6Rm@nanopsycho> <Zh53DaJkqxPC4_ZX@nanopsycho>
In-Reply-To: <Zh53DaJkqxPC4_ZX@nanopsycho>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 12:36:03 +0800
Message-ID: <CACGkMEu5VDMiFQdGbkn3H82SGDB4BE1Br8SV_hjdsPxZAH=Z9A@mail.gmail.com>
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, shuah@kernel.org, petrm@nvidia.com, 
	liuhangbin@gmail.com, vladimir.oltean@nxp.com, bpoirier@nvidia.com, 
	idosch@nvidia.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 9:03=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Apr 16, 2024 at 11:53:35AM CEST, jiri@resnulli.us wrote:
> >Mon, Apr 15, 2024 at 07:26:59PM CEST, kuba@kernel.org wrote:
> >>On Sat, 13 Apr 2024 15:23:53 +0200 Jiri Pirko wrote:
> >>> That is a goal. Currently I do it with:
> >>> vng --qemu-opts=3D"-nic tap,id=3Dnd0,ifname=3Dxtap0,model=3Dvirtio-ne=
t-pci,script=3Dno,downscript=3Dno,mac=3D52:54:00:12:34:57 -nic tap,id=3Dnd1=
,ifname=3Dxtap1,model=3Dvirtio-net-pci,script=3Dno,downscript=3Dno,mac=3D52=
:54:00:12:34:58"
> >>>
> >>> and setting loop manually with tc-matchall-mirred
> >>>
> >>> Implementing virtio loop instantiation in vng is on the todo list for
> >>> this.
> >>
> >>Just to be clear - I think the loop configuration is better off outside
> >>vng. It may need SUID and such. We just need to make vng spawn the two
> >>interfaces with a less verbose syntax. --network-count 2 ?
> >
> >Well, you ask vng for network device by:
> >--net=3Duser/bridge
> >
> >Currently putting the option multiple times is ignored, but I don't see
> >why that can't work.
> >
> >Regarding the loop configuration, I would like to make this as
> >convenient for the user as possible, I was thinking about something like
> >--net=3Dloop which would create the tc-based loop.
> >
> >How to do this without root, I'm not sure. Perhaps something similar
> >like qemu-bridge-helper could be used.
>
> Ha, qemu knows how to solve this already:
>        -netdev hubport,id=3Did,hubid=3Dhubid[,netdev=3Dnd]
>               Create a hub port on the emulated hub with ID hubid.
>
>               The hubport netdev lets you connect a NIC to a QEMU emulate=
d hub
>               instead of a single netdev. Alternatively, you can also  co=
nnect
>               the  hubport to another netdev with ID nd by using the netd=
ev=3Dnd
>               option.
>
> I cooked-up a testing vng patch, so the user can pass "--net=3Dloop":
> https://github.com/arighi/virtme-ng/commit/84a26ba92c9834c09d16fc1a4dc3a6=
9c4d758236
>

Note: another way, there's a vdpa(virto)-net simulator which can only
do loopback. The advantage is that you don't even need Qemu.

Thanks

>


