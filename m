Return-Path: <netdev+bounces-192904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D6AC1905
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59AD7A3846
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B31C84D9;
	Fri, 23 May 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuCHeQQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032020371F
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747961933; cv=none; b=lIlaw3kG8vsK0NwSRO1AFg7pYMBr3mlOHggD11f71ZkgL00cZgxZD0Ox/dOV0uDNC6ffKYo7jDf8RsBDzgL3lEVerRdC4k9otEkN/6YwGNcwNRn/xvxL6oII9S4HrjRAxoc3QbSnk3v/omM/r1YAutzCeI4jNB/SFb5O7SQPlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747961933; c=relaxed/simple;
	bh=gm41587JAfBWkP93M4ImjZtccksPN/OUAl/ZazUkMTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuOv+9jWrhO0GPPKb0Gccul8R1AhwO65bPBjw4rjfjAg1vv1Sgu57aWPyWf/RjGTMNsG9XXEtxkkKbqkPPcKPLAjdWaovZbUvBU1C8v8vriXoD0U8L8Q3lzRw9dGiCeOCeFoQL7MKw0cQEWMXaP/53+DZEwiHtqSXk/JunOm2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuCHeQQz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-550eaf7144cso4e87.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747961927; x=1748566727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcDhPPSzg8HRKmCXh45FEKOEgaUQx/JA7GMC5v5W4po=;
        b=IuCHeQQzpPCeRbXixeiOIU4jCvKeLasoC7gY4UtpgiXz8KW9LPZ9WdU7BqD8LANfxh
         gY287yuMMCWpmO1ggHjUYreREZqJuInXiayeSREPDEoEJwO1mSHSt0WMihIitFLtx6me
         meGfCXwOMjEuN8oWYnM8KD5kMAzw+bwTLatzIoEKkxCHy0iOYCLWzkdBGkfAso/BVglZ
         BNb1bng0YjcfEnHgVMLB7yNgtABeLDf2ED+cWmBkSfvNJSmOy7l9whgv80mfQs8tY9Vw
         2pU9Hs+mHzb5NSns+T4vY/wuVxKm5ST++NXAn0PHCbPTAwWrA96DfEtSh2uvMGZuaGHO
         cX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747961927; x=1748566727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcDhPPSzg8HRKmCXh45FEKOEgaUQx/JA7GMC5v5W4po=;
        b=hSgFvhzKgyJr2p34g8Wpv2q2dROZia7UOqAircVDt7Yj/KUFSu2vhIsmBLjuh8xkBq
         VcdOR1bXmX5uIqtL8JA7a6stNtouB6RYmA3HRrxcDZFDYyboNuLx2lKcS/Smes6C2l78
         hiNLIMyKlCAhbr74TDRuRYGuhAaYo3+Thhq9iu86Guo+HxHEzyR27H8g0UzZHiMZJxXP
         pZGWhVchFJk+fDrMBaDr0euTaQ5+wvL+KfU1BLaYIGBolH9ErylNRQTqJCTkv2eFdZHV
         BkYsK4d0vsKRSSogwx+c1HLvkjZKtChp4r86B5Ke/BW4NNh0xpjE7l9QgyPM/kKIyJfG
         KCVw==
X-Forwarded-Encrypted: i=1; AJvYcCVnddUSpFYt5vH7FH1VchbVqWUwDrgmv9RWONn6NA64W4mi3xy5xCRO9I63Ba6uCp/F3ORZ0mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPk3dJdzxIO26DKFcIflByDWHNyZ5jYk327Kt3Cag7jncjETKe
	FJiKuhUwL/WiKbIKICxupWcNgIVSOTckN+mYiQT8Z+JcUZgqasmSnVo8Wef1n6VVf8EoZhvYvBy
	J8py4z1NkVf9utglY0b1H3uefahTQgKQ47RDaVxPu
X-Gm-Gg: ASbGnctsdAaZv8aeBqXPz6w/wz74AfzhBAwA/kEJolh1dgK54DcEayu9ixTTQgv2x4g
	lxHxwZoiXDW0Y430Mm+9oLByg5xV2MUjW9FZ7YlXb6/+VUCTgELvxXxtnPzUE0PQcoL6y92fjKY
	dwOVbgGPvbkigBkFuXKUH9im6Y4Jt8K1IX3vkb3AWy62DDdxBqCwI4UQNmccnvIIjI7ZUsZIA/
X-Google-Smtp-Source: AGHT+IFr5ZXM9ujKZGt8xf9qPilPgCd8MVEfGCRwDVYV8nwoK6xw3mPwO0lt31YbuQAP4gVwOh6qGIJQrxAiQLNGHus=
X-Received: by 2002:a19:2d0f:0:b0:542:4b92:526d with SMTP id
 2adb3069b0e04-55218553808mr804e87.1.1747961926374; Thu, 22 May 2025 17:58:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
 <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org> <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
