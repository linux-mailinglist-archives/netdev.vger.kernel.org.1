Return-Path: <netdev+bounces-27651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE077CACF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C1428136E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13668111AD;
	Tue, 15 Aug 2023 09:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2F111A7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:23 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0544B5
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BCDAB2084A;
	Tue, 15 Aug 2023 11:53:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p_EhRc-2mM6i; Tue, 15 Aug 2023 11:53:19 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id F13D620868;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id E2A9C80004A;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:53:15 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:53:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6336E31843A4; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/11] xfrm: add NULL check in xfrm_update_ae_params
Date: Tue, 15 Aug 2023 11:53:07 +0200
Message-ID: <20230815095310.3310160-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815095310.3310160-1-steffen.klassert@secunet.com>
References: <20230815095310.3310160-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lin Ma <linma@zju.edu.cn>

Normally, x->replay_esn and x->preplay_esn should be allocated at
xfrm_alloc_replay_state_esn(...) in xfrm_state_construct(...), hence the
xfrm_update_ae_params(...) is okay to update them. However, the current
implementation of xfrm_new_ae(...) allows a malicious user to directly
dereference a NULL pointer and crash the kernel like below.

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 8253067 P4D 8253067 PUD 8e0e067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 98 Comm: poc.npd Not tainted 6.4.0-rc7-00072-gdad9774deaf1 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
RIP: 0010:memcpy_orig+0xad/0x140
Code: e8 4c 89 5f e0 48 8d 7f e0 73 d2 83 c2 20 48 29 d6 48 29 d7 83 fa 10 72 34 4c 8b 06 4c 8b 4e 08 c
RSP: 0018:ffff888008f57658 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff888008bd0000 RCX: ffffffff8238e571
RDX: 0000000000000018 RSI: ffff888007f64844 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888008f57818
R13: ffff888007f64aa4 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000014013c0(0000) GS:ffff88806d600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000054d8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die+0x1f/0x70
 ? page_fault_oops+0x1e8/0x500
 ? __pfx_is_prefetch.constprop.0+0x10/0x10
 ? __pfx_page_fault_oops+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0x11/0x40
 ? fixup_exception+0x36/0x460
 ? _raw_spin_unlock_irqrestore+0x11/0x40
 ? exc_page_fault+0x5e/0xc0
 ? asm_exc_page_fault+0x26/0x30
 ? xfrm_update_ae_params+0xd1/0x260
 ? memcpy_orig+0xad/0x140
 ? __pfx__raw_spin_lock_bh+0x10/0x10
 xfrm_update_ae_params+0xe7/0x260
 xfrm_new_ae+0x298/0x4e0
 ? __pfx_xfrm_new_ae+0x10/0x10
 ? __pfx_xfrm_new_ae+0x10/0x10
 xfrm_user_rcv_msg+0x25a/0x410
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 ? __alloc_skb+0xcf/0x210
 ? stack_trace_save+0x90/0xd0
 ? filter_irq_stacks+0x1c/0x70
 ? __stack_depot_save+0x39/0x4e0
 ? __kasan_slab_free+0x10a/0x190
 ? kmem_cache_free+0x9c/0x340
 ? netlink_recvmsg+0x23c/0x660
 ? sock_recvmsg+0xeb/0xf0
 ? __sys_recvfrom+0x13c/0x1f0
 ? __x64_sys_recvfrom+0x71/0x90
 ? do_syscall_64+0x3f/0x90
 ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
 ? copyout+0x3e/0x50
 netlink_rcv_skb+0xd6/0x210
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? __pfx_sock_has_perm+0x10/0x10
 ? mutex_lock+0x8d/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 xfrm_netlink_rcv+0x44/0x50
 netlink_unicast+0x36f/0x4c0
 ? __pfx_netlink_unicast+0x10/0x10
 ? netlink_recvmsg+0x500/0x660
 netlink_sendmsg+0x3b7/0x700

This Null-ptr-deref bug is assigned CVE-2023-3772. And this commit
adds additional NULL check in xfrm_update_ae_params to fix the NPD.

Fixes: d8647b79c3b7 ("xfrm: Add user interface for esn and big anti-replay windows")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index fdc0c17122b6..8f74dde4a55f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -628,7 +628,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
 
-	if (re) {
+	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
 		replay_esn = nla_data(re);
 		memcpy(x->replay_esn, replay_esn,
-- 
2.34.1


