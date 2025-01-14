Return-Path: <netdev+bounces-158134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BDA108D9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA31884028
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75113E3F5;
	Tue, 14 Jan 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnPGRp3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442A13D619;
	Tue, 14 Jan 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864084; cv=none; b=AVwCgd2xPwytt+n4taWBUsHpccMk8xdIbSZQTLta+pk2UK/VcthwUYsGHKgZDU92qHEGH5e9Bsn56Nz7r1hWhvafW6Z2YOzPsIlnoOZH1F+Ad/pnwgCqRMNTm29ddHhwgJgJAMWVixeMhWY/iJEpIlu/u8JOpwNb59Kld0pVo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864084; c=relaxed/simple;
	bh=lVsjLtMr3iTOzVYmXmNqm0j3L/lDg64orY2BEiVHyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/DoNHIxidTbZiDDDeVttBFFZaP6Z9EW9O0Wofdk9AYLyaBpdjW6Gdl6FSQgv1SVeXPpOk8NQEOqjBUMFdIS5FQAPTQp0GBMX+bPqY8CO0EUamERMFmA2bKQiQiVubczATBPK7+8yLkOCqqUSjj1/Mohj8ETyTLaBalYwyfzwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnPGRp3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3DC4CEDD;
	Tue, 14 Jan 2025 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736864083;
	bh=lVsjLtMr3iTOzVYmXmNqm0j3L/lDg64orY2BEiVHyGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnPGRp3ZUaL518G+5mTsSKqMKXuPIvk2Pzod+WD3/vJMHgUcF/t66PSt+CJPgK1G6
	 uUcQyMBgull816sX8XdcMjMEU/GG+6JvPoUu+ChEMjlAoGpssQMe8XChUc63CzmSzh
	 qyxiNXLt1/AHuXo27LqFcLzB+1lnFYWeYkpvSy1jVg32GUvhl2d+nhdOMmzuoU8sa/
	 hF21g/epss+fqa7iUbYjsqY6Vnyk11ghG9zNAvdYVMueC/GVyPlguvwi1ytCnI1Z4c
	 oDpeSxNrWKePmdIW7w4O3UaY6zDf0EBDUL32q6R1i/V170Ay6nG87iLy/Irvz6yazl
	 8ZpYBw8TDPWhw==
Date: Tue, 14 Jan 2025 14:14:39 +0000
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] net: xilinx: axienet: Get coalesce
 parameters from driver state
Message-ID: <20250114141439.GH5497@kernel.org>
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
 <20250110192616.2075055-6-sean.anderson@linux.dev>
 <20250113173910.GF5497@kernel.org>
 <14d13d7e-ef1d-4dcc-bd18-7a6709616678@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d13d7e-ef1d-4dcc-bd18-7a6709616678@linux.dev>

On Mon, Jan 13, 2025 at 12:45:24PM -0500, Sean Anderson wrote:
> Hi Simon,
> 
> On 1/13/25 12:39, Simon Horman wrote:
> > On Fri, Jan 10, 2025 at 02:26:15PM -0500, Sean Anderson wrote:
> >> The cr variables now contain the same values as the control registers
> >> themselves. Extract/calculate the values from the variables instead of
> >> saving the user-specified values. This allows us to remove some
> >> bookeeping, and also lets the user know what the actual coalesce
> >> settings are.
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
> > 
> > Hi Sean,
> > 
> > Unfortunately this series does not appear to apply cleanly to net-next.
> > Which is our CI is currently unable to cope with :(
> > 
> > Please consider rebasing and reposting.
> 
> As noted in the cover letter, this series depends on [1] (now [2]). It
> will apply cleanly without rebasing once that patch is applied. So maybe
> you can re-run the CI at that time.

Thanks Sean,

Sorry that I did miss the dependencies.

Unfortunately we don't have a way to re-run the CI at this time,
so it would probably be best to repost once the dependencies
are present in net-next.

> 
> --Sean
> 
> [1] https://lore.kernel.org/netdev/20250110190726.2057790-1-sean.anderson@linux.dev/
> [2] https://lore.kernel.org/netdev/20250113163001.2335235-1-sean.anderson@linux.dev

...

