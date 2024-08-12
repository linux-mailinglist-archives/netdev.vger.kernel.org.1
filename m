Return-Path: <netdev+bounces-117784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B694F518
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F7EB230A3
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6CB186E33;
	Mon, 12 Aug 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEPb902s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1865130E27
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480899; cv=none; b=TJdRfc3djr1WGOaPNfYKiC4kjz0tN3a49se5SczHknjKajX+FDaHvRoM81n+Xp4BDobaWgPwkGNTI5+TrdeP8P2Pyx4cxZJdY/oHW696sXfJhJUhwJ3YuXrY8w6jUyL7d0KM/ClZl/Cwy7qSK4du2cZXjGuCk6rpC6sZN3pvq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480899; c=relaxed/simple;
	bh=GfCoTam369bMeKqajWlIHtsFRwiEnCG3h+tl09nsoWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLNxw/6v7wLqqiJyMEOSufn3jdG8srhU3oQstFhUK8G7sP2qBMMQBcDq1KjA0T7KEgmj5nX9QZZnplR5GIbBpAjNsZ6jjlkL8bXAxJmzVolsJYijg1AwiDTdNgkdG3LfFBPa3vwdoMKDut/op+jaMwPMij2xmmZwSY+nymAXRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEPb902s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso255e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723480896; x=1724085696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k3lAZr+Wu+39SLExsOiyxUpyZusvB7h7v3XL+vR/cs=;
        b=dEPb902shdTz0qjcJmyKfuHTWSVLoRQMJ5QWSi7PUEWaPfd0E49FbuEUgNh+LOPiMa
         Ngdet3P2Ve6GQV7wMob31ay5ISj+JzR7uXXJ1/L5mv9KgdNECcIQ8G5TsY+HTEYrS01B
         TYiHI1yKw0WvaUQyauU+1JdR26REbbiNQkcdmFgEUGSyiZA6V4WtwnwkS7Cui38/PxPO
         7T2evaj6JtpKaznKXs+87X+0pP4Of9UwYYIAvg4IWonVeGRLepbdG8WYvkjwvCrnua2W
         k2R48P+Y8OhsV3HP33/tWm94InklsP0QSPSLcs9orEXdJQWHm8Fzk6aZWs5KS/+xqf8T
         CaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480896; x=1724085696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k3lAZr+Wu+39SLExsOiyxUpyZusvB7h7v3XL+vR/cs=;
        b=TkTqXq80ZIEaLGQ/28PqDf2z0fPH+RP1SWvbqEeraJI3pSO3o8UEdP/leqsMYC354+
         X2/AJigVPD6LsxLxYxx+nLkL28g9dzsZlifoFLuiH0nfN93KL9h0iJkNhN6lTEYl1E1v
         Gy+zaAR5pspq9pD2cOc1O6wb5/AxEMGD5t1cb3/ePhOAcZZl0VkA+uMJEzvFbH15A3JZ
         jD76iiWHHlc+7Bcr0Ht5COkRIJ3HF5GoCg5IavMoYHqdG7g5h6rVvrI931mM82Cy9Byz
         Zms8AWq9th00vZSdHD6eeqrYvGNpzgGUFNNhN6kXaLDXokzY/4APconIgBPnPpUPGj/2
         9k0A==
X-Forwarded-Encrypted: i=1; AJvYcCVvrIXgHWyrT4gSqmPRgW3dX0jMo+hLb0tZ/AwrGqH6YWUkkx7AH419ZB2zVcwlTWGQNIQgt68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbJIT03d4Atm614ZZWKJ07KcWTq7t+k9+cKe8da9aB2OeBwFa
	QXZfGnHMMRuMzXAM5G1VR0c1YhDfeR6lMuJfjnYrZC5QEIZpa8Vd/7PZ3fMa7wQsulWdraMnH/r
	Vh6Y8IIq8WonMYV+ADA2gtrebfbya6BLxT3KY
