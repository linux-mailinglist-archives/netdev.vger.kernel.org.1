Return-Path: <netdev+bounces-143436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BB9C26E2
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D46B21945
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F401C1F14;
	Fri,  8 Nov 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iyu6snDm"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F2233D92
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099839; cv=none; b=Q1HhHmxbRqgAml7joa0ZT08JHgEh8MvgE7mCZxIUJDqchJu6eRL4h+AJHTGqb+uTPfByLX1QvVmZo6kWNoD1uP74UTeJq+/Sq8aNyfzV1L9B0/eFyoQjJOQAUFm0xgaH4mvaMCUcZV67Wc6FMEaUL+Rb1Mrae+janarWJpziZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099839; c=relaxed/simple;
	bh=IkNuEqLuf4OrCzNDLZRVbJpPF1vImSQUmOQC882HGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uO/KixDj3FSlle1iFrc0U2fPkIW2LDmWwSRRF1lfq9Zm4hdE5wDFB6GEI+dY1aNtUcHpnqP0ua1J3crrkT6NUsoZVanWqhSlMQsUTYXkwH+WEbg+JYid44jIrWNuy6gJE/MmtCnrpZtYg2RHgItQjZxl4Ye82SynPuwzy/YV5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iyu6snDm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2939664d-e38d-4ac4-b8cf-3ef60c5fd5c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731099834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF3709v11aOgpaO8P8xpLOs+rNMk6jNKKDcoy1EW6y0=;
	b=iyu6snDmqrfG4YYqMXj7lPbnzwB/5Fc9Q1TjKpsetYbx0Ili1ClQLLJmq/6vOgOeGUTRkr
	TPrEZIwAJq6fQkFnnowIZHUOVQXzgvxLd9jjPnweI6+gZlo9MNsibAa0+gB5QQSIaKGgc1
	WRqHAhSESFke2240BWpSLTrAo9/SgBk=
Date: Fri, 8 Nov 2024 13:03:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix recursive lock when verdict program return
 SK_PASS
To: mrpre <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, bpf@vger.kernel.orgc, linux-kernel@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
References: <20241106124431.5583-1-mrpre@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241106124431.5583-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/6/24 4:44 AM, mrpre wrote:
> When the stream_verdict program returns SK_PASS, it places the received skb
> into its own receive queue, but a recursive lock eventually occurs, leading
> to an operating system deadlock. This issue has been present since v6.9.
> 
> '''
> sk_psock_strp_data_ready
>      write_lock_bh(&sk->sk_callback_lock)
>      strp_data_ready
>        strp_read_sock
>          read_sock -> tcp_read_sock
>            strp_recv
>              cb.rcv_msg -> sk_psock_strp_read
>                # now stream_verdict return SK_PASS without peer sock assign
>                __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
>                sk_psock_verdict_apply
>                  sk_psock_skb_ingress_self
>                    sk_psock_skb_ingress_enqueue
>                      sk_psock_data_ready
>                        read_lock_bh(&sk->sk_callback_lock) <= dead lock
> 
> '''
> 
> This topic has been discussed before, but it has not been fixed.
> Previous discussion:
> https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch

Is the selftest included in this link still useful to reproduce this bug?
If yes, please include that also.

> 
> Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue")
> Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>

Please also use the real name in the author (i.e. the email sender). The patch 
needs a real author name also. I had manually fixed one of your earlier 
lock_sock fix before applying.

pw-bot: cr

> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

The patch and the earlier discussion make sense to me.
John and JakubS, please help to take another look in the next respin.


