Return-Path: <netdev+bounces-92189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D02B8B5D5C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBA71C2197A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9138563C;
	Mon, 29 Apr 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUxKW8+j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9485280
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403778; cv=none; b=fC3sb4/ZsN+b3ox5gyDFDoRJfVE8soKzefMGZr7EZI89I5sXDNKAT+jOmetNxnvmU/EGuqXOdsc4XO1yO38Z6Mtx+TXZb/gmcJQ6GDnllfXiQ11smpQbj3dNuAznoggC1ZmeXDtsuwiK04oYAPJdCP/7mrPU4i6zP7q5cp1SZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403778; c=relaxed/simple;
	bh=JInUyCfWa4cj2hSY+8TlfNabBmIPS0UDzEe5ma2bn5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KemuvJMfdfoWBdQesO+uXUIagxdhVLFipc7W3hHxE4zwYEBJC+LWjVieOyHuR0ouuVnh0/tGVW0MQNzpdikOUfCnTggA/tKxGbdvDKWg1I17um3uHbdPV5d9xE6ObpY3xrTpYvHzKlRl7Dz/G4HGF9ICF+KzOqQVz86bWdyDmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUxKW8+j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714403774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k9nifAwGr2Zp6gvAQ7eF6eUdfZNy/PCRT7il66zHEGQ=;
	b=XUxKW8+jAA+WeG6/fdU4oJYm71MXGCX0MIunRMU0textbyYnWRP26RSTfOF5pOjZH1DfzM
	85WlKc77CV1V3jqQztr+qlICPYaAOTZWJP7AxRM75FqUPQxThgiuUVy0+XjOeV+RfnW1pl
	eZkXuBgvUhrxpCZYceO7veJovJahs9c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-5R4o--ttO8SUPyyRYBkGJA-1; Mon, 29 Apr 2024 11:16:13 -0400
X-MC-Unique: 5R4o--ttO8SUPyyRYBkGJA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2abc5b4f3c7so5339862a91.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 08:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403772; x=1715008572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9nifAwGr2Zp6gvAQ7eF6eUdfZNy/PCRT7il66zHEGQ=;
        b=I2RrsvAEmf20Ga9GS/WDNLRtAko5kb//vN9Fz1MsOZJTzcg0ThQ2zKyM7JWG7gdEA+
         Sv5WAzhLSFda3oPKu3NnFsHT3TSU3gaQo8dMJRZCXanMtMMluKQHOU56q2GN/OjAX7R3
         HiIzOdxKridZXF6dxtl22FhB1B1AnxHHwvvfBTe1qUHShwH0aAPbMvd4UV3NHTDbqcV7
         G8p2IdwL3MI9pq/dP5M5QknL9B3lc33LP7dJiQP5vhRx0p00ou49eNRqCcE2Z3GGgirC
         Ji0jZRzwnydXkzaS+LVBxCFebZ9lmo5JwAeCqESl4ziDrcCztkN38wIfCe3Em/QEKb9S
         9YAQ==
X-Gm-Message-State: AOJu0Yxle8mBQNzIiyXHMN+xjoHEv5eOqxeeGZiCAWiuEFdbG7BtDuD/
	Twcg/IcMmzMX9uVUKRcpGfOrrc/h5kLVfjtXd7qUhlI+Wnpk1hk3Xn4aaKmYhaWibbxd/SVJLad
	y6LGGYgaa8Rb5nY9msvbqLbtxKbSKj/YqzNOAR01T5NWyFsBM/Z8Wig==
X-Received: by 2002:a17:90a:c292:b0:2ae:bbf7:30fa with SMTP id f18-20020a17090ac29200b002aebbf730famr8504460pjt.3.1714403771779;
        Mon, 29 Apr 2024 08:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPSUIoPmz7NnF1amN3oBULQy1w4IN8FGpSu183OjoavIw2Db/Ild1Dxk/V3NT0S8XGUWTzzw==
X-Received: by 2002:a17:90a:c292:b0:2ae:bbf7:30fa with SMTP id f18-20020a17090ac29200b002aebbf730famr8504428pjt.3.1714403771253;
        Mon, 29 Apr 2024 08:16:11 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id nv5-20020a17090b1b4500b002a2f055e52csm20840663pjb.34.2024.04.29.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:16:10 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
Date: Tue, 30 Apr 2024 00:16:05 +0900
Message-ID: <20240429151605.2055465-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb()
tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause a
race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
while __ip_make_skb() is running, the function will access icmphdr in the
skb even if it is not included. This causes the issue reported by KMSAN.

Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRINCL
on the socket.

Also, fl4->fl4_icmp_type and fl4->fl4_icmp_code are not initialized. These
are union in struct flowi4 and are implicitly initialized by
flowi4_init_output(), but we should not rely on specific union layout.

Initialize these explicitly in raw_sendmsg().

[1]
BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
 __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
 ip_finish_skb include/net/ip.h:243 [inline]
 ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
 raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
 inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x274/0x3c0 net/socket.c:745
 __sys_sendto+0x62c/0x7b0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2199
 do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
 ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
 raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
 inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x274/0x3c0 net/socket.c:745
 __sys_sendto+0x62c/0x7b0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2199
 do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 15709 Comm: syz-executor.7 Not tainted 6.8.0-11567-gb3603fcb79b1 #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014

Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bug in __ip_make_skb()")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2: https://lore.kernel.org/all/20240324050554.1609460-1-syoshida@redhat.com/
- Explicitly initialize fl4->fl4_icmp_type and fl4->fl4_icmp_code because
  we should not rely on a specific union layout.
---
 net/ipv4/ip_output.c | 2 +-
 net/ipv4/raw.c       | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..39229fd0601a 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1473,7 +1473,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		 * by icmp_hdr(skb)->type.
 		 */
 		if (sk->sk_type == SOCK_RAW &&
-		    !inet_test_bit(HDRINCL, sk))
+		    !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp_type = fl4->fl4_icmp_type;
 		else
 			icmp_type = icmp_hdr(skb)->type;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index dcb11f22cbf2..4cb43401e0e0 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -612,6 +612,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
 
+	fl4.fl4_icmp_type = 0;
+	fl4.fl4_icmp_code = 0;
+
 	if (!hdrincl) {
 		rfv.msg = msg;
 		rfv.hlen = 0;
-- 
2.44.0


