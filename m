Return-Path: <netdev+bounces-248236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49506D0591D
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C5D13017C78
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6231AA80;
	Thu,  8 Jan 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dowsTNAO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6412D73BC;
	Thu,  8 Jan 2026 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897225; cv=none; b=Bc1BjfNM+xUKI30SkS60/ddCblOACNSV8c4Y1HYa9mKwBgeLWzATJ88dB2Ou8MRWLC9+QnbGCIMlex1mhnviiNerPOEW6zcU+ySaFXqsAZA8LHIX2XlFbhOiIHF76SG1IyhGChxLrQbBygwpwI/7VlOdRNJiYzpizONo1TI78Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897225; c=relaxed/simple;
	bh=HQr515ls3pMbGDFJ1Zdo8LW2ZN6guuqKMAeP2/pJELA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgurYhnTTn4hxkaOZGjtUY3m3QoximrEN7zJ8XnDnr/YWgVSS1J3RUNHADhNglC8qHMlCjlRCxKw8oS5PJFXhOz6upDN57a6Bc197Mipc4PsjjhmgaBf/4Yb4MlNMh/VQbG8HMWsiZj3CdDRY79V8XL+L1++Lww/UWf5ZTXBOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dowsTNAO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z7MniIo9tiYgSnDxjVzR6AlCIoXZrz3+JpfW7pRumYQ=; b=dowsTNAOmAkDa8Ee7+pW8xOGCd
	jYYasPYDzM2fEaw0jbzPgaWhJnCqSa3JSRzcshTkG4QSI8DDKekg8jwf9Jo3/2plteDrj8VtH5FME
	axllqCJ6WwcjGEL/YcmpF5KVGFPdNy7R84+dto1Hpdb3hEnAjRmTnZd4elOFIzpfr0KQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdup7-0020Cl-MA; Thu, 08 Jan 2026 19:33:29 +0100
Date: Thu, 8 Jan 2026 19:33:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: motorcomm: fix duplex setting error for
 phy leds
Message-ID: <7cea16cd-5d66-476b-a9f6-0b17fad52169@lunn.ch>
References: <20260108071409.2750607-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108071409.2750607-1-shaojijie@huawei.com>

On Thu, Jan 08, 2026 at 03:14:09PM +0800, Jijie Shao wrote:
> fix duplex setting error for phy leds
> 
> Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

