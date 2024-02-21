Return-Path: <netdev+bounces-73562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F985D19A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 08:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4799B231A5
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964843B1A4;
	Wed, 21 Feb 2024 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3KuFPcG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63F3AC2D
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501335; cv=none; b=YAX+UfIKF+3nqvIKn9ZRoeUc7SaYninJjRB3dzZAdzH2xeYFzR56pA86ANG4AHs46Bjo+4lal/TvOzwMEA1TdgTQsc5pFl2npic+QTWGse2Y4YQLZ9NO4rRqbBufUQTjExnDUQioxp+1kxa/EIQTobnbtzNGaPQS6r58D3penXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501335; c=relaxed/simple;
	bh=K2XmoBnc0oSqRMZca+v0xBottXSpJOmficAexsCc8c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NdK9mdQM/h2dYPuPm8HDedFalrnXIZden4rlhzFhOeqx/r9JYTm3mVFqjrTuuUa/ejO5qakkmiKK/3VO70PLO4xb5ZDABjptwcwjPyV/xWbOlJn7mTFIfMorOWXVqT47b4YAv26LIjitxEcLV1xGekQdInMVDzq1uTqfTVLHvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3KuFPcG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708501332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l1m0Q2FXSUoou8OR42HmZbOVSoPby5yOdtK1PAigeO0=;
	b=K3KuFPcGhRisk27BYE4xLQZWv1cPkLk26+0wXrlZVaHFo23YvhQeCfI7Qe7wH/Qb/t8/yB
	XM86IvofiwPPrBm7QPnzz7LC90bkZY4TZ0jsZu4tZ7Mdlmd5r/PBQEPKzYbdsnwrkDzp5u
	mFet6j/woCHYlzkfac3oI4xQQMOPLTc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-G9dim91EN3SwA7EdiZ12SA-1; Wed, 21 Feb 2024 02:42:10 -0500
X-MC-Unique: G9dim91EN3SwA7EdiZ12SA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-299d76d3a5eso1548419a91.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708501328; x=1709106128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1m0Q2FXSUoou8OR42HmZbOVSoPby5yOdtK1PAigeO0=;
        b=VTe/v98PiIqFIObJgrjJKBVaGEcnWTuNrS5+IgZOQE99cyiQd4fR8nxLdTLKP/On6W
         ziY/R4g+b3zORltNM7J4pj36+BntCS/N/7pcnWg2wkTJHdpT06VyxTbq/W3Bgaxet/0G
         YC3xST6p+t9W/9Oz9G28tYkjS6hbf1IL1VkdHGPEsuOZMzzCIb+bMD7NtUOQYFH0KGk9
         Eu+ktgLZhN4yETCJNevHETRL2IEHPRgrPdaOv+eUmDM3hA3X1Zq/d6RbP8wAG00NJ178
         3m+9rF1FfeHQ52xSXSCHp4nA0wW5Fo4mOscWZvjUiyIYYVoX16Qb8yFkLDxWXUxKf4jE
         DNTw==
X-Forwarded-Encrypted: i=1; AJvYcCUXdApiorxaQD0iwejjfctyvN0o4AjqhDljdVURh5PtYqm4+BmTld764/ig5ErAp0iS18q6So3vkj0BeH0ZpzSDT8eizUG5
X-Gm-Message-State: AOJu0Yye3Z9JR2YBbp/ZFQ9NdWpzURqMmRhvoqn9IeON46E3TdV5UcbE
	97wvr3E1YWhIQ0qz/wTZeJqx/5nZBOxoGqNyuXhHLUXopEOiZ1U57syujiJ8+c4AscVpAVXKlrX
	P8ToNNTyFEIvlI+VGUkUE+yrR/6gAbtZJUamNYMUNk60/+j7GNhIkKvZl4p3ckWxf
X-Received: by 2002:a17:90a:bc84:b0:299:5139:600a with SMTP id x4-20020a17090abc8400b002995139600amr8457785pjr.21.1708501328697;
        Tue, 20 Feb 2024 23:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTY+pXX+tbRjYehwnZGgjwRZqnV/ZhdL6J5Qs6uckMjmhN4J7BLe/nKXQeDR3HNRcsMqEBPQ==
