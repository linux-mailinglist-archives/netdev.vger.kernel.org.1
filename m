Return-Path: <netdev+bounces-106241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302B915724
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C222F1C23421
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E41A00F1;
	Mon, 24 Jun 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YShNIVdA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80119EEDC;
	Mon, 24 Jun 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257289; cv=none; b=O00Y+p6WrlNU7scTzyY/Yj6stJL6FWMjx+D5s4tTr8cicC8cdEWna80l/3svGnA7a3FCSUsy/faQkXnALKcPmJ/bI+/1I73n/6quNg3fePDJ2F1jovANGcmtrGAB3PRz4/zzzp8nzJL4AadxQaFCe9TaXuydCRVumvppsFBULH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257289; c=relaxed/simple;
	bh=vbFOgPgW0uHIR4E4j+Gt+LnVOjU54GeiwpHNnHLXCrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA5+ReXoYaZsZvEKWGkSrpyOWvtXwvaseYd77wTPkaqhKnJfzu9HlH6JQVEBCwXhKllwP8yZoqy3gRnEtwABuFg+3q+T04ERKgbifv5b9MftzMzYEDtnO/gdRY6L28dZ99IYbY+oHNqQ1CpKGeffqu5x05rKgU/IQaUDv4PKoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YShNIVdA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Omp6jWor1YRJRQsi1OuXUg4RXgEComhWnlLImDlXrJ4=; b=YShNIVdAWRn3M+33HnHOpzlGBG
	CYoLFXkULWyF5y6amlDx5GnD75p0YkcTzYj0Y3EIe4CtymBghj8S9IPeM/jzAR2J0d+ZGR9dVjCXd
	3nUzFrPFkxkev/XEeSY3yAAyXXTFrfwpmaw/wzRFVgTli8hDkorsqZ8zOybl6FYz2iGI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLpM2-000sb5-5m; Mon, 24 Jun 2024 21:27:54 +0200
Date: Mon, 24 Jun 2024 21:27:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 4/9] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <55e4b689-6867-4de8-824c-064d9191e44e@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-5-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-5-danieller@nvidia.com>

On Mon, Jun 24, 2024 at 08:51:54PM +0300, Danielle Ratson wrote:
> Add progress notifications ability to user space while flashing modules'
> firmware by implementing the interface between the user space and the
> kernel.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

