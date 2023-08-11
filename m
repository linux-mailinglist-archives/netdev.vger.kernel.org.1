Return-Path: <netdev+bounces-26831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F95779284
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E1D281280
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DE29E18;
	Fri, 11 Aug 2023 15:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD263B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA5C433C8;
	Fri, 11 Aug 2023 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691766593;
	bh=9axkFeaCQbRM472uxQ3pcxOAXerBujZrAQKuYSVjw60=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jg06kd3AKoA1hFoe+AXfh41vb2tpfVbaik8JdHFtzV5henhXvD2hgVNv9g8mnwnlL
	 rxDDAvelB3sVjgBkibRW5SsexkyklIlKoqfD0zvX+nvQZA8dahCEsqAri1qoZMfTiF
	 IVe1+ZKO6G1a6zEnyuTmpPwgCxpH26EKVlLPSQQJeBhmvbqoRWE5aBTy06Hk57Nhtx
	 sETxOWh6dk4QiBxndTEB3piSqE+1LLDtQ97XFCsvfVAMvSvLfZVJR1IWiyonKwdMN0
	 kFmBC4mL9OYLA4ZtQjUjMeeTuDq/UV9BRYcHvG75JsrtxtuL8KmqBhJq74TUKjsO9i
	 r2nQL8vlojV9Q==
Message-ID: <c688e30b-8675-75e5-0874-e61398a565f5@kernel.org>
Date: Fri, 11 Aug 2023 09:09:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v6 1/2] net/ipv6: Remove expired routes with a
 separated list of routes.
To: thinker.li@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, kernel-team@meta.com, yhs@meta.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20230808180309.542341-1-thinker.li@gmail.com>
 <20230808180309.542341-2-thinker.li@gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230808180309.542341-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/23 12:03 PM, thinker.li@gmail.com wrote:
> @@ -504,6 +500,49 @@ void fib6_gc_cleanup(void);
>  
>  int fib6_init(void);
>  
> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
> + * NULL.
> + */
> +static inline void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expires)
> +{
> +	struct fib6_table *tb6;
> +
> +	tb6 = f6i->fib6_table;
> +	f6i->expires = expires;
> +	if (tb6 && !fib6_has_expires(f6i))
> +		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
> +	f6i->fib6_flags |= RTF_EXPIRES;
> +}
> +
> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
> + * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
> + * list of GC candidates until it is inserted into a table.
> + */
> +static inline void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
> +{
> +	spin_lock_bh(&f6i->fib6_table->tb6_lock);
> +	fib6_set_expires_locked(f6i, expires);
> +	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
> +}
> +
> +static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
> +{
> +	struct fib6_table *tb6;
> +
> +	tb6 = f6i->fib6_table;
> +	if (tb6 && fib6_has_expires(f6i))
> +		hlist_del_init(&f6i->gc_link);

The tb6 check is not needed; if the fib6_info is on a gc list it should
be removed here.

> +	f6i->fib6_flags &= ~RTF_EXPIRES;
> +	f6i->expires = 0;
> +}
> +
> +static inline void fib6_clean_expires(struct fib6_info *f6i)
> +{
> +	spin_lock_bh(&f6i->fib6_table->tb6_lock);
> +	fib6_clean_expires_locked(f6i);
> +	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
> +}
> +
>  struct ipv6_route_iter {
>  	struct seq_net_private p;
>  	struct fib6_walker w;


> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index bac768d36cc1..8e86b67fe5ef 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -1057,6 +1060,11 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
>  				    lockdep_is_held(&table->tb6_lock));
>  		}
>  	}
> +
> +	if (fib6_has_expires(rt)) {
> +		hlist_del_init(&rt->gc_link);
> +		rt->fib6_flags &= ~RTF_EXPIRES;
> +	}

Use fib6_clean_expires_locked here.

With those 2 changes:
Reviewed-by: David Ahern <dsahern@kernel.org>


--
pw-bot: cr

