Return-Path: <netdev+bounces-182649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B9A897C6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F71792C8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464127FD61;
	Tue, 15 Apr 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZutqT9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809E27A13C;
	Tue, 15 Apr 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708952; cv=none; b=bhZjlTtBeqbRdJZAwXzZQBz7UmfidyVRt50Q91QHPJ6KZ144m6IKA2EpuSuPGgjzGsNth/AFignpt6IH5Kn3xonkqzdYzSyCRjOh5RrI+n7AJaetMW9J0EABewVHz1RqKeCc639+q0v3ycoO6jGFtD1Tl1iQj8jULDfbKLwslmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708952; c=relaxed/simple;
	bh=BuSc5ocwNLWkjNXjYVYwubVleg1xVZY4XwdbG34uspw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML0wjdjj12DIfijGN9FxcMjtkn6dHQCStF6U5mMHx0r3O/vtuTPg+QV5VwXKFBVBF+3v9rjCWXdLAChg3JrcgzsL46bv3D6WDandHaP+JHIEGcyL5LKCC/T/7Wu0q5xjFygIh0E25tJiG9NPTz3u+w0g2MDOIB3fsFH2KoaTh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZutqT9w; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-acacb8743a7so787833466b.1;
        Tue, 15 Apr 2025 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744708949; x=1745313749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFSHB8vDEA/gB5kXiVxaJXNQ4JrOxv0Kn7v+YHZA1Cc=;
        b=HZutqT9wLgY/O5SQzaIhLDRNob/+Mt+DRVWxb+whbysBqwlKQ9yi73oAN38ZM7cPVz
         C4p1QfA/1u+LXg7jXdPKses+zbSfwOXiZuGivvx0SWzD9w6JCqe5UuCGpmDCMmpkWWXi
         k339Ov0OvIj05zIinc+uVgFeUzUuYjqz9BL4IOdtkZJHZZU6KnMxY9MHVBFtz2IY/aHQ
         g6GuV8S4bPj/Ajv+8ib1D0PRvd0OT6ARLimWpkt5K2vrpAc98U8e+Fx6YL6D9e+KyClH
         Nb+DH95xdUrue5aR9muh7CPq8A+yT9vJOaZ2qcH/JaOl1f6vZZ9GBRRgMHDG/uMdsv/O
         6ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708949; x=1745313749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFSHB8vDEA/gB5kXiVxaJXNQ4JrOxv0Kn7v+YHZA1Cc=;
        b=ResbBhaW1dE02kTP6K9RgQvTBuOAFCFwvoIv75rB7bQH9MtHkwO24N8oKysSeuAdeB
         vPWEsnh6DZpS2suoeFDrlN6ChI2xZQXhh2VbaP2+mUzchPl9RuPwZuaGP422qpiYUrBN
         /UmwkVu8rzZhpOprUcGS9DC+vG8rijKQ4QMwcRSPsLL+bSJJ6N3SdQEfQMT7jtBAZ1K6
         pYBiiIkfI8aM3Y0cKDXRjz0wJQv1l1vcBDSfJ6mGZS+NCLwVw+7O3GhW6L/aJ+hllVmG
         MIa39rGeX6P+y4lXiwdfEINLS28cCMHm7vzWUPhQlKXbwRB+OxF48m+96xoT2yo4diXY
         EMcg==
X-Forwarded-Encrypted: i=1; AJvYcCUhhJTxVEYe5qild2PvH3N9c/ZDWlXSA8ok+nW2Aq0emX2zprsAo+IAiJyNjyWxvaHbss3jgnBh@vger.kernel.org, AJvYcCUx66ZHJvgClSHpIBFdKu460A8WvmduVRKsOHwFHeVZqHzmZwgfxx1WsOiqojSKX03W/YtFWwaA18JuZZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aA1wtQ+a4rWQc6wM9DT2psTHD4wXBPtJbCV6DsX0gUr4orw9
	d5snGWaKbWURI6TP6Ua74H7uN6maicUTtaY9hD4T9yrgIHgIxqq/vaU5b9ZiQwOozacileOeCMP
	uiXqlVRtqvsi9nUTbuqv3QKU0eGA=
