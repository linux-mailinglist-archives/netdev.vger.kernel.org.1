Return-Path: <netdev+bounces-119467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619E4955C4E
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657811C2080C
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E9182C3;
	Sun, 18 Aug 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frSfcsiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B117BA9
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723981391; cv=none; b=KumgUfYgYs4ffi33sbdSIc0JvI//Pj2GMu3Z/9mLLE9tdSHVkjIlJvXz4dqR0TWlq1EhZ+NMRuMfhy+aeF3Ozd4mvkR/b9q/9+JDPpjsMCtkpbkpxNsoaSGknmHnvUZC+k96Ov0f1pikmNqcSBqax3gF6UFgVtW1BucdAP66xRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723981391; c=relaxed/simple;
	bh=Zm7VaeaLhcZqz7JaxGlwFYfgbE5VlDic3sr5IzYcpL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZZyPGSigG2CQzU9/KVTM+eiVjJPoa18U6e8ROuw6csswYzmA0bNBgUAGVHLA3S6U9J9O1nUhDLt13oUp1YPrq3B7hgqSghhgg21WR8YhWdOd2IY/lcIXuVJOCZnws1pd0b/7/tI54LZM1GPA8mGhp9VGNa7G78ZcDfhpa8fqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frSfcsiS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7de4364ca8so387969966b.2
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723981388; x=1724586188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PuMoSZdyaXN6XUG9k+7d/wUz2pU8XEUlINIYJsahzc=;
        b=frSfcsiSxXeXJFS9mGTI96xAJ89vmGRkY5iPCNzVBtMerlEcLtvMHmzjXrig5Ecw6P
         2OoUMUt4R5OCIxMk4odeF9qpDzrnFVvo+dy5qqrOr8iRXqaY9hfj34XQXVhR/7SePVWU
         AvYDbn8kMeIUhbtdOMyDcJH2o5ANcyX2Z6C7v7VYeLRz2iiI2rLZX0ZxlvCHG/GhChN0
         TzVfVYtLp4RYRfv3IXiSujYT8nrSVX7YjhkpIKiWuBFQW/WjUzMmgzXEQDyaPS2ZhPeV
         p8lBDYEqDiqOmozUAA0Sr8PURl7dlmvyYpe8xpT6ahVR8pSfTyxd5p6660Xt9CiXUhy3
         zh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723981388; x=1724586188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PuMoSZdyaXN6XUG9k+7d/wUz2pU8XEUlINIYJsahzc=;
        b=BXONqAweTxKpH/ZHtl62K+p36kvY2/aO03qTsZjuQZZ/U3hVhvfSADbKWuTlBbLkMf
         cLhEFinnzP5jx2I9IaLwln8ytax6voj+S329u9jMFulEYHPhvsmtPC+O9RilI9jCerJN
         OzTqkxU1bhPiNYe3mHY4993H5PhQ1CGi9pJLuQOawYHcSVdykqBnlLIw/YqIfhLUdPMn
         cEoT66+Gq7gwyCcIrCyHmGZnedXKjtMst+AVTZahsAaMVUuS+f/rrweagcsyY7HYIgHD
         fiEPL29b5ZWCnPIZufTo3UxbGBIpXol33FgAA9bLMyDzStEcWAj36NwS4yp6l22st/SH
         puRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU4WioCinethlIkJkgf3PH7C7ROROe/AkbJC/yog2IjW2fLvW/iESQY5r4+av/ADUMGkXt73Q97O8KsUD0bOny9eaO6j2R
X-Gm-Message-State: AOJu0Yyntlj0u+nle/sawumD76hGiADIAifS5TkX6nEVXg7AZFKVdCAm
	ySVX4Tnd39dekFprZ99B8glwR8sPr/+opnoot73iIVG0cFRQieEYXSF6juZAt/HVHxSPSPwaLp0
	b7W4Cp6ZsrV43RZWQxkSzGI145nOF2s1Bw/V6
