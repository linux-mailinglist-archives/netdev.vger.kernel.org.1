Return-Path: <netdev+bounces-69802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1D84CA63
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7022905A8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0FD59B5B;
	Wed,  7 Feb 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFDocB4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E159B6E
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307541; cv=none; b=l+HebF7V5MJhyuaCbp1iy4XmzRpg0sftr2Coka/1kvGzPLweuA3+0jfXF0Zhm28FApME4d1s4HV+hAqirMbHEJU8LBl17o2igUQLc/vzO25X9rEjdLpARP8hs8DjRBRDz7/YADtbMr/5p9d+CdEIuYPwLRJlfeSdrcRGS4PHgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307541; c=relaxed/simple;
	bh=PD6uPuWyMD2oiQ1Ys4yeDhhtNABNk5Bv2OQGDMiidzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/ymaWgkryUd+hfZ0OG2+qm7s2K8nVT11Mhbi3bRFn/+G/ittnBz2afd5Q1dIiOv93mMhxpWjCxLolV3pSKjQpLWBcIYNn4+esTJbrYqITDeVaxxCIUUbvG3HwtTPVbAG19l0KPVe14kHkXAATTpVaAsFQQSKLKpNWv9ZrgasNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFDocB4u; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso377980a91.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 04:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707307539; x=1707912339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSE2XmBMEltANkF9P4I3aPhVXTVM0rcH+dYTDjdh++Q=;
        b=LFDocB4ubTORHA5CRzTSRApeVgm7a+bznfzZ2h7qYFV1/sjoG6+ULC8ExybFHUIKpD
         r7FlUo3B143CNj5S4EcWkyskgJZ6IM9o47Mv4jFrIH4s8dLBFqWhpLQovx03rtfqS1v4
         zGC527jkMCl5xbB0X/4jp6sgTUsAtsUgjZ5LfRkd9VzYrI0DtnRe1/ClxtA2q5Qb4/6p
         EbqawmRnT1Qc9r8tLXj3JpKC9a8LkdeVeL75dlwtdo81hnnz1XZSV+N5/wZ4rBlfLWBX
         2dlzdPGjrJ/IyHxFu+EDAFE9TK4YIp10KUD004eb/rrtTMRq9RtgiaYb6ZPZmTAuT2sn
         7TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307539; x=1707912339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSE2XmBMEltANkF9P4I3aPhVXTVM0rcH+dYTDjdh++Q=;
        b=NyviX4Ce1CjP8zxEi7UFRLhJCxEX6LSFQtvLNs4gc7Vwtvd/YC5AmIiRA0R6GDQSi7
         fdzkF2v3qyVToawTiyvCt1V4k9AiTsE0X5RU1+DhoPzutTRwv8lyffkXtgso+52lLJIz
         B87PJ67f56DW/j320Xfaj8f82Te3TTFyUUrvETQFaryLIVqHwMb0UvkEtN1jSGxX7f00
         NlQEq5/vjN1Zj2xSrJeTZJ9kcn1NOP8Qt51HyPiS34fa4NxbhAeB1hiiFKn0/d0XR5Ir
         +V8FYEILbROZx/+J9GBE2QhFsl2LPAYhUSj2+tDL6JzvRXZ517anqs8ILA9ks/EEYyuL
         Prag==
X-Gm-Message-State: AOJu0YzgseWG9IuGT/m1cMJPngXILxLT1vn9kOo5nt9qdP2y4EmCB0Lp
	RdwnSV70zbrLbOL61n5atZBeXOcSMM58su1LFGz7bUo8siUA6D2IFsrAj78xVGN4+Y4rN+uEI11
	p5bGM96vVwXzYLGj6yoOMAEbJOPAtVpyh
X-Google-Smtp-Source: AGHT+IGTgw0yWuFN9zUPvBl9pNX6+xU7nYAe4RzYAVoL9RdZyVoAHak1niaNVSdbVF2ZUQ8/xVpwDgHoMS1dpJvjD8g=
X-Received: by 2002:a17:90b:480b:b0:296:6a36:a615 with SMTP id
 kn11-20020a17090b480b00b002966a36a615mr2257342pjb.34.1707307539225; Wed, 07
 Feb 2024 04:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
In-Reply-To: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 7 Feb 2024 07:05:27 -0500
Message-ID: <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
Subject: Re: [Bloat] Trying to *really* understand Linux pacing
To: Michael Welzl <michawe@ifi.uio.no>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: bloat@lists.bufferbloat.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Michael:

Thank you for digging deeply into packet pacing, TSQ, etc. I think
there are some interesting new possibilities in probing (especially
during slow start) that could make the core idea even more effective
than it is. I also tend to think that attempting it in various cloudy
environments and virtualization schemes, and with certain drivers, the
side effects are not as well understood as I would like. For example,
AWS's nitro lacks BQL as does virtio-net.

I think the netdev community, now cc'd, would be interested in your
document and explorations so far, below. I hope for more
enlightenment.

On Wed, Feb 7, 2024 at 6:57=E2=80=AFAM Michael Welzl via Bloat
<bloat@lists.bufferbloat.net> wrote:
>
> Dear de-bloaters of buffers,
> Esteemed experts of low delay and pacing!
>
> I have no longer been satisfied with high-level descriptions of how pacin=
g works in Linux, and how it interacts with TSQ (I=E2=80=99ve seen some, in=
 various papers, over the years) - but I wanted to REALLY understand it. So=
, I have dug through the code.
>
> I documented this experience here:
> https://docs.google.com/document/d/1-uXnPDcVBKmg5krkG5wYBgaA2yLSFK_kZa7xG=
DWc7XU/edit?usp=3Dsharing
> but it has some holes and may have mistakes.
>
> Actually, my main problem is that I don=E2=80=99t really know what goes o=
n when I configure a larger IW=E2=80=A6 things seem to get quite =E2=80=9Co=
ff=E2=80=9D there. Why? Anyone up for solving that riddle?  ;-)
> (see the tests I documented towards the end of the document)
>
> Generally, if someone who has their hands on files such as tcp_output.c a=
ll the time could take a look, and perhaps =E2=80=9Cfill=E2=80=9D my holes,=
 or improve anything that might be wrong, that would be fantastic!   I thin=
k that anyone should be allowed to comment and make suggestions in this doc=
.
>
> MANY thanks to whoever finds the time to take a look !
>
> Cheers,
> Michael
>
> _______________________________________________
> Bloat mailing list
> Bloat@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/bloat



--=20
40 years of net history, a couple songs:
https://www.youtube.com/watch?v=3DD9RGX6QFm5E
Dave T=C3=A4ht CSO, LibreQos

