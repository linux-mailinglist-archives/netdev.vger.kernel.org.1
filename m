Return-Path: <netdev+bounces-170350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4580DA484C4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394481899DF8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED21B4227;
	Thu, 27 Feb 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="os+dzt96"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593E1B0403;
	Thu, 27 Feb 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672865; cv=none; b=pr3R0gAf+r670np6W7/+yQg5UxNMdiyt6sYO4A/9KGiunZsIq9w1JLgQeHithVmT6imoPAlw32hdsuptofhxFzSlwk2Uy1L09Vp+mMycFVCbf8+HO5EDAtZQdIlPfWsISaEtIrdeja+K5KpLXQR+3lgUtjXtD84ynwZ2hgcekps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672865; c=relaxed/simple;
	bh=IiY6ZLF7JOMgPL1XZRpG6xEyfSFPHouFr+qz+8RP/ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohZmkYxbCH5F1t+hHn26dItRqMVtj9uKPp+sIv4OPDxV/AptpAu4Zs5Wy8doumkL9iINGolqzmwy2GY60ThwfipZMl8CBiR93CG8OO49hzC+7EFfsq6m6KX2I/L0TPCQLUGg5gK5I9rGFn9T6jLQKjKsxdqA0xV2um9Jr4YYcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=os+dzt96; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E8uMYzZ6EkKf4Tjfs/lP4zNa1kerlGy7v4/Zfy2CCxQ=; b=os+dzt96tZaF+1MYknwshJAdfA
	2CaijdEyu/OKcurqeCL+2aXJhcjXXHdVjXj2SBSz0ZNxju+0uV3c5w2tG8g2tONUPtJIjNKATzU3y
	DCTVW/HasPxkaGD7wMU/1tVas55sECKIulDXs8wfxdlSsj2YsdRJk7539UbS7CeFwa38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tngWh-000eFH-Jw; Thu, 27 Feb 2025 17:14:19 +0100
Date: Thu, 27 Feb 2025 17:14:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 1/3] net: phy: nxp-c45-tja11xx: add support for TJA1121
Message-ID: <a9c98f2a-c5e9-43e3-b77a-0f20eb6cfa98@lunn.ch>
References: <20250227160057.2385803-1-andrei.botila@oss.nxp.com>
 <20250227160057.2385803-2-andrei.botila@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227160057.2385803-2-andrei.botila@oss.nxp.com>

On Thu, Feb 27, 2025 at 06:00:54PM +0200, Andrei Botila wrote:
> Add naming for TJA1121 since TJA1121 is based on TJA1120 but with
> additional MACsec IP.
> Same applies for TJA1103 which shares the same hardware as TJA1104 with
> the latter having MACsec IP enabled.
> 
> Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
> ---
>  drivers/net/phy/Kconfig           | 2 +-
>  drivers/net/phy/nxp-c45-tja11xx.c | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 41c15a2c2037..d29f9f7fd2e1 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -328,7 +328,7 @@ config NXP_C45_TJA11XX_PHY
>  	depends on MACSEC || !MACSEC
>  	help
>  	  Enable support for NXP C45 TJA11XX PHYs.
> -	  Currently supports the TJA1103, TJA1104 and TJA1120 PHYs.
> +	  Currently supports the TJA1103, TJA1104, TJA1120 and TJA1121 PHYs.
>  
>  config NXP_TJA11XX_PHY
>  	tristate "NXP TJA11xx PHYs support"
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 34231b5b9175..244b5889e805 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* NXP C45 PHY driver
> - * Copyright 2021-2023 NXP
> + * Copyright 2021-2025 NXP
>   * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
>   */
>  
> @@ -19,7 +19,9 @@
>  
>  #include "nxp-c45-tja11xx.h"
>  
> +/* Same id: TJA1103, TJA1104 */
>  #define PHY_ID_TJA_1103			0x001BB010
> +/* Same id: TJA1120, TJA1121 */
>  #define PHY_ID_TJA_1120			0x001BB031

Is there a way to tell them apart? Another register somewhere?

	Andrew

