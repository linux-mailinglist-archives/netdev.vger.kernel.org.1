Return-Path: <netdev+bounces-187086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CCDAA4DD4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F1B3A50BE
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34425D540;
	Wed, 30 Apr 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0uyfOCUY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4E1D6DBC;
	Wed, 30 Apr 2025 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020916; cv=none; b=d3g6SVsrPwrsPLX47U+zPUN7WefwH/hTNKuINnmUCbSIgyt/KTcxa11bsKFn3c0kMdDQ39gDXVkp8M6PTj3jkKzkiHXuf2D5zhV/s5G6tJGQ8RF3AgjJouv4l8vzDAQ7cpBO957VT2rI+DSuUKUxVke3IaLNsUHUULUpiUBb5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020916; c=relaxed/simple;
	bh=+4sQkSLnuvN2qQA7KN6xnFTjHUHKK/eOmIEXpAQeyBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNIb5krGJiYDkuZ17z0ZY7p3yE853MFZN+qUjQyvuBtF4wyQrBYSQKjnwx6bJFi9H3y/6JwO7fvb+/GO+6CE5S8KMvEoZ4986yzKdF80smGtqSk7n1izkxelEot0T/stpVNW8CvT5bwmxQRNamoMiGUXMt5KfFUdMkz4bkzPxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0uyfOCUY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kh+5EI7pBmQ+Unq8j4v969l4zuH2jRdecV3GhSl3THQ=; b=0uyfOCUYAb2K17T2DXGQvqhlR7
	eGBMbM4pTEeGkH3Lk5EibazrJsLBDA6AYpnKHLXiJSXUdfkTxKzd119zSMLkUC9lTukRo9Hegw4HN
	ADC1/2DJp0lOkplIa8/bb0FO0o0v7cwXF7W7HnrphJmuJ02fGGZcw9ScNLsm9cjC+z6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uA7nX-00BDrT-QW; Wed, 30 Apr 2025 15:48:27 +0200
Date: Wed, 30 Apr 2025 15:48:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net V2 1/4] net: vertexcom: mse102x: Fix possible stuck
 of SPI interrupt
Message-ID: <665ef5b5-1802-47e8-a97a-972304c5ceb9@lunn.ch>
References: <20250430133043.7722-1-wahrenst@gmx.net>
 <20250430133043.7722-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430133043.7722-2-wahrenst@gmx.net>

On Wed, Apr 30, 2025 at 03:30:40PM +0200, Stefan Wahren wrote:
> The MSE102x doesn't provide any SPI commands for interrupt handling.
> So in case the interrupt fired before the driver requests the IRQ,
> the interrupt will never fire again. In order to fix this always poll
> for pending packets after opening the interface.
> 
> Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

