Return-Path: <netdev+bounces-132240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5360991138
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B021C23412
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0237335A5;
	Fri,  4 Oct 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R9djrknF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716183CC7;
	Fri,  4 Oct 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076665; cv=none; b=TAJwdx5AWcLVMGORCpCourOfroa1+Ev5OszUavtwK5lnk7NPDxibxL/30XmUqTDmCzCs1BZU1ygy8zyebi8jMASCvWRJkUOuzor1UJ19T67+XtjsYSjUfYd0u1WDo0LDbadYM082Er06JgXtwaD79hzUf++CGou+L+LogzzzohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076665; c=relaxed/simple;
	bh=jOTbCsBnp/G8HTaYmkg+mD5ft23aOvMRKZFH0rAk+JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZy25jyiGICAR5D683yx54kZbX44JVzgabsRzl41i9HNZvsFowdLBganA13DzWFu0Eay0KkxDpgU+ncEmfwQVcHW+YAr51l8nYIpRuRX/Z3CToh16gXFc/E6ZCqO51VNAl/t0bHAVw/+S4JmAQXZwO9T3WkXKGA1GyGXmPllFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R9djrknF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bEhtIzrPp9DZunn4IGOjtsc6C2T2hBD0JumElPsQGM8=; b=R9djrknF/b49gGcCBtHX6p2/KZ
	STwDrDYvxi46fCEKARwB+VpM2fQflpjRRn6K8FcQAZYJ1PBzkeO5ysFjX2WV5p4aPukvrCtRtBZwN
	PKjM5ZzaeVfLtuUuULa4SXR6GssfyKSCJWD0KzctvbHN3NuZoH27nQ2YTfkE0u5ARh3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swpg0-0095s2-A2; Fri, 04 Oct 2024 23:17:28 +0200
Date: Fri, 4 Oct 2024 23:17:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>

On Fri, Oct 04, 2024 at 04:50:36PM +0100, Daniel Golle wrote:
> Only use link-partner advertisement bits for 10GbE modes if they are
> actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
> unless both of them are set.
> This prevents misinterpreting the stale 2500M link-partner advertisement
> bit in case a subsequent linkpartner doesn't do any NBase-T
> advertisement at all.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/realtek.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index c4d0d93523ad..d276477cf511 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
>  		if (lpadv < 0)
>  			return lpadv;
>  
> +		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
> +		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
> +			lpadv = 0;
> +
>  		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
>  						  lpadv);

I know lpadv is coming from a vendor register, but does
MDIO_AN_10GBT_STAT_LOCOK and MDIO_AN_10GBT_STAT_REMOK apply if it was
also from the register defined in 802.3? I'm just wondering if this
test should be inside mii_10gbt_stat_mod_linkmode_lpa_t()?

	Andrew

