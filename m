Return-Path: <netdev+bounces-102381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF9902BDB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F9C1F22765
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBF1509A0;
	Mon, 10 Jun 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ms1dOZxi"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FC150981
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059431; cv=none; b=GH5hSBFwEfP25zZi0PeTHInO+9vWm8AeduKoyJY+pWixflbDj5rQthYNLftWO7Qtaj2b3kX59CWV/llkIbIdX54PVfNM07o3RXrs40YS+uhNI+qwtSIAxLk8v2JnCKSipGMBRLKFseE/tu4Tqyf+SElqq4v0OWhClIdgxznm6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059431; c=relaxed/simple;
	bh=ixHL2SRA+tL/zkD6qhBPj+qNUqk/nPNUyio2/47D69s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvxnZXSQGT4afsFpE6cL4wOFOdQe7XFXZhXKTvNVO/9xxqdZ1EEAfuRk35YbKnU1nOTTYjCSJMVRGB7Q/QsJXGkyuKhEXFx7M1lsj8mACfE0LuwTB2yMLWt/Y65GcvKR8VcuPugOMy48pF9cDJ1OIwVf7C88gTloepgseZ81Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ms1dOZxi; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuniyu@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718059428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qu2mneNgF4T3aEJgWNGcS52dseibHIsV+TcyHzQKw1c=;
	b=ms1dOZxi4R6DSr6AYT9mvAfp5jtMwMqxkEWsaAtkloahrdXlmLXsPSYL0RFOutI0NyCzi+
	isgVJtUvWyL3BgQp18HZuZWLMB1GDgXU3L9Fm4MmUS6AQn8YsOdN71+zkHoy394jxSPEtc
	fa6jyAZcuC9xE6nETjggvIWHuMDlrwE=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: kuni1840@gmail.com
X-Envelope-To: netdev@vger.kernel.org
Date: Mon, 10 Jun 2024 18:43:44 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 01/11] af_unix: Define locking order for
 unix_table_double_lock().
Message-ID: <c2s2h5hd6obrraim5u7nbqu3wcp5pm5srtf4772qxmrlaugdps@7gjdbcf6v7dx>
References: <20240610223501.73191-1-kuniyu@amazon.com>
 <20240610223501.73191-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610223501.73191-2-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 10, 2024 at 03:34:51PM -0700, Kuniyuki Iwashima wrote:
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
> ---
>  net/unix/af_unix.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3821f8945b1e..b0a9891c0384 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -126,6 +126,13 @@ static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
>   *    hash table is protected with spinlock.
>   *    each socket state is protected by separate spinlock.
>   */
> +#ifdef CONFIG_PROVE_LOCKING
> +static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
> +				  const struct lockdep_map *b)
> +{
> +	return a < b ? -1 : 0;
> +}
> +#endif

This should be a proper comparison function: -1 for less than, 0 for
equal, 1 for greater than.

I've got a cmp_int() macro in bcachefs that does this nicely.

