Return-Path: <netdev+bounces-92238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7418B616D
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916FF1C2199F
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65913AA31;
	Mon, 29 Apr 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY5C0fF/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A681E529
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416720; cv=none; b=GCB+VUTSqVqNJgnT7aqNqEBb2AgrBDzUhA/fo1cdu2UiPiwPRyZ5Bi/2F0LFdW0D4rQZ4X70E1JQfFl+7Yn6Mq+5jt43p8jxsXb+B7HROIvLjL6QDDkAYhaQ1SH9dmwmbi1ECR2vTh7p2tZL5Rt3ZDPiCRNHH/uelbOkPzHrjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416720; c=relaxed/simple;
	bh=4kwN+5xyXnMW3XybXTZ2reHGMB/y/8/HbmYBixznca0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2YpiYGVzwtrMqqk8EWE5+3VxtJNBks4K8sPcHP/aDl8yaGNr0JbhWPT+yHc4GaJm+R63FHfsAHxICgwJCUkr6O/ptuhO+YtCzQLYMJvz77t9pRFtu0gE57/+a8vldpNtrt7ajrJbTi59mve1MFEkNFfUXjmnAuuGqwuKAJiDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY5C0fF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59ABC113CD;
	Mon, 29 Apr 2024 18:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714416720;
	bh=4kwN+5xyXnMW3XybXTZ2reHGMB/y/8/HbmYBixznca0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LY5C0fF/XTb0t0EMRRXZTvde0ME3hl7+m08ogN3uCYSy+t2fU2yXiaHFLiYQiN3IA
	 51IOjmB/oZFRDmNCgSsZqkZDswYjbSqUKJSZcqzwLQ7JPte91S1e4JVIF5zKjFwUbG
	 HLVt9OGPEBrfX6Zf1yoxItso3M9CUOCdHVBouR7EmryofgQalCTleWlacGN5+EIpPS
	 BDj9F22Kqzohns/CpG0Ez6qUV2qkbvasqDeJa4DgYRJ1eouCZ3lNV5jF1pwOdDOFlE
	 aLc7NitTrYok/5evP3ED2wEVg20TpTwX3jv1Rt2hk5wXLkGvTjkJjFBJmj5uSysQCm
	 lxfV/EIUodKRw==
Message-ID: <06e75c94-1015-404b-ae41-2ef3bfa34352@kernel.org>
Date: Mon, 29 Apr 2024 12:51:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: anycast: use call_rcu_hurry() in aca_put()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240429183643.2029108-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240429183643.2029108-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/24 12:36 PM, Eric Dumazet wrote:
> This is a followup of commit b5327b9a300e ("ipv6: use
> call_rcu_hurry() in fib6_info_release()").
> 
> I had another pmtu.sh failure, and found another lazy
> call_rcu() causing this failure.
> 
> aca_free_rcu() calls fib6_info_release() which releases
> devices references.
> 
> We must not delay it too much or risk unregister_netdevice/ref_tracker
> traces because references to netdev are not released in time.
> 
> This should speedup device/netns dismantles when CONFIG_RCU_LAZY=y
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/anycast.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



