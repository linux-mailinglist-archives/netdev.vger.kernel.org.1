Return-Path: <netdev+bounces-158648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88295A12D9F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B343A40BB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DFC1DA103;
	Wed, 15 Jan 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZJkAF7az"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE31D79A9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976156; cv=none; b=Q/0fc0M1ylBJZuC67E/zIReRy8jT/D+x+eVBfqPkzL6hWAThhc3A9gVNjYE0jEXIndH2lRS5Sfv3GQ2rbPjxqpdwH3C6aypk2Vr3ddGzWl7F7iCojIjfkSbdoSknjFhEq8Ek8dY4cV4Zwy7jcauxHG2cMpRNorDIqWLkadEtotE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976156; c=relaxed/simple;
	bh=uraepEbQJnaWY3X4oH+bHhZuel7YSuPlB/L4bjCLQwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogMKdT9CkvaILt+UVw8VX2o/L3/FNK4d0JHgJ5QQpBZGMBWdp97Phpf1LBvnGG2UQu5pV8WTFI8QoViTUPMK2GF9G6lgoYP8UFelCRCnmGGljGU+crGgagZi3pUEGvCm91Vn1AmDb66gZAqbyaRiW7UaebL5c2M4J6DqrB32CWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZJkAF7az; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80309f62-0900-4946-bb2c-d73a2b724739@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736976137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0Bgm5lCM/3V2FVS63iTi2McfY+jsPoi84BVnDZHNH4=;
	b=ZJkAF7azXjdAaWgHQrqGQ5hfnYBRhjUmIXiplGGVuLtFFKn+OL9C3oFLjhIH0gaVdZwcuq
	e5LBrowv2EYsx/Wo5ljGCNcZ7/2KrthA+kzDNaN8FfORHZNsL7tCUL28UghILR1+iyh9nc
	5Q6uzabsV4+lzo9lplO+WRRsbfNPnF4=
Date: Wed, 15 Jan 2025 13:22:10 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 04/15] net-timestamp: support SK_BPF_CB_FLAGS
 only in bpf_sock_ops_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-5-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> We will allow both TCP and UDP sockets to use this helper to
> enable this feature. So let SK_BPF_CB_FLAGS pass the check:
> 1. skip is_fullsock check
> 2. skip owned by me check
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/core/filter.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1ac996ec5e0f..0e915268db5f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5507,12 +5507,9 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
>   					      KERNEL_SOCKPTR(optval), *optlen);
>   }
>   
> -static int __bpf_setsockopt(struct sock *sk, int level, int optname,
> -			    char *optval, int optlen)
> +static int ___bpf_setsockopt(struct sock *sk, int level, int optname,
> +			     char *optval, int optlen)
>   {
> -	if (!sk_fullsock(sk))
> -		return -EINVAL;
> -
>   	if (level == SOL_SOCKET)
>   		return sol_socket_sockopt(sk, optname, optval, &optlen, false);
>   	else if (IS_ENABLED(CONFIG_INET) && level == SOL_IP)
> @@ -5525,6 +5522,15 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
>   	return -EINVAL;
>   }
>   
> +static int __bpf_setsockopt(struct sock *sk, int level, int optname,
> +			    char *optval, int optlen)
> +{
> +	if (!sk_fullsock(sk))
> +		return -EINVAL;
> +
> +	return ___bpf_setsockopt(sk, level, optname, optval, optlen);
> +}
> +
>   static int _bpf_setsockopt(struct sock *sk, int level, int optname,
>   			   char *optval, int optlen)
>   {
> @@ -5675,7 +5681,16 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
>   BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>   	   int, level, int, optname, char *, optval, int, optlen)
>   {
> -	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
> +	struct sock *sk = bpf_sock->sk;
> +
> +	if (optname != SK_BPF_CB_FLAGS) {
> +		if (sk_fullsock(sk))
> +			sock_owned_by_me(sk);
> +		else if (optname != SK_BPF_CB_FLAGS)

This is redundant considering the outer "if" has the same check.

Regardless, "optname != SK_BPF_CB_FLAGS" is not the right check. The new 
callback (e.g. BPF_SOCK_OPS_TS_SCHED_OPT_CB) can still call 
bpf_setsockopt(TCP_*) which will be broken without a lock.

It needs to check for bpf_sock->op. I saw patch 5 has the bpf_sock->op check but 
that check is also incorrect. I will comment in there together.

> +			return -EINVAL;
> +	}
> +
> +	return ___bpf_setsockopt(sk, level, optname, optval, optlen);
>   }
>   
>   static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {


