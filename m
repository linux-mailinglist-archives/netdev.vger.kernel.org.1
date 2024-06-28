Return-Path: <netdev+bounces-107708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D474791C094
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1328F1C210F4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AD1BF311;
	Fri, 28 Jun 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HASot+jz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E11BE25E
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583966; cv=none; b=geNTvCw3jYG1CSg7CMMSicroYR7Jonej1F6TIhxkyVa3/XsTYiwHmeksh7mE8CxumsGypaGnzoTFS+gyzIcPrJlmM3MnXkEG3zmcnUo24Ng33lVF3xOk2taHtbQr7opTLrks5nZNGWJXESMhVeYG+CgftzVKWM7tVHrm+UYdgRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583966; c=relaxed/simple;
	bh=ldTRIWnzPqckdAPUv3inv+BSwv8FjhtRhqL3RoGiEM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlxYltkO1k4cd46HbOzf0Iyh0jvYraaThd3IUjhjoRmOFHvI0HEQZ3jP33lbAQG9I9TuP3/MxEjISCWQslDFW4CnS93r2+NwEqbm8fQDyIs5ImMqgYbqQDsVzvX73q5eshkVM7RnZIfL6C0b/jTziT6TZ8L8fJlnzc/gk0J6XJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HASot+jz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N+LyAi85sS+aoaneFnfluoO6UZYMxrTPhc8Qzb4qfQo=; b=HASot+jz5XC8BUWS3BlLLC6qJE
	U/N6kabCy2NVkZTnyPnXgrICGibijUet3Jd8i1eOgC7VpROMDz73IsC/vakHsjT9Cfm7U8CLp3z9p
	twshXz7IEHcSUunCPKBqoZWX5+LXMqj9AJO/OzrQ5iG5aLxJAYX8WxsBRp7Xxi9eyOAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNCL6-001I0x-V5; Fri, 28 Jun 2024 16:12:36 +0200
Date: Fri, 28 Jun 2024 16:12:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: phy: fix potential use of NULL pointer in
 phy_suspend()
Message-ID: <d5964682-0f5a-4b9e-8415-bf306f18b8b1@lunn.ch>
References: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>

On Fri, Jun 28, 2024 at 11:32:11AM +0100, Russell King (Oracle) wrote:
> phy_suspend() checks the WoL status, and then dereferences
> phydrv->flags if (and only if) we decided that WoL has been enabled
> on either the PHY or the netdev.
> 
> We then check whether phydrv was NULL, but we've potentially already
> dereferenced the pointer.
> 
> If phydrv is NULL, then phy_ethtool_get_wol() will return an error
> and leave wol.wolopts set to zero. However, if netdev->wol_enabled
> is true, then we would dereference a NULL pointer.
> 
> Checking the PHY drivers, the only place that phydev->wol_enabled is
> checked by them is in their suspend/resume callbacks and nowhere else
> (which is correct, because phylib only updates this in phy_suspend()).
> 
> So, move the NULL pointer check earlier to avoid a NULL pointer
> dereference. Leave the check for phydrv->suspend in place as a driver
> may populate the .resume method but not the .suspend method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

As you say, nobody has reported this. So i think net-next is
sufficient.

    Andrew

