Return-Path: <netdev+bounces-25279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A3773AC9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3592D28184C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9AB12B6E;
	Tue,  8 Aug 2023 14:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B512B6C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA483C433C8;
	Tue,  8 Aug 2023 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691506429;
	bh=zA1OCrH55aDFXkN266uLWpevKy6aTch/pTqap4YDST4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kzz0e0QVv4Eja1ugd1NoRS3yaKE2KFUyshpyh4zOzL71KQeTck9703LCrkuJuk47k
	 SMIzMNBkhzeUP0jeGDgpDOtn8POsmKHJJzbcbJOKYMZuh95Wofhz6ZcTYmhn5Vc2z/
	 EQeT2fQ4JinVfK0THfYAYQoHG1srNNs2ByvBoZRSd2zOO4Uwi+CxfY1a/tRcGyJ6gp
	 +LSBjlBxk2muuGAm5WoORWyUT1d7HN2r0MIXWbiDL1f0P616NlAKrl33mELAoHPVtQ
	 Z3TLJh9clRsWGjGWawk7NU3dijhZdbkBZvv8rcJLboqdUIvkOo+C1EyTg7geiT6v7W
	 F1EjcJXugz6XA==
Message-ID: <81cc614c-901e-ff0b-6185-6fa898ddf39a@kernel.org>
Date: Tue, 8 Aug 2023 08:53:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net 2/3] nexthop: Make nexthop bucket dump more efficient
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20230808075233.3337922-1-idosch@nvidia.com>
 <20230808075233.3337922-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230808075233.3337922-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/23 1:52 AM, Ido Schimmel wrote:
> rtm_dump_nexthop_bucket_nh() is used to dump nexthop buckets belonging
> to a specific resilient nexthop group. The function returns a positive
> return code (the skb length) upon both success and failure.
> 
> The above behavior is problematic. When a complete nexthop bucket dump
> is requested, the function that walks the different nexthops treats the
> non-zero return code as an error. This causes buckets belonging to
> different resilient nexthop groups to be dumped using different buffers
> even if they can all fit in the same buffer:
> 
>  # ip link add name dummy1 up type dummy
>  # ip nexthop add id 1 dev dummy1
>  # ip nexthop add id 10 group 1 type resilient buckets 1
>  # ip nexthop add id 20 group 1 type resilient buckets 1
>  # strace -e recvmsg -s 0 ip nexthop bucket
>  [...]
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
>  id 10 index 0 idle_time 10.27 nhid 1
>  [...]
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
>  id 20 index 0 idle_time 6.44 nhid 1
>  [...]
> 
> Fix by only returning a non-zero return code when an error occurred and
> restarting the dump from the bucket index we failed to fill in. This
> allows buckets belonging to different resilient nexthop groups to be
> dumped using the same buffer:
> 
>  # ip link add name dummy1 up type dummy
>  # ip nexthop add id 1 dev dummy1
>  # ip nexthop add id 10 group 1 type resilient buckets 1
>  # ip nexthop add id 20 group 1 type resilient buckets 1
>  # strace -e recvmsg -s 0 ip nexthop bucket
>  [...]
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 128
>  id 10 index 0 idle_time 30.21 nhid 1
>  id 20 index 0 idle_time 26.7 nhid 1
>  [...]
> 
> While this change is more of a performance improvement change than an
> actual bug fix, it is a prerequisite for a subsequent patch that does
> fix a bug.
> 
> Fixes: 8a1bbabb034d ("nexthop: Add netlink handlers for bucket dump")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



