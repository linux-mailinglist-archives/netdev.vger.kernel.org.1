Return-Path: <netdev+bounces-218017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89EB3AD59
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE4204A01
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623741DEFF5;
	Thu, 28 Aug 2025 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XikhQwR0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0030CD92
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419450; cv=none; b=ou88D+I47z915+bJnXG68V+EwG+ktaMUakFdNfUGUye6GLVucvVD9QY3eW1OrJ79/9bGonzxEEBfyFN8EQR9dsvd0UQTkW9s2XobDv8g9x+AURRggemHNlOQrw4PXVZAMfgUOn3Q9VaZMAxDE6xRSUvXWsRKUyeb5gbo3I9RVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419450; c=relaxed/simple;
	bh=DkRT88lVZHxRE6tGnFTINJKDnPZw2GDxJz6Jj7YNy7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLTlVZ2zMdpMUBihHSffKKtWRRuaTFrucS+fXj/suFDaY+85j/dWNREBeAzZujog4OGDNtG7Pc3DTn/74xobhuoXBcqZgTF5DZMvufaNTTEVT3a6Yn4rXrQWPZIkQaRI/mw0v93gPvMaJR3lXJky0y2Qi5iUQihSk+bWAIhEOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XikhQwR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BC8C4CEEB;
	Thu, 28 Aug 2025 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419449;
	bh=DkRT88lVZHxRE6tGnFTINJKDnPZw2GDxJz6Jj7YNy7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XikhQwR0Do6zODTrNBZp+vNdOXU39yU6J0Heg0S0zPRR+EqKkPPzVJY/AZbc6epQb
	 3ssjTgZRVJm6VJsfI8y5R5zw9f/fFvlE7pjJAU9xcfKboFRuMTv+GwavYG7JfO+m5b
	 5uHj/RFRiMQjm0nTz1JzZYuSuldS2WkMYpWpuW6zGjpS2Zsg9Gf65uJhZ1PTCDzr/Q
	 Wv6D6FEtIv3T+oQpXa2uWWSLFvsDpn79T1Sh0m09hqWMIJRqoxsowElIPS3BofjPso
	 EeQ4W9MchwSCoXqsjjX1UKyGBzyq3n7a7Dthv5YUl6tEbTdXd8XX6FsNwsrpAqjsFT
	 U0zi68mXF+K7A==
Message-ID: <eda537e3-05b5-44be-b0b4-77690040a5e4@kernel.org>
Date: Thu, 28 Aug 2025 16:17:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] ipv4: start using dst_dev_rcu()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-9-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-9-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Change icmpv4_xrlim_allow(), ip_defrag() to prevent possible UAF.
> 
> Change ipmr_prepare_xmit(), ipmr_queue_fwd_xmit(), ip_mr_output(),
> ipv4_neigh_lookup() to use lockdep enabled dst_dev_rcu().
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/icmp.c        | 6 +++---
>  net/ipv4/ip_fragment.c | 6 ++++--
>  net/ipv4/ipmr.c        | 6 +++---
>  net/ipv4/route.c       | 4 ++--
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



