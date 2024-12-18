Return-Path: <netdev+bounces-152863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEA89F6087
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8009163458
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A418872D;
	Wed, 18 Dec 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEwHYeaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7EA18858E;
	Wed, 18 Dec 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512046; cv=none; b=EpeS83HgAjae1HUd5Z42DeuFW1OlJgv0I2MgtDUbk7408AtwkxlaYu7fbzOE2X6TUpoml99g0iE9WJm2bYHMVAyG6Bg+eme7EicjMmX1SNXT5Hh+yJvvENSqC+oSyS26za7tuVz7FtVY4dhHlPANUPAXFVr4SuyZvHZgI6PDqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512046; c=relaxed/simple;
	bh=IcOQrUo4xFFRrDNdntSp+VYygsembbNofvt2QIk6mRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGoELsXotiUre7UbgzdEKcAXSddZ8SThUnKPTggbfEhb+kCifk1SeYGq/pFtbtgLDmPW+PKHEyr3BUPHPkWFc0swlPQ4EYp2VNB8KWOc8+8v9RUsw7B3xA55CJtTnRgA+K8OjGV9v7WrC8rZtLZkl4aQJ78S6bZL6sKAs8kVWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEwHYeaa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862f32a33eso3001569f8f.3;
        Wed, 18 Dec 2024 00:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734512043; x=1735116843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNiChtJGp/pawRaE2tXoUK/xU3kLoHohEj0hRvJi3tk=;
        b=XEwHYeaaFQM/2l36Vk0irl0hMTORpxa3bP2q2qWWXDdYp4GnzxzH/pwTxtgpihvXlc
         fhhyAgi4C9BsdPo7dsPms5mvXmzfLf9/uWJbmGZVeoqs5xx2Li9Wfkog4XLZle3oRfWG
         NNkrdE5IgbBTtMEgIVCtGQJW4oVTKFeItxeNZAuNkJfAhy2CnwNgqH4LG9BCRHQVlaXn
         UPHZ6n0qXNLyna318dZW3KB7U+uJ2DqTPSsmLg2vXs2ZbuPL2KwRibVKEjPYIeJ11kl2
         5A8DeK4XLYfYHfXfT2AvldfOO9dbvEMToJbOfJaRUs5LytnuVvlJ5m6UwCwxv8Zj+4jl
         s6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512043; x=1735116843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNiChtJGp/pawRaE2tXoUK/xU3kLoHohEj0hRvJi3tk=;
        b=i34mnRP2cq13qjk8f8Qlnh1ftJr2GdlAbMZtREOll3MUMn+n2faL8RGWvr0y3ok/Tr
         wSSnA50tfX6dS+pvdsUPPiH9zfp8P3h59GrhrN+xlzw/cWSFjbsE5lL9ekEEIXO3sxk7
         ZSetUzF29/JIOQik04R7G4WUQVUD4J3MRSoiVCCsFoK/9g2uQ2AU5xIrBTR+sZBunWOo
         kZ783F7LeA3GSvzwrmlDBdIG/V4eSYLZte5NWJ9lJJqWWvw7EuxCSehK6tSWxCxhV+i2
         8ZKm3kxp8g7tNyaeKWh1wDqgW/SFuufh4fFCwyHaQ9rN/xvtdnC+sg6YT0dup8SH6xAx
         g8eA==
X-Forwarded-Encrypted: i=1; AJvYcCUAw7UwotkfEGRzs0dU3otOISKOqkJSK1pmSZFdX29TdPHAqVAWozGmy731keypq0OnVsdXCf6OfT4BZOA=@vger.kernel.org, AJvYcCUV61yCSaOedAkvubFtRWY92nBQmzNWInhJ6oFF3xUTB+GaPv+IH2ZK+uyLwuFxi/tyLcZh1FiN@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGypBlQM/RIfEtDgDmuUlKMtg1Bm8w6AZuUW3Nto3seLGKDR5
	cBWLXhnL6yu+CSieGXK6u6Lf3XOXWDNrZ4CVzKHMnSBi9iEBtmOP
X-Gm-Gg: ASbGncu213am6VKwahnSVWFpO6wZVNxW/2vPJVjZbs1fbaiFixSYY8sz7oXwvaZbt5q
	7lMw7orcFLmUymMMTEP7wTwrqynPGOQaHU8pg9raO+MLR44l4f10ArR0H79bgWhQfx0EsZTgvLJ
	Yg+Nl5Kk5qOh9gMEhGLvYGUpAi6MWEG6pysio/pE39ktN132Gja97eQenz6iF+D4Y7FISfkckFB
	yKBDNHqHLfa9saWqLkq9atdXY5cpsdSOQ1qmrlSI2b8r6MGRBxp
X-Google-Smtp-Source: AGHT+IH+rogA0Lfr1RbYPkrzKBHSYzUPxhrmEv6dWTFuczgOT26um130a/DZkw2Sb8iHNmP5JdotRA==
X-Received: by 2002:a05:6000:186d:b0:385:f677:8594 with SMTP id ffacd0b85a97d-388e4dae534mr1541897f8f.43.1734512042641;
        Wed, 18 Dec 2024 00:54:02 -0800 (PST)
Received: from debian ([2a00:79c0:622:b100:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b190absm13302435e9.29.2024.12.18.00.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 00:54:02 -0800 (PST)
Date: Wed, 18 Dec 2024 09:54:00 +0100
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
Message-ID: <20241218085400.GA779107@debian>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>

Am Tue, Dec 17, 2024 at 06:13:25PM +0100 schrieb Andrew Lunn:
> > +static int dp83822_led_hw_control_set(struct phy_device *phydev, u8 index,
> > +				      unsigned long rules)
> > +{
> > +	int mode;
> > +
> > +	mode = dp83822_led_mode(index, rules);
> > +	if (mode < 0)
> > +		return mode;
> > +
> > +	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2)
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_MLEDCR, DP83822_MLEDCR_CFG,
> > +				      FIELD_PREP(DP83822_MLEDCR_CFG, mode));
> > +	else if (index == DP83822_LED_INDEX_LED_1_GPIO1)
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_LEDCFG1,
> > +				      DP83822_LEDCFG1_LED1_CTRL,
> > +				      FIELD_PREP(DP83822_LEDCFG1_LED1_CTRL,
> > +						 mode));
> > +	else
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_LEDCFG1,
> > +				      DP83822_LEDCFG1_LED3_CTRL,
> > +				      FIELD_PREP(DP83822_LEDCFG1_LED3_CTRL,
> > +						 mode));
> 
> index is taken direct from DT. Somebody might have:
> 
>            leds {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 led@42 {
>                     reg = <42>;
>                     color = <LED_COLOR_ID_WHITE>;
>                     function = LED_FUNCTION_LAN;
>                     default-state = "keep";
>                 };
>             };
> 
> so you should not assume if it is not 0, 1 or 2, then it must be
> 3. Please always validate index.
>

By the way. Wouldn't it be helpful adding a u32 max_leds to
struct phy_driver ? Every driver supporting PHY LEDs validates index at the
moment. With max_leds it should be easy to check it in of_phy_leds and
return with an error if index is not valid.

Best regards,
Dimitri

