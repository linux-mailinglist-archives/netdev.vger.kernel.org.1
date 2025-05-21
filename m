Return-Path: <netdev+bounces-192450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D7ABFEE4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34DF4E55A3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C92BD591;
	Wed, 21 May 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/BIEzek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA82BD03D;
	Wed, 21 May 2025 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862776; cv=none; b=in7aXjaofuZs/ti8VgYlFGFCvyXeURp2C/IUNkK70HNTbP0SqSsCoZTQKM5eAYU5P5N6Y9IZtIPqDn9JAGIS9TRdAKBj9TdM5s2kJiYhHTp1JCulhj6tJKNVppcQpeA8cOijklOarw5ueJcAzFCffDaKZPtiNg03wgE0Cd1xP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862776; c=relaxed/simple;
	bh=u7NR90DqN8fR+fEWP+HSd72pFTGEbU0BrJZcMruRDJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2RPCmb8UUyA3/6fJpkZhA1gN076DFw6LeOztdB7azA58kcUUHYjn6l1FRJLsoIKaZMme6egW0D02JcSqT3Tpq7K2ijRlRKFs5Apxv/skho6d58ytz9F8vZfKeuwb86SnVgUV5vDSm2X5pyhoANsHcfJh5vaIwIzQOGmkewoBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/BIEzek; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70cc667a7ecso31768327b3.3;
        Wed, 21 May 2025 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747862774; x=1748467574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lfJ1qErzlYAlSOduBp0YqNghiuLR4YeiXIVbP181bPc=;
        b=C/BIEzekQxnC/XyleL1ZxJS6QSiI3JpDT2oubhlj5FleLUb/v4ubCf3w5rSzgJa0Uq
         h7h57W2QNoEzdTp6iA3hrB+5rbMUJWjwTgck4Cn6L1LbB5Farm49fsaFra8ay426HJgY
         MqKSo3gQfD4GmAP6goE9dgQNXLJL4eunQ/4eM6cTVnPH0ciP6JxV6Hkw3sNJp/tENvRg
         xT0HQJKrwWruUOSaqAwg5KiRj6/UnIfk8ADDC/bUmsG+mI6j0/YpBpwUAf5I1K12tAvB
         ygXTcNLCwuskVrrpEHy4rzSRZXTFVJ/gXmyMLiTl4w5cKJ/7KlHw3bs7fxTelW+bqcQ6
         JSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747862774; x=1748467574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfJ1qErzlYAlSOduBp0YqNghiuLR4YeiXIVbP181bPc=;
        b=K06raT0JDDVz9PrpS1YFVsYrucB+9ICliobwCehdpHerhbaHN94BW/K/DUFTSSOFUP
         vz1tmcJFEDK48HMbZE1vOOHmRhTSrxYkajTYPGrgYI3Mf4Bh+Brm5vDQFVWfQI8G8RP1
         9c2hHdlb2ppuNjYMzHy4b8UFj/WyERu+QZd8jQMAtEbMV1HVldCV59UNpdpy9otH4X4M
         +GC+tzps4eS6exTUQrVtsw1XCGodHXkLmBfRMcn7yDqHUZ99K/Tg1ikndelpWwET3YtI
         5EmR7R8W68R17URSzlLMI0QTjfXxVOkkd21B4/iEDu/cTCQml5uABnW7b8eV+oBsxlHm
         3Vlg==
X-Forwarded-Encrypted: i=1; AJvYcCUwd0Q9rtDcBQ7uRFkUGHwGN5+Pw1dVUK4HRFI0FCf0IirM8urS4HfBaRzz+jEGFeEcnE5yqP6DiRNjRXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63P6EZNXQOE5pL2LM5g2whU++QmMN8jwFt1mGmporwZ1copeB
	nUCP1xPUzSoVae4DfU+qRXXplSpxoQze/J1ZgOdINTJ0PGeY47QYB38iwVBBfHo21tEXmkopV21
	9pazLXkt45Ya8YE4mflWE5zjYscbfosA=
X-Gm-Gg: ASbGncsQ3phbmbPRgsGiL9ibaDwf8GhhCPQNL5bCoTyip2/XMsjzSDA/fMhK1WZxBNA
	PuvkeJI8B38uWO2II0COHNgmeRI8oyJYzvffDEeqIkSBrSEGD2aCZc0/Bb3vjMFCh+LI1+27lO9
	FSVC5nY+CcxjEdJYPLMhbpx+YfhdQjuobqSw==
X-Google-Smtp-Source: AGHT+IGi72zw5+6IdEganAHfWsQ00ijO6N3xfZVrPh0NBXmBLqCM1IASjTO06087mCq1OeadLcq1dHWiT0qtC1Niz0I=
X-Received: by 2002:a05:690c:6c8b:b0:70c:a0c9:c648 with SMTP id
 00721157ae682-70caafd5149mr268621617b3.19.1747862774091; Wed, 21 May 2025
 14:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521113414.567414-1-stefano.radaelli21@gmail.com> <978c8c91-5c52-4e22-bdb8-5731a35278b1@oracle.com>
In-Reply-To: <978c8c91-5c52-4e22-bdb8-5731a35278b1@oracle.com>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Wed, 21 May 2025 23:25:56 +0200
X-Gm-Features: AX0GCFsxiesad5Ep3KVBCvWh8ow4QJ5XZ1M3y_S2ZoAVhZYN0fd-oy5P79uAWu8
Message-ID: <CAK+owoiyB2mG+Q+pfEOkDc7jUj=zngiup32F1f4C0Q8RzTCBEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: phy: add driver for MaxLinear MxL86110 PHY
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Thank you Alok,

I will make those fixes in the next release v6.

Best Regards,

Stefano

Il giorno mer 21 mag 2025 alle ore 15:15 ALOK TIWARI
<alok.a.tiwari@oracle.com> ha scritto:
>
>
>
> On 21-05-2025 17:04, stefano.radaelli21@gmail.com wrote:
> > +/**
> > + * mxl86110_enable_led_activity_blink - Enable LEDs activity blink on PHY
> > + * @phydev: Pointer to the PHY device structure
> > + *
> > + * Configure all PHY LEDs to blink on traffic activity regardless of their
> > + * ON or OFF state. This behavior allows each LED to serve as a pure activity
> > + * indicator, independently of its use as a link status indicator.
> > + *
>
> "regardless of whether they are ON or OFF"
>
> > + * By default, each LED blinks only when it is also in the ON state.
> > + * This function modifies the appropriate registers (LABx fields)
> > + * to enable blinking even when the LEDs are OFF, to allow the LED to be used
> > + * as a traffic indicator without requiring it to also serve
> > + * as a link status LED.
> > + *
> > + * Note: Any further LED customization can be performed via the
> > + * /sys/class/led interface; the functions led_hw_is_supported,
>
> /sys/class/led -> /sys/class/leds (it is leds in sysfs)
>
> > + * led_hw_control_get, and led_hw_control_set are used
> > + * to support this mechanism.
> > + *
> > + * This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 on success or a negative errno code on failure.
> > + */
> > +static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
> > +{
> > +     int i, ret = 0;
> > +
> > +     for (i = 0; i < MXL86110_MAX_LEDS; i++) {
> > +             ret = __mxl86110_modify_extended_reg(phydev,
> > +                                                  MXL86110_LED0_CFG_REG + i,
> > +                                                  0,
> > +                                                  MXL86110_LEDX_CFG_BLINK);
> > +             if (ret < 0)
> > +                     break;
> > +     }
> > +
> > +     return ret;
> > +};
>
> remove ;
>
>
> Thanks,
> Alok
>

