Return-Path: <netdev+bounces-128236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15738978AB3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB69D28A37E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEA155A5D;
	Fri, 13 Sep 2024 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wd2UICex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1014A084
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263542; cv=none; b=uNIXdSuv+CSV/sGBd3WMPi6Fi+rbPpsQSxlj++zTLmnM3p3R3dVSAl4dta/sKXAFbWA43vty1b2vJJ+GettzenypObEu/VQnPHMadTAddKIMcgP+e+gQIHj0rwA0SNn+mQuUXvgipZPL5PLApU84jJfevp2buikL83XFwl+ZspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263542; c=relaxed/simple;
	bh=t2CukQDmtmUqNG8HsheqIRsVphLV3VsQnCZdtsWYqvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSnuUjF6VeGWLnpQRjkhpFDNLeLY1axTTr4RA9EUTJMX13Fh7x7+AO7ccGpFLUuZ37PL1zlmHlB1s5ccKr/fGNsnGaXSpzKA8HX68Hk6IIV2zL7FMQIyrsZNZJ0r2vpXQ1CoNhh/2lT9V/5rFwO+jo6m+KiuuyeAeiWlG1yNvv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wd2UICex; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4582b71df40so25481cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726263539; x=1726868339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxOaF8AxUHaggzGBR0vXSvLLKExg7G9i5r3GTwRaXcM=;
        b=wd2UICexA5iHaZRBeG7t6s7GiGJZWSOulfSwEO9fyangJdAkG4eVHdpC/Hn48Jtgyf
         De5j/leTydJoc+6t2QD0C71s2elSLkjqLAcBIazKT/9+x2JZBjRB2OBCU+9uh3KQH+HS
         ch+NfzpMZ1poDWXmMhlxGdGEVKhDiVGzigsSL+SaYrjT/mE6lkqH8Wzr9DNaDLA0ZGdL
         ZWSns+qqv01xQefOeTebQRm8hN/5T1LOOmvWyRHr3/cYS54URCZX1igFqDRd3t0iVQkn
         fcd3rHNWkUPq3oaNXZqbcIpF9ds/QSNRwuvYPYjBgiFGHJFOJVRa42CMvZ/VDj+e96sS
         NGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263539; x=1726868339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxOaF8AxUHaggzGBR0vXSvLLKExg7G9i5r3GTwRaXcM=;
        b=XRLdWbwCBwgjSCDTZvDgtI4kvIHtQ0AH0PX4Gon6SBNVlVLRnHfmLj04cFc1XVXd9A
         L9e/N3PPH587BJhcrhIPc/XTqqKQIEO7RUSpVK5iL+HNDE5F2CzKPAbvRADVfny6QSIz
         PLT15xV/niGrxd6koWMyft65iSL6sqPCd+L87sGUEc4hibIuNeC8Z3iy+/fvf7yAXmp8
         Shzlh5jpwfCuCK8LazMvtQskb8NbU7m9C5+IwtrZyDIydbMj5Lajg39Gk8+YDdZuMd/k
         ujFtnNEJaVQfIZyWk6kz0uYwec2tEaexBy+L2NK9eT+ixzlTaL4I0n07nOIKmScXXpIM
         177g==
X-Gm-Message-State: AOJu0YwxRUzyOo12UTup1AARnit6+oFgd01hBz44J7sJCBIDysSpS+rc
	qWKC1zkh0wfiGBJdeBNR4Zo5xq4zd7/u30+Lu/Hx08gb8CKROsaTSsIW2AM7M7MZiQTYZtzMC51
	HPV/qDAjpgKbXPpVFjLyfXXIHKTEElk5av56CPLov4vBkiyzV9iq8
X-Google-Smtp-Source: AGHT+IE7wQ6d82h+20+gfYgwUOrNdS6QR9EOku3ZBk+A8q3enqbGgESkjkfIrzysdu6Edkr34sHnqy06TDcBVoKfdsU=
X-Received: by 2002:ac8:7f41:0:b0:456:7501:7c4d with SMTP id
 d75a77b69052e-458644fcbebmr8520731cf.9.1726263538792; Fri, 13 Sep 2024
 14:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913213351.3537411-1-almasrymina@google.com>
In-Reply-To: <20240913213351.3537411-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 14:38:45 -0700
Message-ID: <CAHS8izMfFPkXU5Wx7i7af2c2=nVzZ_GJnoj0YyLugKDr5uAyjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: fix build on powerpc with GCC 14
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 2:33=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Building net-next with powerpc with GCC 14 compiler results in this
> build error:
>
> /home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
> /home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is
> not a multiple of 4)
> make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229:
> net/core/page_pool.o] Error 1
>
> Root caused in this thread:
> https://lore.kernel.org/netdev/913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-so=
prasteria.com/
>
> We try to access offset 40 in the pointer returned by this function:
>
> static inline unsigned long _compound_head(const struct page *page)
> {
>         unsigned long head =3D READ_ONCE(page->compound_head);
>
>         if (unlikely(head & 1))
>                 return head - 1;
>         return (unsigned long)page_fixed_fake_head(page);
> }
>
> The GCC 14 (but not 11) compiler optimizes this by doing:
>
> ld page + 39
>
> Rather than:
>
> ld (page - 1) + 40
>
> And causing an unaligned load. Get around this by issuing a READ_ONCE as
> we convert the page to netmem.  That disables the compiler optimizing the
> load in this way.
>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Networking <netdev@vger.kernel.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
> Cc: Matthew Wilcox <willy@infradead.org>
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Gah, right after I hit send I realized I missed the 24hr rule.
Although I'm unsure about the urgency of build fixes. Sorry about
that.

--=20
Thanks,
Mina

