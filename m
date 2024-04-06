Return-Path: <netdev+bounces-85415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6989AB1F
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EDE281E4B
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E137141;
	Sat,  6 Apr 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qIxuUX0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F236AF2
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411314; cv=none; b=Xf8/GcCohuTWow0y3hFTfoMGhSWTFS5nX36bpDFGlWYRN9NuAHy48EEVsuKtqB5JdsRKKDUPGtuQt0mUf6aTG4urI0hBHpOlafWNX3jrw9/6Hw9XLTVKK9FsRrhNAjtNWGdqlwwyq6ul+sh6mMga5MsjHH5xqANGoKNEik+Gc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411314; c=relaxed/simple;
	bh=zgCM8NsnNaZ0DBEpzMiWhN+mogYlvXld9lo/9ByiQ9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQWDh7m2ytD4RdSGQ7ZzqzlpmyBoEEhXwe/zmUV68MurVUO3ciEslNlwByev7X8dyxlTNUVXlNWC4w7mwWO6nQnBlnen3/Z3+6G6wbRYIvJTtJ2lnOq369weqGucllaJWu3XNWPNTibzy6WPOwBsRc7T4Miz7hRveGbAD6nHpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qIxuUX0v; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so2879252276.3
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712411311; x=1713016111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgCM8NsnNaZ0DBEpzMiWhN+mogYlvXld9lo/9ByiQ9g=;
        b=qIxuUX0vxIirojXBrFBA5ML7Ab3cw1UvH2auq9Bmw3UASW699pIeKd7Z2wtaSyCAzp
         yMqxK4gnmKjxLq2Gor6ktB52b2BOFsLSbbWf8Ag8SfAughqKRpq2yBiR5G3DENig6lVI
         blioGRu+8u8WkJhrewZFvdAUQxWy6I6s2KfiPokEZWIA4mhi+L1hqESLqDIoD4v6ZHeE
         1mDq5bCzBL4W5DM4WRHD/et+ARGgcUS9fWnyBYLKzJ9FjdNNLLw+xwSMi1zfU7VAAzKx
         l6+qZR7fZTzwxMvwMls+68E3dXcP4jgEjoknH1dodeBCO0WyTuncj1Xo2J6ObMBwM99m
         fmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712411311; x=1713016111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgCM8NsnNaZ0DBEpzMiWhN+mogYlvXld9lo/9ByiQ9g=;
        b=gBngdvG2BPVc5gNf7uV0e186ekgmNyH5jfOuyrwRQsOryOXZF4egg9o8Pq9xqSkkrp
         tWfD+QKcG99mUQIYFYWk4VsN/brCH5JRT7HfeBgc19lYhnPua5BMIgRI8i+/d3A6Tim1
         kC16JzN6YxzajE4UhWWz59AAAqs9x/1lFZxb/NrXU8cPZf3h5sl7yZQIl5dhU3mA6U8d
         iQWsgypQAUso5tHyCYZceGAfxgPzyH6NIiltjHDYVjuHzN2/l3V+Qd4DFLZB5YcyuY3h
         eJ7gyTbGSw60Vfh2O6jIQ2qZNbIobqN8+24ZTI+qs6kVPIEPCcHwH1HaoAIQVwLtYXPW
         hXTw==
X-Forwarded-Encrypted: i=1; AJvYcCXH2lOEkedidrLADyy+r7TCsPpo5lnXL5Y1WmFly7ixDlgrJuKUqb1fbqwQDorxKy5IgQS952oNpoKIFD5+Eh0g045ncBg+
X-Gm-Message-State: AOJu0YxjpZ7rveQjXDfjU15tKBK1lUEGlsjgOUdGJZ/q1BJM3ro/WkSX
	v9ocPYtULiUmCI8/vVBk1DyqyGAs5PIvyF6k06mMVickCmYaztxaORHa/uS83xZL5sCGFbSpQZD
	Tatgtq6m2nzTkug0kl7Hu4Rw/QDDqwJIL6IcnuhoOrqsyeO9JEg==
X-Google-Smtp-Source: AGHT+IFMhb4Yp93mgzeuaou/4r1uy4LKjS7mUA920hU1pleLRumKEu7n3e/8ii8Dy8P7FjD/KDxjElSNN/7nt2xx/MM=
X-Received: by 2002:a5b:4ca:0:b0:dcd:19ba:10df with SMTP id
 u10-20020a5b04ca000000b00dcd19ba10dfmr3396208ybp.56.1712411311307; Sat, 06
 Apr 2024 06:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102313.GA310894@kernel.org> <CAM0EoMnEWbLJXNChpDrnKSsu6gXjaPwCX9jRqKv0UagPUuo1tA@mail.gmail.com>
 <b32bab8ee1468647b4b9d93407cf8287bcffc67f.camel@redhat.com>
