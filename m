Return-Path: <netdev+bounces-210011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B66B11E83
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402F1AA548A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B412EA15B;
	Fri, 25 Jul 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sbLPSZU0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCB24E4D4;
	Fri, 25 Jul 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446562; cv=none; b=dDHzAI7Oo2pmuvoyLJKRHsvgAwKsGJx1JKrImk/gwGnH2Buvh6Np1goS3rWzmCvkf1ccPxhWER1Za6cA9fwuYpWxxushdW5VDhhdMMKgYujFf/vj6W6dQI04b0y1onMd8NXR25tFArWSQrowuMp3NGpEu6nXYj9g6OaZVV5Yqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446562; c=relaxed/simple;
	bh=TtzKoulzTgzNhG4ZWzq63btd7EA43u9FgDwMYnPQ44w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N39fYkjbL/YRdXLx1ZXnoQ58/0+Du8PQsgXhy8LZNBzOwx2yALiV4KUycfQ66tQNzPaOKZQZkbzlHUWVuEDoIvJx+15nGmegqpVGeTAqoNtB9fivQ5o4bN6WSn2Xe8BR67C59C8YjIA5hKGCWsueRNumvzM/MUKDsilBPiR/Fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sbLPSZU0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yts+ba71y6u4Np3q4bTSFR8pw7cPvGKj1rv9PdHUec8=; b=sbLPSZU0cecihUfpvRQ4967Z/F
	iT67lYzssLNXXYtZMgc4yPdfIlP2YklS8RDyvU7x3IPRs4QtXjeBgursrQ/uRsdqy+1aeRCff5itR
	8YHt5qvmKy2//66hFpMRmdhGrNMQvwaTNmgtXl3a5u34AQyfQ27p9dqNWOGzx7XRbw3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufHY0-002rcH-9b; Fri, 25 Jul 2025 14:29:12 +0200
Date: Fri, 25 Jul 2025 14:29:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/6] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <ec1a89f5-a467-4500-a8ee-6e0c8fe3d5d3@lunn.ch>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
 <20250725001753.6330-4-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725001753.6330-4-Tristram.Ha@microchip.com>

On Thu, Jul 24, 2025 at 05:17:50PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> to change some registers when using KSZ8463.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

