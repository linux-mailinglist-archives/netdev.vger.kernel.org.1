Return-Path: <netdev+bounces-248562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D8D0BAB6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60E46301A0EE
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F998366DA9;
	Fri,  9 Jan 2026 17:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E9366DAC;
	Fri,  9 Jan 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979924; cv=none; b=oZgxMKKzwIGbj9VXt70gdUSGgqCJ0/b8LecHVj9jBhOS3RcoTO7zwwsPYCnk1Po8OGLpJmTM+1NXcmI1ebuUIIeJcTsSDTiJJfq+06lXBbxkCBhP4b/Ti61CUz8lSgHMrhUY5I7f3peEtmF8byMqc2fhmf9PTQWOWazBrxBv7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979924; c=relaxed/simple;
	bh=n4Gq+KsQfPIp+in+/g8BULAOUduurRzZBSaTmrefJ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqPiVVghbIWIPdHeCjWsULsXNxzJ2aXbzhKXYuAEMGpbt+1MMdK0RZkvhhkhCmbjitc7Vzf/8QY4lD6MpNc3AgGRBS5q9mPeRFlNG0EtzhhfKcYdIiJ9Prx3LE1sS7GHebkrXg5orgNuak5pZtzfSTt5Qd8OkTAJ7RgKuqq0KK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1veGKw-000000001VY-37tv;
	Fri, 09 Jan 2026 17:31:46 +0000
Date: Fri, 9 Jan 2026 17:31:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Aleksander Jan Bajkowski <olek2@wp.pl>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: phy: realtek: demystify PHYSR register
 location
Message-ID: <aWE7fPY64ew-MY6Q@makrotopia.org>
References: <cover.1767926665.git.daniel@makrotopia.org>
 <bad322c8d939b5ba564ba353af9fb5f07b821752.1767926665.git.daniel@makrotopia.org>
 <1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com>
 <aWD0AuYGO9ZJm9wa@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWD0AuYGO9ZJm9wa@makrotopia.org>

On Fri, Jan 09, 2026 at 12:26:42PM +0000, Daniel Golle wrote:
> On Fri, Jan 09, 2026 at 08:32:33AM +0100, Heiner Kallweit wrote:
> > On 1/9/2026 4:03 AM, Daniel Golle wrote:
> > > Turns out that register address RTL_VND2_PHYSR (0xa434) maps to
> > > Clause-22 register MII_RESV2. Use that to get rid of yet another magic
> > > number, and rename access macros accordingly.
> > > 
> > 
> > RTL_VND2_PHYSR is documented in the datasheet, at least for RTL8221B(I)-VB-CG.
> > (this datasheet is publicly available, I don't have access to other datasheets)
> > MII_RESV2 isn't documented there. Is MII_RESV2 documented in any other datasheet?
> 
> No datasheet mentions the nature of paging only affecting registers
> 0x10~0x17, I've figured that out by code analysis and testing (ie.
> dumping all registers for all known/used pages using mdio-tools in
> userspace, and writing to PHYCR1 toggling BIT(13) and confirming that it
> affects the PHY in the expected way). Don't ask me why they ommit this
> in the datasheets, I suspect the people writing the datasheets are given
> some auto-generated code and also don't have unterstanding of the actual
> internals (maybe to "protect" their precious IP?).
> 
> Anyway, as RTL_VND2_PHYSR is 0xa434 on MDIO_MMD_VEND2, and we know that
> 0xa400~0xa43c maps to the standard C22 registers, I concluded that
> 0xa434 on MDIO_MMD_VEND2 is identical to C22 register 0x1a, ie.
> MII_RESV2. I've also noticed that the mechanism to translate registers
> on MDIO_MMD_VEND2 to paged C22 registers only makes use of registers
> 0x10~0x17, so it became apparent that other registers are not affected
> by paging.
> 
> I've confirmed all that by testing on RTL8211F and RTL8221B. As pointed
> out this also holds true for internal PHYs on r8169 which emulate C22
> registers in the exact same way. Hence the PHY driver can be simplified,
> as there is no need to set and restore the page around the reading of
> PHYSR.

Just did some additional testing also with r8169 (with internal 2.5G PHY
0x001cc840), and PHYSR reads fine as MII_RESV2, letting the Ethernet
driver handle the mapping to MDIO_MMD_VEND2 instead of using a paged
read in the PHY driver.

