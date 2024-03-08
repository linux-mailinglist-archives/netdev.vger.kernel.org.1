Return-Path: <netdev+bounces-78580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C45875D0F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8681F21EB8
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 04:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A652C6B6;
	Fri,  8 Mar 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DRsKILWZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30B2C84C
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871221; cv=none; b=uXYtS2ubgIcXXTuCybrqLlRci1seVeSBVIipzNDrcQ254BitADfLXdk/mCjSY/+N9frZhtvySjGAVqHSu5tH80WzVrkAoyGlTCFWGfS200tk9FOeUrXikHZRHfKQxQQywSE6DtPW/LOknEST/Wgf3LbqKxeBXEWbkaVmBYsxyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871221; c=relaxed/simple;
	bh=6cCu9noNfsTelcwsDs/0viN465rqITcLD2PA0NmOv0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLQyAX7ktoDjyb2ZVhyQZDwOE8WcoLkQw8/OREuhWEJ1D67U2sYm8Du2tV8NyGFC9NYpmryWdw8TJDqSNElAmlKojaFNX5+OW78cbB7IEkbbS2fyGUGkz9rQu9nMkJTtNejZIXVjDbN6mYHiQ8k9S/0BwHodmNt0wGp6BK+TDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DRsKILWZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gMEXu6lSO9ojuU1BuF2tW84JYWPuDcSBpJXsxVnFE38=; b=DRsKILWZ1NlE5MmCb4JkP/C/H4
	WyhCulib8i2LPORgSiUtOyY1EIDHx8ftRiognKM/Ksoi9HcnrfDUpzX8RhJ8XwXvLaBCJ2qfAfqpK
	p/fCaBEaEC5YorYqhDEKS9FXiAGfI95X06CLDRex+zWGP1k5WBN0n02LJ+Dnqr3CMRvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riRcV-009j3Z-FN; Fri, 08 Mar 2024 05:14:07 +0100
Date: Fri, 8 Mar 2024 05:14:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>
Cc: "mkubecek@suse.cz" <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nagarjuna Chaganti (QUIC)" <quic_nchagant@quicinc.com>,
	"Priya Tripathi (QUIC)" <quic_ppriyatr@quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Message-ID: <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
References: <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>

On Thu, Mar 07, 2024 at 10:09:18AM +0000, Sagar Dhoot (QUIC) wrote:
> Hi Michal and Team,
> 
> We are developing an Ethernet driver here in Qualcomm and have a query w.r.t one of the limitations that we have observed with ethtool.

Hi Sagar

Please configure your mail client to wrap emails to a little less than
80 characters.

> Detailed issue sequence and the commands executed:
> 1. "ethtool eth_interface"
> 	a. Assuming eth_interface is the interface name.
> 	b. By default, the "get_link_ksettings" will publish all the supported/advertised speed modes. Let's say we support 10G and 25G. In that case both speed modes will be advertised in the ethtool output.
> 2. "ethtool -s eth_interface speed 25000 autoneg off"
> 	a. "set_link_ksettings" will be called and speed value will be passed as 25G.
> 	b. Advertised speed mode will be restricted to 25G.

autoneg is off. So advertised does not matter. You are not advertising
anything. You force the PHY and MAC to a specific speed. You should
not touch your local copy of what the PHY is advertising at this
point. You just disable advertisement in the PHY. The link partner
should then see that autoneg is off, and drop the link. You then need
to configure the partner in the same way, so both ends are forced to
the same mode. The link should then come up.

> 	c. Link comes up fine with 25G.
> 3. "ethtool eth_interface"
> 	a. "get_link_ksettings" will publish the link as up with 25G in the ethtool output. Advertised speed mode will be set to 25G and 10G will not be included in that list.

Nope. I would expect advertised to be still 10G and 25G. All you have
done is disable the PHY from advertisement anything.

When you re-enable autoneg, the PHY should then advertise it can do
25G and 40G to the link peer.

> 4. "ethtool -s eth_interface autoneg off"
> 	a. "get_link_ksettings" will be called and as per our implementation, as the link as up, we will return the speed as 25G.

So you have turned autoneg off, but not specified how the MAC/PHY
should be forced. Defaulting to the last link speed seems sensible.

Maybe you are mixing up advertise on/off with advertise N which allows
you to limit what link modes the PHY will advertise it supports?

       Andrew

