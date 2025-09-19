Return-Path: <netdev+bounces-224691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E450B886A1
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD7F1C860D5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A03064A6;
	Fri, 19 Sep 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gIW7uz8B"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B6305E2F
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270431; cv=none; b=TBdGib6NkOLKhGCD2S4W2nAabSx/XuCDlmbdCowJ8BDpZDbha8uVoR2j5R4Q1kHHQEs6qDGPPloAdJi2Bv1UTKseBi1J2daXze18hXEIgqHtwuZcha3EPvg1+XZpJ4+8HBnvf2F1J6Kljoic2C+Pf1dDTHSwbezMwh6zH0Otbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270431; c=relaxed/simple;
	bh=qsS439hI5wV39QcrqI00cTF4BaxSZ5e0Rj1zD1rl3i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=PUEj0JdNE9zpBADWuw8FAQKI44M3k/YrQDyJXzmWEKfMO09racnrCd1kXa8GuRPsL25KWHvlH7bX58PZ6rQ5E0mdK8Li4QMAhbJvvNDtizx2BlNd/wE5GueyAQgux+8s+WrBavz5/wWjpVFT+tTzkQA+iQxAowWAnaZfVYck+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gIW7uz8B; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250919082707euoutp0143e8dea2b866d062a645bdfd00632302~moaNBIs4X2189921899euoutp01T
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:27:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250919082707euoutp0143e8dea2b866d062a645bdfd00632302~moaNBIs4X2189921899euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758270427;
	bh=6eNfMlTZqUrUupq60aFj0xlkMp9zYwxbsjfbrARp2Co=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=gIW7uz8BH+aDYKJo62e6QfJfG1Oj5GHyDkh9UUQAmUvKLTnicYGA5eblb1I9GWJEp
	 WK5fPfeYSw9HjagcgzPiYe6E78AhBKUUej8Xt2av0FBFkgJP6OrL6j+hZwnzPz2//v
	 jXQCEfnrOBC7aJeNlp9pQYAWNoz2+MZ1u2yjM9/E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250919082706eucas1p1fa29f9e90e1afdf3894b5effd734cf3f~moaMa9DNT1105511055eucas1p1v;
	Fri, 19 Sep 2025 08:27:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250919082704eusmtip1adb06790aee1726353acc54069d07301~moaLAf9lE2569525695eusmtip1P;
	Fri, 19 Sep 2025 08:27:04 +0000 (GMT)
Message-ID: <a52c0cf5-0444-41aa-b061-a0a1d72b02fe@samsung.com>
Date: Fri, 19 Sep 2025 10:27:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH net-next v12 0/5] Add Ethernet MAC support for SpacemiT
 K1
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Junhui Liu <junhui.liu@pigmoral.tech>, Simon
	Horman <horms@kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Conor Dooley
	<conor.dooley@microchip.com>, Troy Mitchell
	<troy.mitchell@linux.spacemit.com>, Hendrik Hamerlinck
	<hendrik.hamerlinck@hammernet.be>, Andrew Lunn <andrew@lunn.ch>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250919082706eucas1p1fa29f9e90e1afdf3894b5effd734cf3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250919082706eucas1p1fa29f9e90e1afdf3894b5effd734cf3f
X-EPHeader: CA
X-CMS-RootMailID: 20250919082706eucas1p1fa29f9e90e1afdf3894b5effd734cf3f
References: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
	<CGME20250919082706eucas1p1fa29f9e90e1afdf3894b5effd734cf3f@eucas1p1.samsung.com>

Hi All,

On 14.09.2025 06:23, Vivian Wang wrote:
> SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
> Add devicetree bindings, driver, and DTS for it.
>
> Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
> tested on Milk-V Jupiter.
>
> I would like to note that even though some bit field names superficially
> resemble that of DesignWare MAC, all other differences point to it in
> fact being a custom design.
>
> Based on SpacemiT drivers [1]. These patches are also available at:
>
> https://github.com/dramforever/linux/tree/k1/ethernet/v12
>
> [1]: https://github.com/spacemit-com/linux-k1x

