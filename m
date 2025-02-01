Return-Path: <netdev+bounces-161937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE85A24B72
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA19F7A29C6
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5101CAA84;
	Sat,  1 Feb 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GVVVRP8r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453A1C5D73
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435774; cv=none; b=hKA/OsGtQMEI33WUcL9ncptDd/W6hzSbkXjNs8uGhqy9HTBr1l+bznyx7pCqIMazFRccDIFica1bm72VbFsvlwLjApBJhQNjqQznfK04InUj23hGD67L1Jwmf78cngQoeMHsx4dnoQI7Vjjuf2+OUN0+ACzd6OL2Zm/4UaXAnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435774; c=relaxed/simple;
	bh=RhSB4mWb6vQjS8yK5BDUzhBKzkheHvgWajj6Tnr3o6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1KWaY7h/dCWIbwHJGbXvYID7hpAdfPnfnhTx4g1esLDaTuELxwI+hL5BXbY0pQr8ZexNsjMdKSL1CfO/4o9weO/wxEz28u1GvPcKRl+ZmwYXIFCeg4thM1//3fJXg7fSvRVrsq21JY5qAGZnvCxuTKzMDRVcMc3zEPZDnHAH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GVVVRP8r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xUK+Tb/0hF3U3LVeV95eC7vzx8DCuibgkgA8f89ayu8=; b=GVVVRP8r2GKMyDfgJ17fhcl0CE
	aiUlVe+6C0XFkqvroMAzps4Kp+4cz4rA61n5GGqdnUizLHc3wxUlFLin4VEvpovnUhsJ8HRaJOA0j
	eprjgQ9wYboj4y0pCT7vVuGMhHgABYyjq4sMPa8AjMoLgzoTYFD8pU/weU/tfDct1Nrg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teIYV-00A2Ut-Cc; Sat, 01 Feb 2025 19:49:23 +0100
Date: Sat, 1 Feb 2025 19:49:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] net: ibm: emac: Use of_get_available_child_by_name()
Message-ID: <1465223e-a9f9-4bdc-a2f9-067884080bb2@lunn.ch>
References: <20250201165753.53043-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201165753.53043-1-biju.das.jz@bp.renesas.com>

On Sat, Feb 01, 2025 at 04:57:51PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> emac_dt_mdio_probe().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> This patch is only compile tested and depend upon[1]
> [1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 25b8a3556004..079efc5ed9bc 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2550,26 +2550,19 @@ static const struct mii_phy_ops emac_dt_mdio_phy_ops = {
>  
>  static int emac_dt_mdio_probe(struct emac_instance *dev)
>  {
> -	struct device_node *mii_np;
> +	struct device_node *mii_np _free(device_node) =
> +		of_get_available_child_by_name(dev->ofdev->dev.of_node, "mdio");

When you are new to a subsystem, it is probably better to send a
single patch to help figure out that subsystems way of doing thing. It
looks like all you patches have the same problem.


    Andrew

---
pw-bot: cr

