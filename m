Return-Path: <netdev+bounces-56179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3C80E163
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994521F21BB4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C623A5;
	Tue, 12 Dec 2023 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2r34UJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CD23A0
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19086C433C8;
	Tue, 12 Dec 2023 02:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702347935;
	bh=HZ0/eUetQq0IOy0d81Ka8PJJW5VGeJH77DXy6D4N6NU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2r34UJzz7qeYwv6YFuFrsq04aTNW1TNWSLQ14BGnA2abgndlNc+5K9+0utFKmiFu
	 PyxUZ3jYKHvVKjpavhNsGs3tPdd858wOlEEqjdXWCh+2tv+lh8V2a4lRMWUWclpccy
	 Raxhwt1EeLTAL0C0lIVwjwXuWVxRAvDtsmptJY9siGAvrky38uf6vLbvJK5zMuu8go
	 5n+5WyKxj9++3+vqGgz5NB9zuVlei+4z2Ksd5NLKYWcmTSdOZYabhEYucGrgbG2fdX
	 1W07eFKMRoifbnuOPoeEXqIcbGlN5Dy8nZYxJ+t+0kkeiG4DnFe44kS1i/VGxTWQNa
	 8IQFt4ptd+aqg==
Date: Mon, 11 Dec 2023 18:25:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
Message-ID: <20231211182534.09392034@kernel.org>
In-Reply-To: <20231205205030.3119672-3-victor@mojatatu.com>
References: <20231205205030.3119672-1-victor@mojatatu.com>
	<20231205205030.3119672-3-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Dec 2023 17:50:29 -0300 Victor Nogueira wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4b84b72ebae8..f38c928a34aa 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3753,6 +3753,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
>  
>  	qdisc_calculate_pkt_len(skb, q);
>  
> +	tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> +
>  	if (q->flags & TCQ_F_NOLOCK) {
>  		if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
>  		    qdisc_run_begin(q)) {
> @@ -3782,7 +3784,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
>  no_lock_out:
>  		if (unlikely(to_free))
>  			kfree_skb_list_reason(to_free,
> -					      SKB_DROP_REASON_QDISC_DROP);
> +					      tcf_get_drop_reason(to_free));
>  		return rc;
>  	}
>  
> @@ -3837,7 +3839,8 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
>  	}
>  	spin_unlock(root_lock);
>  	if (unlikely(to_free))
> -		kfree_skb_list_reason(to_free, SKB_DROP_REASON_QDISC_DROP);
> +		kfree_skb_list_reason(to_free,
> +				      tcf_get_drop_reason(to_free));

You stuff the drop reason into every skb but then only use the one from
the head? Herm. __qdisc_drop() only uses the next pointer can't we
overload the prev pointer to carry the drop reason. That means only
storing it if we already plan to drop the packet.

BTW I lack TC knowledge but struct tc_skb_cb is even more clsact
specific today than tcf_result. And reserving space for drop reason
in a state structure seems odd. Maybe that's just me.

