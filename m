Return-Path: <netdev+bounces-211794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13CB1BBD5
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BAD16B5AF
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A92561B6;
	Tue,  5 Aug 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eXFzQppg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846722D4C0;
	Tue,  5 Aug 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430066; cv=none; b=MbFQF4Nes3NTn42HJaiYKu//NZKeh4cTF7sjY55hzxw1cCWzjOMnMIL/PQ3aoAlPFLmbHMq1nSccL0Z8Uy7ZB2RuRtESVJjZIa56FJeZ887Blh/E6/6iJ1F555P9AW6GVqjwawm1MphMIQ3NNfzIfb1tmOaFTseMLnTBg0nCE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430066; c=relaxed/simple;
	bh=8dUpQn9CcS3sXe/4L+ubz1sM5F88oFVde65by5GHwaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esAIdF+wXFUEJQ0LBcZMRI9wMYRu6Dna1nerUnSbYKWvgmOX/iv3IyaVxH2vM0Owf/capXxlUgf85FyBYnKKHVgcM5Bb/BvFDsWalH7EcsXEufLIbWdMjYwQSQh1O2ynfyWODSmHJOLoSlBpasbPtz8acRZjcYhsE717dXbRV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eXFzQppg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/T32B0iDAc73yD8QSjnheCBq97UTHskJn2BHI0l6/+A=; b=eXFzQppguDZBk4N1x1nydTBhMH
	4k9rwb2TiweuCZcxlpYtGI6DEj2Tw/lyKgp3Wi7rrb83QJ9iPS+U+bhWb/8x7LK1M3p1KnxwCOnDL
	YVoF2hVg8//OrxT6UTIN2sNpQ9i68CW9KZ5Pv5f2Fpw/eOarCGp8snbFj1855WW5trIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujPOz-003pTN-UN; Tue, 05 Aug 2025 23:40:57 +0200
Date: Tue, 5 Aug 2025 23:40:57 +0200
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
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 7/7] net: axienet: Split into MAC and MDIO
 drivers
Message-ID: <c320da3b-6e55-474a-93d6-666092b70774@lunn.ch>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-8-sean.anderson@linux.dev>

> Fixes: 1a02556086fc ("net: axienet: Properly handle PCS/PMA PHY for 1000BaseX mode")

If this is for net-next, please don't have a Fixes: tag.

>  struct axienet_common {
>  	struct platform_device *pdev;
> +	struct auxiliary_device mac;
>  
>  	struct clk *axi_clk;
>  
>  	struct mutex reset_lock;
> -	struct mii_bus *mii_bus;
> +	struct auxiliary_device mii_bus;

Keeping the name mii_bus for something which is not an struct mii_bus
is going to cause confusion. Please give it a different name.

This is another patch which needs splitting up.

   Andrew

