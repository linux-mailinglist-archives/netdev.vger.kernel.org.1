Return-Path: <netdev+bounces-128322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DBF978F8E
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CD31F230DE
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB61CDFD5;
	Sat, 14 Sep 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTPuLtMc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABD1448C5;
	Sat, 14 Sep 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306970; cv=none; b=C3x/bcCyDRDx5U6olJJGvMNZK6NZI20PWlwaMjqyWeKbvyg5udrgC7alluQPsc0Ijp/BUyN89acu1m+fbbZHUNaCFvwmY3YHu02HLXBgWqcgQLiQlbeUoBiC8qHZClkcjuls+ILCJlZvLG0OBMW8At3A0oNb1i4rijsqkTQkDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306970; c=relaxed/simple;
	bh=nFdqN8ZIg9d56NL0UDelISUEoSXmQsSo2jA9nIE+K08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmw8uHi5FCE9J2TdhaWNcZw0YTne8r7EI7KmQrFux24olavUUHTvZd9Bw8aRswPvvepftWv+gdc/CfIJPcrlkuL+7YGREEwkObwWZ4iyYNibscYAPJZkpTLcvzKGJ50wMsQtgQrEWYJgDrNsA1lzEUTtnhG9+o+jcac1QFMKTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTPuLtMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E751C4CEC0;
	Sat, 14 Sep 2024 09:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726306969;
	bh=nFdqN8ZIg9d56NL0UDelISUEoSXmQsSo2jA9nIE+K08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTPuLtMcxIJ6UJQ6YPL+PPzx6chFHXkjTXGCSVE5L6Q6B83OyN19nNUYshONpb4pa
	 uI6/ki1GtGw8r1G5qKqJQ0C1KFm03LPFPNc/OD7pdhahOX2XGxf5pqRNg4dvFz7ddb
	 zQcJdSP66MVeHnyijY5BXTh+t8rZnp82iizIJXqQoixmBpRnq/iMJc0EtRDfR2A2f3
	 8ebriMWS6k/WkGUePHo82DHUHVIE0/uUpIbRU7Jy+iWUgng7Vg3ZG3ClGyEwep9vs8
	 Tzvv4yZxLbRXG02N84X6pks6zLDtBfw+vR6E4igfSLCokKB4ZCV7bn2GsemQaXzh/y
	 2UgtzJOmfqSzw==
Date: Sat, 14 Sep 2024 10:42:44 +0100
From: Simon Horman <horms@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, tuong.t.lien@dektech.com.au,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: tipc: avoid possible garbage value
Message-ID: <20240914094244.GG12935@kernel.org>
References: <20240912110119.2025503-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912110119.2025503-1-suhui@nfschina.com>

On Thu, Sep 12, 2024 at 07:01:20PM +0800, Su Hui wrote:
> Clang static checker (scan-build) warning:
> net/tipc/bcast.c:305:4:
> The expression is an uninitialized value. The computed value will also
> be garbage [core.uninitialized.Assign]
>   305 |                         (*cong_link_cnt)++;
>       |                         ^~~~~~~~~~~~~~~~~~
> 
> tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
> is uninitialized. Although it won't really cause a problem, it's better
> to fix it.
> 
> Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Hi Su Hui,

This looks like a bug fix. If so it should be targeted at net rather than
net-next. If not, the Fixes tag should be dropped, and the commit can be
referenced in the patch description with some other text around:

commit dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing")

> ---
>  net/tipc/bcast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
> index 593846d25214..a3699be6a634 100644
> --- a/net/tipc/bcast.c
> +++ b/net/tipc/bcast.c
> @@ -321,7 +321,7 @@ static int tipc_mcast_send_sync(struct net *net, struct sk_buff *skb,
>  	struct tipc_msg *hdr, *_hdr;
>  	struct sk_buff_head tmpq;
>  	struct sk_buff *_skb;
> -	u16 cong_link_cnt;
> +	u16 cong_link_cnt = 0;
>  	int rc = 0;

I think we should preserve reverse xmas tree order - longest like to
shortest - for these local variable declarations.

>  
>  	/* Is a cluster supporting with new capabilities ? */
> -- 
> 2.30.2
> 
> 

