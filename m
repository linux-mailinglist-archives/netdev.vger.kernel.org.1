Return-Path: <netdev+bounces-155058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A41A00E0C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E29D3A06A4
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A31B412B;
	Fri,  3 Jan 2025 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvp6idgm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33070155C82
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930157; cv=none; b=VfyGeUjefdWEpyH/i3hD+FBI5BosR7VOB3u2mTbIztm1ioh0hIcCJUz7tY9jjkstWKEiOIFOZbA6ODFJPY3kBt3tq29tjLtTkOpQ3+xsJqEYbvXJHWj4yyoi3r4mygQB8GERbqtqlgiN25hSOkqasNBlmpldbb1JflkTXnEVHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930157; c=relaxed/simple;
	bh=Qm2GI8eKvHzeSTXrz8DN9UOA66LyyHqIPo1x9xMd9d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO4vU3bjK5gribeIn6fMbvxphyFIx7wvdNjE504qoM6ngACcQJXL4qjh2AGyuMVJ4gzWxXoUf0vaPYOjdRf19opKZOmdxGqWHGYf+J6N0nyg1qyXox4Nfb1DDP357uIbU7RcEHTKqlkw+aY26cj+0ckatTvn4be9eIgUC5KnYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvp6idgm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so21926292a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735930154; x=1736534954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTcVLIJ74PxU1fTS0H3rfnT+JSeKqq4DP3qwUoq2k9I=;
        b=jvp6idgmO6XiFzeyD9zSl2BdJNg6GYco1v41GxhYWs7vCcECHfy+GWhXJfyeDnyJP7
         LmunMwxnIJZmKUL3/OKZbP69zlgOZ8mgYgzcVuhM6FXrJtaeC7mU3s5TavQQDTDlNMrD
         wR79INjFWbP66Uynf9B9HV7uH4M362YBoGpzxMUmdvpReN3p2hfDtWRX7WLYwkc0WwZB
         3LgrZClQeOFft0g85HB0+yEJL9sGZp05ghrFPCAK5i8KruaHbaM3VPHKjYI81w7fSgx9
         gb2+96Bncicow9S5bDZqr8ej4WE82UvKqzzQ575zGxfQHCAirWAu3384HAxU4wI5pGXY
         a5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735930154; x=1736534954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTcVLIJ74PxU1fTS0H3rfnT+JSeKqq4DP3qwUoq2k9I=;
        b=TtRqIwqhf1z0W11Y2Bt/IpI5+lfgb3xFzFgPNz/gIBPkf++x71FnOmIcam8qxd2ugY
         Dti+mgTWb4tbZ1qrYROa2ciPH5uap3Y+fq8cSNgUrIXxdkHVNtF1SoDIXBk31MiaCIX7
         xZ/OtZiPxRZ/m3/+bd3itm5k4l74USaiIsxfITXwG4LUdoe9BZfPi8maGA/rBOzIPv0T
         zKPAf5b4CoYG0kklQNoWyRENlEysJ9IlyPxFJhZkNRKi8ei814JniYg5zebFmLM3GNoC
         tRTJf+qnSQok7Dx7TXdctBwjKmh7gV65pYoIMqCWyHiQnzATxDnKfyQ2tpOXwJ2tbmAE
         BYKA==
X-Forwarded-Encrypted: i=1; AJvYcCXuhHF863ikuiyh//qkSJmbknJFg+QfitPFceZTRAEZxrm534SeEdjksyBdyLtODKEb/efd7V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbf7bkSDtI4AxpsQi+BCuX0zcDkTUItPXdtZ62lOIcx+zsy4XU
	41j2At9lvwOoEb5MfuTTpPL8mLrdFYtZ515WzpzvamtBB3r/rdoEQcODKcwevK9pRISYOaXScoN
	ecQ6ybVyc7ZWJBlOQr519bNpMIS11+u8bvSiL
X-Gm-Gg: ASbGncsUZhrcIvPqPW2xWeTKX0kyP8wUfMJiQLC8uHTw0fMH8IgSkEciqawpLegVMC2
	KpWiH+HHJ3sGTFK9iTL00nLw51D4afKMZISeavQ==
X-Google-Smtp-Source: AGHT+IEbLEExJ2JQjtuwLVLY6Di2pqvorwo/QQtScoZJP10Wltqbc2JwCR0qbk8x+mXLv/UejZK5BMwULOGtEfLLQ1U=
X-Received: by 2002:a50:cc46:0:b0:5d9:a59:854a with SMTP id
 4fb4d7f45d1cf-5d90a59945bmr4740573a12.13.1735930152985; Fri, 03 Jan 2025
 10:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6742badd.050a0220.1cc393.0034.GAE@google.com> <CANn89iJbfy890gJuqAU-tY76ZSGS0W130KO7=9jvtHYUVzdSmQ@mail.gmail.com>
 <Z3fOdnotJMKWjCNe@calendula>
In-Reply-To: <Z3fOdnotJMKWjCNe@calendula>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 19:49:02 +0100
Message-ID: <CANn89i+NNUFqOyFo0M1J=goz_jK7=zVNYh2jo47eUYWFr-ovow@mail.gmail.com>
Subject: Re: [syzbot] [netfilter?] INFO: task hung in htable_put (2)
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: syzbot <syzbot+013daa7966d4340a8b8f@syzkaller.appspotmail.com>, 
	coreteam@netfilter.org, davem@davemloft.net, horms@kernel.org, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:48=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Hi Eric,
>
> On Fri, Jan 03, 2025 at 10:52:54AM +0100, Eric Dumazet wrote:
> > On Sun, Nov 24, 2024 at 6:34=E2=80=AFAM syzbot
> > <syzbot+013daa7966d4340a8b8f@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.ke=
rnel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13fd6b5f9=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd2aeec8c0=
b2e420c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D013daa7966d=
4340a8b8f
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >
> [...]
> > I do not think I got any feedback from
> > https://lore.kernel.org/netdev/20241206113839.3421469-1-edumazet@google=
.com/T/
> >
> > Should  I repost this patch ?
>
> No need to, I will add this to nf-next now as you requested.

Thanks Pablo !

