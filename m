Return-Path: <netdev+bounces-132826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002F9935E8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F931C23AF5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E71DD55C;
	Mon,  7 Oct 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="QHABp8vX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A513B58B
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325150; cv=none; b=HOCw9h3rHF2SM+k40ZTnfN+luo1/g7VYn/dzuxkOvJBJcup3EEnCPDsvKpzNJTJN+jxdD6PEyPq+0gXh7Vwj3O7Qtvsk5BWKpgUQspyj5PeQxtAddx7d8FGDVmJsxcMGC3NolpNObgGIKHcdg1Y/p9+Oej64zVh71KhiWC83Mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325150; c=relaxed/simple;
	bh=KA4IEftn0wVueic86aERIwPtkVUCq1IqHhVp0Xrm2dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8nR6m9iQmi0BvCUB921JoQ3qxl2sgtRifBYUAvtuh5a4Ya0SVTc1/K+zl8K2NBuwnh8EyeTJ/dxlYblOXg8wecWfwPLcKtCA9Nba/vSFlgOd3+I1UwXHVtXHqAadoVhfvNb68FexYUV0B/Y6eqhG22PSFm22NfRa43uHyM8Ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=QHABp8vX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28e9fba7c5so267561276.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1728325148; x=1728929948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA4IEftn0wVueic86aERIwPtkVUCq1IqHhVp0Xrm2dw=;
        b=QHABp8vXh7sMVgc1epssz8ZRTmuYFIZxdxm32ts2Y+VdszGjZQWiaMPpD7YreL9iEp
         AyVvR3O1+k77DEzc6QFglusA89nZx8VZgkI3iTJVIxGUCBU9cVJunqjEmQG6YR8aoput
         Fq7XmR0MfkB5a5bSyeO7YUeoTMLG3PGid+KPrOf+5hpxcz+LwRWRlZ7gXaPGhJiJyc9z
         lNGK6ifjNjbP7FGZxPV2TRgxv2Qe0Nkm1cc7BiRD+refDP9NKpscOVt306ANxORHIz/I
         0UbzCtHt1R4SNmNJIVAKXOtWTYDUe7tRnW1dt69Rx9Krhgr7fgJhYtjyr+0t1L/65ujD
         PrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325148; x=1728929948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA4IEftn0wVueic86aERIwPtkVUCq1IqHhVp0Xrm2dw=;
        b=UZTC8u9yzPadhavU2B3z3VzAvgphI0APMFkQ+sqzEpI32vea/i6TCBNJB1tw2jnkGm
         0bY43Qvw1jaArYSR2/D1+rQVVvYnT5dQUoi6qhYXXEuhUsvfpXlSYczHJLqWxoEW4ss0
         HJmFadFpjtCy6nSr5h1xdhNW26TRRku1O9/RgU9zefu29YREgZAGgVO5whDsSTTQZunh
         8waL68WOg+/fTncgsXK4IXM7joYyVCzvNpDc6L7pGZ6cYmpx6ok/Gpd18IzFxpHSJaiG
         Jo4Paz1SJ+4Gmqr/WNx44z640PXBnJIFZczj6PUbrWAEQ8XGKuTqmHcyGimIVY2r5ikC
         mcug==
X-Gm-Message-State: AOJu0YwBqfk78MxIdxLxRQj2UyQBICvvgXv8p3WS+spk2dohqzTrfk5v
	2Jbf5bjK6fcn3banKanX2IAd+uJZVnQAj/XUMQXcAJhFOBMh5Z6LTYajLgaLV89xRoodl8AbnS7
	81Py0634Xp+m08xvWJYyrqiZuwt1ANGBY/2uPBKzU5qwx+9O43r4=
X-Google-Smtp-Source: AGHT+IFy9c830cKGamc5aVVwVWiQOgnUfzTe3nfCKwNZRXavVNX1K+z4EV+wj6w30J9zQLto2ZPXDWSqfVJ/OUJWE/c=
X-Received: by 2002:a05:6902:1688:b0:e28:e605:2dd4 with SMTP id
 3f1490d57ef6-e28e6053b29mr1717573276.17.1728325148137; Mon, 07 Oct 2024
 11:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
 <c572529e-78c4-42d5-a799-1027fd5fca29@gmail.com>
