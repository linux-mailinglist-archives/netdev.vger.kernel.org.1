Return-Path: <netdev+bounces-148110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EB9E059F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9139328CC2A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE9209697;
	Mon,  2 Dec 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TtXSqWRQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17340209698;
	Mon,  2 Dec 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150946; cv=none; b=e1lZYV9c2rsjQSA7wpvQpDMJyB6i0XlI7mVRRw6oWz84Kmfe0puSOAXTwoHyrctcPlsf2XU1PJwi8yNE26Yw7YHPu48zqkh8ZojBfDS5ry2SR1ifSFaczujlFk/ULZUcK/5CD2rReT2fOrhMjhtfc3n7On6kKYCD1UYHwaH9ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150946; c=relaxed/simple;
	bh=pi5Mf/nr1qoJZfgRUUnsVgusjVAqfgyggwQ5OZJQnTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzgzvV973RaPIYCJ6QQwNOAzBJSAV5xR8wnPAs4n2kdXIFBWBllwKcb/kEZd40+dmwNmhvpVMi2+zuwLQ00dcsXgGke5q03rOKXPxqCsyXcEqYHg/S0kpIJFV4bcirw793Bqj+RlrR2/WTFceL0YtMbx7xJUQL3tPDY4HEE0e6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TtXSqWRQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d0sGftyf/7BoaDmfklTa6dQjOZv9IFd5AtZRQ5ymZm4=; b=TtXSqWRQrSMsnARGmMN2W1dkwc
	Uaj1wl7CiCEu78RVwYbboGQwMTNC3sx2zPGQ7nOof5aD0bIz+6WQI3ZFYHTThV381v4jEmjSEPfdf
	i1A9ej6h7xQCEFchT3/Z1RMcbgfoFwWa/AXAxpnaRnHE9t1EfxwYTbT2HMXfW90CJssQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tI7jK-00ExwL-BB; Mon, 02 Dec 2024 15:48:54 +0100
Date: Mon, 2 Dec 2024 15:48:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	florian.fainelli@broadcom.com, heiko.stuebner@cherry.de,
	frank.li@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <003d5029-2339-4e18-b632-be35384b2f7a@lunn.ch>
References: <20241202084535.2520151-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202084535.2520151-1-wei.fang@nxp.com>

On Mon, Dec 02, 2024 at 04:45:35PM +0800, Wei Fang wrote:
> On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
> clock sources for two external KSZ PHYs. However, after closing the two
> FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
> not 0. The root cause is that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.

The referenced commit is a one liner:

@@ -2001,7 +2001,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
        kszphy_parse_led_mode(phydev);
 
-       clk = devm_clk_get(&phydev->mdio.dev, "rmii-ref");
+       clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, "rmii-ref");
        /* NOTE: clk may be NULL if building without CONFIG_HAVE_CLK */

and here you are adding 103 lines as a fix. This seems out of
proportion. Did this truly work before this change?

The commit message says:

    While the external clock input will most likely be enabled, it's not
    guaranteed and clk_get_rate in some suppliers will even just return
    valid results when the clock is running.

So it seems like a much simpler fix is to put a
clock_enable/clock_disable around clk_get_rate.

	Andrew

