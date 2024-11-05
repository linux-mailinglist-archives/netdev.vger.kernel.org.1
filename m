Return-Path: <netdev+bounces-142093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330119BD75F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626621C2293F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01228215C68;
	Tue,  5 Nov 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EMLOHdhR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35E1FF7A5;
	Tue,  5 Nov 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840431; cv=none; b=ou1z+uDFnajbsJDqIA6lUdqisjnrW82JBd5wcmSwMapT83BxgqZ2qvU46VLdTHNT+mrEztdxQ/LwOFqAS/FFauDdUM3ZQePlkDP+thaH8FwQ6LWcNyw5AXceXUS4cHtg+iBuz/EECozbq2T6fln2fZ3WT3ufE01GCSzd8iX3r64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840431; c=relaxed/simple;
	bh=48s0hy2LXyleJBmoMFvBJ/haU4AH8PKwJ+78RGfmwac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeZdZv4yQpPcrBTKNASXggXWsnOmj551TN+N6EESMTsIO5yQZxA+L8G8kBcSG0PA15LPK/33Gk1phF+OKhBl0Al638mhSFkN3mvq9Rqsj8qj9FgH41NbkKpAncHHj4Fpfm2A5KX8IC1NP5eCusNdiGIfQAE4NAyLTppj6r/Oi1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EMLOHdhR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V+vyhukru1uIeE+kCfGRSTvksfHKtqzKauF6SWXFu/M=; b=EMLOHdhRqzpI6dSuwpLRH3iGqb
	RGYoKlpFPRnoA/Fh6kyX2tOZFXigDkaI5v/cE074EzYFnfmnOMeNfPJezJL1wdDi/FPpPP9frAKCr
	V+sL7N38ufFpzmbopw4WvkugHzE9+gEX7oFn7DqYGOYhAWj42L4FDV34AIZoEZw7j4q8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8Qex-00CFpl-6A; Tue, 05 Nov 2024 22:00:19 +0100
Date: Tue, 5 Nov 2024 22:00:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: Jakub Kicinski <kuba@kernel.org>, vigneshr@ti.com, horms@kernel.org,
	jan.kiszka@siemens.com, diogo.ivo@siemens.com, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix 1 PPS sync
Message-ID: <6a230b28-9298-410b-b873-21000af4c0f3@lunn.ch>
References: <20241028111051.1546143-1-m-malladi@ti.com>
 <20241031185905.610c982f@kernel.org>
 <7c3318f4-a2d4-4cbf-8a93-33c6a8afd6c4@ti.com>
 <20241104185031.0c843951@kernel.org>
 <e5c5c9ba-fca1-4fa3-a416-1fc972ebd258@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c5c9ba-fca1-4fa3-a416-1fc972ebd258@ti.com>

> > I think you need to write a custom one. Example:
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/meta/fbnic/fbnic_time.c#n40
> Ok thank you. I will add custom function for this and update the patch.

Maybe look around and see if they could be reused by other drivers. If
so, they should be put somewhere central.

	Andrew