In-Reply-To: <c572529e-78c4-42d5-a799-1027fd5fca29@gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 7 Oct 2024 11:18:56 -0700
Message-ID: <CAJ+vNU3qCKzsK2XFj6Gj0vr4JfE=URYadWsr3xvxOO__MVNsPw@mail.gmail.com>
Subject: Re: Linux network PHY initial configuration for ports not 'up'
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 10:28=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 10/7/24 09:48, Tim Harvey wrote:
> > Greetings,
> >
> > What is the policy for configuration of network PHY's for ports that
> > are not brought 'up'?
> >
> > I work with boards with several PHY's that have invalid link
> > configuration which does not get fixed until the port is brought up.
> > One could argue that this is fine because the port isn't up but in the
> > case of LED misconfiguration people wonder why the LED's are not
> > configured properly until the port is brought up (or they wonder why
> > LEDs are ilumnated at all for a port that isn't up). Another example
> > would be a PHY with EEE errata where EEE should be disabled but this
> > doesn't happen utnil the port is brought up yet while the port is
> > 'down' a link with EEE is still established at the PHY level with a
> > link partner. One could also point out that power is being used to
> > link PHY's that should not even be linked.
> >
> > In other words, should a MAC driver somehow trigger a PHY to get
> > initialized (as in fixups and allowing a physical link) even if the
> > MAC port is not up? If so, how is this done currently?
>
> There are drivers that have historically brought up Ethernet PHYs in the
> MAC's probe routine. This is fine in premise, and you get a bit of speed
> up because by the time the network interface is opened by user-space you
> have usually finished auto-negotiation. This does mean that usually the
> PHY is already in the UP state.

Hi Florian,

Can you point me to an example of a driver that does 'not' do this? I
can not find an example where the PHY isn't UP regardless of the MAC
state (maybe I'm biased due to the boards I've been working with most
in the last couple of years) but then again its not because the MAC
driver brought the PHY up, its because it doesn't take it down and it
was up on power-up.

Some examples that I just looked at where if your OS does not bring up
the MAC the PHY is still UP
- imx8m FEC with DP83867 PHY
- KSZ9897S (ksz9447) switch/phy

>
> The caveat with that approach is that it does not conserve power, and it
> assumes that the network device will end-up being used shortly
> thereafter, which is not a given.

agreed... it seems wrong from a power perspective to have those PHY's
up. I recall not to many years ago when a Gbit PHY link cost 1W... and
I think we are currently way worse than that for a 10Gbps PHY link.

Then again think of the case where you have a switch with ports
unconfigured yet connected to a partner and all the LED's are lit up
(giving the impression visually that the ports are up).

>
> For LEDs, I would argue that if you care about having some sensible
> feedback, the place where this belongs is the boot loader, because you
> can address any kernel short comings there: lack of a kernel driver for
> said PHY/MAC, network never being brought up, etc.

I agree that boot firmware can and perhaps should do this but often
the PHY config that is done in the boot loader gets undone in the
Linux PHY driver if the reset pin is exposed to the Linux or in some
cases by soft reset done in the Linux PHY driver, or in other cases
blatant re-configuration of LED's in the Linux PHY driver without
using DT properties (intel-xway.c does this).

>
> For errata like EEE, it seems fine to address that at link up time.

one would think that makes sense as well but the case I just ran into
was where a KSZ9897S switch had a network cable to a link partner and
the link partner would 'flap' with its link giong up and down due to
EEE errata until the KSZ9897S port was brought up which disabled EEE.
In this specific case EEE could have been disabled in U-Boot but that
would also require some changes as U-Boot does the same thing as Linux
currently - it only configures PHY's that are active.

Best Regards,

Tim

