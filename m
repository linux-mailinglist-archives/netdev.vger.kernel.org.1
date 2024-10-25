Return-Path: <netdev+bounces-139107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFB9B03E1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B771F22704
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2F21219E;
	Fri, 25 Oct 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5YTw7mIN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DA70804;
	Fri, 25 Oct 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862531; cv=none; b=dP4qrdFOycGE7fID3DuchIgdogHdKnPd/BGnSgh6ooXQuVmPq0JkbzQpNWnU+WLuWtQ/tBwqHJ944iO+qwtW7n8miOTVdkGYpOZx5naDQiaEJY1VFnvvQh+IGf6JElEak96Ad2I7bbsdv7lAG1SlBFQO6+ZtvNoU3tJnd1ukA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862531; c=relaxed/simple;
	bh=97xec6Itfp79eJ9V8LHzJNYUNNNLIaje9kzkQHPz3P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdXAovAw/YYaDRPu5A2T1/i7t/oX245xEIeJCRiO25OwlFoxETFo5IOSGnEZZNtTCtplZle04fx5NwCo1Myzykh5Pk+dadetTa+JPFXg4eaPLI2EUb076buuydIVdBIMpbXOsvuhd5AWHI2kP7N2dQ6lczS2h4sSUpGs7sivLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5YTw7mIN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dbDacs+phZXwUZfEmiSz/UQ0arF9t20M+M+9HrSqDHs=; b=5YTw7mINuAK2FjNLppS5ZX1TEu
	wA7kxuyX0b4aVDS0I5chb9XbMsSEgxdPDM9QWZBhTMG0EI4NF16Qn73OzYILoGRDGwLo+Mgz8fxjH
	XyEomNde5QB1IVSoQRG9X7xuYpm29P2go4s9mqYVtDGCv+aWJPzlUtTsdV61mOIfzyHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t4KGO-00BFR4-A5; Fri, 25 Oct 2024 15:22:00 +0200
Date: Fri, 25 Oct 2024 15:22:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, horms@kernel.org, jan.kiszka@siemens.com,
	diogo.ivo@siemens.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix 1 PPS sync
Message-ID: <2288a9a9-f9d0-4414-80a2-e11ba66fad50@lunn.ch>
References: <20241024113140.973928-1-m-malladi@ti.com>
 <1a0a632e-0b3c-4192-8d00-51d23c15c97e@lunn.ch>
 <060c298c-5961-467a-80dd-947c85207eea@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060c298c-5961-467a-80dd-947c85207eea@ti.com>

On Fri, Oct 25, 2024 at 11:17:44AM +0530, Meghana Malladi wrote:
> 
> 
> On 25/10/24 01:25, Andrew Lunn wrote:
> > > +static inline u64 icssg_readq(const void __iomem *addr)
> > > +{
> > > +	return readl(addr) + ((u64)readl(addr + 4) << 32);
> > > +}
> > > +
> > > +static inline void icssg_writeq(u64 val, void __iomem *addr)
> > > +{
> > > +	writel(lower_32_bits(val), addr);
> > > +	writel(upper_32_bits(val), addr + 4);
> > > +}
> > 
> > Could readq() and writeq() be used, rather than your own helpers?
> > 
> > 	Andrew
> > 
> The addresses we are trying to read here are not 64-bit aligned, hence using
> our own helpers to read the 64-bit value.

Ah, you should document this, because somebody might do a drive by
patch converting this to readq()/write(q).

Alternatively, i think hi_lo_writeq() would work.

	Andrew

