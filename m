Return-Path: <netdev+bounces-175304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DEA65030
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310CB1886091
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F223E344;
	Mon, 17 Mar 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lYp3UZUY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2523372E;
	Mon, 17 Mar 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216654; cv=none; b=RTY4quVFi1Ny0tpBvHpgivILf1zB2K93fmgtZL0TuXtDboFzdwkMDreHJcKUhyJrLjT2v4BB5Oc/TkO4Zu212djALFZUqhL3CYFBz4LTRyTgyTIXwZC7KkpHKRZWriqydvYnhXkMno+fV16p4KdWMVKr9f3cqPsxXXdpQRu4Bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216654; c=relaxed/simple;
	bh=EHLMuw/JyYlLvDqU6h58lMcp/uEcpIyU1m8aaA3ufQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2nocHr+SYn4i/ZAAO4eqf5Qvv8Sckh6M7MZ0CmWCTPRvDIWyvVdeihhMyTBRkS2+N8jYTkBWHnIgXxd32lLYH2QdjE+MvFBtbHIKVcdKW6KTb2OYiop9dTj5E8GvSa8V0zihYDRTQXNphkThg8AckrC9jOXvv0wtdual0FvFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lYp3UZUY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QQDJSZlvsPxdtXrcfxhzYY3pnuTPlN7iObJIZ09ja6k=; b=lYp3UZUYsynZHh9SB8+AUqn7QV
	AyCwpZ8gMkzuLmEHDZlx0CX1cJWd/yocolMKVYsRv55tey9MEQwUSpi36y3RIBZAPtPPkU3wUiSOx
	ef+YKgM+xnNz05PyqngL0J8pWFoe17d+g4PUZE99fHXCZppS+aSBCwmUiLyNxV/j14aY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuA8M-0068KE-SL; Mon, 17 Mar 2025 14:03:58 +0100
Date: Mon, 17 Mar 2025 14:03:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Message-ID: <dc7296b2-e7aa-4cc3-9aa7-44e97ec50fc3@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317025922.1526937-5-jacky_chou@aspeedtech.com>

> +	u32 rgmii_tx_delay, rgmii_rx_delay;
> +	u32 dly_reg, tx_dly_mask, rx_dly_mask;
> +	int tx, rx;
> +
> +	netdev = platform_get_drvdata(pdev);
> +	priv = netdev_priv(netdev);
> +
> +	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
> +	rx = of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay);

> +	if (!tx) {

The documentation for of_property_read_u32() says:

 * Return: 0 on success, -EINVAL if the property does not exist,
 * -ENODATA if property does not have a value, and -EOVERFLOW if the
 * property data isn't large enough.

You need to handle EINVAL different to the other errors, which are
real errors and should fail the probe.

The commit message, and probably the binding needs to document what
happens when the properties are not in the DT blob. This needs to be
part of the bigger picture of how you are going to sort out the mess
with existing .dts files listing 'rgmii' when in fact they should be
'rgmii-id'.

> +		/* Use tx-internal-delay-ps as index to configure tx delay
> +		 * into scu register.
> +		 */
> +		if (rgmii_tx_delay > 64)
> +			dev_warn(&pdev->dev, "Get invalid tx delay value");

Return EINVAL and fail the probe.

	Andrew

