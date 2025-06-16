Return-Path: <netdev+bounces-198078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB9ADB2C4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C231B188B35F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7592877FF;
	Mon, 16 Jun 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bc7MEjpx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6C2877D8
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082295; cv=none; b=nPtKoU3ohiTXqx1ISf7LugH+xGMWAiXN/yL4uah5fhN1GriVxfgnIyY8TZEYK9Vo7ArP0+P5P0kYmhY4Evwb9zBWJWZl3mMjtbVb88P4l/0PJkfQkmY2KmP03ww4YMqk/R4QLN8ULKQSCv/8ar9UskyqarmPCTMDjKH6deIRZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082295; c=relaxed/simple;
	bh=b6KyW6z/xrfiTfzyKzXkU/2D5Mt1oJC1DaaGOaGoRgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhAO6LhCg0jB8M9cm85S/34si41EshkQtmuyuf1ylqS7McnLnc4ewv4mTLRNpYUDDWg1ohQXhDCTEz7gyecjfJWuhTuUNUUTO6cJlySw+BrYuW7hlf3YZFtEIpHY1cXqCH5WLrQJP0/avbEpsFougZwAXu3i+Mk98bqkA78lKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bc7MEjpx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kg6c7DN2SkuP8SyVzQMU1kpx6c5rN2uQONdKzQO88P8=; b=Bc7MEjpxSz2rtE+MQ5cF1Xf0Aq
	FWU4V7snbXOIFZBpyiDqsh5XKtYsgp/FyzzBUJHx3reL6TwmBpeC0W+2tv0/Jn5mF5oe3UuwzIv1d
	U/htPOQ4CCEpITmr4A1dwqow/7BZqcRdXb52GivUpqzVS0YpnZxyjHAmxLBNccmUDHyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRALd-00G3AG-9h; Mon, 16 Jun 2025 15:58:05 +0200
Date: Mon, 16 Jun 2025 15:58:05 +0200
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
Subject: Re: [PATCH net-next 3/3] net: stmmac: rk: remove unnecessary clk_mac
Message-ID: <66519abb-cf5a-4534-9e54-82850e11c15a@lunn.ch>
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
 <E1uR6sj-004Ku5-HR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uR6sj-004Ku5-HR@rmk-PC.armlinux.org.uk>

On Mon, Jun 16, 2025 at 11:16:01AM +0100, Russell King (Oracle) wrote:
> The stmmac platform code already gets the "stmmaceth" clock, so there
> is no need for drivers to get it. Use the stored pointer in struct
> plat_stmmacenet_data instead of getting and storing our own pointer.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

