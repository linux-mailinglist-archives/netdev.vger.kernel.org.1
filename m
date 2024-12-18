Return-Path: <netdev+bounces-152862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3079F607F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E113B188144C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F2018858E;
	Wed, 18 Dec 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ0XAD7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2C4A3C;
	Wed, 18 Dec 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511975; cv=none; b=LcPqtwTO87Vver/sTbmSe319ct9l6+kufP16OJx8pSf819bFb/M8uW6fu08qI4p2vx6KcjheWcKvXJw6R9p9ccEZ8txJXnM/gnrTe2QqXMqNtTJEuNRVnu2kZetXXZfICSHrIDXe8PVidUly1IX3d4lNIduclZ8n67Ha9zzJhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511975; c=relaxed/simple;
	bh=b8BUordGePXyMPmYfMw51aih2gx7ZrPsUApAk+X917M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmgpNgoHqGrwrR+5Adc7E5Q8AUpvEs8C6zYFLuZxlB36Llxr8e3ZBpEyPDbvxHo7HyCCrZhEcTXWFJgzUQgqqfanmGntI16wrVArmPK5BXJlRdb5084g8yNc+PduQP9hB70Kf6snZFViHDsB1DFn3VIWjQAnnefJMY49iIM1xWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ0XAD7o; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3003e203acaso58490271fa.1;
        Wed, 18 Dec 2024 00:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734511972; x=1735116772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxipcKYrEMK0D8amtkSwoNfW79Kt+zmaZRH04ZVpstg=;
        b=UZ0XAD7ow44NabNV4jGWIDvEvuiet4YHG6a6x/LhSpnm6WuklTkkvi7nImKrFhz3+R
         XpIQs/9wvFtTwsS0L6hxfeIyFT3Uko3c4ACTDxy35OMpjaS+CQStbuRlUe/sbuERyZA/
         85KW0DGbwVLKEY+8kCzuHK80mA/bdNVRLzRA+wiKMeYwhcGBgFeLR5rTTQVNCzUv1rS0
         O8tGso0o+1DrtsH22xMIOA2t3YrAmTsf9kbJ9h2gUx9m5HiFJ8ZSoR+cAo2m5vrbeiD/
         pwkDNSBrWLlsycFTJDK2Q79FUqj03o2DnSDrgnvfeVpl/UUESDmLX2IZWmB8EZGYTa7A
         Fkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511972; x=1735116772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxipcKYrEMK0D8amtkSwoNfW79Kt+zmaZRH04ZVpstg=;
        b=wWFuBTLLqj5MKR7jDHLoKylUJOFNRar7dLs8TzuKsocZjlKt8U5c36lC/SFPbu2VRH
         jA1XA/cV4aiTkpu8cQ/q/ekgmeY45dA/ZmIDdk7jxBVjcOIq4vS1qHV4YLSbLt/3zreX
         yQ6nRajDuETHYY9X27ZHRXSudTBb8YMzQZ4liR3YpZaOTcEYJCsj1ucejdTaGd+6FGAy
         j1PndmJOlvPgyfEj3qAB8rLnd6PV/9/ggHyj43lgyZ+FOabGElz5cECuG1U2BecQZU+s
         tqtIIS9tPn34wGQV94a0/GTEbkrIcf4sZv07S88tZEAJd+XDsKdF4qEC99zzxfn+Hnee
         61nw==
X-Forwarded-Encrypted: i=1; AJvYcCUJnu7LtvAmNSiX6ujVF67Z04mUvCONO6Zg/EXkqQZrpNzd04tRRJuEtnFq1FSd2i90WNASVeH6nTGDnz0=@vger.kernel.org, AJvYcCWKLfJs6rRFZ+6IRGRTNIqi2AUXXjPraoaFhF1aMPeCewsKmJf7WY4bIV/gJoAJEFFF8ARwryi5@vger.kernel.org
X-Gm-Message-State: AOJu0YwCenDv3NRS2evN801yEZgxYkR93uBz9eDUgH7m7DelGSY0xj8c
	/7Gx54hS+m2iDOJ71+Qjpbt5ZWm7KhR3cejJL/TxGhPN8JXeSet6fLj21g9Dg+Ag7wY6Q8wSr0T
	zn+nyozXA+A6euiLYJIbjKk14A9Q=
