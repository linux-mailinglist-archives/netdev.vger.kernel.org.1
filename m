Return-Path: <netdev+bounces-220074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F9DB445EE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CE61CC3930
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F52641C6;
	Thu,  4 Sep 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RuX5dCrs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63D25FA34
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012262; cv=none; b=iprzp8rX43DfQDYR3GfbFLlrvT6TprcX2MekRULMEazCXZeXJrtBeWJPecZcGU5K5WOrYVHf6BwfjSfQEbkR6w2p2t0Qw3stRKZnuepgDhbqMgFNWibqu8GJqjXHe1Kts+QFqoinIZAbx8P/xidj8TiewTJCNNMZoN0yXMZeFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012262; c=relaxed/simple;
	bh=pzNG+bCZZ0wDRj517I4ILeAsqiNTWNSZmIBSe/sa5EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfedvUElaIfW5lK+JlkcwBrxfEgZP+EE/gLQNRybA0W+DHNJjnMPDDO1arrfyJJA0N6KALjR1VPvQX8Z2lWdfJqVX+U8y3WEMCGQxSx2v4bKeUy/gb6ETvTcwvma67tkmRUsmH3IuCWGY0XCXtSDJZD6u2mtkAdqLESSloTTDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RuX5dCrs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xTiDOTyQs4o2KTqHJ5rl2nvLZ6nilRCAZAsj4RoV+iw=; b=RuX5dCrsF8J5h3npPIEwhd6p1F
	J2N+TqNVCqSV7s2Q6lfCFIxm2jnzk9yjEg85k9LeSVyqYs5kChyzThEWEzPvlOR3O0J/p2MHXyHT7
	1CDt79LQmAhNPZwOlmV7vM1JI0K7MurJ1LT/6SdKBjXck89KBPf4HplcIgyc3xeb3yKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuF9H-007G2z-7n; Thu, 04 Sep 2025 20:57:31 +0200
Date: Thu, 4 Sep 2025 20:57:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/11] net: stmmac: mdio: provide
 priv->gmii_address_bus_config
Message-ID: <91aaefa9-a594-4336-918a-5c50654ecb50@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8o2-00000001vog-1LyK@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8o2-00000001vog-1LyK@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:10PM +0100, Russell King (Oracle) wrote:
> Provide a pre-formatted value for the MDIO address register fields
> which remain constant across the various different transactions
> rather than recreating the register value from scratch every time.
> Currently, we only do this for the CR (clock range) field.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

