Return-Path: <netdev+bounces-166615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404ADA3698C
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4553A799C
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D118B03;
	Sat, 15 Feb 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNkWPXYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463E4430
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578067; cv=none; b=Wn7S4dMGUqPe0jElC2O4qQpysjY6K5M/R5MnAfg9ZGFdPtn3cn3lyHlhFaV8f88xro5KmwhvNGjwi5pLYJvfxaNxokyVA3kJF9UVwYfGVT1va7GNQsMQAkxPeBaP3oZioiTXkMP7+sDVKpA/NWRvKQlHMzHaGAgSFfE7rvWLRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578067; c=relaxed/simple;
	bh=UhL6i+N7peb9ywNx3OnTkHbbjamWQQ3AHfW8EL/M6dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o67wD/LLNe3PkXXlhqNj6fI8VbBinLlD0RVs8DhkHoslR1A1VRSne5FlHZy56XmXUkqK9KRYKuYf1CYOUqFdo3mG+aM5y2L9a0Oyf0y6z59A9bJmMiTPWIGbmzxilkuxad2HZwLzU6/vNDn2KjOzZVW3ZXvDDBlRtS/Vq3hl6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wNkWPXYL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-308f141518cso28044391fa.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739578064; x=1740182864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgHLYwinBR34eauCt8OOE9hxiSu48heRbyG92F9P4aI=;
        b=wNkWPXYL6UTfu1s7qIlgtTK5aTFIdk04CGrsMePQ7uh02O2azn56k0TTnSDmX8brQ8
         jX5Zs++/YUvIo4JyXba1XyfyX74rG5yzuz8gu5sV4SyvF284RG4bvAriDoqEoNAu4XpE
         BHnitC5oXXqKMnWKFmx99qMKl2fkvmAtWtgSJsRhiTfqxZzUpHl9sy8Z9K1qUyLFDSJx
         1JW7NKDwo4rAAsy8LlhmkgPEzAn18wgPdsctpt2TFd65ka65B5hezg3GB9wGBGsZHEeI
         Lm+bZpauJfvcBtXneLc9bkX7qLQtrK2Ys9v67q7Piv8Yc3/MosZNFvO9VIoN1dQJPNPc
         2Mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578064; x=1740182864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgHLYwinBR34eauCt8OOE9hxiSu48heRbyG92F9P4aI=;
        b=oPG+qZW5kZFjNzI0j3+cHb3oxVqYpAWxlQ1RPav5dSvSqY788+eR1ObxGsv12lUV6k
         JRuf6V2sey0aFGr+Azc9n4er3PR3D5wzhD8DfNYuEs5XifJ2RwswdsJ1AJhTVBMkUoIU
         E7maVmv4a5Rde9ITN4wqCnWXQywVQIBnmnpQhnVS4xijzLPj4Q0wcaO8wjLV5UNPReqm
         msh8FBiIruuG/soOQoGddLF2n3mwGAXhtVopMRderQnX+Vo67duiRU8y0KF3dWuc6RhP
         NtcMyQ6u8/kg9xWUeWdRwRahF78AadLmlMUhk7CNku1gYUmMziltLIN9K6v5xzsngxIx
         g7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY7sjrR55j8lhnBT5TXsWXPshBrqItFtpC8o9ulvwNojzvMPCC9Kn/ntyWoQPbH53DzVZOMGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIy9hDRgIJPPqBAv6DsRoozOK2NWTV7I/7+CWHjSXIY+dfBnX
	+di3SRn8oS8YEpVGs9U4EqJXeRqcsBIfqy+Na3ngjU/j5U02TeGYYS1BJjrv7WB++vKDPHIF51+
	OLNtd0TPChIHF0nI5pskY4BFPG0gDCe/x5oO1TQ==
X-Gm-Gg: ASbGncut+z62DO/Qp38LRbi98L6AyXvbpIImj4wC4Ru9Ei4iP2GpFhJZEdguSktI1sT
	A0JXaLLaUBxlCvQxKwZ9HD3w52LRDscb5jmMcyMsJGH3F4vsSua0ufX6GCWJSdhNemAIMtIl+
X-Google-Smtp-Source: AGHT+IEg8iNlbN2R/OltdltShZHLG6aQ7xgqNftIkyxGGnGBA1Nylq82wQSYGj8bL3v6mnHUkRfcjf+cZSSya8sPaR0=
X-Received: by 2002:a2e:9cd1:0:b0:308:eabd:2991 with SMTP id
 38308e7fff4ca-30927a3a12fmr4840731fa.1.1739578063687; Fri, 14 Feb 2025
 16:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org>
 <ca426cd1-124a-483e-9426-4a59ed7d7ba4@lunn.ch>
In-Reply-To: <ca426cd1-124a-483e-9426-4a59ed7d7ba4@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 15 Feb 2025 01:07:32 +0100
X-Gm-Features: AWEUYZl-K_KCqbPePoOBg1A-DQnYACcQ70qIXtMW6i-WboXFkW2ISJhEd_WN8bo
Message-ID: <CACRpkdYWXyw6qZBmkf_uN0WcXL3v2iRWbsHjqvmkZ1bWC8Bbmw@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: rtl8366rb: Fix compilation problem
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 3:06=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Feb 14, 2025 at 09:59:57AM +0100, Linus Walleij wrote:
> > When the kernel is compiled without LED framework support the
> > rtl8366rb fails to build like this:
> >
> > rtl8366rb.o: in function `rtl8366rb_setup_led':
> > rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
> >   undefined reference to `led_init_default_state_get'
> > rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
> >   undefined reference to `devm_led_classdev_register_ext'
> >
> > As this is constantly coming up in different randconfig builds,
> > bite the bullet and add some nasty ifdefs to rid this issue.
>
> At least for DSA drivers, it is more normal to put the LED code into a
> separate compilation unit and provide stubs for when it is not
> used. That avoids a lot of nasty #ifdefs. Could you do the same here?

I can pull out *some* code to a separate file like that, but
some LED-related registers are also accessed when the LED
framework is disabled, so it would lead to a bit of unnatural
split between the two files with some always-available
LED code staying in the main file.

But if that's cool, I can do it.

Yours,
Linus Walleij

