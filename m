Return-Path: <netdev+bounces-141315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B009BA75E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA6281E88
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA139158A36;
	Sun,  3 Nov 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C/l/HTtV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32129A0;
	Sun,  3 Nov 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658031; cv=none; b=FwNsDcEfQMNZ/gfjUr2C9eaY/KALPfoSbK4YwT/8X2GToJzt/r1rkpGH/aV5hSa2DQ457lqCBuC5GMu2b1bSZjgwF4Pr6zdAL17Zm/NkmvywRnqEriTFSGinjHbBkDn9xOInx1h9o0xPMvbi8mXYdabbYT5pKW7IDAD5988hrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658031; c=relaxed/simple;
	bh=8Lw/DwOydEskM0e/+dMY1vjT+NEOaxd5foyNhmmyD+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCE+Am3d+/kXt3qE9Jgek6vL3tQpihW6+WGF97DrY265FCN6IWmzYlAWJaaGYgIcaIcpGFvPuGeFH1JneNarOrghAzuuTxxpfLEn7BNPGCKM2ULgMmfZVDCfFxaMWY+P5mcXm/WCoCY9wN5LEIylDmh3nvPihcDIrG7v78hI3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C/l/HTtV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KoeC812BJC1qP0utpHBC083qksYwLvvWXbWjSDq4s+A=; b=C/l/HTtVqwvFuLNKkM/AW0KD3u
	uVlWTzNtla+1d01nLpVzZP7bYItGm9/y9ZnSsmMHGpAccfccOcpzMzFT/sf21s4QmUeWUpvoNOPy1
	2L9+4DHB/lUyGyFR+S1OqrgwUyGLNBIoqcYvC0mqihwvqGadJLAjKf7mtLzKUedyOxcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7fCv-00C202-6c; Sun, 03 Nov 2024 19:20:13 +0100
Date: Sun, 3 Nov 2024 19:20:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, kuba@kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, peppe.cavallaro@st.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] net: stmmac: add support for dwmac 3.72a
Message-ID: <0b64d49d-b0a0-45ba-aecc-febcdc557679@lunn.ch>
References: <20241102114122.4631-1-l.rubusch@gmail.com>
 <20241102114122.4631-2-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102114122.4631-2-l.rubusch@gmail.com>

On Sat, Nov 02, 2024 at 11:41:21AM +0000, Lothar Rubusch wrote:
> The dwmac 3.72a is an ip version that can be found on Intel/Altera Arria10
> SoCs. Going by the hardware features "snps,multicast-filter-bins" and
> "snps,perfect-filter-entries" shall be supported. Thus add a
> compatibility flag, and extend coverage of the driver for the 3.72a.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Does what it says:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Dumb question. What does the 'a' mean in the version? Or is this
actually hex?

    Andrew

