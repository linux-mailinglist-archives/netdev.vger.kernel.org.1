Return-Path: <netdev+bounces-125540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A496D9FF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA68F1F2201E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652319CD19;
	Thu,  5 Sep 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ed3/0FsR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EA198852;
	Thu,  5 Sep 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542264; cv=none; b=Atf8MQx9pJ738ooO3X8MAk6Y7aFl/UxSjWl46Wqjzw2+Ed4+MglWQ+/NpGEuKKRXQVm/CXlEumVNFs14LXlpXs9KYKFJ5aZ7g7VaNMTm1hu5jiOzJY1A3o1DTf83WpqhISLrdOlBco0GU2PFBdc34izy37TxR3WpuwOvHA3SlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542264; c=relaxed/simple;
	bh=mtsb392WNG6b6DuTJvS0+Do9RHM8v8Le1vrjRjP9gpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQC+L1lKbNytjM0IZOSgQlvPSgHXpsC45rdk1smjG8QLQbq3bseREIaOUiKPLfLJhqqiWKWJyQDrCBjAjhAqti5VhvFBEBOMkD5mfmOjpNHr5FyYN4gDYIdf3KmBmCA/t01jUsMUlNB48bruMuG6KS7DCEZ3LbfaTgY3bO3/UpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ed3/0FsR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uSLA4QzqeKoxXIsDyYl7MU0S/K45h0h7fl/gv0XNWRw=; b=Ed3/0FsRR177NyjmXNhyo3INPI
	4yLjOWczASWhQV6rNqfMbNV5iB/brlmO7uzxEZEAx8QTuda8Eb8WgN947gwis0rXhgJAUY6xherwG
	+6ZloCVTpNVE98ytrnt8iD9yq9A1cyFEZ+cexnc8L+skiPEurC37CwaljDUx72BwAC3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smCMb-006gCV-F3; Thu, 05 Sep 2024 15:17:29 +0200
Date: Thu, 5 Sep 2024 15:17:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: saikrishnag@marvell.com, robh@kernel.org, jan.kiszka@siemens.com,
	dan.carpenter@linaro.org, hkallweit1@gmail.com,
	diogo.ivo@siemens.com, kory.maincent@bootlin.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Make pa_stats optional
Message-ID: <48c2a26c-b7ad-4449-921c-7dd65fd2909a@lunn.ch>
References: <20240905101739.44563-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905101739.44563-1-danishanwar@ti.com>

On Thu, Sep 05, 2024 at 03:47:39PM +0530, MD Danish Anwar wrote:
> pa_stats is optional in dt bindings, make it optional in driver as well.
> Currently if pa_stats syscon regmap is not found driver returns -ENODEV.
> Fix this by not returning an error in case pa_stats is not found and
> continue generating ethtool stats without pa_stats.
> 
> Fixes: 550ee90ac61c ("net: ti: icssg-prueth: Add support for PA Stats")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> NOTE: This fix is targetted to net-next because the concerned commit is not
> yet synced to net. So the issue isn't present in net.
> 
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 ++++++++++-----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  4 +---
>  drivers/net/ethernet/ti/icssg/icssg_stats.c   | 21 ++++++++++++-------
>  3 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index 5073ec195854..b85c03172f68 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -68,9 +68,13 @@ static int emac_nway_reset(struct net_device *ndev)
>  
>  static int emac_get_sset_count(struct net_device *ndev, int stringset)
>  {
> +	struct prueth_emac *emac = netdev_priv(ndev);
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> -		return ICSSG_NUM_ETHTOOL_STATS;
> +		if (IS_ERR(emac->prueth->pa_stats))

All these IS_ERR() are not so nice. What you often see is during
probe, if getting an optional resource returns an error, you replace
the error code with NULL. The code then becomes

> +		if (emac->prueth->pa_stats)
> +			return ICSSG_NUM_ETHTOOL_STATS;
> +		else
> +			return ICSSG_NUM_ETHTOOL_STATS - ICSSG_NUM_PA_STATS;

which looks nicer.

	Andrew

