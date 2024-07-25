Return-Path: <netdev+bounces-113041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3693C769
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68C21C21EC8
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7011990DE;
	Thu, 25 Jul 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWmjPj1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44CE11711;
	Thu, 25 Jul 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926219; cv=none; b=OxA7s8LgVWhcJ5w0ZPleKmZck4JWud7l8PCftf1WV+GyuMcsLHHlKOJ2+24rLNrETERz69/ojKmK0fCUJc2JlLgMe72wl2audEK2xt6Hr1cL47C+tVeJTaLdU7i3vlZdY7wC0Udy70eBLOtLTBnP8a3GOYr0LO0ga8FOY/lQOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926219; c=relaxed/simple;
	bh=2ha36h8m+D322Fa0m27vV6yqapptIuzDjOd6G6ZUwAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFYatjOsgGCMxFJS3piMe4jzlxaOVka+nuMUKrU3Yh9D6oLUEOCoE4DYmeo0pGPBS520Wk7I5j56t8XuOoUmBoSbkUSIDA22fJmxsXrMhUH4vOUVjOR2/csIKatqefFeBnPwtGVA5F5Nayww74vF5aGj+h9F0zZAKh8qYD2TodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWmjPj1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86576C116B1;
	Thu, 25 Jul 2024 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721926219;
	bh=2ha36h8m+D322Fa0m27vV6yqapptIuzDjOd6G6ZUwAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWmjPj1bU56coZ6f4THwe7R1JmS/QB61d/mbLZt3vTYfWyzu+1dbXABMlQlmzgb2g
	 F1b87mEVBXsXpsvvd4LAO0ibiLPcePD2ToSk0PIAi7B6tOpEdGAv0tP2bcXvzKfq8f
	 vsY203RSVUaEu8As/m91+wwnborOrDMH12ya7UiuQJyI4YGIfZaNVVQXpn2tP5UMDT
	 zfgAekVw2kzo2QbRIHhIucdumOK5dPax+KgEg3P55T7nxhhv1DRYfokEfDAONonmrs
	 PCY2c9fsWL9QrwCSm82EMhZabAbzd64XdMmFXN8MNL42+fpCsgBO5eJZGVsH46XB5b
	 WPAaMlV6Moi0A==
Date: Thu, 25 Jul 2024 17:50:12 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Sam Shih <Sam.Shih@mediatek.com>,
	Weijie Gao <Weijie.Gao@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: pcs: add helper module for standalone
 drivers
Message-ID: <20240725165012.GL97837@kernel.org>
References: <ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org>

On Thu, Jul 25, 2024 at 01:44:49PM +0100, Daniel Golle wrote:
> Implement helper module for standalone PCS drivers which allows
> standaline PCS drivers to register and users to get instances of
> 'struct phylink_pcs' using device tree nodes.
> 
> At this point only a single instance for each device tree node is
> supported, once we got devices providing more than one PCS we can
> extend it and introduce an xlate function as well as '#pcs-cells',
> similar to how this is done by the PHY framework.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> This is meant to provide the infrastructure suggested by
> Russell King in an earlier review. It just took me a long while to
> find the time to implement this.
> Users are going to be the standalone PCS drivers for 8/10 LynxI as
> well as 64/66 USXGMII PCS found on MediaTek MT7988 SoC.
> See also https://patchwork.kernel.org/comment/25636726/
> 
> The full tree where this is being used can be found at
> 
> https://github.com/dangowrt/linux/commits/mt7988-for-next/

Hi Daniel,

I realise this is an RFC, but I'm guessing a user will need to be submitted
for this to progress into net-next.

...

> +++ b/drivers/net/pcs/pcs-standalone.c

...

> +static struct pcs_standalone *of_pcs_locate(const struct device_node *_np, u32 index)

nit: This could trivially be line wrapped to 80 columns wide

> +{
> +	struct device_node *np;
> +	struct pcs_standalone *iter, *pcssa = NULL;

nit: Reverse xmas tree

...

> +struct phylink_pcs *devm_of_pcs_get(struct device *dev,
> +				    const struct device_node *np,
> +				    unsigned int index)
> +{
> +	struct pcs_standalone *pcssa;
> +
> +	pcssa = of_pcs_locate(np ?: dev->of_node, index);
> +	if (IS_ERR_OR_NULL(pcssa))
> +		return ERR_PTR(PTR_ERR(pcssa));

nit: Perhaps ERR_CAST() ?

> +
> +	device_link_add(dev, pcssa->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
> +	return pcssa->pcs;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_pcs_get);
> +
> +MODULE_DESCRIPTION("Helper for standalone PCS drivers");
> +MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/pcs/pcs-standalone.h b/include/linux/pcs/pcs-standalone.h

Please consider adding this file to MAINTAINERS.

...

> +static inline int devm_pcs_register(struct device *dev, struct phylink_pcs *pcs);
> +	return -EOPNOTSUPP;
> +}

The above does not compile.

...

