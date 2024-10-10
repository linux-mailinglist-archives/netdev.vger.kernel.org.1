Return-Path: <netdev+bounces-134067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1E997C9C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 07:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936A71C21233
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A5178372;
	Thu, 10 Oct 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wlNW1c9P"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01747405F7
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539230; cv=none; b=u0U0AhEWnrvZ1pvSGlbB0Srz0S0+t8XurslK/V27HxNysmNe+0QYlC80P4sayUUgpzPXYctiyE032KYB30OYV/dARKSHFcZ6Gpm1tiG8LMQjuH2Oa+iwcgJRNG7qWm15PnlCx5ERmIYSGWnbg08MmbbUBDLx4SJQ7IHgL++YsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539230; c=relaxed/simple;
	bh=Dc6fTvzZ3MIpkw+4Czs+PKueDtIqWsVS2JqlUq5CxlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLRw5yGDh/tctYyC7cmk+4pTHQuVm/l9l16n81qk5UCZBJUTQVo+zEGl3vrnsXKDC4dLfsQz5TaOuC5R1n3M70fiCCiF12Hwc1i94pu1E5wcZm4Z10MH/G7yYrL7C8q62R5+GaA/3VP6MyeorSygB0yLqxKQTlQz5kS7dtuWXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wlNW1c9P; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a1ecbca9-52c8-4653-a404-961b8e4fc674@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728539225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCwRA5t8Zaks8FCLv60b755ro4TwJlRPC4ajasxEI4k=;
	b=wlNW1c9PUR+m+kRBonz6C7CEJLoAN7d5be7pKMW3zrXW3mOMKpnutlhQLgyGQyRDyDQRT6
	UhdKMCS/l7KxQhtfOlGknskDQJiL8Ibr3JHzJKyZWE7CebTZwJzYmZGDKNQdJauGA3041G
	GIdp9DHtBQw9vme69FGbv0APsYSjtug=
Date: Wed, 9 Oct 2024 22:46:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241009174226.7738-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241009174226.7738-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/9/24 10:42 AM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 2c5632d4fddb..23cff5278a64 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1045,12 +1045,13 @@ static bool reqsk_queue_unlink(struct request_sock *req)
>   		found = __sk_nulls_del_node_init_rcu(sk);
>   		spin_unlock(lock);
>   	}
> -	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
> -		reqsk_put(req);
> +
>   	return found;
>   }
>   
> -bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
> +static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
> +					struct request_sock *req,
> +					bool from_timer)
>   {
>   	bool unlinked = reqsk_queue_unlink(req);
>   
> @@ -1058,8 +1059,17 @@ bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
>   		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
>   		reqsk_put(req);
>   	}
> +
> +	if (!from_timer && timer_delete_sync(&req->rsk_timer))

timer_delete_sync() is now done after the above reqsk_queue_removed().
The reqsk_timer_handler() may do the "req->num_timeout++" while the above 
reqsk_queue_removed() needs to check for req->num_timeout. Would it race?

Others lgtm. Thanks for the patch.

> +		reqsk_put(req);
> +
>   	return unlinked;
>   }


