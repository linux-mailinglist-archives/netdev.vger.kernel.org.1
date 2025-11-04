Return-Path: <netdev+bounces-235489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6FC316A3
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AB21890C72
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4AF32B987;
	Tue,  4 Nov 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR6YQ72T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9C329376;
	Tue,  4 Nov 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265136; cv=none; b=CI1/OJ15TbfQdNMX80TpVtnwxr1QLYVCPFmXG3Zn8r0/LTo2HCKsDtc/jtxSSJKJnEbyayHUIn++eFfEKPxCoFJ+2IRfSCvSpNy7hISHk5RvnvoWrbr9e8Uq0x9es+fdXK7puLm/g32BBLohyatwbX9/yqOeOfcBGIxbVCUbuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265136; c=relaxed/simple;
	bh=3AojZHCkoqMU8JG0gEExhziBqp2lKXJPsKv2SsNeMYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivAYwZtmyKH9p18CMXi70fqxSaNVt2Y0NT929XZBuhjZEzSsL6UXbb77C+zAXFkTEHZ/P79TsJTHkyol5ceiZDxYzlR2DCDCus+NSEJQT7eFf7rd1La/5vT/hrorymR0XaQkOaEabXuRKgCwDLLbcW6Lgg2G7xNaWAVEN83rKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR6YQ72T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D7C116C6;
	Tue,  4 Nov 2025 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265136;
	bh=3AojZHCkoqMU8JG0gEExhziBqp2lKXJPsKv2SsNeMYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CR6YQ72T6u6cYF02exzJxCcLLyAmBZjFuRGMUsVG6Ir3J9Q4ndPvjZgsveFS3o4I4
	 YIr9ofS8dVthuwRpus0P7xGPcIieqgCEcOyB05NHbQW6WgSmcU3Qm/BriTwDtedrlp
	 Rl9aWejKp/ZR48pvLsHqvIqMH3VBtSMZwMIvUgk+g0kC/8lMxGCC+sY0NbOlz/JuQO
	 cA4FaM6nqlSiXYcyizYLfULSmrU90cAKHXmy41/laHDg7VPhwNCK8Nm+c8qbWXJ1YO
	 xbe4oKM7rlEXKChFkKlIiTHiwJf1RWuV1ulSMN3cUivADwxahTgOPIBeRa5hcWHPET
	 zfSqhl/2ajaTw==
Date: Tue, 4 Nov 2025 06:05:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Gal Pressman
 <gal@nvidia.com>, linux-rt-devel@lists.linux.dev, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH net] net: gro_cells: Provide lockdep class for
 gro_cell's bh_lock
Message-ID: <20251104060533.57c1bb79@kernel.org>
In-Reply-To: <20251104111201.5eBxkOKb@linutronix.de>
References: <20251104111201.5eBxkOKb@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 12:12:01 +0100 Sebastian Andrzej Siewior wrote:
> One GRO-cell device's NAPI callback can nest into the GRO-cell of
> another device if the underlying device is also using GRO-cell.
> This is the case for IPsec over vxlan.
> These two GRO-cells are separate devices. From lockdep's point of view
> it is the same because each device is sharing the same lock class and so
> it reports a possible deadlock assuming one device is nesting into
> itself.
> 
> Provide a lockclass for the bh_lock on for gro-cell device allowing
> lockdep to distinguish between individual devices.
> 
> Fixes: 25718fdcbdd2 ("net: gro_cells: Use nested-BH locking for gro_cell")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Closes: https://lore.kernel.org/all/66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Breaks boot:

