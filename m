Return-Path: <netdev+bounces-174897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF1A612AF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B2F1894E27
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA981FF1DA;
	Fri, 14 Mar 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5TmTCTs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029E134AB;
	Fri, 14 Mar 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959108; cv=none; b=WZ76e/cSEbToI3yVOM5FcBF8tfXWrWPwAi+VMNOhvAIho5E7KHBINPXo1PI7VJ3fj3NBj4RxOEgLzLj87fihKyyZP4a7VmdyIwftTGpUGnuiiLuNgXIQJ7tLJfo1LjUxV1swgOPs6c8eLnExllGDNMCCLwbmf3JtMcy8FUvJFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959108; c=relaxed/simple;
	bh=gj3NYI3coGahkYXwx6USbGbvU6D17tfuUeQTPPTb6Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOafQkkhBHq1jukGg565q1omscktFBj/wrQesACAGlxiGok9QML5cb6dXj/eFLs23NTVJ4JWGBeYwjn9SrGz4EdBE0doapYfbv93O2OaCvbsLqEEujmSXuk8H2Tmq+16/Y2Qw8YV8tRlLkShQeXsgGgjmG4wjdUXcpvM7nqhEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5TmTCTs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22398e09e39so43526155ad.3;
        Fri, 14 Mar 2025 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741959106; x=1742563906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRnRGl1AfdbXlS77j82nE9ScaNFhXXtMhswVLJe3pAE=;
        b=Q5TmTCTsv2qPO7bQvI5UH9Xx/2IwW7s5oFIGD+CIOGlPZRDCwmEM0v0p0Obatg7SXZ
         WLy+AiOD7xv+D5xOGgsWrgl2P2OnWwKGaD2shLueeSM2X1DiS2z31A0xX6O5jKi2dZLf
         M/VfW0k/tbcgffq5vpZKLkHMuRaLMF2h3tWmvh0KIa7/sAeGMGmAIDvZw5fYN4wWBibj
         xAYNqcCnsRPWoM03l6DAvDHJH3p+dXJAct8PSqP43piIgi5yMCMmLTH9rWDVZ/rU7Blk
         rWVuAaM0hRwMroMlmYW5N2s9OZtchP25yWXCGjMhNhfUhq44i1qNRD2OzhIlYYERCkPQ
         DZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959106; x=1742563906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRnRGl1AfdbXlS77j82nE9ScaNFhXXtMhswVLJe3pAE=;
        b=VRm5hPNvN4WPHI/5r4J6xH5Fm+Iz8XcSd/qzYSzhrGPpDsXlC6bqnGtO2hdqadpiSi
         NOghHD+Ra6XZ+yLoKTd1IgUpHWm/GS4s/QRGgPOE1AAnTpkq6tHt0JgccHG1GaVSh0Ik
         BvKIUqGxLqmEpY3xxPXUZMQh4AmRE4/q5bivh6NkQiZdVR/MRsxBT93srvPzHhucGBwN
         rV+jfiQ0PxuZKSEyIakthkk5dB6yl9izoIQOd6CQEqmLUPAlE7nhGmbOsIfBVJyO7rkG
         rQuFUndsj8VdY43UbarRup4ZiMdm5Gu7JQlXBdDU8stXH4SwujE5jYBqzgwtpf98b1vL
         1w7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUihpFnsy+UIPePLp8Ysx3LCjMGf3kdCBhMMtTPxis1eVYG4vjYGgyunqgnPsv/DA/Hj8X9Dpc5fomA7/g=@vger.kernel.org, AJvYcCVXm76ssRy3xaO9vXO9pHfZLz4zRv3/7nXrgxTjuGy0GV/DTP0WX1X1vgr6dm5t7CMuQNdjpMoB@vger.kernel.org
X-Gm-Message-State: AOJu0YyQNwI4lRQLSEtuoKC3OzcXJKd20v67pj1R4cRCrmlaHpucfo33
	Z6qdL+yna7W5crB9+kWAymefqWRgiRVQJ5yqmwkcSyEEIuzGE+/zeSHLv8hX44PXWFzWmaR6K3q
	1AV2/4m/QwEoZrkUCo4PjZGwWl2Y=
X-Gm-Gg: ASbGncsvOW3875Hg7oCLMJAXZWN2PRvb3CTIuAmr1zgZlgekLWE6KNMn18ZEE9i5O2b
	OZ8urmMRa6n+aAfomtYGA468NHrjaE5VkHrJN8hddC0i1DrMp4qIZpV81nMoM+t6tzK9atiItc6
	8O0sWQvRT35glEPAySk/3tnkkLlVj6FT7bovZIJog9Ox9+tdTaMeNiLHglJX0=
