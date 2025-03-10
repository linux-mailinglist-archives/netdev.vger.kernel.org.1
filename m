Return-Path: <netdev+bounces-173444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C1A58E05
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9811116A48C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAEA22257D;
	Mon, 10 Mar 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="BVEfJ9pn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AA1D5CC1
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594962; cv=none; b=BBpQjtEUKktOCCAwCwPuynRvt+g530GAQqyLqMSnFarXzktlayM72+hOBeHFKRZoHAqjDEUv0OI79F2U4cEHCRdv2Z2pUEPzbGwuSnXhc916TSBV0v0nPVotyNyQpX3q5hes+3u2lUi/OQdJXh/8VAgs1jYBlaKd/rTg7PJPh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594962; c=relaxed/simple;
	bh=bMQzVsplbiB2Zmo3SaMqut9ld73bjRVV8sqc1inTYf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r30M2WRFGzqENPUxwlbp7+D7mOepg01FU27bP8/5983A9Sj3qOOQZbKP2ie2r1RKyuyTodgXArPgBfVfiaoceS5nrT2DN47E2ucpP5dGd2GhX7mhoojKXgtIS3J5UVb67TrTC9mh/w9OzRhsL9rN2RrZ5/3nTn2OZPIVTscfo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=BVEfJ9pn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-547bcef2f96so4099642e87.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1741594958; x=1742199758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjzKD/Jg47p1iuSSXliIqZXhMH3ZDbn6H5maH+gH5a8=;
        b=BVEfJ9pnw/Bf9/2Ue8ZXnzk3bB85OjFi2cMm/cpj2W5NQYXbuoRsC/yxL2ifR2oDQo
         BRj9SXhkGYNHKjz0Z6k/EkfimKBMq8TjCGjOUiHQpCWW+hjXsl9p6zt+JVDmo2NIc1Y+
         lTcD6HVnxN89HPD6dqaOPtrEMCekau2u33TJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594958; x=1742199758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjzKD/Jg47p1iuSSXliIqZXhMH3ZDbn6H5maH+gH5a8=;
        b=Obf67Ffw6IWNycktpTdMoKEbxIVMc6VG+SqBUczKMlrY1EhhNZtFe7xc/kZLN+ZT9R
         Ue3NXI0L9GIic32Iu1Tt251f5rhUkmTfPL1KaHRtahJ/i0NfUz/vGySyXlHqbkCRCvKi
         bHDuHdK8d58xH/stVdRTwPHBKazpqoVlTEZ+d7TcsLXozUOGuDMJ5ya0j+2FgVHur3i9
         w+wLvvAVm0nNp6dbYjVbBmId+PX6eBB031yn+wF5oypLRu96KG85eAU4B2cD7d/1O5Me
         HgwdPWhTnmmll+lZ71FWuUv19vG+wfwAxF0aqYmoKmbSz98/dRzWZmxjMJj7m5oFl7JE
         RZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzbKFSjuOpbw0/+lhy/OlypcfS60A2nMVvYqgmgfZbHjU6z8Xm8SlXCIwCinOSl2oEpv/Os3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LCHDFsYjeifGR9a2zHl0tBvfIkyVbPM1Y5AIYP7dhNWKZ4tU
	NDdmi1n+SxPirb/X2I2oG26RyhGpuq3ADMTTuaiBV3b2yL4r9Jh34YV4fokJISYoSp+OVifmIqz
	WPeXX3v3YGvbm5WzvF1me6IlqZ8SzGJmsff42LQ==
X-Gm-Gg: ASbGnctWOf+RbwG1dsrKey57sRQKXhPBjH4U0lYsKbT4fAttQEGUQNQrEqD/f0ARk4X
	0stalmVk4HTnRlXIBkGGyi2wrYYjQpYzDsVhi2eQ/uVUxTegxqrzp9Cm5xAEaktaQJH2EKC9qPq
	gLCw2E/WlOt3Ga3y0Kc302t2c+BVQ=
X-Google-Smtp-Source: AGHT+IGvR0f400RVkNv4K+q673+Y3d11UPh/QYHIhrUH/d5oB1WAnS7YR7PKXV6jGKEUVj0KLZINifpAjbJ74/D1xlI=
X-Received: by 2002:a05:6512:ba6:b0:549:8ed4:fb64 with SMTP id
 2adb3069b0e04-54990e6725bmr4679189e87.24.1741594957741; Mon, 10 Mar 2025
 01:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com> <CAL+tcoDhPe3G_iheA0M_9dO-Tij-dYROfneiGS3SUr8w7bhH8A@mail.gmail.com>
In-Reply-To: <CAL+tcoDhPe3G_iheA0M_9dO-Tij-dYROfneiGS3SUr8w7bhH8A@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 10 Mar 2025 09:22:26 +0100
X-Gm-Features: AQ5f1Jr3P324GRSgffqmmY0SETWU8n4FmjryAneVg13f4XigYVSLvHw77lEmslo
Message-ID: <CAJqdLrp+d=d2rZ776_zvw_Kz8FT317skkE+SufyUk_9secE_9w@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, edumazet@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Anna Emese Nyiri <annaemesenyiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mo., 10. M=C3=A4rz 2025 um 06:33 Uhr schrieb Jason Xing
<kerneljasonxing@gmail.com>:
>
> On Sun, Mar 9, 2025 at 1:15=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> >
> > Accidentally found while working on another patchset.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Jason Xing <kerneljasonxing@gmail.com>
> > Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> > Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
>

Hi Jason,

Thanks for looking into this!

> I'm not sure if it's a bug. As you may notice, in
> arch/parisc/include/uapi/asm/socket.h, it has its own management of
> definitions.
>
> I'm worried that since this file is uapi, is it allowed to adjust the
> number like this patch does if it's not a bug.

My understanding is that this file (tools/include/uapi/asm-generic/socket.h=
) is
a mirror copy of the actual UAPI file (uapi/asm-generic/socket.h),
and definitions need to be in sync with it.

But I absolutely agree that we need someone who knows that for sure
and can confirm.
Breaking anything, especially UAPI-related stuff is my nightmare.

>
> Otherwise, the change looks good to me.

Kind regards,
Alex

>
> Thanks,
> Jason
>
> > ---
> >  tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/ua=
pi/asm-generic/socket.h
> > index ffff554a5230..aa5016ff3d91 100644
> > --- a/tools/include/uapi/asm-generic/socket.h
> > +++ b/tools/include/uapi/asm-generic/socket.h
> > @@ -119,14 +119,31 @@
> >
> >  #define SO_DETACH_REUSEPORT_BPF 68
> >
> > +#define SO_PREFER_BUSY_POLL    69
> > +#define SO_BUSY_POLL_BUDGET    70
> > +
> > +#define SO_NETNS_COOKIE                71
> > +
> > +#define SO_BUF_LOCK            72
> > +
> > +#define SO_RESERVE_MEM         73
> > +
> > +#define SO_TXREHASH            74
> > +
> >  #define SO_RCVMARK             75
> >
> >  #define SO_PASSPIDFD           76
> >  #define SO_PEERPIDFD           77
> >
> > -#define SCM_TS_OPT_ID          78
> > +#define SO_DEVMEM_LINEAR       78
> > +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> > +#define SO_DEVMEM_DMABUF       79
> > +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> > +#define SO_DEVMEM_DONTNEED     80
> > +
> > +#define SCM_TS_OPT_ID          81
> >
> > -#define SO_RCVPRIORITY         79
> > +#define SO_RCVPRIORITY         82
> >
> >  #if !defined(__KERNEL__)
> >
> > --
> > 2.43.0
> >

