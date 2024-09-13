Return-Path: <netdev+bounces-128172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79A9785B9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C271F25E09
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0BE537F8;
	Fri, 13 Sep 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lIKr8Ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C54A21
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244853; cv=none; b=KMvmH/mK9fTsvlf0oEDso2x7sWwxWExC8eb02TTpivUY22eAef6RT4fBlEQxjVJNztqQDZMhoqyPnhOJZO5N3pvFPKehoOchjwnz7vrjjRoIXWSj7nQNNWBPmzVCwBWlAmfkeppGScrnIqBCFA0+zoRbd+yijhJ9KNCGbackOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244853; c=relaxed/simple;
	bh=8h5Rfxoes1F/EQEOg2e1jm/KAtjsu5tZuD6b6E74r4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eia508Prn5WlbQkRxtJ/k0k7oAUokBgSkFmwqvmopC2qnsBpqAJ7zACgt0tofcJ9ft3FkUV9WH00v7quTSZinPL29V4yggz1Dy7/uOaqz9KCk6xhiEUc78v7A17waeC3uCRijxLEZQWU5QHgZ8QN/suHm8MOVB1dDixDipWuLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lIKr8Ay; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581cec6079so289221cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726244850; x=1726849650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kaogzt0x83O50oW2Cdc8KsfEPIv2RHrKFooPdPcHuF0=;
        b=1lIKr8AyxHNKFxB554AF19Kd7F/bHOqYVm/pVuG+G0WrUVcZuqqCzq9KxHJfXdWqJp
         cGNvgw8gg25neqbex5UV34ycxw1WLIcmE6GfKsnv0iABDTaZBAjHKGYHm91kfSq6Eh55
         YEzW2DX2WJFTqNPrAZ480SCCFDriNj/8NguAiPbhHB/UxKW5c5DLJoGjSJ49iePULnCZ
         rCvAVpz27l0IM/ee0+s18oZWcS4T/YHEztinmwZB88EVUQ0YlRsM2VeLhmUWaMx9LL1o
         R1mntdJCnidd2wxb5fhh292QM9LqPd/tbqce61hgmOflFDg0564WrCKQr0DryT1hzS72
         a5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244850; x=1726849650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kaogzt0x83O50oW2Cdc8KsfEPIv2RHrKFooPdPcHuF0=;
        b=KyO1T6nzkepW+eIAB5gwK5G36a3YXBef6mmFUngzC1fBSm0rTl1u/wfn7yQKF2P64l
         6zSKh73eRBpWkI/CIRqL9k9+PE2gehzmQa2fyU0dnqnlw2LL9jGk0sybe5ijOurZi91i
         4aVtw5cr3/z/14KI8l/PnyCQGTBIUx1vsbnj5TMzwyvgiZrEPAthcy769TMyLsEYExJA
         9+67U+M8eFYycDJcKW93ShgyILxU8fqpxxd41XpNNWYVnXU557BUuDlrVo2Rqpps2Mb2
         LeRDq8xgZrpe3qo4q6LQ46tB3gNXc7shYXlzs4CANWpyEXVnp6vRsqlpT4KkX4If5f7V
         OA2A==
X-Forwarded-Encrypted: i=1; AJvYcCXOPBsqmoyQrIsFgOYA+JAobet0hNqq59yDKmhPB1htQsPCxHpwJWRGt2Am6vHB5QJUD7bAJgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk40KGzY0GNoIWt34UtHeZJinINAgobZ0Jdis9/jIhLppdhRYM
	JuBQeSQaWLcFMpPaHStw8P6AYpWml9g7Dh/Qgu3QLmlGnOtE2NbF7ii4RKfsg7jXhMqga9lXzn0
	k9OsWpALu4rav9nFCuIJ8rXfr3p5Y9C0Zx8T7
