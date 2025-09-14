Return-Path: <netdev+bounces-222870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB73B56B78
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1725C3B6F03
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936E2C3255;
	Sun, 14 Sep 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HZcB5rCv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C72627EC
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876842; cv=none; b=Jil0ZnLqDFnHEAA09O/4fmUMTzAV54HiCiRF8mXSzuuAEnD4oNWMAXnb0/m5BizvK9AeZ4PEZXQ3vFA6PwDQCARaLufvgkiHjr+pCwWE59HJRteVGrCspqYqsA2qaenEKWaDAvCLmjO/DXLl6U32hcWAnJS5DHj0age/cASs7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876842; c=relaxed/simple;
	bh=qVNnFZjOyOf3YN6UUyBUjn+orHIHbc7kUX0105yCPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBIkR7mMQXEKhZs6vTRkJ7Ogr7Cx5EvB/ls94HYaLUn9VOJOa7Ns5QtdM/AsHiDmu4bQjFmScci6LHPF9HAgr48qwaU0AdT33ZpNhasLn54pXIlCLwxyYzSuISEtCaaG3FdO3fWkDwHRQRR3a4BcMICEnYfun2pnMXxrAasV8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HZcB5rCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDCC4CEF0
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 19:07:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HZcB5rCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757876840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk4wipGYr3zAWauw8DmlPkaXobCPXYPcLgoNl18fiuY=;
	b=HZcB5rCvWyWqAuc9DX74smiyB4UcwTLK6ChNqCOp0G6JJPH2zU4/TvBAM3Zs3Y4y9a+kLU
	nVGCDACJMuksEEK07x1xv6QvOfX1j9vJbK1hj6sgA3dB2vt4wQGeK85t2XXL38RyEVgPHz
	hNs9/teetP5kXGeg+8YEZrf7vCOfKjY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b4c61167 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Sun, 14 Sep 2025 19:07:20 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccea8f43cso2956554fac.1
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 12:07:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwY6useNUuC9rYLyW9kFcqFJQSGy6ffSQiLVo1W3SfiyAwQXrSz
	ELBQQ9Oa8WWG6/q+TPX1ZGYnbnQjnCHJTEmxM5UXfXv7ebX+w7x0/7iYvyqSkUV8hI8fNUefEeE
	l8LOViYsgdVMlQskGhIunWVDf+7cB3Ug=
X-Google-Smtp-Source: AGHT+IHy9b8DjtXTINxT+4iHf7k/nKGjekgcI+MIqWLVtwXI7+4jzAjWQLdY9+QW8Ao/BxQNgu3PS8MLWfWqxE+kVwM=
X-Received: by 2002:a05:6870:505:b0:320:54e:3e79 with SMTP id
 586e51a60fabf-32cc7a0eb42mr8190525fac.19.1757876838802; Sun, 14 Sep 2025
 12:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910013644.4153708-1-Jason@zx2c4.com> <20250910192048.75941267@kernel.org>
In-Reply-To: <20250910192048.75941267@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 14 Sep 2025 21:07:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9q8xT4Ou2Ln_BqSYgWEU7bwqiYyt3MRxtxbn=r6HyG9Tg@mail.gmail.com>
X-Gm-Features: AS18NWAO4xdVZ1vj_IHrOOErmEemF9waKm_sycwokt5Ygr6E_t-iA6sdUrv5Hhk
Message-ID: <CAHmME9q8xT4Ou2Ln_BqSYgWEU7bwqiYyt3MRxtxbn=r6HyG9Tg@mail.gmail.com>
Subject: Re: [PATCH net 0/4] wireguard fixes for 6.17-rc6
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 10 Sep 2025 03:36:40 +0200 Jason A. Donenfeld wrote:
> > 1) A general simplification to the way wireguard chooses the next
> >    available cpu, by making use of cpumask_nth(), and covering an edge
> >    case.
> >
> > 2) A cleanup to the selftests kconfig.
> >
> > 3) A fix to the selftests kconfig so that it actually runs again.
>
> These don't really seem 6.17-worthy TBH.
> Do you care deeply or can we push these to -next?

I was mainly concerned about (3), so that the tests would run again,
but I guess it's not a huge deal, and I see you already applied these
to -next, so that's fine.

Jason

