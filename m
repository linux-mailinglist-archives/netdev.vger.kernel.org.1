Return-Path: <netdev+bounces-154706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B009FF885
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F01F18828F1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95218A6A3;
	Thu,  2 Jan 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KOzYWnvM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9330219FF
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735815983; cv=none; b=uQAkMbx9Wy6BwgkVegaKAohSdLb38zINoDQXvnEz0fCawX4CpCOxDoNvIxox3Xva5LACamiNr4C//Dr+ESii0MOXQxJDHeqRwx1l0i8wg0fDoUP1HaSbui1q0GYYhj1jpSrRHvGgG/Va7cODMbbmvHLgYw2H72hnhrWYn/nD+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735815983; c=relaxed/simple;
	bh=IgrWElfheCAEE9tNT1HXJIseKM8ymJil6ZDH3CCLPJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDTv4IqG0ma6ayRmFtLaBJItifQ+n4RSQ3FJPuEe8Cgb+U4gejR8hCbAQ7h3AhROu5nSSPH2yu1UJK253dZqnKVmPuZqCBsC6TRFKviaSh35EewI/crxvst5+8oTtXCRlP0ZlBO9fRk8c1p/GMsUefBLeKizcOYNP6ifQTLtr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KOzYWnvM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fO04ue8aHvHksQ9Fmz2rG9zKFL71H+rPNAeoGotrvuE=; b=KOzYWnvM3bCke3rM178gp0MtvP
	yakkSekDLrFdEG5NZLIdGSd8mJ72n17JATSzgcIEfhZ7vUivPsWyTopReglsq+EXqzmun3mFeW2Wx
	8yyRAk68rUCATVs0VIr4E03y3ROubFarss8MmUI3EenP27yiOY8XdSxmzZJgoJ//fNYCqfDY3ZVTc
	usMnN1+PX+WaHyIc7QtZZgSFDSnNrnZx709ls7SWTgx6nqOPek14LaQSj5ANsEnTeUUsSn17kS1B4
	0ivH1ph6zofaOoyq2Mt6Hup8Z+9g3+zmZeOJWCC2fRGSAspkLVV+hlPiduT+51gCl0J8ILhpGp+Pr
	a+3On8JQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTJ1s-0001vQ-2g;
	Thu, 02 Jan 2025 11:06:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTJ1r-0000Dk-1I;
	Thu, 02 Jan 2025 11:06:15 +0000
Date: Thu, 2 Jan 2025 11:06:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Francesco Valla <francesco@valla.it>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
References: <20250101235122.704012-1-francesco@valla.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101235122.704012-1-francesco@valla.it>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 02, 2025 at 12:51:22AM +0100, Francesco Valla wrote:
> Whenever a new PHY device is created, request_module() is called
> unconditionally, without checking if a driver for the new PHY is already
> available (either built-in or from a previous probe). This conflicts
> with async probing of the underlying MDIO bus and always throws a
> warning (because if a driver is loaded it _might_ cause a deadlock, if
> in turn it calls async_synchronize_full()).

Why aren't any of the phylib maintainers seeing this warning? Where does
the warning come from?

> +static bool phy_driver_exists(u32 phy_id)
> +{
> +	bool found = false;
> +	struct phy_drv_node *node;
> +
> +	down_read(&phy_drv_list_sem);
> +	list_for_each_entry(node, &phy_drv_list, list) {
> +		if (phy_id_compare(phy_id, node->drv->phy_id, node->drv->phy_id_mask)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	up_read(&phy_drv_list_sem);
> +
> +	return found;
> +}
> +

Why do we need this, along with the associated additional memory
allocations? What's wrong with bus_for_each_drv() which the core
code provides?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

