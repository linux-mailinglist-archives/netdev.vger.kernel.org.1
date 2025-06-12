Return-Path: <netdev+bounces-197072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F2AD7725
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C217F9E7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010372D3A6C;
	Thu, 12 Jun 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SO3ihB7j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C942D322A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743321; cv=none; b=jdyL6n+EVfvtPvmYGLoXMlVVORDxIKIMhiYeT1C5bq5FSTsGwtCqWII3OMR8kzHcTaPWsZVvFAze6yYsx7rLTJMmXBk9a789oDklN9yTeWtKFHVfRhhANU6hnrUHGxC+uWDvpi6akt4PcQDXXklsShP7Uq+3NYHHjVsQIESezhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743321; c=relaxed/simple;
	bh=vWv4bNt9h4S1FvQTYmncjLOmQ38ocNSojLnufwTn3aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmIdiVZhmaDyafXnmZEvP4OZ4eADhMSA7tEU+cnkJLaDz5zkBgyzmMACHbDyAUqX24hSjGS/3g3nCeZKkT/VzSv+2QDo8jNExvdDBrNlHAEGOTkeKZr06+0UG9lwvf3TrCzJgbwwxzEhiEH3fkhJwNyXLLQagh3qKQnp/7RIzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SO3ihB7j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pq7C0R4E2XSkWcjWutsZp1ZBQTicxPhIkd8OpkWTuhk=; b=SO3ihB7jHnaSOG7iS49kyxLkGP
	BHymFTZSA5Inmq4qoxmPtj+UrTlvFco0FbIzAi10gEf3EpkvdT5GFbJKLz/vTTvSHRVnKcp8Mnpi7
	stkunfMdoTle+dJnHxo657gbXHreNGgH6Riddev5pW8D7V/Fa0qy68LJFxcIxenMzbB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPkAJ-00FZAe-Ns; Thu, 12 Jun 2025 17:48:31 +0200
Date: Thu, 12 Jun 2025 17:48:31 +0200
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
Subject: Re: [PATCH net-next 3/9] net: stmmac: rk: add struct for programming
 register based speeds
Message-ID: <92cfb2d8-03db-404d-96d6-c9782ce22bf8@lunn.ch>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
 <E1uPk2t-004CFN-Td@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPk2t-004CFN-Td@rmk-PC.armlinux.org.uk>

On Thu, Jun 12, 2025 at 04:40:51PM +0100, Russell King (Oracle) wrote:
> There is a common pattern in the driver where many SoCs need to write a
> single register with a value dependent on the interface mode and speed.
> Rather than having a lot of repeated code, add some common functions
> and a struct to contain the values to be written to a register to
> select the RGMII and RMII speeds.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

