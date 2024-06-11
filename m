Return-Path: <netdev+bounces-102756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20A90479C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79D41C23847
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25815530F;
	Tue, 11 Jun 2024 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wg52qg9k"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C591B28A
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147881; cv=none; b=nIpyDvop1tkncCKmH7ph7M73mV8LSA9Xr91rPAwiD1qSRi0KToWKkU/Hf9Q0h0Px6EbsQKa6xKabzY2MbemRb0xuu6gjQCMpou3LRq8NBcK/kFytyfqdeWsN3rI9zcj3n3HaoWyRuSZQWaZiSKC+F0Q8mCdJyZLKz6NfRbV8jFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147881; c=relaxed/simple;
	bh=N+gyJoZMBuS898vuWtDiLXIrgK8sUPHLXYXCeghrxbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6qKz8Wb0mffEWN7594yaf5fz6fK3Lvvu8BxCUnR9oMjEejLK6UEdgZN7VTOC/YDAGUXnHU/eRrPqcIwxno3dLhjUL4IN8B0pPEyVlwPocCclsW0mhI/Utm4ZpCu+J/XQOGAw5ZuuCJYXlZt3NCPwkgkovlDPKCKnywmTB90m/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wg52qg9k; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuniyu@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718147877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNpjCwKLehiw9EHl6I8kO0YzbqBvqZscIuNWkcZyKSc=;
	b=wg52qg9k5alDJDg9CdVj5np614llyLdTcFH12m+/bnZqmvLiJ6bAyTG7vZCrbC1Og1MWcj
	2myS1jo+jtKGC3szdJq61uKP5ivGMbP9uh8vXgdFVasDTi8FLinAvtpztyVaVT3sA8Azh5
	GLZmQAkY8UlAtxtm2xnJ6bV4Qcql78w=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: kuni1840@gmail.com
X-Envelope-To: netdev@vger.kernel.org
Date: Tue, 11 Jun 2024 19:17:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 08/11] af_unix: Define locking order for
 U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
Message-ID: <vqp2bzsg2sr6iol4sfbay27trj2gss663yroygrhb6lolmsbqn@sqw732yecjsn>
References: <20240611222905.34695-1-kuniyu@amazon.com>
 <20240611222905.34695-9-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611222905.34695-9-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 03:29:02PM GMT, Kuniyuki Iwashima wrote:
> While GC is cleaning up cyclic references by SCM_RIGHTS,
> unix_collect_skb() collects skb in the socket's recvq.
> 
> If the socket is TCP_LISTEN, we need to collect skb in the
> embryo's queue.  Then, both the listener's recvq lock and
> the embroy's one are held.
> 
> The locking is always done in the listener -> embryo order.
> 
> Let's define it as unix_recvq_lock_cmp_fn() instead of using
> spin_lock_nested().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 17 +++++++++++++++++
>  net/unix/garbage.c |  8 +-------
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 8d03c5ef61df..8959ee8753d1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -170,6 +170,21 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
>  	/* unix_state_double_lock(): ascending address order. */
>  	return cmp_ptr(a, b);
>  }
> +
> +static int unix_recvq_lock_cmp_fn(const struct lockdep_map *_a,
> +				  const struct lockdep_map *_b)
> +{
> +	const struct sock *a, *b;
> +
> +	a = container_of(_a, struct sock, sk_receive_queue.lock.dep_map);
> +	b = container_of(_b, struct sock, sk_receive_queue.lock.dep_map);
> +
> +	/* unix_collect_skb(): listener -> embryo order. */
> +	if (a->sk_state == TCP_LISTEN && unix_sk(b)->listener == a)
> +		return -1;
> +
> +	return 0;
> +}
>  #endif

That's not symmetric.

