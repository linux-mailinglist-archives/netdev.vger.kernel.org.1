Return-Path: <netdev+bounces-185226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D2A995E9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B97D1B667BA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36E028A1CD;
	Wed, 23 Apr 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n989T3S3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CF2820AF;
	Wed, 23 Apr 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427554; cv=none; b=IpYBQWEZKLdiAfMu/M3OnHPPY80wA03KGpufJyS7Y8NEsJdn19vPmzeLo7B9f7xeLJn/MusXdgo5WkhWY2bGtQxH44W26dBox0d6CuBJSLLq6lvyRJi+UZkZOELHTs+gE5QozTH/oRbuRS5PEluNMj7feRcghd4SHf9F8zLXTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427554; c=relaxed/simple;
	bh=ZBYjCWap5snCq+ls10DvvCuKnV6nwylAsutQrwPX7Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq2teiRiM2x2eio9dPmMI0miKgtMbW7oSXJ5xbq0sogQrD5PO4Y5IqOpR5MIIXmXXBfPk9h1JUVYDGAMSEaSGIi0xzvl6EMwU/zmX/t69vaYhMWjfN8yvyLU8zOuS256FVEQRZJqJZ8g0uJmmYQ2oO0RK533rI1gjHLPxFJdNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n989T3S3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+pGhfX/4H3scf/HydnEYjfq1z6zKounijmYTLMLhC5E=; b=n989T3S3GDIXGm1qZvGBeYMZus
	FFbkrtH8uTUC5JEGWWDg1gzaXJKpIm6WJL4xNXmsGG607YJy9Sp2XJvWYbYSJ+eTA6KLJDm+L9UsP
	YP9DGWt/OIbhPtQv9sfilbwMU7bSjlKGpijJY28Qhe1jNNoKo/3GIi2LLSDCk7AQOo0M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7dQj-00AMSb-42; Wed, 23 Apr 2025 18:58:37 +0200
Date: Wed, 23 Apr 2025 18:58:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
 <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>

> +&emac0 {
> +	phy-mode = "rgmii";

Does the PCB have extra long clock lines in order to provide the
needed 2ns delay? I guess not, so this should be rgmii-id.

> +	phy-handle = <&ext_rgmii_phy>;
> +
> +	allwinner,tx-delay-ps = <300>;
> +	allwinner,rx-delay-ps = <400>;

These are rather low delays, since the standard requires 2ns. Anyway,
once you change phy-mode, you probably don't need these.

     Andrew

