Return-Path: <netdev+bounces-51513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6F37FAF48
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A838A28161E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393F410FE;
	Tue, 28 Nov 2023 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kzCl7mU4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2F1AD;
	Mon, 27 Nov 2023 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3k930X9SZ1xl7hqd5sIP8eSDgOCRA4zfABZQSE/mjjw=; b=kzCl7mU4ZFsAPnXZ6ZXSivhecJ
	vhJYGJfX9edWsDN0Wcotd30VM23RsEKfcF8arhsNjXX7b0uIrh5ULBI2OTD0vtIRMMp7RxYUZRe3w
	6XYmhCuuNaItkSvXj+dXDMyoL2b7aNZiXRusFpaWCZpPl+Wb/GwltnCC5rArCFBCCPDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7mJd-001P0K-TJ; Tue, 28 Nov 2023 01:51:05 +0100
Date: Tue, 28 Nov 2023 01:51:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/4] net: phy: add support for PHY package
 MMD read/write
Message-ID: <43255cdd-9e1e-472a-9263-04db0259b3cb@lunn.ch>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126235141.17996-4-ansuelsmth@gmail.com>

On Mon, Nov 27, 2023 at 12:51:41AM +0100, Christian Marangi wrote:
> Some PHY in PHY package may require to read/write MMD regs to correctly
> configure the PHY package.
> 
> Add support for these additional required function in both lock and no
> lock variant.
> 
> It's possible to set is_c45 bool for phy_package_read/write to true to
> access mmd regs for accessing C45 PHY in PHY package for global
> configuration.

I would just use phydev->is_c45. I would be very surprised if you have
a package with some PHYs being only C22 and some C45.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Rework to use newly introduced helper
> - Add common check for regnum and devad
> 
>  include/linux/phy.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 96f6f34be051..3e507bd2c3b4 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2085,6 +2085,84 @@ static inline int __phy_package_write(struct phy_device *phydev,
>  	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
>  }
>  
> +static inline int phy_package_read_mmd(struct phy_device *phydev,
> +				       unsigned int addr_offset, bool is_c45,
> +				       int devad, u32 regnum)
> +{

I also don't know why this should be in the header file?

  Andrew

