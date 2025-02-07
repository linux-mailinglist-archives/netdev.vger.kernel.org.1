Return-Path: <netdev+bounces-164202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DBA2CE6A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E098A16B1F3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6C1A5B98;
	Fri,  7 Feb 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek+Zpb4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D719C556
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961209; cv=none; b=qPxtzJvqXzB91nuS5q/TnqsXuYpUWdJL6OQVY6Cc+oj8ERo/TQDnFgua29QkpbfB0uXc1aCHpB+NdCL4fktRbVY/XEy/gOquciVzvyp589VdACpKo9J+1rqxBi00AST8C9l6aAcyj+sZdK+hikiAp6RFZV5Sq3JHtd5I4zQhZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961209; c=relaxed/simple;
	bh=wNu0FCrMnUuOe+aoGHf9ZCXi5JMovNtO0Q48DNJNFAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkKTW00GoqdCbZrcVsX41t+9g24woBNTpp8tE6Qeo51odYsCSg9msvqPGdZJzk16FSiW5brpc0hAkcy8EP/GhxeXctlfnaESG5Fuhez+cEUkPPGoho1FLWH++8KALfyMqgO8dIP+WCb8qnDZeyYuYdLDFE8JVTDopXQu3ECi3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek+Zpb4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FBC4CED1;
	Fri,  7 Feb 2025 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961209;
	bh=wNu0FCrMnUuOe+aoGHf9ZCXi5JMovNtO0Q48DNJNFAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ek+Zpb4uJktyZ1fNAFGIYkkSavS5yqKf+nfk5hIMdkwvSwRELWOcYlloyW7Der9Kb
	 bTmi5K3kUm1Y5yNn0YLwC4uQvrFubppoF082NkzSLy6I4LiGfuT0QJHLHJOdkNaGNY
	 /JTQb3iTzPcbXqNNL6vKA2iJ6ms50Jq6i/7Pwcf/tUGHGQ7EQjKz/S5XUSEEFEUvX5
	 KRuokIKvv9nBXeHu3IDoGJKU+TCVbzzpuR6zUg1W3c0uWcl5qH20AwdsFbSmLcyuRq
	 IcLfpkH/sev7kku3tU3eHYr6yjxXY5TV+/lcozOIgIuN3tAWx0VCU0ZVgGHuIpX1pj
	 fPiRYF5hXFY3Q==
Message-ID: <1b407f1c-a00b-46fc-98f9-bc2193ee9255@kernel.org>
Date: Fri, 7 Feb 2025 13:46:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/8] ndisc: extend RCU protection in ndisc_send_skb()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250207135841.1948589-1-edumazet@google.com>
 <20250207135841.1948589-8-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250207135841.1948589-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:58 AM, Eric Dumazet wrote:
> ndisc_send_skb() can be called without RTNL or RCU held.
> 
> Acquire rcu_read_lock() earlier, so that we can use dev_net_rcu()
> and avoid a potential UAF.
> 
> Fixes: 1762f7e88eb3 ("[NETNS][IPV6] ndisc - make socket control per namespace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ndisc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



