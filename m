Return-Path: <netdev+bounces-165392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D6FA31D7F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 05:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202367A3C04
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC341E5707;
	Wed, 12 Feb 2025 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOZTHdkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7B27183B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335147; cv=none; b=kn4qh+OsyeR0ad3Q1qdoOq/ylrELk12L6h69wgQfo7zlH8FbbeE0b68bqregD56SS7SDe3GujDO3lEaYDeGtc6M4YyTfTWJw0waK05R8OfZuHmn3iMZg4ypAKoBXuFZFx6KZFeDSYlTNY/PUQpqX4JIj2W6xWcmTdKle/24JPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335147; c=relaxed/simple;
	bh=j1QzW7ga8E0hkg3bXAdQF9Xq6LBFRXiViv0nXjGrGOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/vbKlI49KsH0P6JKOx3ltq3LiOyerCii0HMvMG3EgbjiKOFl2UelDvdaKtW/Lq76O6m0rXvAMVMXWBxdLROHN6bDKiNnoZ2IYwlZAyQysZJx1nnY+LD94Y4djcwWwK8eSnDElfnjuzF/JwLH15T8daHCEOGq9c26Jv9Tv/zaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOZTHdkk; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d162ecb2beso8821545ab.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 20:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739335144; x=1739939944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1QzW7ga8E0hkg3bXAdQF9Xq6LBFRXiViv0nXjGrGOA=;
        b=aOZTHdkksiZLaftqB2MKZFtc5FhU5/E9Lhw01ZbXx3IUpoxp6BxDc4VElc2f+uvxF6
         5KH9XAPh6pMzMNyjBBVsMmmgpCfO2ChIulRqOt2EzPXfARnxzRbrI64oejtjcq9syIq6
         f5jDnbORZqSSBNmxAgypjLJiABrW+sxG3kh+4ZK1g9qnO8OSV/fJbCwswSN1xUPJ4TAE
         9nHE3sJqc6SV2jGY287TosdxliUE8pHVBXZ1ZpZlK5PUvf07dLSeQRMjZ3NV6hwYQlJe
         I+/FOwVdgffe8g91Q5sOC9iViEsoZWABBdJ3o+10xv5Y78LqUjKI2q+VyhI8wPceR2zR
         8NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739335144; x=1739939944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1QzW7ga8E0hkg3bXAdQF9Xq6LBFRXiViv0nXjGrGOA=;
        b=vUi9wr5xZJXWRWVRnjQ5qJINbrahBdJd/dPUkA6D9vZdZ9tQeB7gpPJfmrroJ6c7jX
         UX5JjvUb0tBLOZEM6inGHR0sJTLs2UPjzQI59CuavgvQlXModtCt64urH7Zzj+NonOOc
         RlcGrpVGHIcI1Yvhg7HynbHJWcN8vCR7uqPf8OHas3cu8img1xLsFzQGd9OpREyn1DWo
         PWPM1rem59hW05+jtz2AaHk6QCjsl6l6K3r8DTRQs5qW1NE10A8H9zdtJ3/t7Mkvc2Zw
         5HHlb3J6tlB09e+knROWZB2fA23Un8YXF6UJFYyEc+QGkmNsol15hI5zpoAWZ3hRrCMW
         TLDA==
X-Forwarded-Encrypted: i=1; AJvYcCWfdlJ8GJDAZzWoBEBgzUNrjoHKg2+TRmEdCVhW9SHe61WUfATKuIM556S7dlxt2/Rw3aCkTx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNhPI0bR4JdAhR2pjohwe5mvPaGR8Qhv6iOEuvT2KVHPSkhag
	z030c46bL7uU63sC4UMYYm1kAIJTsq/fExP6PFIK7upcg3qeDFRL7bd+K6nl989KnQ/H5+z3q8t
	CXJv0bdA4EF7YmMP6wvQ5VgmWjfU=
X-Gm-Gg: ASbGncsleq1Mrgg0+tgpvynpEkC1H8OecUJuavQZCqTY8vrt415LOyLXm+DcUw/K79E
	HY20F/lFKz7+p/VLuYNlxyARzNpEA7xz+7CGRCgnA7l9jJbTKoIhaORdamaAYYvv+Sqgk9tGV
X-Google-Smtp-Source: AGHT+IGge03btSeyyYm6hyNU6SCjOrx1HX8tl1bYW14ncL+TRsUHJOLXRB9VLJPwCdIEgaZX5lkDYyJePQyUgcso6aE=
X-Received: by 2002:a05:6e02:338a:b0:3cf:ae67:4115 with SMTP id
 e9e14a558f8ab-3d17be21c71mr18347965ab.8.1739335144630; Tue, 11 Feb 2025
 20:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
 <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
 <20250211184619.7d69c99d@kernel.org> <CAL+tcoA3uqfu2=va_Giub7jxLzDLCnvYhB51Q2UQ2ECcE5R86w@mail.gmail.com>
 <20250211194326.63ac6be7@kernel.org>
In-Reply-To: <20250211194326.63ac6be7@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 12 Feb 2025 12:38:28 +0800
X-Gm-Features: AWEUYZl0_l8z-M8OIdpbXje2xvb0UpSW6mjTG6PIgMB8Lg_OmfFOmEPPckttte0
Message-ID: <CAL+tcoATHuHxpZ+4ofEkg7cba=OZxnHJSbqNHxMC5s+ZMQNR9A@mail.gmail.com>
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 12 Feb 2025 11:20:16 +0800 Jason Xing wrote:
> > On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Tue, 11 Feb 2025 18:37:22 -0800 Mina Almasry wrote:
> > > > Isn't it the condition in page_pool_release_retry() that you want. =
to
> > > > modify? That is the one that handles whether the worker keeps spinn=
ing
> > > > no?
> > >
> > > +1
> > >
> > > A code comment may be useful BTW.
> >
> > I will add it in the next version. Yes, my intention is to avoid
> > initializing the delayed work since we don't expect the worker in
> > page_pool_release_retry() to try over and over again.
>
> Initializing a work isn't much cost, is it?

Not that much, but it's pointless to start a kworker under this
circumstance, right? And it will flood the dmesg.

>
> Just to state the obvious the current patch will not catch the
> situation when there is traffic outstanding (inflight is positive)
> at the time of detach from the driver. But then the inflight goes
> negative before the work / time kicks in.

Right, only mitigating the side effect. I will add this statement as
well while keeping the code itself as-is.

Thanks,
Jason

