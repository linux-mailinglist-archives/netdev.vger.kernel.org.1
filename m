Return-Path: <netdev+bounces-89648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB08AB0B2
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B61C2153A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6212D747;
	Fri, 19 Apr 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ikg9xlii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626985938
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536711; cv=none; b=Jm8ghavTDYhiDevy+OjwgpxG+NXWp9rQDOG4SQH81MxanKC/aO2+0/d8UW5XTyy7LV7QpBsX8ew14PqXQ5nWnwBjDxBKOWs/fzdZUHF1NADZxCJ4DQJbKLRTEAswZBppsK5Xm3PtH3Z+B+a4kPQ/MKPOmOppcMviSr/pfOIIMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536711; c=relaxed/simple;
	bh=0fTY39J89j0LbRjP2d5n3yXjK43A/AUjDcSxEml5MAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSYm9hh2l5f6iKF1qN5RmO1n2XxUTKOuMMIu+vT/cWmofUox+OL6XEEodeB6M794kgQR15IM58yFFgwyd08irOqw6AWqoUgGziMmThmOLMs0D2RZpXJmOvowDJ4IcMM39x5++S29MG8AaFc9jOiDnK2XB9P7GHOfXFwr2MxC/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ikg9xlii; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6098a20ab22so19466477b3.2
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713536704; x=1714141504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfWkv0XjH7C3iA4uCHqcL6RziBZAAX/YaGgCE1Bxx4M=;
        b=ikg9xliif8ATuWfnQMHoGAqjdKCAxU3pvilwxaSym2RlZCEK2bo/m9sWIDUSAyv/fn
         1G1wlEyxf0y066c/82yGPFYIBUrFfVi7lp2zWHE0SzIreftuwIZNW68wt1j9Xug8w/ze
         L682ARJx2MHoS6PNYWPG7x9RAo7mFnu0sw8vPQQPkovISGgo/dZRqiJAk66oYpQbtSA0
         /5BVQAah0smb5Up4uZdlKRFSSQKiBwf1qZUcxTwPnhvMpLgH1CI8AcY4Mi2NWc1T8Wtv
         mxZalKIQ5PRZL/10rQqPY4CpN2IPYxP+VARbPNs3XP+HH635iJ89k/otzMJP9tNy+rBX
         AcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536704; x=1714141504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfWkv0XjH7C3iA4uCHqcL6RziBZAAX/YaGgCE1Bxx4M=;
        b=sq1bUAP8xgUZasGMoPbJi+91s6xPKolE3TrzDCMU1MEU/RXnJlg8kWpYrIh3gAst+g
         G7UWC6eTJ3Bqb61wPvCJYpHhltLByxOiUE7D/uvPhlC+tt3ZrO7ScJBWyZbCF2Q7WNJ/
         LIrNyitWv+uuseURNxEwdqJ+gWgQqiz6UhCOVLMlfho9vCLH8OlH3m4Le9yGnhARAO3T
         gOrDamF65CJw0Nf0rLsVFmY2PI/sSPHGZo5+xRG/UPHPPYq0s1hH7Rln8xZ/XSCst3Pw
         acYI2uRe1ztfVf04Bxa4gd+TsRyIUYzhTUtb7Evw9F9U1LWgZTXyS7XxAPSRSPrMmpwW
         7wzw==
X-Forwarded-Encrypted: i=1; AJvYcCXlYHoW+q/xn5TBs1xNhO503JXurpas1+Qw+D8DaCEgJHXTXodkaNI30UEIpNusBekJfrPVWjrG5U7sQgk6iGGgIy2UsSNp
X-Gm-Message-State: AOJu0YwhKi3BIF6S+mLJ5M4oEPiYR+BopjfXACo/oqbUZnnKefe2HluY
	6NGdeN+uP0beo5fyA/9VEnsBuuKegaRTt6GSqOmSVyVejklt4WRxP8IwF94m/llY0JAOPFn/Yia
	uNeuNoiIkyTJECc2JjHCyjxrd7haqGyuOr7Qj
