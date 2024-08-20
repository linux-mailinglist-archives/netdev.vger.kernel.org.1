Return-Path: <netdev+bounces-120309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7E958E54
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947F5B2234B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C51547D5;
	Tue, 20 Aug 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLzF2My8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08990A31
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180307; cv=none; b=aeE4zKVq7bpGg869Qj88+OTlRIm1ahwyLrdWSL6JdbuhpJ/Qo62nLXyGOY4xYB72A5Sr/MpNVzyw17F7A2CTOT5eqzpgwKDdujlcrfGvh2Px70pDRiehpiPsSofo1INsOFSqlQOTgVTBG3CtXZfjEZs1Kqn6uS0h6e7rhaYBXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180307; c=relaxed/simple;
	bh=hyfsZC/q421dcUUkEwtmwVNAJA2F4+p17X/hilcMCyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwU0CTD7dfirGs9JbI/6/kv7uj9EBTLpQC3sDVfvqvMOSkuzi5rwuACJ8QjDGSJXKZloUHZs6Evigy61gSn/ud9ZlQhWqxsv5WDllPLNarADbRTMrmWRMLlX0y4AmaFeqzWwaapSxpjKmstodeo7XVUJND21sd5+eRhsBoDBfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLzF2My8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF46C4AF09;
	Tue, 20 Aug 2024 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724180305;
	bh=hyfsZC/q421dcUUkEwtmwVNAJA2F4+p17X/hilcMCyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RLzF2My8zC+rnx4h2zyQd5nFmEwxNT8oQk/jfxn7WYtavDgAKuQW7ZDV3bAHyhcnJ
	 6BwPda9XydZ/lGUNgrnv+OQASCAPU7O8fF6iCQDjLFvHr7RTo0EqCD/eZiZd1x7GeW
	 z0BN0XTO2Ii2d1UJJ8OXw+DaLTNTVFeK6pJKUvluOMV8IvXJOBD1Y7rn6xwx7wvuYA
	 2qLC0pWLsRCWJxCCgYM0v0NajqgQPj/JxBzkIfBYpi135HgfRGHt3LgtNxWmBFziGD
	 SIsr2Iugb7VQos03ajMttF/RFyAkHWeepILAp4ueIR8mtXviBqR/5TQMEQ+qxEPIxv
	 fuHO/RikDPYdg==
Message-ID: <b3999792-2613-4dd8-8337-db79273b3112@kernel.org>
Date: Tue, 20 Aug 2024 12:58:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/3] ipv6: fix possible UAF in ip6_finish_output2()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Vasily Averin <vasily.averin@linux.dev>
References: <20240820160859.3786976-1-edumazet@google.com>
 <20240820160859.3786976-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240820160859.3786976-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 10:08 AM, Eric Dumazet wrote:
> If skb_expand_head() returns NULL, skb has been freed
> and associated dst/idev could also have been freed.
> 
> We need to hold rcu_read_lock() to make sure the dst and
> associated idev are alive.
> 
> Fixes: 5796015fa968 ("ipv6: allocate enough headroom in ip6_finish_output2()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vasily Averin <vasily.averin@linux.dev>
> ---
>  net/ipv6/ip6_output.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



