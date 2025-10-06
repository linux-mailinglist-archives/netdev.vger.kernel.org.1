Return-Path: <netdev+bounces-227965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D97BBE338
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 340234E2AEC
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7EA2D239F;
	Mon,  6 Oct 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jb2neMW/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E662C2363;
	Mon,  6 Oct 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758121; cv=none; b=ISwATG+0cgyRiJtWBz8qW5nfUZNFONq6mPbdeWnoC8huiFtV6C6Y+X4OTQutTqTK1pndT+2Lo0jge3y5tulIh8u4FJzVonocd8Fx0SF7+8PNPTeZfQXQgIqxwyEmZTgjMsTAUR2kNCp32HtA3a7o4YfibhjHfNZKb23BMacCYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758121; c=relaxed/simple;
	bh=SvGNA3biD3p7PNApXQAQZfYrxtxMq+LnJ/RTYtZRyMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1hYyaoBl0j6pesXCCuhwqIg2g0AWRZDBfH7JJKEzoI2ZthQAgSZCoJSuORJdy0wgPcjdxOFIeTj1DSlMYxsIAKE5PrgyenzQf4PSUWsKzJoU1JyVaOPCVp6wxnoTGqGG+2XSngh5fD9IuIStn2vZ49uiso9lprPkrMluycLW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jb2neMW/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LJFH/pv0PFB0lu4tjG3fuRh4o1/y+rQZOvxxLCSVrAo=; b=jb2neMW/DaCSMATGGmun/jxo9G
	5udYjZmFg/6TlMIHS+9cWAeFLbQ8rxU4xmUh0gacchFcQwVycXqC8QODsZA8PWEGRAOv8SAAKY5Ql
	q6BI+G5wu2c3ghl8ggsFeNHTDD9PJXh2Zsu9axiaGNT8TzWlkHTII2KFcgzorrnTSdhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v5lCh-00AISc-TX; Mon, 06 Oct 2025 15:24:39 +0200
Date: Mon, 6 Oct 2025 15:24:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net] net: mdio: mdio-i2c: Hold the i2c bus lock during
 smbus transactions
Message-ID: <13a81c5e-3dc8-44fe-aa04-5239c328c0c5@lunn.ch>
References: <20251003070311.861135-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003070311.861135-1-maxime.chevallier@bootlin.com>

On Fri, Oct 03, 2025 at 09:03:06AM +0200, Maxime Chevallier wrote:
> When accessing an MDIO register using single-byte smbus accesses, we have to
> perform 2 consecutive operations targeting the same address,
> first accessing the MSB then the LSB of the 16 bit register:
> 
>   read_1_byte(addr); <- returns MSB of register at address 'addr'
>   read_1_byte(addr); <- returns LSB
> 
> Some PHY devices present in SFP such as the Broadcom 5461 don't like
> seeing foreign i2c transactions in-between these 2 smbus accesses, and
> will return the MSB a second time when trying to read the LSB :
> 
>   read_1_byte(addr); <- returns MSB
> 
>   	i2c_transaction_for_other_device_on_the_bus();
> 
>   read_1_byte(addr); <- returns MSB again
> 
> Given the already fragile nature of accessing PHYs/SFPs with single-byte
> smbus accesses, it's safe to say that this Broadcom PHY may not be the
> only one acting like this.
> 
> Let's therefore hold the i2c bus lock while performing our smbus
> transactions to avoid interleaved accesses.
> 
> Fixes: d4bd3aca33c2 ("net: mdio: mdio-i2c: Add support for single-byte SMBus operations")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

