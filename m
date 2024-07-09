Return-Path: <netdev+bounces-110396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A0C92C2A2
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C15282976
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9215886B;
	Tue,  9 Jul 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n3/gDoI4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D81B86CC;
	Tue,  9 Jul 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546775; cv=none; b=XzpzI2bDUcFeCktOKZf7LkL5eXiKj0tiMLerD4r3E7BAppybcPp/10p6LhWbPaprKyjrqCBPVzZ5ixJXTwD+xxteoedUjxqWSPdez8/O3mljT/guE0JczI7sLnhFRVWXSjHiFGYLFTIBZG4iS/8nih+a9ThA9+Oi/JDFyPQLKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546775; c=relaxed/simple;
	bh=DUv3vz9bXqK9hhtMIiWDO/zVfmBzgXQ9Viyn5KKdtm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii2u+ouJ2xXsJYatr65ZdfBV/JASoYY2yO+TLUhbv5aYYzOTydWOc9VNiBY258wZuDH9OUx3xt33qRCHEjpoK9pS/oZBOy5gOcwV0HFia3NNL8+m9QdJwK2+VOd34eGOoefohNuUTKcn8X30npAMRspvfVNlvtFboXlgHLLvfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n3/gDoI4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=88YsXNA6H4EXPft88nvd1iwciO7x20mRHeiX1KkDl1k=; b=n3/gDoI4EZRQFQWrOj1FgLkqN2
	hDFtbSIRo5HMTCrrgODmSLZWWMx1iBW0UZsVd6FbkGA+DiQtzFKYDFZQBAOYUIx4m7HMgig3EqlFP
	e6zS9uDvHW6aWlStnIAhLoBMTC9BAya+IlK/u9th7vzT5ZfEPXo+eZa2gQFXc1eEVMFk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sREo4-002AV1-D0; Tue, 09 Jul 2024 19:39:12 +0200
Date: Tue, 9 Jul 2024 19:39:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v6 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <68a37d33-6155-4ffc-a0ad-8c5a5b8fed25@lunn.ch>
References: <cover.1720504637.git.lorenzo@kernel.org>
 <bafc8bcf6c2d8c2b80e6bafebe3661d795ffcbee.1720504637.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafc8bcf6c2d8c2b80e6bafebe3661d795ffcbee.1720504637.git.lorenzo@kernel.org>

> +static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
> +				     struct airoha_queue *q, int ndesc)
> +{
> +	struct page_pool_params pp_params = {
> +		.order = 0,
> +		.pool_size = 256,
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.max_len = PAGE_SIZE,
> +		.nid = NUMA_NO_NODE,
> +		.dev = eth->dev,
> +		.napi = &q->napi,
> +	};

I think you can make this const.

> +static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
> +{

> +	port = netdev_priv(dev);
> +	mutex_init(&port->stats.mutex);
> +	port->dev = dev;
> +	port->eth = eth;
> +	port->id = id;
> +
> +	err = register_netdev(dev);
> +	if (err)
> +		return err;
> +
> +	eth->ports[index] = port;

eth->ports[index] appears to be used in
airoha_qdma_rx_process(). There is a small race condition here, since
the interface could be in use before register_netdev() returns,
e.g. NFS root. It would be better to do the assignment before
registering the interface.

These are quite minor, so please add to the next version:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr

