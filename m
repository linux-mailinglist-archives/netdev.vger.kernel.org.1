Return-Path: <netdev+bounces-48931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD37F00C8
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF182810AA
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809B19451;
	Sat, 18 Nov 2023 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="lkd1XLoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6041BE8
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 07:58:05 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50906f941so41635361fa.2
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700323084; x=1700927884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2EkBVgspkMYv5QxLZCvSB5wIue9VU/mFrUQVylTok0A=;
        b=lkd1XLocUlgLOK5+A4T7Wig8TPAi2qTEjHNbGxGuQ2y0oLtoboP+iEZ7eS172V3cFP
         nLxiC0W3c0FD2gQcZiy3a+Lbb5XHyH2OyRuYYBv5eahtKuGUyXaG2ApCfpY6jbNrhmEm
         fbMttVTlBau0IFG7kW3TnHQhrR8ABb+uvdswhpsAxhqOm3j0yrFShtPMJv6btafccTkP
         sruShAtwUVB0DWOdr3pD5tfl54H8xogXUpu0f+xqjC8FyE60QsCXus6VgNd05GEdmPka
         v0eSYSZRwBs5ost+gRwOBlhvhV4CcG+hHaH0dWZKZZ2wMsAm+lf0fEXbDiWxT/0Zgo5T
         onGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700323084; x=1700927884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EkBVgspkMYv5QxLZCvSB5wIue9VU/mFrUQVylTok0A=;
        b=FMiPsssuw0T6NxgFDPFdutGqP2kilMQgTs0elPahFFWDhgXDVidxkWcIg/+QMlbPQi
         RMwBrqHvwFVZKhXLC7rpZpmPxZ6QYyzP8fehsHuC0P4q6zOsSKK3chSyC7txJKqyT09w
         EvNgK7pLMvY6ZC0Vr+wZo94SbBSFCE1JjZ2o3fXPO0BEff6tJGCFRoENONPVhmXkgCup
         2NHdb1YwGh/ntW9ebB/zhgyUtJTUtCQXY/wZd1u1AyHFKd3ijtN5kpRowf4XgHbnczRp
         spj215JN68O14ZYauJcfx+EmMjP/NS5Fd8ZAPLsv+ZXbUzIqXABj46XlD8CQ5j+7g/uf
         DSkA==
X-Gm-Message-State: AOJu0YyFuWs73cfVva1HYOTmvdDVCiVT5U+EQQkRTmX8lYS6f3kLK50X
	1QV9hwHB0c89QPpvsYQRGpCjFC+Chy8shdCSF0LENw==
X-Google-Smtp-Source: AGHT+IG17Y+JgssSkZh3sxMOObt8MZzkEGw7pufoI+WSByyWRjb0Oy/4hXeYkB9571qKJOlmjDTogQ==
X-Received: by 2002:a2e:97c5:0:b0:2c6:f6cf:aaf6 with SMTP id m5-20020a2e97c5000000b002c6f6cfaaf6mr1912626ljj.46.1700323084088;
        Sat, 18 Nov 2023 07:58:04 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id q5-20020a2e9145000000b002b736576a10sm551135ljg.137.2023.11.18.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:58:03 -0800 (PST)
Date: Sat, 18 Nov 2023 16:58:02 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 5/5] net: ethernet: renesas: rcar_gen4_ptp: Break out
 to module
Message-ID: <ZVjfClFyO736qheC@oden.dyn.berto.se>
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-6-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdWd7gK3_p4mhkKS4VJUw6WCAHEw-pkQ8DBABq7=np+1Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWd7gK3_p4mhkKS4VJUw6WCAHEw-pkQ8DBABq7=np+1Vw@mail.gmail.com>

Hi Geert,

Thanks for your review.

On 2023-11-18 12:20:41 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> Thanks for your patch!
> 
> On Fri, Nov 17, 2023 at 5:45 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The Gen3 gPTP support will be shared between the existing Renesas
> 
> Gen4
> 
> > Ethernet Switch driver and the upcoming Renesas Ethernet-TSN driver. In
> > preparation for this break out the gPTP support to its own module.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> > --- a/drivers/net/ethernet/renesas/Kconfig
> > +++ b/drivers/net/ethernet/renesas/Kconfig
> > @@ -44,7 +44,17 @@ config RENESAS_ETHER_SWITCH
> >         select CRC32
> >         select MII
> >         select PHYLINK
> > +       select RENESAS_GEN4_PTP
> >         help
> >           Renesas Ethernet Switch device driver.
> >
> > +config RENESAS_GEN4_PTP
> > +       tristate "Renesas R-Car Gen4 gPTP support"
> > +       depends on ARCH_RENESAS || COMPILE_TEST
> 
> Perhaps
> 
>     tristate "Renesas R-Car Gen4 gPTP support" if COMPILE_TEST
> 
> ?
> 
> The driver is already auto-selected when needed.

Good idea, will do for v2.

> 
> > +       select CRC32
> > +       select MII
> > +       select PHYLIB
> > +       help
> > +         Renesas R-Car Gen4 gPTP device driver.
> > +
> >  endif # NET_VENDOR_RENESAS
> 
> > --- a/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
> > +++ b/drivers/net/ethernet/renesas/rcar_gen4_ptp.c
> 
> > @@ -186,3 +188,6 @@ struct rcar_gen4_ptp_private *rcar_gen4_ptp_alloc(struct platform_device *pdev)
> >
> >         return ptp;
> >  }
> > +EXPORT_SYMBOL_GPL(rcar_gen4_ptp_alloc);
> > +
> > +MODULE_LICENSE("GPL");
> 
> Please add the other MODULE_*() definitions,too.

Wops, checkpatch only complained about MODULE_LICENSE, will fix for v2.

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

