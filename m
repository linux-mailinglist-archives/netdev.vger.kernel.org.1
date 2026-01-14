Return-Path: <netdev+bounces-249954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A3D21A03
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79713301C57A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630C3B52E6;
	Wed, 14 Jan 2026 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O33VKL+q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FD3A9D98
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430347; cv=none; b=o4l92EeG4o8JYiNsgfHOWNbVvmgTIUPsTBk9vzY7IdNKc3s04Zsc1hVzU+LEzNAnk3TAGUZDgmp5cwa3LzZ4FduW+WRtRwpfp9HZh5RykFUu2N/xSmwimZy/GjVghjutfGJxSSe/cyvZ9zWv2opCdAtfFRdpLXlmQK8nN2ozP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430347; c=relaxed/simple;
	bh=LiPMNGSYuDYKND7hjpCb2VOdDYbgBQygqfIWwd0xZ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5MS2XTgHmwHphqS0ZPRTHVsO+SFA3zCTiio1DrGIvDbpR4SlNzN5r9u2DP0d6DoVY3BGG+CrShvXFViHcRpahuCpz4+PSaS04wPxb1Fr/69AYHoK1N11NFavNvaGcBR5ywWXXl7nQo/X7HEIOKffodF3c4LDXSvZlS9fO30I8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O33VKL+q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee787da37so354635e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768430332; x=1769035132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpLrsuBP5cyvqPyFlCwBE8b4I6p1F6uTyQHUxukXoTo=;
        b=O33VKL+qJikSrFjNwPNF+t/liIjkVgBsuZh4JGnVYrcyC5/a71GxNagxBF8Aumdn8t
         O/BccIvh68/QUEPr3HA/ENakTnyy0iEKh6b0Vx1gGI42q6ppfXY2Bwck0A+bc+qVcCHf
         pXuQct4M2HOqXre2zZSPN92Jh5aEVTKvepFHzhC81Qe5i6iub3PJwKMdgRbSfZnkkWw0
         l7+Xxm17++uHDwvUF1M6TDC3Q6tmnLXK8YV1IwMjBv19PpOPIavLHy8wLsHShmzXx3u2
         hbd3O6Z4VkTdHrPBwRCJpQBlGhtmDwLBfJWTKoxfpsgoG7Waqc+05qjMVDCIIjGP8sui
         /nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768430332; x=1769035132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpLrsuBP5cyvqPyFlCwBE8b4I6p1F6uTyQHUxukXoTo=;
        b=Gz6UbG3zaOyxdlbDVlObyZc67h8H3uNZcCztFD0+mrgrLq40oZo69e44T8dNu7rhVE
         Z9JCjpR+OMhemFkUifBaH6okzkeqGA6f7tyqmG9KNlhfIQyzVoxC4AlkrksOErtNn6Az
         rGynndQEEStBboLZLg4s7RTFQDjKSbenfxUao8W8NyiL2ivJEMW7m2NOw2OS3MMAHwmJ
         OZ3HPnK0z5WVD9soIedkOq/4iB4l4yLKiQ4/Odxw62ze9ZUiXXbwj2VUYbxcT1qLqdrw
         be+YDIDAFvG+d0nPJSWB0SgxeIFFGRY6s/yvPFhhLEUAHr4oCUbpiBgAA0QYKlmCdA6a
         8IEw==
X-Forwarded-Encrypted: i=1; AJvYcCUPEOIaBuUxcOzIFJExaTUYjLIX4cUb0uSw4kFQDDFsZY3DwBVSiqvyT3dL/aa5PTJEYByVGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7pPQ5LdftiXAO0fr5vB2FpIuO2oiQpr3Sc9hzQ+r+5cGe8jY
	kzXMABHSYpl2hHT5nT/PlDegKFFCvACvOABq597NzDCSWoJdF+K5roQX
X-Gm-Gg: AY/fxX4By+0KOaKUvKjveCJvTglbiytAdgQYpzLcR0LBz0U/U5b6ZonsJXtRkl3F0nm
	3tnkF8eGSbWfeT+vmoHJj8LcgybnylP7dJ8M6oZlSQ680yyNRoU29EHC0lV+6Js7VMajH0TI4nK
	ebAnkpcKrafAHSB1OGp/2BbeJSRJnMoEm0RDGUxD4/MQtOVmtWsVEC+g9YfjvqzUOg0CM0fS61w
	uak1IrTpEpxu4/ew8EQF0jxl5nZt+LvAlE5cBCNOQnvjMdEiDFDGaF3IuPn22stuI4p95atyxEI
	4Pe95ejapWmeMkCUAngDSJBStolvepAgPYHLnqt7c5fOlPmRvt1BPbHM21wjKsiFtH/5mA4bo5j
	KHljXvXn2r5bAaHY/5h2KUgPV9QFgJriLwJghuoxBeGI06zrBoNtoiHXeOSAQeB7xhtOG4QW0vV
	09ow==
X-Received: by 2002:a05:600c:3510:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47ee32e0ce4mr29774335e9.1.1768430331927;
        Wed, 14 Jan 2026 14:38:51 -0800 (PST)
Received: from skbuf ([2a02:2f04:d703:5400:d5b0:b41:b5b3:8c4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm12480585e9.9.2026.01.14.14.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:38:51 -0800 (PST)
Date: Thu, 15 Jan 2026 00:38:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>,
	Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next 3/3] net: dsa: mxl-gsw1xx: add support for Intel
 GSW150
Message-ID: <20260114223848.4s6r4ncuzstq6e4e@skbuf>
References: <cover.1768273936.git.daniel@makrotopia.org>
 <b179f57a3997a84ae15fd3860c2735a7846d6a6b.1768273936.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b179f57a3997a84ae15fd3860c2735a7846d6a6b.1768273936.git.daniel@makrotopia.org>

On Tue, Jan 13, 2026 at 03:25:34AM +0000, Daniel Golle wrote:
> Add support for the Intel GSW150 (aka. Lantiq PEB7084) switch IC to
> the mxl-gsw1xx driver. This switch comes with 5 Gigabit Ethernet
> copper ports (Intel XWAY PHY11G (xRX v1.2 integrated) PHYs) as well as
> one GMII/RGMII and one RGMII port.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 63 ++++++++++++++++++++++++++---
>  drivers/net/dsa/lantiq/mxl-gsw1xx.h |  2 +
>  2 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 4390c2df2e4bd..1c6a5456a5caf 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000;
> +
> +	switch (port) {
> +	case 0: /* port 0~4: built-in 1GE PHYs */
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:

I think there's a syntax for this, see mt7530_mac_port_get_caps():

	case 0 ... 4:

also, you can drop "port X: " from the comments.

> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	case 5: /* port 5: GMII or RGMII */
> +		__set_bit(PHY_INTERFACE_MODE_GMII,
> +			  config->supported_interfaces);
> +		fallthrough;
> +	case 6: /* port 6: RGMII */
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		break;
> +	}
> +
> +	gsw1xx_phylink_get_lpi_caps(config);
>  }

