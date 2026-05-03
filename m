Return-Path: <netdev+bounces-283540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MNHMh7G9mn4YQIAu9opvQ
	(envelope-from <netdev+bounces-283540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 05:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2D4B453E
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 05:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C41C93009F92
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 03:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E933A6EB;
	Sun,  3 May 2026 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j1MpHy9V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44019AD5C;
	Sun,  3 May 2026 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780251; cv=none; b=J+VDqeCTUPuJI/jaL/5GM7yy0Aure9RMK78R9s8c6/+mjecghRPZuILPJ877X8UuQyD3VvErI9JlTE9VsARqSzRLjX/KtZCmVCMKs/JPPUJ37jkmNi6bxabNdpwJhCit/kC2euVlYUKwYHmLjOd5ziNaPvt1lxzC7xA7CT/rze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780251; c=relaxed/simple;
	bh=KkhqH+enIGlDSe9wpYpqRmRgrfu9Qk/ZTE4eris/8Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNSbYWA2lfHLDsEevH6fAZSuPSOSiXibqJSsR7Q5xc7Ycw9EvLDnGHS2YB7jSnq3FvmZSiGRECCUvJCgrv+gi8uOA1bKNUO7aEvymevVoRWZBzHqVuinSp/bfEAw7UbTHR4/db5Tyrd/VfcupjQB19xHfboQjMCV0WhKyMaE6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j1MpHy9V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KLkq4GgpHcZIZ9V0bLeLbrvyjtYFqPx7kxg5KQcjpck=; b=j1MpHy9V5i9l9+BKoELUgjp6g/
	WACT0v4chUJ+WkillWjstNQgm7aq+y7Ch3mJaDf72tq5dD+BBAhL6Q2lQ24dWPXyOj+fTWG3aflJX
	DMOOMZiyegGm/dozODK+0GgW79Gv61zhMF3JHMRh9VeSn8zk48pRJmtW3KZ16OngQcZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJNqm-0015PB-20; Sun, 03 May 2026 05:50:36 +0200
Date: Sun, 3 May 2026 05:50:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: ethernet: oa_tc6: Allow custom mii_bus
Message-ID: <aad9cb98-8f1f-409f-8d58-0318e125210c@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-2-dd043cdd88f0@analog.com>
X-Rspamd-Queue-Id: 2AB2D4B453E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283540-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> @@ -538,32 +539,37 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
>  {
>  	int ret;
>  
> -	tc6->mdiobus = mdiobus_alloc();
>  	if (!tc6->mdiobus) {
> -		netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> -		return -ENOMEM;
> +		tc6->mdiobus = mdiobus_alloc();
> +		if (!tc6->mdiobus) {
> +			netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> +			return -ENOMEM;
> +		}
> +
> +		tc6->mdiobus->read = oa_tc6_mdiobus_read;
> +		tc6->mdiobus->write = oa_tc6_mdiobus_write;
> +		/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
> +		 * C45 registers space. If the PHY is discovered via C22 bus protocol it
> +		 * assumes it uses C22 protocol and always uses C22 registers indirect
> +		 * access to access C45 registers. This is because, we don't have a
> +		 * clean separation between C22/C45 register space and C22/C45 MDIO bus
> +		 * protocols. Resulting, PHY C45 registers direct access can't be used
> +		 * which can save multiple SPI bus access. To support this feature, PHY
> +		 * drivers can set .read_mmd/.write_mmd in the PHY driver to call
> +		 * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
> +		 */
> +		tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
> +		tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
> +
> +		tc6->own_mdiobus = true;
>  	}
>  
>  	tc6->mdiobus->priv = tc6;
> -	tc6->mdiobus->read = oa_tc6_mdiobus_read;
> -	tc6->mdiobus->write = oa_tc6_mdiobus_write;
> -	/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
> -	 * C45 registers space. If the PHY is discovered via C22 bus protocol it
> -	 * assumes it uses C22 protocol and always uses C22 registers indirect
> -	 * access to access C45 registers. This is because, we don't have a
> -	 * clean separation between C22/C45 register space and C22/C45 MDIO bus
> -	 * protocols. Resulting, PHY C45 registers direct access can't be used
> -	 * which can save multiple SPI bus access. To support this feature, PHY
> -	 * drivers can set .read_mmd/.write_mmd in the PHY driver to call
> -	 * .read_c45/.write_c45. Ex: drivers/net/phy/microchip_t1s.c
> -	 */
> -	tc6->mdiobus->read_c45 = oa_tc6_mdiobus_read_c45;
> -	tc6->mdiobus->write_c45 = oa_tc6_mdiobus_write_c45;
> -	tc6->mdiobus->name = "oa-tc6-mdiobus";
>  	tc6->mdiobus->parent = tc6->dev;
> +	tc6->mdiobus->name = "oa-tc6-mdiobus";
>  
>  	snprintf(tc6->mdiobus->id, ARRAY_SIZE(tc6->mdiobus->id), "%s",
> -		 dev_name(&tc6->spi->dev));
> +			 dev_name(&tc6->spi->dev));
>  
>  	ret = mdiobus_register(tc6->mdiobus);
>  	if (ret) {
> @@ -577,19 +583,30 @@ static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
>  
>  static void oa_tc6_mdiobus_unregister(struct oa_tc6 *tc6)
>  {
> +	if (!tc6->mdiobus)
> +		return;
> +
>  	mdiobus_unregister(tc6->mdiobus);
> -	mdiobus_free(tc6->mdiobus);
> +
> +	if (tc6->own_mdiobus)
> +		mdiobus_free(tc6->mdiobus);
>  }
>  
>  static int oa_tc6_phy_init(struct oa_tc6 *tc6)
>  {
>  	int ret;
>  
> -	ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
> -	if (ret) {
> -		netdev_err(tc6->netdev,
> -			   "Direct PHY register access is not supported by the MAC-PHY\n");
> -		return ret;
> +	/* If the driver provided a mii_bus, it is also responsible for
> +	 * implementing the bus access methods, so we don't have to worry
> +	 * about checking the PHY access mode.
> +	 */
> +	if (!tc6->mdiobus) {
> +		ret = oa_tc6_check_phy_reg_direct_access_capability(tc6);
> +		if (ret) {
> +			netdev_err(tc6->netdev,
> +				"Direct PHY register access is not supported by the MAC-PHY\n");
> +			return ret;
> +		}

This all seems pretty invasive and ugly. Please could you think what
happens if instead of passing in an mdiobus, you pass a phydev. Is the
change to the core simpler and cleaner?

	Andrew

