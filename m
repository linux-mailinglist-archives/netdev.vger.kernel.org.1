Return-Path: <netdev+bounces-124138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020E968421
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A05B220F9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53E13C9C0;
	Mon,  2 Sep 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyXOgv6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528E13AD18;
	Mon,  2 Sep 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271697; cv=none; b=kivnVY0W5VAkOmfYLeiEak8qgn/EhsTfezv67zvarAgirgAW3cqtS7R6KwMrBi2iBueNgcEyjR/lqRU/Mxc+El1moQ5QvwOCRRuQZ1o+1TDOer6R7Q3Dt6+whk9KgX3OI4Lk6TcC4eSrU7hB8LoBtjzvAMZxXqci50s8rHI0jCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271697; c=relaxed/simple;
	bh=ihEUNzFDj1e5AgDwk+GFehGPR9gGmkrh9xrFlidV7cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlHjtOxBJtPKbXWZnSGhN0bORxnIryI4CO0UGO2PeecqAMgfgZTX/FMvwHz/S0nc93SU/gERlBF1NGsuiNOwUXFB4RWVSpNh4Xe9hKDbP1xsbzIjsMNx5Nw6mw/32fiTpfdkSn7NJfFmr/qc5bVGYVR3Mnaj2tqUSgeVj8tHwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyXOgv6T; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5df96759e37so2717160eaf.2;
        Mon, 02 Sep 2024 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725271695; x=1725876495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5X/Tccx+Tn+6km/NHSvsrb4pi+NObw5RhahAjS2Mo0=;
        b=gyXOgv6TLMEN4+ULsUMZDBSgInGhggRO7anR3jBybDKsdRgAayE8MG02AismQuc4EL
         XES8KKDeIx49AGxcpLT03fzaDo6WwfDwXPqgPJuebTbqcXKEVehVyxmfUof1LRJm8PcH
         WuXA+6q57ZBbrNOT8FLrv7ByqGOyRQR3FOwq1QClQLzNb/eAFGaMpVr+OZ8Pc2nAclYz
         paWB4QluXS3Fv+BJfeRPaCNbKOTFoqqcRhgC3FyIcuLnV8d3LRIrpDxO/a2+mlNII7Kk
         5AZB223itTFLGOgBbHtg0gKqEK5ge/BlbAUk+eyx0p8EYSC3QgkcHITQfUjnNXuQ+gYg
         R6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271695; x=1725876495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5X/Tccx+Tn+6km/NHSvsrb4pi+NObw5RhahAjS2Mo0=;
        b=OkNycC/fhICYYGKsmt0XTjRxQvYxVjXghZ+FwuEpsr/NvueNJbvIb1uIOhfQe2tF2Y
         rdnhQyA+aD9y+4Nfnwn7YEDYL7s6jrPjsaqQDcIrFiQUuBPDQ/RIsbiKflK/ksDg3HxE
         5evVuE4MgNvliunjBZEwVm5TXhS+gWnHRR85qkxt+ucC1JAFT+iQI9iyCDHqx5buE6cT
         1pVAM69VHaXA8taB/oE2seMW4pCjlAUWWHyElqzhrO4svYcmNOt43b510bFyegLM4vgK
         dL1uW1Sh6hHqpZi8Dy1QhsOpcVKuZEYPXCB8BbLizYGiGO0m/UeF41EFEPbROmmMdisQ
         6ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCV/02QpnNDM73gm/OEb8oVXLCjSZf3yJTjEqQZp0kf0Itu2cd92kbUkY6vU3Q2X8uk3AG7l0QqGWe5J9vI=@vger.kernel.org, AJvYcCWii59mWgpd4dFYyTDPcC6eZh5jXD+zAh5TVuJLBj5b5mjjeJW8S92dMuqM0vL++CI8Wrl5LZ78@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOOiRkJuqNfsTjtuAwyYPCrn/0GKY+5HMqoWgEDp+3+/Cv11w
	7CS4bUeA097gmeFi9tirTTjdgQy6PjoYZKMJxNxdtPoo7wKrYWGpryK/DLei+YSdT+Hdq51WcFO
	DZl00Bec+QNFwLZ2MdgL1Id0WrYQ=
X-Google-Smtp-Source: AGHT+IGlky3ih60Exkp5+gqA7t4QCsIHBh2L2dQ6BoccHpsVmKeHV+qleuRG2cp+kGXk95CiIo1pqqp1YgZTiJbXPkQ=
X-Received: by 2002:a05:6870:a10f:b0:25e:c013:a7fb with SMTP id
 586e51a60fabf-2779031b4cfmr15210114fac.43.1725271695097; Mon, 02 Sep 2024
 03:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830141250.30425-1-vtpieter@gmail.com> <20240830141250.30425-2-vtpieter@gmail.com>
 <89aa2ceed7e14f3498b51f2d76f19132e0d77d35.camel@microchip.com>
In-Reply-To: <89aa2ceed7e14f3498b51f2d76f19132e0d77d35.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 2 Sep 2024 12:08:03 +0200
Message-ID: <CAHvy4ApAq6dvvAJhU9LSvxRD7eH76vL5KycVk-tg85tVWZ5gvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: dsa: microchip: rename ksz8 series files
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	linux@armlinux.org.uk, Woojung.Huh@microchip.com, f.fainelli@gmail.com, 
	kuba@kernel.org, UNGLinuxDriver@microchip.com, edumazet@google.com, 
	pabeni@redhat.com, o.rempel@pengutronix.de, pieter.van.trappen@cern.ch, 
	Tristram.Ha@microchip.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arun,

> > -         This driver adds support for Microchip KSZ9477 series
> > switch and
> > -         KSZ8795/KSZ88x3 switch chips.
> > +         This driver adds support for Microchip KSZ9477 series,
> > +         LAN937X series and KSZ8 series switch chips, being
> > +         KSZ9477/9896/9897/9893/9563/9567,
>
> You missed KSZ8567 and KSZ8563. Also it could be in order as suggested
> by Tristram,
> -  KSZ8863/8873, KSZ8895/8864, KSZ8794/8795/8765
> -  KSZ9477/9897/9896/9567/8567
> -  KSZ9893/9563/8563
> -  LAN9370/9371/9372/9373/9374

OK will do.

> > + * It supports the following switches:
> > + * - KSZ8863, KSZ8873 aka KSZ88X3
> > + * - KSZ8895, KSZ8864 aka KSZ8895 family
>
> You can remove 'family' here, so as to be consistent.

Well I'd rather keep it so it's consistent with the ksz_common.h
ksz_is_8895_family(), do you agree?

> > + * - KSZ8794, KSZ8795, KSZ8765 aka KSZ87XX
> > + * Note that it does NOT support:
> > + * - KSZ8563, KSZ8567 - see KSZ9477 driver
> >   *
> >   * Copyright (C) 2017 Microchip Technology Inc.
> >   *     Tristram Ha <Tristram.Ha@microchip.com>
> > @@ -23,7 +30,7 @@
> >  #include <linux/phylink.h>
> >

Cheers, Pieter

