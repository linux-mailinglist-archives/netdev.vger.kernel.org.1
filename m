Return-Path: <netdev+bounces-102401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D544902C9B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570181C20D2D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE47152516;
	Mon, 10 Jun 2024 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vesQGhqS"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F343BB48
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063438; cv=none; b=dKv9AaP4g1wCf6UPHgymoEKl23jiT5aTm02J/v9HtmrlvGSYf2xCqL9yyBke+wtoSqV9mQQ9/cPJF+B2Qobj6ids5V9fCnQJ+EOhhQKJGxgXSVa6NS+Llvp/JQIDl1Q0ILzZG9oWQdKDGMHMANnx6T7odAJXNZPVUay64WdzOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063438; c=relaxed/simple;
	bh=ILdg0u9UWuQQQXcW5FvpLmRj7o9XEUtLBDz/P8Kh5hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjnZAdGba/+Q2rZfnxutzG5J5n/523yJmRri8GHmW4mf/T3LJQtDDyUvMfs9sXD82YoIbPKwzk0YHQBmVOoLDclsgVzrCJqehhsJfdpctP4yF2LZT+QI5bljTqeBY+0WAzJIZ1K3gQ5LrNMRmPNvC+pIMJwe98UKfsZ89zcq+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vesQGhqS; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuniyu@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718063432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+N1qaolq83lhcv/BNokpWPX1kfD/DZhYHmypqeKK88=;
	b=vesQGhqSNrqAywPg48Ih+nFI4zujyMstBgqp6JFhxr3W/xfm2+29yfkwokTDPf7yMJ9z6T
	earf1HN0WhEU/2rjoo4CrOaReIgZ1oOmOL9E6qm04LNzIUfiJfDpUbYDkvBYljLwRaSZBN
	vYTd2muCAG6X7j9fS2ezxRjFDfGo/t8=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: kuni1840@gmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: pabeni@redhat.com
Date: Mon, 10 Jun 2024 19:50:27 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v1 net-next 01/11] af_unix: Define locking order for
 unix_table_double_lock().
Message-ID: <3vjpisr5vw5cts5h2wrtcqttgweyidtyjw5vgslhimtvy2oobu@b4hgsefmsmwj>
References: <c2s2h5hd6obrraim5u7nbqu3wcp5pm5srtf4772qxmrlaugdps@7gjdbcf6v7dx>
 <20240610233857.78697-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610233857.78697-1-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 10, 2024 at 04:38:57PM -0700, Kuniyuki Iwashima wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Mon, 10 Jun 2024 18:43:44 -0400
> > On Mon, Jun 10, 2024 at 03:34:51PM -0700, Kuniyuki Iwashima wrote:
> > > When created, AF_UNIX socket is put into net->unx.table.buckets[],
> > > and the hash is stored in sk->sk_hash.
> > > 
> > >   * unbound socket  : 0 <= sk_hash <= UNIX_HASH_MOD
> > > 
> > > When bind() is called, the socket could be moved to another bucket.
> > > 
> > >   * pathname socket : 0 <= sk_hash <= UNIX_HASH_MOD
> > >   * abstract socket : UNIX_HASH_MOD + 1 <= sk_hash <= UNIX_HASH_MOD * 2 + 1
> > > 
> > > Then, we call unix_table_double_lock() which locks a single bucket
> > > or two.
> > > 
> > > Let's define the order as unix_table_lock_cmp_fn() instead of using
> > > spin_lock_nested().
> > > 
> > > The locking is always done in ascending order of sk->sk_hash, which
> > > is the index of buckets/locks array allocated by kvmalloc_array().
> > > 
> > >   sk_hash_A < sk_hash_B
> > >   <=> &locks[sk_hash_A].dep_map < &locks[sk_hash_B].dep_map
> > > 
> > > So, the relation of two sk->sk_hash can be derived from the addresses
> > > of dep_map in the array of locks.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/af_unix.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 3821f8945b1e..b0a9891c0384 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -126,6 +126,13 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
> > >   *    hash table is protected with spinlock.
> > >   *    each socket state is protected by separate spinlock.
> > >   */
> > > +#ifdef CONFIG_PROVE_LOCKING
> > > +static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
> > > +				  const struct lockdep_map *b)
> > > +{
> > > +	return a < b ? -1 : 0;
> > > +}
> > > +#endif
> > 
> > This should be a proper comparison function: -1 for less than, 0 for
> > equal, 1 for greater than.
> > 
> > I've got a cmp_int() macro in bcachefs that does this nicely.
> 
> So, should this be :
> 
>   a < b ? -1 : 1
> 
> ?
> 
> or
> 
>   ((a > b) - (b < a))
> 
> ?
> 
> I think most double_lock functions eliminate the a == b case beforehand,
> and even ->cmp_fn() is not called for such a recursive case because
> debug_spin_lock_before() triggers BUG() then.
> 
> Initially I added the same macro, but checkpatch complains about it,
> and I thought the current form is easier to understand because it's
> the actual comparison used in the double lock part.
> 
> Also, there is a case, where we just want to return an error without
> classifying it into 0 or 1.
> 
> I rather think we should define something like this on the lockdep side.
> 
>   enum lockdep_cmp_result {
>     LOCKDEP_CMP_SAFE = -1,
>     LOCKDEP_CMP_DEADLOCK,
>   };
> 
> What do you think ?

No, we're defining an ordering, there's no need for an enum - this
should work exactly the same as a comparison function that you pass to
sort().

Comparison functions are no place to get fancy, they should be as
standard as possible: you can get _crazy_ bugs resulting from buggy
comparison functions that don't actually define a total ordering.

