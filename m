Return-Path: <netdev+bounces-129853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735598678C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786CBB21FA4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB932155C9A;
	Wed, 25 Sep 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jooyhELy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B5146A79
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295625; cv=none; b=YySpl5ufMumoXVum82hCHEmPnfnhG064JZh3tkA/1u2JxTPxA5tuOvPsUV0rUR1kmHyOIxYpJ8TgkrMNeUeJhf27x9pr31Slpy9OlMzeP2HvvQYsThWf1A9kbOCzrThTwXc46cz7OgBX/nl11k3Qs+ucvpwAazf2wLPA9ZQvE/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295625; c=relaxed/simple;
	bh=+x1hjVJ+TQq+Bm6v7O9rXkc0EbAf4umfKnCq0Rq3xA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8O43Ke42yjyRh8etEi/eunHU329+pLG9+soIJgolYNqYuq56dgQG9I58qi3tCl8ZwiSc7suAcrJasZYGZR+6DDRvXq+uhf3I5Hu24WbdD97iKUe8TVdfWmY/yp1col68ly7IrgaK0HhyQ4wQkBqShQU7GZZzvGmDLmLBx4oyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jooyhELy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4135EC4CECF;
	Wed, 25 Sep 2024 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295625;
	bh=+x1hjVJ+TQq+Bm6v7O9rXkc0EbAf4umfKnCq0Rq3xA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jooyhELyf+F42sNKV/wnXqjrU2k7HlDWC2jXH2Kb9jkC48dXdnZUjtBF+X/nxdAK2
	 0sT+nvniXZt2sTBPucVwTcpoeONEgdbkVpxJ+wJ6kdg8FsL+G5jWtnP1k6mxZlPVqE
	 cZBZCi2lfaLo3xdjGYqXyH35IP/eWiGLrn6efj7VZ4e1t/hEghJqqTkF5TEcdlMKV4
	 RGr4Y4gNlF6yAi1cvZIiyFfktPkilEeOmVQepFZFWzNOBVzjB0xA1/g+v/yclZiRvV
	 m2mhgFqsAysxJsm2Lgj3REIBjZfomhR+vH8mT24gcF4he9p0+XZf0vOesRP7hNytR1
	 XG8l/6p3ol/Eg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net 8/8] net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice
Date: Wed, 25 Sep 2024 13:20:13 -0700
Message-ID: <20240925202013.45374-9-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The km.state is not checked in driver's delayed work. When
xfrm_state_check_expire() is called, the state can be reset to
XFRM_STATE_EXPIRED, even if it is XFRM_STATE_DEAD already. This
happens when xfrm state is deleted, but not freed yet. As
__xfrm_state_delete() is called again in xfrm timer, the following
crash occurs.

To fix this issue, skip xfrm_state_check_expire() if km.state is not
XFRM_STATE_VALID.

 Oops: general protection fault, probably for non-canonical address 0xdead000000000108: 0000 [#1] SMP
 CPU: 5 UID: 0 PID: 7448 Comm: kworker/u102:2 Not tainted 6.11.0-rc2+ #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Workqueue: mlx5e_ipsec: eth%d mlx5e_ipsec_handle_sw_limits [mlx5_core]
 RIP: 0010:__xfrm_state_delete+0x3d/0x1b0
 Code: 0f 84 8b 01 00 00 48 89 fd c6 87 c8 00 00 00 05 48 8d bb 40 10 00 00 e8 11 04 1a 00 48 8b 95 b8 00 00 00 48 8b 85 c0 00 00 00 <48> 89 42 08 48 89 10 48 8b 55 10 48 b8 00 01 00 00 00 00 ad de 48
 RSP: 0018:ffff88885f945ec8 EFLAGS: 00010246
 RAX: dead000000000122 RBX: ffffffff82afa940 RCX: 0000000000000036
 RDX: dead000000000100 RSI: 0000000000000000 RDI: ffffffff82afb980
 RBP: ffff888109a20340 R08: ffff88885f945ea0 R09: 0000000000000000
 R10: 0000000000000000 R11: ffff88885f945ff8 R12: 0000000000000246
 R13: ffff888109a20340 R14: ffff88885f95f420 R15: ffff88885f95f400
 FS:  0000000000000000(0000) GS:ffff88885f940000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f2163102430 CR3: 00000001128d6001 CR4: 0000000000370eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <IRQ>
  ? die_addr+0x33/0x90
  ? exc_general_protection+0x1a2/0x390
  ? asm_exc_general_protection+0x22/0x30
  ? __xfrm_state_delete+0x3d/0x1b0
  ? __xfrm_state_delete+0x2f/0x1b0
  xfrm_timer_handler+0x174/0x350
  ? __xfrm_state_delete+0x1b0/0x1b0
  __hrtimer_run_queues+0x121/0x270
  hrtimer_run_softirq+0x88/0xd0
  handle_softirqs+0xcc/0x270
  do_softirq+0x3c/0x50
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x47/0x50
  mlx5e_ipsec_handle_sw_limits+0x7d/0x90 [mlx5_core]
  process_one_work+0x137/0x2d0
  worker_thread+0x28d/0x3a0
  ? rescuer_thread+0x480/0x480
  kthread+0xb8/0xe0
  ? kthread_park+0x80/0x80
  ret_from_fork+0x2d/0x50
  ? kthread_park+0x80/0x80
  ret_from_fork_asm+0x11/0x20
  </TASK>

Fixes: b2f7b01d36a9 ("net/mlx5e: Simulate missing IPsec TX limits hardware functionality")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 3d274599015b..ca92e518be76 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -67,7 +67,6 @@ static void mlx5e_ipsec_handle_sw_limits(struct work_struct *_work)
 		return;
 
 	spin_lock_bh(&x->lock);
-	xfrm_state_check_expire(x);
 	if (x->km.state == XFRM_STATE_EXPIRED) {
 		sa_entry->attrs.drop = true;
 		spin_unlock_bh(&x->lock);
@@ -75,6 +74,13 @@ static void mlx5e_ipsec_handle_sw_limits(struct work_struct *_work)
 		mlx5e_accel_ipsec_fs_modify(sa_entry);
 		return;
 	}
+
+	if (x->km.state != XFRM_STATE_VALID) {
+		spin_unlock_bh(&x->lock);
+		return;
+	}
+
+	xfrm_state_check_expire(x);
 	spin_unlock_bh(&x->lock);
 
 	queue_delayed_work(sa_entry->ipsec->wq, &dwork->dwork,
-- 
2.46.1


