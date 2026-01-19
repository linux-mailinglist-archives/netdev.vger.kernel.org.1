Return-Path: <netdev+bounces-251099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C9D3AB0B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23469301E6F0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6336A01C;
	Mon, 19 Jan 2026 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aVrqG1rF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E521CC62;
	Mon, 19 Jan 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831257; cv=none; b=CaER07qUGIPWORV0iRn2midudMitX9Nr6CpEvceXutVGI8vmbtHA7SBuNG0J2N170dTDvvVPwPKp8Tf94PFVDw2QQkvaNmPFXnxt04ol0oFl/2L8cQIiM/hqtuPjIc1em06SdYHiI7vuHajYdfgQuP8DZhyfODiEmNdG8jeYNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831257; c=relaxed/simple;
	bh=6A6qO2Pf+gafh+mvIGdFxBlOEbju6g3pO8WHgMvkBRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnUMwXxJ1KY4jZeNy0BLL5IGrIoQHWkgGVZhdyPiPIzT939S0HnUTkN0ML2DpON46XiUuFFWsN0nQ1Q+yuBRC7mFubW4iaT8hYZ+r6L6x7xaDYZkKcCNQJjCLm4QM/BlaNYgze8lQEHuC3RkRLm5Z+P2Id25h4D6JoCHLwiE4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aVrqG1rF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nLXci8Rxz3GiSy4CeTWemlehgXwn7DNboPvAauvtAn4=; b=aVrqG1rFW9aQu30vOenkdA08TC
	+dVQP/6AU3Ny1otfBuwv9qYvqFGH6YBqdMCsirikUkwXkAyeQQOOB3QSO4M/zjGKwbNeuuwUTy3GD
	Fc3+bXD4sN9m35gCvBAesRcyoMUZkHKNaf37j2SiK5TbmKPn2IjiMOU92hSPZp5IWseeM6VmXRTS3
	6eSFdadeAws87OGOFQi/cuxPS3x/NrxtjcqBzJiUUGrpphOqLP/HtFKsWDjGn0+rOaZeGr0y8F0g7
	b75btkUB2dGBUIsLBaKW5m8dStiheEMYeLm9rAdBmb4Jm7jO+kWnvHjiWgNn26+S1+cg3YaWXzDmT
	qmMaoPQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhpoM-000000005Fv-0SUN;
	Mon, 19 Jan 2026 14:00:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhpoK-000000006bi-33zh;
	Mon, 19 Jan 2026 14:00:52 +0000
Date: Mon, 19 Jan 2026 14:00:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/4] Phylink link callback replay helpers for
 SJA1105 and XPCS
Message-ID: <aW45FAKBK0Mi6kLA@shell.armlinux.org.uk>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 19, 2026 at 02:19:50PM +0200, Vladimir Oltean wrote:
> The sja1105 is reducing its direct interaction with the XPCS.
> 
> The changes presented here are an older simplification idea, broken out
> of a previous patch set to allow for more thorough review.

I think I had completely missed these, so thanks for breaking them out.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

