Return-Path: <netdev+bounces-108196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B675791E536
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBA6B2628B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327D16D9BF;
	Mon,  1 Jul 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxvajOjk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378716D9B7;
	Mon,  1 Jul 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850890; cv=none; b=mB6geNGKvrb/LwSYMV1NZOaTfoR9ery9QdnBZnoimNYaev2kx3bd8JgQEBU7hicKQwJG/q+Oxz1l9858KomRo0U97R/ITRF0Iz7vMTGvLSIS9p2/osd3ZbXwSofo37PjmEFC6yYW8SpJL829GC4hoFTIR0MoVupoR/gBmC4R6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850890; c=relaxed/simple;
	bh=5aHOtGJJ2Y5Pc+Kx8K9gLM0fxXIvzccg70ioxAvbKW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeAcyDyXBalmH6UQMIFHm+iXFBzOtsbRN7pXgcYVfur6rrohnDVXnOIHzc8/UL+YK7PwzFuErCwVD4D3ppahACiqVfrWHwkgTNyayt5TlCsK01byFNpvxbk18wFHoIA5XdoftgE8EcXcnu3RgB5rQW0S+o1iGWWMUvszyc/OO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxvajOjk; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e829086f3so2813867e87.3;
        Mon, 01 Jul 2024 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850887; x=1720455687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hgz/vfvdIIstVkRxWKHH4AxdmLyZ5LWQUHyNfrig1A=;
        b=KxvajOjkmNghFfHGB0NcajkeAQpEtu9tTYJ6qYqBDQ+qRxCDzyIfrCQWTrOK9GbHEX
         cl/WPG/P9zLGKgaWNOgcBR7fHSLKJO9b/1rd0xVX92pBP9wW1sP7665rI1eR0untWm4X
         8s4hf0rG1L9hiZaPTOzJEhdx4yHk9WSXUN2FGXcHlxhVGGZaETd0Sg0CusMIHCvf7U+z
         sxBNsZN5M2mcwkBwMnxYfY2WoxhQDbWqoiEBIS5N/ClA65XkRpWHe4s3bL50ryyTIn8A
         1usUMfj/xeLcN+9XjoMkK6YEucfJ3kAjRjWTvrCRyTVi6kmVDupQKbXbPn5J4GUZM7qw
         bhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850887; x=1720455687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hgz/vfvdIIstVkRxWKHH4AxdmLyZ5LWQUHyNfrig1A=;
        b=cd1ymGkT7ZMBjUFtv16dRatSI7FNxuSmT0fSBhLO8DSA04pL7rXsYuvxH6dcbTGiXO
         Pho9CMO5VKNdIvJYE/7QUM1lZIwVwxeB1feWg6Lu4BCAsFxOS8y/CcCEUzQd7oDmLfUF
         JyuQvsO4zM0Wh9Y32Q4hPO76O63NP0UnLqot7UzFezIORcgZD++m9VuFo1avGXh3v4Hl
         lTylBcOt2Yy/uP+6q6DvKGE9FTv1E/CaWYVOKxQUVmcCzHtS4ceh1YYtEkxPh8As30B7
         1sCh/F/mgaa/Bolz0zZJ+NpZakq3EKVJ2mVGEx9qQ1sH5BGceF/k2Gwg38WHOFuXkE1q
         QAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoTd4RtsCy43+k9YBtB55fU8jv2XcmJgXSjtXTqZ8e9lppSuSCc1CHGO96FUZ6+4bE4rQzKsUI5VdOpaXyU3Xiw+s/uLr2BsMKG6p5ffdg43U0gvxPcsaUYaIfMBuMCCh9Hb0/
X-Gm-Message-State: AOJu0YyjM13q6JazGVA1YlhV2eV//3PlcAUglCcirRL3E3/aJZWgTxYE
	E9QvblMLImXpMXCPJoZZD3+7vdRB3C1QUcqmaJ7Xb2K94I2gFDBt
X-Google-Smtp-Source: AGHT+IHQQCCynAPYl6LXUvW6APyHqE9berK0UtiI5jg1zfVojn7CuH1WrDqZGKkIjixJza673C2nkA==
X-Received: by 2002:a05:6512:33c8:b0:52c:c9b6:df0f with SMTP id 2adb3069b0e04-52e82733f9dmr3934002e87.61.1719850886847;
        Mon, 01 Jul 2024 09:21:26 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba0bsm10433428f8f.69.2024.07.01.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:21:26 -0700 (PDT)
Date: Mon, 1 Jul 2024 19:21:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 3/3] net: dsa: microchip: lan937x: disable
 VPHY support
Message-ID: <20240701162123.bj2lgsrouik3xtj3@skbuf>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
 <20240701085343.3042567-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701085343.3042567-3-o.rempel@pengutronix.de>

On Mon, Jul 01, 2024 at 10:53:43AM +0200, Oleksij Rempel wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> As described by the microchip article "LAN937X - The required
> configuration for the external MAC port to operate at RGMII-to-RGMII
> 1Gbps link speed." [1]:
> 
> "When VPHY is enabled, the auto-negotiation process following IEEE 802.3
> standard will be triggered and will result in RGMII-to-RGMII signal
> failure on the interface because VPHY will try to poll the PHY status
> that is not available in the scenario of RGMII-to-RGMII connection
> (normally the link partner is usually an external processor).
> 
> Note that when VPHY fails on accessing PHY registers, it will fall back
> to 100Mbps speed, it indicates disabling VPHY is optional if you only
> need the port to link at 100Mbps speed.
> 
> Again, VPHY must and can only be disabled by writing VPHY_DISABLE bit in
> the register below as there is no strapping pin for the control."
> 
> This patch was tested on LAN9372, so far it seems to not to affect VPHY
> based clock crossing optimization for the ports with integrated PHYs.
> 
> [1]: https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - reword the comment and link microchip article
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

