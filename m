Return-Path: <netdev+bounces-139639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF039B3B53
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4931F21A02
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252091DFDB1;
	Mon, 28 Oct 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T/y0sYDU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742C1DEFCF
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147015; cv=none; b=adkwDu8sS73ApspHE+C7s+hcbvoV82wk4MD1+SA8kpDblGzie7kav+8LQFlfEk8nA1w20E3RB7nHW+NFAPhrMboovrbcXJLtADZXTvmY4MfzQp655ZtDMdCI3VpgZ5zMFzUrreYCXN5dfFRVFZ6CEg83UhLpK2tgGK61yyi2bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147015; c=relaxed/simple;
	bh=F/3fDSa5XC3iqr1+K3VuePfvXPgo2rnhIxeIBgrXp5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL00WUtA+8JAsYcYcVikiJDOlMXpjyCo5UpBSFjk6hTMel+ROY6Ut01mWwogspAQPZSlC/Z5eAW5UQKujbISsbLNpwsgwJs2s8exBJw9HnP0XK94rMU/rS9+xoHKCO3LW/d/vN2R2RvG2x+qxc09U2TS6Vd/DrcHm8Eo0LdQxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T/y0sYDU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eCa5Cfdq/dIYeb1XBnaQ/U67Co7nlY7mZ2ZvKcR/8xI=; b=T/y0sYDU/NH933LnF7Rht7xxpe
	LCeUmYT2flSxAS8YObF473YDFXO6KjmRYOcd4Vok5zuup+lehkZB5oaBmR/DK8vrZsuXVmgvZ87yM
	3Y0/uJmhHS1QVVhk8q0Q7Uv9CjaS5L+kxFt1jp99XMbnUb3k9Re78IEWqe2x1I9rhfNE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5WGf-00BU6K-FX; Mon, 28 Oct 2024 21:23:13 +0100
Date: Mon, 28 Oct 2024 21:23:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ethernet: ftgmac100: fix NULL phy usage on
 device remove
Message-ID: <8780e73e-78cd-4841-8c04-b453fe664bab@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>

On Mon, Oct 28, 2024 at 12:54:11PM +0800, Jeremy Kerr wrote:
> Commit e24a6c874601 ("net: ftgmac100: Get link speed and duplex for
> NC-SI") introduced a fixed phydev attached to the ftgmac netdev for ncsi
> configurations, cleaned up on remove as:
> 
>     phy_disconnect(netdev->phydev);
> 
>     /* ... */
> 
>     if (priv->use_ncsi)
>         fixed_phy_unregister(netdev->phydev);
> 
> However, phy_disconnect() will clear the netdev's ->phydev pointer, so
> the fixed_phy_unregister() will always be invoked with a null pointer.
> 
> Use a temporary for the phydev, rather than expecting the netdev->phydev
> point to be valid over the phy_disconnect().
> 
> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 9caee68468ff5f71d7ea63a0c8c9ec2be4a718bc..c6ed7ed0e2389a45a671b85ae60936df99458cd1 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1730,16 +1730,17 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
>  static void ftgmac100_phy_disconnect(struct net_device *netdev)

This all seems rather hacky. What is the mirror function to
ftgmac100_phy_disconnect(). I don't see a
ftgmac100_phy_connect(). Generally, if the teardown function does the
same as the setup function, but reverse order, it just works....

     Andrew

