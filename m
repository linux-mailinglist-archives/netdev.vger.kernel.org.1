Return-Path: <netdev+bounces-211786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDCB1BB93
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA536203E5
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EEC23BF9B;
	Tue,  5 Aug 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4I88P4ko"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FB12E7F;
	Tue,  5 Aug 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427568; cv=none; b=OwWbz4sEu4qDhejBLoGI5UdubmimhHqEJblSMdlJMDDIDKs9hAizTT/Z0IAbb6S+LaiD7Cm4RccL1gA7eoXu8awhq2QrtWUD3XTsTLduB5VAY3+dab6tkP+pvkYWGFFbwDkn4y/gb8pn8DHX9Pz0WqYgdoErvu7WOJShwfECL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427568; c=relaxed/simple;
	bh=t7+tqrc2CSh6joUTYTSPNLhj41E9+PZPzVTdBsnSpsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgWjuubVaZky3VQ2g+TxRRG41FX4gQECNxskntnCk9nC8SbJUlVrvoQN7YAh37iXWCrdv6GMDfVmqrAtp6Kp5GiXdYRt8SAtp6VjhC5Jsb1jlpyofUNcBjsMpAidWN3gA81gaWsbKkLCBFZ/+ks9DxNPN8ad04tcT4SropvzbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4I88P4ko; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NWDHZJrVWOBu48yVTIxq5bN4KAAfsVdHWzf5NjnxC7c=; b=4I88P4kotaghdXCFOSfBkDGC4o
	sFk7rBF3W7vefj3i0SNWceKobbrdFPCKJTu/qjhMpVIKEay54XbYVhw36DjvMzcbQXud9S/1azxVe
	DKiXLr4lfR3hUd95y8E2leibqEeB+DIWUzcOBwhsW++6DVWlfhakmsiW/XhrQgM65Tsw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujOkZ-003pEJ-6T; Tue, 05 Aug 2025 22:59:11 +0200
Date: Tue, 5 Aug 2025 22:59:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Suraj Gupta <suraj.gupta2@amd.com>
Subject: Re: [PATCH net-next v4 1/7] net: axienet: Fix resource release
 ordering
Message-ID: <9572f798-d294-4f24-8acb-c7972c1db247@lunn.ch>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-2-sean.anderson@linux.dev>

> +static void axienet_disable_misc(void *clocks)
> +{
> +	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks);
> +}
> +

...

>  	ret = devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCKS, lp->misc_clks);
>  	if (ret)
> -		goto cleanup_clk;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not get misc. clocks\n");
>  
>  	ret = clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
>  	if (ret)
> -		goto cleanup_clk;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not enable misc. clocks\n");
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, axienet_disable_misc,
> +				       lp->misc_clks);

It seems like it would be better to add
devm_clk_bulk_get_optional_enable(). There is already an
devm_clk_bulk_get_all_enabled() so it does not seem like too big a
step.

	Andrew

