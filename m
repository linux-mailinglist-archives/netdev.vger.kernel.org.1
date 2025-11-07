Return-Path: <netdev+bounces-236781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 228BFC401D2
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE17F4ED7F2
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952B2E3AEA;
	Fri,  7 Nov 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DZQfYH/x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BD2E3B16
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522147; cv=none; b=QZ52o6Q6iZ+GUNOxEat+GE3Qxo20UuY9xa8MX6FcIY7DSv/9qMknO3AZO3CfUXa8JTuc8vZzJxfPbpPdHGKjdmiN+WRX8qZhXxxcY2f6spPLoaHvrPZKNdLEGM/9e2aYlQbhgmWjb7dZdQ2aY9F1LoxX/ecUgfXscxeGizkSV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522147; c=relaxed/simple;
	bh=Lx2DMfoP+APhH8gees7G1zWku39GDlRR5ucxiSSQnac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDVUcBv8V5ieXgkk25efHNxocMxT8ak63n1wN2p6VaTUhmELGxkXELu8Ca16ZYr0mgqjduOR1HqgdG1e7gNBPnhqfcqx4RrmuHH/MTZ+0v2tUKWXbTErikWEa2/tZexDSpQMyGXA/1c1Tm+TEei/jVtaFeyF4XTP0FVdKsYe2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DZQfYH/x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9LIyjVJQfDG5m11HK4KmkfsZRTOCEumHWut/iWDvXmc=; b=DZQfYH/xC+3iOVDdg7ckosN3Vp
	lxuwXIAC4X94FR2FfQ8gFFwXEyt9HQvfdsdW5dzrEpP/+kP3VahgcBwhFQYzEXC5CSot36k57X2Xp
	aur+bXPeDo+2ZXq14rUcUsS8HqbW2RlY7yrB4BcLg+OwdxrKx8J3gNjCNxDuqAy/HZss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHMWW-00DEIE-8q; Fri, 07 Nov 2025 14:29:04 +0100
Date: Fri, 7 Nov 2025 14:29:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 4/6] net: phy: realtek: allow CLKOUT to be
 disabled on RTL8211F(D)(I)-VD-CG
Message-ID: <750971e1-b133-4776-b518-32d66df29949@lunn.ch>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-5-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107110817.324389-5-vladimir.oltean@nxp.com>

On Fri, Nov 07, 2025 at 01:08:15PM +0200, Vladimir Oltean wrote:
> Add CLKOUT disable support for RTL8211F(D)(I)-VD-CG. Like with other PHY
> variants, this feature might be requested by customers when the clock
> output is not used, in order to reduce electromagnetic interference (EMI).
> 
> In the common driver, the CLKOUT configuration is done through PHYCR2.
> The RTL_8211FVD_PHYID is singled out as not having that register, and
> execution in rtl8211f_config_init() returns early after commit
> 2c67301584f2 ("net: phy: realtek: Avoid PHYCR2 access if PHYCR2 not
> present").
> 
> But actually CLKOUT is configured through a different register for this
> PHY. Instead of pretending this is PHYCR2 (which it is not), just add
> some code for modifying this register inside the rtl8211f_disable_clk_out()
> function, and move that outside the code portion that runs only if
> PHYCR2 exists.
> 
> In practice this reorders the PHYCR2 writes to disable PHY-mode EEE and
> to disable the CLKOUT for the normal RTL8211F variants, but this should
> be perfectly fine.
> 
> It was not noted that RTL8211F(D)(I)-VD-CG would need a genphy_soft_reset()
> call after disabling the CLKOUT.
> 
> Co-developed-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

