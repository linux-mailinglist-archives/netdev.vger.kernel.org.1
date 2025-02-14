Return-Path: <netdev+bounces-166485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE30A3622A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B3B163418
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F9026739F;
	Fri, 14 Feb 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0oD4AUI6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED41684B0
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548015; cv=none; b=hgyIXFVOPRmzZYfMgudBuHErst2TOa1BIgX/38MF7OiBQeHyMBc+NfK3uYO1TUJ13+XnFVSqJCr+SvCll5UCTapp2Ti+J2jhpEy+ExDIJXJjVWoQaGWXRH97klg+VQPlSTFAF84vIMCgBjGolQN6bCwjVQNrUABMC+99+jrW8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548015; c=relaxed/simple;
	bh=QJqxaYxEocVGzpAKc8a5wbs29dKiRNW6PWaQ/h+dRhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QodeIn1xxkLBg20CLVLT8R9gILIx/BjfHRhKnChNKdtiUvJMAdE26RYjBEz7oqmKOJyqD87ayDBR4V3DiOf7Y2zWujp2wGAJKeBbG8B6Fo8YQ/xP8nPZ6LOoxbyMy+P8kO0K5z7Om/5+zmYbye4OzBItKkUlyiImDjkbJJ9vBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0oD4AUI6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GtM15X9w0TCtsB7ShX1k9Bl7bstw3/uXbcoJRw5x8TM=; b=0oD4AUI6BDdzMMAil0xYOHdiQC
	HX3cwu38Han7BW5stvy3vfMwVluFekMsZYROWv3ouBOIo6PL4xOTEQ/1Ko8qewHL2JgCcMrWM8aOD
	sqVU8cUC5psya4NfkvdpKHobnBweGjyCcIkYGGeK5Cvl857hIpGlUl/tZgmFFjrRnzeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tixts-00E74C-8L; Fri, 14 Feb 2025 16:46:44 +0100
Date: Fri, 14 Feb 2025 16:46:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: realtek: switch from paged to
 MMD ops in rtl822x functions
Message-ID: <51d0f59d-2e2c-4384-9a2a-4597ba9b7a03@lunn.ch>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
 <81416f95-0fac-4225-87b4-828e3738b8ed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81416f95-0fac-4225-87b4-828e3738b8ed@gmail.com>

On Thu, Feb 13, 2025 at 08:19:14PM +0100, Heiner Kallweit wrote:
> The MDIO bus provided by r8169 for the internal PHY's now supports
> c45 ops for the MDIO_MMD_VEND2 device. So we can switch to standard
> MMD ops here.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>  {
>  	int val;
>  
> -	val = phy_read_paged(phydev, 0xa61, 0x13);
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa616);

It is nice to see some magic numbers gone. Maybe as a followup add
#defines for these registers? Are they standard registers, just in odd
places? So you could base there name on the standard register name,
but with a vendor prefix?

Thanks
	Andrew