This driver recently landed in linux-next as commit bfec6d7f2001 ("net: 
spacemit: Add K1 Ethernet MAC"). In my tests I found that it 
triggers lock dep warnings related to stats_lock acquisition. In the 
current code it is being acquired with spin_lock(). For tests I've 
changed that to spin_lock_irqsave() and the warnings went away, but I'm 
not sure that this is the proper fix. I've also checked the driver 
history and 'irqsave' locking was used in pre-v7 version, but it was 
removed later on Jakub's request and described a bit misleading as 
"Removed scoped_guard usage".

Here are the lock dep warnings I got on my BananaPiF3 board:

================================
WARNING: inconsistent lock state
6.17.0-rc6-next-20250918 #11165 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffd60b1412a0 (&priv->stats_lock){+.?.}-{3:3}, at: 
emac_stats_timer+0x1c/0x3e [k1_emac]
{SOFTIRQ-ON-W} state was registered at:
   __lock_acquire+0x7f6/0x1f7c
   lock_acquire+0xe8/0x2b6
   _raw_spin_lock+0x2c/0x40
   emac_get_stats64+0xbc/0x188 [k1_emac]
   dev_get_stats+0x3e/0x292
   rtnl_fill_stats+0x32/0xec
   rtnl_fill_ifinfo.constprop.0+0x6d0/0x1448
   rtmsg_ifinfo_build_skb+0x92/0xea
   rtmsg_ifinfo+0x36/0x78
   register_netdevice+0x7a6/0x7d4
   register_netdev+0x20/0x36
   devm_register_netdev+0x58/0xb0
   emac_probe+0x3bc/0x5ce [k1_emac]
   platform_probe+0x46/0x84
   really_probe+0x108/0x2e0
   __driver_probe_device.part.0+0xaa/0xe0
   driver_probe_device+0x78/0xc4
   __driver_attach+0x54/0x162
   bus_for_each_dev+0x58/0xa4
   driver_attach+0x1a/0x22
   bus_add_driver+0xec/0x1ce
   driver_register+0x3e/0xd8
   __platform_driver_register+0x1c/0x24
   0xffffffff025bb020
   do_one_initcall+0x56/0x290
   do_init_module+0x52/0x1da
   load_module+0x1590/0x19d8
   init_module_from_file+0x76/0xae
   idempotent_init_module+0x186/0x1fc
   __riscv_sys_finit_module+0x54/0x84
   do_trap_ecall_u+0x2a0/0x4d0
   handle_exception+0x146/0x152
irq event stamp: 76398
hardirqs last  enabled at (76398): [<ffffffff80b8809c>] 
_raw_spin_unlock_irq+0x2a/0x42
hardirqs last disabled at (76397): [<ffffffff80b87e52>] 
_raw_spin_lock_irq+0x5a/0x60
softirqs last  enabled at (76376): [<ffffffff8002e8ca>] 
handle_softirqs+0x3ca/0x462
softirqs last disabled at (76389): [<ffffffff8002eaca>] 
__irq_exit_rcu+0xe2/0x10c

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&priv->stats_lock);
   <Interrupt>
     lock(&priv->stats_lock);

  *** DEADLOCK ***

1 lock held by swapper/0/0:
  #0: ffffffc600003c30 ((&priv->stats_timer)){+.-.}-{0:0}, at: 
call_timer_fn+0x0/0x24e

