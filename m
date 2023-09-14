Return-Path: <netdev+bounces-33873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F27A08A0
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FEC1F230EC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143421356;
	Thu, 14 Sep 2023 14:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B297C28E11
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE635C433C7;
	Thu, 14 Sep 2023 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694703250;
	bh=0pbck9r2p2FEU9Ej1Vze9zXz0fAhWSx5rWdPGlTc8w4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oPyrwwXGSniq2gzJgnnqj8yk0xVU+984KYKZkKrRIyIs29VCVs+sxa8F6LkSFgIb0
	 qZoEvItkyA7VCqq+ZgwFzYpLh2vB+r35FQ09Kf4w1LGUsU9XNkxHDvg/QlyZIk/XFe
	 G4HaZ2EHuPy2ba/ZkVTFAJnCh5/52gP+g0JExYrnYDePBaLXLvShGrC94ILOmV1fSb
	 YmlNKwKWY5ukAucC3czcClPpha5Jymw/qivX5r1c0AJ5E19UQiSFnYSydW8YKS6qUh
	 O/AgjQhXXF/9B92/kNfnMtETPKz4c1qA2HIq6SUP5EAmyaTrd9ISebcVzlV20uq4mn
	 TOI6K8mRG1S9g==
Message-ID: <aa0b8610-0cc1-7b42-8a6b-a45ec3e7e610@kernel.org>
Date: Thu, 14 Sep 2023 08:54:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 02/14] ipv6: lockless IPV6_MULTICAST_LOOP
 implementation
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230912160212.3467976-1-edumazet@google.com>
 <20230912160212.3467976-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912160212.3467976-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/23 10:02 AM, Eric Dumazet wrote:
> Add inet6_{test|set|clear|assign}_bit() helpers.
> 
> Note that I am using bits from inet->inet_flags,
> this might change in the future if we need more flags.
> 
> While solving data-races accessing np->mc_loop,
> this patch also allows to implement lockless accesses
> to np->mcast_hops in the following patch.
> 
> Also constify sk_mc_loop() argument.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/ipv6.h            | 18 ++++++++++++++----
>  include/net/inet_sock.h         |  1 +
>  include/net/sock.h              |  2 +-
>  net/core/sock.c                 |  4 ++--
>  net/ipv6/af_inet6.c             |  2 +-
>  net/ipv6/ipv6_sockglue.c        | 18 ++++++++----------
>  net/ipv6/ndisc.c                |  2 +-
>  net/netfilter/ipvs/ip_vs_sync.c |  8 ++------
>  8 files changed, 30 insertions(+), 25 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