X-Gm-Gg: ASbGncshGYQ6NlQyd2yBYSnMNeFil3W8i6Ij9aYDQjLHOwoFI4wIU2UfEvup01MY9pm
	xKW7/QDzFhO1nilna/FHH3+d80xsNBAeP1xSkzw==
X-Google-Smtp-Source: AGHT+IERDdUWm6dVha5+qz+jdc4CjQIYAUoCgMgcRkA3aokBHWqbunNZvQ9iAXRGEpIhfxg/WyUiy8GmonzFB0QKlT8=
X-Received: by 2002:a2e:87cb:0:b0:300:4362:40 with SMTP id 38308e7fff4ca-3044db5743bmr5592641fa.36.1734511971425;
 Wed, 18 Dec 2024 00:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021080856.48746-1-ubizjak@gmail.com> <20241021080856.48746-3-ubizjak@gmail.com>
 <7590f546-4021-4602-9252-0d525de35b52@nvidia.com> <CAFULd4aL+qVxyFquMTTQLyVFpVSc1DwcahJprj73RtvrW_XsXA@mail.gmail.com>
 <bf189e58-710f-49c2-a419-e3d3e71576ca@nvidia.com>
In-Reply-To: <bf189e58-710f-49c2-a419-e3d3e71576ca@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 18 Dec 2024 09:52:39 +0100
Message-ID: <CAFULd4YwiE=q4QEPjFeLQdwqcret3TX7usZUOuP=R3hLPMNwyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] percpu: Cast percpu pointer in PERCPU_PTR() via
 unsigned long
To: Gal Pressman <gal@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 9:46=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 18/12/2024 10:40, Uros Bizjak wrote:
> > On Wed, Dec 18, 2024 at 8:54=E2=80=AFAM Gal Pressman <gal@nvidia.com> w=
rote:
> >>
> >> On 21/10/2024 11:07, Uros Bizjak wrote:
> >>> Cast pointer from percpu address space to generic (kernel) address
> >>> space in PERCPU_PTR() macro via unsigned long intermediate cast [1].
> >>> This intermediate cast is also required to avoid build failure
> >>> when GCC's strict named address space checks for x86 targets [2]
> >>> are enabled.
> >>>
> >>> Found by GCC's named address space checks.
> >>>
> >>> [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address=
-space-name
> >>> [2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-=
Named-Address-Spaces
> >>>
> >>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >>> Cc: Dennis Zhou <dennis@kernel.org>
> >>> Cc: Tejun Heo <tj@kernel.org>
> >>> Cc: Christoph Lameter <cl@linux.com>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> ---
> >>>  include/linux/percpu-defs.h | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.=
h
> >>> index e1cf7982424f..35842d1e3879 100644
> >>> --- a/include/linux/percpu-defs.h
> >>> +++ b/include/linux/percpu-defs.h
> >>> @@ -221,7 +221,10 @@ do {                                            =
                         \
> >>>  } while (0)
> >>>
> >>>  #define PERCPU_PTR(__p)                                             =
         \
> >>> -     (typeof(*(__p)) __force __kernel *)(__p);
> >>> +({                                                                  =
 \
> >>> +     unsigned long __pcpu_ptr =3D (__force unsigned long)(__p);     =
   \
> >>> +     (typeof(*(__p)) __force __kernel *)(__pcpu_ptr);               =
 \
> >>> +})
> >>>
> >>>  #ifdef CONFIG_SMP
> >>>
> >>
> >> Hello Uros,
> >>
> >> We've encountered a kernel panic on boot [1] bisected to this patch.
> >> I believe the patch is fine and the issue is caused by a compiler bug.
> >> The panic reproduces when compiling the kernel with gcc 11.3.1, but do=
es
> >> not reproduce with latest gcc/clang.
> >>
> >> I have a patch that workarounds the issue by ditching the intermediate
> >> variable and does the casting in a single line. Will that be enough to
> >> solve the sparse/build issues?
> >
> > Yes, single line like:
> >
> > (typeof(*(__p)) __force __kernel *)(__force unsigned long)(__pcpu_ptr);
> >
> > should be OK.
> >
> > Thanks,
> > Uros.
>
> Awesome, I'll submit a patch unless I hear any objections.

Please note that this is/was a preparation patch for further changes,
applied to akpm's mm branch (typeof() -> TYPEOF_UNQUAL()). I'll take
care to forward-port your patch to mm branch.

AFAICS, the issue triggers only when KASAN is enabled.

Thanks,
Uros.

