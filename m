Return-Path: <netdev+bounces-98347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A78D102F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A49D1F21D5C
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1911667C9;
	Mon, 27 May 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fSy0Ga4U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135917E8EF;
	Mon, 27 May 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848347; cv=none; b=I4bKXanRwBdFI/OacJoTmiGc2dtc04pHoPNUpHYrzl2gQ1oIQFkS1i8tKbQHvxjCludmyqIQHaxr7/nZBRs4JnECel2oz9lN/C3AjC4ubhySr/+u0Y5eY9/mACE5//1K1H24udloXH+bjhkJ5c0F/+yDou4UaZFF2h/YBmnmWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848347; c=relaxed/simple;
	bh=nBsMaSZMZLwwhSbLlNH5zZm39772/CBLeDri8h0k1UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shFPbiJqeXs2yGSrFxfAbyoHGjbUKgvOs6VKeCiKWqs5gvVXRvOhCWcf5cVNAULWgj5u57j1IMnBcCZLOWTZL45RjbuN49h6BBMpixkOxM3Bg+SNStpmFntufzaYnx/YGv1dVkUXI5Kp4REqhj0XZH7LXWKWU3dVwlfG+H5LUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fSy0Ga4U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zo1XCoKBVMLFJ723+R6j/uyNQ3r6suOfHnoTPScIyo0=; b=fS
	y0Ga4Ub6PVt4oEfmJg5kM77IWFUmmYrw5zLmQtvd0MidTODiDw2WVk7OQBpuHHDdIoL4b2fZpO+xJ
	LxtXFemqDH7EMOrH/urn09Qaxcy7vIBjNr2jl+1vne1AGtVXq+pFTODjJHv0C7rdsWKL9XuKdsnN2
	33WfX0Ne9o88a0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBig3-00G6s8-1s; Tue, 28 May 2024 00:18:47 +0200
Date: Tue, 28 May 2024 00:18:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Message-ID: <1d0f9d73-89e7-413a-b1df-5ff56bc1cac4@lunn.ch>
References: <20240527055300.154563-1-danishanwar@ti.com>
 <20240527055300.154563-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527055300.154563-3-danishanwar@ti.com>

On Mon, May 27, 2024 at 11:23:00AM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
> configuration.

You only mention dual-emac here. What about when it is in switch mode
and is using the other firmware?

    Andrew

