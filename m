Return-Path: <netdev+bounces-32553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A67985ED
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 12:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CD81C20BE5
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FB1863;
	Fri,  8 Sep 2023 10:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773A111B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 10:36:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C9199F
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:36:29 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RhsQX6Gx9ztSHv;
	Fri,  8 Sep 2023 18:13:56 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 8 Sep 2023 18:17:57 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bigeasy@linutronix.de>, <netdev@vger.kernel.org>
CC: <m-karicheri2@ti.com>
Subject: [PATCH net] hsr: Fix uninit-value access in fill_frame_info()
Date: Fri, 8 Sep 2023 18:17:52 +0800
Message-ID: <20230908101752.1260288-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Syzbot reports the following uninit-value access problem.

=====================================================
BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:601 [inline]
BUG: KMSAN: uninit-value in hsr_forward_skb+0x9bd/0x30f0 net/hsr/hsr_forward.c:616
 fill_frame_info net/hsr/hsr_forward.c:601 [inline]
 hsr_forward_skb+0x9bd/0x30f0 net/hsr/hsr_forward.c:616
 hsr_dev_xmit+0x192/0x330 net/hsr/hsr_device.c:223
 __netdev_start_xmit include/linux/netdevice.h:4889 [inline]
 netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 xmit_one net/core/dev.c:3544 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3560
 __dev_queue_xmit+0x34d0/0x52a0 net/core/dev.c:4340
 dev_queue_xmit include/linux/netdevice.h:3082 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 __sys_sendto+0x781/0xa30 net/socket.c:2176
 __do_sys_sendto net/socket.c:2188 [inline]
 __se_sys_sendto net/socket.c:2184 [inline]
 __ia32_sys_sendto+0x11f/0x1c0 net/socket.c:2184
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6299
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2794
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 __sys_sendto+0x781/0xa30 net/socket.c:2176
 __do_sys_sendto net/socket.c:2188 [inline]
 __se_sys_sendto net/socket.c:2184 [inline]
 __ia32_sys_sendto+0x11f/0x1c0 net/socket.c:2184
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

It is because VLAN not yet supported in hsr driver. Return error
when protocol is ETH_P_8021Q in fill_frame_info() now to fix it.

Fixes: 451d8123f897 ("net: prp: add packet handling support")
Reported-by: syzbot+bf7e6250c7ce248f3ec9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 net/hsr/hsr_forward.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 629daacc9607..b71dab630a87 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -594,6 +594,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
 		netdev_warn_once(skb->dev, "VLAN not yet supported");
+		return -EINVAL;
 	}
 
 	frame->is_from_san = false;
-- 
2.25.1


