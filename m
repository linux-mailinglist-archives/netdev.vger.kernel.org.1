Return-Path: <netdev+bounces-76539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E186E121
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A33E1F2634C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B2138C;
	Fri,  1 Mar 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vmk0uPHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E51115
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296587; cv=none; b=idqLoIGxG7IsJ6jADhtgYpgkOMxncwqstYtxR02j2uj81SCeUzk56gAhyNT+2w1aKWNNlb0g/4hURu09Ox7YRvwk0Mf5SzIuU16pyeAsVI5aPek+AR41V3yHG2Ic0wEgnuEea+IEH8bE3ouX8jk88diEpw1SL8EsHW0KYyspjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296587; c=relaxed/simple;
	bh=xsrGECSjGw1PlPZBoDn2pZPeXK4cECiDUMPDj/cTlLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNt0IWKzmv6oHc2pmiraFbU/gwtZlJy14po0D0mdrdyiVlBaFsoGyRvn80/dMyjcUNy2bxE14Qwb6MwSvijPNtfh4iueMinDsZd5h58im2VZbQWZZ8Pa/33bn8iP25SvX6f5X/py1wySU6QWRn5gJGHPeOvdSN3SDan3qb5E/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vmk0uPHp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60925d20af0so21837067b3.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709296585; x=1709901385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7HlSWsC5oSq1BRA+xkgQmaElcXOjSddWi6PBJxJbmc=;
        b=vmk0uPHpXoKieYzNOUfPpzRqjNi9vb3jfaCs3dkWMUPb/POvHQxLKF8TsOqH8Ty4Gw
         FbHnoGNx8MEoqOGucuPAPMTGKZYasl1ecemwUmXIL+LySnCVoDBqJB40sU/eDIGTuMec
         BrguVZktMSjm8zOmaQV1GIiJoPSAS8YM0rmIboV4q1To9QSa7qTiL7iVNWKRAawbFE6g
         uhEUAMekN+PdEZIiqjr1xlZotrY3TWkj6BXbJkmY5LSBq5fE1CAF/ecQyyZPfcO2KTov
         a7JQRTKw/co29zejoJqGs3NV0mWHlpPf2MTFHPOLY2IkzQ6rkk8bbNtR1PpJblLKj9tY
         Gp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296585; x=1709901385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7HlSWsC5oSq1BRA+xkgQmaElcXOjSddWi6PBJxJbmc=;
        b=gE1zYwhkEyuq9eJvTRtBeyf1SfmljKC+CX2F/l9u9oXh3Moc/kUd00L7luflKOwzUg
         KH4ur7X5SBjaMLyeSCrDRJaL70T2bQFXGa+eJ94cvQyo52XLDdEDgJZdlsbvNv934Rg4
         ChZngHZh+/ufw9hWTaDKN8V0DiV/W2nyDYL7x9AwjxU1IdzCtJFNuH8rrus853jqaIu8
         dEcaDosoeQjNA6hcjxKRnKCHH9hoO/3O4x+cyFWemaJ2CqsQ1TePvNQJFAm3qIGE6Pth
         d95p/36HisNbeWKN13V8V9VDB+Euwr/STZ9AlXvQtqin9rHpKDA3O0/UOhjSuXN/pr2f
         IN+A==
X-Forwarded-Encrypted: i=1; AJvYcCX9nL0zT9F4mxHPxS4jOH2QeJh/Ts9IsrevCnZLODj5MVumYPmJ48UhPlyF1BeHkOegc61cxiSHEXfc5JZE7p/f0omDZ4jW
X-Gm-Message-State: AOJu0YzQUytAPGZHU3E0ng8wmPtFMFBqf5qrmVHb6IVYRL+F4PQrGPvE
	wr8NT4LtC0nVfmflre6gzH+Gqb2i5DO5/ry2e9zi3Ppfp4O1Xai9JZuT/qqI4qmzd5Lf+vSuN7j
	nIuvihFAbfuw2EjHtb6Ep1DSo94AvZz3DxDdu
X-Google-Smtp-Source: AGHT+IFzQEHDrZJKA1ImxAnOZIIUl0fPrAIdNzwGCOHKyBujENqIVsntijpQvJDrpV7rHwvh0G4w/Z8jE0GEncvX1Mw=
X-Received: by 2002:a0d:df8e:0:b0:608:b83a:992c with SMTP id
 i136-20020a0ddf8e000000b00608b83a992cmr1413327ywe.23.1709296584805; Fri, 01
 Mar 2024 04:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <65df6935db67e_2a12e2083b@john.notmuch>
 <332c7a04-edc8-40bd-9e8f-69c5d297e845@linux.dev>
In-Reply-To: <332c7a04-edc8-40bd-9e8f-69c5d297e845@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 07:36:13 -0500
Message-ID: <CAM0EoMmw25Kye4TTdFMAe8w-VgH++NkbNHcZcsfKR3diS28fSg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	daniel@iogearbox.net, victor@mojatatu.com, pctammela@mojatatu.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:02=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/28/24 9:11 AM, John Fastabend wrote:
> >   - The kfuncs are mostly duplicates of map ops we already have in BPF =
API.
> >     The motivation by my read is to use netlink instead of bpf commands=
. I
>
> I also have similar thought on the kfuncs (create/update/delete) which is=
 mostly
> bpf map ops. It could have one single kfunc to allocate a kernel specific=
 p4
> entry/object and then store that in a bpf map. With the bpf_rbtree, bpf_l=
ist,
> and other recent advancements, it should be able to describe them in a bp=
f map.
> The reply in v9 was that the p4 table will also be used in the future HW
> piece/driver but the HW piece is not ready yet, bpf is the only consumer =
of the
> kernel p4 table now and this makes mimicking the bpf map api to kfuncs no=
t
> convincing. bpf "tc / xdp" program uses netlink to attach/detach and the =
policy
> also stays in the bpf map.
>

It's a lot more complex than just attaching/detaching. Our control
plane uses netlink (regardless of whether it is offloaded or not) for
all object controls (not just table entries) for the many reasons that
have been stated in the cover letters since the beginning. I
unfortunately took out some of the text after v10 to try and shorten
the text. I will be adding it back. If you cant find it i could
cutnpaste and send privately.

cheers,
jamal

> When there is a HW piece that consumes the p4 table, that will be a bette=
r time
> to discuss the kfunc interface.
>
> >     don't agree with this, optimizing for some low level debug a develo=
per
> >     uses is the wrong design space. Actual users should not be deployin=
g
> >     this via ssh into boxes. The workflow will not scale and really we =
need
> >     tooling and infra to land P4 programs across the network. This is o=
rders
> >     of more pain if its an endpoint solution and not a middlebox/switch
> >     solution. As a switch solution I don't see how p4tc sw scales to ev=
en TOR
> >     packet rates. So you need tooling on top and user interact with the
> >     tooling not the Linux widget/debugger at the bottom.
>

