Return-Path: <netdev+bounces-217650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C0B396EA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D5C3B4843
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CF2D97B0;
	Thu, 28 Aug 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s22bNZpw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F92BEC3D;
	Thu, 28 Aug 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369678; cv=none; b=mvFEXOVjJMfvf72giUBuPfUDkPmP/pxX5GF6My4JG1EXfPYr0GIUerdWObpcQv7asDQ5cJx2GL1A3sCaHILoOVM4uYhJysOAjLCb9+A73UjDKgxCmVIUliJ/w9u+6kFSGRJUm4Q0+PS3GQWvEHDVpNreu+S0YHJLMZAU9V1Ypkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369678; c=relaxed/simple;
	bh=Y76Dx76vOBXa6n0mEfflv6F1UIaIvsxYHvAk8TClxF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7f+sp7WYvG9fZRYkULos40ql7x3/EcOUf/BbqJHJa0ZiYrXB2PVlZDP6KZtX+Mg3/+1QiXPV1OYSo1PTvBAAPop4Zunb2wryJieHkR+cO8V1fXCx8oNt/+g4FUOvaPXawnXgfLIIKblxjXv/IIEomrfgHQFLKsUOMFreiO+P44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=s22bNZpw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XGYkP2gK5LTeip2gHE6K5obfBAJQ5rJDF/wdnYSYD8c=; b=s22bNZpwc+tTVTep7ZCnSwN27m
	FdtCOokLxIH5/HOdulNa7Ag8FLrLfdIC5ZpQVlDvWRy2dlTVjLCFyABghD5D6otlXxqwmfpSSXhXH
	th69qyiJv2l7qsLRRl7OXfZW/wb9Ezy5eKxIaUt84Jymujv0/ZeTA6WllRRXm6tsEbuij60PXhyXi
	6aYsXGkWUud58DzC/PhIMO7kkXWgX5EaFckjUp+dMLOQiIk1dPcdLhCPbtDc0EBkqWzZDhJtlpmbw
	ql97PL4GhbGTWXSrQVBW3nnxcfAYQMuLYQD1OXk3bIU3c9lZFNZKVUaO6c+KuXUdGdzOIFqj7uo0D
	bU2X9P0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46508)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urXyr-000000001MK-48J0;
	Thu, 28 Aug 2025 09:27:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urXyo-000000002zn-0sNE;
	Thu, 28 Aug 2025 09:27:34 +0100
Date: Thu, 28 Aug 2025 09:27:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, Parthiban.Veerasooran@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <aLAS9SV_AhEeQIGM@shell.armlinux.org.uk>
References: <20250828073425.3999528-1-horatiu.vultur@microchip.com>
 <20250828073425.3999528-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828073425.3999528-3-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Just a few comments.

On Thu, Aug 28, 2025 at 09:34:25AM +0200, Horatiu Vultur wrote:
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 9a90818481320..95ba1a2859a9a 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -457,6 +457,9 @@ struct lan8842_phy_stats {
>  
>  struct lan8842_priv {
>  	struct lan8842_phy_stats phy_stats;
> +	int rev;

Maybe make this a u16 and move it at the end of the struct?

> +	struct phy_device *phydev;

Why do you need this member? In this patch, you initialise this, but
never use it.

> @@ -5817,6 +5833,41 @@ static int lan8842_probe(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Revision lan8832 doesn't have support for PTP, therefore don't add
> +	 * any PTP clocks
> +	 */
> +	priv->rev = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +					 LAN8842_SKU_REG);
> +	if (priv->rev < 0)
> +		return priv->rev;

	ret = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
				   LAN8842_SKU_REG);
	if (ret < 0)
		return ret;

	priv->rev = ret;

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

