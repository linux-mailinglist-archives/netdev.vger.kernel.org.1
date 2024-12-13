Return-Path: <netdev+bounces-151880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7E9F1725
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E028C188C3DF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107621F12E0;
	Fri, 13 Dec 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Aw4oxx8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39499190471
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120087; cv=none; b=BMukXCH5tLAPF0vevhSTMakzB4CxhMlYSwVuRl0cLusJuqhw2GLUsAg5KqUOB29Yk7fu5aar9gVgO71lt8Uhe73LwUsOj0Y6MkKC8Y2ve2bZs+3wChRBLM2SOVXrAMc1B2GLIRbTmvzmP9XqCYCJX4krVyqqhwGse1Lyrtdl7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120087; c=relaxed/simple;
	bh=+IBdDuUpH0ffV3eW21HSRtsMzybmo8R7I3/oqhIog4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqWhYsdJCi9HW1vC1EWEiCs4efTce43sVQF77rCgC3gQNbG2CpH2wNybo39iwdzTitfeYlmAuGVvn5BxMt5bSQmzmrtvcRmhvqFOYel5gmNUr5lcmAvLHN6lqvTXviybDuplxIZ+2eet7xUynHE6bCYZYgedJfyg5XtI65MQBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Aw4oxx8n; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef7640e484so23889407b3.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1734120084; x=1734724884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjFjYpSxXBJz9M1hdmG3iiPhNXo18zA2UB8YwR16DTw=;
        b=Aw4oxx8nq9uHYAk75b2hNQ2JcHhr7tC+0dX8m9SZWRJDFJiu/sVJSvzM9XBXgYsnYS
         bynk15+8A395Wh84G5ZpC4YGGfrkQ8xHpBJDMEyW4pvh7ya16WRTs5NBihS1LZp+MXdA
         fdGX+h9rZL7wyDolyXRO6nqFyYzZJdh5lxbUKe9+3g9IqZVlwYdSOmCg5hVzekeHff8f
         cd2d8tYPjB4jEbRPJV86IGQHA0YidWAptwpswJs1nuZbmXmmTZ1vPEpDw7vKMqKjZ8ZK
         GILYUBC5+V+gSuchWSYUY+EMYhxiix7FXnt7pk2unihcDI8wHNYTiBdy1abjtd8OFvr2
         HEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120084; x=1734724884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjFjYpSxXBJz9M1hdmG3iiPhNXo18zA2UB8YwR16DTw=;
        b=oL5LsIZChxCGyvM1RxqXODk9KtGpb7WRaVr2TWdjTDiUepiMoW+jhAD2sN2UdrYz0L
         ptnmZvW5gZnskzNeYLI9rSmV2FY0BWUUPFAoEapW3lluMllTMmdULPTBjfWBwZ8g2CAN
         4CtAzcKWxxg8J5PLU2Q5oM9bUzg4s5iLounSm0wgLyh7hYFx/JqKty/zk6B8o40gBxTh
         b5PV2EUjeo0lGaOVn0tpWw1GtogLTampeq4aRrK8+EdQVNcFm0hgpNNHyPJwvS4WSuhL
         tyzJf8dBNp7zMZF4wKbdYK3EuqA2UwB56/uYToqFsw14+bhNwJbUqSBd5JtRNGcEHMgn
         nI1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2qd+dsmYvCyefbFBhxZDBSP4NxES9qz9SlUt1G8UbHEFVnd1Wd4qNFaIzao67ZBPwBI4l8M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekHNS82bj5izZQxnzvnj+/T0r2jtPobQk8TN4hxUZwjCVmuOW
	Ct64JkkGpW7aGEVmXOj6ikm0E+JgLelmdrgXX1s0ru6PYtPNnAhREykbT3Krd1jfXDW48jV/sU8
	ErVAwpc+GRvO9ZloxHppxtDEN6v4pUJ1egaPqXoGkBDRoj4W+lKs=
X-Gm-Gg: ASbGncun1JF8wnRDqvriwyqKQ4QlnTA0aa2Pq3nu2uz0Oix81SqquKP4vYb3k4L4Rb1
	5B12E4HoQ4lSG4vQoSNFtljYKliQ/xxPY4Gmcsg==
X-Google-Smtp-Source: AGHT+IEywBNIbwjppPoVSQ/XELBsV0fF8sTiDrKGwA9AnZLBRibm/aOssHinTtzowKOKfn5HmY+4fB4H6J+nE2ZGRjI=
X-Received: by 2002:a17:90b:2242:b0:2ee:ba0c:1726 with SMTP id
 98e67ed59e1d1-2f2901b253dmr5268444a91.34.1734119680395; Fri, 13 Dec 2024
 11:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Fri, 13 Dec 2024 20:54:29 +0100
Message-ID: <CA+HBbNG0k24fO5OG42jw-7trWbT3iVTdo6Hh=55s1MaTh28p-A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/9] net: lan969x: add RGMII support
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>, 
	jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 2:41=E2=80=AFPM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> =3D=3D Description:
