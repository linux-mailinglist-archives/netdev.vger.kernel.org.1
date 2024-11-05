Return-Path: <netdev+bounces-141773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C29BC35B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C1C1F22C48
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E942AAF;
	Tue,  5 Nov 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lng5Bh9V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114E33987;
	Tue,  5 Nov 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775033; cv=none; b=RoB4M2kZtyJKr5dIEBo4wsqlLtCDpFMjvcnVF/NE/dBt3bgWH+NODEkcdeLJGN6rIPj6YEQu+wB9blPTheh91WnoLw1sToziw58LE+QbUra0ePLugK6pF5/Mx+1ZM9Tn/Z4BfvzjF/ZYZJJJzMWgEP5cNGs5ZlP36gUtvSsjn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775033; c=relaxed/simple;
	bh=TEvoHLLf7+809rqrhTbFJvPU4jPwqPRuDle/botXGIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8j0xH1FI1U1fytCjXaZm+Sd8I1peT4oC+QmV0pET/HlHnv1MwnrO+V8TGceyeDBzvcik7/V7FRHNfr2Vsc8Viaej3+uCP/ch4gANu5wvSAwqN9aaFgre4YCjNn+nr5Jp2HEJp6ZWX2aJWtCgu9E5VOGY0VmHe7t9liEFA4Ya+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lng5Bh9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1313DC4CECE;
	Tue,  5 Nov 2024 02:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730775032;
	bh=TEvoHLLf7+809rqrhTbFJvPU4jPwqPRuDle/botXGIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lng5Bh9VVX3FtlTQLVPEvXflhQvCL7IEv2vblWOybSFGucXnUCrd2+FyflWfgzlw3
	 /VFFLH+QRvuTaN8VCQ9tLSTGHVSrWOekX8QFbc+RLxYFRTvzUb6FFY4RcVjKfrlKC5
	 NgZrk43+83puY7r/Sa+qPff3CufS0M7esfJVk454pSuS4vVLhpdbuuhAlJ3Y7IsqNz
	 5KmRUZGWR5LsnsJI1w1kIc7ZQVIDqhMROjj+iN+Yk6o3T57P36WZmSoRC2sTh3bN32
	 KHuEfG77nYsmjw6wzO5X/xVOoT/voFmFRACj/KdBFShVc6tPiLL/ssfmBKnE2Csbbk
	 TbzJCYTlPqgRQ==
Date: Mon, 4 Nov 2024 18:50:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: <vigneshr@ti.com>, <grygorii.strashko@ti.com>, <horms@kernel.org>,
 <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix 1 PPS sync
Message-ID: <20241104185031.0c843951@kernel.org>
In-Reply-To: <7c3318f4-a2d4-4cbf-8a93-33c6a8afd6c4@ti.com>
References: <20241028111051.1546143-1-m-malladi@ti.com>
	<20241031185905.610c982f@kernel.org>
	<7c3318f4-a2d4-4cbf-8a93-33c6a8afd6c4@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 16:55:46 +0530 Malladi, Meghana wrote:
> On 11/1/2024 7:29 AM, Jakub Kicinski wrote:
> > On Mon, 28 Oct 2024 16:40:52 +0530 Meghana Malladi wrote:  
> >> The first PPS latch time needs to be calculated by the driver
> >> (in rounded off seconds) and configured as the start time
> >> offset for the cycle. After synchronizing two PTP clocks
> >> running as master/slave, missing this would cause master
> >> and slave to start immediately with some milliseconds
> >> drift which causes the PPS signal to never synchronize with
> >> the PTP master.  
> > 
> > You're reading a 64b value in chunks, is it not possible that it'd wrap
> > in between reads? This can be usually detected by reading high twice and
> > making sure it didn't change.
> > 
> > Please fix or explain in the commit message why this is not a problem..  
> Yes I agree that there might be a wrap if the read isn't atomic. As 
> suggested by Andrew I am currently not using custom read where I can 
> implement the logic you suggested

Right but I think Andrew was commenting on a patch which contained pure
re-implementation of read low / hi with no extra bells or whistles. 

> (reading high twice and making sure if 
> didn't change). Can you share me some references where this logic is 
> implemented in the kernel, so I can directly use that instead of writing 
> custom functions.

I think you need to write a custom one. Example:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/meta/fbnic/fbnic_time.c#n40

