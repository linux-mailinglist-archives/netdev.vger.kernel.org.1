Return-Path: <netdev+bounces-147301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F39D8F95
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 01:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8209D169F2E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AD6FBF;
	Tue, 26 Nov 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e6vpLvD8"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18C3209
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732581651; cv=none; b=pJ4Z2tRixBrypr60ycQ6Hlp6V1FB6hMA4yRLKykped5FNaW4DTR2ZVyazcx3e7IRb2UoMeOK0WfUBiYbMfFTuZE7Xrw5s1xA45DTuGsl0M0JRMAdWLJi+ABmvJmTMBnREQZwzruOuZw34qlwJKOhwXm/+fTQoh5lASR6IRvhif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732581651; c=relaxed/simple;
	bh=ykF2eOATOX9fVv+Lykv1HvuJYi+ZqyHT6QjTA/M5ZjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r77PxmEy4bQarCTXaq+oW+H8KWM6jyJOXeFyZJsHI1i5YEo3ftD9e0K2GHmliP9RmACWyTZBVe4NqX2Y/Hvod/kodS1mYHOLU5MbBJSUtvf6yeubfqL1qyAobhGjmOmKRySorDlkviLFi6nu/vwHLKYesdIve0/YiSbIhyrwX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e6vpLvD8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e2a9b1b-62e2-4b8e-8759-159a5190b569@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732581646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jr8gISDfyaFnEkTOT1hYFyfwEDPkLRVSRt2YHQHcXw0=;
	b=e6vpLvD8DjnhxYvJzQbjGgczERF6eIANo8TjyBOPnIW/HxHFcfljaA90OHfK1ROFwWm8JD
	AbX6OiHvl88v32zqLEVij2IXGYlBuukJ1prOrcC/uUQ80v2WZcTuF5qGLhQ7HZs9X12YYW
	5u2HdLtK6d0V45Eo9e9x+FwCPOg1ETY=
Date: Mon, 25 Nov 2024 16:40:37 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 net] tcp: Fix use-after-free of nreq in
 reqsk_timer_handler().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Liu Jian <liujian56@huawei.com>
References: <20241123174236.62438-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241123174236.62438-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/23/24 9:42 AM, Kuniyuki Iwashima wrote:
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

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


