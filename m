Return-Path: <netdev+bounces-152482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE19F4154
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 04:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687DA168300
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCAD13B590;
	Tue, 17 Dec 2024 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfvNvpEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB686252
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407635; cv=none; b=QDyqXjBfi7YP3op1GI73mSBeu91YKHWwUnxR3zTpxgisd19rkWy9aVjOiVsmEtYcEHPElXizzSO8hCrI73PlJhPXLAMBqk7N7X4JLrs6L4jc8ZiGd8qONZwf2VsN3jFYbjhA8OI6mdV6nAcbvTmR/h8Nz2WnbLdLuXHF3TWp7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407635; c=relaxed/simple;
	bh=JjvSUlb0s668mPGWJCN5daNkwa+E19w4qhP7lmASwqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5K4TXH13iNjI6dSca1hEK/fS7wJpgZFQJfZBS3ruwBDd5UEGXkXKceGQJ6rr8mJYeJmFPL2t1ROJ/G0sKgSrlC9WWYqzjb/tXFEn2/7w1QD7utlAgNHCFs7wuGeY+tgQbGkO4sPDFQDSPtLZT//NWVV65x7o6664gzNtCbtJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfvNvpEd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401ab97206so5056901e87.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734407631; x=1735012431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjvSUlb0s668mPGWJCN5daNkwa+E19w4qhP7lmASwqw=;
        b=JfvNvpEdPpWIdJa3d7+8og9fI37U6k2QsgcOXmXKDzaVq2nA+pxPcYqXqpy0gJkel6
         ckvHiF7fP9nuXAigThRQpfLUWRnz89oGF/PBBtbfKmZQ7ZT3UWW+fJDOE12h1kTqGyK3
         M/VLcSu602PDMe8O9ksJpKvpSJwM91kbgPL7m8T6Rh3muyoBxzmxKBGLVeIbEHNwuv4p
         rO6TiLoVElS6l+soOTPlnq281Ky1W0fBMymrnPAMvqfA7tJAQitn9I84Ib9Lk+wvy3uG
         T/dspzVI0zvp3aQhj8Huny5CLL/OEDYTyurZGD2v8VGYLU06cjPrCzaDbIKK/wytI4QN
         QNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734407631; x=1735012431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjvSUlb0s668mPGWJCN5daNkwa+E19w4qhP7lmASwqw=;
        b=I2SBaH6gxUjUtNZuLtrGyetFbc4zOs78zoobksrvJkVVPDDtETPoYSuU4Azoq69ihF
         atdokmmXJSGMZjpx45iTJojyF6NgCy7q8gm4EjrjmktH0t6AgPsuPqtydf0kpJtb3B2e
         679uk3Ld9wZkubGTZ5Mx9AoJ32v8X1sUKW9c0JBh2Q4H/EH8PZxSm5OwGj/MHxQvnZq9
         VN3ECu1lpssgGDknRX7DIxQwAtTaqP+2RkL/QEfp6QdzVsoWSE58/WQunQiTVEq1fXnT
         JQWIeX83k9Ke8iETdm4ok8Ww+aPM8wkSC1MnqdcwPJH6WA6NEzKs+Wjss8+sSpSZjO1X
         +PSA==
X-Forwarded-Encrypted: i=1; AJvYcCW3oMQ7iNVAGddXmb4sGP3pdShzceSz5X69N3O0i7nOygyoddAEd0OTzxsDsXUpaspZvVdlcms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGOTptX0TIXSrZ3F217tsMygZoL6V0gwQCfyUECW3SRloinAl
	FtpS4nD/mhmqxUZOAJ0F4k4FgALEeU1XxaIFqn4E5sUXdDF3AHTngKTin6y6IYCp2vYqsJVwJcH
	anQtZrzXYoaJMhtopKwgmUzpvpdRnLDPPr47M
X-Gm-Gg: ASbGnct8J1kK+dxN8Je1cjda8gNVmY+7D44wnYj5I/Dro3vA3bjY8s5YPgkXt0fQgsa
	CQXTu+xsUodlyap/hXCWH8+rLvFCokTLqTv6gWw==
X-Google-Smtp-Source: AGHT+IEaU+0Dd9AvGqqW/gw3nElxtLBX5cPHOWjS/rZC4WRXjtt2rbtyzHwmhZDGDsLUxRYrcn3n+1g/30SrxJzWcCw=
X-Received: by 2002:a05:6512:2255:b0:540:1e17:10d2 with SMTP id
 2adb3069b0e04-54099b696c9mr4317280e87.49.1734407631461; Mon, 16 Dec 2024
 19:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212224114.888373-1-dualli@chromium.org> <20241212224114.888373-3-dualli@chromium.org>
 <Z2BtgqkPUZxE8B83@google.com> <CANBPYPhZ-_5=VMRoBxbfVb+AFb_qu49QH_hKOiSjX93E1GQA8A@mail.gmail.com>
 <20241216174111.3fdce872@kernel.org>
In-Reply-To: <20241216174111.3fdce872@kernel.org>
From: Li Li <dualli@google.com>
Date: Mon, 16 Dec 2024 19:53:40 -0800
Message-ID: <CA+xfxX6-cbTyyyTf1UL_A7DzagfrV+y0367MdO21+JdjW870ZA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, corbet@lwn.net, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, donald.hunter@gmail.com, 
	Greg KH <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	tkjos@android.com, maco@android.com, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, brauner@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	Hridya Valsaraju <hridya@google.com>, Steven Moreland <smoreland@google.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024, 5:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wrot=
e:
>
> On Mon, 16 Dec 2024 10:58:10 -0800 Li Li wrote:
> > > not: There are several places where you have "netlink_nl" which seems
> > > kind of redundant to me. wdyt? IMO you should drop the "nl" in all of
> > > these cases.
> > >
> >
> > These are automatically generated from the yaml file. So let's just
> > keep them as is.
> > But it's a good suggestion to the owner of yaml parser.
>
> I think the unusual naming comes from fact that you call your netlink
> family binder_netlink. It's sort of like adding the word sysfs to the
> name of a sysfs file. I mean the user visible name, not code
> references...
>
> s/binder_netlink/binder/ will clean this up..


I did consider that but unfortunately that would result in a
conflicting binder.h in uapi header.

Probably "binder_report" or "bindererr"?

