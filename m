Return-Path: <netdev+bounces-197046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C07AD76B9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD4217CFEC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407CF29B8EA;
	Thu, 12 Jun 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AokftquE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0D29899D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742750; cv=none; b=Em7YZvI0Yo6gE2ee/CzaR5BAFFoPvqvdFbtu7PksiGaXZ3ggFmpqAhuVtZJfukmNkjF0BakevFIiL0G1Wq2hir9875OXGfToT920n2onRgZZNEDegUAE9Gvd3CNr5rJfK4n8J1R21nWOCsTdpELhvEyoYyBK1nSvietmnMfVgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742750; c=relaxed/simple;
	bh=yS9kY3Pun9P35enIw5K4tBP/k5w73YxTBU1S2/TdoqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryXhPzoe1oupZkdpPH5hutWXbjQJjdkwt4cC707NOvNIar9umokscs7gnDk8IDyXQkSf6q5Far7XoVI3Pt9RR7vNDVJoZfd3VgxnnoRtfaTo+XhXDVxFI2ToM+yq1OogJ6cBV4Lp37xoz0LXnz4RPerO1V6Yyu10m9DFnkGCI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AokftquE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d5POXrwIe5mG+yNJWkyn2wpz0/e3gRt3NbqS1KIA9Gg=; b=AokftquEAWMOmyMx6ONHpXNmgW
	VbfMs+qRypR7abRpqDm5Sriwfv+ZdGWT3RTnYjM0O6F/UacrOX6pn13u94FgZuuMrm5ekyNsz21lp
	gCcY9oWc0mzJZ13Nz6Ay4s33srFqK7t3RMWOPHza3UmV6ghm+Zx8hhYIfaK2W9rxFT6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPk1A-00FYtk-AF; Thu, 12 Jun 2025 17:39:04 +0200
Date: Thu, 12 Jun 2025 17:39:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: simplify phy_get_internal_delay()
Message-ID: <b6c479d7-2134-4c87-bab0-61a2f2381f23@lunn.ch>
References: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>

On Wed, Jun 11, 2025 at 02:56:19PM +0100, Russell King (Oracle) wrote:
> Simplify the arguments passed to phy_get_internal_delay() - the "dev"
> argument is always &phydev->mdio.dev, and as the phydev is passed in,
> there's no need to also pass in the struct device, especially when this
> function is the only reason for the caller to have a local "dev"
> variable.
> 
> Remove the redundant "dev" argument, and update the callers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