X-Google-Smtp-Source: AGHT+IFHHbnd1rUGJQLpuRW92dlLAOdQnAyAUwyYFrdCtBIvbaZ8mHCRqqGaYbgfqLgUmQ2BLw2A4tFP2lNa/YFJihM=
X-Received: by 2002:a05:600c:870a:b0:428:31c:5a4f with SMTP id
 5b1f17b1804b1-429c827ac44mr2986265e9.3.1723480513270; Mon, 12 Aug 2024
 09:35:13 -0700 (PDT)
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
 <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net> <1914270a012.d45a8060119038.8074454106507215168@shytyi.net>
In-Reply-To: <1914270a012.d45a8060119038.8074454106507215168@shytyi.net>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Mon, 12 Aug 2024 09:34:56 -0700
Message-ID: <CANP3RGdeFFjL0OY1H-v6wg-iejDjsvHwBGF-DS_mwG21-sNw4g@mail.gmail.com>
Subject: Re: [PATCH net-next V9] net: Variable SLAAC: SLAAC with prefixes of
 arbitrary length in PIO
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: ek <ek@loon.com>, ekietf <ek.ietf@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	yoshfuji <yoshfuji@linux-ipv6.org>, liuhangbin <liuhangbin@gmail.com>, 
	davem <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
	David Ahern <dsahern@gmail.com>, Joel Scherpelz <jscherpelz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 10:16=E2=80=AFAM Dmytro Shytyi <dmytro@shytyi.net> =
wrote:
>
> Hello Erik Kline,
>
>   You stated that, VSLAAC should not be accepted in large part because
>   it enables a race to the bottom problem for which there is no solution
>   in sight.
>
>   We would like to hear more on this subject:
>   1. Would you be kind to send us the explanation of
>   "race to the bottom problem" in IP context with examples.
>
>   2. Would you be kind to explain howt he possibility of configuration of
>   prefix lengths longer that 64, enables "race to the bottom problem"?

This has been discussed multiple times in IETF (and not only), I don't
think this is the right spot for this sort of discussion.

>
>   We look forward for your reply.

NAK: Maciej =C5=BBenczykowski <maze@google.com>
>
> Best regards,
> Dmytro SHYTYI, et Al.
>
>  >
>  >
>  >
>  > ---- On Mon, 12 Jul 2021 19:51:19 +0200 Erik Kline ek@google.com> wrot=
e ---
>  >
>  > VSLAAC is indeed quite contentious in the IETF, in large part because
>  > it enables a race to the bottom problem for which there is no solution
>  > in sight.
>  >
>  > I don't think this should be accepted.  It's not in the same category
>  > of some other Y/N/M things where there are issues of kernel size,
>  > absence of some underlying physical support or not, etc.
>  >
>  >
>  > On Mon, Jul 12, 2021 at 9:42 AM Dmytro Shytyi dmytro@shytyi.net> wrote=
:
>  > >
>  > > Hello Jakub, Maciej, Yoshfuji and others,
>  > >
>  > > After discussion with co-authors about this particular point "Intern=
et Draft/RFC" we think the following:
>  > > Indeed RFC status shows large agreement among IETF members. And that=
 is the best indicator of a maturity level.
>  > > And that is the best to implement the feature in a stable mainline k=
ernel.
>  > >
>  > > At this time VSLAAC is an individual proposal Internet Draft reflect=
ing the opinion of all authors.
>  > > It is not adopted by any IETF working group. At the same time we con=
sider submission to 3GPP.
>  > >
>  > > The features in the kernel have optionally "Y/N/M" and status "EXPER=
IMENTAL/STABLE".
>  > > One possibility could be VSLAAC as "N", "EXPERIMENTAL" on the linux-=
next branch.
>  > >
>  > > Could you consider this possibility more?
>  > >
>  > > If you doubt VSLAAC introducing non-64 bits IID lengths, then one mi=
ght wonder whether linux supports IIDs of _arbitrary length_,
>  > > as specified in the RFC 7217 with maturity level "Standards Track"?
>  > >
>  > > Best regards,
>  > > Dmytro Shytyi et al.
>  > >
>  > > ---- On Mon, 12 Jul 2021 15:39:27 +0200 Dmytro Shytyi dmytro@shytyi.=
net> wrote ----
>  > >
>  > >  > Hello Maciej,
>  > >  >
>  > >  >
>  > >  > ---- On Sat, 19 Dec 2020 03:40:50 +0100 Maciej =C5=BBenczykowski =
maze@google.com> wrote ----
>  > >  >
>  > >  >  > On Fri, Dec 18, 2020 at 6:03 PM Jakub Kicinski kuba@kernel.org=
> wrote:
>  > >  >  > >
>  > >  >  > > It'd be great if someone more familiar with our IPv6 code co=
uld take a
>  > >  >  > > look. Adding some folks to the CC.
>  > >  >  > >
>  > >  >  > > On Wed, 16 Dec 2020 23:01:29 +0100 Dmytro Shytyi wrote:
>  > >  >  > > > Variable SLAAC [Can be activated via sysctl]:
>  > >  >  > > > SLAAC with prefixes of arbitrary length in PIO (randomly
>  > >  >  > > > generated hostID or stable privacy + privacy extensions).
>  > >  >  > > > The main problem is that SLAAC RA or PD allocates a /64 by=
 the Wireless
