Return-Path: <netdev+bounces-138856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862579AF309
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3206F1F21186
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF411A7ADE;
	Thu, 24 Oct 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cpYHN+kp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2422B656;
	Thu, 24 Oct 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799748; cv=none; b=mrD2Wwm1cBDCDmB/1liu1Gvzv0mBD68cjicEjLWjWpKO69CNjd4ezYImp2C6twQZpli6nABth9rbQE41m/MLB6mtdlBthPjeINCua7mPG9ElCSt+L5NxWCufSIE42j3zdD7bkhUsj3VDfvhEHEs1KjGUE1cJDq8oIgcghjn7Dww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799748; c=relaxed/simple;
	bh=Fw5zA1BJeray3y8Y0Dh7HHmux2rO+bnzVVkJap2Pw1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO9Oqr8hqbSbHtmp1KC1MPzPmljxlw+eAsQWRAeMg3kPY94A+nTeNC65+LV78iUqOQywhn3kN0s4WzeJY2TSwR0YOzTrsJVwggYmpns4x2TU7D9oDpqJd1+FRfFEv6ntnV5PFuMhynS5+DBT0FEFfMAkYzlQsxl2TnArCZzND1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cpYHN+kp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LcZcoNtK17StNbJld4FBjf5TfS0y1pDALpIecO6pJw8=; b=cpYHN+kpLCNRDo+Jsqh9hkvNri
	8hDvwYHii0T3iIftrtFDnHnSDy54Pphqvp+HPbE+SnF64EHrYfqtUzbdrxnmO4EyI8dU+U9dMacP0
	U9T783tBIEqf//Ri/hBWLECap/87eyFAXO94zckngbICbvyz21ovY4ZyU4+5k9Ifby+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t43vm-00BAiO-7O; Thu, 24 Oct 2024 21:55:38 +0200
Date: Thu, 24 Oct 2024 21:55:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, horms@kernel.org, jan.kiszka@siemens.com,
	diogo.ivo@siemens.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix 1 PPS sync
Message-ID: <1a0a632e-0b3c-4192-8d00-51d23c15c97e@lunn.ch>
References: <20241024113140.973928-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024113140.973928-1-m-malladi@ti.com>

> +static inline u64 icssg_readq(const void __iomem *addr)
> +{
> +	return readl(addr) + ((u64)readl(addr + 4) << 32);
> +}
> +
> +static inline void icssg_writeq(u64 val, void __iomem *addr)
> +{
> +	writel(lower_32_bits(val), addr);
> +	writel(upper_32_bits(val), addr + 4);
> +}

Could readq() and writeq() be used, rather than your own helpers?

	Andrew


