Return-Path: <netdev+bounces-96111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB58C45E8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B49E1F2123B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2D20310;
	Mon, 13 May 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KRgaCc5a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55022612
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620936; cv=none; b=UCnk62ZCB4Rf7iGmYSUs0Myp9i39O/QsVwHOCFHFYHf6mQ8YQi0WW9hBcv6gpsyL2vQGGEscau4eq8+i0f6Z8Q1Ip7nobkXEq+l6oP+d0rt6PN6wNCAouZ+BjdL26w9Wn8DcqoDlU+KmhE295BDUrwrzJLlRONDBdP29W4WsBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620936; c=relaxed/simple;
	bh=LapeqVwNKoAt+AhxqyrVNxWf38B0S/SBFikjDYrknGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7C4soD+XKSUZpuOYhMxYpT4LjOrULvwB9R4iduyulo+U1s/bHt2TOoz2kAlvbp+/ukZa4ZyMk64pQtxCxVMFNHxyV+yMhdU8Hw4oygyb1juWyTCmpPN8gNKBwGVAt4DRl6N4Lm2zDo8ycpDF8qBgBtpXFfNcdB+FiiIMGZLh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KRgaCc5a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P0ZrwzNqwtkYQgW/SBWRNMaRlv1kWQBbVtFFH/Xl9H4=; b=KRgaCc5aeBLmtX4zHQtjklNxpW
	D3jq4a4SKcLSWegI+tlzrO5E5vJgr8wBO75BedTp+lDLtlF1JXw/ssaSzTK8Szntp+BYR0I6cM5lq
	sraA55dob9ftkGglMJmrCwvlWpNKWDt/Jk56ds8NF9YaUNazk7VwhfZk560Aa7knJWHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6ZNI-00FKD6-KI; Mon, 13 May 2024 19:22:08 +0200
Date: Mon, 13 May 2024 19:22:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] net: ethernet: cortina: Implement
 .set_pauseparam()
Message-ID: <9d7d7e8b-8838-410b-a694-2f2da21602c1@lunn.ch>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-5-b442540cc140@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-5-b442540cc140@linaro.org>

On Mon, May 13, 2024 at 03:38:52PM +0200, Linus Walleij wrote:
> The Cortina Gemini ethernet can very well set up TX or RX
> pausing, so add this functionality to the driver in a
> .set_pauseparam() callback.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 85a9777083ba..4ae25a064407 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2146,6 +2146,20 @@ static void gmac_get_pauseparam(struct net_device *netdev,
>  	pparam->autoneg = true;
>  }
>  
> +static int gmac_set_pauseparam(struct net_device *netdev,
> +			       struct ethtool_pauseparam *pparam)
> +{
> +	struct phy_device *phydev = netdev->phydev;
> +
> +	if (!pparam->autoneg)
> +		return -EOPNOTSUPP;
> +
> +	gmac_set_flow_control(netdev, pparam->tx_pause, pparam->rx_pause);

It is not obvious to my why you need this call here?

	Andrew

