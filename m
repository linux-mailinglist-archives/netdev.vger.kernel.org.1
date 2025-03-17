Return-Path: <netdev+bounces-175473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F9A660A7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E08717818F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C31FECD7;
	Mon, 17 Mar 2025 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eVkO+aTu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF618EFD1
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247359; cv=none; b=MQmFPYEvsngMEERsrO391jAsjb9qqoHUOijfjn5kqYlxKwnEzyFZ5kRJVVdvD0izIZaCBTetPVamicSUj5HCHLYXtk3jXd83j/XqayzE7VBF56b0rCgQtwIw+T9tPbBxZ0XSOb8lcH99LgBjBAkF6esPLglsMuyf1LCutLtDzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247359; c=relaxed/simple;
	bh=S11G/nySYLSKxGhFpmPXx1T9aZwFPmUvbhr3ZAH9n18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgd6duiVaju3VxSdvd93yobg9PeHdbLegabecXG08bvqZ8K/g+TawGxFEIfEYiRTUhz+xsQ32ij/M0MKaSk7LXBirltO2He2sNPh92Tpp8Vv/w6r5lBK+GX2grUTidmLIr+MzkEfbA0rdmJZig7CGse/VHdKnjDjnJ7SfWuqyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eVkO+aTu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ocezziAHQz9/hQpHVJSmv4oBhFZMfNuOT6O8Nv3bhkw=; b=eVkO+aTuyUzlARyJSYdl7B00cE
	8eJMYUCX/mcxWtazR1gXys1npZW8/h91aIhbAHyoEK/vo5evdxhRQHVxYFziifi9lHNGlbYOwNSe7
	0e8CAvjdxHqa1kHk/7KM57/1gmdvKe4eG5siYXcWFf8gWwUmg7lhYgq+G2F+Gq1OIWaE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuI7l-006BRM-Ct; Mon, 17 Mar 2025 22:35:53 +0100
Date: Mon, 17 Mar 2025 22:35:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: fix genphy_c45_eee_is_active() for
 disabled EEE
Message-ID: <a6c0ed10-4bd8-4f86-bec9-8b2940ea636e@lunn.ch>
References: <E1ttmWN-0077Mb-Q6@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ttmWN-0077Mb-Q6@rmk-PC.armlinux.org.uk>

On Sun, Mar 16, 2025 at 11:51:11AM +0000, Russell King (Oracle) wrote:
> Commit 809265fe96fe ("net: phy: c45: remove local advertisement
> parameter from genphy_c45_eee_is_active") stopped reading the local
> advertisement from the PHY earlier in this development cycle, which
> broke "ethtool --set-eee ethX eee off".
> 
> When ethtool is used to set EEE off, genphy_c45_eee_is_active()
> indicates that EEE was active if the link partner reported an
> advertisement, which causes phylib to set phydev->enable_tx_lpi on
> link up, despite our local advertisement in hardware being empty.
> However, phydev->advertising_eee is preserved while EEE is turned off,
> which leads to genphy_c45_eee_is_active() incorrectly reporting that
> EEE is active.
> 
> Fix it by checking phydev->eee_cfg.eee_enabled, and if clear,
> immediately indicate that EEE is not active.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

