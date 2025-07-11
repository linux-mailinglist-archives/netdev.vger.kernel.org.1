Return-Path: <netdev+bounces-206169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A273B01D58
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9AA7A3A98
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9492D3226;
	Fri, 11 Jul 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2LbzWxKs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2A70810;
	Fri, 11 Jul 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240314; cv=none; b=nebqYf6ndEYXu3mn6VFOzCopJZ04CYHAfkD6Hy7vPVHUnCte+SAon/Lo9rEiB2Co4WJsEM7YZS+BPHuayQ63Pbut6WrjDLBkupFTRcjyq8OIkmxeeeglrlJvtXsHelKX52dF3ejc5CX/bN31c5XNVolh7iT9cXJEeQPNqq3EKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240314; c=relaxed/simple;
	bh=TMxwU5OcMEsujj9nJKYk/hnws8kYEpNzWgcnKJGW4ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojpxHOas0UqhSSAx+qgRwKKMSrxHexN/39dc5zf0G0XanlJnCMHRN674lU/4ldZ/I8o1N/RsPEycohHSXPUq2T4PtURW93PXSB+bIxYoDqLQyCFab60iwKDWYEDfxJzsdO4wvUOUoD38JNcB7BQbG7fuQzBd4/s0DEmUhfIH5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2LbzWxKs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HEwG9GJocIwY3rI8chyAhvZTbw2XLe9/YmKGzWNW0BQ=; b=2LbzWxKsOnQ+Li0cEyuTq2/c3C
	5INP3q8iu6RLkkH9R+mcGB76yUtnDFZDeOcHjuOvsY+nTU90xFyEzoHzN/tokDXif9pkyGUr2Kk9Y
	tFQ5Hnr6RiGxAwAXr+AYupCJ5+Da4xpdCVF3uDeDMdhzrHR0zpdNoMLtCzz0ybOFmtCQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uaDkN-001EdQ-5C; Fri, 11 Jul 2025 15:25:03 +0200
Date: Fri, 11 Jul 2025 15:25:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Message-ID: <9f65fac0-e706-4a00-bac7-20c3ee727f69@lunn.ch>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065748.250159-3-wei.fang@nxp.com>

> +	of_property_read_string(np, "clock-names", &clk_name);
> +	if (clk_name) {
> +		priv->src_clk = devm_clk_get_optional(dev, clk_name);
> +		if (IS_ERR_OR_NULL(priv->src_clk)) {
> +			dev_warn(dev, "Failed to get source clock\n");
> +			priv->src_clk = NULL;
> +			goto select_system_clk;
> +		}
> +
> +		priv->clk_freq = clk_get_rate(priv->src_clk);
> +		if (!strcmp(clk_name, "system")) {
> +			/* There is a 1/2 divider */
> +			priv->clk_freq /= 2;
> +			priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +		} else if (!strcmp(clk_name, "ccm_timer")) {
> +			priv->clk_select = NETC_TMR_CCM_TIMER1;
> +		} else if (!strcmp(clk_name, "ext_1588")) {
> +			priv->clk_select = NETC_TMR_EXT_OSC;
> +		} else {
> +			dev_warn(dev, "Unknown clock source\n");
> +			priv->src_clk = NULL;
> +			goto select_system_clk;
> +		}

That is pretty unusual. Generally, a clock is a clock, and you only
use the name to pick out a specific clock when there are multiple
listed.

Please expand the binding documentation to include a description of
how the clock name is used here.

I don't generally get involved with clock trees, but i'm wondering if
the tree is correctly described. Maybe you need to add a clk-divider.c
into the tree to represent the system clock being divided by two?

	Andrew