X-Google-Smtp-Source: AGHT+IFLIVO3GAQiV32AIRq5tRq8/+Y6XmNS4xK792rwOjota6Ua04VI9PjqMQ/wHusA5aDseJUdCQZv6B0+BHgZ16k=
X-Received: by 2002:a05:622a:4cc:b0:456:796b:2fe5 with SMTP id
 d75a77b69052e-45864512051mr7158501cf.9.1726244849858; Fri, 13 Sep 2024
 09:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913125302.0a06b4c7@canb.auug.org.au> <20240912200543.2d5ff757@kernel.org>
 <20240913204138.7cdb762c@canb.auug.org.au> <20240913083426.30aff7f4@kernel.org>
 <20240913084938.71ade4d5@kernel.org> <913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com>
In-Reply-To: <913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 09:27:17 -0700
Message-ID: <CAHS8izPf29T51QB4u46NJRc=C77vVDbR1nXekJ5-ysJJg8fK8g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: christophe.leroy2@cs-soprasteria.com
Cc: Jakub Kicinski <kuba@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 9:13=E2=80=AFAM LEROY Christophe
<christophe.leroy2@cs-soprasteria.com> wrote:
>
>
>
> Le 13/09/2024 =C3=A0 17:49, Jakub Kicinski a =C3=A9crit :
> > On Fri, 13 Sep 2024 08:34:26 -0700 Jakub Kicinski wrote:
> >>> The second "asm" above (CONFIG_PPC_KERNEL_PREFIXED is not set).  I am
> >>> guessing by searching for "39" in net/core/page_pool.s
> >>>
> >>> This is maybe called from page_pool_unref_netmem()
> >>
> >> Thanks! The compiler version helped, I can repro with GCC 14.
> >>
> >> It's something special about compound page handling on powerpc64,
> >> AFAICT. I'm guessing that the assembler is mad that we're doing
> >> an unaligned read:
> >>
> >>     3300         ld 8,39(8)       # MEM[(const struct atomic64_t *)_29=
].counter, t
> >>
> >> which does indeed look unaligned to a naked eye. If I replace
> >> virt_to_head_page() with virt_to_page() on line 867 in net/core/page_p=
ool.c
> >> I get:
> >>
> >>     2982         ld 8,40(10)      # MEM[(const struct atomic64_t *)_94=
].counter, t
> >>
> >> and that's what we'd expect. It's reading pp_ref_count which is at
> >> offset 40 in struct net_iov. I'll try to take a closer look at
> >> the compound page handling, with powerpc assembly book in hand,
> >> but perhaps this rings a bell for someone?
> >
> > Oh, okay, I think I understand now. My lack of MM knowledge showing.
> > So if it's a compound head we do:
> >
> > static inline unsigned long _compound_head(const struct page *page)
> > {
> >          unsigned long head =3D READ_ONCE(page->compound_head);
> >
> >          if (unlikely(head & 1))
> >                  return head - 1;
> >          return (unsigned long)page_fixed_fake_head(page);
> > }
> >
> > Presumably page->compound_head stores the pointer to the head page.
> > I'm guessing the compiler is "smart" and decides "why should I do
> > ld (page - 1) + 40, when I can do ld page + 39 :|
> >
> > I think it's a compiler bug...
> >
>
> Would it work if you replace it with following ?
>
>         return head & ~1;
>

I was able to reproduce with the correct compiler version, and yes,
this fixes the build for me. Thanks!

Probably healthy to add UL, yes?

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..ea4005d2d1a9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -239,8 +239,8 @@ static inline unsigned long _compound_head(const
struct page *page)
 {
        unsigned long head =3D READ_ONCE(page->compound_head);

-       if (unlikely(head & 1))
-               return head - 1;
+       if (unlikely(head & 1UL))
+               return head & ~1UL;
        return (unsigned long)page_fixed_fake_head(page);
 }

Other than that I think this is a correct fix. Jakub, what to do here.
Do I send this fix to the mm tree or to net-next?

--=20
Thanks,
Mina

