Return-Path: <netdev+bounces-113607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E193F450
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857002802E6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233E145B16;
	Mon, 29 Jul 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LWjeg9qb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFB145330;
	Mon, 29 Jul 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253308; cv=none; b=VuqUeqxLY3LjU15d6xo2q/yKHGs4IYkSgRGOT8WqYPW4mAehg2RKv0ZegzhCeGsz2SmAUU7abv/MJ5Bk3hr8yZsLqTPgmXnRpI9TMKIApeQz4PMYgXhgoo+8EVEbxtTAKjbvpkiqpYPFU8BszFXSZ5Xtcbsxx2zy/izHwLO6AMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253308; c=relaxed/simple;
	bh=JRrHbiKlytnHj6P/j86pANIOFLHYhVfQU9hbiPuPzM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwP/A3o9u9LPdiJrBjohZ9L/9aqq0v/Dwh3JXhAj/qjUbojE06Vm6tcP6zv5QEwJFa2GoNGl36qxKFZxrcHdwlpYV4VHsHijtod44dXNqDEAFFCm1CJvoAWlmeTC4YbMe6xq9klgvl8+gpDYUhVhR3AJJ5poAVvtgd5GiXpdHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LWjeg9qb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MIEWQH2EbsC6quDfk/x97k807fOjv5v98y+H4O3aEqc=; b=LWjeg9qbZoz8Yy5ZZwr/a+sh7A
	njMK0Rr8wOmMpILkmPLL8ptcF+wpWIY6m2BuPN97PZ/traVbLxVqcEVK/LSHIIQW/e3IzqfsS/Dg4
	8oF/L7QuB2gdnH1jWT2sYV3Uz26gDxxpcgl56wazNzhEu9dt2RL0q1ejXUCnpcmfdG4D9sBGRdBwz
	GRhG3hKiKhMTWzpoCeas1cu8yRgT0gPcrz6NsIDv8rumRHm/5bF1Q/vgDZPuqWCiyyTrzWjttmkjQ
	CuZ/cqOGprt9q+RiHwML+vE0tX549zIVu+udwZcz7rw3PORr4GP9FyjhnVN/a9GfQ59VGDsE56eo2
	ItNP/S/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47642)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYOkp-00049A-2P;
	Mon, 29 Jul 2024 12:41:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYOks-0004IU-KC; Mon, 29 Jul 2024 12:41:30 +0100
Date: Mon, 29 Jul 2024 12:41:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Frank.Sae" <Frank.Sae@motor-comm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com, xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G
 ethernet phy
Message-ID: <Zqd/6u5b7z1bCFaT@shell.armlinux.org.uk>
References: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 27, 2024 at 02:20:31AM -0700, Frank.Sae wrote:
> +/**
> + * yt8821_config_init() - phy initializatioin
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8821_config_init(struct phy_device *phydev)
> +{
> +	struct yt8821_priv *priv = phydev->priv;
> +	int ret, val;
> +
> +	phydev->irq = PHY_POLL;
> +
> +	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
> +	if (priv->chip_mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
> +		ret = ytphy_modify_ext_with_lock(phydev,
> +						 YT8521_CHIP_CONFIG_REG,
> +						 YT8521_CCR_MODE_SEL_MASK,
> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 0));
> +		if (ret < 0)
> +			return ret;
> +
> +		__assign_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			     phydev->possible_interfaces,
> +			     true);
> +		__assign_bit(PHY_INTERFACE_MODE_SGMII,
> +			     phydev->possible_interfaces,
> +			     true);

Before each and every call to .config_init, phydev->possible_interfaces
will be cleared. So, please use __set_bit() here.

> +static int yt8821_read_status(struct phy_device *phydev)
> +{
> +	struct yt8821_priv *priv = phydev->priv;
> +	int old_page;
> +	int ret = 0;
> +	int link;
> +	int val;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		int lpadv = phy_read_mmd(phydev,
> +					 MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
> +
> +		if (lpadv < 0)
> +			return lpadv;
> +
> +		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> +						  lpadv);
> +	}
> +
> +	ret = ytphy_write_ext_with_lock(phydev,
> +					YT8521_REG_SPACE_SELECT_REG,
> +					YT8521_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	val = __phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
> +	if (val < 0) {
> +		ret = val;
> +		goto err_restore_page;
> +	}
> +
> +	link = val & YTPHY_SSR_LINK;

What link status is this reporting? For interface switching to work,
phydev->link must _only_ indicate whether the _media_ side interface
is up or down. It must _not_ include the status of the MAC facing
interface from the PHY.

Why? The interface configuration of the MAC is only performed when
the _media_ link comes up, denoted by phydev->link becoming true.
If the MAC interface configuration mismatches the PHY interface
configuration, then the MAC facing interface of the PHY will
remain down, and if phydev->link is forced to false, then the link
will never come up.

So, I hope that this isn't testing the MAC facing interface status
of the PHY!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

