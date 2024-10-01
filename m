Return-Path: <netdev+bounces-130842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F498BBBE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55416B23B03
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301F18E04D;
	Tue,  1 Oct 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kfZIBFzA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B3186607;
	Tue,  1 Oct 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784071; cv=none; b=bB1I6e1xPgIGfFgKG66fds3w8l1e4MQPy6+s0GIHXLPpk48SJhW3RhX2mX7iDMq0KYR3O+D6+MZC89hUJn6StCabx+HF8l4BCAWehELoF7XIBZ02fn91obpAlXIX7R8m6Nw+c7UpWTfvZgZ/fiqllMRK1mjzL2OrmG4PABmGwto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784071; c=relaxed/simple;
	bh=cY21EQWrMTCAZsqYH9XsCHJ3j7F4pn9FB8g+ti4tI50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmgL4GFIrbvqyhIwh7wY8k12qWJG87TpzwS2vZRfXcxTWtDkdcuGB3Qgt+vHHmyIyjzYk1l3UdAvkQOHOKBpPuZUTUp+6Z1roXaIeIenVvxs0criNBzemyZWZVYyaXa5YQfA/QUIz/LxmsmXpbqIO4u9coGEjNGcdIN4x1B4ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kfZIBFzA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ll58dMychfnKYvvq98aQIv+n7E9gr0v/D/YsXSRrda4=; b=kfZIBFzA6djlotTfpobKv5HzcC
	zDSlWmNv8SYo9jpKLmBSd4K4th/Llp8ogVSI8bGtWDNIRm4Is6ShAgToK4JimXFEPxuVdVzBIubuU
	1d0yhyA+jMmzpqORRtKD7dBI7/iCkjRSv36M9sDUe0sl3skfyZe0hEYT6OxkcP/ggmzMQwY28q1z2
	XmyLE3BIf6yQ7aYFZ/s7a7YRawcERl3kN52D4ZLlzRL59fqHI68inIUrVGw+T6jIQOiy2WyM2FLI7
	833y5NnFAJsyr762XoxOhJl8NXD0qrpTn7AaFw0s790kkHSRD/pKavhl4l352hN3HlcZlGWJMmxRw
	LhnxG03A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56312)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1svbYo-0005jd-2w;
	Tue, 01 Oct 2024 13:00:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1svbYl-0004vm-1X;
	Tue, 01 Oct 2024 13:00:55 +0100
Date: Tue, 1 Oct 2024 13:00:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Halaney <ahalaney@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v5 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
Message-ID: <Zvvkd1Xi4/rmWQRf@shell.armlinux.org.uk>
References: <20240930223341.3807222-1-quic_abchauha@quicinc.com>
 <20240930223341.3807222-3-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930223341.3807222-3-quic_abchauha@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Mon, Sep 30, 2024 at 03:33:41PM -0700, Abhishek Chauhan wrote:
> +static int aqr111_get_features(struct phy_device *phydev)
> +{
> +	/* PHY FIXUP */
> +	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
> +	aqr115c_get_features(phydev);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported);

More or less same as the previous. The comment could do with shortening.
I think for this linkmode_set_bit(), it's not worth using a local
"supported" variable, so just put phydev->... on the following line to
avoid the long line.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

