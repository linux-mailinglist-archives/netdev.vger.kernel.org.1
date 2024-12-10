Return-Path: <netdev+bounces-150631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC539EB05D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A79D168F12
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81F1A0B0D;
	Tue, 10 Dec 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keaTljYd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D31A00F8;
	Tue, 10 Dec 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832265; cv=none; b=nva72U9+MWZzqEycSfuoQE5LkKovqXqO72xqEmqZtuXYPfMXUVQkRQFz6yUpwuuiSCwgCM9V45VKL7Fy9S8OYyoC/6IFhuhDCJ+7SyWXZmL4dboxpiErvBowDjq8gK1C6njkkuhcCaGc1MVSAYLay+aPyK87rb+ytbpMQtuH+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832265; c=relaxed/simple;
	bh=F2vLOZZmY8igUjUkHX7s++To+8YzE2ks8UcCli1UzT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf1mV5LzwRJN9SV/oOPX6D8EU6bvm2ai1OKDSUCtrlazBF5ANL95yeF7mULx8+UszO24bU2CpeaRt8cXdHtG7ZzPv/gAz/8nOyk7a1f7ghzeGkD/icI4DR32YDG9uXWMkTSyYc9JoMgae0eeJDHtau2g3+JtudhQk/fGKekbP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keaTljYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83B6C4CED6;
	Tue, 10 Dec 2024 12:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733832264;
	bh=F2vLOZZmY8igUjUkHX7s++To+8YzE2ks8UcCli1UzT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keaTljYdtvhbZr6tdyUiFN26lOk46uUerEryfn5Nj11vudpqTRjwbomkNiPqSNvWu
	 Nc7HYjwzicqThyyeAv1WQfYSkvYoOr2F/EtEmxQexz1jZH09DgnTmdat678kHyokJB
	 RvObUwSMDBaDfC69SOQ50a1RCGrWGVKB02b9yF/HRrxoM4oYDeXMQ5VeMZJeaUuLDt
	 efTCYuz1nPf2Zt/Nq9YGvyZO4ydMji3w5eLZcWQm1auuoPOyaOZV1PBNx+wtsjO97d
	 pagK7r4gje5v06dvugYIdbPROsw3eUxq/BcDFIIOVieufoHkdY+J1aYS68DZuNgWRE
	 DtL9CG6q6Gbtw==
Date: Tue, 10 Dec 2024 12:03:19 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20241210120319.GA4202@kernel.org>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203075622.2452169-2-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:56:15AM +0100, Oleksij Rempel wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Feed the existing IEEE PHY counter struct (which currently
> only has one entry) and link stats into the PHY driver.
> The MAC driver can override the value if it somehow has a better
> idea of PHY stats. Since the stats are "undefined" at input
> the drivers can't += the values, so we should be safe from
> double-counting.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/linux/phy.h     | 10 ++++++++++
>  net/ethtool/linkstate.c | 25 ++++++++++++++++++++++---
>  net/ethtool/stats.c     | 19 +++++++++++++++++++
>  3 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 563c46205685..523195c724b5 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1090,6 +1090,16 @@ struct phy_driver {
>  	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
>  
>  	/* Get statistics from the PHY using ethtool */
> +	/**
> +	 * @get_phy_stats: Get well known statistics.
> +	 * @get_link_stats: Get well known link statistics.
> +	 * The input structure is not zero-initialized and the implementation
> +	 * must only set statistics which are actually collected by the device.
> +	 */
> +	void (*get_phy_stats)(struct phy_device *dev,
> +			      struct ethtool_eth_phy_stats *eth_stats);

nit: There should be a kernel doc for @get_link_stats here.

     Flagged by ./scripts/kernel-doc -none

> +	void (*get_link_stats)(struct phy_device *dev,
> +			       struct ethtool_link_ext_stats *link_stats);
>  	/** @get_sset_count: Number of statistic counters */
>  	int (*get_sset_count)(struct phy_device *dev);
>  	/** @get_strings: Names of the statistic counters */

...