X-Received: by 2002:a17:90a:bc84:b0:299:5139:600a with SMTP id x4-20020a17090abc8400b002995139600amr8457764pjr.21.1708501328356;
        Tue, 20 Feb 2024 23:42:08 -0800 (PST)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001db717ed294sm7388132plb.120.2024.02.20.23.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:42:07 -0800 (PST)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	anjali.k.kulkarni@oracle.com,
	lirongqing@baidu.com,
	dhowells@redhat.com,
	pctammela@mojatatu.com,
	kuniyu@amazon.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com
Subject: [PATCH net] netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter
Date: Wed, 21 Feb 2024 16:40:48 +0900
Message-ID: <20240221074053.1794118-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following uninit-value access issue [1]:

netlink_to_full_skb() creates a new `skb` and puts the `skb->data`
passed as a 1st arg of netlink_to_full_skb() onto new `skb`. The data
size is specified as `len` and passed to skb_put_data(). This `len`
is based on `skb->end` that is not data offset but buffer offset. The
`skb->end` contains data and tailroom. Since the tailroom is not
initialized when the new `skb` created, KMSAN detects uninitialized
memory area when copying the data.

This patch resolved this issue by correct the len from `skb->end` to
`skb->len`, which is the actual data offset.

BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak-after-free in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_iter+0x364/0x2520 lib/iov_iter.c:186
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x364/0x2520 lib/iov_iter.c:186
 copy_to_iter include/linux/uio.h:197 [inline]
 simple_copy_to_iter+0x68/0xa0 net/core/datagram.c:532
 __skb_datagram_iter+0x123/0xdc0 net/core/datagram.c:420
 skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:546
 skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
 packet_recvmsg+0xd9c/0x2000 net/packet/af_packet.c:3482
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg net/socket.c:1066 [inline]
 sock_read_iter+0x467/0x580 net/socket.c:1136
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x8f6/0xe00 fs/read_write.c:470
 ksys_read+0x20f/0x4c0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x93/0xd0 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 skb_put_data include/linux/skbuff.h:2622 [inline]
 netlink_to_full_skb net/netlink/af_netlink.c:181 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:298 [inline]
 __netlink_deliver_tap+0x5be/0xc90 net/netlink/af_netlink.c:325
 netlink_deliver_tap net/netlink/af_netlink.c:338 [inline]
 netlink_deliver_tap_kernel net/netlink/af_netlink.c:347 [inline]
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x10f1/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 free_pages_prepare mm/page_alloc.c:1087 [inline]
 free_unref_page_prepare+0xb0/0xa40 mm/page_alloc.c:2347
 free_unref_page_list+0xeb/0x1100 mm/page_alloc.c:2533
 release_pages+0x23d3/0x2410 mm/swap.c:1042
 free_pages_and_swap_cache+0xd9/0xf0 mm/swap_state.c:316
 tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu+0x6f5/0x980 mm/mmu_gather.c:300
 tlb_finish_mmu+0x101/0x260 mm/mmu_gather.c:392
 exit_mmap+0x49e/0xd30 mm/mmap.c:3321
 __mmput+0x13f/0x530 kernel/fork.c:1349
 mmput+0x8a/0xa0 kernel/fork.c:1371
 exit_mm+0x1b8/0x360 kernel/exit.c:567
 do_exit+0xd57/0x4080 kernel/exit.c:858
 do_group_exit+0x2fd/0x390 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3c/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 3852-3903 of 3904 are uninitialized
Memory access of size 3904 starts at ffff88812ea1e000
Data copied to user address 0000000020003280

CPU: 1 PID: 5043 Comm: syz-executor297 Not tainted 6.7.0-rc5-syzkaller-00047-g5bd7ef53ffe5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023

Fixes: 1853c9496460 ("netlink, mmap: transform mmap skb into full skb on taps")
Reported-and-tested-by: syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=34ad5fab48f7bf510349 [1]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c962347cf85..ff315351269f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -167,7 +167,7 @@ static inline u32 netlink_group_mask(u32 group)
 static struct sk_buff *netlink_to_full_skb(const struct sk_buff *skb,
 					   gfp_t gfp_mask)
 {
-	unsigned int len = skb_end_offset(skb);
+	unsigned int len = skb->len;
 	struct sk_buff *new;
 
 	new = alloc_skb(len, gfp_mask);
-- 
2.43.0


