Return-Path: <netdev+bounces-159630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD7A16334
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E68E16438A
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AED45023;
	Sun, 19 Jan 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LPld0bsq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2A6125;
	Sun, 19 Jan 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307232; cv=none; b=ku0doJbVq1xT62sZI71aDhu3+19pOwlskfxQ2WrCqZ+XyeBt9OR3lLSvhqAA2U43uQcbGdAaS8byujKBf6ZrIpoNB1WpGoDSc4pCTA+4htiPFEwUmPeI6kQwI0zVd4KXNarEfuONFomyUDvLWAyL5QaqKfwJp5c4e9X2eltRKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307232; c=relaxed/simple;
	bh=J7v+BgIY5shT8MHdg4IpkqYCZQ3Diu+7902fJTq5oos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzUzcpuncqBWG4lXC/7cVRBZWOwYCFlcQgFSjyRLZO30tSxtHHOGfuqzWJhjCwQX48iNdGqWy6g+yzF01FJgW9++EKsyZBgxU5tLxpgSPWzl+eXT+8xQho4zmf+fdn+tkBSibWYSms4qnVnLcTUp/oGf6fekyqVfHYhJf6hME1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LPld0bsq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ccUdV+bJB0JqpX+VeyHCjAkIupowyxA6d+tOpsGgVs8=; b=LPld0bsqaGGBAyeqvvQre2TI23
	miBlbXSrArijsZvPeONXoENHJdsXIGQEi9LK2NJdr6jhD1RpFJja6Kwz8Ii330917aD1RZv4CqPSF
	WtKZ1/51B9vBAojad7ShDX/VrN3J3Keah9SOvqSm/ZYRT2SghI5OaCwnC3bqhnyYFeIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZYy9-0066hN-2y; Sun, 19 Jan 2025 18:20:17 +0100
Date: Sun, 19 Jan 2025 18:20:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 2/3] net: phy: mediatek: Move some macros to
 phy-lib for later use
Message-ID: <af88a47d-9514-4969-9b39-a387d51fdf82@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116012159.3816135-3-SkyLake.Huang@mediatek.com>

On Thu, Jan 16, 2025 at 09:21:57AM +0800, Sky Huang wrote:
> From: Sky Huang <skylake.huang@mediatek.com>
> 
> Move some macros to phy-lib because MediaTek's 2.5G built-in
> ethernet PHY will also use them.
> 
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
> ---
>  drivers/net/phy/mediatek/mtk-ge.c | 4 ----
>  drivers/net/phy/mediatek/mtk.h    | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> index 79663da..937254a 100644
> --- a/drivers/net/phy/mediatek/mtk-ge.c
> +++ b/drivers/net/phy/mediatek/mtk-ge.c
> @@ -8,10 +8,6 @@
>  #define MTK_GPHY_ID_MT7530		0x03a29412
>  #define MTK_GPHY_ID_MT7531		0x03a29441
>  
> -#define MTK_PHY_PAGE_EXTENDED_1			0x0001
> -#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
> -#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
> -
>  #define MTK_PHY_PAGE_EXTENDED_2			0x0002
>  #define MTK_PHY_PAGE_EXTENDED_3			0x0003
>  #define MTK_PHY_RG_LPI_PCS_DSP_CTRL_REG11	0x11
> diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
> index 712a9f0..cda1dc8 100644
> --- a/drivers/net/phy/mediatek/mtk.h
> +++ b/drivers/net/phy/mediatek/mtk.h
> @@ -8,7 +8,11 @@
>  #ifndef _MTK_EPHY_H_
>  #define _MTK_EPHY_H_
>  
> +#define MTK_PHY_AUX_CTRL_AND_STATUS		0x14
> +#define   MTK_PHY_ENABLE_DOWNSHIFT		BIT(4)
> +
>  #define MTK_EXT_PAGE_ACCESS			0x1f
> +#define MTK_PHY_PAGE_EXTENDED_1			0x0001
>  #define MTK_PHY_PAGE_STANDARD			0x0000
>  #define MTK_PHY_PAGE_EXTENDED_52B5		0x52b5

A patch like this i can easily review. I can see somethings removed
from one file and added to another, without any changes. It is
obviously correct, and toke about 10 seconds to review.

Another way to look at this. Say somebody reports your previous patch
breaks their system. How are you going to debug it? If rather than
being one huge patch, it was 10 simpler patches, you could ask them to
run a git bisect. That will narrow down the code where you need to
look for the bug to 1/10 of the code. And that one patch will
hopefully be a lot simpler, making the code inspection to find the
problem a lot simpler....

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

