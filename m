Return-Path: <netdev+bounces-35821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD77AB283
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 14B202823FF
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58827707;
	Fri, 22 Sep 2023 13:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA871EA95
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 13:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC79DC433C7;
	Fri, 22 Sep 2023 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695388077;
	bh=ipvIcW7wJcePGb59jjHMDzJyJTw5enlWv3nXwGN8QdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=itW3iZkZmE5lAN4uYplvAvJF7FBTbEzr0HN/8zlRNwZdgZWl5L5PW0tVLgfxRV/N0
	 YvoMD54MRLA+vMtKf3QU1A+VqmIXE4unR/1BRNfZEMJnmF1g8TjVDO39ai3BgelA8j
	 /lnWP0MQc86y/HuXO2dWCDy8amzTB7KLYK58eAiU8yehbTnOsUesoWZ+rnFamHCcUp
	 AuIgiuQMHPrsg0AsnqzG4Qb47rWYi/wLnbut/N5Ehb2rcH/+VgB7uXGpvG+zB40j/z
	 YBkGlosMX+JpalZZYk1RbBLmmokEv+qa2ko05+LPnf5mDVZB9eAfESGKYRdxLw3yn+
	 Q3v6+FRSOALmQ==
Message-ID: <48ed6b4a-3739-8641-52d4-4aaa1e882ee8@kernel.org>
Date: Fri, 22 Sep 2023 07:07:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 net-next 3/8] inet: implement lockless IP_TOS
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230922034221.2471544-1-edumazet@google.com>
 <20230922034221.2471544-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230922034221.2471544-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 9:42 PM, Eric Dumazet wrote:
> Some reads of inet->tos are racy.
> 
> Add needed READ_ONCE() annotations and convert IP_TOS option lockless.
> 
> v2: missing changes in include/net/route.h (David Ahern)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h                              |  3 +-
>  include/net/route.h                           |  4 +--
>  net/dccp/ipv4.c                               |  2 +-
>  net/ipv4/inet_diag.c                          |  2 +-
>  net/ipv4/ip_output.c                          |  4 +--
>  net/ipv4/ip_sockglue.c                        | 29 ++++++++-----------
>  net/ipv4/tcp_ipv4.c                           |  9 +++---
>  net/mptcp/sockopt.c                           |  8 ++---
>  net/sctp/protocol.c                           |  4 +--
>  .../selftests/net/mptcp/mptcp_connect.sh      |  2 +-
>  10 files changed, 31 insertions(+), 36 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



