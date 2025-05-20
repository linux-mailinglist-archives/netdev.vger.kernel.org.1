Return-Path: <netdev+bounces-191789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D010ABD3F5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68A51B646FA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F40268C6B;
	Tue, 20 May 2025 09:55:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56425DAF4;
	Tue, 20 May 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734915; cv=none; b=cZAKZwwRx9t/A+eb6TkGuhai8pgyZ6uKiH1aM5n5ZrQwjRkSpImOPj1i5h7O/nWwBswPUJBQw8OS8tj6UoJBs1PXyP52+Dpw2nCKPRVjhHOgR0Zh5z2AuJDDKibjab7o3qmj07ifSlyd9SnBxyEjED3OACowGcCdiV+QYi+8Vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734915; c=relaxed/simple;
	bh=nYtSmDmCMfbAwLf3uXqJZRMJmgIAW9Thdzm8zwi6TrI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n4P1uYRU/6DyE6vtALDQZzvSyrzFkq7ooVpxS0IwB6+EbuX5AbW0CDqF3FuKKa6ta6svogj6Eyp78akkkk+FRDbOwxAAQmEsduPkZ1qoYajYV3bNi4Oize+USScc5fcu38+hFPCZNfOwFPYrFoN4af3i1QGq8HijQpld7BEa+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b1qgX2LMqz27hxh;
	Tue, 20 May 2025 17:55:52 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D2D3B1A016C;
	Tue, 20 May 2025 17:55:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 May
 2025 17:55:02 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <jmaloy@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<tuong.t.lien@dektech.com.au>, <ying.xue@windreiver.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net] net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done
Date: Tue, 20 May 2025 18:14:04 +0800
Message-ID: <20250520101404.1341730-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg200005.china.huawei.com (7.202.181.32)

Syzbot reported a slab-use-after-free with the following call trace:

  ==================================================================
  BUG: KASAN: slab-use-after-free in tipc_aead_encrypt_done+0x4bd/0x510 net/tipc/crypto.c:840
  Read of size 8 at addr ffff88807a733000 by task kworker/1:0/25

  Call Trace:
   kasan_report+0xd9/0x110 mm/kasan/report.c:601
   tipc_aead_encrypt_done+0x4bd/0x510 net/tipc/crypto.c:840
   crypto_request_complete include/crypto/algapi.h:266
   aead_request_complete include/crypto/internal/aead.h:85
   cryptd_aead_crypt+0x3b8/0x750 crypto/cryptd.c:772
   crypto_request_complete include/crypto/algapi.h:266
   cryptd_queue_worker+0x131/0x200 crypto/cryptd.c:181
   process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231

  Allocated by task 8355:
   kzalloc_noprof include/linux/slab.h:778
   tipc_crypto_start+0xcc/0x9e0 net/tipc/crypto.c:1466
   tipc_init_net+0x2dd/0x430 net/tipc/core.c:72
   ops_init+0xb9/0x650 net/core/net_namespace.c:139
   setup_net+0x435/0xb40 net/core/net_namespace.c:343
   copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
   create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
   unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
   ksys_unshare+0x419/0x970 kernel/fork.c:3323
   __do_sys_unshare kernel/fork.c:3394

  Freed by task 63:
   kfree+0x12a/0x3b0 mm/slub.c:4557
   tipc_crypto_stop+0x23c/0x500 net/tipc/crypto.c:1539
   tipc_exit_net+0x8c/0x110 net/tipc/core.c:119
   ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
   cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
   process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231

After freed the tipc_crypto tx by delete namespace, tipc_aead_encrypt_done
may still visit it in cryptd_queue_worker workqueue.

I reproduce this issue by:
  ip netns add ns1
  ip link add veth1 type veth peer name veth2
  ip link set veth1 netns ns1
  ip netns exec ns1 tipc bearer enable media eth dev veth1
  ip netns exec ns1 tipc node set key this_is_a_master_key master
  ip netns exec ns1 tipc bearer disable media eth dev veth1
  ip netns del ns1

The key of reproduction is that, simd_aead_encrypt is interrupted, leading
to crypto_simd_usable() return false. Thus, the cryptd_queue_worker is
triggered, and the tipc_crypto tx will be visited.

  tipc_disc_timeout
    tipc_bearer_xmit_skb
      tipc_crypto_xmit
        tipc_aead_encrypt
          crypto_aead_encrypt
            // encrypt()
            simd_aead_encrypt
              // crypto_simd_usable() is false
              child = &ctx->cryptd_tfm->base;

  simd_aead_encrypt
    crypto_aead_encrypt
      // encrypt()
      cryptd_aead_encrypt_enqueue
        cryptd_aead_enqueue
          cryptd_enqueue_request
            // trigger cryptd_queue_worker
            queue_work_on(smp_processor_id(), cryptd_wq, &cpu_queue->work)

Fix this by holding net reference count before encrypt.

Reported-by: syzbot+55c12726619ff85ce1f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=55c12726619ff85ce1f6
Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/tipc/crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index c524421ec652..8584893b4785 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -817,12 +817,16 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	get_net(aead->crypto->net);
+
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY)
 		return rc;
 
 	tipc_bearer_put(b);
+	put_net(aead->crypto->net);
 
 exit:
 	kfree(ctx);
@@ -860,6 +864,7 @@ static void tipc_aead_encrypt_done(void *data, int err)
 	kfree(tx_ctx);
 	tipc_bearer_put(b);
 	tipc_aead_put(aead);
+	put_net(net);
 }
 
 /**
-- 
2.34.1


