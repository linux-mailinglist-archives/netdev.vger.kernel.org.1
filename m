Return-Path: <netdev+bounces-198344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6AADBDCB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D4E189052E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6F229B28;
	Mon, 16 Jun 2025 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tqzZzy69"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360B40856
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117466; cv=none; b=TSq4dc8ARF1jtwVhZ+pAUuUHnk2W2jhqb4wtngO/aUs/v/10AbCDj+NdVFF8GVGqCTn+gw4zIJsoMELsAkHcbcbg7idkx1oxCe/ya88gvrDEGEnhoaeOXZ/ePtauEhDfSyVhIsITL86vssFlyKr3piPIp0W0Oqnv6J7hWDC6TMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117466; c=relaxed/simple;
	bh=TyCKZKGOAAPyR31zGJZMO38/BuApKNtVZReI//LPOeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4ZuYS43zbBrgLRrIvpE8dP2dcviT+dBZIdHzft+PztXm3cnUb6ETGI5mn7+RfaQr4+SM7WimYBFmdDefQ/SQoiQ2mlk4WP3ClOBlIJgQZ5/FURilPfwwj4xpXF1dLwFOtFOzJKJ3gYEus+789rCvgd6+/53kR0fLomMsKpSB2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tqzZzy69; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E1MZF6qJ4kR4/xO2ag9oWgv0qmKN1SifNEp7nDneWJI=; b=tqzZzy69zkTYAVEJjjhpDX/o7O
	T2Cem5IHWwYJDak/HKqK7V0GVQTjv5gx1NBDIwOLgEfUyng0PkhiZSdSKZTBwUC3S7W0e1Tct1a2s
	7T2pHNKj97HdVUkwzvLNvCWPLJ/egIYUQf+P7ZTOPYuFZZKzc3dDbtGILNFiZulX5rc4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uRJUr-00G6Zd-IF; Tue, 17 Jun 2025 01:44:13 +0200
Date: Tue, 17 Jun 2025 01:44:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: Re: [PATCH net-next] dpaa_eth: don't use fixed_phy_change_carrier
Message-ID: <c93dacff-eb7f-4552-9a1d-839b416fb500@lunn.ch>
References: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
 <8020ee44-e7b1-4bae-ba34-b0e2a98a0fbd@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8020ee44-e7b1-4bae-ba34-b0e2a98a0fbd@intel.com>

On Mon, Jun 16, 2025 at 03:47:57PM -0700, Jacob Keller wrote:
> 
> 
> On 6/16/2025 2:24 PM, Heiner Kallweit wrote:
> > This effectively reverts 6e8b0ff1ba4c ("dpaa_eth: Add change_carrier()
> > for Fixed PHYs"). Usage of fixed_phy_change_carrier() requires that
> > fixed_phy_register() has been called before, directly or indirectly.
> > And that's not the case in this driver.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Is this harmful to leave set if fixed_phy_register() is not called? If
> so then this could be net + a fixes tag instead of net-next.

It appears to be used if you echo something to
/sys/class/net/eth42/carrier. It will return EINVAL.

The same will happen if you use do_set_proto_down() via rtnetlink.

Apart from the EINVAL returned to userspace, nothing bad will happen.
So i don't think this needs a Fixes: tag.

	Andrew

