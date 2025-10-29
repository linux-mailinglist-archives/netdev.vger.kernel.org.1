Return-Path: <netdev+bounces-233972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A845C1B394
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0125C626CF7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE7242D8A;
	Wed, 29 Oct 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nbxt5b7Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F541223DE8;
	Wed, 29 Oct 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744029; cv=none; b=jnBwsuEXXdq/7VK31sORpsBdqkUcApGfMMTn5fHuD9xzSv2AQ65nwqqK7lWtI5fe8UueVhUOOKoodX9Pb6Az0W2MG3VoUq4JaZi8NCFYqUz0r56zLWptVWFUkPRzYN/pZ8on6B3D+gJixtCdv+u9nfOzacVE67/cx4zrZTbpAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744029; c=relaxed/simple;
	bh=GgyosBxSCtZCaTM2Fx98F2nUfbbe2h51kr2+GNIFkM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYwAoOWFjAscHgpXUe7I165LGV+Mz9g4WDvoNaJRTylxA3Vx2ElvznN3IEZ1JnMaSOprxrVNcxit+EaSPz2MC1QOIq7ofS+cwZSaO/e0f5zopCve94zdIIt9JRRheGeYAlP3caqAG2xFTRoxXJzzyjMgERVjrjMXgpUXizN9t5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nbxt5b7Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hyTW+gBJjnpvgL6F0hUmkX6o8vJScOeRcapB3a98qzU=; b=nbxt5b7YdYgg+X/cL9Xu2RkBsI
	bjLcva473eqYhUTl6wi+ISAxRVdviksUg3R4HRmb/dJt37A6qbtXxT+C7IIU/jP+Hwy5npbfvSSQm
	j89XKPh7QDIfvwk9HnEk4fmj7BDriHLtwwIgljcGtUocR+f6iUaYklZuNlcg/SscsOFk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE662-00CPQI-PW; Wed, 29 Oct 2025 14:20:14 +0100
Date: Wed, 29 Oct 2025 14:20:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/4] net: mdio: reset PHY before attempting
 to access registers in fwnode_mdiobus_register_phy
Message-ID: <e61e1c1c-083b-472f-8edd-b16832ca578e@lunn.ch>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8d93021a7aa6eeb4fb67ab27ddc7de9101c59f.1761732347.git.buday.csaba@prolan.hu>

> +/* Hard-reset a PHY before registration */
> +static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
> +			    struct fwnode_handle *phy_node)
> +{
> +	struct mdio_device *tmpdev;
> +	int rc;
> +
> +	tmpdev = mdio_device_create(bus, addr);
> +	if (IS_ERR(tmpdev))
> +		return PTR_ERR(tmpdev);
> +
> +	fwnode_handle_get(phy_node);

You add a _get() here. Where is the corresponding _put()?

Also, fwnode_handle_get() returns a handle. Why do you throw it away?
What is the point of this get?

> +	device_set_node(&tmpdev->dev, phy_node);
> +	rc = mdio_device_register_reset(tmpdev);
> +	if (rc) {
> +		mdio_device_free(tmpdev);
> +		return rc;
> +	}
> +
> +	mdio_device_reset(tmpdev, 1);
> +	mdio_device_reset(tmpdev, 0);
> +
> +	mdio_device_unregister_reset(tmpdev);
> +	mdio_device_free(tmpdev);
> +
> +	return 0;
> +}
> +

	Andrew

