Return-Path: <netdev+bounces-179945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2336BA7EF79
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CC7169475
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB122331C;
	Mon,  7 Apr 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b9+0eRem"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B521B9F7;
	Mon,  7 Apr 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059462; cv=none; b=IsoiieLXfoj/wEUAvkXS/ivv28t6PvIzaZBVDIi9BC4fvekwdWu5ceWH9q91RuYqrZUA79lepCCQqVJO6Xowd+ioVv+qcl1IXL4TF+KYcmYruCDZ8VYY0CDDskDFH88TTFsQENdmCeaIbJpxO6lOHNk8iNjJywceAhthnITCNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059462; c=relaxed/simple;
	bh=Mbyrz1Qi5XQlFpRS8zL5PVOBby94colqqkS/+3hWAH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVRBNc7OgiybTIfZOrN/mYWCl/tplaETWPqkSNeSbYI0iCMbI8dNoYpWIirNdys2/ygvUc7sV4ItWHISYc7Io7Ss6fhaW5mZDAVT/XL7oPnKe1Fc0r9Bms/ynrHWg/YnN/+fsExySzvlzK6bCwIRfmmLfvHFkHQpfHPTcsBrrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b9+0eRem; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FIFzgxgJF3inGAo4BQdXx/+2ik1F0587zeNPteUhJtk=; b=b9+0eRemltOMVqPX+0y1eN3GdM
	ESLSwdeF0F5WgO05UZl7OHBAglXKWDyr4Hjrf8Iyu8k6DvMz8Jmp2x0vn7W8pawWl2voe79VRIgVZ
	8S7B9Yec9Ff5IRC0MnfjQ+e69v0D5SU7NpRBHjEw6yvypM6S4es/9EJfF+hbWyhf7s40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1tX1-008J05-O3; Mon, 07 Apr 2025 22:57:23 +0200
Date: Mon, 7 Apr 2025 22:57:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 02/28] mfd: zl3073x: Register itself as devlink device
Message-ID: <262753b0-817a-436c-bfcc-62c375e4bbf6@lunn.ch>
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172836.1009461-3-ivecera@redhat.com>

On Mon, Apr 07, 2025 at 07:28:29PM +0200, Ivan Vecera wrote:
> Use devlink_alloc() to alloc zl3073x_dev structure and register
> the device as a devlink device. Follow-up patches add support for
> devlink device info reporting and devlink flash interface will
> be later used for flashing firmware and configuration.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/mfd/Kconfig        |  3 +++
>  drivers/mfd/zl3073x-core.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 30b36e3ee8f7f..a838d5dca4579 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2424,11 +2424,13 @@ config MFD_UPBOARD_FPGA
>  
>  config MFD_ZL3073X_CORE
>  	tristate
> +	select NET_DEVLINK
>  	select MFD_CORE
>  
>  config MFD_ZL3073X_I2C
>  	tristate "Microchip Azurite DPLL/PTP/SyncE with I2C"
>  	depends on I2C
> +	depends on NET
>  	select MFD_ZL3073X_CORE
>  	select REGMAP_I2C
>  	help
> @@ -2441,6 +2443,7 @@ config MFD_ZL3073X_I2C
>  
>  config MFD_ZL3073X_SPI
>  	tristate "Microchip Azurite DPLL/PTP/SyncE with SPI"
> +	depends on NET

It seems odd that the SPI and I2C drivers need net? It is the core
which is doing devlink stuff.

	Andrew

