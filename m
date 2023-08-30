Return-Path: <netdev+bounces-31417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C637378D6BC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88571C2074A
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136B6D3F;
	Wed, 30 Aug 2023 14:56:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055E3FFB
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8728EC433C7;
	Wed, 30 Aug 2023 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693407396;
	bh=IS46+TBmhUHbfuH5nVePActDLfTq/Oi6sRGuRduxrmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qHy9jTtGEg/fCr/5nboCSnE1caI+5DXfDYyGNRKLl+DJFlGds/lw9TZuHkpZb/1iB
	 dfS/uAoIm6JziGy+V9iXfvN+7GuVdVcQA6D81pxFePkWeOQlPmWE/2skB85Jx8BbVW
	 SPpibj+q+WOvHgUlX27bhsg72m6vJ/GWqTvn4SkL7Cevx4UngWVNaFFX8rcdE7rRZQ
	 HpiAcoCAb/njBurPZy90bCAhKtNLSJmB5fadd4BdxYf18LCliTyAcVsgvzAi10S1cF
	 /a7Yk6DIXI4p6yRZkqWa8AxMww2wPvceruemx5jfXrbkLwZuIg4OFM0+O+7+EbUmP3
	 8Z1VOKVYV4aGw==
Message-ID: <7aec656a-f9dc-776b-a4a7-ef16370d0cef@kernel.org>
Date: Wed, 30 Aug 2023 08:56:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] net: fib: avoid warn splat in flow dissector
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: Stanislav Fomichev <sdf@google.com>, Ido Schimmel <idosch@nvidia.com>
References: <20230830110043.30497-1-fw@strlen.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230830110043.30497-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/23 5:00 AM, Florian Westphal wrote:
> New skbs allocated via nf_send_reset() have skb->dev == NULL.
> 
> fib*_rules_early_flow_dissect helpers already have a 'struct net'
> argument but its not passed down to the flow dissector core, which
> will then WARN as it can't derive a net namespace to use:
> 
>  WARNING: CPU: 0 PID: 0 at net/core/flow_dissector.c:1016 __skb_flow_dissect+0xa91/0x1cd0
>  [..]
>   ip_route_me_harder+0x143/0x330
>   nf_send_reset+0x17c/0x2d0 [nf_reject_ipv4]
>   nft_reject_inet_eval+0xa9/0xf2 [nft_reject_inet]
>   nft_do_chain+0x198/0x5d0 [nf_tables]
>   nft_do_chain_inet+0xa4/0x110 [nf_tables]
>   nf_hook_slow+0x41/0xc0
>   ip_local_deliver+0xce/0x110
>   ..
> 
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Fixes: 812fa71f0d96 ("netfilter: Dissect flow after packet mangling")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217826
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/net/ip6_fib.h | 5 ++++-
>  include/net/ip_fib.h  | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



