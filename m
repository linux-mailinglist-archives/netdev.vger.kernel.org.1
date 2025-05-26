Return-Path: <netdev+bounces-193377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C432AC3B14
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADAC1895983
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F01DED56;
	Mon, 26 May 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ahmp7gVK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C703595E;
	Mon, 26 May 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246711; cv=none; b=eagQz/Z4Q8Gg7DmocZp7isKWlJ2s9x4AgrDjByaN4qK2I2zAY0GFg+GMb6bHV6GG48LNWPcXtQfggux0YoPBO00oX5u03CzaDVZ0bOkVQ9Hbi8c3nRFg2ycFuu6ak8JwH3zr0wWLPNjwWCiEurV9tjMkjBYNy9jaeHk/EQCeguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246711; c=relaxed/simple;
	bh=Xi/4wSWLk23OU5m5HrWBRgvE7nyhIYVAvXhoVjBKmmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsBs2Oex0lZ7aKFgCJVxcAue3cm5E5cIomy4NMS4ahsDS/g2jGta57C8Gsox4/IJ4AJtCX6q5Mgh/nh1yvAaFPzj0WXIslVPBaYgYU9ffYWntvGL2wqCxE2e4xPWMfA79Y460DkbYAGYycetALQQF0C1cVM65g1SQ81NDVb2V14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ahmp7gVK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bbADdHqSyemEAUvSgp0Vxsp615wRz96ttPoTQeE5LAo=; b=ahmp7gVKJThDo8tM/ki0syfuDO
	JQtPY1b6f/MhHhhkDOr6epdnAs23WIReEi4cS/jX2seK6jRV8D64egdPDbzu0ATYjmqV3uvgtyRuM
	L28cPXQKHj4swBTuaFPS4vj1udkP0rrgNjalXHH8NVUfvoMPGGM4HxxAGptJvPlWeZJjCRu+CyH86
	EGQDPvyoL7F1xXhi7G5cjdYnVCEex3JGS43fnm0UThcxWdZIqHy41Ry7ItnoTGLzrL621TA2cFa/4
	wtDHSNK4r/xGSPQRieqC6Kranr7QD6YD0UPQjI9sjJWWQazCRZJjGd21XRaeXvljqFD+emrVJbpwY
	0tGoJdlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50816)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uJSpH-0006VC-1T;
	Mon, 26 May 2025 09:04:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uJSp6-0000Fz-1l;
	Mon, 26 May 2025 09:04:40 +0100
Date: Mon, 26 May 2025 09:04:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
Message-ID: <aDQgmJMIkkQ922Bd@shell.armlinux.org.uk>
References: <20250526002924.2567843-1-james.hilliard1@gmail.com>
 <20250526002924.2567843-2-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526002924.2567843-2-james.hilliard1@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, May 25, 2025 at 06:29:22PM -0600, James Hilliard wrote:
> +	if (!nvmem_cell_read_u16(dev, "ac300", &val)) {
> +		const char *phy_name = (val & AC300_KEY) ? "ac300" : "ac200";
> +		int index = of_property_match_string(dev->of_node, "phy-names", phy_name);
> +		if (index < 0) {
> +			dev_err(dev, "PHY name not found in device tree\n");
> +			return -EINVAL;
> +		}
> +
> +		plat_dat->phy_node = of_parse_phandle(dev->of_node, "phys", index);
> +		if (!plat_dat->phy_node) {
> +			dev_err(dev, "Failed to get PHY node from phys property\n");
> +			return -EINVAL;
> +		}
> +	}

1. You are re-using the drivers/phy binding for ethernet PHYs driven by
   phylib here.
2. You need to update
   Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
   in a separate patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

