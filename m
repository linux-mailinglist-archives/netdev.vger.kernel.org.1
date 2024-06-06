Return-Path: <netdev+bounces-101221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95028FDC8B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE121F246FD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1A17580;
	Thu,  6 Jun 2024 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3FOQwrFn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47841640B;
	Thu,  6 Jun 2024 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639845; cv=none; b=fFd6Wwy3XKOZ/ScX1rYcWfyCOFW7p28EtymBKFSdMQiX6VXQYv2eAvv/vZcZzjs17ndSkhAdVhwb6F6+Mp5ISGV73xiAHNz413nMD9YjMBoI9P5oB6lfzZ1eZ1+H+/OaM4MZLXJoFrMDMqSKB0e32dvrm7cU8nT2oDno9qsCXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639845; c=relaxed/simple;
	bh=rzkXo4IiaYMRDDc4Kh6uXteBk5BmEOFOnfDbjMu0Pks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+Zm+I1zf99IiS2fgyCEIO+Ic0UqYsyHgt36KKdFIF4VS3nejHHN9zyACLvoU+NF9oBT7fi1Vqq8yAQ2JpeA5hDyzIh+jDbn95lXtwKkzfJeUhJGkUDvda7pgD6qWpANHTA8dh8NCxCpia4+Kdf24gszL3ystUj1xX5SNdGnBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3FOQwrFn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EiYcxxAUjvaXFSXD8Eyyj23c1fzGWFwSW2rcb3xgMqw=; b=3F
	OQwrFnv1lMS+Ax3bpro3dfWTZhMVDenFAvHSiWuA5iliO1aKS2NCfJautCPMsx+jyXyinAJT2YDPG
	rwV9/Z2RxGdwhx9ey29Gfwx75Zwp2LU8rTCCoOIW+aQkNHsKB2Hyk02vECSu0HcEuQhDIZKpuwTF+
	AgPhUwyQ289RuBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF2aO-00Gy1b-3w; Thu, 06 Jun 2024 04:10:40 +0200
Date: Thu, 6 Jun 2024 04:10:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <7a313ff6-574b-425d-be06-23bb588402c8@lunn.ch>
References: <20240605095646.3924454-1-kamilh@axis.com>
 <20240605095646.3924454-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605095646.3924454-4-kamilh@axis.com>

On Wed, Jun 05, 2024 at 11:56:46AM +0200, Kamil Horák - 2N wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.
> 
> Change-Id: I592d261bc0d60aaa78fc1717a315b0b1c1449c81
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---
>  drivers/net/phy/bcm-phy-lib.c | 123 ++++++++++++
>  drivers/net/phy/bcm-phy-lib.h |   4 +
>  drivers/net/phy/broadcom.c    | 368 ++++++++++++++++++++++++++++++++--
>  drivers/net/phy/phy-core.c    |   2 +-
>  include/linux/brcmphy.h       |   9 +
>  5 files changed, 488 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
> index 876f28fd8256..cc1b5e5a958c 100644
> --- a/drivers/net/phy/bcm-phy-lib.c
> +++ b/drivers/net/phy/bcm-phy-lib.c
> @@ -794,6 +794,47 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
>  	return ret;
>  }
>  
> +static int bcm_setup_forced(struct phy_device *phydev)
> +{
> +	u16 ctl = 0;
> +
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->speed == SPEED_100)
> +		ctl |= LRECR_SPEED100;
> +
> +	if (phydev->duplex != DUPLEX_FULL)
> +		return -EOPNOTSUPP;
> +
> +	return phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_SPEED100, ctl);

We should consider naming here. I assume this will not work for IEEE
forced mode? So maybe this should have _lre_ or _brr_ in the name to
make it clear what it actually does.

> +}



> +
> +/**
> + * bcm_linkmode_adv_to_mii_adv_t
> + * @advertising: the linkmode advertisement settings
> + * @return: LDS Auto-Negotiation Advertised Ability register value
> + *
> + * A small helper function that translates linkmode advertisement
> + * settings to phy autonegotiation advertisements for the
> + * MII_BCM54XX_LREANAA register of Broadcom PHYs capable of LDS
> + */
> +static u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)
> +{
> +	u32 result = 0;

Make here, and maybe lre_advertising?

Please go through all the functions and think about naming.

    Andrew

---
pw-bot: cr