stack backtrace:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
6.17.0-rc6-next-20250918 #11165 NONE
Hardware name: Banana Pi BPI-F3 (DT)
Call Trace:
[<ffffffff800163a6>] dump_backtrace+0x1c/0x24
[<ffffffff80001482>] show_stack+0x28/0x34
[<ffffffff8000f7ca>] dump_stack_lvl+0x5e/0x86
[<ffffffff8000f806>] dump_stack+0x14/0x1c
[<ffffffff80090a80>] print_usage_bug.part.0+0x29a/0x302
[<ffffffff80091152>] mark_lock+0x66a/0x7ee
[<ffffffff80091cfe>] __lock_acquire+0x7cc/0x1f7c
[<ffffffff80093d0c>] lock_acquire+0xe8/0x2b6
[<ffffffff80b87d18>] _raw_spin_lock+0x2c/0x40
[<ffffffff025c61da>] emac_stats_timer+0x1c/0x3e [k1_emac]
[<ffffffff800d8de4>] call_timer_fn+0x90/0x24e
[<ffffffff800d91b0>] __run_timers+0x20e/0x2e8
[<ffffffff800d98ea>] timer_expire_remote+0x4a/0x5e
[<ffffffff800efe52>] tmigr_handle_remote_up+0x174/0x34a
[<ffffffff800ee5e0>] __walk_groups.isra.0+0x28/0x66
[<ffffffff800f0128>] tmigr_handle_remote+0x9e/0xc2
[<ffffffff800d931c>] run_timer_softirq+0x2a/0x32
[<ffffffff8002e662>] handle_softirqs+0x162/0x462
[<ffffffff8002eaca>] __irq_exit_rcu+0xe2/0x10c
[<ffffffff8002efac>] irq_exit_rcu+0xc/0x36
[<ffffffff80b7b248>] handle_riscv_irq+0x64/0x74
[<ffffffff80b898aa>] call_on_irq_stack+0x32/0x40



================================
WARNING: inconsistent lock state
6.17.0-rc6-next-20250918-dirty #11166 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/4/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffd606ca92a0 (&priv->stats_lock){+.?.}-{3:3}, at: 
emac_stats_timer+0x1c/0x3e [k1_emac]
{SOFTIRQ-ON-W} state was registered at:
   __lock_acquire+0x7f6/0x1f7c
   lock_acquire+0xe8/0x2b6
   _raw_spin_lock+0x2c/0x40
   emac_open+0x820/0x9b0 [k1_emac]
   __dev_open+0xca/0x21c
   __dev_change_flags+0x18a/0x204
   netif_change_flags+0x1e/0x56
   do_setlink.constprop.0+0x268/0xb88
   rtnl_newlink+0x57a/0x788
   rtnetlink_rcv_msg+0x3ea/0x54c
   netlink_rcv_skb+0x44/0xec
   rtnetlink_rcv+0x14/0x1c
   netlink_unicast+0x1b6/0x218
   netlink_sendmsg+0x174/0x34e
   __sock_sendmsg+0x40/0x7c
   ____sys_sendmsg+0x19c/0x1ba
   ___sys_sendmsg+0x5c/0xa0
   __sys_sendmsg+0x5a/0xa2
   __riscv_sys_sendmsg+0x16/0x1e
   do_trap_ecall_u+0x2a0/0x4d0
   handle_exception+0x146/0x152
irq event stamp: 36278
hardirqs last  enabled at (36278): [<ffffffff80b8809c>] 
_raw_spin_unlock_irq+0x2a/0x42
hardirqs last disabled at (36277): [<ffffffff80b87e52>] 
_raw_spin_lock_irq+0x5a/0x60
softirqs last  enabled at (36256): [<ffffffff8002e8ca>] 
handle_softirqs+0x3ca/0x462
softirqs last disabled at (36269): [<ffffffff8002eaca>] 
__irq_exit_rcu+0xe2/0x10c

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&priv->stats_lock);
   <Interrupt>
     lock(&priv->stats_lock);

  *** DEADLOCK ***

1 lock held by swapper/4/0:
  #0: ffffffc600023c30 ((&priv->stats_timer)){+.-.}-{0:0}, at: 
call_timer_fn+0x0/0x24e

