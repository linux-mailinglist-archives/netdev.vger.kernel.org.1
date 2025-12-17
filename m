Return-Path: <netdev+bounces-245049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCCCC6609
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DAA13012240
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CB0272801;
	Wed, 17 Dec 2025 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpCnWix4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890A1AA7BF
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957132; cv=none; b=dQxRO3io0RjHKNQg+wRpwteRr68l74tAXCYeSeDBea/uLyrcTfy0nzzmMhhyMfZHYv/u6bCljBw2McZ37EjYFEskMa/tJ0w/zmLfQIj9KTf/5ffsEmvulrLxOjRTJQpVw1SN/YYZtP9vRIdmVTl03s+7ZJ2byxbS+JPOzMTaLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957132; c=relaxed/simple;
	bh=Hsb56Rs90x2k4ukE0Ot8r6/OwCWWMm1hIIq3hRHiUkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrvhDFGcjvpplk/ZwS6UFA4YkMeXaidWNRBYVeBbyKq7BkRmtL1I/L0qiXxyGHXdroqbHMIWjIPV77zvRf1utMSWn3h/OH9yqA+TJy8Scj1SSfmwhKO8p0LkjtGQktA+c1K5AmkbDfV7J3Gx7bSjuzdUdLUbsqNz8YooL24JUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpCnWix4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42f9ece6387so2130070f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 23:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765957129; x=1766561929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbqhzpWH7PyaGirZsS8sgiEKvpbvpZb7J4Lujfr7Cw8=;
        b=OpCnWix4H/DHbEOAVXbEePBZvGpjjZG+byqjaP5EYu4y8shRghGGOS2OBssmUL4oXs
         VfmfBwo+1Kb2cB25XhkFIqCFpvqjnR+o1hYoT/GrgnmEiOJMX+D6oKOkJeVuN7Ok9FS/
         +f47wDkE97TsDwrPLxOrh4QcAXT5wyi8WNE5qOABDpesCeviIrAB/BHaeQnZ+lcpt7rU
         ifEixFxfw+cVsFSMRI8m4KSpKrxqOFTRKWHc8HgT7LCf3Y/Ru5klQMaJs14bxunh/mk5
         HhVyZmZouglEEjhKcVbFPFo7LIYDC4lEhWTWlRBoCvpTZ3JauUUWchCdEY8aechc2TAK
         Dhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765957129; x=1766561929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbqhzpWH7PyaGirZsS8sgiEKvpbvpZb7J4Lujfr7Cw8=;
        b=L5fWC3jY9mjqbsmQoaFne87cULaWojPzHtFKLNC93V4hgO/ErCdin8Sxh08c4PKAyL
         82mfQRkjcwIz4T05D1IavIuqkf9yEkg60iGwMnl1ccn5zrnhMIkCDIRH3FuAJKrSdXmF
         hIbSKyrtJqNbfKC7wFpSPh+/JzqShEFvVl4+tJR+cOzaQfBKNB83ZSzYmgDyEfD73qGy
         1N6XOdIPfqVtDgjH4+PFI8WmEGI3cZs7sMHKpVcrTedmuLGEhRZ0j8LuFE0LpSVMH7Yw
         Laf4DAbnQ/0IwyhfnH+4Pb0BD+FpPzXxz5CNJUfEwSwDgVl/TTdq2Wcvbd1MfoXhlho/
         rSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPT/MEOXR9yO3pph9kSnoDAF2nMoirf2FBFCv0KLWazNl2LDIKzN/LWQ8fTHsz23mVEDm+wac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1aqOwBby377pLLKHq8cZdYHvnppoIa5syvyztG/R0LFxu/S9
	bv9/M89EA3rkUD40PdMUzRCHUQ3XmEGqOk1BOXr/NgMjezQY83pv3SKNVrfrSWDdD0gmAZgxKsY
	8pO//ewpUDO2NudR4MliXKegobJO4QR0=
X-Gm-Gg: AY/fxX7QG7GaknKyokHOvcVbqOuRwXMeBdoQu3Dog2Nc5mtABJPKg1Kgef6/cDjoTyH
	DMKldd99eFI4x8VJOgqicVskAzIaO2kZVUfurh8kXzQa5cscQiLYOujpzE0idFi7sTTm5WNIX71
	qPFbmnjw4BbLcV06Vh56UJEFOzz65i0iU0WXaAEWsPBVTGKMd90OHfz1CruRPV3A+PDQ2+pDNfc
	VFoylAZyu7I2YmRxQcYPW/fqsUbk2KVvPtWMPxM7bWMKq+XE5wC9gEVhKQzV5cZoH7GoNApf7MD
	crpRfT2rj2F/K/0v4Ey3+jIu9Gdx3A==
X-Google-Smtp-Source: AGHT+IF1d/OhXg0L/2AreTO1JLf6LtyhYdbdF4v0qna6Dg0KUlZSE7gqWoK7bBwMpfC9YRqlfnXsO4eNSi9QPN5Op98=
X-Received: by 2002:a05:6000:18a6:b0:430:fd84:3179 with SMTP id
 ffacd0b85a97d-430fd8434b3mr8675400f8f.33.1765957128980; Tue, 16 Dec 2025
 23:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUJYSv6kqb9QauMI@westworld> <a5ef868d-b957-4124-a9ed-030f863dcd29@nvidia.com>
In-Reply-To: <a5ef868d-b957-4124-a9ed-030f863dcd29@nvidia.com>
From: Kyle Zeng <zengyhkyle@gmail.com>
Date: Wed, 17 Dec 2025 00:38:11 -0700
X-Gm-Features: AQt7F2p-BYMdwBvcqpmQpZ9o-7T-_YNct-DlQUY8OZldAlmulsYGkefgGFpYLEw
Message-ID: <CADW8OBstQyqcrt6f0qt9EQOr4_LrFgMd1ve15ZerTw0P-qQN6w@mail.gmail.com>
Subject: Re: [PATCH] ptp: prevent info leak to userspace
To: Gal Pressman <gal@nvidia.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I apologize for the rookie mistake. Should've known better than this.
And thanks for the correction.

On Wed, Dec 17, 2025 at 12:28=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrot=
e:
>
> On 17/12/2025 9:14, Kyle Zeng wrote:
> > Somehow the `memset` is lost after refactor, which leaks a lot of kerne=
l
> > stack data to userspace directly. This patch clears the reserved data
> > region to prevent the info leak.
> >
> > Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> > ---
> >  drivers/ptp/ptp_chardev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> > index c61cf9edac48..06f71011fb04 100644
> > --- a/drivers/ptp/ptp_chardev.c
> > +++ b/drivers/ptp/ptp_chardev.c
> > @@ -195,6 +195,8 @@ static long ptp_clock_getcaps(struct ptp_clock *ptp=
, void __user *arg)
> >       if (caps.adjust_phase)
> >               caps.max_phase_adj =3D ptp->info->getmaxphase(ptp->info);
> >
> > +     memset(caps.rsv, 0, sizeof(caps.rsv));
> > +
> >       return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
> >  }
> >
>
> This is not how C works, the designated initializer clears the field
> implicitly.

