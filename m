Return-Path: <netdev+bounces-161061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35985A1D0CC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B2188644C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34931FC7D3;
	Mon, 27 Jan 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qW2CDj3U"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A91547FE
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958086; cv=none; b=RWiuevZcX8GP28j6qkwIf0S+Q40F0eOmx5ntfLOQ4wwNXwpSaLoCrMsg/Yxe8hmG49fO+xb/QteFMR5zGbcGC8g58mmtT7jzCsyaKkSCG/u8ESojAIxF7KvEAeelo+Sw9EL+UYre3VLN8WrRc9/sNraXxbnMVp8UwejRZYY3luY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958086; c=relaxed/simple;
	bh=7O3OoG7dgTMC6b8FNlEeBVEMP9ZH/s+axbT5y6TpsQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4aM1eknbdv+SYtaVFpmIGcA6FQ/40aAFKCyem8G8XhC0/rMhZX6dLb6aJtB/4O/RJLUQ/Ttrxt5wjLunWvEkP1FqILG8anCRIdT4hYVlM1ywEy46hA4YW48/DnF9X8P2CIfb3U75onvQDx/iV/xfrg5OY2C9qRivakpRYpxJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qW2CDj3U; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5B2202074B;
	Mon, 27 Jan 2025 07:08:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id quLJU4-pB8iI; Mon, 27 Jan 2025 07:08:00 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 53A3E201E2;
	Mon, 27 Jan 2025 07:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 53A3E201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737958080;
	bh=KfhSoTFyNphIRbJ4FkOafQH9Skam5N4rpGsYYCdAFHQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qW2CDj3UJKfa0+QJDU0X9odv9SkRSOxow5v6/OdzMFLOUkgRGSTGZIN6aE8VHw151
	 UV9j6uq5a7xZ4sf5E9jnQAdhM3l8TPdHxkAgJ6Nkj6Md25nlxpZ6n6/oe7cBDHBBr3
	 acRadQF0ZldMTzva5m+TC3i4fpVkHSME/00D21vTu86eFpxl/9oeB6MucpaU8zrHqH
	 IeUY9+TieQvo1O7ggh+WxfQFZMvzRo2ccR/0sdFsnLOAzrvRcAraeEI5wxIy2sbWET
	 U5tcPakf8IMJxBvU6c8WH4v0ryH3vIIz6Lrpa3Gc9LcS9CsLw9izpl62L1TbPnrmGI
	 RfMRWGQszq2Bw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 Jan 2025 07:08:00 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 07:07:59 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D12B63184110; Mon, 27 Jan 2025 07:07:59 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/5] xfrm: delete intermediate secpath entry in packet offload mode
Date: Mon, 27 Jan 2025 07:07:55 +0100
Message-ID: <20250127060757.3946314-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127060757.3946314-1-steffen.klassert@secunet.com>
References: <20250127060757.3946314-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Alexandre Cassen <acassen@corp.free.fr>

Packets handled by hardware have added secpath as a way to inform XFRM
core code that this path was already handled. That secpath is not needed
at all after policy is checked and it is removed later in the stack.

However, in the case of IP forwarding is enabled (/proc/sys/net/ipv4/ip_forward),
that secpath is not removed and packets which already were handled are reentered
to the driver TX path with xfrm_offload set.

