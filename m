Return-Path: <netdev+bounces-81084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1A885B54
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62C8B20FD5
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2198565C;
	Thu, 21 Mar 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eRObIcBx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871155792
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033384; cv=none; b=DEZ933YsuYpRfFtvACRaPqzwYSEF2IzguScYqMw23g6NTH7OVNzJC5GRzAOnADLhjjt++LBUUcsMkxZc35eQphKeQXqPOYYoZdaU8F2M8l/xJ2khdLxdyzOn2MAVPeU78P+pehZBcO+SYdL2ta8BGcqU81SZ0RR5awyBO1jSCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033384; c=relaxed/simple;
	bh=eiR5m8Q+NxythERDYGllaH4r479oDB0TmrddNaxHXzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvDxl3DpUvb8EBlMNeTD4wz4rgm/ehL9QwadChoLOV1WOPOwh6sefiB2tBd0dPOH4JbK/mUn+c9Qtydy1a33bE9XIEZ04cmQMKGm9VP+5BqKkqXp831RIpwElkw8NqH5rEzBPWiTiAC31plC/B/4luXlXYOaSw9iWD35hHMJJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eRObIcBx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=whpj9yVKfDIqXCcl+Y8UUCx47XsRQ2oUM+eMSVKDS50=; b=eR
	ObIcBxeUv2u8FFb8QhpHq/i+b3CuVS2nCkqyqV7nNSjE3d7j7AfUluML6kCXOX8rrcO/ZZ+pUU6oE
	KXhSmAJHdov69AO/saHKtgBWZhs8kW214I9vnJyr3ey3poKHLD7WYms3fJAsyv6AsYi486Eu7vE/L
	BbPJKiFHkU5TMyY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnJwU-00Astn-NH; Thu, 21 Mar 2024 16:02:54 +0100
Date: Thu, 21 Mar 2024 16:02:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Serge Semin <fancer.lancer@gmail.com>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC
 speed for GNET
Message-ID: <3c551143-2e49-47c6-93bf-b43d6c62012b@lunn.ch>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
 <fg46ykzlyhw7vszgfaxkfkqe5la77clj2vcyrxo6f2irjod3gq@xdrlg4h7hzbu>
 <4873ea5a-1b23-4512-b039-0a9198b53adf@loongson.cn>
 <2b6459cf-7be3-4e69-aff0-8fc463eace64@loongson.cn>
 <odsfccr7b3pphxha5vuyfauhslnr3hm5oy34pdowh24fi35mhc@4mcfbvtnfzdh>
 <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9e27007-c754-4baf-84ed-0deed9f29da4@loongson.cn>

On Thu, Mar 21, 2024 at 05:29:55PM +0800, Yanteng Si wrote:
> 
> 在 2024/3/20 01:02, Serge Semin 写道:
> > > > Due to a bug in the chip's internal PHY, the network is still not working after
> > > > the first self-negotiation, and it needs to be self-negotiated again.
> > Then please describe the bug in more details then.
> > 
> > Getting back to the code you implemented here. In the in-situ comment
> > you say: "We need to use the PS bit to check if the controller's
> > status is correct and reset PHY if necessary." By calling
> > phy_restart_aneg() you don't reset the PHY.
> > 
> > Moreover if "PS" flag is set, then the MAC has been pre-configured to
> > work in the 10/100Mbps mode. Since 1000Mbps speed is requested, the
> > MAC_CTRL_REG.PS flag will be cleared later in the
> > stmmac_mac_link_up() method and then phylink_start() shall cause the
> > link speed re-auto-negotiation. Why do you need the auto-negotiation
> > started for the default MAC config which will be changed just in a
> > moment later? All of that seems weird.
> 
> When switching speeds (from 100M to 1000M), the phy cannot output clocks,
> 
> resulting in the unavailability of the network card.  At this time, a reset
> of the
> 
> phy is required.

reset, or restart of autoneg?

> BTW, This bug has been fixed in gnet of 2k2000 (0x10, 7a13).
> 
> > 
> > Most importantly I have doubts the networking subsystem maintainers
> > will permit you calling the phy_restart_aneg() method from the MAC
> > driver code.

That is O.K. It should have a comment explaining that it is working
around a hardware bug. And you need to take care of locking. But a MAC
driver can call this, e.g. if it implements ethtool nway_reset, it
needs to do exactly this. See phy_ethtool_nway_reset().

      Andrew

