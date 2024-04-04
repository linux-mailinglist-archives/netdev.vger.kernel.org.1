Return-Path: <netdev+bounces-84981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9D898DB2
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133DE1C2198A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73FC12FB10;
	Thu,  4 Apr 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPjoyJgV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A712F590
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253970; cv=none; b=fzvkHtf0vqeuXJO+R/tbhxujvCagdr4Yxk0ywpne36JGKymUqf19ejKL75EExnJDYGPHhT8qNh/L4hHMvi8Vf9zfXYeU0XzVogx7Le3U70/VwghFL+bMh2S/XY5GV4bdgjZI39Fvc3QnVVZpHWzHOYbVTq4T5M3dzwm/dZV6ZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253970; c=relaxed/simple;
	bh=ciGSsgbtL57oOZaOtVMCBQeNpC3tDp8C+/42uIsQBwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlpFxZSdeuJ3j7cVVRouHSULYL0aMm4+u7ry5Pwj0TQoWFvb1yvpSuJ2gGtpQffqbM50teXXnEfXfjAvXqvo4Gcmcy45jg+gBKumbusf4vQEyPskir5usQPxidvhDRhrMiM9di3zIpE/RCeZhuQQ/Sa6aW5g66OGK4KvfwK3Tqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPjoyJgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8633C433C7;
	Thu,  4 Apr 2024 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253969;
	bh=ciGSsgbtL57oOZaOtVMCBQeNpC3tDp8C+/42uIsQBwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PPjoyJgVVMrSoPKsT9k4ldcaVTaCJhCHYFyjmSDrzyE5RpovGzLD2BKYGW0i1Z6/7
	 8N+zYZ5YRetvIMgbsJSHzVc42HOyvdoAIe0O3U1OnSi2f2isph0gmczu3qVMB+VrA/
	 roqBs9JnSb66SJRMRlMyCKaqB3KQSkH6KlHaVvCfQp5HZrUtUOwoSiP/94h7ab929x
	 36SIEe9wk9gyhvaRkwT2t7PXTQhPDbFr+1fhV5+miFVBLz2qT/+TyuIiwFtCwJDHH8
	 3WzbSwqEalCvsQ6nR2eqEwyRybIQiQUjvAw76Rv5NwCOKzkRkNGzd/F8NvJCX0i8al
	 0dM+Omsidte3w==
Message-ID: <8ab59d1c-80fb-439c-962f-a1c3b486ca37@kernel.org>
Date: Thu, 4 Apr 2024 12:06:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ipv6: remove RTNL protection from
 ip6addrlbl_dump()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240404132413.2633866-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240404132413.2633866-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 7:24 AM, Eric Dumazet wrote:
> No longer hold RTNL while calling ip6addrlbl_dump()
> ("ip addrlabel show")
> 
> ip6addrlbl_dump() was already mostly relying on RCU anyway.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations around
> net->ipv6.ip6addrlbl_table.seq
> 
> Note that ifal_seq value is currently ignored in iproute2,
> and a bit weak.
> 
> We might user later cb->seq  / nl_dump_check_consistent()
> protocol if needed.
> 
> Also change return value for a completed dump,
> so that NLMSG_DONE can be appended to current skb,
> saving one recvmsg() system call.
> 
> v2: read net->ipv6.ip6addrlbl_table.seq once, (David Ahern)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Link:https://lore.kernel.org/netdev/67f5cb70-14a4-4455-8372-f039da2f15c2@kernel.org/
> ---
>  net/ipv6/addrlabel.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



