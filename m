Return-Path: <netdev+bounces-211148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E832B16E86
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3529563B73
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2A2BD5A3;
	Thu, 31 Jul 2025 09:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6381E567
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953861; cv=none; b=lCDY82V64535xyTRTuG9l3MnevpWlm8I5IlYbQLBT3RK3ECP6/OyGYteFblCgtd/NSj1ONq0pm67sMN75pULASJB+riDAKgqL1DotL3GDwjqUN3RihrGJQaGAWjn+jbWIKjyQ2XAC2HzR4g7wS4mSDpqSP4vzNuRdIn52wEwjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953861; c=relaxed/simple;
	bh=F1R4nqAiSjktmNShlwq3cSdO+NSA21hWenMgeb5XPXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFrEaIs/Xli6rfdht3e7T3pG3MzZ08jfPicVRUPCFjdzdA2m3ickR2T320pih9L616/RJsm37NdUzD8oHmqej49o/lP+v1GdGAClKs+Pms/hYCmaQbnr/eYcukLqXdFIVQNNPMvxV2e2wWW3Lgg1puNv11CUpap72ZyDpcevqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uhPW7-000000002Pa-0P6W;
	Thu, 31 Jul 2025 09:24:03 +0000
Date: Thu, 31 Jul 2025 10:23:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michael@fossekall.de, netdev@vger.kernel.org,
	jan@3e8.eu
Subject: Re: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Message-ID: <aIs2KVi6rYVhTzde@pidgin.makrotopia.org>
References: <20250731054445.580474-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731054445.580474-1-markus.stockhausen@gmx.de>

On Thu, Jul 31, 2025 at 01:44:45AM -0400, Markus Stockhausen wrote:
> The RTL8226-CG can be found on devices like the Zyxel XGS1210-12. These
> are driven by a Realtek RTL9302B SoC that has phy hardware polling
> in the background. One must decide if a port is polled via c22 or c45.
> Additionally the hardware disables MMD access in c22 mode. For reference
> see mdio-realtek-rtl9300 driver. As this PHY is mostly used in Realtek
> switches Convert the phy to a c45-only function set.
> 
> [...]
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index dd0d675149ad..8bc68b31cd31 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> [...]
> @@ -1675,11 +1690,12 @@ static struct phy_driver realtek_drvs[] = {
>  	}, {
>  		PHY_ID_MATCH_EXACT(0x001cc838),
>  		.name           = "RTL8226-CG 2.5Gbps PHY",
> -		.get_features   = rtl822x_get_features,
> -		.config_aneg    = rtl822x_config_aneg,
> -		.read_status    = rtl822x_read_status,
> -		.suspend        = genphy_suspend,
> -		.resume         = rtlgen_resume,
> +		.soft_reset     = rtl822x_c45_soft_reset,
> +		.get_features   = rtl822x_c45_get_features,
> +		.config_aneg    = rtl822x_c45_config_aneg,
> +		.read_status    = rtl822x_c45_read_status,
> +		.suspend        = genphy_c45_pma_suspend,
> +		.resume         = rtlgen_c45_resume,
>  		.read_page      = rtl821x_read_page,
>  		.write_page     = rtl821x_write_page,

I suppose .read_page and .write_page can then be dropped as well as paged
Clause-22 access is no longer needed, right?


