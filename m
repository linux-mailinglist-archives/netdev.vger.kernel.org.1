Return-Path: <netdev+bounces-165517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F15A326CF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E143A7819
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCE520E024;
	Wed, 12 Feb 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jzj0DOo1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BF2066DB;
	Wed, 12 Feb 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366120; cv=none; b=CNjhOSPH0XPVskWngxgUSUuJjnUohijpr8kzblORyxJJ5jrXoMKxn9xeYeAkI633VdIVs8sksUVIPxnUgF+Kdnm/dEvG6LG8GJ7FZgn0z60ZO3oXQwiVGSRqFMK4API4HjPcbtcWiB/oB1xqu5a9LTe/lQyxpbrwWcgvwRM435M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366120; c=relaxed/simple;
	bh=aaENiWK5qeN70Em+WDEKVv+4R2zA3wf/rDoTcO5YYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJwSeYZy/IdqI9ye17vHhyY5EmZT0rLuC5SECisOTZz2Dc/TOGw+YMwMjZ9QGCX1lbFTyn8xpO+cIDH14x5sAMFUV2kDibFw7FGCcCm+V/qq8WSBt/dGQ8gfuyMpit4OzGbE+CEZg/kKgYPm0O+yCRvLPFpV10LwDDL5ekkN/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jzj0DOo1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aTmA/TLrE9tOJ1577A2180d7gUiYGDdGBwySWLOkaOg=; b=jzj0DOo1pFwHU0CVJQ5X7LNdVA
	IeTpzwnLj5StJjh4zdD4JJVIPh+3xGFe1FoXgzpKyO/1UhMPaFkd/ht7N9CxK6xJl1zSjl70M8DUs
	M7qRKMTcL052yZG2LVEjD55pfS82Eov9xdtxscC0ad0X+nlNYn5mPemxfIM+NqFl7XWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiCa4-00DOn9-GE; Wed, 12 Feb 2025 14:15:08 +0100
Date: Wed, 12 Feb 2025 14:15:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v4 2/3] net: phy: Add helper for getting tx
 amplitude gain
Message-ID: <84b5b401-e48b-4328-84b2-f795c1404630@lunn.ch>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-2-1e8ebd71ad54@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-dp83822-tx-swing-v4-2-1e8ebd71ad54@liebherr.com>

> @@ -3133,12 +3126,12 @@ static int phy_get_int_delay_property(struct device *dev, const char *name)
>  s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
>  			   const int *delay_values, int size, bool is_rx)
>  {
> -	s32 delay;
> -	int i;
> +	u32 delay;
> +	int i, ret;

Networking uses reverse christmass tree. So you need to sort these two
longest first.

> +int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
> +			      enum ethtool_link_mode_bit_indices linkmode,
> +			      u32 *val)

Since this is an exported symbol, it would be nice to have some
kerneldoc for it.

> +{
> +	switch (linkmode) {
> +	case ETHTOOL_LINK_MODE_100baseT_Full_BIT:
> +		return phy_get_u32_property(dev,
> +					    "tx-amplitude-100base-tx-percent",
> +					    val);

So no handling of the default value here. This would be the logical
place to have the 100 if the value is not in device tree.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL(phy_get_tx_amplitude_gain);

I would prefer EXPORT_SYMBOL_GPL, but up to you.

    Andrew

---
pw-bot: cr

