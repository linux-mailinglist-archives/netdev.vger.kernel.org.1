Return-Path: <netdev+bounces-250439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655BD2B379
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39158301515F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79E34321C;
	Fri, 16 Jan 2026 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pofHY7nk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9D20C00C;
	Fri, 16 Jan 2026 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536720; cv=none; b=JtSnhhlWpfMmuqU3VXIt1SiFxvRNdr3nG5QnqBxHpgEghBEmlVb0QvFb/+Vky1Ma6LW/Lg8jXBB58i+XtBl0P2A7BhKZUBH4HZzYYI6NYi0lBBejlV3ZueLt+nPJ9njCrCjBdvV46mY6wyOiEwGSzOqvncubu7gN9rEXL2lYCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536720; c=relaxed/simple;
	bh=4uoGgoog5Fby7u6C0Dxo43qgoE40DFXVo7FCNNGrnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OherzVIgrHtg+PaEEIikmUI2vbr5zV1jAq6JsdUnct1Ss6UR4omzU5iK1IBA4KYomVAIuPHY6ExAU7eD650H7lGHTJDkSrxaMfpyj0B+k25CLhNaue2xyi6T9gr9SuB/+QMmoDMD8zjilhZA19P3YPHKfyRpH12+niNdD0SmFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pofHY7nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5566AC116C6;
	Fri, 16 Jan 2026 04:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536720;
	bh=4uoGgoog5Fby7u6C0Dxo43qgoE40DFXVo7FCNNGrnfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pofHY7nkpiKhAxQyLOLbPsRy8q/x5Q/3s4n/wEkvNw0YzWKn8tw91Nl7uszQ3mN4R
	 k2af9HzewRX7zlJGADX7lewi1sxDwR2sJvcO6V2gbWRDEnpu2+F1yhW9zGSmjabsHT
	 laMMS8KVeWATcL2n55obXgFbbrSQmlqLlMbsgmAy1EQopNMfjX6TPXzU9ZNoJ+fpl2
	 5JKOlnQXI3XrLyLR1fa4cvXYy+7lYnkaU3qtdtgC+Oy7ylKTTQy/B4l/83h47iT71o
	 YGPUza2uy325wf3IlpZzXqsZaQvOe9cFyJIj121e8LQJq8wPQS5gPbnbvAOpVTCLHt
	 tic45C3RQ0WlA==
Date: Thu, 15 Jan 2026 20:11:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.simek@amd.com>, <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <bmasney@redhat.com>
Subject: Re: [PATCH V2 1/2] clk: Add devm_clk_bulk_get_optional_enable()
 helper
Message-ID: <20260115201158.3371bf40@kernel.org>
In-Reply-To: <20260113181002.200544-2-suraj.gupta2@amd.com>
References: <20260113181002.200544-1-suraj.gupta2@amd.com>
	<20260113181002.200544-2-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 23:40:01 +0530 Suraj Gupta wrote:
> +/**
> + * devm_clk_bulk_get_optional_enable - Get and enable optional bulk clocks (managed)
> + * @dev: device for clock "consumer"
> + * @num_clks: the number of clk_bulk_data
> + * @clks: pointer to the clk_bulk_data table of consumer
> + *
> + * Behaves the same as devm_clk_bulk_get_optional() but also prepares and enables
> + * the clocks in one operation with management. The clks will automatically be
> + * disabled, unprepared and freed when the device is unbound.
> + *
> + * Returns 0 if all clocks specified in clk_bulk_data table are obtained
> + * and enabled successfully, or for any clk there was no clk provider available.
> + * Otherwise returns valid IS_ERR() condition containing errno.
> + */
> +int __must_check devm_clk_bulk_get_optional_enable(struct device *dev, int num_clks,
> +						   struct clk_bulk_data *clks);

s/Returns 0/Return: /
the colon is required by kdoc
-- 
pw-bot: cr

