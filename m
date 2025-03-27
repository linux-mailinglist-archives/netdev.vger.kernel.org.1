Return-Path: <netdev+bounces-177988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D172BA73DBC
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DA91738E9
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173EA21A427;
	Thu, 27 Mar 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UjJLEWuw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC92192E1;
	Thu, 27 Mar 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743098954; cv=none; b=TmLGVll/4B6HIGAyIHplhCilEA4miuWDJxLKa62wRHOlIweHBHedIpUgijGPU9l9AQyU8y3CjprBL7Vinr0DD/6AXGjaYbfJqbM82F18XCVHhAAaA5OtosSSwS464e+cXb4Xfn0sg3cNl9XNqH3A6k3eCE2v11m2klIKXUz5t4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743098954; c=relaxed/simple;
	bh=WDZ/TdvVqTGFdOBs5AR+LXVDcaQB6OZOUx/p/Fq2Mv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFIDj710FsqKi7KlRx8fAG/1SOJcklIAwEbTE/1gDaO+BLopO2SMFCQ6dUwhJ+NXRQ4MVw1+6rJUC8/750sARlvwYjpBYAI6unsQ1+j6jprK+6wqFh9Ac3vC+1oh8O5TUd4Q0tDpMnZTLAIXuv6hxKv4C3paIsA0DTltDaNVIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UjJLEWuw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0iI76ZxHHsT4dCo91RfA/tDxDNywYERS3l4ButZui0A=; b=UjJLEWuw4yaVByGcTP20JjLak0
	0+Di8UCRGKCFC3BAtPn3bep04rQ5kiOASDOoesZ+AfRe6OyovW+QgoSxdYiGmgTvbsHjXmIKhHeiW
	v+OUeG2JfDNnXQmHid0ZKghAH59P9YuyKWY6GaEMVuIHCioPejZdAmAC0EiKBietEHNjR+wakqLvT
	zb0WwRwRE0+4uG/KlIt0FxX3dP5CfL93663AbeysSLjhm75ALjInKM2Ujx+TrLLVRSqRxCXykUGPq
	NiKMzgE7nJJpmkq1uaSI55dXchOIefHRsOOYoLz4bGzHP6CnKIeFdi9Ktm5fNFHWX1W/10k5cSVpt
	15SdYy6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52902)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txrex-0007ZR-0S;
	Thu, 27 Mar 2025 18:08:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txrer-00067y-2f;
	Thu, 27 Mar 2025 18:08:49 +0000
Date: Thu, 27 Mar 2025 18:08:49 +0000
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
Message-ID: <Z-WUMb-xfYIihPJQ@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
 <67daee6c.050a0220.31556f.dd73@mx.google.com>
 <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>
 <67db005c.df0a0220.f7398.ba6b@mx.google.com>
 <Z9sbeNTNy0dYhCgu@shell.armlinux.org.uk>
 <67e58cd2.7b0a0220.289480.1e35@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e58cd2.7b0a0220.289480.1e35@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 06:37:19PM +0100, Christian Marangi wrote:
> OK so (I think this was also suggested in the more specific PCS patch)
> - 1. unpublish the PCS from the provider
> - 2. put down the link...
> 
> I feel point 2 is the big effort here to solve. Mainly your problem is
> the fact that phylink_major_config should not handle PROBE_DEFER and
> should always have all the expected PCS available. (returned from
> mac_select_pcs)

I'm going to do a quick reply here, because I'm on a high latency LTE
connection right now (seems Three's backhaul network for downstream is
being overloaded.)

I mad ea comment previously, and implemented it:

https://lore.kernel.org/r/E1twkqO-0006FI-Gm@rmk-PC.armlinux.org.uk

Remainder too painful to try and reply to at the moment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

