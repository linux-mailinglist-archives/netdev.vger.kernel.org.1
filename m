Return-Path: <netdev+bounces-79490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0810879781
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56105283DA8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06F7C0AD;
	Tue, 12 Mar 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="es9oHh4H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BE7C0A5
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257249; cv=none; b=LKW1iJTU5k6fcwpH9OKNYjLhd28nAljEwtk81uRp4PkfMPrNWqCgDszpq21q3IuSxgxj5G69i0m83cU3Zj9ewT6qwUAoHRaUSE5bbHvLBtkB8ZWpQBL8mzvZQZeb5MsjT6c2qCHW0Uk1jsgygbEMQIePa2hSNu94zhsmgZcYvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257249; c=relaxed/simple;
	bh=w7z1eLBV/cGTuzfm8y67GKU7V01cuMnBpwQKthEkV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DzKaOM3/yKUa4sQoETXRP+wdmC64P5qh4ofVMYrD7XC44jIPIArTYbSkXnAVi0uNud4nzSyaFxiZWgCoEVSCLccSIyApPVjAjq3hwgp2yda0LbNuhGJM2u+h/3ztujEqazoUV+CjDZLPS9zs/3oyw+PZncRao1JVdRtLFMM3iCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=es9oHh4H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710257247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uC39AaHxCXn4out0wHELXA5Z5h6XuwlzMRRIrhomGFU=;
	b=es9oHh4HsijzKJggidN5pBzUWOcj7tNiYYoO9wijNVbt8fykuTW5S+oyryijs/A49uH8ap
	cpVeaw5GcquNcnbvEdPmO5j416O5CUvjtbEAYAqkWnxzV6wMjGRmeiTnEnKAlgGGBm5JBW
	NBqfTrAbycnNHBUewJNft2apRmyN8gM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-9lDF1IyzPuGCX3ZQ7RNirg-1; Tue, 12 Mar 2024 11:27:25 -0400
X-MC-Unique: 9lDF1IyzPuGCX3ZQ7RNirg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e657979d66so4821005b3a.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 08:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257244; x=1710862044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC39AaHxCXn4out0wHELXA5Z5h6XuwlzMRRIrhomGFU=;
        b=JkjhPARKu9OAKSxiesEoPJbv85wgZxOMC2F9B5j14643niVD8NFX8Tq/DfYPZ/2nMi
         1cEwUPGqBl7Ljq/XC9nyh7YHoRxOScJAshFdvj/1LknUSn6ievUYaEB9aaUXs8pIoPWu
         Js07RKkPg+E25BH/JzoRbT2eRH7ec/6vIC8itAn4MONUnBYXQPaCsSp1fDknk2kjhBWn
         HNIq9U5LqZzdqY1hpMAbpyzBhF2qGZzNX83ArXeH4TsgeYdskIBvcCDPsJT0KHYopCCW
         AUKo4uykwDMBFNQVFzGu5jD78m6zsX4gI0L/ToM3JXdbum11Y7kQs1mxDpWFWJEdEcpI
         zxdQ==
X-Gm-Message-State: AOJu0YwSZXPzcxXD5RanI5LYGkVS2wkmEXIOi/c7nVdOrY+Ty9imSqtq
	h5+YTV/QRgXAewxMAbXp/pqvDDP9w1ggqankPNhzvz826Cqxzom5o3mXwqhPTVX3Xtj+EUImOsB
	za4Hx8HAALHM3ule3T+mKFhcAM3n8A3R18MPPKeJ7W9EoKtvagfmevQ==
X-Received: by 2002:a05:6a20:1824:b0:1a1:67c7:3ba4 with SMTP id bk36-20020a056a20182400b001a167c73ba4mr8580922pzb.51.1710257244526;
        Tue, 12 Mar 2024 08:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWH08GPkN3yS9nkXqOwjXA9YHlNM8PdeCaFjXBLasZR3oXnUTRMuqMWcHPzMZk6gzAxntf0Q==
X-Received: by 2002:a05:6a20:1824:b0:1a1:67c7:3ba4 with SMTP id bk36-20020a056a20182400b001a167c73ba4mr8580902pzb.51.1710257244235;
        Tue, 12 Mar 2024 08:27:24 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006e6ab7cb10esm969668pfa.186.2024.03.12.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:27:23 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com
Subject: [PATCH net] hsr: Fix uninit-value access in hsr_get_node()
Date: Wed, 13 Mar 2024 00:27:19 +0900
Message-ID: <20240312152719.724530-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported the following uninit-value access issue [1]:

=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
 hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0xe12/0x30e0 net/hsr/hsr_forward.c:615
 hsr_dev_xmit+0x1a1/0x270 net/hsr/hsr_device.c:223
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2787
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5033 Comm: syz-executor334 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================

If the packet type ID field in the Ethernet header is either ETH_P_PRP or
ETH_P_HSR, but it is not followed by an HSR tag, hsr_get_skb_sequence_nr()
reads an invalid value as a sequence number. This causes the above issue.

This patch fixes the issue by returning NULL if the Ethernet header is not
followed by an HSR tag.

Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Reported-and-tested-by: syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2ef3a8ce8e91b5a50098 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/hsr/hsr_framereg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..26329db09210 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -228,6 +228,10 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
+		/* Check if skb contains hsr_ethhdr */
+		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+			return NULL;
+
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */
-- 
2.43.0


