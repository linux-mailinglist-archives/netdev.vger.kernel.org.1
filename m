Return-Path: <netdev+bounces-174961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7CA61A3F
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B5E3A4B40
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633782040BC;
	Fri, 14 Mar 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Axg7LZJg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F07D530;
	Fri, 14 Mar 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979840; cv=none; b=OouUDtYFhUEdAXA9TP5XP3riknvRcZmnM5JkUGTPoHAkvo0d9qdAatZ9oVVr7CkO07tQTBRhdYtdXU+399qof5CUBuEGGgcVAcIdwrwmr8c/eHqQcZ9r6UhM4dSPQbm+EHZJ/zPaQHjc5mnJ6YwPZ+kayrpZfwbCNpn4bXfX5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979840; c=relaxed/simple;
	bh=YjhN7yGHAgYFDdU+fi3f2nNPpZZ9ftpnKhdoH/fMKYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO64lA2w4CMxZyf+Fjh7SzmeXdNcTtuNZ+z12sp9FMW783r5eju1IRDhqBx2bZJIZ32h0CsTSysMIUGa9ZXkwWNBawXzuquNRHQeVMHI0ImACZrKUICWgXsHsBBA9z9dTvjhQA0WdJpko6uoet0MAE3un4mKtREquAWt7xzzBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Axg7LZJg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=14q1zuoC/RYgpg42ycjqCS4ie1FHZTJiWO21vFg6qTk=; b=Axg7LZJgdNjewBL3JmJdJjRst/
	x+jKPP3zJ0C+xYYh9xUgnBH1pROTkSJ0lR28U4q6kclRSU7gfyGVxoJEzNWkYluenQIkMYN/tHsEs
	jwlKbjzT8MOPsstAZgrAr7deVqqDqD2BHYSVuejuSKEG/zgHZE3gFV9+gIuUwKuX9gtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ttAWg-005Nnw-Nm; Fri, 14 Mar 2025 20:16:58 +0100
Date: Fri, 14 Mar 2025 20:16:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 09/13] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <2253e19b-2115-441e-b78a-3c10d61f2fad@lunn.ch>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309172717.9067-10-ansuelsmth@gmail.com>

> +static int an8855_mii_set_page(struct an8855_mfd_priv *priv, u8 phy_id,

phy_id is a bit of an odd name. __mdiobus_write() expects addr, since
at this level, it is just a device on a bus. We have no idea if it is
a PHY, or an Ethernet switch, or anything else.

> +			       u8 page) __must_hold(&priv->bus->mdio_lock)
> +{
> +	struct mii_bus *bus = priv->bus;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PHY_SELECT_PAGE, page);
> +	if (ret < 0)
> +		dev_err_ratelimited(&bus->dev,
> +				    "failed to set an8855 mii page\n");
> +
> +	/* Cache current page if next mii read/write is for switch */
> +	priv->current_page = page;
> +	return ret < 0 ? ret : 0;

__mdiobus_write() should only return -ve error code, or 0. So you
don't need this.

	Andrew

