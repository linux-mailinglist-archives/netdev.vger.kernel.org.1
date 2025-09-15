Return-Path: <netdev+bounces-223220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20582B5861E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 22:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC594169689
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037B29D27A;
	Mon, 15 Sep 2025 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtaR9NJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737129D26C
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968888; cv=none; b=BgPinzvJJCrcROqq3/qDa+eKJSxmbcdYs22+Pw7RrMCOeipvSnLGKwwNgNS0LDrRSxNMAJgMLDzsnIJ+wXVND/ewmfY4LcHTTLkt2GAwZX/6ucrQnWAhJrDFH2PeD9hDP/voTHAgp8eajEXBEDoRGCh1+c7yLRknKqtjB0bCCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968888; c=relaxed/simple;
	bh=OiYmP25yYp/dcX2iT5/y/TPt9rjEO4jN+GBBIbsdQPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYWa7jII1mmvEwsP4dpeum5P9+Bab+MmEZx3G2cek0t1FPxarkd60vkat1LqBbKafa39zuwfqOqs4wikLpzlnP3gj/A2trx6ydK3q9TKkQtS6NCX0dCgBlP2xUIFhhXkTVu1sGfdI48t2zVmDZrx2WymdflhLLRXYWumwl7F66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtaR9NJz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5702b63d72bso2007e87.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757968885; x=1758573685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMK7NJwaESJbnK3s8EHaT9c8KoXak+YYX74sQNHhiFI=;
        b=ZtaR9NJz0p9NEgYw6XozpXBnOnKLF2N1Dk0kpNdRXqlxWm+Ymf/XPimfASvae3k16v
         ynqB6n+bxFk7NLEwUh/U7Ci3EQ85cSjQKobQuPSsh4unp3LplXGTOYT4hZhbIFgtDwx5
         mz5LSIOo3B3sdbUQcONcLB3gFILChn4NfHSwAlMuG9/w9JjqVCWngrAvlbuzdZ9EvjUw
         88CAhIw7v82aN1H7fxv0ou6AagVfn1nY+OLE6ZajVx8vQRJ58Ix9AeYq3x+LQQVRTWdQ
         b3aCdEK8qPBp2garzPy3GrhFiUPm+76O7OobiaBj4xFSidYPIXESKLnCV3QGrn80fkNo
         gGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968885; x=1758573685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMK7NJwaESJbnK3s8EHaT9c8KoXak+YYX74sQNHhiFI=;
        b=bhQCXpTqxhUMh92459SpOSjwoPPw0plnIX4lsEs64BMQj1Z7afhLwgmAJz7DgtNfZz
         BTUjh2p9hMWLmDlP9O9ceqsp5s3upe/rzlBgtWpiC4Sq4XctuMHGqXbkm/bP2XiUOf6Z
         KI88OGeiLGyBuFUjaGYzcuYlheqPT2CkR0bsUAhl/rqyThd6V7tMFKcjA1aUhZT0oIml
         IYcA+uEMr75JpicWIM9keO7zr2y4GfvMCKbX65yBBIxvrCoTJ95wKR3h6S0C7Es0q3Xx
         8Z73rLaElxoA8Lb7KU8OIgbXXVMZeGMZTACtrPLx7UD3PHk4ywpoizircZUAPUdhr9ss
         135w==
X-Forwarded-Encrypted: i=1; AJvYcCWOkKeMPYBrfWCCly1ncyIZ8tG+Vi8rlPsJTRrbG7f/Y9X97KQ7U2K06OHD/AsZv+JP3CLxP8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VQCLSbAFCJwjkvem3Y3/4C8pQO6hfSLgsAeMUf62vaf0gVzx
	XGHPBAc2SPuivi0bKGukuJQrfwsEhDN2c4LJTnzqZ1N9xREraSdhWIwa7b4j+brRI1h4G52PW5L
	iC1oXQmuN0G0DYKC+19oml7I5rqfz9Y8PziTZbRZe
X-Gm-Gg: ASbGncstYbUUhC+CPDLZk41PMO4lQN2vTFwDp5CLW9inUA39Dn+OVRD4NwaeWAXsy24
	lCAiRdmkDgDP/c4YcCjroTG8GEXVvC6VHj8mZ67Y+iHBlDZYnI4XMYHvURUQC+h6aYP0lC0JLzK
	otAxJcR2i5TmyCJxkyJiVDXuSRLEcbDWAXri0nYqF7qIpLSSMdz7RkCJv9YdEfgxVG+FnGMTRUR
	avQP+wVDbeyb/kOIhBBK+JWzWRzdzG3Z07XSRqdbsx+ofuZfntfIqcXTZfsDWg9Cw==