>
> This series is the fourth of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
>
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
>
>         1) Prepare the Sparx5 driver for lan969x (merged)
>
>         2) Add support for lan969x (same basic features as Sparx5
>            provides excl. FDMA and VCAP, merged).
>
>         3) Add lan969x VCAP functionality (merged).
>
>     --> 4) Add RGMII support.
>
>         5) Add FDMA support.
>
> =3D=3D RGMII support:
>
> The lan969x switch device includes two RGMII port interfaces (port 28
> and 29) supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.
>
> =3D=3D Patch breakdown:
>
> Patch #1 does some preparation work.
>
> Patch #2 adds new function: is_port_rgmii() to the match data ops.
>
> Patch #3 uses the is_port_rgmii() in a number of places.
>
> Patch #4 makes sure that we do not configure an RGMII device as a
>          low-speed device, when doing a port config.
>
> Patch #5 makes sure we only return the PCS if the port mode requires
>          it.
>
> Patch #6 adds checks for RGMII PHY modes in sparx5_verify_speeds().
>
> Patch #7 adds registers required to configure RGMII.
>
> Patch #8 adds RGMII implementation.
>
> Patch #9 documents RGMII delays in the dt-bindings.
>
> Details are in the commit description of the individual patches
>
> To: UNGLinuxDriver@microchip.com
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> To: Steen Hegelund <Steen.Hegelund@microchip.com>
> To: Horatiu Vultur <horatiu.vultur@microchip.com>
> To: Russell King <linux@armlinux.org.uk>
> To: jacob.e.keller@intel.com
> To: robh@kernel.org
> To: krzk+dt@kernel.org
> To: conor+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: robert.marko@sartura.hr
>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Tested-by: Robert Marko <robert.marko@sartura.hr>

> ---
> Changes in v4:
>
> - Split patch #4 in v3 into two patches, where the new patch #5 handles
>   PCS selection, by returning the PCS only for ports that require it.
>
> - Got rid of the '|' symbol for {rx,tx}-internal-delay-ps property
>   description in the dt-bindings (patch #9).
>
> - Link to v3: https://lore.kernel.org/r/20241118-sparx5-lan969x-switch-dr=
iver-4-v3-0-3cefee5e7e3a@microchip.com
>
> Changes in v3:
>
> v2 was kindly tested by Robert Marko. Not carrying the tag to v3 since
> we have changes to the handling of the delays.
>
> - Modified lan969x_rgmii_delay_config() to not apply any MAC delay when
>   the {rx,tx}-internal-delay-ps properties are missing or set to 0
>   (patch #7).
>
> - Removed 'required' constraint from {rx-tx}-internal-delay-ps
>   properties. Also added description and default value (Patch #8).
>
> - Link to v2: https://lore.kernel.org/r/20241113-sparx5-lan969x-switch-dr=
iver-4-v2-0-0db98ac096d1@microchip.com
>
> Changes in v2:
>
>   Most changes are in patch #7. RGMII implementation has been moved to
>   it's own file lan969x_rgmii.c.
>
>   Details:
>
>     - Use ETH_P_8021Q and ETH_P_8021AD instead of the Sparx5 provided
>       equivalents (patch #7).
>     - Configure MAC delays through "{rx,tx}-internal-delay-ps"
>       properties (patch #7).
>     - Add selectors for all the phase shifts that the hardware supports
>       (instead of only 2.0 ns, patch #7).
>     - Add selectors for all the port speeds (instead of only 1000 mbps.)
>     - Document RGMII delays in dt-bindings.
>
>   - Link to v1: https://lore.kernel.org/r/20241106-sparx5-lan969x-switch-=
driver-4-v1-0-f7f7316436bd@microchip.com
>
> ---
> Daniel Machon (9):
>       net: sparx5: do some preparation work
>       net: sparx5: add function for RGMII port check
>       net: sparx5: use is_port_rgmii() throughout
>       net: sparx5: skip low-speed configuration when port is RGMII
>       net: sparx5: only return PCS for modes that require it
>       net: sparx5: verify RGMII speeds
>       net: lan969x: add RGMII registers
>       net: lan969x: add RGMII implementation
>       dt-bindings: net: sparx5: document RGMII delays
>
>  .../bindings/net/microchip,sparx5-switch.yaml      |  18 ++
>  drivers/net/ethernet/microchip/sparx5/Makefile     |   3 +-
>  .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   5 +
>  .../ethernet/microchip/sparx5/lan969x/lan969x.h    |  10 +
>  .../microchip/sparx5/lan969x/lan969x_rgmii.c       | 224 +++++++++++++++=
++++++
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 ++-
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
>  .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++
>  .../net/ethernet/microchip/sparx5/sparx5_phylink.c |  14 +-
>  .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 ++++--
>  .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
>  11 files changed, 484 insertions(+), 29 deletions(-)
> ---
> base-commit: 2c27c7663390d28bc71e97500eb68e0ce2a7223f
> change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a
>
> Best regards,
> --
> Daniel Machon <daniel.machon@microchip.com>
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

