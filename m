Return-Path: <netdev+bounces-223265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395ACB5889B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B933A512C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EEF2DA776;
	Mon, 15 Sep 2025 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQwbMWGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766D2D592B
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980299; cv=none; b=PHh5LaMM9DaExINySMRMCtNX2P5+aqCzgJk8qcyOW3HYX81qH6uqdDwVr4KzeenvgZsnLtiF2snfUCyhVkLAztzAQHZtOTheHH/9n3B5RVW++zzeT9oobz8b0vjSOdO5bX00D6nPfncNiYRyPs7F7MS0bmZFPpgAqG2aGe7I5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980299; c=relaxed/simple;
	bh=eliaRJLX7HQmX0oBI6ci9T+Cenfd4Lgby8UQAyIhUoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5/s6n84+KYb9qGuoUms7IvZ1YKykDEoU/sZCnBGROlYnW74lGYlzTtUrVlBxJO/gbwdNRhATsBIl/nf5XcQxItPl4DHwMuoNuavyCNoVIWvkS+/xYvvyxVzR4JTub36pZ7nXiZwOqDdjixFQiR4jSR7CGDHcI/RR50WXXIFyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQwbMWGp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-572e153494eso1265e87.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757980295; x=1758585095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AW5j7gH90N0KHAK5Rp1VJX/iqgngX55U8vMWYrXM/c=;
        b=gQwbMWGp82H1KIo11wgq/6vCTG2Y1Tm4fiGBO4VXSoC4GURuXLZEug0MClH814pbI2
         I4pmV4VI0PjZqBkQPup3atP8VgcyMCnoSqfxIVSyyT971xyP00BYvnv3hCqVT9tH6P3U
         iTs3c4h1lckno+xM+YWeW83Vx3Kcrv35/Q4TYD/GCyat+4zbL8bH4rTC9HDDWLp+fz+v
         m7CnoBteOICPPR/eJV+UgHizG5qHhZG/VPVtfxEJ1OUHK9dwwOu6/trdLmF1/DKB5XM1
         M4Tih4FKc1/PGaC0qQNBBXMlVj6hlo/SRX+tKa3tYtm7Qab123cj/Fv7lDvkYyyYdL9E
         AxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757980295; x=1758585095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AW5j7gH90N0KHAK5Rp1VJX/iqgngX55U8vMWYrXM/c=;
        b=uXuW6cIP0ePB9jiYwyvgWc/ij1DFAMxFv0QE22kSWMbIGhhqPIlDFTI+iXfo9vC1RW
         zdkvhSdpT5zooukylt4luIxeXArZWgnKxXyO3ughSpnGD0bDpomElw5m5qKVPYpKHRpS
         OL7ced1gBOpUfpDHsFcfFOVVMEeiWphiGu1fpnATh9UnNIlThuDGK48YK10LUs02UFQp
         UnJMIDnUvSSIldPMz9VZiOvb3A1wzbwF7YtZp4l04OCpO/gMwQNxHHZ7S/Fi9cEH+QIp
         /EYrFwvFcc0j0PhKUXGNXgHzz1FOS784xQrO2pQPPrVRRv4CQacn9ekZA3zFxmvZO9zl
         YEhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzZakgAPCsRWI/CixGFLCcKqDa5Yk05385rM1FAeYxDQa8etEQhVDL8P6nZ3JoSHyYb1uxW5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3dqk9f5KwiG8DUrdf9KVF+RFCKJvz4NI4L7YDzv0JTz0FK/k
	C4MAutMWNnXpkALkhFPHjXEP4ep2ax3aKgWBjvyAwkzEbfpYbp+1c2gSBEIhTvsdK7+L9FCN1VO
	7rdZq6IM5A8VKZBlId4xWk71t1YiOEYEdaiJ3/DMI
X-Gm-Gg: ASbGncv4nLrvFMCgXIJNih8aY98EtghaeiBFFjfxBlbBv44WNCejphHhYlkDSMWDHaX
	OO6BSy94suiaSsEQWi7egDuIx4QK7UuMnjs8FfLXCaullvOYXPckZH8A6vdDysCltK90X0+1bH1
	fxrLq9T2bgHzvIEYtKlIUVcnmSJQ+XPXDtX1s/mLiTJTV8MGy3UM15aPL4tm5H/NqEoPbWlbsw2
	qF3CMJOqtyQhSBQHHDLFvK2cJUkgBoOu+drTB4tcf2ZE8njhqFRsZY=
X-Google-Smtp-Source: AGHT+IHxvjAgcwmbl7i4qIGx4IZFATPmsddKAtgs9jLnh4/bbrdOaxSwmwp0X3FOGMej3r5ilGUywPi3vDMfM91nRr8=
X-Received: by 2002:ac2:58eb:0:b0:56c:8abf:2f84 with SMTP id
 2adb3069b0e04-575f17cd140mr128995e87.6.1757980295277; Mon, 15 Sep 2025
 16:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMSni79s6vCCVCFO@p100> <87zfawvt2f.fsf@toke.dk> <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
In-Reply-To: <f64372ec-c127-457f-b8e2-0f48223bd147@gmx.de>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 15 Sep 2025 16:51:23 -0700
X-Gm-Features: AS18NWBQSIQoWON_0Lqkp-hzdof6vglmBL66-QqAsvHEfvhsjjn3e7ulAH9_zlI
Message-ID: <CAHS8izMjKub2cPa9Qqiga96XQ7piq3h0Vb_p+9RzNbBXXeGQrw@mail.gmail.com>
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

I tried to take a look to double check here and AFAICT Helge is correct.

Before the breaking patch with PP_MAGIC_MASK=3D=3D0xFFFFFFFC, basically
0x40 is the only pointer that may be mistaken as a valid pp_magic.
AFAICT each bit we 0 in the PP_MAGIC_MASK (aside from the 3 least
significant bits), doubles the number of pointers that can be mistaken
for pp_magic. So with 0xFFFFFFFC, only one value (0x40) can be
mistaken as a valid pp_magic, with  0xc000007c AFAICT 2^22 values can
be mistaken as pp_magic?

I don't know that there is any bits we can take away from
PP_MAGIC_MASK I think? As each bit doubles the probablity :(

I would usually say we can check the 3 least significant bits to tell
if pp_magic is a pointer or not, but pp_magic is unioned with
page->lru I believe which will use those bits.

AFAICT, only proper resolution I see is a revert of the breaking patch
+ reland after we can make pp a page-flag and deprecate using
pp_magic. Sorry about that. Thoughts Toke? Anything better you can
think of here?

--=20
Thanks,
Mina

