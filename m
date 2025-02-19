Return-Path: <netdev+bounces-167664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C859BA3BABE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46203B65BA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69201BD9D3;
	Wed, 19 Feb 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Zy9X1JhI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259317A30C;
	Wed, 19 Feb 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957653; cv=none; b=liHDWgaDiKPPNkJlXf7EkPc4mZxL0iTESAFbzcsyzaiUggd0XoDeOHP+SYLt2poCZVWGYGJ9Upx63jnIXG6hc4l/Z7qCvcVEBp6kAuGghSNqB6EJ/tEWzHe3WwfIGfDtKXfRr8t2tx9XZ9Vl4PVMVMlGjkLvT+5DaGeMWOB+l9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957653; c=relaxed/simple;
	bh=LVjYs3+R2Y0RSYxVDr9by6OtNXzH5dBxzqN9Q5FeqLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih7hHlvQi/e9BDd1hsWq/OTzEzjU1GBP4dinW8Nx00HXGShK4a7OfGKr2IrqWSyrSsWC+Tyh5Y39M/WF0zDzEiDw1AJP+qUxFni/1aB7dtNuer8TRiO1qQHRrFUZIiH/0LQMraCoEJ0Lva7RjhD/OFU+uApTLF8u6KCu2LkrO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Zy9X1JhI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UJi/ZZDPytMZa3Hcg3Ha7wf64wi1Jm9YQ1zlxDcQewI=; b=Zy9X1JhIJ3vzwjwF5hdcaVF4Db
	ynvZJFXSrpv0cw2uz0MMbMIkrPon/gvwpwuh5rS1Aa1cBRD4/Cls3j5fLmFc6OiK8FNI51VuuFJt3
	pE6buavaSuWku/q4XoDdjp2O6OD4deN3GRczII7XEAoXcZ9U5rWOrSuxm5WE9C5UVB/kl94kP65ki
	R64kRQJsqthOC1M3eenqlafeh4IcXuf1Y0gA7/s4VrEM7lNnlEiPeaUz9DsOek21R5htLzxGEEVmh
	BCvYtfJFtvi1lkSXIc+7+lzzvUIYwAnfy9K4gMjZznd2v0zt7AU+6v6H+mi8xJlZo6TE9SaHD/S6G
	XHfhKYqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkgSj-0005Bw-2d;
	Wed, 19 Feb 2025 09:33:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkgSe-0008Gi-1m;
	Wed, 19 Feb 2025 09:33:44 +0000
Date: Wed, 19 Feb 2025 09:33:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 19, 2025 at 04:39:10PM +0800, Sky Huang wrote:
> +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	struct pinctrl *pinctrl;
> +	int ret;
> +
> +	/* Check if PHY interface type is compatible */
> +	if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> +		return -ENODEV;
> +
> +	ret = mt798x_2p5ge_phy_load_fw(phydev);
> +	if (ret < 0)
> +		return ret;

Firmware should not be loaded in the .config_init method. The above
call will block while holding the RTNL which will prevent all other
network configuration until the firmware has been loaded or the load
fails.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

