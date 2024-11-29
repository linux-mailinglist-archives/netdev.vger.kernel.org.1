Return-Path: <netdev+bounces-147832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FB9DE64B
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A627A282734
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2E19CC3E;
	Fri, 29 Nov 2024 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9M4YI3a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379A19A298;
	Fri, 29 Nov 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883013; cv=none; b=nh+sM8+mCT6VPNbfF+LSvp5SAjrbcmhie335RdkCzgKNLltBnL2YmWNS9OUGi5UtXzelUWxU8DT0OqtlkhOhP4XwBftAgiJ3sbhys9vS8bPrs+n9070A6PYhuLPxxBK+gs3/BFMnYH/3O3km/GUQY65oupyGN9uLC9vWdLriGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883013; c=relaxed/simple;
	bh=x6ds4depXJ3x1wS0EfDmuF9bTtZmMDhaiDzLRWiI5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HxmmdwIWW/Rg5ctd4HFQXNexNygojaPbyy/oKmHIqGJrTaZjB8Sfp+scIQ/YTEZaUToQiJA6TW1hv2TAV9xEcJM1GPjWMKAinTFEvmMq3J1n81YbCt6eHRHsYMu7Qs2o6oy2y4/h4r9M2vxJjUVBy2oJ+JJxJoESqkWSB1zMq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9M4YI3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2030C4CED2;
	Fri, 29 Nov 2024 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732883012;
	bh=x6ds4depXJ3x1wS0EfDmuF9bTtZmMDhaiDzLRWiI5UU=;
	h=Date:From:To:Cc:Subject:From;
	b=k9M4YI3aucPoCkXM3faDD/1h6Me2Tuz+kcoKunXgdZaFa8Rnfy4ayYdY2QVxy3OTr
	 k7NymP0TsqeViokqae97qf5KP9THD8rUEnRZua+Vik0qaRefIrLQz8qp4QMGwg9RW6
	 BZUPURAbaHHbpUUirB/VieokL6pcQjZyEHJqhMrZ9pG7cbPpl4eOeEfGYQzPL/8hKk
	 C93S8jxkUV1FJRehOpO31oIbbbWSWaJ7f8KA3u6ghEoFrSsKXBKZ28/ibbnW47rg/5
	 F4LIGgzO44dDxmQ1a6L4dOBwHbLR1AtSHefcYiq5VnbeXgRlZ7nOnmnbxDHYB3MTeN
	 RLPkqhaMqI2pg==
Date: Fri, 29 Nov 2024 12:23:28 +0000
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, conor@kernel.org
Subject: deadlock in macb_start_xmit() with PREEMPT_RT enabled
Message-ID: <20241129-glimpse-wilt-8a9ba002d7bf@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vVya7FBFnkVqn3JA"
Content-Disposition: inline


--vVya7FBFnkVqn3JA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yo,

Just reporting a deadlock that I've been seeing since PREEMPT_RT was
merged in the cadence macb driver. I meant to report this weeks ago
after mentioning it to Nicolas but it slipped my mind. With PREEMPT_RT
disabled, the deadlock does not get reported.

Cheers,
Conor.

======================================================
WARNING: possible circular locking dependency detected
6.12.0-10553-gb86545e02e8c-dirty #1 Not tainted
------------------------------------------------------
kworker/0:1/9 is trying to acquire lock:
ffffffe5c0abb460 (&bp->lock){+.+.}-{3:3}, at: macb_start_xmit+0x836/0xa3e

but task is already holding lock:
ffffffe5c0ab9270 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit+0x300/0xa3e

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&queue->tx_ptr_lock){+...}-{3:3}:
       __lock_acquire+0xadc/0xda6
       lock_acquire+0x124/0x2d0
       rt_spin_lock+0x3a/0x142
       macb_start_xmit+0x300/0xa3e
       dev_hard_start_xmit+0xf4/0x28c
       sch_direct_xmit+0xbc/0x324
       __dev_queue_xmit+0x5f6/0xb5e
       neigh_resolve_output+0x122/0x15a
       ip6_finish_output2+0x624/0xa06
       ip6_output+0x182/0x35a
       mld_sendpack+0x274/0x47e
       mld_ifc_work+0x254/0x400
       process_one_work+0x224/0x55a
       worker_thread+0x236/0x360
       kthread+0xf2/0x10c
       ret_from_fork+0xe/0x18

-> #2 (_xmit_ETHER#2){+...}-{3:3}:
       __lock_acquire+0xadc/0xda6
       lock_acquire+0x124/0x2d0
       rt_spin_lock+0x3a/0x142
       sch_direct_xmit+0x80/0x324
       __dev_queue_xmit+0x5f6/0xb5e
       neigh_resolve_output+0x122/0x15a
       ip6_finish_output2+0x624/0xa06
       ip6_output+0x182/0x35a
       mld_sendpack+0x274/0x47e
       mld_ifc_work+0x254/0x400
       process_one_work+0x224/0x55a
       worker_thread+0x236/0x360
       kthread+0xf2/0x10c
       ret_from_fork+0xe/0x18

-> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
       __lock_acquire+0xadc/0xda6
       lock_acquire+0x124/0x2d0
       rt_spin_lock+0x3a/0x142
       __local_bh_disable_ip+0x10c/0x1ec
       local_bh_disable+0x1c/0x24
       __netdev_alloc_skb+0x12e/0x232
       gem_rx_refill+0xf6/0x1ae
       gem_init_rings+0x56/0x110
       macb_mac_link_up+0xc0/0x2d6
       phylink_resolve+0x5f2/0x72e
       process_one_work+0x224/0x55a
       worker_thread+0x236/0x360
       kthread+0xf2/0x10c
       ret_from_fork+0xe/0x18

-> #0 (&bp->lock){+.+.}-{3:3}:
       check_noncircular+0x146/0x15c
       validate_chain+0xb86/0x2806
       __lock_acquire+0xadc/0xda6
       lock_acquire+0x124/0x2d0
       rt_spin_lock+0x3a/0x142
       macb_start_xmit+0x836/0xa3e
       dev_hard_start_xmit+0xf4/0x28c
       sch_direct_xmit+0xbc/0x324
       __dev_queue_xmit+0x5f6/0xb5e
       neigh_resolve_output+0x122/0x15a
       ip6_finish_output2+0x624/0xa06
       ip6_output+0x182/0x35a
       mld_sendpack+0x274/0x47e
       mld_ifc_work+0x254/0x400
       process_one_work+0x224/0x55a
       worker_thread+0x236/0x360
       kthread+0xf2/0x10c
       ret_from_fork+0xe/0x18

other info that might help us debug this:

Chain exists of:
  &bp->lock --> _xmit_ETHER#2 --> &queue->tx_ptr_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&queue->tx_ptr_lock);
                               lock(_xmit_ETHER#2);
                               lock(&queue->tx_ptr_lock);
  lock(&bp->lock);

 *** DEADLOCK ***

15 locks held by kworker/0:1/9:
 #0: ffffffe5c084f538 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work+0x194/0x55a
 #1: ffffffc600063d88 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1b2/0x55a
 #2: ffffffe5c5228620 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x2e/0x400
 #3: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x32
 #4: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x32
 #5: ffffffe5fef5c210 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x10c/0x1ec
 #6: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x34
 #7: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x2e
 #8: ffffffff81ca92c8 (rcu_read_lock_bh){....}-{1:3}, at: rcu_lock_acquire+0x0/0x2a
 #9: ffffffe5c4ce7398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0x458/0xb5e
 #10: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x34
 #11: ffffffe5c5721318 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x80/0x324
 #12: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x34
 #13: ffffffe5c0ab9270 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit+0x300/0xa3e
 #14: ffffffff81ca92a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x34

stack backtrace:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-10553-gb86545e02e8c-dirty #1
Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
Workqueue: mld mld_ifc_work
Call Trace:
[<ffffffff80007870>] show_stack+0x2c/0x3c
[<ffffffff80c205dc>] dump_stack_lvl+0x32/0x9a
[<ffffffff80c20658>] dump_stack+0x14/0x1c
[<ffffffff8009a950>] print_circular_bug+0x320/0x326
[<ffffffff8009a3f0>] check_noncircular+0x146/0x15c
[<ffffffff80097eb2>] validate_chain+0xb86/0x2806
[<ffffffff80092c0e>] __lock_acquire+0xadc/0xda6
[<ffffffff80091eb2>] lock_acquire+0x124/0x2d0
[<ffffffff80c2bee2>] rt_spin_lock+0x3a/0x142
[<ffffffff80870788>] macb_start_xmit+0x836/0xa3e
[<ffffffff80a0a410>] dev_hard_start_xmit+0xf4/0x28c
[<ffffffff80a6ed88>] sch_direct_xmit+0xbc/0x324
[<ffffffff80a0b57c>] __dev_queue_xmit+0x5f6/0xb5e
[<ffffffff80a1feec>] neigh_resolve_output+0x122/0x15a
[<ffffffff80b2fcc0>] ip6_finish_output2+0x624/0xa06
[<ffffffff80b2ac3a>] ip6_output+0x182/0x35a
[<ffffffff80b67128>] mld_sendpack+0x274/0x47e
[<ffffffff80b642dc>] mld_ifc_work+0x254/0x400
[<ffffffff800451e6>] process_one_work+0x224/0x55a
[<ffffffff8004754e>] worker_thread+0x236/0x360
[<ffffffff8004e076>] kthread+0xf2/0x10c
[<ffffffff80c324e2>] ret_from_fork+0xe/0x18

--vVya7FBFnkVqn3JA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0myQAAKCRB4tDGHoIJi
0lSzAP4/Mb0RONUDlGP+GtmT1lyoj6E760RDZFCMuYODbqiOCgD+MFQrrP0HpWjS
t5pMcPKpm0FThkEso63mDLgTwV3qrgE=
=/2XV
-----END PGP SIGNATURE-----

--vVya7FBFnkVqn3JA--

