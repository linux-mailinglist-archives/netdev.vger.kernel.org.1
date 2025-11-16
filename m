Return-Path: <netdev+bounces-238906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC6C60E29
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 01:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C7F3A438C
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 00:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B811D31B9;
	Sun, 16 Nov 2025 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0x6DWOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA4183CC3
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763254655; cv=none; b=aKQHkGOtgI4EHN2kROrecKZk3OBpmQ93T8NIbvZkZ80K52Jwl+lLB/Ulce6qYU+hq5OM5LZ7x6clpbJ76mJxQATIybE26H7j8FpKCDPCtL1yTqNxIIUVWrtYdww8ZZCCmrzPaZPEpwY4Oqlq9vm+CVmNG3y1OlzFpmTdPY1JIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763254655; c=relaxed/simple;
	bh=s0AmmzyABWD4Oq9M0188bm0asRW+bjv/4AsappBKzo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU14Hwwh02O7SE1g7k9RbT3FuvZ2GjEplobM+4vSuGKWfRXO00lG8VCMF7F72Sd2Bo7cV0xB0PBTzIcH/ZgIAvpQatDD/HZYBJB5zsAr/z/L1dmtM33CiGV+IgP9Xz7U3hvCCxIhLUAdLquEUzg9gnH2ESN+suqdnefwoOm7XQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0x6DWOg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957d86f800so3173691e87.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 16:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763254652; x=1763859452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajg4HS+BMsNbtABrkTDYlU3vNspmGsLPkfbzb+ywu1c=;
        b=N0x6DWOgmvF17YrpYcr0M0ZU7WDip9bGUL2m2DKO1S4/0dxihqQX/jJahhpazpHwUN
         gMarM0MUv9tRt7MiPfUpspnHwNsF8TZwwiJaFCpY/d8wCA75t7kmVDgA2g2sqTQpq3oz
         2dY1oFMBZmb2eBoPA/dTwWDa4AlfivQSk0Bf/x56IhPWkQz/jc4Nl01r3uXZxn4rJUUN
         6O4gg7EOU0NcxQl/LX2biZ33gu3HYEG5u61EmDky8C1k5aVaT4uZVKr3pVvSRCy/fvEo
         LQfTsV+jf2LxQ0e6Jn9LI1I1pnb6W6ZOpDNUoUuntOnzVEiZobULr0mVwlDpTG6wByhZ
         CKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763254652; x=1763859452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ajg4HS+BMsNbtABrkTDYlU3vNspmGsLPkfbzb+ywu1c=;
        b=Bxgdlxla7UQbTy7gbjS8PARdoeOAU94j49Y8Wu69ELHxz/qqDRlNJX3L90LB6S2KoU
         mhe8bnQuJfHW6kRrYI5mK0lrhN6zp/ydL/yoj2Qc2o4iKvaLjT++mgLpMIH70o+VZUt6
         jh/Gnk8Gjf9VbCaSTzkg78ahcEaHqLYAuprgkFf9vfpDRtJvBDC2FkO366NjA+R4u3b1
         GQRcFsmHvYW8+Xr4vAOk5JtbaB8QmwdsrRC11f3yBZ0xcffdUxI3864h+pIHV9dbMs1W
         dOVU9yWsPNyYyZPcgFqGvuFGycrqmwsF+JMwPftPapJGP4aVsjDVcQTBvmYcfl2UyHn+
         9zSw==
X-Forwarded-Encrypted: i=1; AJvYcCVA4YfR7Sf0bZg+s2YAwMgXbwUq+5wbly+Zs1ohlqj82PyIfSMF2+iL62+tBII/nv33fGi4EMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5O3yFxXb7ir25FK3PWq5hZUxhsc2BZZs+iAbptaxASg935j41
	vcDH2eLFynPlnM7xw7LgplUoQvbb8uy+uo3IsVr1C2XP2LgqoIAQqD9ldmjZMl0n134tSA6BgoP
	sIa2+JU+zt2mhAIHmC+DbS5UKwNkFAIA=
X-Gm-Gg: ASbGnctesMmVxKEQGoSpdO+P7N0CrlaPPXAkciiCSeHyZTqwuwM21J/hUHpXYj5RbXT
	oaqS9qfp1mp+jE8sPCsdyMEvqbqsmcoG0dxRpPGjGuNldtQX0fei5u+x7gQ0S7FeLFSysvAoeJE
	5LpESYq7Ls2r/v+LeEzQ9edr68jmwoTFOpDmquU345okVmrgyyrM70q84TartYhqQK/b3MWT4iO
	YWVP/a2aWhXZQ0FmBaYdyeM66ylPOGRcQWKgbRXnq0oCnDdyGQeD45AnzIjKN3ZsNRWyYpCmW5R
	ugproJ9CJnEsCwMU3kBwiwclywX+eKNHaDc9kA==
X-Google-Smtp-Source: AGHT+IEmIP5t/YzkeE4RNxRjNVshIk6A50pUHMKvQdQq4FTod6TW7aNT49/QK/nViigx6ccY70RNW1vuQOKgnVRv/V8=
X-Received: by 2002:a05:6512:3b9c:b0:594:27fb:e7f5 with SMTP id
 2adb3069b0e04-59584200d84mr2721624e87.42.1763254651569; Sat, 15 Nov 2025
 16:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch> <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com> <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
 <aRjytF103DHLnmEQ@shell.armlinux.org.uk>
In-Reply-To: <aRjytF103DHLnmEQ@shell.armlinux.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Nov 2025 21:57:20 -0300
X-Gm-Features: AWmQ_bl66ws4cdagWjPJO_XmL7LGy76fJ7om8bsyr6WZNGCxAhZM9Hde7Hu_BS0
Message-ID: <CAOMZO5DfK1kxhtbYR3bDbwinpCKotBgHnY-B+YUknnHivUPYDA@mail.gmail.com>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, edumazet <edumazet@google.com>, 
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 6:37=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> What happens if you replace this with genphy_soft_reset() ?

Packet loss is also observed.

> Is the hardware reset signal wired on this PHY, and does the kernel
> control the hardware reset?

Yes, there is an i.MX6Q GPIO that is connected to the LAN8720 reset pin.

> I note that phy_init_hw() will deassert the hardware reset, and with
> .soft_reset populated, we will immediately thump the PHY with a
> soft reset unless a reset_deassert_delay is specified (e.g. via DT
> reset-deassert-us prioerty). This is probably not a good idea if the
> PHY is still recovering from hardware reset.

The original dts had the PHY reset described in the FEC node:

&fec {
      phy-reset-gpios =3D <&gpio2 4 GPIO_ACTIVE_LOW>;
      phy-reset-duration =3D <100>;

I have also tried describing it inside the ethernet-phy node with:
reset-assert-us; reset-deassert-us; and reset-gpios, but it did not help.

I agree that the combination of a software reset and hardware may be
causing the issue here.

> For reference, LAN8720 requires a minimum period of 100=C2=B5s for hardwa=
re
> reset assertion, and then between 2 and 800ns before the PHY starts
> driving the configuration pin outputs. This _probably_ (it's not
> specified) means we shouldn't be talking to the PHY for approx. the
> first 1=C2=B5s.
>
> Finally, and this is probably not relevant given that the PHY works
> with the genphy driver, the PHY requires the XTAL1/CLKIN to be running
> during a hardware reset.

A 25MHz oscillator is connected to XTAL1 and XTAL2.

Thanks

