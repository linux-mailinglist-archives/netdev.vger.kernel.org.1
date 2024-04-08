Return-Path: <netdev+bounces-85618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B702589BA07
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A921F21BCD
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954D2C69C;
	Mon,  8 Apr 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8A3C2w8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572F28DDE
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564315; cv=none; b=ttkvvFkvjlXpcHzT4RmNdmDwptRlM70AcOV6WSKaip5g5GR6900cIJXpy/O4YM43DVTLu8upehKQLGSM3pjFiCrATfFJ2MXJLdl7cF6GnsxkYT5jXrXlvo6Dpye8Q/yTBJ6kPPMs0jnbyhX87Ct4PQUqij6okPAjCxDZbMQ1P5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564315; c=relaxed/simple;
	bh=V+IU8LKSCDfm3LUp3bhJMYwdOS7zuyGG+w+em89VaoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMou4pi1428cVJgDsikQxtpOkLtw5USkDB+C5Iu6+G/h3woKA2/EjUqpuqxIbdfKPOgFJ49vqHITL6dPmdyGqMOi/KrQZNbHxfSbhJGfBNYW5GQntx3eZZLSmAbsGnqzbaFO1/K2iXY31Zos4XTiQgocnnGz7S0edAaFPLn3YB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8A3C2w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E1DC433C7;
	Mon,  8 Apr 2024 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712564314;
	bh=V+IU8LKSCDfm3LUp3bhJMYwdOS7zuyGG+w+em89VaoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8A3C2w8fBeKJOxnn0I5z3dQYqgJ+Vh5D/HzBA8ywhBKDzoV6+rTAF+RCOQFRbWgf
	 gMrePG3f4Tg7+kBRI60CZKifNB3Dur/X13q7MYpqRT7u7nMrhyCNqZQaz9mjYrOW3q
	 4A9579JaOUwaZM2iMGsBO1CVfcV0JGMwDKMw6N6utcKX0B49ZzPG2Jui8FzDX/TR5O
	 /FXx7zix+eRN212Ga1BZrc4gvbqqIaAdh/V6btkZJUiWQt+QFGqCDp5HLKC0fiQJlA
	 qLWZZBP95bAWhlxdCavnzHovpY6SkhPni4vrDd7IBaT0G7YjJevXQ7Ff4XuU7QHszI
	 BIhlYlEbRpwFA==
Date: Mon, 8 Apr 2024 09:18:29 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [net-next v2] pfcp: avoid copy warning by simplifing code
Message-ID: <20240408081829.GC26556@kernel.org>
References: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>

On Fri, Apr 05, 2024 at 08:36:05AM +0200, Michal Swiatkowski wrote:
> >From Arnd comments:
> "The memcpy() in the ip_tunnel_info_opts_set() causes
> a string.h fortification warning, with at least gcc-13:
> 
>     In function 'fortify_memcpy_chk',
>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       553 |                         __write_overflow_field(p_size_field, size);"
> 
> It is a false-positivie caused by ambiguity of the union.
> 
> However, as Arnd noticed, copying here is unescessary. The code can be
> simplified to avoid calling ip_tunnel_info_opts_set(), which is doing
> copying, setting flags and options_len.
> 
> Set correct flags and options_len directly on tun_info.
> 
> Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/netdev/701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com/
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

I agree that it's nice to avoid a copy.
But I do wonder where else this pattern may exist.
And if it might be worth introducing a helper for it.

Regardless, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

