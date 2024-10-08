Return-Path: <netdev+bounces-132995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F59942C4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EBE28BF7F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A91E0DDC;
	Tue,  8 Oct 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HlgXsr5/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8B1DF992;
	Tue,  8 Oct 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376301; cv=none; b=mhB3iTuovZB5VWiTLMqdWK8RpB90KhdUudwG6MadhxX9iIMgNBKb2Ce4NrvADAgU3HTVy8VSSsXHpQpspNvakc8NL1EmHap0fW2O7rnsylhuKT7FkVxECoT0AULBA6Sx5WQRHhmY/9K4jKzDiF0U1rJBYYBhTz/SEQ+swRfurzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376301; c=relaxed/simple;
	bh=uiQgzBxJtxFIFzFO1Q0G8G8iZ07N4T2ckZhzqXQ2b3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh9yKkyZLp5Rxwe6YXcjX537bnleuJ6rTobnUxT15RElMPsKngwLPhCQm+6XHt+RK5unOyke8RpG5dbhZg3kpmmwbnIJ/b3F3m0H6n9xY0gde4ZLTFbNyXOcJmF03zb0JLjiRQHUgMtTjVl/X553K7LieMdnt+8FzJ5BUBSEFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HlgXsr5/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KUKKV+hhxMy1Mw968oqWoUVxYocxrQgxcW/UOjKQ9Mk=; b=HlgXsr5/jd9oezKVg0NBeFTKO2
	CBGJa5KUUZY2kFnjnzqjArSBEnHalFO+Y8EGhSedaGziaWUg1J9+HnTdlxKUhGygX6IV+XgL01jQh
	nbCvBCzyKTNkuJnYbMCTV5IVingoevoyK/1jG8wd+BLW7u5eUSuTkcyBsUIQMP6QBdh7x58sh5QaP
	rYoQT3/7qum5GTTe4dYV/lQRgtx4jPaUyVuvg/nYQxZ5I9s19cxM0hx7xJPSculULQFwZokHbMObf
	WbOpIM7H1RiaBcjSGVbGdpCsyv+rnC7rfZaaMkoa1f/Hje570PjKJAORdSEjW5X3NpDFc2ohK0hrP
	9eKkiMbA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34528)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sy5ck-00077R-0b;
	Tue, 08 Oct 2024 09:31:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sy5cf-00052g-14;
	Tue, 08 Oct 2024 09:31:13 +0100
Date: Tue, 8 Oct 2024 09:31:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	hkallweit1@gmail.com, andrei.botila@oss.nxp.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for
 outputing RMII reference clock
Message-ID: <ZwTt0R_n40ohJqH1@shell.armlinux.org.uk>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
 <20241008070708.1985805-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008070708.1985805-3-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 08, 2024 at 03:07:08PM +0800, Wei Fang wrote:
> @@ -1561,8 +1565,13 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
>  			phydev_err(phydev, "rmii mode not supported\n");
>  			return -EINVAL;
>  		}
> -		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
> -			      MII_BASIC_CONFIG_RMII);
> +
> +		if (priv->flags & TJA11XX_REVERSE_MODE)
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
> +				      MII_BASIC_CONFIG_RMII | MII_BASIC_CONFIG_REV);
> +		else
> +			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
> +				      MII_BASIC_CONFIG_RMII);

Netdev has an 80 column limit, and this needs commenting because we have
PHY_INTERFACE_MODE_REVRMII which could be confused with this (although
I haven't checked.)

		u16 basic_config;
		...
		basic_config = MII_BASIC_CONFIG_RMII;

		/* This is not PHY_INTERFACE_MODE_REVRMII */
		if (priv->flags & TJA11XX_REVERSE_MODE)
			basic_config |= MII_BASIC_CONFIG_REV;

		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
			      basic_config);

is much nicer to read.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

