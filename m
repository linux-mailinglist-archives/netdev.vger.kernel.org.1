Return-Path: <netdev+bounces-35588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74497A9D65
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CC82829DF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B51F18037;
	Thu, 21 Sep 2023 19:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D218036
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59113C116B7;
	Thu, 21 Sep 2023 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695324782;
	bh=p+UXhnZrQR7EJ2RQRdT4lBGAH7gd4Wy6J0BrwHVk6bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c0svWX9UNt4NEpB9BQl9Ja67eNqS/mHTDvKNlvIYr3P3b2SImYxQuyVwf9VD/7PVG
	 5MLYRHEbRrnGYWLnV6tIgRnoOwJLMm1KjHdcsWh477rukUaG6ARZWQlIyZc/zuWhLw
	 FQ1PdaMVKepTrnspBhSUineoKK8pRNVBUf+bDRQg/WPODTWKp0pfEi0FywhQyjwjHx
	 iX7jPg9VFc+rkgK8SviqSnsxW5zlz7PDWQLU0CCceU7DHU+FJEz5xkPoHdCu0egUvU
	 Kecjew4LR441DpOrTamuxhyuS5IFenAbLluH8MkM+8Rfp+E0eMSKQKXpoWd4k62XNd
	 cLWAHuQNlrQ4w==
Message-ID: <876b1ab4-2f28-943e-b85d-e196f46b3138@kernel.org>
Date: Thu, 21 Sep 2023 13:33:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net: fix possible store tearing in
 neigh_periodic_work()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921084626.865912-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921084626.865912-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 2:46 AM, Eric Dumazet wrote:
> While looking at a related syzbot report involving neigh_periodic_work(),
> I found that I forgot to add an annotation when deleting an
> RCU protected item from a list.
> 
> Readers use rcu_deference(*np), we need to use either
> rcu_assign_pointer() or WRITE_ONCE() on writer side
> to prevent store tearing.
> 
> I use rcu_assign_pointer() to have lockdep support,
> this was the choice made in neigh_flush_dev().
> 
> Fixes: 767e97e1e0db ("neigh: RCU conversion of struct neighbour")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/neighbour.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