X-Google-Smtp-Source: AGHT+IG+ne+8p13Htb14aXLkntTilSPKC/OeqzVzwVQ2A5/iR3GHAUhe50ICQhOW0wIGDKSVxg0PpIceEjZbsM70aXw=
X-Received: by 2002:a05:6902:1b02:b0:dcd:aee6:fa9 with SMTP id
 eh2-20020a0569021b0200b00dcdaee60fa9mr2275087ybb.53.1713536703890; Fri, 19
 Apr 2024 07:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com> <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>
 <20240418150816.GG3975545@kernel.org> <CAM0EoM=Cen-0ctMkBvDL-jsuwPKGetz4yTG+RpmW7dXjjeVaQg@mail.gmail.com>
 <20240419071809.GT3975545@kernel.org>
In-Reply-To: <20240419071809.GT3975545@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 19 Apr 2024 10:24:52 -0400
Message-ID: <CAM0EoMnLDrpoU21K85fun2ncN3r3ucF3p6ajw0H_-XoEsyDn5w@mail.gmail.com>
Subject: Re: tdc [Was: Re: [PATCH v2 net-next 00/14] net_sched: first series
 for RTNL-less] qdisc dumps
To: Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:18=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Apr 18, 2024 at 07:05:08PM -0400, Jamal Hadi Salim wrote:
> > On Thu, Apr 18, 2024 at 11:08=E2=80=AFAM Simon Horman <horms@kernel.org=
> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 06:23:27AM -0400, Jamal Hadi Salim wrote:
> > > > On Thu, Apr 18, 2024 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > Medium term goal is to implement "tc qdisc show" without needing
> > > > > to acquire RTNL.
> > > > >
> > > > > This first series makes the requested changes in 14 qdisc.
> > > > >
> > > > > Notes :
> > > > >
> > > > >  - RTNL is still held in "tc qdisc show", more changes are needed=
.
> > > > >
> > > > >  - Qdisc returning many attributes might want/need to provide
> > > > >    a consistent set of attributes. If that is the case, their
> > > > >    dump() method could acquire the qdisc spinlock, to pair the
> > > > >    spinlock acquision in their change() method.
> > > > >
> > > >
> > > > For the series:
> > > > Reviewed-by: Jamal Hadi Salim<jhs@mojatatu.com>
> > > >
> > > > Not a show-stopper, we'll run the tdc tests after (and use this as =
an
> > > > opportunity to add more tests if needed).
> > > > For your next series we'll try to do that after you post.
> > >
> > > Hi Jamal,
> > >
> > > On the topic of tdc, I noticed the following both
> > > with and without this series applied. Is this something
> > > you are aware of?
> > >
> > > not ok 990 ce7d - Add mq Qdisc to multi-queue device (4 queues)
> > >
> >
> > Since you said it also happens before Eric's patch, I took a look in
> > the test and nothing seems to stand out. Which iproute2 version are
> > you using?
> > We are running tdc in tandem with net-next (and iproute2-next) via
> > nipa for a while now and didn't see this problem pop up. So I am
> > guessing something in your setup?
>
> Thanks Jamal,
>
> I appreciate you checking this.
> I agree it seems likely that it relates to my environment.
> And I'll try out iproute2-next.
>

Yeah, that would work although i think what you showed earlier should
have worked with just iproute2. Actually one thing comes to mind
noticing you are using tdc.py - that test uses netdevsim. You may have
to modprobe netdevsim. If you run it via tdc.sh it would probe and
load it for you

> For the record I'm using the Fedora 39 packaged iproute2,
> iproute-6.4.0-2.fc39.x86_64.
>

We use debian and ubuntu mostly.

> For the kernel, I was using net-next from within the past few days.
>

Havent tested the latest/greatest net-next but say 3-4 days old net-next.

> > > I'm not sure if it is valid, but I tried running tdc like this:
> > >
> > > $ ng --build --config tools/testing/selftests/tc-testing/config
> > > $ vng -v --run . --user root --cpus 4 -- \
> > >         "cd ./tools/testing/selftests/tc-testing; ./tdc.py;"
> >
> > This looks reasonable...
>
> Thanks, that was my main question.

Just what i said above.

cheers,
jamal

