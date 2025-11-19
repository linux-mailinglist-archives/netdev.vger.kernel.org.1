Return-Path: <netdev+bounces-239989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A266C6ED7D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7757D2E977
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6935B123;
	Wed, 19 Nov 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xeFke5LD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83D357A35;
	Wed, 19 Nov 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558518; cv=none; b=tv2gg/9kapli2m4dPc1Oh9bDjQC0Lu4LS+JM57ZRgM5VfBOGBW4WH1dHehRifPsQgWAN+8zbe9DbIxxiZuscAQabDIpXagQuVUBwyWGPbPKX79QybXEE0wvAB1eNV/ZP1pfPg/8U0nvZ+ZBgOJQa2NcWl4k0aHfYfqEi2iButy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558518; c=relaxed/simple;
	bh=kIR0fW9JqiCHaGVP0kKHrMjO64QBKyaRvs8Fpzed/zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Maqd+gLSqbTRAIVIKpLxdZPqeziaNma2KQN4TBqX3yRaR0OIAHi2AcNC96dXCBKRlRj+SwzF1c5OB7HHRgH23Z+vNL5qRVfC7Cp/Z7Pg3MjtW6u8qlt6Ig/MO5xP+Tmv3AVDx4fZ1YIAR8Gk9upxTPBBlr0IM8/vQg1rW150I64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xeFke5LD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KxzwycKQG3iQZZ/xLETlDmyKWFMf0WNE7UcuyInjim0=; b=xeFke5LDxiIPjjEgIEVmpeYprz
	o7IjL6K6ieD5GWx3IsmEhonNg+xrkuHhWMjY6AwVRwYMVkkWPV+ZSgitEjtrWS2+UrhsoKgC8E6xK
	yW3Q7qXP2SG+V86PorFl3YTVVsL3HAMK1xaSctBuZMpk69/KTkOdM5e++uYYbhRtbbYBKDuejkuIr
	/rPTi8Za+DC1/UadpCOZmv25MaB0wDHcTwd01PLA5R83yvnyWL+1WCoeJG4ThXbST8qgVC41dixJu
	0bJbYXEElX/gilNC0VFsJgIweAvSaoKRI84qsI0kdClxyrWw0YOxkaQjkdaKmcuMgxwcZLWJnjzDO
	H5NQCWEw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33866)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLi88-000000004ob-0K96;
	Wed, 19 Nov 2025 13:21:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLi86-000000003SF-16I0;
	Wed, 19 Nov 2025 13:21:50 +0000
Date: Wed, 19 Nov 2025 13:21:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Dahl <ada@thorsis.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: phy: adin1100: Fix software power-down ready
 condition
Message-ID: <aR3Ebs6gdra4qGzo@shell.armlinux.org.uk>
References: <20251119124737.280939-1-ada@thorsis.com>
 <20251119124737.280939-2-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119124737.280939-2-ada@thorsis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 01:47:36PM +0100, Alexander Dahl wrote:
> Value CRSM_SFT_PD written to Software Power-Down Control Register
> (CRSM_SFT_PD_CNTRL) is 0x01 and therefor different to value
> CRSM_SFT_PD_RDY (0x02) read from System Status Register (CRSM_STAT) for
> confirmation powerdown has been reached.
> 
> The condition could have only worked when disabling powerdown
> (both 0x00), but never when enabling it (0x01 != 0x02).
> 
> Result is a timeout, like so:
> 
>     $ ifdown eth0
>     macb f802c000.ethernet eth0: Link is Down
>     ADIN1100 f802c000.ethernet-ffffffff:01: adin_set_powerdown_mode failed: -110
>     ADIN1100 f802c000.ethernet-ffffffff:01: adin_set_powerdown_mode failed: -110
> 
> Fixes: 7eaf9132996a ("net: phy: adin1100: Add initial support for ADIN1100 industrial PHY")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

