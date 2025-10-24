Return-Path: <netdev+bounces-232307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EBC03FF2
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8623B7770
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4541BD9D3;
	Fri, 24 Oct 2025 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrKHmuPa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA671B85F8;
	Fri, 24 Oct 2025 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268215; cv=none; b=qUlHc0M4ww3c+tSwez8KaVwMTZXD6GDboAqKhl46W44ytWmAN9FW0/ziQuGUHxAQa1sb2muqiPk1nFpUcgypeZodfNj/hbHNoUtC7R7LO5xyGowV5MjCv2SaWi/Q/V9omRSDA31ZB0cGlVg+3G0zgn3r8Yry22xIT/n9SxizT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268215; c=relaxed/simple;
	bh=OLXoSnqBAFgBwoQMFtvAMOPLw94jaNvTQASIeLyNyII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEox005NoE9Nm3+x4Znm/nBy0mxit5DaXd1O+9m60qbU+Xt4gi6ncWp5Iam51wcpPZYiZ5Bz9AxNfC5dNCIktNui4FC+PXRJdb0FAAeyIrXdofdJ1r2NP2fUBrHurl42BbgXtUTzCgW1GlZeERTyakr8uCKFT1e6HvY952vW0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrKHmuPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DAEC113D0;
	Fri, 24 Oct 2025 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268214;
	bh=OLXoSnqBAFgBwoQMFtvAMOPLw94jaNvTQASIeLyNyII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WrKHmuPagZflA2cQbaM+uEDIZWz7+utTLmFSlMSAPNEEw+e+E1yQnm0YZ+3sskOqS
	 qEtXImiN9VvvlIjlo6qCtvWgut2rDBAnCNhkTPNb93e7uoiU0Vvyyz4aon7zGDm/d9
	 35g9lMWnqGFAW1mHhfkRQnVIYBEjU7KxUu5F405kPF3ShnXDxdmGqlL57HFnOPLSht
	 z3Doxp2nBxo9ElMu2bt2yFm4xMyuqsEV+WG8LAk5nDoE3464Ym6qR9jlfKMl7Nexze
	 bQtKShADtwAyzv5zY1mV3J59MgzusTVAH2ses4qh3Zl8oYa2eGPWDt+G/GeR1zKC1U
	 PjZ9K9aEWyIvg==
Date: Thu, 23 Oct 2025 18:10:12 -0700
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
Subject: Re: [PATCH net-next v7 3/5] ethtool: netlink: add lightweight MSE
 reporting to LINKSTATE_GET
Message-ID: <20251023181012.6bf107a6@kernel.org>
In-Reply-To: <20251020103147.2626645-4-o.rempel@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
	<20251020103147.2626645-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 12:31:45 +0200 Oleksij Rempel wrote:
> Extend ETHTOOL_MSG_LINKSTATE_GET to optionally return a simplified
> Mean Square Error (MSE) reading alongside existing link status fields.
> 
> The new attributes are:
>   - ETHTOOL_A_LINKSTATE_MSE_VALUE: current average MSE value
>   - ETHTOOL_A_LINKSTATE_MSE_MAX: scale limit for the reported value
>   - ETHTOOL_A_LINKSTATE_MSE_CHANNEL: source channel selector
> 
> This path reuses the PHY MSE core API (struct phy_mse_capability and
> struct phy_mse_snapshot), but only retrieves a single value intended for
> quick link-health checks:
>   * If the PHY supports a WORST channel selector, report its current
>     average MSE.
>   * Otherwise, if LINK-wide measurements are supported, report those.
>   * If neither is available, omit the attributes.
> 
> Unlike the full MSE_GET interface, LINKSTATE_GET does not expose
> per-channel or peak/worst-peak values and incurs minimal overhead.
> Drivers that implement get_mse_capability() / get_mse_snapshot() will
> automatically populate this data.
> 
> The intent is to provide tooling with a "fast path" health indicator
> without issuing a separate MSE_GET request, though the long-term overlap
> with the full interface may need reevaluation.

I don't think this justification is sufficient, we don't normally
duplicate information in uAPI to make user space have to issue
fewer calls. ethtool $link already issues a number of calls to
the kernel.