In-Reply-To: <b32bab8ee1468647b4b9d93407cf8287bcffc67f.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 6 Apr 2024 09:48:19 -0400
Message-ID: <CAM0EoMkeErAmjksQKqOjL6uz00XXahvbgoHJWpCRjR-S6CkSGA@mail.gmail.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Madhu Chittim <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:06=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-04-05 at 09:33 -0400, Jamal Hadi Salim wrote:
> > On Fri, Apr 5, 2024 at 6:25=E2=80=AFAM Simon Horman <horms@kernel.org> =
wrote:
> > > This is follow-up to the ongoing discussion started by Intel to exten=
d the
> > > support for TX shaping H/W offload [1].
> > >
> > > The goal is allowing the user-space to configure TX shaping offload o=
n a
> > > per-queue basis with min guaranteed B/W, max B/W limit and burst size=
 on a
> > > VF device.
> > >
> > >
> > > In the past few months several different solutions were attempted and
> > > discussed, without finding a perfect fit:
> > >
> > > - devlink_rate APIs are not appropriate for to control TX shaping on =
netdevs
> > > - No existing TC qdisc offload covers the required feature set
> > > - HTB does not allow direct queue configuration
> > > - MQPRIO imposes constraint on the maximum number of TX queues
> > > - TBF does not support max B/W limit
> > > - ndo_set_tx_maxrate() only controls the max B/W limit
> > >
> > > A new H/W offload API is needed, but offload API proliferation should=
 be
> > > avoided.
> > >
> > > The following proposal intends to cover the above specified requireme=
nt and
> > > provide a possible base to unify all the shaping offload APIs mention=
ed above.
> > >
> > > The following only defines the in-kernel interface between the core a=
nd
> > > drivers. The intention is to expose the feature to user-space via Net=
link.
> > > Hopefully the latter part should be straight-forward after agreement
> > > on the in-kernel interface.
> > >
> > > All feedback and comment is more then welcome!
> > >
> > > [1] https://lore.kernel.org/netdev/20230808015734.1060525-1-wenjun1.w=
u@intel.com/
> > >
> >
> > My 2 cents:
> > I did peruse the lore quoted thread but i am likely to have missed some=
thing.
> > It sounds like the requirement is for egress-from-host (which to a
> > device internal looks like ingress-from-host on the device). Doesn't
> > existing HTB offload already support this? I didnt see this being
> > discussed in the thread.
>
> Yes, HTB has been one of the possible option discussed, but not in that
> thread, let me find the reference:
>
> https://lore.kernel.org/netdev/131da9645be5ef6ea584da27ecde795c52dfbb00.c=
amel@redhat.com/
>
> it turns out that HTB does not allow configuring TX shaping on a per
> (existing, direct) queue basis. It could, with some small functional
> changes, but then we will be in the suboptimal scenario I mentioned in
> my previous email: quite similar to creating a new offload type,
> and will not be 'future proof'.
>
> > Also, IIUC, there is no hierarchy
> > requirement. That is something you can teach HTB but there's probably
> > something i missed because i didnt understand the context of "HTB does
> > not allow direct queue configuration". If HTB is confusing from a
> > config pov then it seems what Paolo was describing in the thread on
> > TBF is a reasonable approach too. I couldnt grok why that TBF
> > extension for max bw was considered a bad idea.
>
> TBF too was also in the category 'near enough but not 100% fit'
>
> > On config:
> > Could we not introduce skip_sw/hw semantics for qdiscs? IOW, skip_sw
> > means the config is only subjected to hw and you have DIRECT
> > semantics, etc.
> > I understand the mlnx implementation of HTB does a lot of things in
> > the driver but the one nice thing they had was ability to use classid
> > X:Y to select a egress h/w queue. The driver resolution of all the
> > hierarchy is not needed at all here if i understood the requirement
> > above.
> > You still need to have a classifier in s/w (which could be attached to
> > clsact egress) to select the queue. That is something the mlnx
> > implementation allowed. So there is no "double queueing"
>
> AFAICS the current status of qdisc H/W offload implementation is a bit
> mixed-up. e.g. HTB requires explicit syntax on the command line to
> enable H/W offload, TBF doesn't.
>
> H/W offload enabled on MQPRIO implies skipping the software path, while
> for HTB and TBF doesn't.
>
> > If this is about totally bypassing s/w config then its a different ball=
game..
>
> Yes, this does not have s/w counter-part. It limits itself to
> configure/expose H/W features.
>

I think this changes the dynamics altogether. Would IDPF[1] be a fit for th=
is?

> My take is that configuring the shapers on a queue/device/queue
> group/vfs group basis, the admin is enforcing shared resources
> reservation: we don't strictly need a software counter-part.
>

I am assuming then, if the hw allows it one could run offloaded TC/htb
on the queue/device/queue

cheers,
jamal

[1] https://netdevconf.info/0x16/sessions/workshop/infrastructure-datapath-=
functionidpf-workshop.html
> Thanks for the feedback!
>
> Paolo
>

