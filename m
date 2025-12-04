Return-Path: <netdev+bounces-243675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554ACA55F4
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 21:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EAB306B51B
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B58926B741;
	Thu,  4 Dec 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T/SIfiqD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E91F5E6;
	Thu,  4 Dec 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881270; cv=none; b=cPdbtLlbEfJwiNWnK268JEEOxz/MJi39pTo6Yq9oo6cXMWXY+S1kJ74mQ5lx2B/xSR6tN/024lkeEkA0KivrX9kpdMl3EuNfV0dtnuaKbZaJS1FJBX2miXYcAx+/df21aAA3FCQSf6bTMVwrHRBd8owipa7WC/xw7DY4bmSlCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881270; c=relaxed/simple;
	bh=DZNGbBIFwdBhALOb0N5Gy3FQ7YOyC1fjB7NsyJoZj7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ39PNUxvPHGzDPDYXlQOL/ZjbNXVcsyBw06cgK0sxLPLQpNXkJqtgRm1+IxOuTut+P8wu5uY3qctsSAE1VHfUpdgzoyeBLJxcy0zjZELmBtJdUBHB3e7vkHHKFZkmZa5VLlFK0I3Bo3kevnqtA1viEBRd+nmfOv/beJTvjIId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T/SIfiqD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=90lPoCGIeZvibFvI+Jj7Aj4Z4grOEkzE4KDDgVz3fS8=; b=T/SIfiqDXVikO9O0tu4uZBNlLW
	6PMOsEibq8S9h3DE3ovp9EN5cl/7WTTpDdxenrHdNtAeCsqlo1hH8k3dnhCJenq/VnizEzAHbCv6s
	crE4bj22iCna436g2Iqoqwd8IKtACPqvPCtv1jAF2/vjBryDOi2SU3fbdHxccoBbjOluy3utx/Xhr
	WLzi/hGK0ayRycPwbfh1gsKYrrfEUwJelwKQGGbKTdnPgalqsgXxV6zwFLfmnn50PPjzzzpceDqKh
	KkZX+cS2QzNka7NhIIcEV6VS232P7EO2438bRCGz1z+PS7rKgOvELaLHLkm1INShBT18CE1oSEfdU
	Y71n0DPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56322)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vRGEh-000000003wd-1CNC;
	Thu, 04 Dec 2025 20:47:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vRGEc-000000001L6-1Grf;
	Thu, 04 Dec 2025 20:47:30 +0000
Date: Thu, 4 Dec 2025 20:47:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frankwu@gmx.de>, Andrew Lunn <andrew@lunn.ch>,
	Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <aTHzYq5L7kvAPrjQ@shell.armlinux.org.uk>
References: <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
 <20251204160247.yz42mnxvzhxas5jc@skbuf>
 <66d080f1-e989-451f-9d5e-34460e5eb1b0@kernel.org>
 <20251204171159.yy3nkvzttxecmhfo@skbuf>
 <178afbeb-168f-4765-bb0b-fad0bcd29382@kernel.org>
 <9f7da6ae-9e3e-442f-a203-28a8881dbe0f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f7da6ae-9e3e-442f-a203-28a8881dbe0f@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 04, 2025 at 06:32:23PM +0100, Krzysztof Kozlowski wrote:
> On 04/12/2025 18:23, Krzysztof Kozlowski wrote:
> > On 04/12/2025 18:11, Vladimir Oltean wrote:
> >> On Thu, Dec 04, 2025 at 05:48:07PM +0100, Krzysztof Kozlowski wrote:
> >>> Both are the same - inverter or NOT gate, same stuff. It is just
> >>> connecting wire to pull up, not actual component on the board (although
> >>> one could make and buy such component as well...). We never describe
> >>> these inverters in the DTS, these are just too trivial circuits, thus
> >>> the final GPIO_ACTIVE_XXX should already include whatever is on the wire
> >>> between SoC and device.
> >>
> >> Please read what Andrew said:
> >> https://lore.kernel.org/netdev/3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch/
> >>
> >>   Assuming there is not a NOT gate placed between the GPIO and the reset
> >>   pin, because the board designer decided to do that for some reason?
> >>                    ~~~~~~~~~~~~~~
> >>
> >> You two are *not* talking about the same thing. I dismissed the
> > 
> > 
> > It's the same thing. NOT gate is just pulling some pin down or up.
> 
> Although transistor would be still needed, so indeed that's still a bit
> more than a wire and resistor as I implied.
> 
> It looks like:
> https://www.electronics-tutorials.ws/wp-content/uploads/2018/05/logic-log47.gif

A bit more than even that... I do hope folk don't use exactly that,
that's the kind of thing that would be used in "learning about
electronics" projects! That's a recipe to drive a transistor into
full saturation, which makes it comparitively very slow to turn off.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

