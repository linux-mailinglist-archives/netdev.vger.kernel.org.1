Return-Path: <netdev+bounces-164962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F1A2FE99
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8FC1887035
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B56E25E470;
	Mon, 10 Feb 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2O5WYhNt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB1194141
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739231046; cv=none; b=Yfd4WYeYLFYsp7sRnFSPQThq5FZj0iTlHUR8EiOAEXPxbrspr/htQr6t9cIELj1K33P11iPCNpsnTYbqw9WYcrOXZaoaUWj7/TInWiiiaSV3r3nBysOeZYtl5DHa34og0mIz2fr5QuKVAeZe07pseSQ3b7iAmfPRbZC4fCpT080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739231046; c=relaxed/simple;
	bh=4wdt4i5RWTvirgj9C4mIYtEvg7SkqV/7aaKwMYpbbco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfWhTCFkgqRZoJOPKJd89nJsV4Czk9dMSHnuw6tx/BgDb03QC7m3hadO8+gNi4wp7Bv+CnvhYcfaaK4ipiMFOqpW119B8yt9CHdpilc/cnhNdjnFse+tXyvUOkCq8+/rB2/Mk4/MpA/MUYKie4TGbl1QvB8DtC+4bdtOktYurJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2O5WYhNt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TQoIKTC4F29j3zhkzzTdWiTiq+DveQGlu8tEPYrS5Z0=; b=2O5WYhNtC5VJuZReoo4JOnl8Mj
	eqLQr14u4Y/zT13qc3+8jKXzL9Axe3b/eXidQPRh0xxKAMvk2zNs/rHGjJkOJAedK7Yx8JAHS5/zK
	rJRfCSFjm8ObRi1DHI6o913GPzvZICteBfSlL2UF+6RzKdewatNTwJE7cq8CMPDgoeYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1thdR5-00CsBE-KW; Tue, 11 Feb 2025 00:43:31 +0100
Date: Tue, 11 Feb 2025 00:43:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, maxime.chevallier@bootlin.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org
Subject: Re: upstream Linux support for Ethernet combo ports via external mux
Message-ID: <e56150f0-1a57-4a04-ae74-d966e3dda5d3@lunn.ch>
References: <Z6qHi1bQZEnYUDp7@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qHi1bQZEnYUDp7@makrotopia.org>

On Mon, Feb 10, 2025 at 11:11:07PM +0000, Daniel Golle wrote:
> Hi,
> 
> Looking for ways to support a passive SerDes mux in vanilla Linux I
> found Maxime's slides "Multi-port and Multi-PHY Ethernet interfaces"[1].

Maxime is still working on this. There was a patchset posted
recently...

> The case I want to support is probably quite common nowadays but isn't
> covered there nor implemented in Linux.
> 
>  +----------------------------+
>  |            SoC             |
>  |    +-----------------+     |
>  |    |       MAC       |     |
>  |    +----+-------+----+     |
>  |         |  PCS  |   +------+
>  |         +---=---+   | GPIO |
>  +-------------=-------+---=--+
>               |            |
>            +---=---+       |
>            |  Mux  <-------+
>            +-=---=-+
>              |   |
>             /     \
>      +-----=-+   +-=-----+
>      |  PHY  |   |  SFP  |
>      +-------+   +-------+
> 
> So other than it was when SoCs didn't have built-in PCSs, now the SFP is
> not connected to the PHY, but there is an additional mux IC controlled
> by the SoC to connect the serialized MII either to the PHY (in case no
> SFP is inserted) or to the SFP (in case a module is inserted).
> 
> MediaTek came up with a vendor-specific solution[2] for that which works
> well -- but obviously it would be much nicer to have generic, vendor-
> agnostic support for such setups in phylink, ideally based on the
> existing gpio-mux driver.

I don't actually understand how it can work. For the PHY the PCS
probably needs to be running SGMII. For the SFP it probably wants
1000BaseX. It looks like phylink has no idea the mux has been flipped,
so it needs to reprogram the PCS. You cannot just create two phylink
instances and flip flop between them. You need phylink actively
involved so it can correctly manage the PCS.

	Andrew

