Return-Path: <netdev+bounces-176487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76387A6A863
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2412485D2E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF33226CFF;
	Thu, 20 Mar 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnByeUgm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0174226CFB
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480434; cv=none; b=WMIHnQe/kb4XrQnahmI4MYtz4EaOvoFdrZZm3D5KxdU9XOP5N8zyDMUHXZhmjp1pTr6lQ5cc+OXube4rhPSSk0TJsobcj+mm9tnjtMgCl/ZR0SiAJDSaDKXlK3cTR15SIwoXsZNE9bhRecG9GMy7UTsA4BVG2iwgJxi2GAY4iSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480434; c=relaxed/simple;
	bh=eezOHvkT+vtkcWUhQkZKES+usNBF4EoxjQNwxX5b1Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNlqKA4BCmB5Ff0ySHwSnBbRwVyyZ7RnXcHJCCm5v5ZaZAYNcsbk2S/yaekF6h+dZuf1j76KxBg0y2UUo9BxTE9BQi3u7009UTO0DUxj9IHBudDIdfjdymxhJxoCp1kf4CAvDopiOymEc/nEKXQHvwCdrYFiFvH2zOYY6c8WDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnByeUgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708E7C4CEE3;
	Thu, 20 Mar 2025 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480433;
	bh=eezOHvkT+vtkcWUhQkZKES+usNBF4EoxjQNwxX5b1Hw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CnByeUgmCqmuAOiqAZ5B0A7dCU5+PRE837d/D6IbFuIPa+o6MBny6LyKIqbg5tVvr
	 +KOOEKAR6ZDJbv6UriLKsD8/CINzP2hYsvmMmO8bY+OH5YsrNKtcXMOaFw/5B/5b25
	 pOee07NzDEsaUzfAGj/cRSe9wkvRtM2XO9LmMH+YwJqbiYqBboxtgJwL64z9EztS+y
	 VoULNyOAd2i8sBnrAownBDzhflnj2j3FB7h9B/POwClUl+mVo8Z5T6mrVao9ZOLqrl
	 VhVfPoq6rA93wk/ANeo/J1m8imGpoL1O4GKxRbFbN37kHPLObQ1aDA9UKcr9gHckRo
	 FP/ew3f9VO6+A==
Message-ID: <ce7ce83f-b52f-443e-97f8-beffde023274@kernel.org>
Date: Thu, 20 Mar 2025 08:20:33 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 6/7] nexthop: Convert RTM_NEWNEXTHOP to
 per-netns RTNL.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-7-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> If we pass false to the rtnl_held param of lwtunnel_valid_encap_type(),
> we can move RTNL down before rtm_to_nh_config_rtnl().
> 
> Let's use rtnl_net_lock() in rtm_new_nexthop().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



