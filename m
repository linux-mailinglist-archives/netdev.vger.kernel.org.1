Return-Path: <netdev+bounces-127297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF54974E67
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EE31C216B6
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818A14EC59;
	Wed, 11 Sep 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoA3XYGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF65339F
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046444; cv=none; b=mZa07qe32ylqP8uCXmNwi2eWvzU9XvPApMmF3M/YB84BITDDy9wTBLbzsQVNzt1FOhTR3LU45tWH2E5obeXQqbJ1MQ1MuupAU+/QNTJJ2p6GKrrXC3fScYVb6++Pr70AS138n3b5AEnKB72Jm0BPpYcbuFMiwIGYGv+aJJKakW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046444; c=relaxed/simple;
	bh=llbHvM2NSh1y9Ktj1BqB84u7m73YqVAzvlKA403MUSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTR5alY20s8BXeciwkSS7EKUEvmJB2FlQojPxbHW/RKesZwtljlDgFjmfFiJaUgC2f5lib8U2DzebGC63eh0Gg4kkGAgNVjDAdfjRAp7YuRv9Pa+DXhbi5cZKtBlFr3v0PndaRHl5xOfn+NtXFvrnnEG0HjJgEr8zSR8xdamFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoA3XYGQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53659867cbdso8574641e87.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726046441; x=1726651241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llbHvM2NSh1y9Ktj1BqB84u7m73YqVAzvlKA403MUSs=;
        b=EoA3XYGQoUzq6UBlaZg/vUeRaVVz32ALIMyUCn/kDhEMhJud/hQOh6/uT950heDPHt
         wfuKeGSQmEoUHHWmq9Ezvk86/6xqQCqtHP1fF7pjB2lK7mrO2bqJHPGGueWq+hStiTRM
         gHAJaMpVt1oKVSltp6MozltsGIszBDXRYSD8lnNX/AwfraU5DEOW1uZXRcxivTSirZcv
         1MteqQcgWQ0YpQISI0C8GlOcdDDHrmwkdjCe7MYIl91ik6OPvNpnV3zRbkuLy2Zw96aA
         uUgDjuaV7cIluDXGBSul9lyrCufYWCVI7bT/1nXVnuDlCOrOXk6TJ2CtViewkgh9XCGz
         eq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046441; x=1726651241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llbHvM2NSh1y9Ktj1BqB84u7m73YqVAzvlKA403MUSs=;
        b=IcS8btLqRTNlMDBdJPUbq1q5XOzPOp/C7VKKy9XxAyWKy6+VWlqQMvDBigbXdhaKCj
         X+3gP0k92RoRaU3NRESwkByCJObRoVw6EyiR+a8aAk5TE6M8i8OfPbQ+WuFwoCa6fTee
         0ug+Bpjj6r2xDtEyff+50T7fOqKxXLIT5EqXaoYiIbd5VCAI8zmYa70nbZl7qc2iUAHQ
         INTwl5EOkExToAa2fbmFuxWEJP9Ke88L88HPlPYPMu5rvykS0nXw/l+3qXjDiWlkVpdG
         38UKHy5gf54JpfLDfM2pUkPAy1pByInQmxFB3cNql4BXRbHlzcwXWgVbMV2owNlreM+w
         2aMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVehLB/xuLXv7RnWyoICBZJfWpXDhmuSnzimTTJRlVV1h+EFh5Hb8n7cIL/411pvSrYnW05zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxppCXCV8PUrMzi/lmkHO64Havnet07+iddm0IZxzrDfQ9CFWO3
	WaRA5XYQuOWe5p9sipB5Gn/a8GWa+r+2NcjLU63vayTcYMo9FPqfdFh6wQwncopmzOdj0cYhGyR
	gdFV1cBIeyBR1I8Or3k+lxf1K6u3CDeCp4wrz
X-Google-Smtp-Source: AGHT+IGLDjUNO1VR1Yljd5LCgc0RmDQJRXz4f3BqsbUQD+9Uc9X/sCaJ33fwYmRs04iln/kcXAKuf8+0IQ+O/NHhl9w=
X-Received: by 2002:a05:6512:1245:b0:536:54bd:8374 with SMTP id
 2adb3069b0e04-53658818949mr10161474e87.60.1726046440484; Wed, 11 Sep 2024
 02:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
 <CANn89iKxDzbpMD6qV6YpuNM4Eq9EuUUmrms+7DKpuSUPv8ti-Q@mail.gmail.com>
 <20240911103322.20b7ff57@fedora.home> <20240911103744.251b0246@fedora.home>
In-Reply-To: <20240911103744.251b0246@fedora.home>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 11:20:29 +0200
Message-ID: <CANn89iKCj086chL-1fCR62H1Aq3qJ9MWsBapr=za8VSB4uPq2g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn field
 for GET commands
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	=?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, 
	Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:37=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 11 Sep 2024 10:33:22 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
>
>
> > Sorry for asking that, but I missed the report from this current patch,
> > as well as the one you're referring to. I've looked-up the netdev
> > archive and the syzbot web interface [1] and found no reports for both
> > issues. I am clearly not looking at the right place, and/or I probably
> > need to open my eyes a bit more.
>
> Heh my bad, I just received the report in question. Looks like you are
> getting these before I do :)

I triage the reports, to avoid flooding mailing list with duplicates,
and possibly catch very serious security bugs.

I usually wait for some consistent signal like a repro, so that a
single email is sent to the list.

