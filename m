Return-Path: <netdev+bounces-57724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBA813FE3
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C321C220F8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BA18F;
	Fri, 15 Dec 2023 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHBH74Cy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB47D279
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F814C433C7;
	Fri, 15 Dec 2023 02:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702607793;
	bh=yJ9XVJuk48nQyEOei9rfBwmUC5/fn1VYqNUprXm0HyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PHBH74CyDUohWPR2gQNzwWAQCdFRvq3PKRNzn1afL2rlWu7X7wvc4YqDGQJrplWpP
	 qWpu5CEDLREs/lXvJnQkWbZJ5kP9mhXkjCdWZ8HgG1HRXoGnjAyqaYp04G1kmk3/j/
	 +3/CtJSgj7UVbQtttodiMLQ5VqF75gDHm0OLSj8qhzN2qY6Ap/aB8W2987ZafSaqh3
	 ywQvcC96o+vvLadIi3zHOTbUgKDntxDyCZ/NY8LmvnSjD8Mj4emDqAtbbphdTwaNuu
	 /fyddHzdzmM7KHQ2AAfrZPqwP9cxRevnj24MJ/Y0zRIEzgsPqldouMI+iWS9GlYVSa
	 1mhNx2RCPc31A==
Date: Thu, 14 Dec 2023 18:36:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liu Jian <liujian56@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
 <d-tatianin@yandex-team.ru>, <justin.chen@broadcom.com>,
 <rkannoth@marvell.com>, <idosch@nvidia.com>, <jdamato@fastly.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] net: check vlan filter feature in
 vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
Message-ID: <20231214183631.578f374b@kernel.org>
In-Reply-To: <20231213040641.2653812-1-liujian56@huawei.com>
References: <20231213040641.2653812-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 12:06:41 +0800 Liu Jian wrote:
> I got the bleow warning trace:

s/bleow/below/

> WARNING: CPU: 4 PID: 4056 at net/core/dev.c:11066 unregister_netdevice_many_notify
> CPU: 4 PID: 4056 Comm: ip Not tainted 6.7.0-rc4+ #15
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:unregister_netdevice_many_notify+0x9a4/0x9b0
> Call Trace:
>  rtnl_dellink
>  rtnetlink_rcv_msg
>  netlink_rcv_skb
>  netlink_unicast
>  netlink_sendmsg
>  __sock_sendmsg
>  ____sys_sendmsg
>  ___sys_sendmsg
>  __sys_sendmsg
>  do_syscall_64
>  entry_SYSCALL_64_after_hwframe
> 
> It can be repoduced via:
> 
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode 0
>     ip netns exec ns1 ip link add bond_slave_1 type veth peer veth2
>     ip netns exec ns1 ip link set bond_slave_1 master bond0
> [1] ip netns exec ns1 ethtool -K bond0 rx-vlan-filter off
> [2] ip netns exec ns1 ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
> [3] ip netns exec ns1 ip link add link bond0 name bond0.0 type vlan id 0
> [4] ip netns exec ns1 ip link set bond_slave_1 nomaster
> [5] ip netns exec ns1 ip link del veth2
>     ip netns del ns1

Could you construct a selftest based on those commands?

> This is all caused by command [1] turning off the rx-vlan-filter function
> of bond0. The reason is the same as commit 01f4fd270870 ("bonding: Fix
> incorrect deletion of ETH_P_8021AD protocol vid from slaves"). Commands
> [2] [3] add the same vid to slave and master respectively, causing
> command [4] to empty slave->vlan_info. The following command [5] triggers
> this problem.
> 
> To fix this problem, we should add VLAN_FILTER feature checks in
> vlan_vids_add_by_dev() and vlan_vids_del_by_dev() to prevent incorrect
> addition or deletion of vlan_vid information.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Did the STAG/CTAG features exist in 2.6? I thought I saw the commit
that added them in git at some point. Could be misremembering...

> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1->v2: Modify patch title and commit message.
> 	Remove superfluous operations in ethtool/features.c and ioctl.c
>  net/8021q/vlan_core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index 0beb44f2fe1f..e94b509386bb 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -407,6 +407,12 @@ int vlan_vids_add_by_dev(struct net_device *dev,
>  		return 0;
>  
>  	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +		    vid_info->proto == htons(ETH_P_8021Q))
> +			continue;
> +		if (!(by_dev->features & NETIF_F_HW_VLAN_STAG_FILTER) &&
> +		    vid_info->proto == htons(ETH_P_8021AD))
> +			continue;

this code is copied 3 times, could you please factor it out to a helper
taking dev and vid_info and deciding if the walk should skip?
-- 
pw-bot: cr