[    2.053035][    T1] netem: version 1.3
[    2.054087][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    2.055273][    T1] BUG: key ffff888009041e10 has not been registered!
[    2.055683][    T1] ------------[ cut here ]------------
[    2.055863][    T1] DEBUG_LOCKS_WARN_ON(1)
[    2.055880][    T1] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:4976 lockdep_init_map_type+0x24c/0x270
[    2.056328][    T1] Modules linked in:
[    2.056488][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc3-virtme #1 PREEMPT(full) 
[    2.056792][    T1] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    2.057007][    T1] RIP: 0010:lockdep_init_map_type+0x24c/0x270
[    2.057220][    T1] Code: ff 4c 89 e6 48 c7 c7 50 97 83 b6 e8 ee c9 01 00 e9 3d ff ff ff 90 48 c7 c6 1a 2d 7d b6 48 c7 c7 67 29 7d b6 e8 65 6e e9 ff 90 <0f> 0b 90 90 e9 47 ff ff ff 90 48 c7 c6 56 2e 7d b6 48 c7 c7 67 29
[    2.057839][    T1] RSP: 0000:ffffc90000017960 EFLAGS: 00010286
[    2.058161][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    2.058417][    T1] RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000001
[    2.058663][    T1] RBP: ffffe8ffffc01ce8 R08: 0000000000000000 R09: fffffbfff6e4090c
[    2.059045][    T1] R10: 0000000000000003 R11: 0000000000000004 R12: ffff888009041e10
[    2.059298][    T1] R13: 0000000000000000 R14: ffffe8ffffc01ad0 R15: ffffe8ffffc01a78
[    2.059657][    T1] FS:  0000000000000000(0000) GS:ffff8880ae587000(0000) knlGS:0000000000000000
[    2.059966][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.060199][    T1] CR2: 0000000000000000 CR3: 0000000079349001 CR4: 0000000000772ef0
[    2.060559][    T1] PKRU: 55555554
[    2.060684][    T1] Call Trace:
[    2.060819][    T1]  <TASK>
[    2.060911][    T1]  gro_cells_init+0x252/0x3d0
[    2.061082][    T1]  ip_tunnel_init+0xef/0x5f0
[    2.061364][    T1]  register_netdevice+0x59f/0x17b0
[    2.061545][    T1]  ? unregister_netdevice_queue+0x410/0x410
[    2.061767][    T1]  ? alloc_netdev_mqs+0xdd7/0x1370
[    2.062035][    T1]  __ip_tunnel_create+0x326/0x440
[    2.062201][    T1]  ? ip_tunnel_add+0x180/0x180
[    2.062374][    T1]  ip_tunnel_init_net+0x16f/0x4e0
[    2.062539][    T1]  ? paint_ptr+0x3b/0x90
[    2.062666][    T1]  ? ip_tunnel_ctl+0x890/0x890
[    2.062953][    T1]  ? mark_held_locks+0x49/0x70
[    2.063125][    T1]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[    2.063332][    T1]  ops_init+0x189/0x550
[    2.063469][    T1]  register_pernet_operations+0x31f/0x8b0
[    2.063747][    T1]  ? ops_undo_list+0x890/0x890
[    2.063918][    T1]  ? rwsem_down_write_slowpath+0xc60/0xc60
[    2.064134][    T1]  ? rng_is_initialized+0x20/0x20
[    2.064408][    T1]  ? __up_write+0x1ad/0x520
[    2.064584][    T1]  ? ip_mr_init+0x120/0x120
[    2.064777][    T1]  register_pernet_device+0x2a/0x60
[    2.064947][    T1]  ipip_init+0x23/0xe0
[    2.065072][    T1]  do_one_initcall+0x8c/0x1d0
[    2.065353][    T1]  ? trace_initcall_start+0x130/0x130
[    2.065535][    T1]  ? rcu_is_watching+0x12/0xb0
[    2.065700][    T1]  ? __kmalloc_noprof+0x313/0x820
[    2.065983][    T1]  ? rcu_is_watching+0x12/0xb0
[    2.066158][    T1]  do_initcalls+0x176/0x280
[    2.066383][    T1]  kernel_init_freeable+0x227/0x310
[    2.066565][    T1]  ? rest_init+0x260/0x260
[    2.066774][    T1]  kernel_init+0x20/0x1f0
[    2.066900][    T1]  ? rest_init+0x260/0x260
[    2.067062][    T1]  ? rest_init+0x260/0x260
[    2.067227][    T1]  ret_from_fork+0x1db/0x270
[    2.067397][    T1]  ? rest_init+0x260/0x260
[    2.067677][    T1]  ret_from_fork_asm+0x11/0x20
[    2.067858][    T1]  </TASK>
[    2.067995][    T1] irq event stamp: 337037
[    2.068127][    T1] hardirqs last  enabled at (337037): [<ffffffffb3bcfb47>] __up_console_sem+0x67/0x70
[    2.068525][    T1] hardirqs last disabled at (337036): [<ffffffffb3bcfb2c>] __up_console_sem+0x4c/0x70
[    2.068829][    T1] softirqs last  enabled at (336962): [<ffffffffb3a63822>] handle_softirqs+0x352/0x610
[    2.069231][    T1] softirqs last disabled at (336631): [<ffffffffb3a6408b>] irq_exit_rcu+0xab/0x100
[    2.069541][    T1] ---[ end trace 0000000000000000 ]---
[    2.073346][    T1] IPv4 over IPsec tunneling driver
[    2.077691][    T1] NET: Registered PF_INET6 protocol family
[    2.087079][    T1] Segment Routing with IPv6
[    2.087254][    T1] RPL Segment Routing with IPv6
[    2.087776][    T1] In-situ OAM (IOAM) with IPv6
[    2.092422][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.100954][    T1] NET: Registered PF_PACKET protocol family
[    2.102004][    T1] 8021q: 802.1Q VLAN Support v1.8
[    2.102407][    T1] 9pnet: Installing 9P2000 support
-- 
pw-bot: cr

