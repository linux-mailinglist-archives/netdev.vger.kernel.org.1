Return-Path: <netdev+bounces-79034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A918777D8
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D03B1F21253
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3C39863;
	Sun, 10 Mar 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbWJ2xZw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3351D6BD
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710093302; cv=none; b=nL46pQcTN0SWgJD8zvbjwS97TS7CpB0MoOxW0byN+ach9YPXO+8PnZ+HXNCG0w2lmrbH5F8CpSTPoFTrgl8BR1CE0yaRY3xjiYOrG9t/R1RzERrbb9mTl7J9+ZR7CGWQTM+kxt89wSwSF5tnp+w1SBDUmXY/6VipaVOBh12xrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710093302; c=relaxed/simple;
	bh=heTFNwk/ppSR2NA7nRc1RYd/yeHfAhlCgWm5vmeCr8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhOR2lTjDKK54Jax9VSAxerz/QF4iIHq/Ikcz5DQH7VOz4iHZRKIKuLaxhEJt0VFiYPaA1QlE5ilOj2WdAzagw4lYkgYyDc7KL7Ok2GFTZ3Z9t9cP72GeNc/s7LwO8yiYTAuTcxHsEigy2yt681/JazmbyWGySpTZpPs5JU0RhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbWJ2xZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E37EC433F1;
	Sun, 10 Mar 2024 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710093301;
	bh=heTFNwk/ppSR2NA7nRc1RYd/yeHfAhlCgWm5vmeCr8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rbWJ2xZw8nTCFJOs/ZbT9FWyDYe9jOyHqSGlZQInQXFLXUCTzNO06q+EGbHXJmS2c
	 GIUf27MZ0Guyw8b39ekKCZNF0B11qB4UDty6h/rkyXn3oPH5x4p8eVXDm01DQZZ+xu
	 i5RGkWdShOgwIjRqOKfv0i4A1q9mo7VPfxinPuB9vojF4A7/7hegaePDq0G423IW4y
	 1b3RKRbWwCzXil4zaWnsRRMqg952xqYI5wSHpTEfHKPdH2USPdx+XRzowArPgAVstI
	 E8ag+DZl1a8n2Ly3a8ad6jFTY2fXVgCPFpkPtOMN/4COn6WmWVdVCXnsnviSwEcUNL
	 6+JKwvKl5IuJA==
Message-ID: <a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org>
Date: Sun, 10 Mar 2024 11:54:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during
 attribute validation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20240310173215.200791-1-idosch@nvidia.com>
 <20240310173215.200791-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240310173215.200791-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/24 11:32 AM, Ido Schimmel wrote:
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 5eb3ba568f4e..f3df80d2b980 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -3253,8 +3253,9 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	int err;
>  	u32 id;
>  
> -	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
> -			  rtm_nh_policy_del, extack);
> +	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
> +			  ARRAY_SIZE(rtm_nh_policy_del) - 1, rtm_nh_policy_del,

'tb' on the stack only needs to be ARRAY_SIZE as well; that's the
benefit of the approach - only declare what you need.

Comment applies to the other locations as well.

