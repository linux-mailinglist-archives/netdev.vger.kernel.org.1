Return-Path: <netdev+bounces-102755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350990479A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C6F2855A9
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A81509A6;
	Tue, 11 Jun 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m9akb+LJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26C757E5
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147793; cv=none; b=OggBoSS6W040ODDxv7zBUf2wrSAt4HFo9LeY1yycCJTG8/2zJ/B3kOt2M0xr/z5dZ83ep0w73bf8LKIIVdzQwII/ZgwMXFX8VJQ7KY3evNbb5abKoLHpKobV/51ELH4TKuzY8XRkqzz+Mvku2kBJboRVLwyKAmaQzREAEmug4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147793; c=relaxed/simple;
	bh=G0zmzM7rQU3iJTXhNPAkZ/5gVFJS6GixxMotndneHj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLaBZW5c6vUEo/jlMGx2BHq6ISoY4JYHNkwIxeWJmH2NOAoW/QCYYPe1BT66MltLindXwYTgtJ0QEnB1xU32En+4X/rr29r+KaAquaSsAn5a0Abe0ehzdOOdYCGd2WYPKBcHwhB4nYSeePfgpyyduiEJ+M7zhmRWlQwKjjzXZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m9akb+LJ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kuniyu@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718147789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ2cFroggFxgbs91WWbGFKtjFC+wHYZuVOBQdAei9uI=;
	b=m9akb+LJtRscAwWkaWdAjRgATYhz6Cn36Y27UJ1WaTnV2vxJcyxQkD+uipIhsiSBZTsSFm
	amsigOqqnNYhwZJaItCNshiMPFe5ZLI9uR8E9Ofl5jOUF0pwaEGly0GnHXnUw3cmabPUp4
	/LAE8Wu8fgKhA918FpDrdLeLrur0hDc=
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: kuni1840@gmail.com
X-Envelope-To: netdev@vger.kernel.org
Date: Tue, 11 Jun 2024 19:16:25 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 02/11] af_unix: Define locking order for
 U_LOCK_SECOND in unix_state_double_lock().
Message-ID: <bra5lpyerrn7su4cc45q77grgn3ysmx6mz3hghiclktq6zf6rf@smpb3wdqzjqt>
References: <20240611222905.34695-1-kuniyu@amazon.com>
 <20240611222905.34695-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611222905.34695-3-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 03:28:56PM GMT, Kuniyuki Iwashima wrote:
> unix_dgram_connect() and unix_dgram_{send,recv}msg() lock the socket
> and peer in ascending order of the socket address.
> 
> Let's define the order as unix_state_lock_cmp_fn() instead of using
> unix_state_lock_nested().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  net/unix/af_unix.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 22bb941f174e..c09bf2b03582 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -134,6 +134,18 @@ static int unix_table_lock_cmp_fn(const struct lockdep_map *a,
>  {
>  	return cmp_ptr(a, b);
>  }
> +
> +static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
> +				  const struct lockdep_map *_b)
> +{
> +	const struct unix_sock *a, *b;
> +
> +	a = container_of(_a, struct unix_sock, lock.dep_map);
> +	b = container_of(_b, struct unix_sock, lock.dep_map);
> +
> +	/* unix_state_double_lock(): ascending address order. */
> +	return cmp_ptr(a, b);
> +}
>  #endif
>  
>  static unsigned int unix_unbound_hash(struct sock *sk)
> @@ -987,6 +999,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
>  	u->path.dentry = NULL;
>  	u->path.mnt = NULL;
>  	spin_lock_init(&u->lock);
> +	lock_set_cmp_fn(&u->lock, unix_state_lock_cmp_fn, NULL);
>  	mutex_init(&u->iolock); /* single task reading lock */
>  	mutex_init(&u->bindlock); /* single task binding lock */
>  	init_waitqueue_head(&u->peer_wait);
> @@ -1335,11 +1348,12 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
>  		unix_state_lock(sk1);
>  		return;
>  	}
> +
>  	if (sk1 > sk2)
>  		swap(sk1, sk2);
>  
>  	unix_state_lock(sk1);
> -	unix_state_lock_nested(sk2, U_LOCK_SECOND);
> +	unix_state_lock(sk2);
>  }
>  
>  static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
> -- 
> 2.30.2
> 

