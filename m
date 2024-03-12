Return-Path: <netdev+bounces-79360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28699878D7D
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 04:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDB01F21F44
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8220AD53;
	Tue, 12 Mar 2024 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBNCOOpD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B6AD4B
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 03:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214135; cv=none; b=JGddP5eQg0ITH5kFzeBUrmp6siSQ9fkiMco55HVIUgnvOX3j4jZqKWbeXxaYdlk3WmV+qYqWTY0bX9Fb3fg49WTcNp0I8Tdm7iyKKW4OjrWFuOSGluJzXB5LrLPf70gOiVWPFojTI56s1mNTtQEJwyKKX86lfXAylrbUi7qqK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214135; c=relaxed/simple;
	bh=wWsb3jNGG7p37/spo1MKPPAS3oWHeRrEErQZKntRCrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXAf/6DgpRD1k7Vd76RWJMWDDGsM7AVCToBfrdTiDLjkTs72+VY0ez+1fKJ/Wog9gLqq7Rp6dqKllYxTG+ThAWU0+qbNjj5qTJ7yffPHwB3BdJhTKRUSIyGrQJKt0Oe50il+TeocEo90jIl2OIQCPda3FaiUGl9mUe9dsf1FMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBNCOOpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9317C433C7;
	Tue, 12 Mar 2024 03:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214135;
	bh=wWsb3jNGG7p37/spo1MKPPAS3oWHeRrEErQZKntRCrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YBNCOOpDCSLNDD6M1J5duEzxyUreAXViahUkU5nTgHLAIYXWhNpjZxNOAk2/DmYqI
	 2j6EP2dHzjtAKZc+GZlfg0s7+exQZn9GRhd0NbyxfomS8vkuDWF4ByNK/WuSWxpDuM
	 WLXhvqj5OZ1iZb/UjLiY+Gn8ebguS8xsv3Z8VuzNV8VqnMEEp+pli4cZUjbmVHX7eL
	 iFGil4oxC1mbwWV0COeCMdprooAzo2oLc2qwu0rUNZRPlmb3KPvRPKL/ZfMh7H7XFm
	 307vNMpn3KeVIQUGee4vBAxK2wbOc1jEhLlCW8eLKrxquvsfz/YGtcjjy4q4LZakEd
	 WIQd7bN7lwi1Q==
Message-ID: <d3f29160-e44e-418e-967c-321b78ffc66b@kernel.org>
Date: Mon, 11 Mar 2024 21:28:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] nexthop: Fix splat with
 CONFIG_DEBUG_PREEMPT=y
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com
References: <20240311162307.545385-1-idosch@nvidia.com>
 <20240311162307.545385-5-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240311162307.545385-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 10:23 AM, Ido Schimmel wrote:
> Locally generated packets can increment the new nexthop statistics from
> process context, resulting in the following splat [1] due to preemption
> being enabled. Fix by using get_cpu_ptr() / put_cpu_ptr() which will
> which take care of disabling / enabling preemption.
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: ping/949
> caller is nexthop_select_path+0xcf8/0x1e30
> CPU: 12 PID: 949 Comm: ping Not tainted 6.8.0-rc7-custom-gcb450f605fae #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xbd/0xe0
>  check_preemption_disabled+0xce/0xe0
>  nexthop_select_path+0xcf8/0x1e30
>  fib_select_multipath+0x865/0x18b0
>  fib_select_path+0x311/0x1160
>  ip_route_output_key_hash_rcu+0xe54/0x2720
>  ip_route_output_key_hash+0x193/0x380
>  ip_route_output_flow+0x25/0x130
>  raw_sendmsg+0xbab/0x34a0
>  inet_sendmsg+0xa2/0xe0
>  __sys_sendto+0x2ad/0x430
>  __x64_sys_sendto+0xe5/0x1c0
>  do_syscall_64+0xc5/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [...]
> 
> Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/nexthop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


