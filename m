Return-Path: <netdev+bounces-218332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4BFB3BFCA
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7B3B937A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B3B322A25;
	Fri, 29 Aug 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnWAHT/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFD321445;
	Fri, 29 Aug 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482469; cv=none; b=YUd608Ml9stpf05a2f7+8JMRdsLxK7j0dvVFGbJO3Wh2p3Q6iZQh20ZII6hRPPt1haE0YKNc70dSnoL318ysCw+W6kKANWpoAkHWZxs3GcDT3Lt0RLLUojFUFxLAGfVPT74ZE0jHMQd3o+hBB02LXH33jh2sdKXwwopqyhv/Urg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482469; c=relaxed/simple;
	bh=H9KvmKAvBSqpdjqk6dX57n/NICaFbBX2Vntmnt9bR+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbkxkOyPAL5TSDLYmmi/50FezxggVK7NS8od9l0vqnivQOi4nX5V4z1JIL//kUVdnHJMKWnsYWOQwNMZvxO7yExr5fIqu0s783BaRkughdfw4AGIE65bzKv32J10p+5jL7vP85sD/oIbQoM5qE042m3Mu4Df4cMc34dKCIPQgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnWAHT/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11301C4CEF0;
	Fri, 29 Aug 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482468;
	bh=H9KvmKAvBSqpdjqk6dX57n/NICaFbBX2Vntmnt9bR+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WnWAHT/jdQDoqTbvqIALf+ek8Cw4SOPx/AFOPT2thEJ5XoDfcYQwAgE2gC7PFSQfF
	 PoGa8XNGOP0kjnfI9IAIdYjLTgnPTOe7PdYIVaoF59tDYLX6ce9iILNeQruMlRT2ek
	 TBJkgZ6wsZ+Hgrm5UuPFODMx+z8rpj+asWtZMyhT6WsEN0lkoVNHC6VZi7OSq69+or
	 Xjeo3BaNYM6UHzAepD3AZxddP7dyg01JdoAdI73rU/bYz5aCPNN68iXG0n2XoXVC2Y
	 v6gEtjI9rSudZUhfTlS5JauWBsGOV/PjLxEieMIqfeLK7Nh/W0mP4StTz5gz+qCMgk
	 G9/pBX/PWJFpA==
Date: Fri, 29 Aug 2025 08:47:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
Message-ID: <20250829084747.55c6386f@kernel.org>
In-Reply-To: <20250829085724.24230-1-linus.luessing@c0d3.blue>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Aug 2025 10:53:41 +0200 Linus L=C3=BCssing wrote:
> This patchset introduces new state variables to combine and reduce the
> number of checks we would otherwise perform on every multicast packet
> in fast/data path.
>  =20
> The second reason for introducing these new, internal multicast active
> variables is to later propagate a safety mechanism which was introduced
> in b00589af3b04 ("bridge: disable snooping if there is no querier") to
> switchdev/DSA, too. That is to notify switchdev/DSA if multicast
> snooping can safely be applied without potential packet loss.

Please leave the git-generated diff stat in the cover letter.
Please include tree designation in the subject, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

I'll leave the real review to the experts but this series appears
to make kselftests unhappy:

[  106.423894] WARNING: CPU: 3 PID: 1121 at net/bridge/br_multicast.c:1388 =
__br_multicast_stop+0xa0/0xc0 [bridge]
[  106.424022] Modules linked in: sch_ingress 8021q act_mirred cls_matchall=
 sch_red dummy bridge stp llc sch_tbf vrf veth
[  106.424144] CPU: 3 UID: 0 PID: 1121 Comm: ip Not tainted 6.17.0-rc2-virt=
me #1 PREEMPT(voluntary)=20
[  106.424235] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  106.424301] RIP: 0010:__br_multicast_stop+0xa0/0xc0 [bridge]
[  106.424371] Code: 89 df e8 f3 fd ff ff 80 bb 2c 01 00 00 00 75 19 80 bb =
0c 02 00 00 00 75 1d 48 8b 3b 5b 48 81 c7 4c 03 00 00 e9 b1 c2 0b f8 90 <0f=
> 0b 90 80 bb 0c 02 00 00 00 74 e3 90 0f 0b 90 48 8b 3b 5b 48 81
[  106.424544] RSP: 0018:ffffb78500283888 EFLAGS: 00010202
[  106.424586] RAX: 0000000000000000 RBX: ffff979907d81af0 RCX: 00000000000=
00000
[  106.424665] RDX: ffff979907d81c50 RSI: 0000000000000001 RDI: ffff979907d=
819c0
[  106.424753] RBP: ffff979907d819c0 R08: ffffffffb94f0180 R09: ffffb785002=
83b40
[  106.424836] R10: ffff97990342d250 R11: ffff979907d81000 R12: ffff979907d=
819c0
[  106.424913] R13: 0000000000000002 R14: 0000000000000001 R15: 00000000000=
00001
[  106.424992] FS:  00007f7e9de78800(0000) GS:ffff979985967000(0000) knlGS:=
0000000000000000
[  106.425073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.425144] CR2: 0000000000447b60 CR3: 0000000004d3b003 CR4: 00000000007=
72ef0
[  106.425226] PKRU: 55555554
[  106.425250] Call Trace:
[  106.425278]  <TASK>
[  106.425305]  br_multicast_toggle_vlan_snooping+0x1a9/0x1e0 [bridge]
[  106.425383]  br_boolopt_multi_toggle+0x54/0x90 [bridge]
[  106.425443]  br_changelink+0x4be/0x510 [bridge]
[  106.425510]  ? ns_capable+0x2d/0x60
[  106.425557]  rtnl_newlink+0x73f/0xbc0
[  106.425605]  ? rtnl_setlink+0x2c0/0x2c0
[  106.425633]  rtnetlink_rcv_msg+0x358/0x400
[  106.425676]  ? update_load_avg+0x6f/0x350
[  106.425726]  ? rtnl_calcit.isra.0+0x110/0x110
[  106.425778]  netlink_rcv_skb+0x57/0x100
[  106.425819]  netlink_unicast+0x252/0x380
[  106.425858]  ? __alloc_skb+0xdb/0x190
[  106.425904]  netlink_sendmsg+0x1be/0x3e0
[  106.425945]  ____sys_sendmsg+0x132/0x260
[  106.425984]  ? copy_msghdr_from_user+0x6c/0xa0
[  106.426039]  ___sys_sendmsg+0x87/0xd0
[  106.426083]  ? __handle_mm_fault+0xa41/0xe50
[  106.426144]  __sys_sendmsg+0x71/0xd0
[  106.426184]  do_syscall_64+0xa4/0x260
[  106.426224]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  106.426279] RIP: 0033:0x7f7e9e0451e7