X-Gm-Gg: ASbGncvXuCujAQStCt1gC1FADzvT6Wb8fJmYddW1wGSEqpV3JfD4awGRD6LT07AMR0n
	umh05ItZi5AGzjYCkWEUglqGcuv6WJDCDW3ZNN/3Nh6Zx3TrAj78Ic0/14Md9F/3Kt6cHhiHoyT
	PdBAq6tPa1oFDPfQ5JKm1T
X-Google-Smtp-Source: AGHT+IFoISNvEyOTAV6L95npDwn8IeABBA5AjS5VPrPDQDz6OGMnodI/Oqsr3Iy2uQkFakSwtVhAcFofvLFjycgBZSY=
X-Received: by 2002:a17:907:8688:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-acb166c9e62mr249010966b.15.1744708948501; Tue, 15 Apr 2025
 02:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415064638.130453-1-maimon.sagi@gmail.com> <Z/4D3/PW9FkxQSdo@mev-dev.igk.intel.com>
In-Reply-To: <Z/4D3/PW9FkxQSdo@mev-dev.igk.intel.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 15 Apr 2025 12:22:01 +0300
X-Gm-Features: ATxdqUHJvZLEqBP_crtdHMliwArlrmpga35FVWZtSPIGUFh9R4_ZqmlfEyxnoMo
Message-ID: <CAMuE1bH9zPA4Bzk7ZictvbWi6v5uTsE_zUVKkTCeuspDT0D7tw@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: ocp: fix NULL deref in __handle_s for irig/dcf
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:00=E2=80=AFAM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Tue, Apr 15, 2025 at 09:46:38AM +0300, Sagi Maimon wrote:
> > SMA store/get operations via sysfs can call __handle_signal_outputs
> > or __handle_signal_inputs while irig and dcf pointers remain
> > uninitialized. This leads to a NULL pointer dereference in
> > __handle_s. Add NULL checks for irig and dcf to prevent crashes.
> >
> > Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children =
of serial core port device")
> > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> > Addressed comments from Paolo Abeni:
> >  - https://www.spinics.net/lists/netdev/msg1082406.html
> > Changes since v1:
> >  - Expanded commit message to clarify the NULL dereference scenario.
> > ---
> >  drivers/ptp/ptp_ocp.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > index 7945c6be1f7c..4e4a6f465b01 100644
> > --- a/drivers/ptp/ptp_ocp.c
> > +++ b/drivers/ptp/ptp_ocp.c
> > @@ -2434,15 +2434,19 @@ ptp_ocp_dcf_in(struct ptp_ocp *bp, bool enable)
> >  static void
> >  __handle_signal_outputs(struct ptp_ocp *bp, u32 val)
> >  {
> > -     ptp_ocp_irig_out(bp, val & 0x00100010);
> > -     ptp_ocp_dcf_out(bp, val & 0x00200020);
> > +     if (bp->irig_out)
> > +             ptp_ocp_irig_out(bp, val & 0x00100010);
> > +     if (bp->dcf_out)
> > +             ptp_ocp_dcf_out(bp, val & 0x00200020);
> >  }
> >
> >  static void
> >  __handle_signal_inputs(struct ptp_ocp *bp, u32 val)
> >  {
> > -     ptp_ocp_irig_in(bp, val & 0x00100010);
> > -     ptp_ocp_dcf_in(bp, val & 0x00200020);
> > +     if (bp->irig_out)
> Why not irig_in? Can we asssume that "in" isn't NULL if "out" isn't?
>
Ss part of ocp_resource initiation, irig_in and irig_out initiated separate=
ly
(one can be initiated and the other not ) so we can't assume that
> > +             ptp_ocp_irig_in(bp, val & 0x00100010);
> > +     if (bp->dcf_out)
> The same here.
>
> > +             ptp_ocp_dcf_in(bp, val & 0x00200020);
>
> Just my opinion, I will move these checks into ptp_ocp_...() functions
> as bp is passed to a function not bp->sth.
>
> >  }
> >
> >  static u32
> > --
> > 2.47.0

