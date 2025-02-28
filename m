Return-Path: <netdev+bounces-170795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF540A49ED5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D853B3192
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D3199FBA;
	Fri, 28 Feb 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckz/PcP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6C14A4DF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760233; cv=none; b=NzkorsrO4lnl0cXkUNX/O2B1xGFofNnEcEq56h5nx1lmESA2Td6oCh1vks8WVEyqfs+r3+PkrSBTRwSO55olJz/10ewu7bSObiuZzOLQnsLvkwSs4evSHLpwWsuiQBrzhxRFz1AJsj9/rJ3HNmb03/oMeygue0c6KqKZcpXXAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760233; c=relaxed/simple;
	bh=3KtmV5ME+F1pYQp+xfSt0h4YT4MAlpymShBBSIhkOkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/xvnfg1VUTYb2VjZE6xdJfcqoGMdrZPJLaJdgePwlBy2mUd0kibnIeLp5OnFNapCyvqAbaJnS9XezFvCYqY/brIbgSQj2Vh6AVS+m8jJQday2giZuy6lm/yUJd/egM+6tE7VlKrqYlMQgm0XFS4bSWoRXFPceZl5Y2bkeGfEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ckz/PcP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B952DC4CED6;
	Fri, 28 Feb 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760233;
	bh=3KtmV5ME+F1pYQp+xfSt0h4YT4MAlpymShBBSIhkOkA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ckz/PcP4/9P4X2n/0Y8qpr1/yfjzOE0Oqk5scRqL9CNiTVHdDDIjPcHFFIT6hUxY/
	 ZJdQjrjScPh6/RNSI5unjm+QmpFuoc/JgEP6VznqPsX74npi522D89IZLfs2j6S/IA
	 zLfRePoRcDTNUH93fet4Y5J1zd4zALQYjOMj+U1dzRftH2K25zt1Ri+tyO1rHnIW7V
	 xQzAGrbZrP88v1pOQJbYHM14y5lGPTjKegvk0eeFSRRAf3QoRHn6+Dy6zsJIR6ux9n
	 Sn/nAdb5gtDdTYUw6g5lQ/enpWAbYHqZRWOVIIIyMU8szhBweqyM4OgosuKLF7eW0+
	 yJlky2ZBwJMug==
Message-ID: <02e5bf07-b722-475e-91e5-78def5e6a83a@kernel.org>
Date: Fri, 28 Feb 2025 09:30:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] inet: ping: avoid skb_clone() dance in
 ping_rcv()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250226183437.1457318-1-edumazet@google.com>
 <20250226183437.1457318-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250226183437.1457318-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:34 AM, Eric Dumazet wrote:
> ping_rcv() callers currently call skb_free() or consume_skb(),
> forcing ping_rcv() to clone the skb.
> 
> After this patch ping_rcv() is now 'consuming' the original skb,
> either moving to a socket receive queue, or dropping it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/icmp.c |  5 +++--
>  net/ipv4/ping.c | 20 +++++---------------
>  net/ipv6/icmp.c |  7 ++-----
>  3 files changed, 10 insertions(+), 22 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



