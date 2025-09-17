Return-Path: <netdev+bounces-223973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542ADB7C6EF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15325164E22
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDB2DEA74;
	Wed, 17 Sep 2025 11:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC4296BBB;
	Wed, 17 Sep 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107888; cv=none; b=pmoAwk65txRVRn5pDH0gjqoHpf86iPGLuBxeqUJqodRsEB4YP544GP0MD6L579l1RNTiGx9eO8HfKmnSN1M82VMAbAjU1AftjpVFDm+q2TpL+MeM3ASTVR2r36M2p7sfQ0wpATpjKA/slSlJae1E8kc4Hhwh0zQrzrwSivV3n48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107888; c=relaxed/simple;
	bh=/kSeI78h4y9G4JNsOy+QlFi7Ig7SFC1gf5owympzhlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQyjGdzoI/uCp3s7bi5PGSNTHlPDR93mO8RajYX5FDusw+8Dsqp5awD1SlMplo7lVCH22P9A3EHtjg0cmBRqt16yuZl/7vUZtz8aHqPDToUOInWEfp5QMa9Tuv9sm3dVWzQCLHUylTHGijzkizuVOsT8Iv7chIunlvLPCXMI8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cRbl11Z0Qz2VRrP;
	Wed, 17 Sep 2025 19:14:37 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 340BA140142;
	Wed, 17 Sep 2025 19:18:02 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 19:18:00 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <lorenzo@kernel.org>, <toke@redhat.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH net] net: tun: Update napi->skb after XDP process
Date: Wed, 17 Sep 2025 19:39:19 +0800
Message-ID: <20250917113919.3991267-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The syzbot report a UAF issue:

  BUG: KASAN: slab-use-after-free in skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
  BUG: KASAN: slab-use-after-free in napi_frags_skb net/core/gro.c:723 [inline]
  BUG: KASAN: slab-use-after-free in napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
  Read of size 8 at addr ffff88802ef22c18 by task syz.0.17/6079
  CPU: 0 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
  Call Trace:
   <TASK>
   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378 [inline]
   print_report+0xca/0x240 mm/kasan/report.c:482
   kasan_report+0x118/0x150 mm/kasan/report.c:595
   skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
   napi_frags_skb net/core/gro.c:723 [inline]
   napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
   tun_get_user+0x28cb/0x3e20 drivers/net/tun.c:1920
   tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
   new_sync_write fs/read_write.c:593 [inline]
   vfs_write+0x5c9/0xb30 fs/read_write.c:686
   ksys_write+0x145/0x250 fs/read_write.c:738
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  Allocated by task 6079:
   kasan_save_stack mm/kasan/common.c:47 [inline]
   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
   unpoison_slab_object mm/kasan/common.c:330 [inline]
   __kasan_mempool_unpoison_object+0xa0/0x170 mm/kasan/common.c:558
   kasan_mempool_unpoison_object include/linux/kasan.h:388 [inline]
   napi_skb_cache_get+0x37b/0x6d0 net/core/skbuff.c:295
   __alloc_skb+0x11e/0x2d0 net/core/skbuff.c:657
   napi_alloc_skb+0x84/0x7d0 net/core/skbuff.c:811
   napi_get_frags+0x69/0x140 net/core/gro.c:673
   tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
   tun_get_user+0x77c/0x3e20 drivers/net/tun.c:1784
   tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
   new_sync_write fs/read_write.c:593 [inline]
   vfs_write+0x5c9/0xb30 fs/read_write.c:686
   ksys_write+0x145/0x250 fs/read_write.c:738
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Freed by task 6079:
   kasan_save_stack mm/kasan/common.c:47 [inline]
   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
   poison_slab_object mm/kasan/common.c:243 [inline]
   __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
   kasan_slab_free include/linux/kasan.h:233 [inline]
   slab_free_hook mm/slub.c:2422 [inline]
   slab_free mm/slub.c:4695 [inline]
   kmem_cache_free+0x18f/0x400 mm/slub.c:4797
   skb_pp_cow_data+0xdd8/0x13e0 net/core/skbuff.c:969
   netif_skb_check_for_xdp net/core/dev.c:5390 [inline]
   netif_receive_generic_xdp net/core/dev.c:5431 [inline]
   do_xdp_generic+0x699/0x11a0 net/core/dev.c:5499
   tun_get_user+0x2523/0x3e20 drivers/net/tun.c:1872
   tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
   new_sync_write fs/read_write.c:593 [inline]
   vfs_write+0x5c9/0xb30 fs/read_write.c:686
   ksys_write+0x145/0x250 fs/read_write.c:738
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

After commit e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in
generic mode"), the original skb may be freed in skb_pp_cow_data() when
XDP program was attached, which was allocated in tun_napi_alloc_frags().
However, the napi->skb still point to the original skb, update it after
XDP process.

Reported-by: syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 drivers/net/tun.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index cc6c50180663..47ddcb4b9a78 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1875,6 +1875,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				local_bh_enable();
 				goto unlock_frags;
 			}
+
+			if (frags && skb != tfile->napi.skb)
+				tfile->napi.skb = skb;
 		}
 		rcu_read_unlock();
 		local_bh_enable();
-- 
2.34.1


