Return-Path: <netdev+bounces-36825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C857B1E94
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A6D63281E92
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658553B79E;
	Thu, 28 Sep 2023 13:36:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511363AC3D;
	Thu, 28 Sep 2023 13:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29908C433C9;
	Thu, 28 Sep 2023 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695908199;
	bh=buWFvyKvzLE7yL9fD5WstGeTidrhh5FjGgosGmcwWnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRZGCX4uM6nkWatFx7vCXHkNlUNWjWo3yiUsyXT5+Lkn/x8HZJejO0I56+C12vAKX
	 mJorU9/7Rn6Ix0Ka5F16XmmPqoZp9ssId88f4t8jGBd5LG3pi3bYUgRYoyrjq/dSho
	 uY2qKIzOuhL41R7wpANqI/+vSXk08AD6BuvSdqIKwzx773+Z4U6NnerejQug+Kw1lB
	 xByiAv/JNY1zsOIEfRX7SVieCdeeCAn5w8+m5gTLdMzUCJT55WBUK+tOSakelTU7FJ
	 hgJuQcyIknhUrLOVHIfPUJ1dER7tKcRDGcTRvSbJiQ8GoVB5/Bm2tgTPp5vxcQ1ghX
	 AMYeIKxgZBZ3A==
Date: Thu, 28 Sep 2023 15:36:29 +0200
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
Message-ID: <20230928133629.GM24230@kernel.org>
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
> In Layerscape and QorIQ SoCs, compliance with the backplane Ethernet
> protocol is bolted on top of the SerDes lanes using an external IP core,
> that is modeled as an Ethernet PHY. This means that dynamic tuning of
> the electrical equalization parameters of the link needs to be
> communicated with the consumer of the generic PHY.
> 
> Create a small layer of glue API between a networking PHY (dealing with
> the AN/LT logic for backplanes) and a generic PHY by extending the
> phy_configure() API with a new struct phy_configure_opts_ethernet.
> 
> There are 2 directions of interest. In the "local TX training", the
> generic PHY consumer gets requests over the wire from the link partner
> regarding changes we should make to our TX equalization. In the "remote
> TX training" direction, the generic PHY is the producer of requests,
> based on its RX status, and the generic PHY consumer polls for these
> requests until we are happy. Each request is also sent (externally to
> the generic PHY layer) to the link partner board, for it to adjust its
> TX equalization.
> 
> struct phy_configure_opts_ethernet is valid when phy_set_mode_ext() has
> been called with PHY_MODE_ETHERNET or PHY_MODE_ETHTOOL, same as with
> other union phy_configure_opts types.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

...

> +/**
> + * struct phy_configure_opts_ethernet - Ethernet PHY configuration set

nit: please include documentation of the structure members - type,
local_tx, and remote_tx - here.

> + *
> + * This structure is used to represent the configuration state of an Ethernet
> + * PHY (of various media types).
> + */
> +struct phy_configure_opts_ethernet {
> +	enum ethernet_phy_configure_type type;
> +	union {
> +		struct c72_phy_configure_local_tx local_tx;
> +		struct c72_phy_configure_remote_tx remote_tx;
> +	};
> +};

...

