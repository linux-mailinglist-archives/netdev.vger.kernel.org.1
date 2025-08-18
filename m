Return-Path: <netdev+bounces-214738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30516B2B219
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 22:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C3817E4EB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271E225416;
	Mon, 18 Aug 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIpOS1xk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA103451A6;
	Mon, 18 Aug 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547838; cv=none; b=BVYYF9HLzMD4FLwrELuqKoMe3DS39oROjdbJ5R5zAD8olSRcpFYX+e67yzLQ2Cb5E6IDjuhVLeBR5pCr4UWb83ooFbTZciMUShHvHb6HzwcWENu2OBn62cW3YKd77iapKqJzfHUaAeXLhHr1g5cqtnwaFr3hxVAVjL22/Sk9teQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547838; c=relaxed/simple;
	bh=qg6GZTp8IOOZdRgNGIXFARftWitXEVGq3DzHCuGmImo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkNI30+Gn03PDMHPz8A9fTRWNojyn3AvDDhJZ93Qp8zUXn7NtNfmTSvZUuw+hETz8IIuZIDJp+5biERvfVLKeDgc5BHHjRis4PYOyCtahCvBv245Lp7iUiHj3+CXbkjUyvOi9SamNnHV/iFZjHlMVV9Nyz6KLyqbJvn7DxcVQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIpOS1xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B7C4CEEB;
	Mon, 18 Aug 2025 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755547838;
	bh=qg6GZTp8IOOZdRgNGIXFARftWitXEVGq3DzHCuGmImo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JIpOS1xk7YahMhN5Ye/QxfvM1KFZzF+ZJKLD1lPbylumH+5cNqfFXMwBkxuvWL60v
	 qi4ZUeXgTw+TLW1+3cnLUthS8RU/rplcG2CDUkqpiPPW5RqF3PHaiPwyJulrJuDI4N
	 xQISNqlI4R6NnYQXtV7jw0ApGiVSjH6JLT5rYnjmzThfKjzuu67dyZnWdWYpXXcy0x
	 Y9B7SkxmxNElXdnU8JtDZfUQMFGt/K1e6TgmtamsG6LunbtISoRzbTA3gkeFvrU7Pl
	 jUDODGTn5iRWh6am2TOOeB+pWZdb+TF7c+v7Ej012BUzj8hGZvqiqXubas7FFeT0bM
	 rHR/aKgHbW/hA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A80ACE122F; Mon, 18 Aug 2025 13:10:37 -0700 (PDT)
Date: Mon, 18 Aug 2025 13:10:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC] net: stmmac: Make DWMAC_ROCKCHIP and DWMAC_STM32
 depend on PM_SLEEP
Message-ID: <4c3b0193-4fa7-47ef-9d61-f060c10d3ed4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7ee6a142-1ed9-4874-83b7-128031e41874@paulmck-laptop>
 <aKN-Tdfvc3_hD2p7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKN-Tdfvc3_hD2p7@shell.armlinux.org.uk>

On Mon, Aug 18, 2025 at 08:26:05PM +0100, Russell King (Oracle) wrote:
> On Mon, Aug 18, 2025 at 12:11:09PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This might be more of a bug report than a patch, but here goes...
> > 
> > Running rcuscale or refscale performance tests on datacenter ARM systems
> > gives the following build errors with CONFIG_HIBERNATION=n:
> > 
> > ERROR: modpost: "stmmac_simple_pm_ops" [drivers/net/ethernet/stmicro/stmmac/dwmac-rk.ko] undefined!
> > ERROR: modpost: "stmmac_simple_pm_ops" [drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.ko] undefined!
> 
> The kernel build bot caught this, and I asked questions of Rafael last
> week and have been waiting for a response that still hasn't come.
> 
> However, there was some discussion over the weekend (argh) on IRC from
> rdd and arnd, but I didn't have time over a weekend (shocking, I know,
> we're supposed to work 24x7 on the kernel, rather than preparing to
> travel to a different location for medical stuff) to really participate
> in that discussion.
> 
> Nevertheless, I do have a patch with my preferred solution - but whether
> that solution is what other people prefer seems to be a subject of
> disagreement according to that which happened on IRC. This affects every
> driver that I converted to use stmmac_simple_pm_ops, which is more than
> you're patching.
> 
> I've been missing around with medical stuff today, which means I also
> haven't had time today to do anything further.
> 
> It's a known problem, but (1) there's been no participation from the
> kernel community to help address it and (2) over the last few days I've
> been busy myself doing stuff related to medical stuff.
> 
> Yea, it's shocking, but it's also real life outside of the realms of
> kernel hacking.

;-) ;-) ;-)

I am happy with whatever solves the problem.  In the meantime, I will
be using my patch in testing to get this failure out of the way of
other bugs.

							Thanx, Paul

