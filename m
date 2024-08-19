Return-Path: <netdev+bounces-119904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72095771F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE9B285A72
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1A189912;
	Mon, 19 Aug 2024 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jC8em0ss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4F14D70E;
	Mon, 19 Aug 2024 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105228; cv=none; b=Drtlg99jUhc2r5jYQjmQkfq5MTwhmLAh1KYOVD3296cy4/0I3VkqCl9oZfcYgdlWoJqHfyR/h+nO5dojy0WGSBILMBeRl3AEVs0sroRdOiWEchkJCi3/03mnTiR5wQ0ImviFD64BP3jGl0BcnCkPINlN4IcmZYx/zKC+HS2irfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105228; c=relaxed/simple;
	bh=XrkBY75V13GbM24tskzyLi2gFXCxHOpvM1sre5vZJBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLWcA3w+uk2A01XuwKrpAHmeJJ8NzlZYIXZ9SRIQgtfFK3aQ3TX4rH7QtfmbC0eRMY2JwrJ0fcwLi/1Y1Anb86HJbJ2sN+rvH+1H49aE6N4/sW+uCjKGDH/sMq2ip5n/mtEbWs1qgDf4GC1S/QS6nIVVlLhKs8l3j3z7Pl+5jOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jC8em0ss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uZczDJCmCCm41DMXVQTJRndcBOAdnPJvp8hRXnZ3XcE=; b=jC8em0ssHCR+duLHyI03Yn3ERk
	4O5DrdD2Y4//EokTq0ok2xQ98jCOIcho1cn7NQMbLjJNpPiUBat9YsiJAJluXs5UkCbRy2x6CwYNP
	yd1KbMke2XcVgUnObKzRCG0jpmif817kXEgqqwdImIBLBs7/RvDMkKU0LDSB0tTy1rss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgAWe-0059pi-KV; Tue, 20 Aug 2024 00:06:56 +0200
Date: Tue, 20 Aug 2024 00:06:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 1/3] ethtool: Extend cable testing interface
 with result source information
Message-ID: <a4d44aa6-e679-4ce0-8d9b-33a40f85e322@lunn.ch>
References: <20240819141241.2711601-1-o.rempel@pengutronix.de>
 <20240819141241.2711601-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819141241.2711601-2-o.rempel@pengutronix.de>

> +/* Information source for specific results. */
> +enum {
> +	/* Results provided by the Time Domain Reflectometry (TDR) */
> +	ETHTOOL_A_CABLE_INF_SRC_TDR,
> +	/* Results provided by the Active Link Cable Diagnostic (ALCD) */
> +	ETHTOOL_A_CABLE_INF_SRC_ALCD,
> +};

It is pretty typical for such enums to have a _UNSPEC for the first
entry.

	Andrew

