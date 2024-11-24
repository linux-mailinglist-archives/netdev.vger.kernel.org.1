Return-Path: <netdev+bounces-146928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF599D6C65
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 02:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5B7281395
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36C14A82;
	Sun, 24 Nov 2024 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaYtgmq+"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703529A9
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732411819; cv=none; b=iU9woE2Egpl6e/4QQwBNWk1BgwqZ+gfJUgOzKb/3irV564UtRljLolhAaJecEfoCflh0cosXabcG6pKKXP08+BtzY/2ol6Odq6ZsChBp1nLW7bCUL+LMIFN6BoOfXwdFJHYuyseA5kRaEaDXh52cYgfe7zZKuzdyhoU7XFel5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732411819; c=relaxed/simple;
	bh=iE8bC0iYoUv3KN66wBvVm3CpHEtNZAq6gL6hU7plVWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UApLkD82OpeyGzHi5jHyhVWsYq+2Dps3qQ1lV2m7ZI8tcj64ZpIx8rZUnUe8UJOI8jMyy+S4PbdLFAysdGOlRncgBhoWnIriGn/g5N2T+r0pwH68ufcTMBVejR+Ht/vlO0lpjDKp05i06ha8sp4hG1tdn2k1ykI5oLQuyhEcvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XaYtgmq+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66ebd7b1-8798-4d1c-925e-0822c9b466d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732411813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBqCvmkIK9awW/W/XAMHoyazY0FAb6jfi4/qNnRLVF8=;
	b=XaYtgmq+XKIvSs4Qk2ye5eBIb4ZR4BUgk9zPOmcKz68r79e/DHhItRXhC6yrSqnoBjhNIB
	0TUTWCc9lh2J6zBit5q1k8UhF5lKkfYHY+m1n2b5oMvcOnbpRmBGlmyVfRl7OAOjbBG9Q+
	yq5hf0Xg7rjz8xnoJGhjspo05rF45Z4=
Date: Sat, 23 Nov 2024 17:30:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 net] tcp: Fix use-after-free of nreq in
 reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Liu Jian <liujian56@huawei.com>
References: <20241123174236.62438-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241123174236.62438-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/11/2024 09:42, Kuniyuki Iwashima wrote:
> The cited commit replaced inet_csk_reqsk_queue_drop_and_put() with
> __inet_csk_reqsk_queue_drop() and reqsk_put() in reqsk_timer_handler().
> 
> Then, oreq should be passed to reqsk_put() instead of req; otherwise
> use-after-free of nreq could happen when reqsk is migrated but the
> retry attempt failed (e.g. due to timeout).
> 
> Let's pass oreq to reqsk_put().
> 
> Fixes: e8c526f2bdf1 ("tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().")
> Reported-by: Liu Jian <liujian56@huawei.com>
> Closes: https://lore.kernel.org/netdev/1284490f-9525-42ee-b7b8-ccadf6606f6d@huawei.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/ipv4/inet_connection_sock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 491c2c6b683e..6872b5aff73e 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1191,7 +1191,7 @@ static void reqsk_timer_handler(struct timer_list *t)
>   
>   drop:
>   	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> -	reqsk_put(req);
> +	reqsk_put(oreq);
>   }
>   
>   static bool reqsk_queue_hash_req(struct request_sock *req,

That indeed fixes the fix :)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

