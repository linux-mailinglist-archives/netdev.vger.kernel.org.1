Return-Path: <netdev+bounces-203072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1C1AF0764
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B9117EAA5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35893E555;
	Wed,  2 Jul 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvFYw2uV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61B81E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417267; cv=none; b=XxwxygtTRQx9dTAqHnNiPmHjHcxWMQ5pucvIuAyx1xbFf/4m9Ws4UFGtOn1GoVkdDT34F7Kyp8dt7rniRE8UmAfYdeOjJbqDFEvrOSPbs72pkPFR12Y9Q8dus3VkeHuVwobMvnPhG32/XWnY4gkHoR4tM52MwLM6pEPVrH78IB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417267; c=relaxed/simple;
	bh=tLOumMRfugGO2Mj4vO6D5R/mcZ0aE8fkVURB6rnuFkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDWHPy6PXEzKEUgBsOe5Y66StN/fU4BzQzPmrmje+HxUIZgqEEszW/7nUPAJnFHKTXtFpFP1FHiEyVaRPxqfr76LPQcsb4UA2TctCHHO3eSF3dwCSIE4d0kqtOdurFm8j1WgDtVBelByZ/dw1PDurpMINlI5H/qNWa47uIUf7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvFYw2uV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86d0168616aso349368139f.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 17:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751417265; x=1752022065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDfz6DP2mOskolyPQKeZzzS8BoJt+DlpnpcW6eMwqBg=;
        b=QvFYw2uVxMXmgliB0pjcpdtMAJYU0k2ND1W7EAofa0CddcEksVuxFIvvBmttTWP/WG
         ISDkrKt8/M94SmaNGrEPsFXgVZl7QBUXEm/Yd1IEdbo+xZMagfjnT5WJlV5xfNOGlhBb
         m9DkCATC6md8gmcqjx/ozJw8WuSoajFdm70lHgQAbjm/CbBmAW26sxJ1WQWdAWlA4YWC
         UuhcZBu5LdmJ2SF2PexczOvxh9KcIgJ65O4XfrBvMrMwBhOvPhGDYMRfWlEPx0Nol6Qh
         Bvmxbs7OXziXLu8yolHIHcOr8NKClx7KTzebPLGOCY+O63Qjvv2wW/Al7VTA1SxGCZjw
         J6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751417265; x=1752022065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDfz6DP2mOskolyPQKeZzzS8BoJt+DlpnpcW6eMwqBg=;
        b=FUZthWxV4VsM0Lctd7hHlRZtU0+SsTF853d4wFgWXwB9SU4LSP2m2dpb1mb+VYHDQv
         3HuZftEsGa4xTY5yJjgD+7Nzd8n4NQm+pbdwHycmM2sJuya9Bc4IrbOHp3PFan/fIyXJ
         LJhdOKRBHZ4SJtYTOdWlqCFEogiDXC9/MjW1ae08K57rKFQa+02HD6VspEZCiQ4iaYrw
         AJQMQV/shANwS7zjjUBpl2x8VlxX2VXxhhLMdYtzINIrHU5VwqjiIhfdrZyp6lOQSmwn
         4YTQibKS/2pqILG9r4WC3dYYeUKn8hCdu/M+d+IfOSilepZtU+hYdFoqJujd3ED2oKc/
         252A==
X-Forwarded-Encrypted: i=1; AJvYcCWI/qpV0GKqDC9qtHY8oCC2LLbCMzkpDEfBpuQnQDbXgI5qJrqIzlnI9enl+IVvhaWMYnkHMA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QBYlXl2mlUnA+oTuApLXISC9MJnRUOw4UlHAbNR4HNq8EmVB
	uRtHwtqeBt/NpwIp7/8Nj7oqvx7TGTZp8/y0zVb3m1RlttorpkZXCgcs6fjKue36JHIDs/j0g4i
	+gOofK+tqxnRDpgsMurZf/mF3FVBhKAM=
X-Gm-Gg: ASbGnctvmeau0qtCBmYH6Vyem+c+VyJysrBvKp0d9Y852XiCAiHeCbWPBgQI901rhA1
	QW4DL4t0JhTNa0Pq3BGnExCfO4T6WylLxgc7RDvOaQOuinL+VChjmMGxDE+u5NXWURMEKnGYB7d
	7q8vMkah8TF1Hek4yfWApF7WCXwTZCcA3STTtCPKu/TUXEYXeypTxA
X-Google-Smtp-Source: AGHT+IHQ/txYxOv2mldJzFC7caKVnNyTELIQGyRkuVtv/vYItgmPUF0MC6n+1Nxwg8U3CKmg15OLqGTMscBbcVjPEYc=
X-Received: by 2002:a05:6e02:12e2:b0:3da:71c7:5c7f with SMTP id
 e9e14a558f8ab-3e054a09dd8mr11833605ab.15.1751417264623; Tue, 01 Jul 2025
 17:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
 <20250630110953.GD41770@horms.kernel.org> <CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
 <20250701171501.32e77315@kernel.org>
In-Reply-To: <20250701171501.32e77315@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Jul 2025 08:47:08 +0800
X-Gm-Features: Ac12FXxDf9fiEFnCKxHJ2hGMMcOGSHsksJmowHiHU49mjPgHuFDFg0dntNfs1Wo
Message-ID: <CAL+tcoAfV+P3579_uM4mikMkNK4L2dMx0EuXNnTeLwZ3-7Po2Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 8:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 30 Jun 2025 19:47:47 +0800 Jason Xing wrote:
> > > Not for net, but it would be nice to factor the #ifdefs out of this
> > > function entirely.  E.g. by using a helper to perform that part of th=
e
> > > initialisation.
> >
> > Got it. I will cook a patch after this patch is landed on the net-next =
branch.
>
> Maybe we can fix it right already. The compiler should not complain if
> it sees the read:
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index f621a5bab1ea..6bbe875132b0 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11616,11 +11616,9 @@ static void bnxt_free_irq(struct bnxt *bp)
>
>  static int bnxt_request_irq(struct bnxt *bp)
>  {
> +       struct cpu_rmap *rmap =3D NULL;
>         int i, j, rc =3D 0;
>         unsigned long flags =3D 0;
> -#ifdef CONFIG_RFS_ACCEL
> -       struct cpu_rmap *rmap;
> -#endif

Sorry, Jakub. I failed to see the positive point of this kind of
change comparatively.

>
>         rc =3D bnxt_setup_int_mode(bp);
>         if (rc) {

Probably in this position, you expect 'rmap =3D bp->dev->rx_cpu_rmap;'
to stay there even when CONFIG_RFS_ACCEL is off?

The report says it's 'j' that causes the complaint.

Thanks,
Jason

> @@ -11641,15 +11639,15 @@ static int bnxt_request_irq(struct bnxt *bp)
>                 int map_idx =3D bnxt_cp_num_to_irq_num(bp, i);
>                 struct bnxt_irq *irq =3D &bp->irq_tbl[map_idx];
>
> -#ifdef CONFIG_RFS_ACCEL
> -               if (rmap && bp->bnapi[i]->rx_ring) {
> +               if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
> +                   rmap && bp->bnapi[i]->rx_ring) {
>                         rc =3D irq_cpu_rmap_add(rmap, irq->vector);
>                         if (rc)
>                                 netdev_warn(bp->dev, "failed adding irq r=
map for ring %d\n",
>                                             j);
>                         j++;
>                 }
> -#endif
> +
>                 rc =3D request_irq(irq->vector, irq->handler, flags, irq-=
>name,
>                                  bp->bnapi[i]);
>                 if (rc)
> --
> pw-bot: cr

