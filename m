Return-Path: <netdev+bounces-148920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8B9E372A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D65B29239
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EAF1B3930;
	Wed,  4 Dec 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x5/WXeGB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D691B21B5;
	Wed,  4 Dec 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306466; cv=none; b=KYepCPSdUoFcdE5N3qtkLiFhtiZj6uLUEnc4UfL+dcFbqjJUaExs+QqdWpPJVHHspW4sPWtxfmwpJ4uR28ErPY3oplpqf6pAqEXl0cn5p0voV9PnZ+xDM32Usu6imz/JoZXhn6VRocBQGpI5SqgPbFzd0Y58wYyq+qNAJiJRf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306466; c=relaxed/simple;
	bh=sKsYxzyOlAIW739jxHhHWnC/OVvHM9eHTjS3Whe6d6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfjBOhgx9Vf4lIJ9M/bLx20neKRd6F1QeLjaOMOlFH49pQ1ke1V4ysRwdLdtxv3kS+R1WKU7Uh2D8SNE2zSvIa98/pYshwgZGY0gnWiuTrEBIZR+nGbx2IQqx/2dn4s2P3se7iz211eRs7bgjzgRc1+hZ+nPDCfyZaENRA0PKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x5/WXeGB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l3A2A2dyYCIFcqs3vUodXDpOQcBZ1CzrLM96sSXpgMM=; b=x5/WXeGBk/irKh/OT/tiRi5Gft
	L3e4DrdCYGtM4Ma9fNynoW6V6Kmkzzcxxo1joTvmLNXUNdOeeKfCI7SVtB7RFrNbte7SqV2CPwvZ1
	5vIMlVkkj8VdPRX2D0Sd3qHS8GxbyLgB0hc4UN1weBpZ60tgh8S+t8SPESfoWHzLXSCYycSevyIa8
	HWt7PR2wuLpeHLgjBGrTldjl35bnKeaDfajJYFrQhkGmp4yOvPIOt4j7BS0fOu1ly0hn6+QN8Mw/f
	2pRNf1ZlU1Vov9hivIupBBoCNuyvZb94GWfOmwsFdi8mg+1UNm5PunkAyTfI3GTMxaAdPGmgT5J1F
	9wdVhP2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40630)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tImBZ-00035V-2u;
	Wed, 04 Dec 2024 10:00:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tImBV-0005SZ-1k;
	Wed, 04 Dec 2024 10:00:41 +0000
Date: Wed, 4 Dec 2024 10:00:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <Z1AoSSDqAbEisuzK@shell.armlinux.org.uk>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
 <20241204072427.17778-4-ansuelsmth@gmail.com>
 <20241204100922.0af25d7e@fedora.home>
 <67501d7b.050a0220.3390ac.353c@mx.google.com>
 <Z1Af3YaN3xjq_Gtb@shell.armlinux.org.uk>
 <675021f1.050a0220.34c00a.3a0c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <675021f1.050a0220.34c00a.3a0c@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 10:33:33AM +0100, Christian Marangi wrote:
> On Wed, Dec 04, 2024 at 09:24:45AM +0000, Russell King (Oracle) wrote:
> > > Added 5000 as this is present in documentation bits but CPU can only go
> > > up to 2.5. Should I drop it? Idea was to futureproof it since it really
> > > seems they added these bits with the intention of having a newer switch
> > > with more advanced ports.
> > 
> > Is there any mention of supporting interfaces faster than 2500BASE-X ?
> >
> 
> In MAC Layer function description, they say:
> - Support 10/100/1000/2500/5000 Mbps bit rates
> 
> So in theory it can support up to that speed.

Maybe the internal IP supports this but the SoC doesn't?

However, I was asking about interfaces rather than speeds - so RGMII,
SGMII, 2500BASE-X... is there a mention of anything else?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

