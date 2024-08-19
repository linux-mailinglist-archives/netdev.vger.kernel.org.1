Return-Path: <netdev+bounces-119771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCF956E9E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791E11F215A3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C33A8F7;
	Mon, 19 Aug 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0dtrpVx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0963A8D0
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080889; cv=none; b=mGgcbgjW2bZa/M6BPHOJlFmM+l649MctlV9mpa0OAPHDYjkM1VeVHYuU1haITtl2HN8Lm4HjiOuxS6Lw6IVcsOnAIchn3Gqzu3cE309eKzRJTGVc4dRjpFXLEBWQXEd8lJqDI7xSAvR05Ltrt94RahaZInC4/hRtkNNV1QA/MwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080889; c=relaxed/simple;
	bh=aBcAqY1HN+qQxw/5Pog1o53oFOe+MJASXET9/gwKRb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Grf0RttVqwwc7awjixkIU5E8GuTOQQu54TNaNzgxoOAW7R2wEyAtrNvYKba1O021nSoOxvCHg2fHifk0NZ1n8bXMW53hw+m0kYKeWTXmLPqYZ0Y3D2AfnqHIJB7iV9KEKjB/EHzVCepq7xFKO79ihhmVCvRnQURQmJEHHcFbP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0dtrpVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A8C32782;
	Mon, 19 Aug 2024 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724080889;
	bh=aBcAqY1HN+qQxw/5Pog1o53oFOe+MJASXET9/gwKRb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0dtrpVxgpUKunkV2U1kZaUiF2pyUSwwhorixqBUH5k5JL/WeM0TTabQRMY1qZsWl
	 HDRddIiOQM7a6wqCQd3s3rFaSEd54MD79kaDyLXF3HlWT58H5MOwl9BPpozR8+1CjT
	 Z/2MpLxGR4lHtyfEusLkdQaDTbrUmX0PtS0rhPSuWeHN1F4I717AAYQyDffIby+kNi
	 RtcdEEeakEyTyUZKy254Nh0a4JWmacTGSoX5moEBCbwc2+u9JPZdh8ZcFI0C47Fvhg
	 spKu7BYdkqapakFtufVdp7uzQRMj+Fw7Mk9t27Qk7EPrmVkEeXINg5EHRg/ZCRJtFX
	 zh5gMvpUPW/8Q==
Message-ID: <bda78aa1-d4bd-4f9a-9b54-d7b5444177e2@kernel.org>
Date: Mon, 19 Aug 2024 09:21:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ipv6: prevent possible UAF in ip6_xmit()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Vasily Averin <vvs@virtuozzo.com>
References: <20240819134827.2989452-1-edumazet@google.com>
 <20240819134827.2989452-4-edumazet@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240819134827.2989452-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 7:48 AM, Eric Dumazet wrote:
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 1b9ebee7308f02a626c766de1794e6b114ae8554..519690514b2d1520a311adbcfaa8c6a69b1e85d3 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -287,11 +287,15 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
>  		head_room += opt->opt_nflen + opt->opt_flen;
>  
>  	if (unlikely(head_room > skb_headroom(skb))) {
> +		/* Make sure idev stays alive */
> +		rcu_read_lock();
>  		skb = skb_expand_head(skb, head_room);
>  		if (!skb) {
> +			rcu_read_unlock();
>  			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);

rcu_read_unlock after INC_STATS

>  			return -ENOBUFS;
>  		}
> +		rcu_read_unlock();
>  	}
>  
>  	if (opt) {


