Return-Path: <netdev+bounces-31653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2D78F554
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF832810B1
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D081AA80;
	Thu, 31 Aug 2023 22:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF601AA79
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 22:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFFFC433C8;
	Thu, 31 Aug 2023 22:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693520388;
	bh=enfb8TSresSVrhYoJxYi4z+rBQX1sv1LnUfIkz3MX44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MKdA2Qmjelh6UnDJ8AIr16eqfVbBv3tFb+DVzgzrRw8oTYhADWap77+EQExtjxO2A
	 Yy/+sH2EVPM1izbvYg1/hiuvDTw/arkJxQCqgSbggP54I2opkyd4fdXCzLsAsNCIyc
	 WOQy32WEfd5q7enj4ghHhEF9wv9c+DBsp7+PqA2dCdvUCprF8mb9+XO8DUHHIRd5vB
	 GPMIyJfi8aahJEfb3aHBUE+YwBSFWUbJmrWECyq7LTg1SIBV6d1qDQiAt3SPO/FT2Y
	 QjL4/GhKQgWRkv3t7+tdkmVLn5ISdOm7sy3O8CkG1+ysW9DU1L9kUdoQheb/CQPMd8
	 uOM7+tpUUPz7A==
Message-ID: <3e4c3524-9b6a-3435-96ea-70dd65be8893@kernel.org>
Date: Thu, 31 Aug 2023 16:19:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net] gve: fix frag_list chaining
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Bailey Forrest <bcf@google.com>, Willem de Bruijn <willemb@google.com>,
 Catherine Sullivan <csully@google.com>
References: <20230831213812.3042540-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230831213812.3042540-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/23 3:38 PM, Eric Dumazet wrote:
> gve_rx_append_frags() is able to build skbs chained with frag_list,
> like GRO engine.
> 
> Problem is that shinfo->frag_list should only be used
> for the head of the chain.
> 
> All other links should use skb->next pointer.
> 
> Otherwise, built skbs are not valid and can cause crashes.
> 
> Equivalent code in GRO (skb_gro_receive()) is:
> 
>     if (NAPI_GRO_CB(p)->last == p)
>         skb_shinfo(p)->frag_list = skb;
>     else
>         NAPI_GRO_CB(p)->last->next = skb;
>     NAPI_GRO_CB(p)->last = skb;
> 
> Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Bailey Forrest <bcf@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Catherine Sullivan <csully@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