X-Google-Smtp-Source: AGHT+IFiAWiKj+MJwn+S3HigGFeBovw0sPdQYFXD28BrLYC4NGbnywq9LbSsyUrkKeF0to/BJtRSGNGdYXVJp590efw=
X-Received: by 2002:a17:90b:2707:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-30151ca0e05mr3418497a91.20.1741959105688; Fri, 14 Mar 2025
 06:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
 <CAL+tcoDhPe3G_iheA0M_9dO-Tij-dYROfneiGS3SUr8w7bhH8A@mail.gmail.com> <CAJqdLrp+d=d2rZ776_zvw_Kz8FT317skkE+SufyUk_9secE_9w@mail.gmail.com>
In-Reply-To: <CAJqdLrp+d=d2rZ776_zvw_Kz8FT317skkE+SufyUk_9secE_9w@mail.gmail.com>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Fri, 14 Mar 2025 14:31:34 +0100
X-Gm-Features: AQ5f1Jpl1eZvO9TwMCXdy9qA1FDmOIBQXsUQV-i0tHUZkyoMr31eqj3wUhXsCaU
Message-ID: <CAKm6_RsfA_Ygn4aZQdUxfBujxxgdB=PvgymChDtWSVHhhp6WZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, edumazet@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexander Mikhalitsyn <alexander@mihalicyn.com> ezt =C3=ADrta (id=C5=91pont=
:
2025. m=C3=A1rc. 10., H, 9:22):
>
> Am Mo., 10. M=C3=A4rz 2025 um 06:33 Uhr schrieb Jason Xing
> <kerneljasonxing@gmail.com>:
> >
> > On Sun, Mar 9, 2025 at 1:15=E2=80=AFPM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORIT=
Y.
> > >
> > > Accidentally found while working on another patchset.
> > >
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: netdev@vger.kernel.org
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Cc: Jason Xing <kerneljasonxing@gmail.com>
> > > Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test"=
)
> > > Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> >
>
> Hi Jason,
>
> Thanks for looking into this!
>
> > I'm not sure if it's a bug. As you may notice, in
> > arch/parisc/include/uapi/asm/socket.h, it has its own management of
> > definitions.
> >
> > I'm worried that since this file is uapi, is it allowed to adjust the
> > number like this patch does if it's not a bug.
>
> My understanding is that this file (tools/include/uapi/asm-generic/socket=
.h) is
> a mirror copy of the actual UAPI file (uapi/asm-generic/socket.h),
> and definitions need to be in sync with it.

I don=E2=80=99t completely understand this either=E2=80=94if the definition=
s need to
be in sync, why is there a discrepancy?

Specifically, I am referring to the ones that caused the shift in
numbering in uapi/asm-generic/socket.h:
#define SO_DEVMEM_LINEAR 78
#define SCM_DEVMEM_LINEAR SO_DEVMEM_LINEAR
#define SO_DEVMEM_DMABUF 79
#define SCM_DEVMEM_DMABUF SO_DEVMEM_DMABUF
#define SO_DEVMEM_DONTNEED 80

In the case of SO_RCVPRIORITY, I simply continued the numbering
sequence as it was=E2=80=94I didn=E2=80=99t intend to disrupt the structure=
 of the
definitions. It=E2=80=99s possible that I made a mistake in doing so.
If this doesn=E2=80=99t cause any issues, I would also vote for modifying t=
he
numbering. Could someone more familiar with this area confirm whether
adjusting the numbering is acceptable?

> But I absolutely agree that we need someone who knows that for sure
> and can confirm.
> Breaking anything, especially UAPI-related stuff is my nightmare.
>
> >
> > Otherwise, the change looks good to me.
>
> Kind regards,
> Alex
>
> >
> > Thanks,
> > Jason
> >
> > > ---
> > >  tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/=
uapi/asm-generic/socket.h
> > > index ffff554a5230..aa5016ff3d91 100644
> > > --- a/tools/include/uapi/asm-generic/socket.h
> > > +++ b/tools/include/uapi/asm-generic/socket.h
> > > @@ -119,14 +119,31 @@
> > >
> > >  #define SO_DETACH_REUSEPORT_BPF 68
> > >
> > > +#define SO_PREFER_BUSY_POLL    69
> > > +#define SO_BUSY_POLL_BUDGET    70
> > > +
> > > +#define SO_NETNS_COOKIE                71
> > > +
> > > +#define SO_BUF_LOCK            72
> > > +
> > > +#define SO_RESERVE_MEM         73
> > > +
> > > +#define SO_TXREHASH            74
> > > +
> > >  #define SO_RCVMARK             75
> > >
> > >  #define SO_PASSPIDFD           76
> > >  #define SO_PEERPIDFD           77
> > >
> > > -#define SCM_TS_OPT_ID          78
> > > +#define SO_DEVMEM_LINEAR       78
> > > +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> > > +#define SO_DEVMEM_DMABUF       79
> > > +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> > > +#define SO_DEVMEM_DONTNEED     80
> > > +
> > > +#define SCM_TS_OPT_ID          81
> > >
> > > -#define SO_RCVPRIORITY         79
> > > +#define SO_RCVPRIORITY         82
> > >
> > >  #if !defined(__KERNEL__)
> > >
> > > --
> > > 2.43.0
> > >

