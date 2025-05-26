Return-Path: <netdev+bounces-193506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D26AC4429
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70F5189A8CB
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C123F42D;
	Mon, 26 May 2025 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4tEXRGQf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC023ED75;
	Mon, 26 May 2025 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289361; cv=none; b=XRdF/x6CZQcVRPf+r/xXR497IT17scwj18jcMDqzWGqdQyEtt2QfYoExTGdP5Z+P+SHVo/ZHjOveJpuWfxN4+cBwm63Kl1Qko02uXl49ReXAldIREtoj3OeyIJSXHOb+BrP84E26CsLSJ6P996uervzQOaI26sObJeERQlQZsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289361; c=relaxed/simple;
	bh=U8tGrcORNhsrVTb5sJb22d4+YfDP9oQ0T4Y+3poIiVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=donXKkwpSDzd+mZvebR9CUNPo5bNz13OqPG83FBoTnjgm0I0lm+P+vh7MdPgvLDWrfBtuYVCWjxQPVoxqJSq3y9nutWakZk5UYrCRBMgmVn/KnJUtUkgdwD8g0QjNTFshB/QaPchXHKkmMGiOIPKuHomIWHYft3iPN4R7F9Zbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4tEXRGQf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4+r/nHRyZltKy41tZTedOu70Px/F9mZ4F2bNtsI59OU=; b=4tEXRGQfPFBKpQqSc4z3gLgkOI
	2o4h5Mvi6Sh0ZTFi1D2+yNvmyXjWCGYdmEHfGYz0Cg28GnJ2XGysRQrywM1DpEhKGquRqpftFPcNI
	8DjUFHygH594V/sfYAptUWciuDPafHD5BXrYWXj9wRwcblq7YpMgBF+7bvyXY3SQXb9Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJdvL-00E1V8-N2; Mon, 26 May 2025 21:55:51 +0200
Date: Mon, 26 May 2025 21:55:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Paul Kocialkowski <paulk@sys-base.io>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] net: stmmac: dwmac-sun8i: Allow runtime
 AC200/AC300 phy selection
Message-ID: <a2ac65eb-e240-48f1-b787-c57b5f3ce135@lunn.ch>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-2-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526182939.2593553-2-james.hilliard1@gmail.com>

On Mon, May 26, 2025 at 12:29:35PM -0600, James Hilliard wrote:
> The Allwinner H616 ships with two different on-die phy variants, in
> order to determine the phy being used we need to read an efuse and
> then select the appropriate PHY based on the AC300 bit.
> 
> By defining an emac node without a phy-handle we can override the
> default PHY selection logic in stmmac by passing a specific phy_node
> selected based on the ac200 and ac300 names in a phys list.

The normal way to do this is phy_find_first().

    Andrew

