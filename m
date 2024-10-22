Return-Path: <netdev+bounces-137707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3989A96F1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 05:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75571F26EA5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FD14B092;
	Tue, 22 Oct 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2KKWHav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549713B297
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 03:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567019; cv=none; b=EmTYyoDT0igfXFfiDsBAQdQ+2LurJUqQI/ZtQix/AUuhXPpogcG05mwHh3GqdIvfiPepj4+kKd5kCwnXZMctL07pquvkske2KxbPS0qy091DscGU0kkiY872qRSCp3W73yDz5lEm26wbcMmDPqyfTlCoZTBAYlPyYn/FVm6wXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567019; c=relaxed/simple;
	bh=OEmfwiAkoZN1ST5JdtiQAcgQq190u8l5XLy4d0qXCzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVdhbJHdo/ZnQsaYQAe7zlPtSXALTjCDLMmN053ywYK7rMlIGHMYtESmm+G05E6PS/dX2lfop1mva9GClrgiDVfZfI5QIgD1CTRYIgmomFbTQgiI2V+jj6gaBXVSndz8s7zh5syeEBNQgMahGoO7HTEgGJ3+dWejIKGaChy4oqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2KKWHav; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e39bf12830so36039547b3.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729567017; x=1730171817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/cn0iNCyYAWaqDPrWymeoJ6QjtEh5iPBAJ25ZQN+F4=;
        b=W2KKWHavr0eeteka2CtXuIWga5kauzxcisbSFCiIa4aLAeCxS673CNNzDfwJvi2lbQ
         OsrTg/gXhEYi7sy6jgSROoBIw334g23jVR8WupajHb4G3ruFGx/v9Yh1SUeTLXBLwnJZ
         TTKWX0bxRLRhFh40qYdPEhdybDfARbanQBpOfwZ9XbfcFpcPBvocyrEO0CpawEO8XZx0
         eROMuvZpqEGI0YaH5dCufF30pQ5BlFm1ppJ6mO9NKnkFRcq5nGdVMPYjbc7fTef7enbg
         kV6GqDuULQc3768YpU3lAeOf47K3j80nmhznPhmn6J0s8f672w7uKoJhnoPDeDuq71rA
         OebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567017; x=1730171817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/cn0iNCyYAWaqDPrWymeoJ6QjtEh5iPBAJ25ZQN+F4=;
        b=Hw7diWIucTvUUCJoIE5JjY1ExzDWVsiwHGorPOwBPuF30qEfxdinUL8md6h+01UNcj
         xsEaJtep+NiJ07hdHwN3L5opdsfOuqBxzWs45Dv7lSrPkDWzOoaJVoLWsF5sdZFThe/7
         egReg0+kuSkp5hyG/ZCl5dJhCqLdZeHA8OE4uS8BQ9mqYWYgfTyXhYy+sx4A10ygwR8o
         iTNHdP5+xUYOaTiXlU+9tVnIqqNx4NUg4vfl7f+VxP0+/q9sk7qFEy9qeCuiNm7TgHfn
         5xZvqj/gg3TlGYci/hy6eRFleoYfZL/6Vw4c4pzhWWkNfXiy9GV1B6EIAATATWWB6F7Z
         eZPw==
X-Gm-Message-State: AOJu0Yyx53ObGuApUdL5PMW7PDllvKD0/xsn83qupPfFb7JrGTWYwn3r
	ZcI8LTvQGfoh8Cp6RzceUD+UOfj062/9w+WCZbRbOdImwPDGCe61d6qW4HftkuquKh6byWueZyH
	6lsAQfS1Dt5l7KvigyFs3tSkPbmw=
X-Google-Smtp-Source: AGHT+IFRk9XzxSsT9ULI+6gld1WMI5Vz5Pn3tTaPjwiKTRyp8Y0VIg3sDi0/mu/fTFHvTtDvWOp3qtiKrMy6jdISIr4=
X-Received: by 2002:a05:690c:b9c:b0:6dd:c619:4cb1 with SMTP id
 00721157ae682-6e7d4334d5amr16437527b3.0.1729567016653; Mon, 21 Oct 2024
 20:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930031624.2116592-1-wojackbb@gmail.com> <e2f390c7-4d58-47fb-ba86-b1e5ccd6e546@lunn.ch>
 <CAAQ7Y6Z2xkgxv36=WOxbUArCw3eBeY0nx_7nAH36+Wicjs_fPg@mail.gmail.com> <562c8ee8-7ce3-4343-9d93-b01be1235954@lunn.ch>
In-Reply-To: <562c8ee8-7ce3-4343-9d93-b01be1235954@lunn.ch>
From: =?UTF-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Date: Tue, 22 Oct 2024 11:16:44 +0800
Message-ID: <CAAQ7Y6aqLJoScfVD3NMyw_0r42qYS2BCCWa5iRDaM8h1EKwwkg@mail.gmail.com>
Subject: Re: [PATCH] [net,v2] net: wwan: t7xx: add PM_AUTOSUSPEND_MS_BY_DW5933E
 for Dell DW5933e
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com, 
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com, 
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com, 
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com, 
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn <andrew@lunn.ch> =E6=96=BC 2024=E5=B9=B410=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:09=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On Tue, Oct 15, 2024 at 10:48:15AM +0800, =E5=90=B3=E9=80=BC=E9=80=BC wro=
te:
> > Hi Andrew,
> >
> > We have a power test that uses a small script to loop through the power=
_state
> > of Dell DW5933e.(/sys/bus/pci/devices/..../power_state)
> >
> > We expect that PCIE can enter the D3 state when Host don;t have data pa=
cket
> > transmission,
> > but the experimental result of the small script test is that it is only=
 in the
> > D3 state about 5% of the time.
> >
> > We analyze logs to found that Dell DW5933e occasionally sends signal ch=
ange
> > notifications, and ModemManager occasionally captures Modem status.
> > Although these situations are not very frequent,
> > However, since the default auto suspend time is 20 seconds, the chance =
of PCIE
> > being able to enter the D3 state is very small.
> >
> > After we changed auto suspend to 5 seconds, PCIE have 50% of the time w=
as in D3
> > state, which met Dell's requirements.
>
> So you answered some of my questions. But missed:
>
> What makes this machine special?
>
> It is maybe because this machine occasionally sends signal change
> notifications? There are modem status changes?
>
> Have you compared this to other machines with the same hardware? Do
> they do the same? Or is this Dell special? If it is special, why is it
> special?
>
>         Andrew

Hi Andrew,

The chip of Fibocom FM350 is MTK T7XX,
It is the same chip as our device.

We tested the Fibocom FM350 and It had the same issue as our device.
The following tests use the same environment and steps:
a. Make data call to connect Internet
b. No data is transferred to the Internet and wait one minute.
c. use test script to capture and count power_state until one minute.

Result:
1. When autosuspend_delay_ms is 20000,
Our device's d3_cold time is 0%
Fibocom FM350's d3_cold time 0%

2. When autosuspend_delay_ms is 5000,
Our device's d3_cold time is 80%
Fibocom FM350's d3_cold time 60%

So this problem is a common problem.
Should I remove PM_AUTOSUSPEND_MS_BY_DW5933E,
and modify PM_AUTOSUSPEND_MS to 5000 at my patch?

Thanks.

