Return-Path: <netdev+bounces-170431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97296A48B2F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A281516C913
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA85226177;
	Thu, 27 Feb 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DMHpKzLa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD25225A48
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694616; cv=none; b=kAHsMtttWHCYI1AVzAHgVrmAchwQc4XHjtJT+Gwn+kWQPyxv7spb1z0K3Nv69qReTK+lq5bk3CW7Nhgu38JW0ztglnuB3Vq8aDBkrKQ8TkdGSqGaYrcjfqwEEWRrHvcKQjDr8j7Nhbidmgk2IRuHKOpTGahl7QsfPaa2i8MbwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694616; c=relaxed/simple;
	bh=IOv+Xb2j0RrYST2gGKYh/2Dj7f2kiUoNglDM1DOmcyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLnkn9nYoeLeM7OOtM2ZD5Aeap0MOjuYsUkzgczolbmSWfEC8iZhGV0boIax4cdSdXqxoSblpZ4EmhRHAs0BTNb//Iwqw4nUFJRpwRocy9PQm7Zt61xUjWMzfModHqiwyVSFpjPluVFfGyA0nzG2y13cmO9kjeTGTLkvN/BEsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DMHpKzLa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0vW2upRPSd5LLd1via6CVZkp3pUHMr3UQjB71gJgNPE=; b=DMHpKzLamSx1RRMiNoYsM6m+ci
	1szkNqwNx0Bvn9TIM8if0t6a/A/dAc0WPfyi4eABJic8LWrdHYeF57qhQgLzR0LyKAVONHee/0tSL
	oZov52lh0f+TPqk75GsYNQUm2ErXinpjcf1PBFy1fB7HE51/1cl0WErp+cxvrG2Y20E8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnmBN-000jjN-A5; Thu, 27 Feb 2025 23:16:41 +0100
Date: Thu, 27 Feb 2025 23:16:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 2/5] net: stmmac: remove redundant racy
 tear-down in stmmac_dvr_remove()
Message-ID: <c8117288-5ef9-445c-a14d-28b2756e5944@lunn.ch>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRj-0057SF-9t@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnfRj-0057SF-9t@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 03:05:07PM +0000, Russell King (Oracle) wrote:
> While the network device is registered, it is published to userspace,
> and thus userspace can change its state. This means calling
> functions such as stmmac_stop_all_dma() and stmmac_mac_set() are
> racy.
> 
> Moreover, unregister_netdev() will unpublish the network device, and
> then if appropriate call the .ndo_stop() method, which is
> stmmac_release(). This will first call phylink_stop() which will
> synchronously take the link down, resulting in stmmac_mac_link_down()
> and stmmac_mac_set(, false) being called.
> 
> stmmac_release() will also call stmmac_stop_all_dma().
> 
> Consequently, neither of these two functions need to called prior
> to unregister_netdev() as that will safely call paths that will
> result in this work being done if necessary.
> 
> Remove these redundant racy calls.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

