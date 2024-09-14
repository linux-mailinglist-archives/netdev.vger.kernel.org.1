Return-Path: <netdev+bounces-128309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C4978F38
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5891C218DA
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A218126F0A;
	Sat, 14 Sep 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OClk+0lw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F115D1;
	Sat, 14 Sep 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726303643; cv=none; b=aJ9HZ3keD2riMj8IqUj7hapMPiwJ9p5rz0ZbULh4Ii0u9OKyMpC/oU8ukV9k2GXYGxmsDGD6KVEptdsnu3lE6n3YySzdQPh+qhKxYu27jKedg3uS6aWv5c3h7UZ6ERNd7Uhty465J7xCGY8jqdRdBehnPlSxwV+sq5BPsjp1HwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726303643; c=relaxed/simple;
	bh=pM41I7GYBIObPxP8lAyins5PGX0tZr2so12UfRynbeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUf1piI1xuba9+wdlyCDOI01lqzS5xDp7WFKb0WGJaLgSjXmztpXlh9XfrObB5+JhkhcjwaoQFvMRawS2YSNZ2p6XcLKHdyNzBHojnSotSIoOVWI/mD3aCLk9zKOS362SGWa+02r6C/C/4EbTaDGexUihNMAShQ9LJlhrL+lMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OClk+0lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F77C4CEC0;
	Sat, 14 Sep 2024 08:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726303642;
	bh=pM41I7GYBIObPxP8lAyins5PGX0tZr2so12UfRynbeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OClk+0lwA1O69g/rFyxVhltTq+6B3LXvUJNjmHumahB3oOsCqv1BmMeY5Jgyyl0r2
	 3rCe5lxY8XeKlY1JsmlwQQI2WmMCBgSBNL5iMbWGjclKuNuQcIdlip6DHGPU4a5NFU
	 oM8pCHFscG6MQcSv95o/nf66CussD6XGiQ6ezwVCVGykBGclVv4ONIb8oXJsKbGPB5
	 471n750TU3lF6R3zqDdemtsMzeUpDisqkjujkKRhsfZ7LzJwbEZKu1F8BUnxjyJh9v
	 FSBcIDcJRt4yunC+foYozqULtUUwj7bFxA5pXt9xr+jCrRqpYxFi69bEfYNPC3Slhi
	 HXtNSb5gsbKDA==
Date: Sat, 14 Sep 2024 09:47:17 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: sja1105: implement management
 routes for cascaded switches
Message-ID: <20240914084717.GA12935@kernel.org>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
 <20240913131507.2760966-5-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913131507.2760966-5-vladimir.oltean@nxp.com>

On Fri, Sep 13, 2024 at 04:15:07PM +0300, Vladimir Oltean wrote:
> The SJA1105 management route concept was previously explained in commits
> 227d07a07ef1 ("net: dsa: sja1105: Add support for traffic through
> standalone ports") and 0a51826c6e05 ("net: dsa: sja1105: Always send
> through management routes in slot 0").
> 
> In a daisy chained topology with at least 2 switches, sending link-local
> frames belonging to the downstream switch should program 2 management
> routes: one on the upstream switch and one on the leaf switch. In the
> general case, each switch along the TX path of the packet, starting from
> the CPU, need a one-shot management route installed over SPI.
> 
> The driver currently does not handle this, but instead limits link-local
> traffic support to a single switch, due to 2 major blockers:
> 
> 1. There was no way up until now to calculate the path (the management
>    route itself) between the CPU and a leaf user port. Sure, we can start
>    with dp->cpu_dp and use dsa_routing_port() to figure out the cascade
>    port that targets the next switch. But we cannot make the jump from
>    one switch to the next. The dst->rtable is fundamentally flawed by
>    construction. It contains not only directly-connected link_dp entries,
>    but links to _all_ other cascade ports in the tree. For trees with 3
>    or more switches, this means that we don't know, by following
>    dst->rtable, if the link_dp that we pick is really one hop away, or
>    more than one hop away. So we might skip programming some switches
>    along the packet's path.
> 
> 2. The current priv->mgmt_lock does not serialize enough code to work in
>    a cross-chip scenario. When sending a packet across a tree, we want
>    to block updates to the management route tables for all switches
>    along that path, not just for the leaf port (because link-local
>    traffic might be transmitted concurrently towards other ports).
>    Keeping this lock where it is (in struct sja1105_private, which is
>    per switch) will not work, because sja1105_port_deferred_xmit() would
>    have to acquire and then release N locks, and that's simply
>    impossible to do without risking AB/BA deadlocks.
> 
> To solve 1, recent changes have introduced struct dsa_port :: link_dp in
> the DSA core, to make the hop-by-hop traversal of the DSA tree possible.
> Using that information, we statically compute management routes for each
> user port at switch setup time.
> 
> To solve 2, we go for the much more complex scheme of allocating a
> tree-wide structure for managing the management routes, which holds a
> single lock.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/sja1105/sja1105.h      |  43 ++++-
>  drivers/net/dsa/sja1105/sja1105_main.c | 253 ++++++++++++++++++++++---
>  2 files changed, 263 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
> index 8c66d3bf61f0..7753b4d62bc6 100644
> --- a/drivers/net/dsa/sja1105/sja1105.h
> +++ b/drivers/net/dsa/sja1105/sja1105.h
> @@ -245,6 +245,43 @@ struct sja1105_flow_block {
>  	int num_virtual_links;
>  };
>  
> +/**
> + * sja1105_mgmt_route_port: Representation of one port in a management route

Hi Vladimir,

As this series has been deferred, a minor nit from my side.

Tooling seems to want the keyword struct at the beginning of the
short description. So I suggest something like this:

 * struct sja1105_mgmt_route_port: One port in a management route

Likewise for the two Kernel docs for structures below.

Flagged by ./scripts/kernel-doc -none

> + * @dp: DSA user or cascade port
> + * @list: List node element for the mgmt_route->ports list membership
> + */
> +struct sja1105_mgmt_route_port {
> +	struct dsa_port *dp;
> +	struct list_head list;
> +};
> +
> +/**
> + * sja1105_mgmt_route: Structure to represent a SJA1105 management route
> + * @ports: List of ports on which the management route needs to be installed,
> + *	   starting with the downstream-facing cascade port of the switch which
> + *	   has the CPU connection, and ending with the user port of the leaf
> + *	   switch.
> + * @list: List node element for the mgmt_tree->routes list membership.
> + */
> +struct sja1105_mgmt_route {
> +	struct list_head ports;
> +	struct list_head list;
> +};
> +
> +/**
> + * sja1105_mgmt_tree: DSA switch tree-level structure for management routes
> + * @lock: Serializes transmission of management frames across the tree, so that
> + *	  the switches don't confuse them with one another.
> + * @routes: List of sja1105_mgmt_route structures, one for each user port in
> + *	    the tree.
> + * @refcount: Reference count.
> + */
> +struct sja1105_mgmt_tree {
> +	struct mutex lock;
> +	struct list_head routes;
> +	refcount_t refcount;
> +};
> +
>  struct sja1105_private {
>  	struct sja1105_static_config static_config;
>  	int rgmii_rx_delay_ps[SJA1105_MAX_NUM_PORTS];

...

