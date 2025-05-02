Return-Path: <netdev+bounces-187534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED9AA7B5D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57429A0E9A
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 21:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9E1F473A;
	Fri,  2 May 2025 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vtMEVTZD"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561A376
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221353; cv=none; b=Ig89FHvAWF8cxW+WHgEOJl9cEPG0Pgdqy+aeKNoI7lUhe/9QdgzEWuq03R/cW/v8qH/6VV0/28o8DnCnYnwnxUPpGlb51CPhOd9kdDr8XbV7tzRFq7bfhoDecoiB2j+DYB+WcgDvcfgVMn8fD1MulxBQ/V6fNQ2qqyBB6Y5phGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221353; c=relaxed/simple;
	bh=PZgYDufMY+jvzsidTEwrW0spRw9hJQX+FATyPYtpefQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikjmVnRezJRgk/j+6ZBvgwv0hXYBg5m7W+HDgdfo+7qZC5/l+1ihXC0rX7wmOvYtGUqxHVbdnxuatjJhYFBqnkWQtfeh2csy9F3WywQXZFOkWzZWj642MnYuKLBxYV19+Xp9QhUEEu9SBjn6XVjHHgiHoifj0fZ+Y3YiM5Nrdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vtMEVTZD; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1aff3b57-d125-4ca4-b56a-e47ff1de6094@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746221348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y/KcTWKQvHwcO912E6Fo9633dWVKvc9p1szhXjF09I=;
	b=vtMEVTZDhef1vthBTOzMhT+cmdghWOhcATZ4awfds/5q5sfme82KhIK+tIYJQ96oNZg5+q
	kXqGOznfnrvSvWuiRsARYVfKJHeMv4T91zMGCX1ARZcWE0Gc61D6xbctm+mhvtUZgjaxx8
	8G2gMMFYT+/AM6EIu6j5W6NfrEuQCIg=
Date: Fri, 2 May 2025 14:29:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 5/7] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250502161528.264630-1-jordan@jrife.io>
 <20250502161528.264630-6-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250502161528.264630-6-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/2/25 9:15 AM, Jordan Rife wrote:
>   static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   {
>   	struct bpf_udp_iter_state *iter = seq->private;
>   	struct udp_iter_state *state = &iter->state;
> +	unsigned int find_cookie, end_cookie = 0;

A nit. I removed the zero initialization in the "end_cookie". Like 
"find_cookie", both of them will be initialized by iter->cur_sk and iter->end_sk 
later.

Applied. Thanks.

>   	struct net *net = seq_file_net(seq);
> -	int resume_bucket, resume_offset;
>   	struct udp_table *udptable;
>   	unsigned int batch_sks = 0;
> +	int resume_bucket;
>   	int resizes = 0;
>   	struct sock *sk;
>   	int err = 0;
>   
>   	resume_bucket = state->bucket;
> -	resume_offset = iter->offset;
>   
>   	/* The current batch is done, so advance the bucket. */
>   	if (iter->cur_sk == iter->end_sk)
> @@ -3434,6 +3452,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>   	 * before releasing the bucket lock. This allows BPF programs that are
>   	 * called in seq_show to acquire the bucket lock if needed.
>   	 */
> +	find_cookie = iter->cur_sk;
> +	end_cookie = iter->end_sk;
>   	iter->cur_sk = 0;
>   	iter->end_sk = 0;
>   	batch_sks = 0;