stack backtrace:
CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 
6.17.0-rc6-next-20250918-dirty #11166 NONE
Hardware name: Banana Pi BPI-F3 (DT)
Call Trace:
[<ffffffff800163a6>] dump_backtrace+0x1c/0x24
[<ffffffff80001482>] show_stack+0x28/0x34
[<ffffffff8000f7ca>] dump_stack_lvl+0x5e/0x86
[<ffffffff8000f806>] dump_stack+0x14/0x1c
[<ffffffff80090a80>] print_usage_bug.part.0+0x29a/0x302
[<ffffffff80091152>] mark_lock+0x66a/0x7ee
[<ffffffff80091cfe>] __lock_acquire+0x7cc/0x1f7c
[<ffffffff80093d0c>] lock_acquire+0xe8/0x2b6
[<ffffffff80b87d18>] _raw_spin_lock+0x2c/0x40
[<ffffffff025b41da>] emac_stats_timer+0x1c/0x3e [k1_emac]
[<ffffffff800d8de4>] call_timer_fn+0x90/0x24e
[<ffffffff800d91b0>] __run_timers+0x20e/0x2e8
[<ffffffff800d98ea>] timer_expire_remote+0x4a/0x5e
[<ffffffff800efe52>] tmigr_handle_remote_up+0x174/0x34a
[<ffffffff800ee5e0>] __walk_groups.isra.0+0x28/0x66
[<ffffffff800f0128>] tmigr_handle_remote+0x9e/0xc2
[<ffffffff800d931c>] run_timer_softirq+0x2a/0x32
[<ffffffff8002e662>] handle_softirqs+0x162/0x462
[<ffffffff8002eaca>] __irq_exit_rcu+0xe2/0x10c
[<ffffffff8002efac>] irq_exit_rcu+0xc/0x36
[<ffffffff80b7b248>] handle_riscv_irq+0x64/0x74
[<ffffffff80b898aa>] call_on_irq_stack+0x32/0x40


