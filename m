Return-Path: <netdev+bounces-133110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD9994E6A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C473FB248D9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832461DEFC9;
	Tue,  8 Oct 2024 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEvV+gp7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57041DE4CD;
	Tue,  8 Oct 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393222; cv=none; b=oebKCnplskjBPPi038xXHt9VJTuN3ygJnBc1QKevULC2xg1vcvE49bLbUAU1GFqxwiEMOVlzXNxcfmd9K5M4RDgj4hrzMD5W6K5lVkXydeRtDvFiT8BaVwnuAnR/JEkECSBTeBd6XiunzeEFpeM4fJh5BnM4aHmoKae5fIROGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393222; c=relaxed/simple;
	bh=HB2X+1cgA42e71mYG+axOAoHb2tW9up9sEJ3ZOfoDyU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0hdsv/NVU8RzWjHxjoDjohakH3LqHCp9IJrVCYwC8q0jkuoG0jhO3f0cqVKtu3hwhAdOwrnyaEeAhonwvqhAdL3vKHjynQXLDM3iFlosAdiotppqlnQ/dxgxGHT4V9KcVDxLbHqNtD0wz2hHqP4WMgrafoRpDzLna6asUH9dsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEvV+gp7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so45098795e9.3;
        Tue, 08 Oct 2024 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728393219; x=1728998019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+3nNuHTEY1yCn0MC03snttILQ8g327zVvBFongvgvc=;
        b=NEvV+gp7q11y6e2i3CTBtWKSdeIkFV+Ugl9FYA4Y3eSXkA3fNMY73L943vBB47EACW
         9eNt/b3qUr2qO8Bn0cn79tINbN+3OK2cJ4+WUGriJcd1YWSA+vMAuNARcOGBDS9Da33p
         pcjajCtXHrSMhRsio7jPvHN+hbyAMrYXoWU7CPNAbAc3X855gZrZQc3w4J+YmFTJkDqA
         47skLdYJlDJ2W/UO3ile/xO56mRGA1WTJbGZzVLmnJ6BUqt9PMefkm8w4ZhbHAJ2PKS3
         JRmACtNLZ0LSVWpelYvu76Q59PCFPZSjiPWYq1T6JMO56r2FYf9WndyS6nIF5kljhQtM
         Z6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393219; x=1728998019;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+3nNuHTEY1yCn0MC03snttILQ8g327zVvBFongvgvc=;
        b=hSZm4OeBdhBNF6GjdIISX1hiTir6scCz8EixR8KYHrskKW6goK3iBqNXUwGSA+T3oh
         n9BRVN3BRKEeq0yyKocM1lL+gcYyI8EXC1ngnF5+AwVqcjIEZ9vwhYFK6QOIvwpV/ixm
         NiYuHGX+LOwJJoRRwyT6C1x+UX4LM+dyKVdBvk2U7X6zuu24UbhIqnVnMC4Mk9iN9dqa
         uqN4qyNWDtTaefCgEPLm31EHgcdI3FUrV2F3LCwCLlxSNDUyjhfxvMDlW3AGoOSdc6/w
         eiLmJPmTqpupb052C938eE5nIDkAI/v2Ip2chi8y9dXvAKmyJlMW0PdRg/w5NkHKm+ja
         6P7A==
X-Forwarded-Encrypted: i=1; AJvYcCULcA8+vX5Hp6lcXCjfUOYzA9JDkG89uHXRMmx2AJoDXT2fftq16nY/e1WLCw+dN2kwQQzHiAcq@vger.kernel.org, AJvYcCUUU0OHTX9pRTS7Tc6TVCfOM4bjgJDJomVOWhs1eb2NB7dmVMBzTkCwWbKlquw+h+eZNJ+VfaqZVYFj4ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9UYYNlz99Kj4iRMWSpmlCziJeuYp+j8VQtBaFR0NURG0OlxJ
	2TQIKWfPza71BRmDY1I/KODy7ju2E5S1c7GXLwZH8E0wSRJuxEmM
X-Google-Smtp-Source: AGHT+IE4Stw/XNORaS3bEyUc3ys0SxWN35LG6c+Lgtu04NEpny6nANutfe3eEzGGUtGLdLPaFJt+Ww==
X-Received: by 2002:a05:600c:c12:b0:42c:ad30:678 with SMTP id 5b1f17b1804b1-42f85aee7efmr98609065e9.28.1728393218749;
        Tue, 08 Oct 2024 06:13:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e85dd0sm109746525e9.4.2024.10.08.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:13:38 -0700 (PDT)
Message-ID: <67053002.050a0220.63ee8.6d11@mx.google.com>
X-Google-Original-Message-ID: <ZwUv_jkcITPhkEyq@Ansuel-XPS.>
Date: Tue, 8 Oct 2024 15:13:34 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: phy: Validate PHY LED OPs presence
 before registering
References: <20241004183312.14829-1-ansuelsmth@gmail.com>
 <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>

On Tue, Oct 08, 2024 at 03:08:32PM +0200, Andrew Lunn wrote:
> > +	/* Check if the PHY driver have at least an OP to
> > +	 * set the LEDs.
> > +	 */
> > +	if (!phydev->drv->led_brightness_set &&
> > +	    !phydev->drv->led_blink_set &&
> > +	    !phydev->drv->led_hw_control_set) {
> 
> I think this condition is too strong. All that should be required is
> led_brightness_set(). The rest can be done in software.
>

Mhh the idea was really to check if one of the 3 is declared. Ideally to
future proof case where some led will only expose led_hw_control_set or
only led_blink_set?

-- 
	Ansuel

