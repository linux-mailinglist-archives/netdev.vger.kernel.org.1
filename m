Return-Path: <netdev+bounces-158532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9AA1265B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C823A887F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709486320;
	Wed, 15 Jan 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ddHnqtib"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97E78C6C;
	Wed, 15 Jan 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952217; cv=none; b=RIwdEIALaC1dCXFFu4sw3TKlgZBWCF4c4x+8xdhTBNi7um0b7F9Um8N8v5araijh+Bslf+5L9d4VdEXqV2S6SuGJ02JXg4lxaxfHxnqXj6qK6uzqBSWMfeE/2oJcIyCXLHKXWTfcohNSmR0i+NwJAC/p4dmQ+Tg5x3SYCpxiuzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952217; c=relaxed/simple;
	bh=EGxr3f1Hp9rA0ARBX9STSNQ6goPhd754A6QHHBolOU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLzWINRstFvjSSK1wyOZr3W2ajNgjUMy9ZmSRk+RCSqvo1uhoOSlzteywpXDW5amuLnJspjWHBw2hCEz4DFBRbpx+wUMz8Ktmyc0IA3ph/0LVj32Gg5GUdCa85saNuB8sqwLuT0wMO8iFvePzpsM+zzylZj+d86RU0ukPcFCc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ddHnqtib; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i/j5p8GOUpKWGp44THvpHWvOSrabQaXeAztkPN54uS4=; b=ddHnqtibxA2RIs7orSgsLbk/W6
	dPp5r0b2KNDzgZGQKmQ43KBP0dkK/8PFXJQV9rHCbc0bjekh6eWD9nNzlOXeD5EW6b0q0FbNokRHB
	8JnO+lP0xAWhi/6WBrNnUNpXN9Q0arq2ya2Oc6uRUuaVnB7BiqxoHUBRpQQUpW9laxZ9KIT9Znkim
	UlYhwOX8zstGJmzYTJDTsNmuBVgPpkxJdgpuPFwFw8Ojf467CJcL74TAoVNvPcQTff3rgh0IRSj8u
	+Za9/uOjySulb3HLrV1qn/nSZ6mmfeWVQM9E7m2avGt4/zj6o0l3UP7HP+Kj7m0oCeBzZ/3hKANgh
	K7ImEkag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34660)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tY4cD-0001IC-16;
	Wed, 15 Jan 2025 14:43:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tY4c9-0006Eb-1V;
	Wed, 15 Jan 2025 14:43:25 +0000
Date: Wed, 15 Jan 2025 14:43:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: pcs: xpcs: fix DW_VR_MII_DIG_CTRL1_2G5_EN
 bit being set for 1G SGMII w/o inband
Message-ID: <Z4fJjf4nyiNyRus_@shell.armlinux.org.uk>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 14, 2025 at 06:47:20PM +0200, Vladimir Oltean wrote:
> On a port with SGMII fixed-link at SPEED_1000, DW_VR_MII_DIG_CTRL1 gets
> set to 0x2404. This is incorrect, because bit 2 (DW_VR_MII_DIG_CTRL1_2G5_EN)
> is set.
> 
> It comes from the previous write to DW_VR_MII_AN_CTRL, because the "val"
> variable is reused and is dirty. Actually, its value is 0x4, aka
> FIELD_PREP(DW_VR_MII_PCS_MODE_MASK, DW_VR_MII_PCS_MODE_C37_SGMII).
> 
> Resolve the issue by clearing "val" to 0 when writing to a new register.
> After the fix, the register value is 0x2400.
> 
> Prior to the blamed commit, when the read-modify-write was open-coded,
> the code saved the content of the DW_VR_MII_DIG_CTRL1 register in the
> "ret" variable.
> 
> Fixes: ce8d6081fcf4 ("net: pcs: xpcs: add _modify() accessors")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Good catch!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

