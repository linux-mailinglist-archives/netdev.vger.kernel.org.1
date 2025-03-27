Return-Path: <netdev+bounces-177921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F44A72E92
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52EB3BCB44
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D1420FA9C;
	Thu, 27 Mar 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yeqleNWE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A119DF40;
	Thu, 27 Mar 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073708; cv=none; b=UIAft8R54ORXi2snAzI5dS9LxH4o5J7M5bCYOmln+2qmd3lf3h/n8vtMg4tCW6Tj68awl3nOqPnUWOx4NAXHOLF7WudZKEsK2b7+wv9w5BOer6/fYZoS/mMr9IP6hCYpJq7JaJaYfddlZGiNDdchzM/zvhOpKEeOxts1a4y6uEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073708; c=relaxed/simple;
	bh=OH7QZFUu0ryv+8vHFEw/qfGsxEIKnrUvyYNH7cBsr6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYR4vBpl4TlPOQEiGPS1varRgEOzgdFc0fl+qbxC67wovP0vdkDvLqtnIZOE4Re22SFeJ4G/LtPI+zyNB06ylQG0VJ+EC8jq1YhI54iNCNtiiBnmRMXs63EgSpHoaruAyFA27BpTu+POTcjt4hsAThsHyf+Q0ZgltyQPgFjY3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yeqleNWE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eDRJrQ3U6xuh69yqSFaehCOw5/haYnaDh2eIcuzErB4=; b=yeqleNWELw2zHB8EUUeaahqPLo
	Vz+nQMQwLNLInu8vGPIAqYylmE2bkIB8gIySyWA0RhiZpGdGOSQzCLh8/KAFN//WG2tgUUuiTIoap
	7jMqIiLZWbgBbKsdYgPW2mzF45+pATbEU3QhSNR1N9cdr6xxkIKEAtFExzMYLQKGnNLjpzO/F3lom
	aWazSL6Qd81e7t5DCtKHW/3dXyr+HYRAQiPo8cETIxpf5nWz786TJi/hTfw6+WdTyZdHCGaAIlLCd
	xlaCu0aDraKeo/dGFZ4HZboXYaPZqsOg3JqJckmMuQK9jmODbkFAWrxivUkP4IyjOF0tnyLHDx6sP
	GrL7K0Dw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60216)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txl5s-00079I-36;
	Thu, 27 Mar 2025 11:08:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txl5r-0005Zn-16;
	Thu, 27 Mar 2025 11:08:15 +0000
Date: Thu, 27 Mar 2025 11:08:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 2/4] net: phy: bcm87xx: simplify
 .match_phy_device OP
Message-ID: <Z-Uxn3hlJQ62bBGw@shell.armlinux.org.uk>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326233512.17153-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 12:35:02AM +0100, Christian Marangi wrote:
> Simplify .match_phy_device OP by using a generic function and using the
> new phy_id PHY driver info instead of hardcoding the matching PHY ID.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/bcm87xx.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Great! Less code! :)

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

