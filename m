Return-Path: <netdev+bounces-177818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C494AA71E37
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93331896F73
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE557251791;
	Wed, 26 Mar 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b4KIhiSm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0F1F7561;
	Wed, 26 Mar 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013346; cv=none; b=uP3ltXuL8G4ZAofarbHbwHuyugQWUjM19uojiV22pKmaSl0TeZ2XNT3Mba40itdOr45RsfWJwUid1GOfb0rRDFg6l/X7NkZQsgJX+A4m+v5Hm+/WPMiWshMfherBGFlGmKFsNP7YKoQgkmlXEW7bKhK2zOVzLB7MiyN4z7AlQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013346; c=relaxed/simple;
	bh=SaH4BztDb3GjFrot+1JCJfrrotQrNoVEQSHTmGL0ymU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY8uBY/UEC4ezx4aERg7Bb4FxJPevJI6ZOZm6ZfQa14Y+R6ZiVSZKjmLjHHeS2XtrPYECdkInWYNiGsKv83s7USjs8qU6PdRdb2GVdMKY7sKFuFeSgN0tTf3izn/hw8FUrJyOiWbE7VHvj2Xnjb8390rlT58FtaIlnoR50D34so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b4KIhiSm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S6UG/g4kXeJWqIlOD8zLxKVyyrfJXLskZtm4wFYt/e0=; b=b4KIhiSmAz644dnh2O+PXMCFbM
	EqvuM6CRqwEQ3AHAw9PJfersALKfcMxBz1x9aX4k7dLwhfS6l+0EdsI2kudPfZuDnu3crB7lx1cLH
	fSxUM+VPvKUwpnJ6MucJLvlF8s5AO4jUK0uee5LjijIOuXf4UBLUIN80h/1vvOTQF7k0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txVOB-007Cct-RF; Wed, 26 Mar 2025 19:22:07 +0100
Date: Wed, 26 Mar 2025 19:22:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: dsa: felix: check felix_cpu_port_for_conduit() for
 failure
Message-ID: <dc85eb72-cdec-43a1-8ad7-6cd7db9c6b25@lunn.ch>
References: <20250326161251.7233-1-v.shevtsov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326161251.7233-1-v.shevtsov@mt-integration.ru>

On Wed, Mar 26, 2025 at 09:12:45PM +0500, Vitaliy Shevtsov wrote:
> felix_cpu_port_for_conduit() can return a negative value in case of failure
> and then it will be used as a port index causing buffer underflow. This can
> happen if a bonding interface in 802.1Q mode has no ports. This is unlikely
> to happen because the underlying driver handles IFF_TEAM, IFF_MASTER,
> IFF_BONDING bits and ports populating correctly, it is still better to
> check this for correctness if somehow it fails.
> 
> Check if cpu_port is non-negative before using it as an index.
> Errors from change_conduit() are already handled and no additional changes
> are required.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
> ---
>  drivers/net/dsa/ocelot/felix.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 0a4e682a55ef..1495f8e21f90 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -523,6 +523,7 @@ static int felix_tag_npi_change_conduit(struct dsa_switch *ds, int port,
>  {
>  	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
>  	struct ocelot *ocelot = ds->priv;
> +	int cpu;
>  
>  	if (netif_is_lag_master(conduit)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> @@ -546,7 +547,12 @@ static int felix_tag_npi_change_conduit(struct dsa_switch *ds, int port,
>  	}
>  
>  	felix_npi_port_deinit(ocelot, ocelot->npi);
> -	felix_npi_port_init(ocelot, felix_cpu_port_for_conduit(ds, conduit));
> +	cpu = felix_cpu_port_for_conduit(ds, conduit);
> +	if (cpu < 0) {
> +		dev_err(ds->dev, "Cpu port for conduit not found\n");
> +		return -EINVAL;
> +	}

If i'm reading the code correctly you mean ocelot_bond_get_id()
returns -ENOENT?

If so, you should return the ENOENT, not replace it by EINVAL.

	Andrew

