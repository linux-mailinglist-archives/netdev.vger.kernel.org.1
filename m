Return-Path: <netdev+bounces-119403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4795577A
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1151F21403
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C603614BFB0;
	Sat, 17 Aug 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qKhT/DkC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FA1487E3;
	Sat, 17 Aug 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894601; cv=none; b=dfftjKMn6A159rw6C+ZKJn3RPTXc47ZwN4IER3eFc8zleCLrDqc5NRgjNeTFoL3hFCxeUjpjckNtOlYywPhFxcH2dJtNYD/Vq+NUizBKbIRRSp/EnLdCn/CzarkOJLY00AZncsNF+HaeX52NrSxatPQmDS05k1C/AupTZ6ulBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894601; c=relaxed/simple;
	bh=FoXN34tCCnY5LpfkOruPe2wZCn8mbJnZQrAuXAAbunw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYCdtV9s8KzIrwCKbTbHpmbT/e0DLuVR6AEz2kMT0QDj7Zpq69TMgtS8q5mk78qBJ90r9DCT/IjOuKc3NtGc8JSRpS4HULHjvzsYlkaKuvTHI1j9W0+AgggE/dBG9r1JG2L8/Q2B97akA9MDidM5QbezPCA+d11+jZE+vHyZCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qKhT/DkC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xIYM1b3GKgy5NSFhjv/KLy3Bp9KYexM4qTA6DMc+TkM=; b=qKhT/DkC8HXg8Uw6l8SEH+bzka
	qw9pjtw3q0umgIEifX4qda243SK+kIRg75PtJFuBk0zvvp8oiLSSwGSIf0WfrX/WYxT3n4YR4LIUv
	kdG1unk7f6vw/HbAqGWrDUQazxrqHwdQuVIkU8hL+wuR/hLi9EkFsT9w0oYEbBCTY6KancVLmUF0j
	INspdQYdo2JVxwSUK+AUPpWgPemppA2gdoiGB4XxstKb/cY7v9DogvhOn8L3SlMRDXIn7/GF4ctru
	30+LVTJDbda4gwPA/eDs+tSw6PYJBUuCLEg08JcXbXL/VCAhKqGlr2DvzYyUC2s/KbK7ho/0vSvHP
	bQ2hjU7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55714)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sfHjD-0006oj-1P;
	Sat, 17 Aug 2024 12:36:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sfHjF-00055c-GW; Sat, 17 Aug 2024 12:36:17 +0100
Date: Sat, 17 Aug 2024 12:36:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add driver for Motorcomm
 yt8821 2.5G ethernet phy
Message-ID: <ZsCLMQWoZcVV+7xR@shell.armlinux.org.uk>
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
 <20240816060955.47076-3-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816060955.47076-3-Frank.Sae@motor-comm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 15, 2024 at 11:09:55PM -0700, Frank Sae wrote:
> +static int yt8821_get_rate_matching(struct phy_device *phydev,
> +				    phy_interface_t iface)
> +{
> +	int val;
> +
> +	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
> +	if (val < 0)
> +		return val;
> +
> +	if (FIELD_GET(YT8521_CCR_MODE_SEL_MASK, val) ==
> +	    YT8821_CHIP_MODE_FORCE_BX2500)
> +		return RATE_MATCH_PAUSE;

Does this device do rate matching for _any_ interface mode if it has
this bit set - because that's what you're saying here by not testing
"iface". From what I understand from your previous posting which
included a DT update, this only applies when 2500base-X is being
used as the interface mode.

> +static int yt8821_aneg_done(struct phy_device *phydev)
> +{
> +	int link;
> +
> +	link = yt8521_aneg_done_paged(phydev, YT8521_RSSR_UTP_SPACE);
> +
> +	return link;
> +}

Why not just:

	return yt8521_aneg_done_paged(phydev, YT8521_RSSR_UTP_SPACE);

?

> +/**
> + * yt8821_config_init() - phy initializatioin
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8821_config_init(struct phy_device *phydev)
> +{
> +	u8 mode = YT8821_CHIP_MODE_AUTO_BX2500_SGMII;
> +	int ret;
> +	u16 set;
> +
> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX)
> +		mode = YT8821_CHIP_MODE_FORCE_BX2500;

Hmm, I think this is tying us into situations we don't want. What if the
host supports 2500base-X and SGMII, but does not support pause (for
example, Marvell PP2 based hosts.) In that situation, we don't want to
lock-in to using pause based rate adaption, which I fear will become
a behaviour that would be risky to change later on.

> +
> +	set = FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, mode);
> +	ret = ytphy_modify_ext_with_lock(phydev,
> +					 YT8521_CHIP_CONFIG_REG,
> +					 YT8521_CCR_MODE_SEL_MASK,
> +					 set);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  phydev->possible_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  phydev->possible_interfaces);
> +
> +		phydev->rate_matching = RATE_MATCH_NONE;
> +	} else if (mode == YT8821_CHIP_MODE_FORCE_BX2500) {

		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
			  phydev->possible_interfaces);

so that phylink knows you're only going to be using a single interface
mode. Even better, since this is always supported, move it out of these
if() statements?


Also, it would be nice to have phydev->supported_interfaces populated
(which has to be done when the PHY is probed) so that phylink knows
before connecting with the PHY which interface modes are supported by
the PHY. (Andrew - please can we make this a condition for any new PHYs
supported by phylib in the future?)

Note the point below in my signature.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

