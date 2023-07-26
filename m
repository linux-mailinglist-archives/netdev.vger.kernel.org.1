Return-Path: <netdev+bounces-21636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3444576413E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D521C2141A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412521C9F4;
	Wed, 26 Jul 2023 21:32:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B41C9E5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A6C4339A;
	Wed, 26 Jul 2023 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407137;
	bh=g8G9rYv8cOkxGobCx/jECpc22uFMyOygPFuyO442yIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5RNS1xYkMDFabCBxs0XTi0OhAVBrX5L7guMUkCs7osf4l12TVl2qqpICFAogQKTS
	 oFoOOeyEvng1d4pnJdXiZKkWgrhTeqwP1rTFF2RLP2EguDz2kCoI8Kw8bTlRx/sEod
	 Is1RQXCzqNTZCoL6ngr1A+9MQDGSUpdRQlh8sohprJ+Gduiqsdq4jRYs0D+CG/IMT7
	 H+oarchSENqu6imyVs7/fXrmNaQepPx/iJzD3NtdyBXV3iJkfmB0izBGrPMVel8/jm
	 i3oFGLydcVSNe+PN8YbkSeZPpcdFeKWC8x+FUtdpFbZ1zVRjSeCtgJgoxNX8Q1vaeD
	 q8/607H98NGCg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 09/15] net/mlx5e: xsk: Fix invalid buffer access for legacy rq
Date: Wed, 26 Jul 2023 14:32:00 -0700
Message-ID: <20230726213206.47022-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

The below crash can be encountered when using xdpsock in rx mode for
legacy rq: the buffer gets released in the XDP_REDIRECT path, and then
once again in the driver. This fix sets the flag to avoid releasing on
the driver side.

XSK handling of buffers for legacy rq was relying on the caller to set
the skip release flag. But the referenced fix started using fragment
counts for pages instead of the skip flag.

Crash log:
 general protection fault, probably for non-canonical address 0xffff8881217e3a: 0000 [#1] SMP
 CPU: 0 PID: 14 Comm: ksoftirqd/0 Not tainted 6.5.0-rc1+ #31
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:bpf_prog_03b13f331978c78c+0xf/0x28
 Code:  ...
 RSP: 0018:ffff88810082fc98 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff888138404901 RCX: c0ffffc900027cbc
 RDX: ffffffffa000b514 RSI: 00ffff8881217e32 RDI: ffff888138404901
 RBP: ffff88810082fc98 R08: 0000000000091100 R09: 0000000000000006
 R10: 0000000000000800 R11: 0000000000000800 R12: ffffc9000027a000
 R13: ffff8881217e2dc0 R14: ffff8881217e2910 R15: ffff8881217e2f00
 FS:  0000000000000000(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000564cb2e2cde0 CR3: 000000010e603004 CR4: 0000000000370eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? die_addr+0x32/0x80
  ? exc_general_protection+0x192/0x390
  ? asm_exc_general_protection+0x22/0x30
  ? 0xffffffffa000b514
  ? bpf_prog_03b13f331978c78c+0xf/0x28
  mlx5e_xdp_handle+0x48/0x670 [mlx5_core]
  ? dev_gro_receive+0x3b5/0x6e0
  mlx5e_xsk_skb_from_cqe_linear+0x6e/0x90 [mlx5_core]
  mlx5e_handle_rx_cqe+0x55/0x100 [mlx5_core]
  mlx5e_poll_rx_cq+0x87/0x6e0 [mlx5_core]
  mlx5e_napi_poll+0x45e/0x6b0 [mlx5_core]
  __napi_poll+0x25/0x1a0
  net_rx_action+0x28a/0x300
  __do_softirq+0xcd/0x279
  ? sort_range+0x20/0x20
  run_ksoftirqd+0x1a/0x20
  smpboot_thread_fn+0xa2/0x130
  kthread+0xc9/0xf0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>
 Modules linked in: mlx5_ib mlx5_core rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay zram zsmalloc fuse [last unloaded: mlx5_core]
 ---[ end trace 0000000000000000 ]---

Fixes: 7abd955a58fb ("net/mlx5e: RX, Fix page_pool page fragment tracking for XDP")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index d97e6df66f45..b8dd74453655 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -323,8 +323,11 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 	net_prefetch(mxbuf->xdp.data);
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (likely(prog && mlx5e_xdp_handle(rq, prog, mxbuf)))
+	if (likely(prog && mlx5e_xdp_handle(rq, prog, mxbuf))) {
+		if (likely(__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)))
+			wi->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 		return NULL; /* page/packet was consumed by XDP */
+	}
 
 	/* XDP_PASS: copy the data from the UMEM to a new SKB. The frame reuse
 	 * will be handled by mlx5e_free_rx_wqe.
-- 
2.41.0


