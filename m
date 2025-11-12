Return-Path: <netdev+bounces-237824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062AFC509BE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEE43B2D33
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19492D0C7D;
	Wed, 12 Nov 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r8cv2ohz"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ABD15D1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925013; cv=none; b=lhhOHIa72PKEeo9UYctXC0NFbo/2UH+Ixf8ZXaXrr+nLnuNJ6JeXZIiLirV5mJ3IC0PPH8dLQO5v6r5Vsr7beXDOmbWFwuNU76/Igv+faetId6wzS32LCb4WQTRiCE/p86ntHVqFYH2NHNTwKwhdKuEotQNb5u+Fo/SdIsFmEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925013; c=relaxed/simple;
	bh=iFe4eN+GGjVJM3R8ZJzHpxXb8xip+1blhqvRxkid3o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nourw5J/NoDm5on8wa3gNZimRarnDWQMQVjbnacRk4gYAH0KnMwdu/wvR8a08imIJCO5vh5EUTEK2EN+hvNyy5Cw7owFNaR8gHzzCb5LKCjQbzR9XZEr9RcgPdVSWhDoeYnJHTdVeNNEWDFJplFhn01O4l/9M5FqXBL4D6J0XXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r8cv2ohz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 3AADE201334C; Tue, 11 Nov 2025 21:23:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AADE201334C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762925012;
	bh=WyksDat+1K+APdMFDc8CrnDGGQ2pVvvBuHeAGHioQ9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8cv2ohzI6criVrEFuAbeihbM9M0OgJoGHebhwjJj+anV8IYQ2XsRIZgYGJ22NZFo
	 anWE3XqcyOwCk46vWGNbe1lkyf7WG8yLCzBQkxhR3UX6DiJO0Xb1DfZRYKd+cTayDq
	 r3r5W/Q6tYk+AVu2HA73Zgcd3Tawe8ogmhsA7NUM=
Date: Tue, 11 Nov 2025 21:23:32 -0800
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, ssengar@linux.microsoft.com,
	gargaditya@microsoft.com
Subject: Re: [PATCH net-next] net: clear skb->sk in skb_release_head_state()
Message-ID: <20251112052332.GA7608@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251111151235.1903659-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111151235.1903659-1-edumazet@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Nov 11, 2025 at 03:12:35PM +0000, Eric Dumazet wrote:
> skb_release_head_state() inlines skb_orphan().
> 
> We need to clear skb->sk otherwise we can freeze TCP flows
> on a mostly idle host, because skb_fclone_busy() would
> return true as long as the packet is not yet processed by
> skb_defer_free_flush().
> 
> Fixes: 1fcf572211da ("net: allow skb_release_head_state() to be called multiple times")
> Fixes: e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/skbuff.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 4f4d7ab7057f16bcf88f29827a45a9f4a8f43d5c..f34372666e67cee5329d3ba1d3c86f8622facac3 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1152,6 +1152,7 @@ void skb_release_head_state(struct sk_buff *skb)
>  
>  #endif
>  		skb->destructor = NULL;
> +		skb->sk = NULL;
>  	}
>  	nf_reset_ct(skb);
>  	skb_ext_reset(skb);
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
>

Tested-by: Aditya Garg <gargaditya@linux.microsoft.com> 

