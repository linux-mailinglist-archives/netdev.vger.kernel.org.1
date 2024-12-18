Return-Path: <netdev+bounces-153133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3493B9F6F02
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7744D16BB83
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF471FC0EB;
	Wed, 18 Dec 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW9sfdB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988E154BF5;
	Wed, 18 Dec 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554696; cv=none; b=HrJorhg2OqaALfWF2ZDpid7nDb1c8RuR1ASmARx2SQ3iia9MI+eWHb4mdFzDGpOUGb30Du1Kcpq08fOVW5iuSRJbENIGcgv++Ay+fU0NRQrKYppDplwVBlkH5SSeP57yaTmy0QLXPWdJ/IHc2uPA5ytKlhN8bsSrpBF6rjLcI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554696; c=relaxed/simple;
	bh=efj8Cdf5GEHEStwGTOBnMB+lZnYnrQ4k0PjreAoHbzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbSdRbk+Ii6LxRrVwZr8RueMMS+UWddPyJ1erdDvF6c7s5d4z5MRirRbYsmKvaoh3AfRQZ73yPX39pLsItqBspw88KnZ6TrSAbYPQ7bdP3MB1aUFA9yBnl7bsvs8Z0R08+arqmH7KFJbICfwO9faocltfyRP8EDDmD2tOeAfqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW9sfdB/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434e3953b65so537465e9.1;
        Wed, 18 Dec 2024 12:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734554692; x=1735159492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOo6aR0HrRqXEPTeqKeLumdrMeWE46KUaUAupbDA16U=;
        b=jW9sfdB/nH+NvGVm8rvl06hCezKV+oeNPBWnp530kkKDKij/ugzEaOoX9ZOIgdcsBc
         Bdiefn5o9QXps6+NAZoaPNQ4ZhdpZsBcZ8XNfJw+rg7Qc/XnfC5tUEPxoKAu91nTh0eZ
         IoC4c/GOObkN0AMr2ueOEY35nUjeMo3OqFi2HLXZM6z/3X2+cVdWMmWeUO7GzeyG2UYc
         TodlJzY8YAl9Zu7wxy6pueM2JKXbzvKzYPe1huoahz50sLVTSpbm9lnrgih7XuGodYzA
         7esLqvcIjeSUviooxJ0ulqqGzoX5o3+GXoecRwA/rmsDPmT3zISxgQQTS5fcAy0yod1/
         XqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734554692; x=1735159492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOo6aR0HrRqXEPTeqKeLumdrMeWE46KUaUAupbDA16U=;
        b=Tca3ENhtHodXMH1qrXZDT6RWFzMF2L+FpNJ/5mcCVfoa5w9DEogelsI0uakQzbmCGO
         o7GeXyhYgGCO7MZMYc+caPHi8kWsurtitmtF9E3qqjiJoIs/9UN7BlwzJqq0C/EKyvLI
         CUJdzBBw+FaByXiKUdqRjbDWPOn2RomGxFfPPLRudSmh9BbEPP96kfFQ60WE7gHy7RR7
         9BfINrI2HCU7aw34uq6Qav180Np4lvk7t+gwNwP0mmvqQmdY1hoXPN6onfFjdUMYLgKW
         mDZUjvHlDGLIBV2mCMyZr1eeY0Dz9YdCpEh10U1m0IuWMwV8WFHmNUcmzrXxE5Lo8UKU
         9bQw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Tx34L67nF9joG30kVauFDDkFaBESeEM5o7LrLFP2IPbuDo8D7/ouVxM/uD63pVxnD80zmnZiaFwn8ow=@vger.kernel.org, AJvYcCXbJP+mElflh9dsEDgr2S0gLREpE6JI/2YHS51ABcurRFV+hAHutRSc9nOAagIq8fGmyUu1UQ2k@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlt7rfgeWuxXEHmGeCAuzs4VmpTs8mYfZctZz1vgkd46Vq9Lfz
	UmcGc7q7gbRCNJHL02Y3uY5Fj+6aRCs+nuUpb3xMKTzkbfNs2bTk
