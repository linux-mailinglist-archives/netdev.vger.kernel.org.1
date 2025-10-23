Return-Path: <netdev+bounces-232235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E666BC030E8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDB244E5EE7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D97725B663;
	Thu, 23 Oct 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L62SfJoo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4B35B120
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245173; cv=none; b=seoz/n2aphugbFlB586bKd1GtCoYyz1ngoeQI9vIl63sSU9b5qrXp6fTjzKSF8gfj8dXafjPbkWD+InQyHp+bWFIflUXTeZO4gPAFdL5ZYgXjdM7fp0bYUjd9TeY0mIk8CgFyBfup9wt+6e8YMU8zu2XZe0xRBziw2OrvUosN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245173; c=relaxed/simple;
	bh=hXJl47hM5XgE3BLk19OxqY3biicvykmF1zeiG5/McbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umFdjsRy8J0cayf3MnF0WpEpI5StFpEceNbPmIM6P395d7aoVX2pJkt5DtxZhtpYFeymTmVrgwV2kdPCkFFexFjKXooN7vsZGxvhpDUufK81ZUNCA45tarAk1IUbkhZcN7qhQkh1XfxgskL5kHPT17i7qPqVEbLtQRxGWXbChT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L62SfJoo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KXMWS8elffTVXMlbgTNjkC6/Aglod5o8DOa2MMAXrA4=; b=L62SfJooNCDP7njm3znI64QK1F
	SRJoLxTzb9+BZtYoPrYfcDJp6DqLZTjrizYW10neasQPv0nkANZIMDZ4su0t3rSoD/BMjUkZHcsz6
	IJuLXwUQL56tozuA+ozzA3yI4Rpaw5YXMNV4NtE3CVXyAyXVxk/n1d4WYDeFRDKZ4bks=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0K1-00BuXq-0E; Thu, 23 Oct 2025 20:46:01 +0200
Date: Thu, 23 Oct 2025 20:46:00 +0200
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
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 2/8] net: stmmac: simplify stmmac_get_version()
Message-ID: <81d5c1f2-e912-40de-a870-290b0cf054b3@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrlB-0000000BMPs-1eS9@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrlB-0000000BMPs-1eS9@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:29AM +0100, Russell King (Oracle) wrote:
> We can simplify stmmac_get_version() by pre-initialising the version
> members to zero, detecting the MAC100 core and returning, otherwise
> determining the version register offset separately from calling
> stmmac_get_id() and stmmac_get_dev_id(). Do this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

