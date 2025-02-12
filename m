Return-Path: <netdev+bounces-165684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94355A3307A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2965E3A1392
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C880F20012B;
	Wed, 12 Feb 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib0PjZRb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454F1FF1C2
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390952; cv=none; b=Sj8XlrW1SsMUcMJm3e5yOUN6d/Kiu7zJVqGsOUqFTtZwkQEuX9Njst9BHrhnbjYMSO576OzpJmKlEDCjB3D2/wilBcoxvjvmszU9jmA6W6zR/uiJuX1f9R1YHpXtvirZ8bgw32a5cU3ip5qnCaRC6+3NdOTZ/z85RKcvlPlFTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390952; c=relaxed/simple;
	bh=0Vb0Y7OckXhuinWilEKDEpEhT1gzrajLKbuUOaR7zZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqm2F8V+5jB2oFVndWUh6B+pirdDJ9M5VNesZNUFhT6XT48gL08oS4NY1U/mocjb3V7HJgoBA2aG+zxIkCtufVnfa0CaM09HY77x6Z5AFhcr60diKd57igxVpM+W73THea9nGkJXNYiTHgYTTuZr37moxSeRkNtguuXR6yXA9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib0PjZRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AD1C4CEDF;
	Wed, 12 Feb 2025 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739390952;
	bh=0Vb0Y7OckXhuinWilEKDEpEhT1gzrajLKbuUOaR7zZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ib0PjZRbcYaWCj2ky3bHdVAdiIzUV21orTymAHz5st7kH/KD7sUcfXfS+LDGiIUOW
	 AKN4VReKfbW1XdKD80Wd2DeXGL1PRx3W6mPNyYeneak57yTgNuaofHK+quUUSwD9PW
	 NTJ7gfWWpN/IdJW63G6+2tWJTFGnUDb5cbAohQA5JizhsMyPhv63+dv80POtxqpO79
	 50onIbswhMYaaqvaxCNmHjXHmxPc2hoyrlv8yFNnJxAwyyZC8H3G6Ki/Pu9LhL1uQT
	 Qit5j2sRJMc5vbr4k31Qe5vVP3oHzEd5E8cXyB/2gFcltTzHtVcXADmDij/vGijJAr
	 78uYz+0rtsnhg==
Message-ID: <a01a9e26-358a-4a49-9b27-b12b93695e08@kernel.org>
Date: Wed, 12 Feb 2025 13:09:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: mcast: add RCU protection to mld_newpack()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250212141021.1663666-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250212141021.1663666-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 7:10 AM, Eric Dumazet wrote:
> mld_newpack() can be called without RTNL or RCU being held.
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
>  net/ipv6/mcast.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



