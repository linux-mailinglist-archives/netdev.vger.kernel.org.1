Return-Path: <netdev+bounces-239064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE8C63502
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 795344F3F6A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1132ED40;
	Mon, 17 Nov 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l9aYhKt5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6426462E;
	Mon, 17 Nov 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372109; cv=none; b=Kja0aJKcVEpY7ljm26YvFV57Ad3LR87naHphoe5xonF4waqRhgVjsh/fb4d0bfFmF3MAzzf6lxSKPTX7A//E6ZwOz3dNNsCreiHQLltzAaMeX7M4E7cZptSBHcLfQ/qamlu+BshEcLUgJx96j7TDJ/mdpTkmbUNaiPak5ekhA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372109; c=relaxed/simple;
	bh=5+SE2KpjiJesyLGYI2J69xcSEpt/d0N008iU38ThnRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cchzBCkNLyvWAYyABNjtSS7LKVBE4t4zdvY70StUqxop7YJ8IWkNhv+b9zTYXy5L47vU0r0u8ydJkL6pKFuNehPu7EJOwN+a7iC8UMH2o3CNVOnyhrpWyk8NgOo3gx012o3wbjX1rUzQssO7oLTpHecoY1H2rgMXTN1LpeLc6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l9aYhKt5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8O6huGgV16m+89MZvtHIdYlbs4vgx81P16nu9QCxG9E=; b=l9aYhKt5rIvzUXA4MY54o33f1W
	YB4bIEk8//stjI8nCuO3dDKtnNcPKTfQWFMBoFbk1DplQ2lhgeLB/xuqb8fQ6OCw5Fp8UJpWhnc+Z
	CSbeEbLMoJhedKmVh8boGAxY+paUXzQf3HGOHpOAmogGKZff4ux0a3zW2yvbf8/Eby8nvCATaGfyn
	dN3uRiNSQw0soIx0R3iLIiX6eeVk5olNOOeMpZlfSXqdKuTJZMh1zeYey/SZRA6cIFQemzJbzyQFx
	TLjnMcrDPkFQin0B9MPAt2PxtHTFXrfAoCsZ+FvjG3xIis4yyzbFlZU9WlYi54sremfA+ax5Pj3nJ
	0hLNR4oA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40876)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vKvdM-000000001aR-2UUZ;
	Mon, 17 Nov 2025 09:34:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vKvdJ-000000001NJ-1kWf;
	Mon, 17 Nov 2025 09:34:49 +0000
Date: Mon, 17 Nov 2025 09:34:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: mdio: move device reset functions
 to mdio_device.c
Message-ID: <aRrsOfJv6kUPCxNd@shell.armlinux.org.uk>
References: <cover.1763371003.git.buday.csaba@prolan.hu>
 <d81e9c2f26c4af4f18403d0b2c6139f12c98f7b3.1763371003.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81e9c2f26c4af4f18403d0b2c6139f12c98f7b3.1763371003.git.buday.csaba@prolan.hu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 17, 2025 at 10:28:51AM +0100, Buday Csaba wrote:
> diff --git a/include/linux/mdio.h b/include/linux/mdio.h
> index 42d6d47e4..1322d2623 100644
> --- a/include/linux/mdio.h
> +++ b/include/linux/mdio.h
> @@ -92,6 +92,8 @@ void mdio_device_free(struct mdio_device *mdiodev);
>  struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
>  int mdio_device_register(struct mdio_device *mdiodev);
>  void mdio_device_remove(struct mdio_device *mdiodev);
> +int mdio_device_register_gpiod(struct mdio_device *mdiodev);
> +int mdio_device_register_reset(struct mdio_device *mdiodev);

These are private functions to the mdio code living in drivers/net/phy,
so I wonder whether we want to have drivers/net/phy/mdio.h for these to
discourage other code calling these?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