In-Reply-To: <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 23 May 2025 09:58:08 +0900
X-Gm-Features: AX0GCFscXC9XMB5hiL2g5EpdL-FsW-OU9gYZe7SsmvLpbk2gBcssbqf-p5pjHDE
Message-ID: <CADXeF1Hmuc2NoA=Dg1n_3Yi-2kzGNZQdotb4HJpE-0X9K9Qf5Q@mail.gmail.com>
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: Luca Boccassi <bluca@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Backward compatibility is broken due to the exit(1) in the following change=
s.

```
+ if (lmask & IPMON_LMADDR) {
+ if ((!preferred_family || preferred_family =3D=3D AF_INET) &&
+     rtnl_add_nl_group(&rth, RTNLGRP_IPV4_MCADDR) < 0) {
+ fprintf(stderr,
+ "Failed to add ipv4 mcaddr group to list\n");
+ exit(1);
+ }
+ if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
+     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_MCADDR) < 0) {
+ fprintf(stderr,
+ "Failed to add ipv6 mcaddr group to list\n");
+ exit(1);
+ }
+ }
+
+ if (lmask & IPMON_LACADDR) {
+ if ((!preferred_family || preferred_family =3D=3D AF_INET6) &&
+     rtnl_add_nl_group(&rth, RTNLGRP_IPV6_ACADDR) < 0) {
+ fprintf(stderr,
+ "Failed to add ipv6 acaddr group to list\n");
+ exit(1);
+ }
+ }
+
```

My patches follow the existing code styles, so I also added exit(1).

Link: https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/tre=
e/ip/ipmonitor.c#n330

I thought iproute2 was intentionally not backward compatible, but it
sounds like that's not true.

I can submit a fix patch to remove the exit(1), which should fix the
backward compatibility issue.

Shall we proceed with this proposal?

Thanks,

Yuyang

On Fri, May 23, 2025 at 9:03=E2=80=AFAM Luca Boccassi <bluca@debian.org> wr=
ote:
>
> On Fri, 23 May 2025 at 01:00, David Ahern <dsahern@kernel.org> wrote:
> >
> > On 5/22/25 4:55 PM, Luca Boccassi wrote:
> > > On Thu, 22 May 2025 at 20:41, Adel Belhouane <bugs.a.b@free.fr> wrote=
:
> > >>
> > >> Package: iproute2
> > >> Version: 6.14.0-3
> > >> Severity: normal
> > >> X-Debbugs-Cc: bugs.a.b@free.fr
> > >>
> > >> Dear Maintainer,
> > >>
> > >> Having iproute2 >=3D 6.14 while running a linux kernel < 6.14
> > >> triggers this bug (tested using debian-13-nocloud-amd64-daily-202505=
20-2118.qcow2)
> > >>
> > >>     root@localhost:~# ip monitor
> > >>     Failed to add ipv4 mcaddr group to list
> > >>
> > >> More specifically this subcommand, which didn't exist in iproute2 6.=
13
> > >> is affected:
> > >>
> > >>     root@localhost:~# ip mon maddr
> > >>     Failed to add ipv4 mcaddr group to list
> > >>     root@localhost:~# ip -6 mon maddr
> > >>     Failed to add ipv6 mcaddr group to list
> > >>
> > >> causing the generic "ip monitor" command to fail.
> > >>
> > >> As trixie will use a 6.12.x kernel, trixie is affected.
> > >>
> > >> bookworm's iproute2/bookworm-backports is also affected since curren=
tly
> > >> bookworm's backport kernel is also 6.12.x
> > >>
> > >> Workarounds:
> > >> * upgrade the kernel to experimental's (currently) 6.14.6-1~exp1
> > >> * downgrade iproute2 to 6.13.0-1 (using snapshot.d.o)
> > >> * on bookworm downgrade (using snapshot.d.o)
> > >>   iproute2 backport to 6.13.0-1~bpo12+1
> > >>
> > >> Details I could gather:
> > >>
> > >> This appears to come from this iproute2 6.14's commit:
> > >>
> > >> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/=
?h=3Dv6.14.0&id=3D7240e0e40f8332dd9f11348700c0c96b8df4ca5b
> > >>
> > >> which appears to depend on new kernel 6.14 rtnetlink features as des=
cribed
> > >> in Kernelnewbies ( https://kernelnewbies.org/Linux_6.14#Networking )=
:
> > >>
> > >> Add ipv6 anycast join/leave notifications
> > >>
> > >> with this (kernel 6.14) commit:
> > >>
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D33d97a07b3ae6fa713919de4e1864ca04fff8f80
> > >
> > > Hi Stephen and David,
> > >
> > > It looks like there's a regression in iproute2 6.14, and 'ip monitor'
> > > no longer works with kernels < 6.14. Could you please have a look whe=
n
> > > you have a moment? Thanks!
> >
> > were not a lot of changes, so most likely the multiaddress or anycast
> > address changes from Yuyang Huang. Please take a look.
>
> The original reporter suggested it was this commit that introduced the
> regression:
>
> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?h=3D=
v6.14.0&id=3D7240e0e40f8332dd9f11348700c0c96b8df4ca5b

