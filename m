Return-Path: <netdev+bounces-193177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D17AC2BF2
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A9D4A80D9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A58B20B207;
	Fri, 23 May 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QH+a3TyB"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA411FF1CE
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041526; cv=none; b=W8rya8Mv/rhITjtoaudyTR95LjOwBxAERN96uryUph0QoDJJkQwYE1FmMMASRvLxvdOrhwTHAtDBH3iG1UbvVBpKA832JLxjmbo8IgcXq+R6rM61VEXco0g83xjhyJIwmCwigqBiQy6uThlY9yzgJOy36gI2bE34w4TMextDv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041526; c=relaxed/simple;
	bh=n4lVZZyLBM0+qLadDuyfSQBaBJeYC61/p/Xzgf/u1XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bA5Zr+jRxiWu1t0LHs0yZvorx7xsYqvYKMAUUqeoQ90mWrEOBoOCRl2p4KL81P8tL6KZ2VQ91rYOR6tB6goEXalrN5p9x3BRM/YVIblfQm47I1xKionxpvA6L1iDL8bOYKrF2TWLrejkgoeax0cLaHjINw3W0eMWFgjRlAnPWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QH+a3TyB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e350e8b-3192-48e9-a419-ba727a52abee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748041520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIA0wb8u0ZC3RAAVHYbFulzKzwer2HQMWyvXoEhU9tU=;
	b=QH+a3TyBD84BsIoSwzNBZjaozdCWkcK9zHxJE48pO0mVRpNDllG09eCQRmKO5jg5e/F+Xq
	6vhk/vDLOoC73JnnfixDoE+zat5oo8mqAXJYxTFPYNFabrYrT+kBKay0Ds7UvyxwrTVzBF
	ur00ln0KrnWKhTCqrEsrVeyhI/2lTng=
Date: Fri, 23 May 2025 16:05:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 05/10] bpf: tcp: Avoid socket skips and
 repeats during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250520145059.1773738-1-jordan@jrife.io>
 <20250520145059.1773738-6-jordan@jrife.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250520145059.1773738-6-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/20/25 7:50 AM, Jordan Rife wrote:
> Replace the offset-based approach for tracking progress through a bucket
> in the TCP table with one based on socket cookies. Remember the cookies
> of unprocessed sockets from the last batch and use this list to
> pick up where we left off or, in the case that the next socket
> disappears between reads, find the first socket after that point that
> still exists in the bucket and resume from there.
> 
> This approach guarantees that all sockets that existed when iteration
> began and continue to exist throughout will be visited exactly once.
> Sockets that are added to the table during iteration may or may not be
> seen, but if they are they will be seen exactly once.
> 
> Remove the conditional that advances the bucket at the top of
> bpf_iter_tcp_batch, since if iter->cur_sk == iter->end_sk
> bpf_iter_tcp_resume_listening or bpf_iter_tcp_resume_established will
> naturally advance to the next bucket without wasting any time scanning
> through the current bucket.

> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   net/ipv4/tcp_ipv4.c | 141 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 113 insertions(+), 28 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 65569d67d8bf..11531ed4ef3c 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -58,6 +58,7 @@
>   #include <linux/times.h>
>   #include <linux/slab.h>
>   #include <linux/sched.h>
> +#include <linux/sock_diag.h>
>   
>   #include <net/net_namespace.h>
>   #include <net/icmp.h>
> @@ -3016,6 +3017,7 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
>   #ifdef CONFIG_BPF_SYSCALL
>   union bpf_tcp_iter_batch_item {
>   	struct sock *sk;
> +	__u64 cookie;
>   };
>   
>   struct bpf_tcp_iter_state {
> @@ -3046,10 +3048,19 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
>   
>   static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
>   {
> +	union bpf_tcp_iter_batch_item *item;
>   	unsigned int cur_sk = iter->cur_sk;
> +	__u64 cookie;
>   
> -	while (cur_sk < iter->end_sk)
> -		sock_gen_put(iter->batch[cur_sk++].sk);
> +	/* Remember the cookies of the sockets we haven't seen yet, so we can
> +	 * pick up where we left off next time around.
> +	 */
> +	while (cur_sk < iter->end_sk) {
> +		item = &iter->batch[cur_sk++];
> +		cookie = sock_gen_cookie(item->sk);
> +		sock_gen_put(item->sk);
> +		item->cookie = cookie;
> +	}
>   }
>   
>   static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
> @@ -3073,6 +3084,105 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
>   	return 0;
>   }
>   
> +static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
> +					       union bpf_tcp_iter_batch_item *cookies,
> +					       int n_cookies)
> +{
> +	struct hlist_nulls_node *node;
> +	struct sock *sk;
> +	int i;
> +
> +	for (i = 0; i < n_cookies; i++) {
> +		sk = first_sk;
> +		sk_nulls_for_each_from(sk, node) {
> +			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
> +				return sk;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
> +{
> +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +	unsigned int find_cookie = iter->cur_sk;
> +	unsigned int end_cookie = iter->end_sk;
> +	int resume_bucket = st->bucket;
> +	struct sock *sk;
> +
> +	sk = listening_get_first(seq);

Since it does not advance the sk->bucket++ now, it will still scan until the 
first seq_sk_match()?

Does it make sense to advance the st->bucket++ in the bpf_iter_tcp_seq_next and 
bpf_iter_tcp_seq_stop?

> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +
> +	if (sk && st->bucket == resume_bucket && end_cookie) {

If doing st->bucket++ in the next and stop, this probably needs the "&& 
end_cookie - find_cookie" check.

> +		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
> +						end_cookie - find_cookie);
> +		if (!sk) {
> +			spin_unlock(&hinfo->lhash2[st->bucket].lock);
> +			++st->bucket;
> +			sk = listening_get_first(seq);
> +		}
> +	}
> +
> +	return sk;
> +}
> +
> +static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
> +{
> +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +	unsigned int find_cookie = iter->cur_sk;
> +	unsigned int end_cookie = iter->end_sk;
> +	int resume_bucket = st->bucket;
> +	struct sock *sk;
> +
> +	sk = established_get_first(seq);
> +	iter->cur_sk = 0;
> +	iter->end_sk = 0;
> +
> +	if (sk && st->bucket == resume_bucket && end_cookie) {
> +		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
> +						end_cookie - find_cookie);
> +		if (!sk) {
> +			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
> +			++st->bucket;
> +			sk = established_get_first(seq);
> +		}
> +	}
> +
> +	return sk;
> +}
> +
> +static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
> +{
> +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> +	struct bpf_tcp_iter_state *iter = seq->private;
> +	struct tcp_iter_state *st = &iter->state;
> +	struct sock *sk = NULL;
> +
> +	switch (st->state) {
> +	case TCP_SEQ_STATE_LISTENING:
> +		if (st->bucket > hinfo->lhash2_mask)

Understood that this is borrowed from the existing tcp_seek_last_pos().

I wonder if this case would ever be hit. If it is not, may be avoid adding it to 
this new resume function?

> +			break;
> +		sk = bpf_iter_tcp_resume_listening(seq);
> +		if (sk)
> +			break;
> +		st->bucket = 0;
> +		st->state = TCP_SEQ_STATE_ESTABLISHED;
> +		fallthrough;
> +	case TCP_SEQ_STATE_ESTABLISHED:
> +		if (st->bucket > hinfo->ehash_mask)

Same here, and the following established_get_first() should have taken care of 
this case also.

Overall the set makes sense to me. Thanks for making a similar improvement in 
the tcp iter.

I often find the seq_start/next/stop logic a bit tricky. I will need to do 
another look early next week. I also haven't had a chance to look at the tests.


