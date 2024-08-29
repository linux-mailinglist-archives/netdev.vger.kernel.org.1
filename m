Return-Path: <netdev+bounces-123269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C74596458F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD35728663A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC21B0102;
	Thu, 29 Aug 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q8XshM6P"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CF1AF4E3;
	Thu, 29 Aug 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936008; cv=none; b=XDRi+t92jpLF9vZCFAgNcsfYpwgJJtxfZGENu+E8cl75DK/+VhdKcKrYyK/1p3UnDuj9i1lbMgbd435P9C6ajQoLIKUGWPSGNN7R3vYbjkKn/Dsr3Z/T5C+7/bn1EPqcCiUK88+eurvhVHdJ85y6nJwFMC1Ep/yspnqNxvI7BLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936008; c=relaxed/simple;
	bh=t84Y75AeJld6VhMkbxqZ4RN26WeuBYvFxtcWoJ+cOPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwHdbJnNSl3MOxfLEHHionVkHuLgGSpjQ8HbDZcLqevHQpj1rICkn6w+/XsD8bviErmE2IZkDH5+PrptGxKKLr39BPndyNOPcCtU77+ZVpG/PH/5GfXWX3G0YaHNFGEYPLZgm7Qe5WLTUhwJGyKRGvBZ5v6LCe/Fc56YurWf3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q8XshM6P; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4XVFWemciIAHW42T2+DLDBnxwOiYznfPcQJ7dmpsZvQ=; b=q8XshM6P5jdFu3CwMM33x1KjGE
	PFIISWANX1R6Xo7zy2G+tMkx0zc4dr6jdBediAL8bmsuEdJSbBd4f43AzvkeXMsk2JIlicArPRY7N
	wYxTo9Jf1HiRj05zI2LHCWa0EJ0FRc4mffdMTOVULqqCRRzBdJydOzb2+8q7gwOjVYaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjeeE-0062AF-2n; Thu, 29 Aug 2024 14:53:10 +0200
Date: Thu, 29 Aug 2024 14:53:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v3 08/13] net: mdio: mux-mmioreg: Simplified
 with dev_err_probe()
Message-ID: <3e47f3ee-bf44-46f2-a080-5dd9ac559cbc@lunn.ch>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <20240829063118.67453-9-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829063118.67453-9-ruanjinjie@huawei.com>

>  	s->iosize = resource_size(&res);
>  	if (s->iosize != sizeof(uint8_t) &&
>  	    s->iosize != sizeof(uint16_t) &&
>  	    s->iosize != sizeof(uint32_t)) {
> -		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
> -		return -EINVAL;
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "only 8/16/32-bit registers are supported\n");

Please think about this change. Why is it wrong?

       Andrew

