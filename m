Return-Path: <netdev+bounces-168175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF658A3DE56
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D43D18904D3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349621FCF6B;
	Thu, 20 Feb 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1b/D0zg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83461FCE;
	Thu, 20 Feb 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064941; cv=none; b=UUsOjO636JOxsYF04rwC56ghg12XM92Aa62QHPxyT8/N1jjk0N9Rn36XC8w8swJj7iuCQIDyVNFkwplwsStkD0ncSXXHV8my89laIlEw33jh6vlT36K4sQ974lW3vHqik7tvJaTgXRxggTa98BACmf3Fz6YWi0eUUYVXomqneI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064941; c=relaxed/simple;
	bh=kfHU9mcfyEWp4K4OecPGGsOrDBco/6BHCzY/iw7yXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAAWdhnHyCep0wAFz9F0cLE8t4r3eLnfH/hWNolJn76HqdqTNYeQ/FTmFm40eJvIQg+2KdEiZqimooHaQu395yZbpmGocb1TVWnQAnQ3TtagXMwrCBMfMA0/cpqm6QDHvxOP8aqaNdhkKVfIpD28r8lqGOi0WBthjSo6fGFUofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1b/D0zg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso174483166b.0;
        Thu, 20 Feb 2025 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740064938; x=1740669738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKMJRxcVrE9w/3DLSs5I+sMeKRaz1X1IP++J5YO4MRY=;
        b=B1b/D0zggsRpKQj2PdFZCFBPe/P3XZG3cpKgABCyaYw0mKkx1b4JJXprisAubcMGP1
         T4wQ4a/iLne6md7quOlS94Cml20E5fuA8eEkDilk9MBYsbWe/vRhIVm2jTlTByao6OgO
         KCKDfKyhZ8xlRhnLgbAmdtwHUGhjl3kA2lpZASioo6nuI4/nutq7hWbFYecRljiuJAL7
         aJQMEx7GZZq3I2Wrj0pN7Seh5kySHQltPUjtggbZeXM+6TwOZbg1iHzafF+0DCLrFXj8
         396XhHbUzxY/XNW23XQKddu5Yes7ZAfmWxL+kMstG5zwtZ0i1cZNwJNk4f1qNPdiJVak
         xmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064938; x=1740669738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKMJRxcVrE9w/3DLSs5I+sMeKRaz1X1IP++J5YO4MRY=;
        b=wtuPGx4IkIZ4ua8QYoet+JlcGFymiwxMGdnRBYcNbG/N6C/XWW2U5cN8yOEK+44uHP
         OnU51dJ9HN4VMJp/+2ZSNuzKrzKsOEbEEsseMxNfJk9CLTF1Acy1kcDBUv0zPOyGHMZX
         MqoYNzMBa3WRvrLojk30dW6j3mFXkKHuGSpeWiXmtHq1JvQi8b69KuHoPSt7jDXbIobV
         NQXOBscjrBwSM2Rp2BQ3JylabgC4jjoTSsXYn/EGHOLhRtVzwuwOi24teDk5u2BA7fwR
         fCOLFyURtWjg3z/8UXh4EtHDf1mEZYRe1GwV0XEBfdw/hAL6BAIqQ5zmR6bas2VFq5fi
         +wtg==
X-Forwarded-Encrypted: i=1; AJvYcCW35g38iDqLVM4dhf1blDjqEgnt1621KBPfn2JeXFQ2kjdqd/W0scrN98rjk4bpr74DMHJeDNrBDcL+aac=@vger.kernel.org, AJvYcCXHL6b+BH/7t5yRlH2dnBmTRO91HAi1c7/SSwGgfMvHovrcElUrdk27WeuY1qKAYef1nlzBZ73M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VGdtDQwsu0hLi1f2tng0SomUr9qZZDa2OwBg/AfFOKOsO+Ow
	zKabNgNwpfN+1W24LDwINavbhVz3aF8Eo/B0VZ4tpgHhog2rk5p4
X-Gm-Gg: ASbGncu9/QmSEMdLv0O/D9IRZsK9TIkpV9ge2qyrDxnIe+qU+/AnMWlKZ+3BflFllNV
	AatnFsmAnbjC7pWEjfSalu2Zn4BCREQxhxeVOaKQdIG4b/BAYidyIGKwf7D6IRQM48Yc9PvUuT9
	2oIRXaL/uFicVZK83qzA0XnYjcNqfzTjoAlsdulog64Mj8LMkHRAPKdVEAwg4P8ZgoRZGB6OaES
	+ERbCPiMm8t7F6T/xCgtRJNFnN1M+Nkmw+h970kICbqRBtSgLtJCt7XASePCbLyIy31ftqG3Oe0
	coqMcpjPq3ck
X-Google-Smtp-Source: AGHT+IH9sBChZn12otJIB5X5cXCBtVvi58fLoea3t1Q2O8pmJr78TCNQCBEuKRP+mmL2IHNzuTYK6A==
X-Received: by 2002:a17:907:770c:b0:abb:9d27:290e with SMTP id a640c23a62f3a-abbcd059572mr781333566b.41.1740064937413;
        Thu, 20 Feb 2025 07:22:17 -0800 (PST)
Received: from debian ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbefd080asm518070466b.179.2025.02.20.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:22:16 -0800 (PST)
Date: Thu, 20 Feb 2025 16:22:14 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: marvell-88q2xxx: Prevent hwmon
 access with asserted reset
Message-ID: <20250220152214.GA40326@debian>
References: <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com>
 <20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-2-78b2838a62da@gmail.com>
 <Z7b3sU0w2daShkBH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7b3sU0w2daShkBH@shell.armlinux.org.uk>

Hi Russell,

Am Thu, Feb 20, 2025 at 09:36:49AM +0000 schrieb Russell King (Oracle):
> On Thu, Feb 20, 2025 at 09:11:12AM +0100, Dimitri Fedrau wrote:
> > If the PHYs reset is asserted it returns 0xffff for any read operation.
> > This might happen if the user admins down the interface and wants to read
> > the temperature. Prevent reading the temperature in this case and return
> > with an network is down error. Write operations are ignored by the device
> > when reset is asserted, still return a network is down error in this
> > case to make the user aware of the operation gone wrong.
> 
> If we look at where mdio_device_reset() is called from:
> 
> 1. mdio_device_register() -> mdiobus_register_device() asserts reset
>    before adding the device to the device layer (which will then
>    cause the driver to be searched for and bound.)
> 
> 2. mdio_probe(), deasserts the reset signal before calling the MDIO
>    driver's ->probe method, which will be phy_probe().
> 
> 3. after a probe failure to re-assert the reset signal.
> 
> 4. after ->remove has been called.
> 

There is also phy_device_reset that calls mdio_device_reset.

> That is the sum total. So, while the driver is bound to the device,
> phydev->mdio.reset_state is guaranteed to be zero.
> 
> Therefore, is this patch fixing a real observed problem with the
> current driver?
>
Yes, when I admin up and afterwards down the network device then the PHYs
reset is asserted. In this case phy_detach is called which calls
phy_device_reset(phydev, 1), ...

Best regards,
Dimitri Fedrau

