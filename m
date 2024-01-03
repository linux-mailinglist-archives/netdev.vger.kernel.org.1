Return-Path: <netdev+bounces-61151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EED822B67
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE11C22E77
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554F18B0D;
	Wed,  3 Jan 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J2xzDKFW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC918AF1
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S5O56tcQC4vWMrlcAyZtSd/U+zZMlsONGKHie5BZf20=; b=J2xzDKFWkvTvWI8ipd05EdFPt5
	7y4wF7vZCd0UF01oFDAiCCOMbOKtYEX5X3iksH/SROK9+Dr4pm6UpMnTAJwUbDSAoAdAbWhix28AC
	GomTcvcN0Lg4Eg6OQkAi9dQbrzs41krcKBF4clbr6LTiZuBjrYzUORuQn2lJ6wqhD4cr86UxV4seE
	rlWW2e/u21kFnPqnHcOqjAyL6d4ZNE3oI1cL4Zd1k2A8NjR+4tOpGCIgiB5CxCsM1vYm8aWF+CVRv
	LHVqISkx+avUXHvA9qvhTeFgA1ITXx7x63nENki8Xh2FZf5HDj7mSVMUYr+i779yMBb2W70gEmSdM
	gIKfwbig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45214)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKyVT-0007L2-32;
	Wed, 03 Jan 2024 10:29:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKyVW-0006HT-IG; Wed, 03 Jan 2024 10:29:54 +0000
Date: Wed, 3 Jan 2024 10:29:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: extend
 genphy_c45_read_eee_abilities() to read capability 2 register
Message-ID: <ZZU3Ijo2TCIHJvJh@shell.armlinux.org.uk>
References: <20231220161258.17541-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220161258.17541-1-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 05:12:58PM +0100, Marek Behún wrote:
> +/**
> + * genphy_c45_read_eee_cap2 - read supported EEE link modes from register 3.21
> + * @phydev: target phy_device struct
> + */
> +static int genphy_c45_read_eee_cap2(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	/* IEEE 802.3-2018 45.2.3.11 EEE control and capability 2
> +	 * (Register 3.21)
> +	 */
> +	val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE2);
> +	if (val < 0)
> +		return val;
> +
> +	/* The 802.3 2018 standard says the top 6 bits are reserved and should
> +	 * read as 0.
> +	 * If MDIO_PCS_EEE_ABLE2 is 0xffff assume EEE is not supported.
> +	 */
> +	if (val == 0xffff)
> +		return 0;

802.3 also says that unimplemented registers should read as zeros.
Reserved bits should read as 0, but reserved typically means (as we've
seen several times) that bits get used in the future. Do you have a
good reason why this check is necessary?

> +
> +	mii_eee_cap2_mod_linkmode_t(phydev->supported_eee, val);
> +
> +	/* Some buggy devices may indicate EEE link modes in MDIO_PCS_EEE_ABLE2
> +	 * which they don't support as indicated by BMSR, ESTATUS etc.
> +	 */
> +	linkmode_and(phydev->supported_eee, phydev->supported_eee,
> +		     phydev->supported);

I wonder whether we should just do that as a general thing after
reading all the abilities in phy_probe() rather than burying it in
various capability reading functions?

Apart from those two, I don't see any other issues with the patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