The following kernel panic is observed in mlx5 in such case:

 mlx5_core 0000:04:00.0 enp4s0f0np0: Link up
 mlx5_core 0000:04:00.1 enp4s0f1np1: Link up
 Initializing XFRM netlink socket
 IPsec XFRM device driver
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0010 [#1] PREEMPT SMP
 CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc1-alex #3
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffffb87380003800 EFLAGS: 00010206
 RAX: ffff8df004e02600 RBX: ffffb873800038d8 RCX: 00000000ffff98cf
 RDX: ffff8df00733e108 RSI: ffff8df00521fb80 RDI: ffff8df001661f00
 RBP: ffffb87380003850 R08: ffff8df013980000 R09: 0000000000000010
 R10: 0000000000000002 R11: 0000000000000002 R12: ffff8df001661f00
 R13: ffff8df00521fb80 R14: ffff8df00733e108 R15: ffff8df011faf04e
 FS:  0000000000000000(0000) GS:ffff8df46b800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 0000000106384000 CR4: 0000000000350ef0
 Call Trace:
  <IRQ>
  ? show_regs+0x63/0x70
  ? __die_body+0x20/0x60
  ? __die+0x2b/0x40
  ? page_fault_oops+0x15c/0x550
  ? do_user_addr_fault+0x3ed/0x870
  ? exc_page_fault+0x7f/0x190
  ? asm_exc_page_fault+0x27/0x30
  mlx5e_ipsec_handle_tx_skb+0xe7/0x2f0 [mlx5_core]
  mlx5e_xmit+0x58e/0x1980 [mlx5_core]
  ? __fib_lookup+0x6a/0xb0
  dev_hard_start_xmit+0x82/0x1d0
  sch_direct_xmit+0xfe/0x390
  __dev_queue_xmit+0x6d8/0xee0
  ? __fib_lookup+0x6a/0xb0
  ? internal_add_timer+0x48/0x70
  ? mod_timer+0xe2/0x2b0
  neigh_resolve_output+0x115/0x1b0
  __neigh_update+0x26a/0xc50
  neigh_update+0x14/0x20
  arp_process+0x2cb/0x8e0
  ? __napi_build_skb+0x5e/0x70
  arp_rcv+0x11e/0x1c0
  ? dev_gro_receive+0x574/0x820
  __netif_receive_skb_list_core+0x1cf/0x1f0
  netif_receive_skb_list_internal+0x183/0x2a0
  napi_complete_done+0x76/0x1c0
  mlx5e_napi_poll+0x234/0x7a0 [mlx5_core]
  __napi_poll+0x2d/0x1f0
  net_rx_action+0x1a6/0x370
  ? atomic_notifier_call_chain+0x3b/0x50
  ? irq_int_handler+0x15/0x20 [mlx5_core]
  handle_softirqs+0xb9/0x2f0
  ? handle_irq_event+0x44/0x60
  irq_exit_rcu+0xdb/0x100
  common_interrupt+0x98/0xc0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x27/0x40
 RIP: 0010:pv_native_safe_halt+0xb/0x10
 Code: 09 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 22
 0f 1f 84 00 00 00 00 00 90 eb 07 0f 00 2d 7f e9 36 00 fb
40 00 83 ff 07 77 21 89 ff ff 24 fd 88 3d a1 bd 0f 21 f8
 RSP: 0018:ffffffffbe603de8 EFLAGS: 00000202
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000f92f46680
 RDX: 0000000000000037 RSI: 00000000ffffffff RDI: 00000000000518d4
 RBP: ffffffffbe603df0 R08: 000000cd42e4dffb R09: ffffffffbe603d70
 R10: 0000004d80d62680 R11: 0000000000000001 R12: ffffffffbe60bf40
 R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffbe60aff8
  ? default_idle+0x9/0x20
  arch_cpu_idle+0x9/0x10
  default_idle_call+0x29/0xf0
  do_idle+0x1f2/0x240
  cpu_startup_entry+0x2c/0x30
  rest_init+0xe7/0x100
  start_kernel+0x76b/0xb90
  x86_64_start_reservations+0x18/0x30
  x86_64_start_kernel+0xc0/0x110
  ? setup_ghcb+0xe/0x130
  common_startup_64+0x13e/0x141
  </TASK>
 Modules linked in: esp4_offload esp4 xfrm_interface
xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo binfmt_misc
intel_rapl_msr intel_rapl_common kvm_amd ccp kvm input_leds serio_raw
qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc
scsi_dh_alua efi_pstore ip_tables x_tables autofs4 raid10 raid456
async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor async_tx
libcrc32c raid1 raid0 mlx5_core crct10dif_pclmul crc32_pclmul
polyval_clmulni polyval_generic ghash_clmulni_intel sha256_ssse3
sha1_ssse3 ahci mlxfw i2c_i801 libahci i2c_mux i2c_smbus psample
virtio_rng pci_hyperv_intf aesni_intel crypto_simd cryptd
 CR2: 0000000000000000
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0018:ffffb87380003800 EFLAGS: 00010206
 RAX: ffff8df004e02600 RBX: ffffb873800038d8 RCX: 00000000ffff98cf
 RDX: ffff8df00733e108 RSI: ffff8df00521fb80 RDI: ffff8df001661f00
 RBP: ffffb87380003850 R08: ffff8df013980000 R09: 0000000000000010
 R10: 0000000000000002 R11: 0000000000000002 R12: ffff8df001661f00
 R13: ffff8df00521fb80 R14: ffff8df00733e108 R15: ffff8df011faf04e
 FS:  0000000000000000(0000) GS:ffff8df46b800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffffffffffd6 CR3: 0000000106384000 CR4: 0000000000350ef0
 Kernel panic - not syncing: Fatal exception in interrupt
 Kernel Offset: 0x3b800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: 5958372ddf62 ("xfrm: add RX datapath protection for IPsec packet offload mode")
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 32c09e85a64c..2c4eda6a8596 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1224,9 +1224,19 @@ static inline int __xfrm_policy_check2(struct sock *sk, int dir,
 
 	if (xo) {
 		x = xfrm_input_state(skb);
-		if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
-			return (xo->flags & CRYPTO_DONE) &&
-			       (xo->status & CRYPTO_SUCCESS);
+		if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
+			bool check = (xo->flags & CRYPTO_DONE) &&
+				     (xo->status & CRYPTO_SUCCESS);
+
+			/* The packets here are plain ones and secpath was
+			 * needed to indicate that hardware already handled
+			 * them and there is no need to do nothing in addition.
+			 *
+			 * Consume secpath which was set by drivers.
+			 */
+			secpath_reset(skb);
+			return check;
+		}
 	}
 
 	return __xfrm_check_nopolicy(net, skb, dir) ||
-- 
2.34.1


