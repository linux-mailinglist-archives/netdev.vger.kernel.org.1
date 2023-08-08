Return-Path: <netdev+bounces-25280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D12773ACB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6163F281880
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429D12B6F;
	Tue,  8 Aug 2023 14:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770812B6C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46538C433C8;
	Tue,  8 Aug 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691506465;
	bh=ou2m41GAb2PoXwHYH0rBwWUzzY3t0vieCxnqZys3PnM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YNrL464sEed8fCE4fk0s3zimL/Y7vr5KvJCiPaa+k2+b6T4035OUEqv21HRJNmmQm
	 uC0iwLrmhuOR1f5hM3CqxLB1NgUl+nfI1DvuIFBz77yPIr3H5ufaLrOGcDeUcarorR
	 c71HoWE6XxbfZydb1HVvupZrXocJ7sp2TEhaW2q5F+DZ91AMQ0/DuysoYROIFUVHsY
	 cYDK2z2A0G8unMI7b0lv2yWFkcJeTBfD0MRJPdSyIBOUS7Zh2zU7hZig0a6gp9ShMf
	 r6NdmJid773tSXR9aid5VoYkh9NXGF9tn2liKgPho2xX7kq5lBgTtf4YawBYfOHgzk
	 AIM68YKhjBfJw==
Message-ID: <c7addf11-e60c-f5da-ad81-dfde959fd3d8@kernel.org>
Date: Tue, 8 Aug 2023 08:54:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net 3/3] nexthop: Fix infinite nexthop bucket dump when
 using maximum nexthop ID
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20230808075233.3337922-1-idosch@nvidia.com>
 <20230808075233.3337922-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230808075233.3337922-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/23 1:52 AM, Ido Schimmel wrote:
> A netlink dump callback can return a positive number to signal that more
> information needs to be dumped or zero to signal that the dump is
> complete. In the second case, the core netlink code will append the
> NLMSG_DONE message to the skb in order to indicate to user space that
> the dump is complete.
> 
> The nexthop bucket dump callback always returns a positive number if
> nexthop buckets were filled in the provided skb, even if the dump is
> complete. This means that a dump will span at least two recvmsg() calls
> as long as nexthop buckets are present. In the last recvmsg() call the
> dump callback will not fill in any nexthop buckets because the previous
> call indicated that the dump should restart from the last dumped nexthop
> ID plus one.
> 
>  # ip link add name dummy1 up type dummy
>  # ip nexthop add id 1 dev dummy1
>  # ip nexthop add id 10 group 1 type resilient buckets 2
>  # strace -e sendto,recvmsg -s 5 ip nexthop bucket
>  sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOPBUCKET, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691396980, nlmsg_pid=0}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 128
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396980, nlmsg_pid=347}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], [{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396980, nlmsg_pid=347}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 128
>  id 10 index 0 idle_time 6.66 nhid 1
>  id 10 index 1 idle_time 6.66 nhid 1
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 20
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396980, nlmsg_pid=347}, 0], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
>  +++ exited with 0 +++
> 
> This behavior is both inefficient and buggy. If the last nexthop to be
> dumped had the maximum ID of 0xffffffff, then the dump will restart from
> 0 (0xffffffff + 1) and never end:
> 
>  # ip link add name dummy1 up type dummy
>  # ip nexthop add id 1 dev dummy1
>  # ip nexthop add id $((2**32-1)) group 1 type resilient buckets 2
>  # ip nexthop bucket
>  id 4294967295 index 0 idle_time 5.55 nhid 1
>  id 4294967295 index 1 idle_time 5.55 nhid 1
>  id 4294967295 index 0 idle_time 5.55 nhid 1
>  id 4294967295 index 1 idle_time 5.55 nhid 1
>  [...]
> 
> Fix by adjusting the dump callback to return zero when the dump is
> complete. After the fix only one recvmsg() call is made and the
> NLMSG_DONE message is appended to the RTM_NEWNEXTHOPBUCKET responses:
> 
>  # ip link add name dummy1 up type dummy
>  # ip nexthop add id 1 dev dummy1
>  # ip nexthop add id $((2**32-1)) group 1 type resilient buckets 2
>  # strace -e sendto,recvmsg -s 5 ip nexthop bucket
>  sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOPBUCKET, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691396737, nlmsg_pid=0}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 148
>  recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396737, nlmsg_pid=350}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], [{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396737, nlmsg_pid=350}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396737, nlmsg_pid=350}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 148
>  id 4294967295 index 0 idle_time 6.61 nhid 1
>  id 4294967295 index 1 idle_time 6.61 nhid 1
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
>  # ./fib_nexthops.sh -t basic_res
>  [...]
>  TEST: Maximum nexthop ID dump                                       [FAIL]
>  [...]
> 
> And passes after it:
> 
>  # ./fib_nexthops.sh -t basic_res
>  [...]
>  TEST: Maximum nexthop ID dump                                       [ OK ]
>  [...]
> 
> Fixes: 8a1bbabb034d ("nexthop: Add netlink handlers for bucket dump")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/ipv4/nexthop.c                          | 6 +-----
>  tools/testing/selftests/net/fib_nexthops.sh | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