X-Google-Smtp-Source: AGHT+IH4KBS5/hzIpQHpQ5/YuOamAE2rl0AsFihXkl2Nu38uMr1DDNY3mq5fsB23/ew636LXFLmMAFskaNQSjRoLOUM=
X-Received: by 2002:a17:907:e2a5:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a83928d7b9emr519346566b.20.1723981387521; Sun, 18 Aug 2024
 04:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175b3433a4c.aea7c06513321.4158329434310691736@shytyi.net>
 <202011110944.7zNVZmvB-lkp@intel.com> <175bd218cf4.103c639bc117278.4209371191555514829@shytyi.net>
 <175bf515624.c67e02e8130655.7824060160954233592@shytyi.net>
 <175c31c6260.10eef97f6180313.755036504412557273@shytyi.net>
 <20201117124348.132862b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <175e0b9826b.c3bb0aae425910.5834444036489233360@shytyi.net>
 <20201119104413.75ca9888@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <175e1fdb250.1207dca53446410.2492811916841931466@shytyi.net>
 <175e4f98e19.bcccf9b7450965.5991300381666674110@shytyi.net>
 <176458a838e.100a4c464143350.2864106687411861504@shytyi.net>
 <1766d928cc0.11201bffa212800.5586289102777886128@shytyi.net>
 <20201218180323.625dc293@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANP3RGfG=7nLFdL0wMUCS3W2qnD5e-m3CbV5kNyg_X2go1=MzQ@mail.gmail.com>
 <17a9af1ae30.d78790a8882744.2052315169455447705@shytyi.net>
 <17a9b993042.b90afa5f896079.1270339649529299106@shytyi.net>
 <CAAedzxr75CQTPCxf4uq0CcpiOpxQ_rS3-GQRxX=5ApPojSf2wQ@mail.gmail.com>
 <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net>
 <1914270a012.d45a8060119038.8074454106507215168@shytyi.net>
 <CANP3RGdeFFjL0OY1H-v6wg-iejDjsvHwBGF-DS_mwG21-sNw4g@mail.gmail.com>
 <19147ac34b9.11eb4e51f218946.9156409800195270177@shytyi.net> <CAMGpriVD6H4t9RSTBeVsLqPC5TGHoMkjOE1SE=MCMDgnxOK7ug@mail.gmail.com>
In-Reply-To: <CAMGpriVD6H4t9RSTBeVsLqPC5TGHoMkjOE1SE=MCMDgnxOK7ug@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Sun, 18 Aug 2024 20:42:56 +0900
Message-ID: <CAKD1Yr3YrspL=4ZXCZVq7bPJuQOuBuFzLzc2Xyoa6uxnPshkOQ@mail.gmail.com>
Subject: Re: [PATCH net-next V9] net: Variable SLAAC: SLAAC with prefixes of
 arbitrary length in PIO
To: Erik Kline <ek.ietf@gmail.com>
Cc: Dmytro Shytyi <dmytro@shytyi.net>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	ek <ek@loon.com>, Jakub Kicinski <kuba@kernel.org>, yoshfuji <yoshfuji@linux-ipv6.org>, 
	liuhangbin <liuhangbin@gmail.com>, davem <davem@davemloft.net>, 
	netdev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, 
	Joel Scherpelz <jscherpelz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 1:48=E2=80=AFPM Erik Kline <ek.ietf@gmail.com> wrot=
e:
>
> Well, there are roughly 1,000,001 threads where this has been hashed
> out.  It's not possible to point to a single document, nor should it
> be necessary IMHO.

In addition to what Erik and other have said, I would point out that
it's extremely unlikely that this will be an IETF standard anytime in
the foreseeable future. The IETF is a consensus-based organization,
and if you look at the discussions that happened in Vancouver in the
v6ops and 6man working groups, there was very strong opposition to the
plan from many working group participants. These participants were all
very concerned that this change cannot achieve its desired goal, and
would be harmful to the Internet's architecture. Such a level of
opposition, and the fact that the opposition is founded in legitimate
technical concerns, pretty much guarantee that the documents proposing
these changes will not reach consensus and thus will not be published.

> > The fundamental problem "race to the bottom" was
> > brought up as a issue in the current topic,
> > therefore, could Erik or you provide a more detailed explanation

Here's what "race to the bottom" means in this context. Today, many
ISPs make a business decision to assign to their customers the minimum
amount of space that their devices will accept. For residential users,
that is a /64 per user. The reason I say it's a business decision is:
- There is no technical reason to assign a /64 instead of a shorter
prefix such as a /60 or a /56. There is plenty of IPv6 address space;
all home routers support shorter prefix sizes; all industry standards
and best practices, including IETF standards, recommend shorter than
/64.
- There are plenty of technical downsides of a single /64 - for
example, stub networks such as Thread won't be able to access the
Internet; if the customer plugs in another IPv6 router, then that
router and all the devices behind it become IPv4-only.

The fact that this is an explicit business decision, not a technical
one, means that the decision will not change if this proposal gets
adopted. These ISPs will continue to make the same decision - assign
the minimum size that is accepted. The current proposal limits
variable length SLAAC to /80, and once all devices support /80, then
the minimum will be /80. The situation will be the same as it is today
(mix of prefix sizes), but the minimum will be /80. At that point
another proposal could come around - just like the current one - that
shortens /80 to, say, /96. And so on. It's called "race to the bottom"
because each time the amount of space available to users becomes less,
until we hit the "bottom".

