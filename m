Return-Path: <netdev+bounces-48930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C10C7F00C7
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA986281084
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021318C0A;
	Sat, 18 Nov 2023 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="wWvKEV/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31F3AA3
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 07:56:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a55302e0so4368685e87.0
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700322996; x=1700927796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpdSmYEMTKgajsmyK7SUPIe652up0wMdUCzgc0Fx6lI=;
        b=wWvKEV/kpw4xOY/FwpY+douIb76wRjTPBr3NvNkx0LSd2B/qKhTknIc7+TY7jmudeF
         T5qtLGaMFDPcbNUKATRY6eETw+nrE6T770XYvF5uL8dJmrw38+EMG27DFqEA/ye3GoP6
         Fjsc4YM7kr9f1UaNBZOqE5Q5V7jMc0DaVSkYIeJdWulWtZND2MtCNw58oss5HGBQ/dRx
         XyRCbKopazH+1G2lCHWV+SMLc9PlaxuR+8ro8Q/Om4TvLUsetfql8eRxnkJ+8c1Arazh
         lFfK8pu3YHj2+IYwgLuQUK6WVgbt6vujuNCO/7xlVw9HooyYdeZq6GSiAM/19/qWP3Lj
         UKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322996; x=1700927796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpdSmYEMTKgajsmyK7SUPIe652up0wMdUCzgc0Fx6lI=;
        b=nbtWybYu/Vv0/m5cduWxCbH9cSJUAuj6Vg4dfjAyCk0EvRCN4uwURdv0Iq8jInBc3w
         kBIZ0OLmIhj5GDGHTDU27FJTX3juWdfcqFBKq4+KJofuXGDKQXZ1Ml3gfYIEIRsQp2wI
         Ci+haGh4ZOF49CRWZFh2zWjaCp/UiuSkfisLxMGu5Eeo2Z3LaA+JRHWJaw6af1a1Zha9
         UxdAkRcoW4ew91o+Ro2XcNUSIQc2a3/SxRmdtrb9auAUMYKG2MpxEcBtDGMYx9t+yk8R
         DZyOtSACLCtIXkEo+CHnu02QN/qrYZcuNoEE5FN5qyef1UyLr5y9Lp0kNu4JCTJ0BQ/O
         TU9Q==
X-Gm-Message-State: AOJu0YwM1PDyZwE35CoXsWZE30z//MWCqUDuNfvELMpB7CPRObAzEOeO
	h5x5QQuXFKVlq2aCgRqWkwDLxA==
X-Google-Smtp-Source: AGHT+IHTLvDB6i+cykEOLGjCyuaIyaJJhQ02NctNes08KtX5IFACA+1B7XtWGorJi/ViwTgoTCMvfg==
X-Received: by 2002:ac2:4951:0:b0:503:3808:389a with SMTP id o17-20020ac24951000000b005033808389amr2125556lfi.11.1700322996114;
        Sat, 18 Nov 2023 07:56:36 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id g7-20020a0565123b8700b00509131de510sm608346lfv.151.2023.11.18.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:56:35 -0800 (PST)
Date: Sat, 18 Nov 2023 16:56:34 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 4/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H
 clock setting
Message-ID: <ZVjest6pUoM2b9mO@oden.dyn.berto.se>
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdW8L9BxPUkBf-pNrACqAyFcEcczOBEaOqwwgHpisZ_e5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW8L9BxPUkBf-pNrACqAyFcEcczOBEaOqwwgHpisZ_e5g@mail.gmail.com>

Hi Geert,

Thanks for your review.

On 2023-11-18 12:16:51 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Fri, Nov 17, 2023 at 5:45 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The gPTP clock is different between R-Car S4 and R-Car V4H. In
> > preparation of adding R-Car V4H support define the clock setting.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks for your patch!
> 
> > --- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
> > +++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.h
> > @@ -9,8 +9,12 @@
> >
> >  #include <linux/ptp_clock_kernel.h>
> >
> > -#define PTPTIVC_INIT                   0x19000000      /* 320MHz */
> > -#define RCAR_GEN4_PTP_CLOCK_S4         PTPTIVC_INIT
> > +#define PTPTIVC_INIT_200MHZ            0x28000000      /* 200MHz */
> > +#define PTPTIVC_INIT_320MHZ            0x19000000      /* 320MHz */
> > +
> > +#define RCAR_GEN4_PTP_CLOCK_S4         PTPTIVC_INIT_320MHZ
> > +#define RCAR_GEN4_PTP_CLOCK_V4H                PTPTIVC_INIT_200MHZ
> 
> I think the gPTP Timer Increment Value Configuration value should be
> calculated from the module clock rate instead (rsw2 runs at 320 MHz
> on R-Car S4, S0D4_HSC and tsn run at 200 MHz on R-Car V4H).

This is a great idea, I will do so for v2.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kind Regards,
Niklas Söderlund

