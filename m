Return-Path: <netdev+bounces-115050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3384944FA3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF4B23E83
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4FA13D2AF;
	Thu,  1 Aug 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PArTGbI/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B719478;
	Thu,  1 Aug 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527349; cv=none; b=W/wMH+Pzu3PXxa1lIkolbgd/f9hCWNSjVU1zayGjmYGyiDaEDQhYNq6YQPfxgi4wKims6r7e3xdn/AiUGMngjr55mbmn7mAoBBAyTiuqCCMqfIhcGSGc6Ds0MvsI/XZTe2Nv9/J+X5LIO6fVrddCBsV8cK8iMT1yc2XetPSpcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527349; c=relaxed/simple;
	bh=nKlAaSFE+fmPAfHTs1O+o85Jcq+2pHAXogZG4LGZs7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mj6ze1/m2zWQAi2BzUihiv3mz8gC5HG5zkDY00eNBJc03+g81dt7me9PIDUxKqArRNi1ucSEV8q6kJAFyPonHYCjScSYoBzmgu87tORbg2QWf629YZ8yfj5QvnrJaxbfEQC+kKoKyeGbQP3kMxZQ+azNugNmy/luUDXFQWfeLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PArTGbI/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260f863108fso4254091fac.1;
        Thu, 01 Aug 2024 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722527346; x=1723132146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vrM3I08KeD9LyJzc0AY/Lrr8WEZiRdSbJCEvBssBw/Q=;
        b=PArTGbI/ArcfczSXegzfdra6jPx/u/pHWfqldh5+YV51hkFbuRiSa1arFjYN7rYkFw
         XG06ROZaZUhl2ld5YMG0ZJTJZzVyn3CjXN7Fb9zxaDStXlCT4CX1hg2pQcMCZRXQoOnB
         DzaP7OyLMV5BS9W4maeCE+axxph6030noYfgQ3a0HXQjoZz1XCVDB0zxLw1m8eiEU1Cu
         wdXoE7TlH23XGPULS8XbtjS8iZ/TIn7RU8QLJSL6w+sv8GUsiDevlubAE+3aG/so8QGD
         DQQ7ByT/2uNpBR1/BFibSv6v3HKjTNkmROuhC4vvCBRL2uiDPO6Zi435m88WFJJ2aBB1
         /TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527346; x=1723132146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrM3I08KeD9LyJzc0AY/Lrr8WEZiRdSbJCEvBssBw/Q=;
        b=Ygt1rA41PvtEel/R4ubkQU93mdh6vlkJjyzUvRDTVFEsOxwXWBwQGPs1hEvkcRjkKx
         abkNmEhC96m0Ij1tOoFWJDV1K1+Hk3FoQN6dSmziOJU341oDQkkMEsIKDCESLmJsP5+w
         fPQlBqqrhHhV1twBrMjkHnSRbsq16LVIDmr/QtdAs9r3j8VHoGi0FQHnyygMkd5fjj7h
         ru9XmRRERq1v5Yv6ES4BePhGuyxBkokgXkWq7uOi9lkwl4TUuqDdNNofVHfhOuZ4VBlu
         4T21tsTENveAY1qUoZ9sJDoJmEfKP3m3ELaymloN+KoVfe8E/dzKpzbvfW5+lJYTnplr
         H0pw==
X-Forwarded-Encrypted: i=1; AJvYcCXVga1nQbo6LwX4zsRW9DHcx7VVlHgFBOygZbNniJyaXJnv+DD4meGvT1f3q/lhyfmakkKqSJ12bJCuCQnFbwXsPAIXt9EM
X-Gm-Message-State: AOJu0YzEfKqip2nHAe1RInCAsYRXUNPWKKMtj1fqI0XowCGTkxBqLrt2
	S54xazZv5sLeq+/mUGGlKG2vpV3D4Fqt1quTEMyEX2Rxz7RXVAwlz2YvhJzprhe09rws/LJ7fqv
	yLnXZmM8Yr/WZzzXbrWr2LexrfPI=
X-Google-Smtp-Source: AGHT+IE4a/ab2ipgCtKLDQdF1uoLyP1fr48PFJM601wjm1wNf9gdc1LSocrjfhcAQXO7Dyx+GIaFmFQOjGKx9HHflQE=
X-Received: by 2002:a05:6870:a54a:b0:24f:dd11:4486 with SMTP id
 586e51a60fabf-26891e92ab4mr587892fac.36.1722527346628; Thu, 01 Aug 2024
 08:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731103403.407818-1-vtpieter@gmail.com> <20240731103403.407818-4-vtpieter@gmail.com>
 <925034c0e0714fce5859d829fdb0ad6cd82f71d7.camel@microchip.com>
In-Reply-To: <925034c0e0714fce5859d829fdb0ad6cd82f71d7.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 1 Aug 2024 17:48:55 +0200
Message-ID: <CAHvy4AqyHUvm-0oAt88uxPazbpKvKO36goqpW2kyDoeyicxOjw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] net: dsa: microchip: generalize KSZ9477
 WoL functions at ksz_common
To: Arun.Ramadoss@microchip.com
Cc: devicetree@vger.kernel.org, Woojung.Huh@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pieter.van.trappen@cern.ch
Content-Type: text/plain; charset="UTF-8"

Hi Arun,

> > @@ -1051,12 +1052,12 @@ void ksz9477_port_setup(struct ksz_device
> > *dev, int port, bool cpu_port)
> >         ksz9477_port_acl_init(dev, port);
> >
> >         /* clear pending wake flags */
> > -       ksz9477_handle_wake_reason(dev, port);
> > +       ksz_handle_wake_reason(dev, port);
> >
> >         /* Disable all WoL options by default. Otherwise
> >          * ksz_switch_macaddr_get/put logic will not work properly.
> >          */
> > -       ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, 0);
> > +       ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
>
> check the return value.

Thanks but since it's a void function, I cannot pass a non-zero return value
so is there a point checking it?

>
> >  }
> >
> >  void ksz9477_config_cpu_port(struct dsa_switch *ds)
> > @@ -1153,6 +1154,7 @@ int ksz9477_enable_stp_addr(struct ksz_device
> > *dev)
> >  int ksz9477_setup(struct dsa_switch *ds)
> >  {
> >         struct ksz_device *dev = ds->priv;
> > +       const u16 *regs = dev->info->regs;
> >         int ret = 0;
> >
> >         ds->mtu_enforcement_ingress = true;
> > @@ -1183,11 +1185,11 @@ int ksz9477_setup(struct dsa_switch *ds)
> >         /* enable global MIB counter freeze function */
> >         ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
> >
> > -       /* Make sure PME (WoL) is not enabled. If requested, it will
> > be
> > -        * enabled by ksz9477_wol_pre_shutdown(). Otherwise, some
> > PMICs do not
> > -        * like PME events changes before shutdown.
> > +       /* Make sure PME (WoL) is not enabled. If requested, it will
> > +        * be enabled by ksz_wol_pre_shutdown(). Otherwise, some
> > PMICs
> > +        * do not like PME events changes before shutdown.
> >          */
> > -       ksz_write8(dev, REG_SW_PME_CTRL, 0);
> > +       ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
>
> here also.

Thanks will do.

Cheers, Pieter

