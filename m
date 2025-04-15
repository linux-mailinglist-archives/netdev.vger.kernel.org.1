Return-Path: <netdev+bounces-182560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B3A8918C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21580189BFF4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711861BD4F7;
	Tue, 15 Apr 2025 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gkT1XCiF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2401A5BA8;
	Tue, 15 Apr 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681448; cv=none; b=bgjLPt0Y7XyVDLCEv+6DC+LMf2T9EZkpXnCkdWtWdzQd2s8ygooQnCRIPVoEEeJ914MUN5xEFu4TeqyNKcDFCOOjQ2acyiYhRh3kh45ZpnkPGQFhhmAKVGKznqL7EVS08J3YVt5RZIK1ec+VaA56tk6wV2AapQCNf8brsj71frY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681448; c=relaxed/simple;
	bh=5/BeXwKcj97t82jM+9oYwA9IQD7JHFcv3WYKpcXTkHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkvF7n2MGT5RjMy0eYKgDPgCkD1367YKbGVW4WE9Avrr+xqsDn+dkEEuyayqHfqzKtqmKN5ulX9XDSFPcptGq/BMWgGG7MA8Lh1SdvsBaTZpnBGMgM0QBOKbeb1P7KoRz21VSQQqvHFChF0PPWoukVlRT/SmT1pJ0Pd1KYDBvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gkT1XCiF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wGR7nK8EU+Cj5W9ySk84JYng8rysMk1dgDF+70d6Bc8=; b=gkT1XCiFMPbPvAozaSPSIi2XnW
	7ylKKmYfn5zEZNYYZb8vFvCYJOsVlqoJAYTK9KVIxklBr4X/NwyS2mkh+jVnyd8898ni4BXUR3UOE
	ut9/u80pzzVHjE5+nrAGEWQ7cBye7POaHgaQOP/YdOv0Orw03jhVVcnp4WQZKyqWeLK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4VL9-009Jyv-LS; Tue, 15 Apr 2025 03:43:55 +0200
Date: Tue, 15 Apr 2025 03:43:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v5 4/6] net: mtip: The L2 switch driver for imx287
Message-ID: <45a4fe47-d590-442a-9073-39472a49d52d@lunn.ch>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414140128.390400-5-lukma@denx.de>

On Mon, Apr 14, 2025 at 04:01:26PM +0200, Lukasz Majewski wrote:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
> 
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
> 
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
> 
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data
> to/form switch (and then switch sends them to respecitive ports).
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

