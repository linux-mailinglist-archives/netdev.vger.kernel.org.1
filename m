Return-Path: <netdev+bounces-102754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881CF904799
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37910285792
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345B43AC5;
	Tue, 11 Jun 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cYotVNk/"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B31B28A
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147761; cv=none; b=hISf5pW/FxmFkVxoJdVx2026c8pg9ujxueUGG4uKv6GZvJTOsKXl6HRDO7P4TUnV1jMiivO5sk/4572+cEv1qzqMR0f/pS9EIR9/Wc9Iee7m19ll0jaZaF4ryHH3Netnq6XQ+Vk9+0SpwIwHhj4sLQZi2NW2M3ymgZTz/s9s/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147761; c=relaxed/simple;
	bh=aHmon48zIuk8yo1/4ZaVWiDwNIDpI4jDcjVtdd03ueg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeEOT4e0dJToeqZMHuf7H8bfmbZqTg1K48Loi6u0sxKWJn3DZqGUHs7qjvwNPNJ8V2mZJr7ikWFp7WaHJAUBEPgcoPkYBtJaTlp2NF48druLhoLAZfIhFqHYhG9RpP0Z9R3YW+cUUzqlwXEWTWOm5yy+1IST4P4lqH2LS/BOa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cYotVNk/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuniyu@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718147757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJi1ZAo4pABcCEalHi79/szAyfe45wIEXBU2UIhFAes=;
	b=cYotVNk/UbLCDYe9QMEgOShfPPfyMv07nDe8DU2XfOTw732l5U/+9ZQhWShcQimVMI1b87
	9OJ61Tm7FmL7JogkF06aH7wFruhNzKqrOV5DP/EElwa1zGi88HZBm8yoCIaD46Rvcrcknd
	4ZGE22Sd1UTxBk1cvpfMhECkuzIfWEk=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: kuni1840@gmail.com
X-Envelope-To: netdev@vger.kernel.org
Date: Tue, 11 Jun 2024 19:15:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 01/11] af_unix: Define locking order for
 unix_table_double_lock().
Message-ID: <sd4deue52mkpbl37qogkx3hjcqcno2fpq3cv5bdpi3kvpwqwah@pzlwic2kn64o>
References: <20240611222905.34695-1-kuniyu@amazon.com>
 <20240611222905.34695-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611222905.34695-2-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 03:28:55PM GMT, Kuniyuki Iwashima wrote:
> When created, AF_UNIX socket is put into net->unx.table.buckets[],
> and the hash is stored in sk->sk_hash.
> 
>   * unbound socket  : 0 <= sk_hash <= UNIX_HASH_MOD
> 
> When bind() is called, the socket could be moved to another bucket.
> 
>   * pathname socket : 0 <= sk_hash <= UNIX_HASH_MOD
>   * abstract socket : UNIX_HASH_MOD + 1 <= sk_hash <= UNIX_HASH_MOD * 2 + 1
> 
> Then, we call unix_table_double_lock() which locks a single bucket
> or two.
> 
> Let's define the order as unix_table_lock_cmp_fn() instead of using
> spin_lock_nested().
> 
> The locking is always done in ascending order of sk->sk_hash, which
> is the index of buckets/locks array allocated by kvmalloc_array().
> 
>   sk_hash_A < sk_hash_B
>   <=> &locks[sk_hash_A].dep_map < &locks[sk_hash_B].dep_map
> 
> So, the relation of two sk->sk_hash can be derived from the addresses
> of dep_map in the array of locks.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  net/unix/af_unix.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3821f8945b1e..22bb941f174e 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -126,6 +126,15 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
>   *    hash table is protected with spinlock.
>   *    each socket state is protected by separate spinlock.
>   */
> +#ifdef CONFIG_PROVE_LOCKING
> +#define cmp_ptr(l, r)	(((l) > (r)) - ((l) < (r)))
> +
> +static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
> +				  const struct lockdep_map *b)
> +{
> +	return cmp_ptr(a, b);
> +}
> +#endif
>  
>  static unsigned int unix_unbound_hash(struct sock *sk)
>  {
> @@ -168,7 +177,7 @@ static void unix_table_double_lock(struct net *net,
>  		swap(hash1, hash2);
>  
>  	spin_lock(&net->unx.table.locks[hash1]);
> -	spin_lock_nested(&net->unx.table.locks[hash2], SINGLE_DEPTH_NESTING);
> +	spin_lock(&net->unx.table.locks[hash2]);
>  }
>  
>  static void unix_table_double_unlock(struct net *net,
> @@ -3578,6 +3587,7 @@ static int __net_init unix_net_init(struct net *net)
>  
>  	for (i = 0; i < UNIX_HASH_SIZE; i++) {
>  		spin_lock_init(&net->unx.table.locks[i]);
> +		lock_set_cmp_fn(&net->unx.table.locks[i], unix_table_lock_cmp_fn, NULL);
>  		INIT_HLIST_HEAD(&net->unx.table.buckets[i]);
>  	}
>  
> -- 
> 2.30.2
> 

