Return-Path: <netdev+bounces-35574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925FD7A9C74
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61FD282DF1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FB9CA44;
	Thu, 21 Sep 2023 19:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B59CA42
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0305C433C7;
	Thu, 21 Sep 2023 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695323414;
	bh=OsddfhZZNaovHAfvxR6GOOhcxdW6sx5FotsIGV/i4zc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qf0z3Vh9pRGNCTc2kLn8VPWamMlPuxYFoedseW1XwCBlEWKVCa2jbe+y742ZIMGs0
	 0lciVaP1Dpg57+sXAV59skXE8kybZzx5uyHawvjgtqwTsmEZvagIKVliLUA0qsPrZp
	 i+9QfoZMFSHzTXB1i+1BNVbE7FXnjfZEsbue8392YHr0VvAPjWBSFFv6alWeGyIipo
	 Af8RpgXXt1HqhOd19j060aAhXJkrzuOQNz3PRDSNsAM5ShSpfanytseBpU77NWgw6/
	 5oTKi8kJEEkGY6q8Ma1w6wMoRxqCY5E+1Q09mrJXPakkXr/+WmG4+1ZdPg5WKLXViL
	 OVJ79NQdNSW5g==
Message-ID: <3473bea6-00c8-2949-5029-122b599be9b2@kernel.org>
Date: Thu, 21 Sep 2023 13:10:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 3/8] inet: implement lockless IP_TOS
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921133021.1995349-1-edumazet@google.com>
 <20230921133021.1995349-4-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230921133021.1995349-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/23 7:30 AM, Eric Dumazet wrote:
> Some reads of inet->tos are racy.
> 
> Add needed READ_ONCE() annotations and convert IP_TOS option lockless.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h                              |  1 -
>  net/dccp/ipv4.c                               |  2 +-
>  net/ipv4/inet_diag.c                          |  2 +-
>  net/ipv4/ip_output.c                          |  4 +--
>  net/ipv4/ip_sockglue.c                        | 29 ++++++++-----------
>  net/ipv4/tcp_ipv4.c                           |  9 +++---
>  net/mptcp/sockopt.c                           |  8 ++---
>  net/sctp/protocol.c                           |  4 +--
>  .../selftests/net/mptcp/mptcp_connect.sh      |  2 +-
>  9 files changed, 28 insertions(+), 33 deletions(-)
> 

include/net/route.h dereferences sk tos as well.
net/ipv4/icmp.c has a setting of it


