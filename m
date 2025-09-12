Return-Path: <netdev+bounces-222388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD8B54062
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2ED1C871AD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BF91865FA;
	Fri, 12 Sep 2025 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLD5W5Fm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED194E555;
	Fri, 12 Sep 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644483; cv=none; b=hZbc4wywf/6YhKdPXs5LXKY6l65NtvrmV1UXDEy6uV9B3CF24ImS7AJ3lCz90zX/W5yCcoEiXQm/1cit6uQaiZO3ISC2VIiFMDaZndNlBrK5WtqgzJwvjsWuX/6fgXqG8IPjBSO0q353eaZwWCtLcCAda/rQCzSE9g1FGQNk/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644483; c=relaxed/simple;
	bh=SwPQNn5pPNWxmJTZxjxdWn5osFkcEVxEdmvE11iK9Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEwe5EdILiatCOJg7ihVXRpNKB3UNv7tsNYVHNDwLCUk6hHO7B8ryCaoUU/743mVmRQ/qOZOTKS5G3/V+y1Kf1yPHlm3tTCF8eZrpHbV4vfWq8yb2M7GVCrvH3szgrTp9/7NIC7QWGLUcKWbT9Es1rF4OH5cRbuKRvZoUuon18s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLD5W5Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A954EC4CEF0;
	Fri, 12 Sep 2025 02:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644482;
	bh=SwPQNn5pPNWxmJTZxjxdWn5osFkcEVxEdmvE11iK9Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JLD5W5FmJe2oTeOwZVwNNu8IssffS8Y/ZonRTku80JiMh/bTIm85ulNdHoPD0j9dm
	 l43OedQc9YNONXHc6Fw7pIuGc67etpd3FgYcuF/wH0PUq7IVFIdHY6Ojd/tKZmW7Dy
	 xUEEpQnEKo+s+/9wtQpj7nB4OZVUzxhnA++m3L6VZYrTNqlYTUbqTfbA7V3H33+pw0
	 W0TpwgI7EFha0lwXcYcSFb9UirLrAPwuaWijj9lNTTWER5bJ6+QMp2L83vf8Woi9/T
	 BAAObKXsDtt5UxgAX1dhpOaeap+J4Z6T4vCisE4bgSxbAzw1nbPtXo+b9rJHX03gmI
	 +kIhF+vqjBHyw==
Date: Thu, 11 Sep 2025 19:34:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20250911193440.1db7c6b4@kernel.org>
In-Reply-To: <20250908124610.2937939-3-o.rempel@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
	<20250908124610.2937939-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 14:46:07 +0200 Oleksij Rempel wrote:
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 969477f50d84..d69dd3fb534b 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1899,6 +1899,79 @@ attribute-sets:
>          type: uint
>          enum: pse-event
>          doc: List of events reported by the PSE controller
> +  -
> +    name: mse-config
> +    attr-cnt-name: --ethtool-a-mse-config-cnt
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

Are you actually using this somewhere?
It's good to not use attr ID 0 in case we encounter an uninitialized
attr, but there's no need to define a name for it, usually.
Just skip the entry 0 if you don't need then name.

> +      -
> +        name: max-average-mse
> +        type: u32
> +      -
> +        name: max-peak-mse
> +        type: u32
> +      -
> +        name: refresh-rate-ps
> +        type: u64
> +      -
> +        name: num-symbols
> +        type: u64

type: uint for all these?

> +      -
> +        name: supported-caps
> +        type: nest
> +        nested-attributes: bitset
> +      -
> +        name: pad
> +        type: pad

you shouldn't need it if you use uint

> +  -
> +    name: mse-snapshot
> +    attr-cnt-name: --ethtool-a-mse-snapshot-cnt
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: channel
> +        type: u32
> +        enum: phy-mse-channel
> +      -
> +        name: average-mse
> +        type: u32
> +      -
> +        name: peak-mse
> +        type: u32
> +      -
> +        name: worst-peak-mse
> +        type: u32
> +  -
> +    name: mse
> +    attr-cnt-name: --ethtool-a-mse-cnt
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: channel
> +        type: u32

Please annotate attrs which carry enums and flags with

	enum: $name

> +        enum: phy-mse-channel
> +      -
> +        name: config
> +        type: nest
> +        nested-attributes: mse-config

config sounds like something we'd be able to change
Looks like this is more of a capability struct?

> +      -
> +        name: snapshot
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: mse-snapshot

This multi-attr feels un-netlinky to me.
You define an enum for IDs which are then carried inside
snapshot.channel. In netlink IDs should be used as attribute types.
Why not add an entry here for all snapshot types?

