Return-Path: <netdev+bounces-144664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3339C8131
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAC28162E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C4E1E493F;
	Thu, 14 Nov 2024 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rXHBOzef"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50CE433D1;
	Thu, 14 Nov 2024 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553002; cv=none; b=BSjyvlvheIacT1/56LQ4IXsWYqVMoJVCRw3rC+AoOOPioy6Gxmn4WduvsVG8fcWkA3HJvew5CpqTv6tBmAgie6hPQ9X55J2el17eqjjfR5QNyeZN9invqplpTcnQ7Ts1bRbjw67NkYU7MfeO5cEPyOgGIJyEbzaTAK7zbwV1tyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553002; c=relaxed/simple;
	bh=R0omCTv1fKmLruLdm0U2jMBcupUY3T5+CouRucknR/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVIIbwjuSNDX7esfahqjkWhpjEZ+EgHBqHQyI2lrUJDoQ3rINQtcmRfNR2gXFuWrJP7jf6Crer+h/6OQOZjcvZOU2Avb1qZ38UIw+k8miyF+ZWV2KHjGMTKB8FEM2wrLfnvz9+rzWMNz6elyYKrTchhCk/SeEOBZ7wdI3vCzxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rXHBOzef; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JJq+FCylc0jmdKMgnYo/ob9xvCnB0F5KgIKVz3m2Nfs=; b=rXHBOzefIqgQ8x33CXqamAs/rK
	nzL1Spdpkwe3YloUQNFyv7UIdHE4tWNPm7JLtHn0sNJgC1M2Cug/DVCLmcVedA9kiJoboJ9v1Ski4
	4+eI6HBVUo72sS9vIr6cyhHIOd8tVnFRxjPAXkiP9GXLB2s3QwLLF7SMzoUf1wDK4nfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBQ1x-00DEnU-TW; Thu, 14 Nov 2024 03:56:25 +0100
Date: Thu, 14 Nov 2024 03:56:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-nuvoton: Add dwmac support for
 MA35 family
Message-ID: <b7fb59a9-989e-42b9-ac72-71f353854812@lunn.ch>
References: <20241113051857.12732-1-a0987203069@gmail.com>
 <20241113051857.12732-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113051857.12732-4-a0987203069@gmail.com>

> +	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
> +		tx_delay = 0; /* Default value is 0 */
> +	} else {
> +		if (arg > 0 && arg <= 2000) {
> +			tx_delay = (arg == 2000) ? 0xF : (arg / PATHDLY_DEC);
> +			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay);
> +		} else {
> +			tx_delay = 0;
> +			dev_err(dev, "Invalid Tx path delay argument. Setting to default.\n");
> +		}
> +	}

The device tree binding says that only [0, 2000] are valid. You should
enforce this here, return -EINVAL of any other value.

	Andrew

