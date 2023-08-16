Return-Path: <netdev+bounces-28095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B142577E373
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DEF2818AC
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558A11CBA;
	Wed, 16 Aug 2023 14:22:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B38101F6
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:22:02 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C2C2709
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:22:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c561f4ac3so22073447b3.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692195720; x=1692800520;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TeC0ug8D1eXirPEbnRcyIBCYyPrnNhfPEDVTkTAG8fI=;
        b=brEJSV9NWRaq2yl/Bru18oBOTAJXdR+6vh+gR/MIwPmIWKPOiwYZKi49IPCE48SDao
         SJHLp02eASw/Rajzu4zLRAh2BQ3MBWYiQlQA9WoEAXIHxMXQllrgv79CRJZdCyuqhT4n
         6ceZlTFr7Ir/YdCMUfxTBV2D9uoA6HGlbumaFtWyzElpl5HSNfwlVtEj87vYp21C97PI
         TIaBlT+8zyRhdKeDP9ZMUbSigUXDHjtAugahNkTk4f/s6EevOzizciRGE3DJ5R/sLkxA
         1CuILDG8vceKm+8cyCJfRDe+QyLYN0jZVnKRrKg9T2ualTHJG0tKGWsGgkSyWnbwo8HM
         yehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195720; x=1692800520;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeC0ug8D1eXirPEbnRcyIBCYyPrnNhfPEDVTkTAG8fI=;
        b=jmRt9AUfzwrumhQQyA7nOheMJXrJmFl2dIdJfArNoT562P3j2VmDcM/DqEjAlsptu3
         8UIu0eMmVJUVTqr75mH5a4PxNFTSPO7Nb+hEdv5C8ck3taB7iy6Miu8tD4I8MRAJs2MB
         ibU5hq7DeNqakKCNiHEMFhg4CpcTRfPSVjBdmeHYkrPd9AnRrzuDxXvWfGmJZGeo44C6
         f9EVhG06D+B2brKOG9cFiLu4V+Kj9gCbkbZ6vvFidM2sWx0AbJgRy5aoxLjs8UZEXZIB
         8t8YXrsAjekgd5XLGyS/tY8qE28XdTONH5LqhL1glRX5iS1rkvo4lpp7Zosmp60pmpMq
         wdyQ==
X-Gm-Message-State: AOJu0Yy4L9arKDF6dskRj/6uh8la9XuSIIqIRGI3WHttd46Bc+L+Wqgx
	itoG0/XcWwWWFjEQZ4xs0Jngy+oWCuuP9g==
X-Google-Smtp-Source: AGHT+IGlheKjIdjPwhnpRvOjXxbkDq7HQgLn7IaWENom1flnn4VvNdmiGe/3/mABCHAXgQaXLxYMqmJkpk0FvQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1609:b0:d07:7001:495b with SMTP
 id bw9-20020a056902160900b00d077001495bmr30412ybb.11.1692195720373; Wed, 16
 Aug 2023 07:22:00 -0700 (PDT)
Date: Wed, 16 Aug 2023 14:21:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816142158.1779798-1-edumazet@google.com>
Subject: [PATCH net] net: do not allow gso_size to be set to GSO_BY_FRAGS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Xin Long <lucien.xin@gmail.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

One missing check in virtio_net_hdr_to_skb() allowed
syzbot to crash kernels again [1]

Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
because this magic value is used by the kernel.

[1]
general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 PID: 5039 Comm: syz-executor401 Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:skb_segment+0x1a52/0x3ef0 net/core/skbuff.c:4500
Code: 00 00 00 e9 ab eb ff ff e8 6b 96 5d f9 48 8b 84 24 00 01 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e ea 21 00 00 48 8b 84 24 00 01
RSP: 0018:ffffc90003d3f1c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 000000000001fffe RCX: 0000000000000000
RDX: 000000000000000e RSI: ffffffff882a3115 RDI: 0000000000000070
RBP: ffffc90003d3f378 R08: 0000000000000005 R09: 000000000000ffff
R10: 000000000000ffff R11: 5ee4a93e456187d6 R12: 000000000001ffc6
R13: dffffc0000000000 R14: 0000000000000008 R15: 000000000000ffff
FS: 00005555563f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 000000001626d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
udp6_ufo_fragment+0x9d2/0xd50 net/ipv6/udp_offload.c:109
ipv6_gso_segment+0x5c4/0x17b0 net/ipv6/ip6_offload.c:120
skb_mac_gso_segment+0x292/0x610 net/core/gso.c:53
__skb_gso_segment+0x339/0x710 net/core/gso.c:124
skb_gso_segment include/net/gso.h:83 [inline]
validate_xmit_skb+0x3a5/0xf10 net/core/dev.c:3625
__dev_queue_xmit+0x8f0/0x3d60 net/core/dev.c:4329
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
packet_xmit+0x257/0x380 net/packet/af_packet.c:276
packet_snd net/packet/af_packet.c:3087 [inline]
packet_sendmsg+0x24c7/0x5570 net/packet/af_packet.c:3119
sock_sendmsg_nosec net/socket.c:727 [inline]
sock_sendmsg+0xd9/0x180 net/socket.c:750
____sys_sendmsg+0x6ac/0x940 net/socket.c:2496
___sys_sendmsg+0x135/0x1d0 net/socket.c:2550
__sys_sendmsg+0x117/0x1e0 net/socket.c:2579
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff27cdb34d9

Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index bdf8de2cdd935d31449b78e1b9c67fdcdc537bf2..7b4dd69555e497497460dcf5d72737fe5c09fd53 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -155,6 +155,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_type & SKB_GSO_UDP)
 			nh_off -= thlen;
 
+		/* Kernel has a special handling for GSO_BY_FRAGS. */
+		if (gso_size == GSO_BY_FRAGS)
+			return -EINVAL;
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
-- 
2.41.0.694.ge786442a9b-goog


