Return-Path: <netdev+bounces-155520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72576A02E26
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F86164B32
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85B1DC99E;
	Mon,  6 Jan 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r5Yobd/4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2321D5AA0
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181953; cv=none; b=DoyH9ciq4HRlVjDDTHwaqRjU/6+r7Dey12xP+4KkAtLWx7x3msgMILv+ZlY8xKfrM94L+CsvCne1wOdxTnBr9awE7iHeAzEr180mqcUywBQs5KHRR0mmX6hOqu3GcgrH49Vq5WqgwOaXvPHwBpmxhWlryC/cWVPvAfhcBxYNJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181953; c=relaxed/simple;
	bh=r8btyJhBe6h1DC0LxDyw4hvbcyVVPNJg9+AStRQ+Ijg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw3p8U8Gt9THVOTfPUHfkV/PdIIvD74hQgufHw3a/BF0pCbz9WyTYcugy1vpLbL3LwSqUp2u34kdvPNO4ICNjpqamJNQHtFBJeHnloB0amH7hv/TAeDwNp/60oJ98DFbDrwAUwQBxTRpnU6V6aNZX1ir4whGricc1HR25RanT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r5Yobd/4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TTBw/8twQXi9pbyFxx9LGrGU5Hjj6/2+Qg9FmAlzSXA=; b=r5Yobd/4Srwu5zPjD61dr/6lS0
	PYLb751fHqynwTFSO7K0aCM7P435vjExEyWv25ghiNb7YhIAqWEkGmEFRvl5nzS/8hw936gQ/Fsbs
	Duv3x8D6Jj7bdgdEkbZpJGpVnM9eewfmuZr2C4xLegmeVg5rSB2YMbqoi/XbwbaSY5WE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqET-001vsu-AI; Mon, 06 Jan 2025 17:45:37 +0100
Date: Mon, 6 Jan 2025 17:45:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 03/17] net: stmmac: use correct type for
 tx_lpi_timer
Message-ID: <0cf7eacd-6834-47d8-b370-cac5a7395d44@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmAE-007VWv-UW@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:24:58PM +0000, Russell King (Oracle) wrote:
> The ethtool interface uses u32 for tx_lpi_timer, and so does phylib.
> Use u32 to store this internally within stmmac rather than "int"
> which could misinterpret large values.
> 
> Since eee_timer is used to initialise priv->tx_lpi_timer, this also
> should be unsigned to avoid a negative number being interpreted as a
> very large positive number.
> 
> Also correct "value" in dwmac4_set_eee_lpi_entry_timer() to use u32
> rather than int, which is derived from tx_lpi_timer, even though
> masking with STMMAC_ET_MAX will truncate the sign bits. u32 is the
> value argument type for writel().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

