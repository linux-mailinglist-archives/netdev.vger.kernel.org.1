Return-Path: <netdev+bounces-250710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B7D38FA6
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC8913009ABB
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7021E0AF;
	Sat, 17 Jan 2026 16:03:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A521F4CBB
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768665812; cv=none; b=Tv64tKTFP1ONLtWgHdG+P/TEkBX0M25t9+H6xv331GXTT2BN6dr7AolzLrVmg7hR2za4SGZ5fdOGTxtVYTHxMI266sM5MENtfwYXYsM9u71zD76sbvmyChpJ7IrnBCek+yPd/tk+rBNVwr353OCrsYYSRlp3idxDRlAR8i/ijlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768665812; c=relaxed/simple;
	bh=Ma1E0nAO2b/GiJXUClauXrtjaKgZh5FU8rDFdNw1sZw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rzAtuQvecvu4p+rUnyOcb6/elQwtVdUm/Kj1z7L9oIMTnZ/UPRJJnZ06jby8La2BJKg1edbJ0BQ0l2TZ28ONIxpwq0nw5DUrnB81re94GBb9OkOn3qDp0IBo6X84nqQZ/iEe9DwXPsdxuGo0Kzy4nkiD2rLcypnTk1OUcA+LIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60HG3S2s009369;
	Sun, 18 Jan 2026 01:03:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60HG3Sw5009366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 18 Jan 2026 01:03:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
Date: Sun, 18 Jan 2026 01:03:27 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Aviad Yehezkel <aviadye@mellnaox.com>, Aviv Heller <avivh@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, Guy Shapiro <guysh@mellanox.com>,
        Ilan Tayari <ilant@mellanox.com>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Yossi Kuperman <yossiku@mellanox.com>
Cc: Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: xfrm: question regarding NETDEV_UNREGISTER handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting that "struct xfrm_state" refcount is leaking.

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

Commit d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API") introduced
xfrm_dev_state_add() which grabs a reference to "struct net_device".
That commit called xfrm_dev_state_add() from xfrm_state_construct() and
introduced the NETDEV_UNREGISTER case to xfrm_dev_event(), but
xfrm_dev_unregister() was a no-op (rather than doing necessary actions
for releasing "struct xfrm_state" which will in turn drop the reference
to "struct net_device").

Commit 152afb9b45a8 ("xfrm: Indicate xfrm_state offload errors") added
proper error code propagation, and commit cc01572e2fb0 ("xfrm: Add SA to
hardware at the end of xfrm_state_construct()") moved the location to call
xfrm_dev_state_add(), but these commits did not touch NETDEV_UNREGISTER
handling.

Commit ec30d78c14a8 ("xfrm: add xdst pcpu cache") added
xfrm_policy_cache_flush() call to xfrm_dev_unregister(), but
commit e4db5b61c572 ("xfrm: policy: remove pcpu policy cache") removed
xfrm_policy_cache_flush() call from xfrm_dev_unregister() and also
removed the NETDEV_UNREGISTER case from xfrm_dev_event() because
xfrm_dev_unregister() became no-op.

Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
re-introduced the NETDEV_UNREGISTER case to xfrm_dev_event(), but that
commit chose to do the same thing for NETDEV_DOWN case and
NETDEV_UNREGISTER case. Since xfrm_dev_down() is no-op unless
(dev->features & NETIF_F_HW_ESP) != 0, no necessary actions are done for
releasing "struct xfrm_state" (for at least !NETIF_F_HW_ESP case).

Commit 919e43fad516 ("xfrm: add an interface to offload policy") added
xfrm_dev_policy_flush() to xfrm_dev_down(). I don't know whether this commit
is relevant or not.

But I feel that calling xfrm_dev_state_add() and  xfrm_dev_policy_add()
are possible for !NETIF_F_HW_ESP case. If my feeling is correct, we have
never implemented proper NETDEV_UNREGISTER handling for releasing
"struct xfrm_state". What actions are needed for properly releasing
"struct xfrm_state" from NETDEV_UNREGISTER handler?