> ---
> Changes in v12:
> - Add aliases ethernet{0,1} to DTS
> - Minor changes
>    - Use FIELD_MODIFY to set duplex mode in HW based on phydev->duplex
>    - Use FIELD_GET in emac_mii_read() to extract bits from MAC_MDIO_DATA
> - Link to v11: https://lore.kernel.org/r/20250912-net-k1-emac-v11-0-aa3e84f8043b@iscas.ac.cn
>
> Changes in v11:
> - Use NETDEV_PCPU_STAT_DSTATS for tx_dropped
> - Use DECLARE_FLEX_ARRAY for emac_hw_{tx,rx}_stats instead of cast
> - More bitfields stuff to simplify code:
>    - Define EMAC_MAX_DELAY_UNIT with FIELD_MAX
>    - Use FIELD_{PREP,GET} in emac_mii_{read,write}()
>    - Use FIELD_MODIFY in emac_set_{tx,rx}_fc()
> - Minor changes:
>    - Use lower_32_bits and such instead of casts and shifts
>    - Extract emac_ether_addr_hash() helper
>    - In emac_mdio_init(), 0xffffffff -> ~0
>    - Minor comment changes
> - Link to v10: https://lore.kernel.org/r/20250908-net-k1-emac-v10-0-90d807ccd469@iscas.ac.cn
>
> Changes in v10:
> - Use FIELD_GET and FIELD_PREP, remove some unused constants
> - Remove redundant software statistics
>    - In particular, rx_dropped should have been and is already tracked in
>      rx_errors.
> - Track tx_dropped with a percpu field
> - Minor changes
>    - Simplified int emac_rx_frame_status() -> bool emac_rx_frame_good()
> - Link to v9: https://lore.kernel.org/r/20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn
>
> Changes in v9:
> - Refactor to use phy_interface_mode_is_rgmii
> - Minor changes
>    - Use netdev_err in more places
>    - Print phy-mode by name on unsupported phy-mode
> - Link to v8: https://lore.kernel.org/r/20250828-net-k1-emac-v8-0-e9075dd2ca90@iscas.ac.cn
>
> Changes in v8:
> - Use devres to do of_phy_deregister_fixed_link on probe failure or
>    remove
> - Simplified control flow in a few places with early return or continue
> - Minor changes
>    - Removed some unneeded parens in emac_configure_{tx,rx}
> - Link to v7: https://lore.kernel.org/r/20250826-net-k1-emac-v7-0-5bc158d086ae@iscas.ac.cn
>
> Changes in v7:
> - Removed scoped_guard usage
> - Renamed error handling path labels after destinations
> - Fix skb free error handling path in emac_start_xmit and emac_tx_mem_map
> - Cancel tx_timeout_task to prevent schedule_work lifetime problems
> - Minor changes:
>    - Remove unnecessary timer_delete_sync in emac_down
>    - Use dev_err_ratelimited in a few more places
>    - Cosmetic fixes in error messages
> - Link to v6: https://lore.kernel.org/r/20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn
>
> Changes in v6:
> - Implement pause frame support
> - Minor changes:
>    - Convert comment for emac_stats_update() into assert_spin_locked()
>    - Cosmetic fixes for some comments and whitespace
>    - emac_set_mac_addr() is now refactored
> - Link to v5: https://lore.kernel.org/r/20250812-net-k1-emac-v5-0-dd17c4905f49@iscas.ac.cn
>
> Changes in v5:
> - Rebased on v6.17-rc1, add back DTS now that they apply cleanly
> - Use standard statistics interface, handle 32-bit statistics overflow
> - Minor changes:
>    - Fix clock resource handling in emac_resume
>    - Ratelimit the message in emac_rx_frame_status
>    - Add ndo_validate_addr = eth_validate_addr
>    - Remove unnecessary parens in emac_set_mac_addr
>    - Change some functions that never fail to return void instead of int
>    - Minor rewording
> - Link to v4: https://lore.kernel.org/r/20250703-net-k1-emac-v4-0-686d09c4cfa8@iscas.ac.cn
>
> Changes in v4:
> - Resource handling on probe and remove: timer_delete_sync and
>    of_phy_deregister_fixed_link
> - Drop DTS changes and dependencies (will send through SpacemiT tree)
> - Minor changes:
>    - Remove redundant phy_stop() and setting of ndev->phydev
>    - Fix error checking for emac_open in emac_resume
>    - Fix one missed dev_err -> dev_err_probe
>    - Fix type of emac_start_xmit
>    - Fix one missed reverse xmas tree formatting
>    - Rename some functions for consistency between emac_* and ndo_*
> - Link to v3: https://lore.kernel.org/r/20250702-net-k1-emac-v3-0-882dc55404f3@iscas.ac.cn
>
> Changes in v3:
> - Refactored and simplified emac_tx_mem_map
> - Addressed other minor v2 review comments
> - Removed what was patch 3 in v2, depend on DMA buses instead
> - DT nodes in alphabetical order where appropriate
> - Link to v2: https://lore.kernel.org/r/20250618-net-k1-emac-v2-0-94f5f07227a8@iscas.ac.cn
>
> Changes in v2:
> - dts: Put eth0 and eth1 nodes under a bus with dma-ranges
> - dts: Added Milk-V Jupiter
> - Fix typo in emac_init_hw() that broke the driver (Oops!)
> - Reformatted line lengths to under 80
> - Addressed other v1 review comments
> - Link to v1: https://lore.kernel.org/r/20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn
>
> ---
> Vivian Wang (5):
>        dt-bindings: net: Add support for SpacemiT K1
>        net: spacemit: Add K1 Ethernet MAC
>        riscv: dts: spacemit: Add Ethernet support for K1
>        riscv: dts: spacemit: Add Ethernet support for BPI-F3
>        riscv: dts: spacemit: Add Ethernet support for Jupiter
>
>   .../devicetree/bindings/net/spacemit,k1-emac.yaml  |   81 +
>   arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |   48 +
>   arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts  |   48 +
>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |   48 +
>   arch/riscv/boot/dts/spacemit/k1.dtsi               |   22 +
>   drivers/net/ethernet/Kconfig                       |    1 +
>   drivers/net/ethernet/Makefile                      |    1 +
>   drivers/net/ethernet/spacemit/Kconfig              |   29 +
>   drivers/net/ethernet/spacemit/Makefile             |    6 +
>   drivers/net/ethernet/spacemit/k1_emac.c            | 2159 ++++++++++++++++++++
>   drivers/net/ethernet/spacemit/k1_emac.h            |  416 ++++
>   11 files changed, 2859 insertions(+)
> ---
> base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
> change-id: 20250606-net-k1-emac-3e181508ea64
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


