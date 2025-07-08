Return-Path: <netdev+bounces-205185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C1AFDBC1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DC216F930
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00021D3CC;
	Tue,  8 Jul 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K2KfR0uF"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEF33086
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016588; cv=none; b=UvfM4BDooCC6HnjHF1228sYiJ5kiQF3YxOOiLoVecDq6l1+C2ZvcLO+zJ8yACNDrHMP5jt4CSrYiKrcV3IJ2AFXUOrCMvwWfuADQJN3KjRjwBby7be8XAMU+tQBWg2eWSFOzMlIXSxj6bvcuDG/prCa7pD1Y7wZl1RFwtemaAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016588; c=relaxed/simple;
	bh=81XBgthguk7KPUOGdMRA1riD7Wwb5bo1f0NySYWsfBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ+Bm3gWmGohxiQyR32WdswBTwXQHFA9cO5Vybk0lJaRY94EjrbIuSDHrlvk45BTx2eRnD+lOyzDgOEgFl3nf7fUBqVJ51GY4MHXB7o97zBZeQzrX1p8OwI1X6kTiCLfiwnpENVduUULacJzStPyfV7CnR0H1C5gglMrCw4eeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K2KfR0uF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88507f09-b422-4991-90a8-1b8cedc07d86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752016584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVimyiAtXL5+/IMzzh5RgQWOCFeSz63JM21NoY0yOgE=;
	b=K2KfR0uFYToEQV9P3TjuXtBV6BoUFGKviix0lhhEyNy61hdYr0zIszeulEPjk7QKKSIQvE
	EU21xM/MIm3DmBvqJq/i/wloBKcdNi2JnXJxuBH09fA/69OXWUfx7xaIFJxzfbgfX7DQ+k
	CFfredtC1RVLh8Uvp5Lvgblx1AdMteU=
Date: Tue, 8 Jul 2025 16:16:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 02/12] bpf: tcp: Make sure iter->batch always
 contains a full bucket snapshot
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-3-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250707155102.672692-3-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/25 8:50 AM, Jordan Rife wrote:
>   static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
> -						 struct sock *start_sk)
> +						 struct sock **start_sk)
>   {
> -	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
>   	struct bpf_tcp_iter_state *iter = seq->private;
> -	struct tcp_iter_state *st = &iter->state;
>   	struct hlist_nulls_node *node;
>   	unsigned int expected = 1;
>   	struct sock *sk;
>   
> -	sock_hold(start_sk);
> -	iter->batch[iter->end_sk++] = start_sk;
> +	sock_hold(*start_sk);
> +	iter->batch[iter->end_sk++] = *start_sk;
>   
> -	sk = sk_nulls_next(start_sk);
> +	sk = sk_nulls_next(*start_sk);
> +	*start_sk = NULL;
>   	sk_nulls_for_each_from(sk, node) {
>   		if (seq_sk_match(seq, sk)) {
>   			if (iter->end_sk < iter->max_sk) {
>   				sock_hold(sk);
>   				iter->batch[iter->end_sk++] = sk;
> +			} else if (!*start_sk) {
> +				/* Remember where we left off. */
> +				*start_sk = sk;
>   			}
>   			expected++;
>   		}
>   	}
> -	spin_unlock(&hinfo->lhash2[st->bucket].lock);
>   
>   	return expected;
>   }
>   

[ ... ]

>   static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
>   {
>   	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
>   	struct bpf_tcp_iter_state *iter = seq->private;
>   	struct tcp_iter_state *st = &iter->state;
>   	unsigned int expected;
> -	bool resized = false;
>   	struct sock *sk;
> +	int err;
>   
>   	/* The st->bucket is done.  Directly advance to the next
>   	 * bucket instead of having the tcp_seek_last_pos() to skip
> @@ -3145,33 +3171,52 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
>   		}
>   	}
>   
> -again:
> -	/* Get a new batch */
>   	iter->cur_sk = 0;
>   	iter->end_sk = 0;
> -	iter->st_bucket_done = false;
> +	iter->st_bucket_done = true;
>   
>   	sk = tcp_seek_last_pos(seq);
>   	if (!sk)
>   		return NULL; /* Done */
>   
> -	if (st->state == TCP_SEQ_STATE_LISTENING)
> -		expected = bpf_iter_tcp_listening_batch(seq, sk);
> -	else
> -		expected = bpf_iter_tcp_established_batch(seq, sk);
> +	expected = bpf_iter_fill_batch(seq, &sk);
> +	if (likely(iter->end_sk == expected))
> +		goto done;
>   
> -	if (iter->end_sk == expected) {
> -		iter->st_bucket_done = true;
> -		return sk;
> -	}
> +	/* Batch size was too small. */
> +	bpf_iter_tcp_unlock_bucket(seq);
> +	bpf_iter_tcp_put_batch(iter);
> +	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
> +					 GFP_USER);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +
> +	sk = tcp_seek_last_pos(seq);
> +	if (!sk)
> +		return NULL; /* Done */
> +
> +	expected = bpf_iter_fill_batch(seq, &sk);

A nit.

The next start_sk is stored in &sk. It took me a while to see through how it is 
useful such that it needs the new "struct sock **start_sk" argument.

> +	if (likely(iter->end_sk == expected))
> +		goto done;
>   
> -	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
> -						    GFP_USER)) {
> -		resized = true;
> -		goto again;
> +	/* Batch size was still too small. Hold onto the lock while we try
> +	 * again with a larger batch to make sure the current bucket's size
> +	 * does not change in the meantime.
> +	 */
> +	err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
> +	if (err) {
> +		bpf_iter_tcp_unlock_bucket(seq);
> +		return ERR_PTR(err);
>   	}
>   
> -	return sk;
> +	expected = bpf_iter_fill_batch(seq, &sk);

iiuc, the stored "&sk" is only useful in this special GFP_NOWAIT case.

How about directly figuring out the next start_sk here?
The next start_sk should be the sk_nulls_next() of the
iter->batch[iter->end_sk - 1]?

> +done:
> +	WARN_ON_ONCE(iter->end_sk != expected);

nit. I would move this WARN_ON_ONCE before the "done:" label. It seems to make 
sense only for the GFP_NOWAIT case.

> +	bpf_iter_tcp_unlock_bucket(seq);
> +	return iter->batch[0];
>   }
>   
>   static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)


