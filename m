Return-Path: <netdev+bounces-164203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA9A2CE6F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F353C3AB72E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC21A5B98;
	Fri,  7 Feb 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2WEdi+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11D71747
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961450; cv=none; b=mOwdvJ6iaQubs/ntPMQ1vdWW3kVa6YtMaKc8OL1RjGfTe1XeuxQSRnNQETxJviour7KYP6oOAP58XR1RHiTE06D/Y5n+ijYLzvgfhbnFEg1/QsNARinr6Tnz464nlXe0nmdWsBhuRN4FbGw3MsiLA6RcatgkQBQBLFtuVVOzcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961450; c=relaxed/simple;
	bh=OkAJOKwjdalCZ3Et83FUM9D96Lluvr0he7GFtl/+S9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvj+t36rQWg52RkidU9mQP5zipFVvrbX9sVR5bjpDrUFH5BX1cNIFrAOshsBRyPHEQ1NoH8fosTrwQIygqAsVfk93iE8GTC97+9m4MThPmYH83tdzatDb7M0KdfSS+eQVAvGcc/K/ePCIR4KFkHCcb4ypW0XBWPg1lk6k0Z23LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2WEdi+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF0C4CED1;
	Fri,  7 Feb 2025 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961450;
	bh=OkAJOKwjdalCZ3Et83FUM9D96Lluvr0he7GFtl/+S9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L2WEdi+FrKETmduRoAOGNXI48ltG4lgOV1NlbVEXjgf+q/DpbjQKSQOCcEi1cbRxF
	 W02NwGxxV5/XjJAh/XoViErXLsV0BDhAWwXdHyiO1qY2o6JSU1PvEwjsJKdn5c7b1X
	 f5AsJAlbG9elY0NvokX6R97gDx/rD81NjGgsGgjtEmsxPp/+x+pihoChfgAfwrMPVl
	 sv8rc1JyxwzWh+ufYoFjAYB92IaNPP1u3OE1FVLEKV3yFAYJLGS1VmvDjCeUhC7yH7
	 791RrBQ5b/NaSqHJ5v+Gy6p949InmmtqFw8j1RClxcWX9SpyBdr2w85dnKMd0gqYVE
	 caORQczuSCYNg==
Message-ID: <aed28a3c-5f6a-4377-a9df-ed24d602509c@kernel.org>
Date: Fri, 7 Feb 2025 13:50:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 8/8] ipv6: mcast: extend RCU protection in
 igmp6_send()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-9-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> igmp6_send() can be called without RTNL or RCU being held.
> 
> Extend RCU protection so that we can safely fetch the net pointer
> and avoid a potential UAF.
> 
> Note that we no longer can use sock_alloc_send_skb() because
> ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.
> 
> Instead use alloc_skb() and charge the net->ipv6.igmp_sk
> socket under RCU protection.
> 
> Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/mcast.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


