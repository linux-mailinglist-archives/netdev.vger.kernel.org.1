Return-Path: <netdev+bounces-129908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D94986F91
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB131F2188E
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4861AB52A;
	Thu, 26 Sep 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZ3cujDp"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C41AB6F0
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341589; cv=none; b=L0wZh6lLtu7jpBMGyFr7nWiPpR6trZP4VND6HDY76Nn/w7wocO8FpK8BIi1BHnoqlC6ihrXsZSBJeNKQBCEj8Yn7vpS99J3Dw4pZypKD+bPSqOPexcsYhi2OEh3f9cl8L5BHGnDf1DDlDmwzOHJ83Ne3Hnzt2CdfHJpDEL/pjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341589; c=relaxed/simple;
	bh=EkE9FfbB1Fp3JDlj4/hr0jrlTbfDS3RFOhiV3x3c+Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MA7WGXsPFvfwM+h56pzTOMemNPFYqB2jk3AOnSws1lJcMTa+yAu321Zh986g+gAcXPJ7SSofN/aNEZjT08x0oe6InG0WT70lUkLHwbFK+W++YPdX4O1ENnQAL5cd5LMLDYG/PyEV8soVYHcWKZd36mISQ4bpwi9/rmPA4O6zPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZ3cujDp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <abbe18b1-b372-4044-8490-82e6c0b4ec36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727341585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvvbrtaS6dEUP6f63YZemxRSOMHEf03ko/qFj9tmROY=;
	b=GZ3cujDpT7z6IB9Q6O+yA5eDjWVrFHkUSiL3+V9G6ovh7HBQcd/ZfBLDuCwPjdUTos6sR8
	wcP9Q9arnPJ5i81oOhRzuSNdDZTfJxRoJ2Us9o0Hs0eSTR2s5/4d4/BMaX98omN558Fcsw
	gU9cEt8WM7jUOXe9UOR+4dp3Cl3EuBE=
Date: Thu, 26 Sep 2024 10:06:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] tcp: check if skb is true to avoid crash
To: Lena Wang <lena.wang@mediatek.com>, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240926075646.15592-1-lena.wang@mediatek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240926075646.15592-1-lena.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/09/2024 08:56, Lena Wang wrote:
> A kernel NULL pointer dereference reported.
> Backtrace:
> vmlinux tcp_can_coalesce_send_queue_head(sk=0xFFFFFF80316D9400, len=755)
> + 28 </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2315>
> vmlinux  tcp_mtu_probe(sk=0xFFFFFF80316D9400) + 3196
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2452>
> vmlinux  tcp_write_xmit(sk=0xFFFFFF80316D9400, mss_now=128,
> nonagle=-2145862684, push_one=0, gfp=2080) + 3296
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:2689>
> vmlinux  tcp_tsq_write() + 172
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1033>
> vmlinux  tcp_tsq_handler() + 104
> </alps/OfficialRelease/Of/alps/kernel-6.6/net/ipv4/tcp_output.c:1042>
> vmlinux  tcp_tasklet_func() + 208
> 
> When there is no pending skb in sk->sk_write_queue, tcp_send_head
> returns NULL. Directly dereference of skb->len will result crash.
> So it is necessary to evaluate the skb to be true here.
> 
> Fixes: 808cf9e38cd7 ("tcp: Honor the eor bit in tcp_mtu_probe")
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>   net/ipv4/tcp_output.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746bd4d54..12cde5d879c5 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2338,17 +2338,19 @@ static bool tcp_can_coalesce_send_queue_head(struct sock *sk, int len)
>   	struct sk_buff *skb, *next;
>   
>   	skb = tcp_send_head(sk);
> -	tcp_for_write_queue_from_safe(skb, next, sk) {
> -		if (len <= skb->len)
> -			break;
> +	if (skb) {

Thinking more of this, I don't really understand how is it possible to
reach tcp_can_coalesce_send_queue_head() with empty send queue, but
anyway, this patch will move NULL dereference further to tcp_mtu_probe()
where new skb is build with the same tcp_send_head() call.

I believe the proper way is to return false here in case of missing skb:

if (!skb)
	return false;

This will prevent tcp_mtu_probe() to continue execution and avoid
possible NULL dereference.

> +		tcp_for_write_queue_from_safe(skb, next, sk) {
> +			if (len <= skb->len)
> +				break;
>   
> -		if (unlikely(TCP_SKB_CB(skb)->eor) ||
> -		    tcp_has_tx_tstamp(skb) ||
> -		    !skb_pure_zcopy_same(skb, next) ||
> -		    skb_frags_readable(skb) != skb_frags_readable(next))
> -			return false;
> +			if (unlikely(TCP_SKB_CB(skb)->eor) ||
> +			    tcp_has_tx_tstamp(skb) ||
> +			    !skb_pure_zcopy_same(skb, next) ||
> +			    skb_frags_readable(skb) != skb_frags_readable(next))
> +				return false;
>   
> -		len -= skb->len;
> +			len -= skb->len;
> +		}
>   	}
>   
>   	return true;




