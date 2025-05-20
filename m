Return-Path: <netdev+bounces-191900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896AABDD46
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185738E1407
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10369246765;
	Tue, 20 May 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b1+f6y/q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5B0EEDE;
	Tue, 20 May 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751428; cv=none; b=jrXnSUNzMZysOWxzmJe7zqu1KFJ+R9DFyHLJsOJbpswxtT1zoxKgLNBfczvfoKZxaf3izbuBYfyUxrkUXsTSsGjg6bWO55iI7c2HA2uI0NI8jDkIgqGHgMkVa8wXF2uesQw6y50qtLjcL//fsdK+zZGoKIQbTfUPga08kDBM+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751428; c=relaxed/simple;
	bh=muApyINzTB9u4a/fQgtoIyPRGqFRWXQQmhe1H/OsntU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFscY+q7Ny1cqnvRPY7gr3DnoIz86j9Y4gIg6ySqdWff4Hw3akHIeod+YIclMQ1+GNiqz2TV99BmTKcpnLOgXHPuh44IXndVSNjNr+9VtVEpdmqU7q6vVzwY1+Dhlc2ug7+l/H5q8fp+ubegzr40TgXCaY9SZlA1WYz6F46PPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b1+f6y/q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=60oYgzAqshuD6yLOKdWI/2Zup0hrKz6aeKRaimHYHAU=; b=b1+f6y/qH2058NF2o/xrWpwO2L
	8MoTZG0nKc3MTgGQfRLBEdPRafkGWEK3ijxCQ9bcpbumoeiNLv86XQr9TWXw/ZqLfeeD6OQBg83P1
	CaOiweBnQ5dCVPAv5On3ryybfKlhWBMlvWfjvQ0OfkUjmAvZBizf7FXaqJj3BJ71oYsM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHNz0-00D8Jc-Gt; Tue, 20 May 2025 16:30:18 +0200
Date: Tue, 20 May 2025 16:30:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [net 0/4] net: ftgmac100: Add SoC reset support for RMII mode
Message-ID: <cfb44996-ad63-43cd-bbc5-07f70939d019@lunn.ch>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520092848.531070-1-jacky_chou@aspeedtech.com>

On Tue, May 20, 2025 at 05:28:44PM +0800, Jacky Chou wrote:
> This patch series adds support for an optional reset line to the
> ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
> the internal MAC reset is not sufficient to reset the RMII interface.
> By providing a SoC-level reset via the device tree "resets" property,
> the driver can properly reset both the MAC and RMII logic, ensuring
> correct operation in RMII mode.

What tree is this for? You have net in the subject, but no Fixes:
tags?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

