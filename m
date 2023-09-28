Return-Path: <netdev+bounces-36930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23E7B25A9
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DA26C281CE6
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACC2E658;
	Thu, 28 Sep 2023 19:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E25253;
	Thu, 28 Sep 2023 19:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BEAC433C7;
	Thu, 28 Sep 2023 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695927945;
	bh=hL+1NK7FhszHgz8oD0fZO4rkoqzQEsWg3x3hhHFUDiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5RF0CV+X6PZ2UnKfF1cHF0YRVn39sT/fWwmRXYooWHxcmtRfB3Pzkh3H2SXVWzDK
	 hOxEwwX8zPxXSRo+nXVuHXZF9uCGZwEZ6m3OTiBlR69wgxpSgERc0v+wlxEAEr59KS
	 BdQHOnTrmj1EGypvPQozajvkpiL4Q9I14qQvIwl3tcuL2tvZD1jvxxuOgLi5Jrcsuo
	 xDw5ORw6S9vV08RvCLEGmVSepCLo+YMUoaqOssAzZfxjd7/Xh9YAsYf9AsKo3Zv/vv
	 WAGeKLgkgQzr6RuMmGMoxP9uHdb1dZzLt7RnDAxU8f+O5yW+zUd8r5Zs5MCyNqw9O1
	 slQ1GCspCCBPw==
Date: Thu, 28 Sep 2023 21:05:36 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 03/15] phy: ethernet: add configuration
 interface for copper backplane Ethernet PHYs
Message-ID: <20230928190536.GO24230@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-4-vladimir.oltean@nxp.com>

On Sat, Sep 23, 2023 at 04:48:52PM +0300, Vladimir Oltean wrote:

...

> +/**
> + * coef_update_opposite - return the opposite of one C72 coefficient update
> + *			  request
> + *
> + * @update:	original coefficient update
> + *
> + * Helper to transform the update request of one equalization tap into a
> + * request of the same tap in the opposite direction. May be used by C72
> + * phy remote TX link training algorithms.
> + */
> +static inline enum coef_update coef_update_opposite(enum coef_update update)

Hi Vladimir,

another nit from me.

Please put the inline keyword first.
Likewise elsewhere in this patch.

Tooling, including gcc-13 with W=1, complains about this.

> +{
> +	switch (update) {
> +	case COEF_UPD_INC:
> +		return COEF_UPD_DEC;
> +	case COEF_UPD_DEC:
> +		return COEF_UPD_INC;
> +	default:
> +		return COEF_UPD_HOLD;
> +	}
> +}

...

