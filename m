Return-Path: <netdev+bounces-118866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093149535FB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B431D282E76
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5771AED41;
	Thu, 15 Aug 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrBgl2ZH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420319D89D;
	Thu, 15 Aug 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732973; cv=none; b=Qw4fTnZJmEZKXCwN+GLPou1IdQdtiRBcG0CGbKmXmmp/Fvf6cfsVFd+rpNqaqqxooAZ3y++z8LBegpN8Jf74jbe6bXHOs2U13YVbNN2tgq3Tn/tG6shstYUo/aw0oN9I3eoOXlR8tYvbC02NWiiOwb6DZqZvWZhLoIyw6Kvu+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732973; c=relaxed/simple;
	bh=bBXh6kYTTgi9MjJkwNqZSkd5ZjNPCu6uClsTZcZBw00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV40JTmEvu9Ke24j9PTfMOW1lc6h0IaVnay1e7jPL2cc+0PeKHVH3IgG5ruOLwLakFI2Q/aNZFkTRax1AAr8mRHmTWafTKy0wfjowXEjvb/3PrmUtwxHWIz1BBBh2touDeliYhi6G1gf/nj457CVybDGWQRv+/ft5YGCMawAgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrBgl2ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E0BC32786;
	Thu, 15 Aug 2024 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723732973;
	bh=bBXh6kYTTgi9MjJkwNqZSkd5ZjNPCu6uClsTZcZBw00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrBgl2ZHr7mefzi+wNxigOZl5d8WLC+stExumTJ+IY72s4ivFNvWEP3hpFiyi2SxZ
	 jcEyjRj1swk9iHH2azkFjuCHilrOYneLbgBQ0HTz4ZGbe4c+cs45hWKW8fuDftBEHM
	 i2/FGokcI+aarAer2EA7QGR9IZXA7GqRA0Tu1sumvdp1dszeNkaBvfNFaBZiFEZJCp
	 iLxvzBlOsKStWUyD0PE0GqPCAhV9gEupfHPNF7+o/CTE3syMOn7ADYCwT3yMoErqOg
	 Jw+9rw6exhDwc3odftHL0WZASdyAGi9BLYlmpo4f5Uqtd6qseh/UcMHajvREJFdvMZ
	 IPdsOviboiReA==
Date: Thu, 15 Aug 2024 15:42:48 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ramon.nordin.rodriguez@ferroamp.se,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Message-ID: <20240815144248.GF632411@kernel.org>
References: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
 <20240812134816.380688-6-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812134816.380688-6-Parthiban.Veerasooran@microchip.com>

On Mon, Aug 12, 2024 at 07:18:14PM +0530, Parthiban Veerasooran wrote:
> This patch adds support for LAN8670/1/2 Rev.C1 as per the latest
> configuration note AN1699 released (Revision E (DS60001699F - June 2024))
> https://www.microchip.com/en-us/application-notes/an1699
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  drivers/net/phy/Kconfig         |  2 +-
>  drivers/net/phy/microchip_t1s.c | 68 ++++++++++++++++++++++++++++++++-
>  2 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 68db15d52355..63b45544c191 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -282,7 +282,7 @@ config MICREL_PHY
>  config MICROCHIP_T1S_PHY
>  	tristate "Microchip 10BASE-T1S Ethernet PHYs"
>  	help
> -	  Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0/B1
> +	  Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
>  	  Internal PHYs.
>  
>  config MICROCHIP_PHY
> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index d0af02a25d01..62f5ce548c6a 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c
> @@ -3,7 +3,7 @@
>   * Driver for Microchip 10BASE-T1S PHYs
>   *
>   * Support: Microchip Phys:
> - *  lan8670/1/2 Rev.B1
> + *  lan8670/1/2 Rev.B1/C1
>   *  lan8650/1 Rev.B0/B1 Internal PHYs
>   */
>  
> @@ -12,6 +12,7 @@
>  #include <linux/phy.h>
>  
>  #define PHY_ID_LAN867X_REVB1 0x0007C162
> +#define PHY_ID_LAN867X_REVC1 0x0007C164
>  /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
>  #define PHY_ID_LAN865X_REVB 0x0007C1B3
>  
> @@ -243,7 +244,7 @@ static int lan865x_revb_config_init(struct phy_device *phydev)
>  		if (ret)
>  			return ret;
>  
> -		if (i == 2) {
> +		if (i == 1) {
>  			ret = lan865x_setup_cfgparam(phydev, offsets);
>  			if (ret)
>  				return ret;

Hi Parthiban,

This patch is addressing LAN867X Rev.C1 support.
But the hunk above appears to update LAN865X Rev.B0/B1 support.
Is that intentional?

...