X-Gm-Gg: ASbGncuIKolQNkK3/KSegkE0DKXQezXEJDQwuoMPsTVUGWmyTfuuh628P4f1gdB/xoy
	teindgAopk2ltc6cvYJTou2BWNqGXacrz1Or3CgekfiSgO6+WfJD1lPfBl/tYWbvEoSVlY2GEea
	LSlEim/kX3vzaKsvrIZP86W/fSJXkU8pRjWSPzqPl7vac1TWHAnGDNtIaGjtdmwYQmGLIKeqTlR
	Lxh5Z2bDMx8cPC9ZezC9e4JG1CAwuwZgY0OglnsyW4WEqNmD3/m
X-Google-Smtp-Source: AGHT+IFoZfBWMqEswL9oXIUj1CjTqb2B+uZLHWPtgiIwbHxWOQWAFKRl4QUvb3WbWNwM+/R/IiOTEw==
X-Received: by 2002:a05:600c:46ca:b0:434:f270:a4f0 with SMTP id 5b1f17b1804b1-43655426983mr36843275e9.21.1734554692303;
        Wed, 18 Dec 2024 12:44:52 -0800 (PST)
Received: from debian ([2a00:79c0:622:b100:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm57253105e9.0.2024.12.18.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 12:44:51 -0800 (PST)
Date: Wed, 18 Dec 2024 21:44:49 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <20241218204449.GA797439@debian>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
 <20241218085400.GA779107@debian>
 <c63316ac-696d-4ca9-8169-109ed1739f2a@lunn.ch>
 <20241218181752.GA792287@debian>
 <4f40c476-565f-4f74-8cab-7250045fdd90@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f40c476-565f-4f74-8cab-7250045fdd90@lunn.ch>

Am Wed, Dec 18, 2024 at 09:19:47PM +0100 schrieb Andrew Lunn:
> On Wed, Dec 18, 2024 at 07:17:52PM +0100, Dimitri Fedrau wrote:
> > Am Wed, Dec 18, 2024 at 06:16:20PM +0100 schrieb Andrew Lunn:
> > > > By the way. Wouldn't it be helpful adding a u32 max_leds to
> > > > struct phy_driver ? Every driver supporting PHY LEDs validates index at the
> > > > moment. With max_leds it should be easy to check it in of_phy_leds and
> > > > return with an error if index is not valid.
> > > 
> > > I have been considering it. However, so far developers have been good
> > > at adding the checks, because the first driver had the checks, cargo
> > > cult at its best.
> > > 
> > > If we are going to add it, we should do it early, before there are too
> > > many PHY drivers which need updating.
> > >
> > Another solution without breaking others driver would be to add a
> > callback in struct phy_driver:
> 
> Adding the maximum number of LEDs to struct phy_driver will not break
> anything. But we would want to remove all the tests for the index
> value from the drivers, since they become pointless. That will be
> easier to do when there are less drivers which need editing.
>
Just adding the number will not break anything, but probably the test
that should be implemented in of_phy_led. Except the test gets skipped if
maximum number of LEDs is not set(zero). Otherwise we would have to
change all existing drivers to set the maximum numbers of LEDs.

> > int (*led_validate_index)(struct phy_device *dev, int index)
> > It should be called in of_phy_led right after reading in reg property:
> > if (phydev->drv->led_validate_index)
> > 	ret = phydev->drv->led_validate_index(phydev, index);
> > 
> > This would solve another isssue I have. The LED pins of the DP83822 can
> > be multiplexed. Not all of them have per default a LED function. So I
> > need to set them up. In dp83822_of_init_leds I iterate over all DT nodes
> > in leds to get the information which of the pins should output LED
> > function. Using the callback would eleminate the need for copying code of
> > functions of_phy_leds and of_phy_led.
> 
> Your hardware is pretty unique. It might be best to keep it in the
> driver, until there is a second driver which needs the same. I also
> think you need the complete configuration in order to validate it, not
> each LED one by one, which your led_validate_index() would provide.
>
I have implemented LED support for marvell-88q2xxx.c which I wanted to
upstream after LED support for DP83822 is done. There I have the same
issue.
You are right, I need the whole configuration. But at the moment I read
it in the same way as it is done in of_phy_led and save indices to
bool led_pin_enable[DP83822_MAX_LED_PINS] and set them up later in
dp83822_config_init.

How do we proceed ? Implement maximum numbers of LEDs ? Skip the
validation index callback when upstreaming LED support for
marvell-88q2xxx.c ?

Best regards,
Dimitri

