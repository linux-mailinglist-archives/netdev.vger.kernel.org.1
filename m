Return-Path: <netdev+bounces-201371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2DAE935B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A817067C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2A78F3E;
	Thu, 26 Jun 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Db3ygVk1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17D2AD13
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750897391; cv=none; b=QLhFhH51ih8HU7hSnBD5N+6vNpfS2itPBPjxx+OGKXXpY4u09ncM1az4ZhuwUW4YP5u2p+9+R/Xr5W4eX7iZlIzAcmWJYEBDao43HMyhpSu0lHBnKtLcdznp3Qo/t5sqE0ZxGsNBessBHXqZGr+QTXpsyrLbRnx38dZ+hZ8owrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750897391; c=relaxed/simple;
	bh=NCsrN+HdfSuoPmwKEfBglZgoIH5ku20D9mJrTlOeaBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjKr2F+iOhDvxdqZy4nTs09Wa9FzfKgMuipn0glxSWJi6vGxcgsI9475cWLVQ3/vdUTSrgOz//8o5CzGAZeMOeKv4dU/T1SFMq6GZC4xAOpbuGuJVIv7S+kArkkn97V1C0kT4lXeM0vTkJISGgYv+1wdivM6P8uvahqb2fkARYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Db3ygVk1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237f18108d2so77365ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750897389; x=1751502189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCsrN+HdfSuoPmwKEfBglZgoIH5ku20D9mJrTlOeaBw=;
        b=Db3ygVk1gk7eKgKMUeAaoq1jJ3BycUz6wluw/v6mT1hRN6eymlCSX47oRU/NQln3DD
         E6hhu4rQqbeIgdNNDffBbWeWGmSUWLvJWx+suYSJPMavktWpash62i9eofKj7mUILR0F
         zmRaLh2V3z2bgEL5LHxnoEQyCpOyPXi9yblQHj+jpztF18tbhLE/tf22Y3cHJbkHL9mM
         w5P5XFKXaP/0mdShlzRcUPmIHBYXtdmkgAFl2cPgRLmhvrwtKomSwQRV+CpJBTiR0ce/
         EohakOJBjCaDQcI0ZWDdkZ4oUZel/8L3X7JbgNq/Gl0HeIm4EvsSIYTL7cpU/Fqg6w8F
         owCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750897389; x=1751502189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCsrN+HdfSuoPmwKEfBglZgoIH5ku20D9mJrTlOeaBw=;
        b=wvXqcbowbzsT6eWM+m7fe/S27k+k5G4rRwlhn/Mkj9i5EAyZ28ZCv+kkzH3k5BBNja
         W7N/Zwg/74f9KSJmZLecHpxR1bJlpy8EXGuilR3ECpwEFicAwBRNUoFBCeQ8qAh/ogrx
         YrJG+G+FwNNfR+ABsVWdm/fv6emirQw1hxpgYGUBu//uotoCRFSjhMc6vnqwYrsvw+7e
         1hdywOlryEkJrpgmWglOs1VRN3muA9aMel0Q5QYWVCJ+cqy7qaZl5tf7/DJsww5JYy0B
         DiQytHMmxUs+/upn0Hkqix3gpR3EhsYAJqCHTu3vfLqCgu6GEMNnuUvOU0bcVvoCBv/S
         d7fA==
X-Forwarded-Encrypted: i=1; AJvYcCWfFnu/HgQD9us6wdlpFLxS7ZBO90yE8e7mavnJ/stXKf3dHal1otNQ5e440AjidoMDNvamre8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIm3Aq4J9vWc62Q0xmbk59o5r+8XcuJljOYzcUK5GfqxPFgKNC
	3Yj35/DQzDczO/jvVtla2rhqzn/LFncIOB7JvrOvWO/0/H/642LRMJMorzIY1NwIul5On6fyjM5
	gTVCherGZ2ERiW1hxgTjhH3j+KnjY0BcLTFWa04Xg
X-Gm-Gg: ASbGncuJHMdlt2vkdEefznzMbnBwkMYVgHqFx7Y3W3+QzCKZn2nnncxpoVdjkMXUJtY
	1xWfh4OcySHYvXcdcvAQHFZ3KBGoM9v4X78wBkuT1kWHc0ARctRQcyCR2uSyWDqia2UslJs0zgy
	aeGHrwy359/4/Spy8jhBvHOK2idPIf/LJ2q6IvjCuyH2NNdq3hCkTlZt7gXHYuluU3aB4GHquT7
	Q==
X-Google-Smtp-Source: AGHT+IEwuIRJz2GnuYFakjvLvwNdDT0PhaAO+MJrfxFtHd/bqcmj1964+AMMsw9hZf+b6bYiVMNzPCB9JCe4G7It6W0=
X-Received: by 2002:a17:903:1b2d:b0:22c:3cda:df11 with SMTP id
 d9443c01a7336-239785df083mr1424685ad.10.1750897389164; Wed, 25 Jun 2025
 17:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619181519.3102426-1-almasrymina@google.com>
 <175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
 <CAHS8izMPWjmxLWJr+BSqd5jamsFHDOm71NkG7fmm-78SkLxQTg@mail.gmail.com> <20250625170305.40d8c27a@kernel.org>
In-Reply-To: <20250625170305.40d8c27a@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Jun 2025 17:22:56 -0700
X-Gm-Features: Ac12FXyiBMisv4tGfeRxSMIrkn6bU28R4i4OvLr3C7LRcHrlkuJntc45GbrMbFU
Message-ID: <CAHS8izO9=Q3W9zvq4Qtoi_NGTo6QShV7=rGOjxz3HiAB+6rZyw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	hawk@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, ilias.apalodimas@linaro.org, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 5:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 25 Jun 2025 16:45:49 -0700 Mina Almasry wrote:
> > Thank you for merging this. Kinda of a noob question: does this merge
> > mean that nipa will run this on new submitted patches already? Or do
> > I/someone need to do something to enable that? I've been clicking on
> > the contest for new patches like so:
> >
> > https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-2=
025-06-25--21-00
> >
> > But I don't see this benchmark being run anywhere. I looked for docs
> > that already cover this but I couldn't find any.
>
> Right now to add a new TARGET one needs to have SSH access to the
> systems that run the tests :( The process of adding a runner is not
> automated. But this will probably need even more work because it's
> a performance test. We'd need some way of tracking numerical values
> and detecting regressions?
>

I actually did what you suggested earlier, I have the test report the
perf numbers but succeed always.

What I'm hoping to do is:

1. Have nipa run the benchmark always (or at least on patches that
touch pp code, if that's possible), and always succeed.
2. The pp reviewers can always check the contest results to manually
see if there is a regression. That's still great because it saves us
the time of cherry-pick series and running the tests ourselves (or
asking submitters to do that).
3. If we notice that the results between runs are stable, then we can
change the test to actually fail/warn if it detects a regression (if
fast path is > # of instructions, fail).
4. If we notice that the results have too much noise, then we can
improve the now merged benchmark to somehow make it more consistent.

FWIW, when I run the benchmark, I get very repeatable results across
runs, especially when measuring the fast path, but nipa's mileage may
vary.

--=20
Thanks,
Mina

