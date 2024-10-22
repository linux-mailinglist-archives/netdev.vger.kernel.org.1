Return-Path: <netdev+bounces-137930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D733E9AB259
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A89BB215F6
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79F19D082;
	Tue, 22 Oct 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTtejDMl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11359B71
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611846; cv=none; b=fyuyZCZJ/P9ms1JcwYfL/Oh39lURICk4V+qYUJ480jYdz6CfsW6X2CmxEI4i3LRoGymTQ9fM5AdxuyctHbekyJ84XbdVSRxdiKu0zbGe3xs2WNgSWK1wjg4yrVB9lQLg4Zf2FuRlnfTNuMZk4ajglqtNzM/3vypSSgpR75uCebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611846; c=relaxed/simple;
	bh=2n0DwXyfQztO24SkX/DpDvIgRxJaMfVCH8AFQ25yZEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gwi1OuGFJhCzQRyVQONTAPf8+LY/bs9hYlr4c/q0JYaqxal9PquTkZOPHRFTq6uQgAxMJz3R4uZOICAaGnYFe/PKgrE/NxEc2JIsXsdv/JGMLp95rVa/q2UlP+P9mkbtTBy+1mA+brznS8vgGp6dQ3LBfvYPnV5fjSSaOUstRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTtejDMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E6BC4CEC3;
	Tue, 22 Oct 2024 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611845;
	bh=2n0DwXyfQztO24SkX/DpDvIgRxJaMfVCH8AFQ25yZEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aTtejDMl9IH5GqE/2GfEy1xvYR0fWXiXTYWZXCkv3AL6Ps+H04sAuJ2e1ck8dygLB
	 dIYBZNPGeZQuIkkPkXAxMg95V8s7GMazus3Vlxk0vMrKMUrTc7KbFdgx0yAczYnIFA
	 LY/iTi5rY+sisA38H8sQqFt2/8LVH+JT0lXGs1hDkhu6D3+QD/1tk0rtQp7IlBeIu/
	 iXVAOpvQMvUGj1QEClsdEAPxwLwWvDzpaSmiVPIkOVJ5sF6Wm+ToSzsIbi2xt8iNyY
	 ACZgkbB9+92t5tUHAN5SJ22MkpUOQYK9pRR5V4KfhduPGiGAh1lfxcDJl+8pbR9Lbc
	 rDNCYMSPgNyqA==
Message-ID: <529331cf-4791-4e6c-ab67-89d6dde66f90@kernel.org>
Date: Tue, 22 Oct 2024 09:44:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in
 ip_tunnel_init_flow()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org
References: <20241022063822.462057-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241022063822.462057-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 12:38 AM, Ido Schimmel wrote:
> There are code paths from which the function is called without holding
> the RCU read lock, resulting in a suspicious RCU usage warning [1].
> 
> Fix by using l3mdev_master_upper_ifindex_by_index() which will acquire
> the RCU read lock before calling
> l3mdev_master_upper_ifindex_by_index_rcu().
> 
> [1]
> WARNING: suspicious RCU usage
> 6.12.0-rc3-custom-gac8f72681cf2 #141 Not tainted
> -----------------------------
> net/core/dev.c:876 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by ip/361:
>  #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60
> 
> stack backtrace:
> CPU: 3 UID: 0 PID: 361 Comm: ip Not tainted 6.12.0-rc3-custom-gac8f72681cf2 #141
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xba/0x110
>  lockdep_rcu_suspicious.cold+0x4f/0xd6
>  dev_get_by_index_rcu+0x1d3/0x210
>  l3mdev_master_upper_ifindex_by_index_rcu+0x2b/0xf0
>  ip_tunnel_bind_dev+0x72f/0xa00
>  ip_tunnel_newlink+0x368/0x7a0
>  ipgre_newlink+0x14c/0x170
>  __rtnl_newlink+0x1173/0x19c0
>  rtnl_newlink+0x6c/0xa0
>  rtnetlink_rcv_msg+0x3cc/0xf60
>  netlink_rcv_skb+0x171/0x450
>  netlink_unicast+0x539/0x7f0
>  netlink_sendmsg+0x8c1/0xd80
>  ____sys_sendmsg+0x8f9/0xc20
>  ___sys_sendmsg+0x197/0x1e0
>  __sys_sendmsg+0x122/0x1f0
>  do_syscall_64+0xbb/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: db53cd3d88dc ("net: Handle l3mdev in ip_tunnel_init_flow")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_tunnels.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



