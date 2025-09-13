Return-Path: <netdev+bounces-222788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E77B560FA
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B29C3B67A0
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D12EBB81;
	Sat, 13 Sep 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+Nnwqsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A85288D6;
	Sat, 13 Sep 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757768504; cv=none; b=acX0DgjZ2yI07X2v/n0mDAvxNseRA55U8/z7FyqZOregeKJyZFh+okc+dzevMdPdj/Uh7064HhkXYDhAsHwMyuKPrjwuNhJRJD5UBZu4/rT+/nyDOocx/NuL9iT201T30jlwIBOTSsRHlUI/8NpFmVsxPefv2DLisVCZe9N7zWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757768504; c=relaxed/simple;
	bh=AomHbXjj2ZCUcLKxzCjlmTkzRv3ch6j47Nsf97s7m28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9qXYCiqCkefO/bHZrmXlwxeEZy4HjgeqkoGGpOg+lRb1F4AhVLDqTlHyWieLaRtxJCks1UOWvuO30vbKjAY7w/oUW82dGkfVNH7UmGB/R8F8J23s2mXgXhWYg5WoLAKvlPDB/oaayNV/zWg1IfSyJ7FB1ld4uBG3nW6Nm7WxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+Nnwqsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1000C4CEEB;
	Sat, 13 Sep 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757768504;
	bh=AomHbXjj2ZCUcLKxzCjlmTkzRv3ch6j47Nsf97s7m28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+NnwqsdjYqUUU5iDKDNJ1RiHTJ41S+3Q5XcrXwOvxElRasNhNUyyKz0q22WSbK24
	 Iv9gkT9b9xl9pVbotzkof4Al5C1TtWA/zJrlymNERSHnY447cR/VRfac1D31t/WBCw
	 lkpDKFRO4rZuYPCIK+IwL5DSMBBgvRSaEhd2tjDlXb2Eu1QTM1LbcNOMxi6n2ISqCi
	 9KEA4/V+KEHgPDpRaU/FAhFE7YMpYwJ8mVKeqt0yjjadCUEguXponQbyqPn99Kqbla
	 MeTXIG6jKyUr+OtDEB3CQ4jdTOXrWDRYPTr4tajuv7QT78p/rTgjVv7fhvHHI/VCYq
	 X9j/XgJIxBfFg==
Date: Sat, 13 Sep 2025 14:01:37 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v17 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250913130137.GL224143@horms.kernel.org>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
 <20250911133929.30874-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911133929.30874-7-ansuelsmth@gmail.com>

On Thu, Sep 11, 2025 at 03:39:21PM +0200, Christian Marangi wrote:
> Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> switch and a NVMEM provider.
> 
> Also make use of the mdio-regmap driver and register a regmap for each
> internal PHY of the switch.
> This is needed to handle the double usage of the PHYs as both PHY and
> Switch accessor.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

...

> diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c

...

> +static int an855_mdio_register(struct device *dev, struct an8855_core_priv *priv)
> +{
> +	struct device_node *mdio_np;
> +	int ret;
> +
> +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> +	if (!mdio_np)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
> +		ret = an8855_phy_register(dev, priv, phy_np);
> +		if (ret)
> +			break;
> +	}

Hi Christian,

Maybe it cannot happen, but if the loop above iterates zero times,
then ret will be used uninitialised below.

Flagged by Smatch.

> +
> +	of_node_put(mdio_np);
> +	return ret;
> +}

...

