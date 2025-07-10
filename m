Return-Path: <netdev+bounces-205876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2FB009D8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1244E82D2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE22EF9C0;
	Thu, 10 Jul 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skur7NdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968222423A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168205; cv=none; b=RHWyUedxqfxivMA7itMEDkkgz9iQcKNiQfzlh4c8jjHOjOkf46iM+6rfEl1VoQCph8I3aaWPI3yhnSx38w00tGs4Ht7zC5e2g6Ra1Ew/SPdLqOI4dGrifHtwfrIs3c7/ciY5Knx9Xa/JV/RxEbQeqZJhRlUTSyRbXP/gC9Q1w+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168205; c=relaxed/simple;
	bh=Ma3dnBgFGkdiQFkF1QU1lRHU3qxv6KmZrVVUkMwPmuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/Hi7ZaMNJbsAp9GSgqkbOtBCx/Us+IqzfzbnxmPUr1j07/BF1UiY7Ux5Lvw+kN+3+LFT5RWs4a3a+xTTr7aNw5elMxhO3aN7RnzdiaVpzXXCMcvXtO4qbRf/VmkGZ7r3SPwHC+kvSHIiYxAFbhzT7d1YZfHwdfdX8B/nTbvl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Skur7NdY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so1072385f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752168202; x=1752773002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjaYJhQo97zlAsgdnLTz6VU7sE7grvBagflPK+Bvf3U=;
        b=Skur7NdYbuZab3eL2XQObqjrKHAT+OG/0j3rHl+vsCQF/snpmpDWhiTABL4DSRzAFv
         Gc6Sv9IhjlkvNNGLbKYOha7kjFpUarRaWvXwP9rLYc7k0/B2tf8+mV6zo2c2cZUXFPqj
         pDEOtqEwXQFYNpMUDCRm097Sc3VaRQq2CYTFix576OvjOo3oKAvhsnn1zuLtDzkRjATg
         8rPAkGyaeEANFA3DoKYaWX+Dfpa1uvsIqas/rnb/Sm89oEX9VBAHtyZIQ1odrBsdDstf
         T6bco7tRAwlYe3hrov5c+KCKQsVmgwTliQ6lF/LCyEv1py+WSWPYSVtJOV+ix06HngYD
         gPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168202; x=1752773002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjaYJhQo97zlAsgdnLTz6VU7sE7grvBagflPK+Bvf3U=;
        b=GsQTYaT7iootQHckK1uUQTObSat7drLJrtzDxqjsy266BQNjF/Q/oAfMx+p6JCRYYQ
         xPlbgkY+ADqwCBLyrIy9wJqCyAhvnHSaU4jPbVVViopDWy3s9Ep9+S44AxVdoeFQXcUu
         oqKSx3XRlUtkvPSGsI7xrFNrcpsdgfFagaBsQDFU7dvw5RASexcCDF/6UfzBNjiCjAlF
         umagxE45xvGSGNKAwkCw3txvOzTFkTHeUf7MAdJXugZoCak1jeqSpi5S7NIbGUD1lFBd
         6LbW28Nt1Aa2rlM6FTa7wJcsG3KXFlb6szTfbTOWWDid4+A/mna6bH/d+b6MC459byQe
         5mzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNHSTpxpfMCqnl8a2SjfG7VjdOmPMlOrHAEXQs30g2GHSYPW862cD3QFC2WA6fZevjzyuCx/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nZuku2djDNJMaHLLwNuDNowbOTLZUxq3r7/ZLw0VvmPhZaoG
	EuocjXy34Bsz5gNqOurOV/DQQWAW5xQ8Xzk6LoFfzOtt2zpigbNeABshEM9d+oXnaPGgmFygdQv
	s5tfoc87etWdnmb4PQpOQuvQP57eOV50=
X-Gm-Gg: ASbGncs66796hzkhGZ8xFctqpKLABtw3HerC1cwunaQDHzWIu9H5X9kW8hyzuHTSJOs
	9lpGsI8AfZETrPW0lAPJJsg2TI98MxBbIODXmFcCisZzamfqdC5jqTCsDuBjbiHIEUdoy3GWofy
	lutERRjsKtWjv3KbnhFIJ33a4sbGJp1G1aHMbbIOU/hslS+ktjw0OVU9gPZPteJHQrloywbnUtE
	sZCohamjs2cKAs=
X-Google-Smtp-Source: AGHT+IEu+HkIw9CSLs0pVX1jLbWRT46Ge70CrhiBUVn5KNAzcWtzFKi+VwSfSZN+zTYK7PdtObVYiekTnoTckdOuGzs=
X-Received: by 2002:a05:6000:2189:b0:3b5:db54:c68e with SMTP id
 ffacd0b85a97d-3b5f1856575mr290728f8f.9.1752168201554; Thu, 10 Jul 2025
 10:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk> <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home> <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
 <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk> <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
 <14b442ad-c0ab-4276-8491-c692f0b7c5c9@lunn.ch>
In-Reply-To: <14b442ad-c0ab-4276-8491-c692f0b7c5c9@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 10 Jul 2025 10:22:44 -0700
X-Gm-Features: Ac12FXz9bo120I-JZwka7UC6V495BdA_ttamriygIS8dIlAAOOEKkPfxXEQuA3s
Message-ID: <CAKgT0UfXRsVEgvJScapiXNWyqB8Yd07t5dgrKX82MRup78tXrw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add phylink_sfp_select_interface_speed()
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 9:11=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Settings for enp1s0:
> >         Supported ports: [  ]
> >         Supported link modes:   50000baseCR/Full
> >                                 100000baseCR2/Full
> >         Supported pause frame use: Symmetric Receive-only
> >         Supports auto-negotiation: No
> >         Supported FEC modes: RS
> >         Advertised link modes:  100000baseCR2/Full
> >         Advertised pause frame use: Symmetric Receive-only
> >         Advertised auto-negotiation: No
> >         Advertised FEC modes: RS
> >         Link partner advertised link modes:  100000baseCR2/Full
> >         Link partner advertised pause frame use: No
> >         Link partner advertised auto-negotiation: No
> >         Link partner advertised FEC modes: RS
>
> This all looks suspicious. If it does not support autoneg, how can it
> know what the link partner is advertising?
>
> If you look at what phylib does, for plain old 1G devices:
>
> genphy_read_status() calls genphy_read_lpa()
>
> genphy_read_lpa() then looks to see if autoneg is enabled, and if not
> it does linkmode_zero(phydev->lp_advertising).
>
> So it will not report any link partner information.
>
> What is wrong, that it is reporting LP information, or that it is
> reporting it does not support autoneg when in fact it is actually
> doing autoneg?

I have some debug code on here that is reporting the FW config as the
"LP Advertised". I had borrowed that approach from the phylink
fixedlink config as I thought it was a good way for me to know what
the FW was requesting without having to report it out to a log file.

