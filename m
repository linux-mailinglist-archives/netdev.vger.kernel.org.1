Return-Path: <netdev+bounces-123481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2726965083
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D001F2672C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BAD1BA288;
	Thu, 29 Aug 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzfEkHgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA201494A7
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962264; cv=none; b=c+LCwacofcoDJmFkF0ntvPaMkDA+NZQj85WFRaXT3lVF7W+MuYhj1HGMr/KMtXUxS7ifFfwazSFIQTkSEI5wjwLvtNZQ8BNBnqypbsqsqq9f8fqWrAM+nUfgP43PJu2L/LPPyFqIEOzj/8cm6ipoQm2OGhF4GamErej6Ztw0+Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962264; c=relaxed/simple;
	bh=qAm0d34zoB1eJ0WQ0I6/LSz+1p9fX/OXAZI/p13/NUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru1w7GBSvDVSjX0iWY0JuBY9EPN1ylePdasAY249tMwwchuVPzaRn9tfHjKtF5VdsesCLZR6vZkG7rDC+M1FEsr5pzXa0cWg7j5e3eTa0/f8M9oOOh5wkW833ZAJH/O3g+eQ1IWw7MTgpZ9mI6a2pKeFiTx1vv85MCn0IGTCfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzfEkHgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2C8C4CEC1;
	Thu, 29 Aug 2024 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724962264;
	bh=qAm0d34zoB1eJ0WQ0I6/LSz+1p9fX/OXAZI/p13/NUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzfEkHgjwQnvPyTHgehSEv60nTXIM64OP7ozdcvZaZkH8G2bEFaWriXeAkLKbU3k3
	 /+RkJxrqPCdoHU5orOabxlmGiVMuNGLbLEt7f+mNe2ndA56reYuAeB7BWND131u604
	 qHfNheYpbxGKmC6nWCNsi8aXnL7hBnY59q8AuDoP3J2LrwYqT/4/R6cyw4a1Tg4tRn
	 pDtUQkVDpKTgiAMxEKNzaYbKs9s4LnbOWi4qFQvwYlNsM6Hv3p5JqEp30XEhJdlEff
	 oQaK06q3qnHBPhfudsRfPJv91oOK354RxwI2Ljv5J2r4J7CGieAS77o8hybhaovlP4
	 eNEhQIMOE0VFQ==
Date: Thu, 29 Aug 2024 21:11:00 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>,
	Keyu Man <keyu.man@email.ucr.edu>,
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/3]  icmp: avoid possible side-channels
 attacks
Message-ID: <20240829201100.GY1368797@kernel.org>
References: <20240829144641.3880376-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829144641.3880376-1-edumazet@google.com>

On Thu, Aug 29, 2024 at 02:46:38PM +0000, Eric Dumazet wrote:
> Keyu Man reminded us that linux ICMP rate limiting was still allowing
> side-channels attacks.
> 
> Quoting the fine document [1]:
> 
> 4.4 Private Source Port Scan Method
> ...
>  We can then use the same global ICMP rate limit as a side
>  channel to infer if such an ICMP message has been triggered. At
>  first glance, this method can work but at a low speed of one port
>  per second, due to the per-IP rate limit on ICMP messages.
>  Surprisingly, after we analyze the source code of the ICMP rate
>  limit implementation, we find that the global rate limit is checked
>  prior to the per-IP rate limit. This means that even if the per-IP
>  rate limit may eventually determine that no ICMP reply should be
>  sent, a packet is still subjected to the global rate limit check and one
>  token is deducted. Ironically, such a decision is consciously made
>  by Linux developers to avoid invoking the expensive check of the
>  per-IP rate limit [ 22], involving a search process to locate the per-IP
>  data structure.
>  This effectively means that the per-IP rate limit can be disre-
>  garded for the purpose of our side channel based scan, as it only
>  determines if the final ICMP reply is generated but has nothing to
>  do with the global rate limit counter decrement. As a result, we can
>  continue to use roughly the same scan method as efficient as before,
>  achieving 1,000 ports per second
> ...
> 
> This series :
> 
> 1) Changes the order of the two rate limiters to fix the issue.
> 
> 2-3) Make the 'host-wide' rate limiter a per-netns one.
> 
> [1]
> Link: https://dl.acm.org/doi/pdf/10.1145/3372297.3417280
> 
> v2: added kerneldoc changes for icmp_global_allow() (Simon)

Thanks for the update; confirming that part looks good to me.

