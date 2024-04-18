Return-Path: <netdev+bounces-89462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EA8AA59C
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 01:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E158EB2161F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539F4AED6;
	Thu, 18 Apr 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wSDcJLRX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E8286AF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481523; cv=none; b=tuDq6pX7CstW0MI1nMI2FNVSi5u8org6ohTzhwtC7ReDM8Na3C7QlvxDnuzpSluN/+o15vOxMdYXhObfiy4lmoOg0U41myFaaN9NRkJtVmRhi6eTiUb0+DIOdbOHok0fAhzyATiOXSP/J4y9BGc3Qi46hqeKPGIaZiVCl4uxXWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481523; c=relaxed/simple;
	bh=zE/X1c2GWnLTEWZsM2SNSsv7zJ1QqOOdnKpuwt9eJPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8IXDIjMzk9Rnw0yJGRgZs++dBCnN3QrBIqrzyIZh/C6p4oslxGy3xp01eVrh1yHpB6ordShsECRTpowVPHeJeIz4M0k9nXQAunkgPL6SYSE+dtVCHXCluEAYPvHp+qd8Mp9F191U34BBLdRWsIkq46vAdUuiSvCvqTorhDBlTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wSDcJLRX; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso1682171276.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713481520; x=1714086320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1iZDc8ti+hRIsONcPGumEwX6irint2hC+ddeAPUmUc=;
        b=wSDcJLRXQclsZPqvnr4m1P7ySYQNae0un2OnlpUlz+SOb9H+5d1AnR9JAOnHou4cs+
         JGd9kZLvZR13ZC2DkkfT3wusrfqlVDMWdjWdv2kMhqHJxCyb7HivadeGdFZ/PmgmsMK3
         h0vP2GROnUrc1lXrY9EpE+5VRTGGYB8JuUGyn4mXC/K9JSh74tFK+MSG+1gxemItR+k/
         M22J8I14gyp58a7qUGOdXtFqhoGO5NYbJuCPA3OUPmf+NfnD9mUcTFRnuXgn5R9HpdzU
         ZJU6OE0VVmnq0Nlj+X2kb0Rwp/nREcatstwqtW1sEX06ksqHkF+bJSk2ItAS8zBYHTYR
         6Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713481520; x=1714086320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1iZDc8ti+hRIsONcPGumEwX6irint2hC+ddeAPUmUc=;
        b=t+X2H9OMoioOGG4QuVzwhWZ5mmMYYWSrSVkao7I453Ddtn6jx2GKzr10fn99Gf+w++
         a1dUsiuucO8qXCpyY6haDefjDgit+mrp06p28g7F3Vsos1DbYQq+/kDNtYKMpK7Ij+RM
         YuYkbNTOMGsCVzIo13TKsx/eeAaB+G0NhNkRdgjo6JLBJedOIAIsV5976G48iGRZecce
         kFcU3yxf69KP3hDj9VvuJSPPo/+NupsW5sERIKVuzdayuSHy+l/G/1kZfyesh/9rOD1G
         2WsyjlumRJdQ7vZ+PE28AvDk3Pfx7uuNqrOXVvqOQK9CFAIP8xxoNaXDgajGtHhrGD6l
         Uf2A==
X-Forwarded-Encrypted: i=1; AJvYcCUAE4Cd5pzYlj0OEq2NEWxUhI781bkqEN7iYdwap5zGJ+li75K2I+fWIOEt0RA9vlEzRBIiGbq+HWfd1Nb39RuIer/bI0qp
X-Gm-Message-State: AOJu0Yyqr6gmwTRH0EVeNIF0almCM3ANGHarfkVHW1W9xoBiVQOu3xe9
	lP8kQY6dXbVCjtCVKO5fju0bQNDoIPvflO1IaIyYojJbFcQ3ge9KgdB/qPi3THeGz7j4e5WNtP5
	I7ZdjVbytniQ/ZUbqnnj4tFQP+9w/sBTUoy1D
X-Google-Smtp-Source: AGHT+IHFLhFbi5GM9mAA9rRvBkoGLe00u7yq+qMap3AYiyCfn+FK522bMf8820ohGe3mBmiSuVItkvz3gxAU/iwcrYo=
X-Received: by 2002:a25:ced2:0:b0:dc7:d6:fd44 with SMTP id x201-20020a25ced2000000b00dc700d6fd44mr297051ybe.65.1713481520307;
 Thu, 18 Apr 2024 16:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com> <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>
 <20240418150816.GG3975545@kernel.org>
In-Reply-To: <20240418150816.GG3975545@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 18 Apr 2024 19:05:08 -0400
Message-ID: <CAM0EoM=Cen-0ctMkBvDL-jsuwPKGetz4yTG+RpmW7dXjjeVaQg@mail.gmail.com>
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

On Thu, Apr 18, 2024 at 11:08=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Thu, Apr 18, 2024 at 06:23:27AM -0400, Jamal Hadi Salim wrote:
> > On Thu, Apr 18, 2024 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > Medium term goal is to implement "tc qdisc show" without needing
> > > to acquire RTNL.
> > >
> > > This first series makes the requested changes in 14 qdisc.
> > >
> > > Notes :
> > >
> > >  - RTNL is still held in "tc qdisc show", more changes are needed.
> > >
> > >  - Qdisc returning many attributes might want/need to provide
> > >    a consistent set of attributes. If that is the case, their
> > >    dump() method could acquire the qdisc spinlock, to pair the
> > >    spinlock acquision in their change() method.
> > >
> >
> > For the series:
> > Reviewed-by: Jamal Hadi Salim<jhs@mojatatu.com>
> >
> > Not a show-stopper, we'll run the tdc tests after (and use this as an
> > opportunity to add more tests if needed).
> > For your next series we'll try to do that after you post.
>
> Hi Jamal,
>
> On the topic of tdc, I noticed the following both
> with and without this series applied. Is this something
> you are aware of?
>
> not ok 990 ce7d - Add mq Qdisc to multi-queue device (4 queues)
>

Since you said it also happens before Eric's patch, I took a look in
the test and nothing seems to stand out. Which iproute2 version are
you using?
We are running tdc in tandem with net-next (and iproute2-next) via
nipa for a while now and didn't see this problem pop up. So I am
guessing something in your setup?


> I'm not sure if it is valid, but I tried running tdc like this:
>
> $ ng --build --config tools/testing/selftests/tc-testing/config
> $ vng -v --run . --user root --cpus 4 -- \
>         "cd ./tools/testing/selftests/tc-testing; ./tdc.py;"

This looks reasonable...

cheers,
jamal

