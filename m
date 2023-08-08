Return-Path: <netdev+bounces-25278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C54773AC8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4D1C20FF5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4D12B6C;
	Tue,  8 Aug 2023 14:53:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F637C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7B1C433C8;
	Tue,  8 Aug 2023 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691506413;
	bh=HuUYTjjYVnQOERNoSA9neyG21fRczFPu0hILI0XF+T8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q6G7GRrFcME8xxsMojOG5IrfZizeGXQ4gOQfOqLOCW6FplO2ErjJxT1NUEvPqhvX7
	 MIY89FfXS4spxUa/NktKsibaTnCFi5mGiZHKGe3BF8TlTszGonEHReFlIbj/rDes41
	 IkCH+5oI898mGkG4st/mJwJ9aShi4ThiiJBp9yeN3v3vqQUj4vRjcXwKYbWYBhjB7t
	 yxbMNhckz7qFnxriwbYWJ7PMFfXHp9sfkSeVETSJYlDtZ1fiG7Q74f8P/UtmbYOILa
	 /+QhTq8Ad5V88DJKBmQkZ1Yy1heykKEWgjijFXdmVbgnenoIQxYyaf13txEjqpfR5n
	 GhOPFZqu6m/zg==
Message-ID: <1570bd85-87e6-6dc5-6c1b-03529bd5b412@kernel.org>
Date: Tue, 8 Aug 2023 08:53:31 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net 1/3] nexthop: Fix infinite nexthop dump when using
 maximum nexthop ID
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20230808075233.3337922-1-idosch@nvidia.com>
 <20230808075233.3337922-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230808075233.3337922-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/23 1:52 AM, Ido Schimmel wrote:
> A netlink dump callback can return a positive number to signal that more
> information needs to be dumped or zero to signal that the dump is
> complete. In the second case, the core netlink code will append the
> NLMSG_DONE message to the skb in order to indicate to user space that
> the dump is complete.
> 
> The nexthop dump callback always returns a positive number if nexthops
> were filled in the provided skb, even if the dump is complete. This
> means that a dump will span at least two recvmsg() calls as long as
> nexthops are present. In the last recvmsg() call the dump callback will
> not fill in any nexthops because the previous call indicated that the
> dump should restart from the last dumped nexthop ID plus one.
> 
>  # ip nexthop add id 1 blackhole
>  # strace -e sendto,recvmsg -s 5 ip nexthop
>  sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOP, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691394315, nlmsg_pid=0}, {nh_family=AF_UNSPEC, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 36
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=36, nlmsg_type=RTM_NEWNEXTHOP, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394315, nlmsg_pid=343}, {nh_family=AF_INET, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}, [[{nla_len=8, nla_type=NHA_ID}, 1], {nla_len=4, nla_type=NHA_BLACKHOLE}]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 36
>  id 1 blackhole
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 20
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394315, nlmsg_pid=343}, 0], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
>  +++ exited with 0 +++
> 
> This behavior is both inefficient and buggy. If the last nexthop to be
> dumped had the maximum ID of 0xffffffff, then the dump will restart from
> 0 (0xffffffff + 1) and never end:
> 
>  # ip nexthop add id $((2**32-1)) blackhole
>  # ip nexthop
>  id 4294967295 blackhole
>  id 4294967295 blackhole
>  [...]
> 
> Fix by adjusting the dump callback to return zero when the dump is
> complete. After the fix only one recvmsg() call is made and the
> NLMSG_DONE message is appended to the RTM_NEWNEXTHOP response:
> 
>  # ip nexthop add id $((2**32-1)) blackhole
>  # strace -e sendto,recvmsg -s 5 ip nexthop
>  sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOP, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691394080, nlmsg_pid=0}, {nh_family=AF_UNSPEC, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 56
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=36, nlmsg_type=RTM_NEWNEXTHOP, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394080, nlmsg_pid=342}, {nh_family=AF_INET, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}, [[{nla_len=8, nla_type=NHA_ID}, 4294967295], {nla_len=4, nla_type=NHA_BLACKHOLE}]], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394080, nlmsg_pid=342}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 56
>  id 4294967295 blackhole
>  +++ exited with 0 +++
> 
> Note that if the NLMSG_DONE message cannot be appended because of size
> limitations, then another recvmsg() will be needed, but the core netlink
> code will not invoke the dump callback and simply reply with a
> NLMSG_DONE message since it knows that the callback previously returned
> zero.
> 
> Add a test that fails before the fix:
> 
>  # ./fib_nexthops.sh -t basic
>  [...]
>  TEST: Maximum nexthop ID dump                                       [FAIL]
>  [...]
> 
> And passes after it:
> 
>  # ./fib_nexthops.sh -t basic
>  [...]
>  TEST: Maximum nexthop ID dump                                       [ OK ]
>  [...]
> 
> Fixes: ab84be7e54fc ("net: Initial nexthop code")
> Reported-by: Petr Machata <petrm@nvidia.com>
> Closes: https://lore.kernel.org/netdev/87sf91enuf.fsf@nvidia.com/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/ipv4/nexthop.c                          | 6 +-----
>  tools/testing/selftests/net/fib_nexthops.sh | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



