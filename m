Return-Path: <netdev+bounces-118493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D7951C79
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8631F2164B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B51B29B5;
	Wed, 14 Aug 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G3VqScFP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A861AE855;
	Wed, 14 Aug 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644172; cv=none; b=O9jq2q8VdDlY1IBYFS7zY5179rAPb5RgRw1BRNcgRkF45dU7kSV1CZydYBQjcUFOi+DN5/tyqTjQj9owdQCMb1y5T9ZYAInj4X7o9lLPJwzKnlQ39B5pRwLx1FQNq9PlyfaDnA8N3MtdgsVhcxdc3qNw1FvruCh93hwRYDrzzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644172; c=relaxed/simple;
	bh=6L8akOPqyyTPBa3PqXH17GTp/Y2Tsj2veKm6veIzVlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcgpJVFbNSS9ndqB8AtwOkAoldJmX3zXdE3o0htWyiGqUrAuFz5jWux7jhJGBwAyeh0HJCIwdjLIE1mQ8BsaY1Zg77l5zQXg61xkBAEzAElLL05cJ6WpXqpzkwuAlI+7kXXEKmmtGWerc+B8/vekruQyMllA38Skms5A+/rGKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G3VqScFP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6+uVBqyTy+4a4I/W2kullK4I72CTIelXCLMBNU2Cl2Y=; b=G3VqScFPDpuoQBh6K2RUl6CHmF
	S/1jvXjwK1KH9/vCJUZD5plk6V0Cq2oYhjS5Gc0MSO2yaadQ5gTpIxRJPYq9ZpufQR0Q7NeoG3g1e
	aH5VFWrvwei2A+0KArzqhZ1XSUXG1BsLU/0HahTQWflPbizTDjOe1UOotW1J5U5ejRcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seEa6-004lmN-D8; Wed, 14 Aug 2024 16:02:30 +0200
Date: Wed, 14 Aug 2024 16:02:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
Message-ID: <5128f815-f710-4ab7-9ca9-828506054db2@lunn.ch>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
 <082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch>
 <1ae38c1d-1f10-4bb9-abd7-5876f710bcb7@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ae38c1d-1f10-4bb9-abd7-5876f710bcb7@ti.com>

> Yes, the icssg_init_ and many other APIs are common for switch and hsr.
> They can be renamed to indicate that as well.
> 
> How does icssg_init_switch_or_hsr_mode() sound?

I would say it is too long. And when you add the next thing, say
bonding, will it become icssg_init_switch_or_hsr_or_bond_mode()?

Maybe name the function after what it actually does, not why you call
it.

> >>  static struct icssg_firmwares icssg_switch_firmwares[] = {
> >>  	{
> >>  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
> >> @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
> >>  
> >>  	if (prueth->is_switch_mode)
> >>  		firmwares = icssg_switch_firmwares;
> >> +	else if (prueth->is_hsr_offload_mode)
> >> +		firmwares = icssg_hsr_firmwares;
> > 
> > Documentation/networking/netdev-features.rst
> > 
> > * hsr-fwd-offload
> > 
> > This should be set for devices which forward HSR (High-availability Seamless
> > Redundancy) frames from one port to another in hardware.
> > 
> > To me, this suggests if the flag is not set, you should keep in dual
> > EMACS or switchdev mode and perform HSR in software.
> 
> 
> Correct. This is the expected behavior. If the flag is not set we remain
> in dual EMAC firmware and do HSR in software. Please see
> prueth_hsr_port_link() for detail on this.

O.K.

	Andrew