X-Google-Smtp-Source: AGHT+IHGFMFAHe3bY+DvDEhDPlvcqwc3mNHGgpeC6W2UaOALsJ4SgnArYnmlKWon5p86seALXadangeVhLFqm7q/dg0=
X-Received: by 2002:a05:6512:114a:b0:55f:6a35:dd47 with SMTP id
 2adb3069b0e04-575f227aaa7mr93342e87.4.1757968884595; Mon, 15 Sep 2025
 13:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk> <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
In-Reply-To: <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 15 Sep 2025 13:41:12 -0700
X-Gm-Features: Ac12FXw8iWJeTorsJMYkNtO9I0t4-r4gAX3swEx-NNU_3hrQub2lYzbBDyi4Y1E
Message-ID: <CAHS8izNiogfYx7YqfnAEUZX9NJSnHn7vykNx_X=b5chLpJ90SQ@mail.gmail.com>
Subject: Re: [PATCH][RESEND][RFC] Fix 32-bit boot failure due inaccurate page_pool_page_is_pp()
To: Helge Deller <deller@gmx.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Helge Deller <deller@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Linux Memory Management List <linux-mm@kvack.org>, netdev@vger.kernel.org, 
	Linux parisc List <linux-parisc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:08=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 9/15/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Helge Deller <deller@kernel.org> writes:
> >
> >> Commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them=
 when
> >> destroying the pool") changed PP_MAGIC_MASK from 0xFFFFFFFC to 0xc0000=
07c on
> >> 32-bit platforms.
> >>
> >> The function page_pool_page_is_pp() uses PP_MAGIC_MASK to identify pag=
e pool
> >> pages, but the remaining bits are not sufficient to unambiguously iden=
tify
> >> such pages any longer.
> >
> > Why not? What values end up in pp_magic that are mistaken for the
> > pp_signature?
>
> As I wrote, PP_MAGIC_MASK changed from 0xFFFFFFFC to 0xc000007c.
> And we have PP_SIGNATURE =3D=3D 0x40  (since POISON_POINTER_DELTA is zero=
 on 32-bit platforms).
> That means, that before page_pool_page_is_pp() could clearly identify suc=
h pages,
> as the (value & 0xFFFFFFFC) =3D=3D 0x40.
> So, basically only the 0x40 value indicated a PP page.
>
> Now with the mask a whole bunch of pointers suddenly qualify as being a p=
p page,
> just showing a few examples:
> 0x01111040
> 0x082330C0
> 0x03264040
> 0x0ad686c0 ....
>
> For me it crashes immediately at bootup when memblocked pages are handed
> over to become normal pages.
>
> > As indicated by the comment above the definition of the PP_DMA_INDEX_*
> > definitions, I did put some care into ensuring that the values would no=
t
> > get mistaken, see specifically this:
> >
> > (...) On arches where POISON_POINTER_DELTA is
> >   * 0, we make sure that we leave the six topmost bits empty, as that g=
uarantees
> >   * we won't mistake a valid kernel pointer for a value we set, regardl=
ess of the
> >   * VMSPLIT setting.
> >
> > So if that does not hold, I'd like to understand why not?
>
> Because on 32-bit arches POISON_POINTER_DELTA is zero, and as such
> you basically can't take away any of the remaining low 32 (30) bits.
>
> >> So page_pool_page_is_pp() now sometimes wrongly reports pages as page =
pool
> >> pages and as such triggers a kernel BUG as it believes it found a page=
 pool
> >> leak.
> >>
> >> There are patches upcoming where page_pool_page_is_pp() will not depen=
d on
> >> PP_MAGIC_MASK and instead use page flags to identify page pool pages. =
Until
> >> those patches are merged, the easiest temporary fix is to disable the =
check
> >> on 32-bit platforms.
> >
> > As Jesper pointed out, we also use this check internally in the network
> > stack, and the patch as proposed will at least trigger the
> > DEBUG_NET_WARN_ON_ONCE() in include/net/netmem.h.
>
> Interestingly it did not triggered this warning for me.
> Need to look into this.
>

I think you're probably not running into this because you're not
testing on with a driver that supports pp. There are 2 broad buckets
of places where page_pool_page_is_pp and netmem_is_pp is used:

(1) in the networking stack, where all the checks are guarded by
skb->pp_recycle, which is not set unless the driver supports pp
(2) in the general mm code, where the checks are not guarded by skb->pp_rec=
ycle

You seem to be hitting 2 and not 1, which just indicates you don't
have a pp enabled driver, I think. If you do and you're not hitting
the warns then that's indeed a bit weird.

The proposed patch fixes callsites #2 but does not fix #1, so I think
it may not be good enough. 32-bit setups with pp drivers will still be
completely bonked with that patch I think, although it's obviously
better than crashing on boot. I think we need the *_is_pp() checks to
work reliably one way or another. Reverting will also introduce the
crashes that patch aimed to fix :( I'm taking a look to see if there
is any suggestion here I can make.


--
Thanks,
Mina

