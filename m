Return-Path: <netdev+bounces-168281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73560A3E62E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CBE7A43EF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E021516F;
	Thu, 20 Feb 2025 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al98RS1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19C1E4AB
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085142; cv=none; b=AMOrH2AzXJR3Xjrhz7V4I4In9PMInJ12dODusYx4/su085IYy4hxNkPt4+MG0fjAxOi8aL/+gFhWUciDDTpFfoscygfFfCFJT5dw1PWw3Fyf3zfokKCtbgFWlCkjUKi/KKMobHislZEb1ei2vVLAYN9V5+a3U41qmLdICSrbCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085142; c=relaxed/simple;
	bh=qfpF+i9a+oPfCGrTBRwRjfbWlMj2/uE/QUNdZjDWxVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgoEJhhazJk/E1vlBl3QwbgH6YL0ahts2YkbIfLDtj/acgDlNA3+doqEHZqfgWhokm1sQ52OZxX7nIv+Pnnme3t4qPbIzEDx22UAC46PsDr3p2lkY+M855FDGWh2s+5DaJYb5z6zKizN5Hg/qeydAntkdas436oinBJ07IdvzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al98RS1C; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5decbcd16d2so272028a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 12:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085139; x=1740689939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqEPfDUDZHGv88zgUmEc0ttCumBQXmOunBZbS9NvCeg=;
        b=al98RS1CuUzuUCixZSuEQ/8cbR0fsgjkGrdXcHTTosabe3UriRnVEO7Id857HZkFF6
         k8RVBvDfNWohCEVdC1hbfPEe97P7++MRjqWfqHZcM3mnfAfEJWzQ51u7pGR/xlbwfIbA
         Bz1RovNC6a+vm7A8TffYyYE5+f41+OS8C3NKF3N7YwyfjQS5b6dXu2HzvM7GIsAJOzJ0
         AQvEVNMe4/uZLxKuogDOZBAppFEMVHCb8dgwgMoc1YhSm2apyBuUhx2Rq+eC+vyUtKHZ
         L5WLmQXePpI+T5ALMbigvzcmCThOEikX27hBfZj5Mnyi9BZZEi5X5+Jlhp4wU+pL0BLQ
         wAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085139; x=1740689939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqEPfDUDZHGv88zgUmEc0ttCumBQXmOunBZbS9NvCeg=;
        b=VxA+yrIwfGLg0+DqXg887sJpWuTNCpnt5TszlQzjfV0PBsd3S6426Dz8iasKFvEsQq
         4ZviPBuNPiLx0YpvsvVHeVt54sUVMrgyZHPSKCWnTWPpTG8+VsB1gOFzQO6/v8Andcyt
         5ucay9Oz9/XXBb/ZHa3KMpWWfED2VslKqZz2/3Ar/lVN5t/HoF3JoQdaGB7mxGU8b4OF
         zdhCRL6pJ51lAAwJDT7tU419/qIr6sIo6eeDMVQBH8j6ec+BL/u1oo8FmKz1fOeghbzw
         g0VtTTKJtgmWSIwteLj6hx63dCg3vavXw8OCGOjiwwd9JUwg/On7gvBaboT50ZXNbmfj
         Imbw==
X-Forwarded-Encrypted: i=1; AJvYcCVe0mb297A6nVVihxTzvfV5xOpL48+cqeo2dm1X6fu5dJLqd5AiLvnE/ok8vrH0kNuPZZt6res=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DCeMq5Y7WutlgF5kRzHUFvF5doRSgodrEuvJBJuakaW4g3qx
	m2mC2b6RYFGTd7TM8qyU9bH0c1hgLJuMagN/kKclcMl+bueSB7oW
X-Gm-Gg: ASbGncvE4deAeo4upw+BVAaCVyecaGrxRJFxD4jKsouqvS+Rz0VqQEpc1KgXbHneJuX
	kmvHtdhTF7dr3vtVu/oS+ZqSelB8Py6lrfbB2Rvvgx5klTRjSD7XeS8/Pa6UhNjzF+RA3Ew7LoG
	Tv46WIxOb1nhVJUPrlDz5xM3at5BQ+t9lbfLQfIVrFybt4ECIzmLp6a+zwyebbjKPfkQODmeI40
	5vTqozvTMEWelksNNtqGmNQFDDOKBcyUSrqhuZts+69Laf3wIq7B4VpNuIcEiR2PLstxOAs0G9u
	I0Q=
X-Google-Smtp-Source: AGHT+IF7v8zj+Wm4ZYoog4dTqbxk3YjQVdwXYzunA0FrXd52R+i+dh/8ShdGBTT+5UDtFrTMjPJFRQ==
X-Received: by 2002:a05:6402:40c6:b0:5e0:36fa:ac1e with SMTP id 4fb4d7f45d1cf-5e0b722c442mr104845a12.6.1740085139077;
        Thu, 20 Feb 2025 12:58:59 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c3ce5sm12844757a12.17.2025.02.20.12.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:58:58 -0800 (PST)
Date: Thu, 20 Feb 2025 22:58:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <20250220205855.hthx46nbghverspc@skbuf>
References: <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>
 <20250220180814.efeavobwf4oy5pvy@skbuf>
 <CACRpkdY4WtDGFxTu+Ke_g+YfzL7vY3BGktzUpUAzJuuDgbBtSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY4WtDGFxTu+Ke_g+YfzL7vY3BGktzUpUAzJuuDgbBtSw@mail.gmail.com>

On Thu, Feb 20, 2025 at 08:16:26PM +0100, Linus Walleij wrote:
> > IMHO, the code could use further simplification if "realtek,disable-leds" were
> > honored only with the LED subsystem enabled. I understand the property exists
> > prior to that, but it can be ignored if convenient. It seems reasonable to
> > leave LEDs as they are if CONFIG_LEDS_CLASS is disabled. But let me know
> > if you disagree, it's not a strong opinion.
> 
> I added it to the router for a reason: I found that the LEDs were enabled
> on the D-Link DIR-685 (boot on default), despite this device does not
> even have any physical LEDs mounted.
> 
> So it's there to save some (well, probably not much but not non-existent)
> leak current in the silicon and pads from the LED driver stages being
> activated despite they are unused. If they are even blinking, it's even
> more leak current for blinking the non-LEDs, running timers and what
> not.
> 
> That's why the binding looks like so:
> 
>   realtek,disable-leds:
>     type: boolean
>     description: |
>       if the LED drivers are not used in the hardware design,
>       this will disable them so they are not turned on
>       and wasting power.
> 
> This is maybe a bit perfectionist I know...

No, I understand, it is definitely more careful and perfectionist handling
than you'd expect of the situation where software support for LEDs
is compiled out of the kernel.

Anyway, are you using a custom-built kernel for this router? Do you
expect CONFIG_LEDS_CLASS to be disabled? I hope I'm not reading this
wrong, but I see current openwrt for dir-685 uses the same config-6.6
for the entire gemini target, which in my reading has CONFIG_LEDS_CLASS
enabled (well it explicitly only has CONFIG_PHYLIB_LEDS, which depends
on CONFIG_LEDS_CLASS).

I understand why you did it when you did it, and I'm not trying to push
any farther if you want it to remain that way, I'm just not clear whether
you understood that I'm asking whether it matters from a practical
perspective today.

