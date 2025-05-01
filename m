Return-Path: <netdev+bounces-187293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C50AA62C5
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 20:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB24C0112
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC5121FF52;
	Thu,  1 May 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ElPsOUq+"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1244C7C
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124122; cv=none; b=Vbdc11GkPUrfjMH2MvfZP14fVbCfIT8ARMNhyEoouU8zc4V7y9vMz1HZ2oROii0s8yKBh0j+22z7roCyRSfXpZPBsXhiARygA4O6RXGJvF5zC/CG+WoN3n3Ax6ntWt1tOeeyjAngFTUXoRx0cREL45ZczdE4oYqHGdz+dWEp0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124122; c=relaxed/simple;
	bh=1TLECa84fP67tqe6uF23a5fKRS/OVXqP1xuReeOk6Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYlgO2eZlRb2BlXIgcC7wKFxVQuBTqjqb9OwCGAuJMowCzOi5SsMb9ykRuU7at7CEFEBbtnlFvgQ0dKdvC+pWTfnKesZSeIxeL9v2PisvOB/AQqU+SPibj1X0dLK3j+rpy9oDyb7aPpao/iP23YzFLLgHTqqFJtzog5+N77kPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ElPsOUq+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4fc1f65c-d950-42a5-b3d2-8e7adfcb4d45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746124116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuGnmrV2rLsvZ0VB6/gtXwq/au4W6KlO1lkop1yPSAQ=;
	b=ElPsOUq+owCecaEXcSgrs9Q+jy9AXZjDO4mrtRLptp7wsLC6VVPBTwg9Jm4/nkOUmasQB5
	DoasM1+fPNB2pcw48CCLaoAYOBfurIfJiUSdSGY80xf75hlWMU1IDmYw+qFv2RdKVr5Two
	kVJ6vAAlGg5+NIKYbZVRvh8WAJDX+SM=
Date: Thu, 1 May 2025 11:28:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 3/7] bpf: udp: Get rid of st_bucket_done
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-4-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250428180036.369192-4-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/28/25 11:00 AM, Jordan Rife wrote:
> Get rid of the st_bucket_done field to simplify UDP iterator state and
> logic. Before, st_bucket_done could be false if bpf_iter_udp_batch
> returned a partial batch; however, with the last patch ("bpf: udp: Make
> sure iter->batch always contains a full bucket snapshot"),
> st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   net/ipv4/udp.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 5fe22f4f43d7..57ac84a77e3d 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -3397,7 +3397,6 @@ struct bpf_udp_iter_state {
>   	unsigned int max_sk;
>   	int offset;
>   	struct sock **batch;
> -	bool st_bucket_done;
>   };
>   
>   static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
> @@ -3418,7 +3417,7 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	resume_offset = iter->offset;
>   
>   	/* The current batch is done, so advance the bucket. */
> -	if (iter->st_bucket_done)
> +	if (iter->cur_sk == iter->end_sk)
>   		state->bucket++;

I think the very first bucket will be skipped.

>   
>   	udptable = udp_get_table_seq(seq, net);
> @@ -3433,7 +3432,6 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	 */
>   	iter->cur_sk = 0;
>   	iter->end_sk = 0;
> -	iter->st_bucket_done = true;
>   	batch_sks = 0;
>   
>   	for (; state->bucket <= udptable->mask; state->bucket++) {
> @@ -3596,8 +3594,10 @@ static int bpf_iter_udp_seq_show(struct seq_file *seq, void *v)
>   
>   static void bpf_iter_udp_put_batch(struct bpf_udp_iter_state *iter)
>   {
> -	while (iter->cur_sk < iter->end_sk)
> -		sock_put(iter->batch[iter->cur_sk++]);
> +	unsigned int cur_sk = iter->cur_sk;
> +
> +	while (cur_sk < iter->end_sk)
> +		sock_put(iter->batch[cur_sk++]);
>   }
>   
>   static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
> @@ -3613,10 +3613,8 @@ static void bpf_iter_udp_seq_stop(struct seq_file *seq, void *v)
>   			(void)udp_prog_seq_show(prog, &meta, v, 0, 0);
>   	}
>   
> -	if (iter->cur_sk < iter->end_sk) {
> +	if (iter->cur_sk < iter->end_sk)
>   		bpf_iter_udp_put_batch(iter);
> -		iter->st_bucket_done = false;
> -	}
>   }
>   
>   static const struct seq_operations bpf_iter_udp_seq_ops = {