>  > >  >  > > > carrier 4G, 5G to a mobile hotspot, however segmentation o=
f the /64 via
>  > >  >  > > > SLAAC is required so that downstream interfaces can be fur=
ther subnetted.
>  > >  >  > > > Example: uCPE device (4G + WI-FI enabled) receives /64 via=
 Wireless, and
>  > >  >  > > > assigns /72 to VNF-Firewall, /72 to WIFI, /72 to Load-Bala=
ncer
>  > >  >  > > > and /72 to wired connected devices.
>  > >  >  > > > IETF document that defines problem statement:
>  > >  >  > > > draft-mishra-v6ops-variable-slaac-problem-stmt
>  > >  >  > > > IETF document that specifies variable slaac:
>  > >  >  > > > draft-mishra-6man-variable-slaac
>  > >  >  > > >
>  > >  >  > > > Signed-off-by: Dmytro Shytyi dmytro@shytyi.net>
>  > >  >  > >
>  > >  >
>  > >  >  > IMHO acceptance of this should *definitely* wait for the RFC t=
o be
>  > >  >  > accepted/published/standardized (whatever is the right term).
>  > >  >
>  > >  > [Dmytro]:
>  > >  > There is an implementation of Variable SLAAC in the OpenBSD Opera=
ting System.
>  > >  >
>  > >  >  > I'm not at all convinced that will happen - this still seems l=
ike a
>  > >  >  > very fresh *draft* of an rfc,
>  > >  >  > and I'm *sure* it will be argued about.
>  > >  >
>  > >  >  [Dmytro]
>  > >  > By default, VSLAAC is disabled, so there are _*no*_ impact on net=
work behavior by default.
>  > >  >
>  > >  >  > This sort of functionality will not be particularly useful wit=
hout
>  > >  >  > widespread industry
>  > >  >
>  > >  > [Dmytro]:
>  > >  > There are use-cases that can profit from radvd-like software and =
VSLAAC directly.
>  > >  >
>  > >  >  > adoption across *all* major operating systems (Windows, Mac/iO=
S,
>  > >  >  > Linux/Android, FreeBSD, etc.)
>  > >  >
>  > >  > [Dmytro]:
>  > >  > It should be considered to provide users an _*opportunity*_ to ge=
t the required feature.
>  > >  > Solution (as an option) present in linux is better, than _no solu=
tion_ in linux.
>  > >  >
>  > >  >  > An implementation that is incompatible with the published RFC =
will
>  > >  >  > hurt us more then help us.
>  > >  >
>  > >  >  [Dmytro]:
>  > >  > Compatible implementation follows the recent version of document:=
 https://datatracker.ietf.org/doc/draft-mishra-6man-variable-slaac/ The sys=
ctl usage described in the document is used in the implementation to activa=
te/deactivate VSLAAC. By default it is disabled, so there is _*no*_ impact =
on network behavior by default.
>  > >  >
>  > >  >  > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
>  > >  >  >
>  > >  >
>  > >  > Take care,
>  > >  > Dmytro.
>  > >  >
>  > >
>  >
>  >
>  >
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

