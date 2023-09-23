Return-Path: <netdev+bounces-35941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6BF7AC0FB
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 66218282041
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BBF10A3C;
	Sat, 23 Sep 2023 11:09:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B010A14
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 11:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CBBC433CA;
	Sat, 23 Sep 2023 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695467354;
	bh=YGFnrFG1GorO4OohL+Jdb/NA1+/vyKkeiFZgrD/OzQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jxhy7hMTy1gEFkZf8KUimp9bCEqcHvCAChDr3QhEyGQ4TQFjcmG63TXnPaO2FqFVP
	 KRirNo9PzmP3UxHN8vtvyi7IbboYEiBudgAwSDLtNvDAiSnFDkx6BKAxHxSTtYU2OS
	 PGbjo4VPBNx4KoFxi53aa0XN+YzO0GClrbwlLGnLoMotco0dehHtyQ09HLmM3bAnqJ
	 D/axTbxfU5XLrbsm9PDqVg9yiF8j9TqyeENrJxeHpFMlGIHR7TaqGELptABmWIJK3/
	 fNbfHVQpJ/qelnvuDGbb3peEO/H3flMAj091V7Qp2YUfqUzonuXTXW4q3trQyjPO25
	 Xia/6Tica0PSg==
Message-ID: <e7a1d01a-6607-fa6f-33f8-db31a3fb75a8@kernel.org>
Date: Sat, 23 Sep 2023 13:07:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/4] tcp_metrics: optimize
 tcp_metrics_flush_all()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230922220356.3739090-1-edumazet@google.com>
 <20230922220356.3739090-5-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230922220356.3739090-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/23 4:03 PM, Eric Dumazet wrote:
> This is inspired by several syzbot reports where
> tcp_metrics_flush_all() was seen in the traces.
> 
> We can avoid acquiring tcp_metrics_lock for empty buckets,
> and we should add one cond_resched() to break potential long loops.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index 7aca12c59c18483f42276d01252ed0fac326e5d8..c2a925538542b5d787596b7d76705dda86cf48d8 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -898,11 +898,13 @@ static void tcp_metrics_flush_all(struct net *net)
>  	unsigned int row;
>  
>  	for (row = 0; row < max_rows; row++, hb++) {
> -		struct tcp_metrics_block __rcu **pp;
> +		struct tcp_metrics_block __rcu **pp = &hb->chain;
>  		bool match;
>  
> +		if (!rcu_access_pointer(*pp))
> +			continue;
> +
>  		spin_lock_bh(&tcp_metrics_lock);
> -		pp = &hb->chain;
>  		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
>  			match = net ? net_eq(tm_net(tm), net) :
>  				!refcount_read(&tm_net(tm)->ns.count);
> @@ -914,6 +916,7 @@ static void tcp_metrics_flush_all(struct net *net)
>  			}
>  		}
>  		spin_unlock_bh(&tcp_metrics_lock);
> +		cond_resched();

I have found cond_resched() can occur some unnecessary overhead if
called too often. Wrap in `if (need_resched)`?


Reviewed-by: David Ahern <dsahern@kernel.org>


