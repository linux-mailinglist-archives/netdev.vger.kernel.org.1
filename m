Return-Path: <netdev+bounces-149008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91089E3C54
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38D916A435
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1791F7589;
	Wed,  4 Dec 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNKkOQus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8C31F8901
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321435; cv=none; b=ZiENfurbRfYwV9/q4Ymt/Uua7aenxO2Tw1yG4soZYX9F+K6yo8sbSqNYE2W6o9PRC/jA4/TdJhAjORCd5fst8IiqTcZX4U6d9ih3RjfVsgQEXqs5yTkGtNTeJsclr53y8chtIveF8tKZ+o8vJ+VPdDMS2j/W/iCj4tyEPj/IFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321435; c=relaxed/simple;
	bh=GVDsDE1B8g+/VPEJrLRC1jffhk036aDFnGYidI+v76s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qNM206OYu5cAo6sYhoEbrNDWp+GPGtMRBbMryUwNv+gKnlF05WUTBd7m6bMvU3xRdqgJWTwAeaM2Exg3S/SNz9LB/PrlQApMd3gM7CKE7wTRuMJZDQmqJ9yHjxPyh75mJX8QwxLU3Vdc1cuW70GMRKFrDK197MLpHsufhCponJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNKkOQus; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4668d3833a4so141258201cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733321432; x=1733926232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IW6Gotd2j4I5hRdGOPLy0chScrPfpQfQ+DQAd6uG4e8=;
        b=MNKkOQusZvYDlhQnMaE8GLib+BYZSQi44NytM/hUqEi4oXkX3qhVihwv9XDEkeZWaa
         +K4Qvtjdp1j55/zBM44BAWcutnjkVyIhudRM5znTFwd/WF8t4Iu3yMV6b5PE+VGwzAD0
         5QEMaL8zNtVVX8VBA9mmTlvuwp0E9o0+2I68EBgclbuvA+T9J5KtdoabcEPxupWfFo99
         lNXMk6MQ5U+DUPQ3a+ckxH8dbsAIxrCq3E4PIpAJgRJsVHlbA6KwDcBlxpnzLQxso1II
         iLB+CyXFfTsZOhj1uPNLxlJQXQpop5WXtN1imsAiWI4rFpfBb05onVnHSM8Rn0w33Tzo
         26qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321432; x=1733926232;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IW6Gotd2j4I5hRdGOPLy0chScrPfpQfQ+DQAd6uG4e8=;
        b=k3/yv/dNLjMbHiDl4N51xzOlnvRsJS1l5JVBf2oXTJEl0lajDfLViJ/U8UamGkNk8C
         sif94knIPZmpg+Q+As2SblkvvDeZ1wASke707+VRQU3Ava0FNfF8PvwIyT8PmlbFRyKI
         AWlwB0BNm0/i56CxrqU995WisgHref6GGTUJDFpfYNNp2PuwTeb/AHE9tzgGQKdcqMPX
         +9piMPoPma0663hUKZ8pWZ0Jy8ywUjaTrFD/bv+M2atnpJ/51Q2rx425toNR+QAVflX6
         XmKs5KqbtyMWYxj0pAuHeFtyFEn0j74AYvfQMqHBaQ8ro7qg6+2zVT4xLg+dgr0C7YyN
         60Pg==
X-Gm-Message-State: AOJu0Yx2+Hwlz72otjggj+rWnM9lKEAA/kMlZOUoprO7ULqwziv0PoJm
	BhJzMMDqYYwPxmt2lCaOpzWulZh0Q1r1BNJCk5krs8IbytcWF9L7iKMOnSVeajBvejsVZdmWlmO
	/xpFdws8u8A==
X-Google-Smtp-Source: AGHT+IG7yKzAWcBQ+CZG6p2WusnRE6cXRNGl8vvzhapiBZk+Sx5s6KdIUBa3ZMZdwIBGDlPY6YsREd+FPZKOvg==
X-Received: from qtbfk14.prod.google.com ([2002:a05:622a:558e:b0:463:5a79:2fa5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:574e:0:b0:466:a41a:6448 with SMTP id d75a77b69052e-4670c141187mr91162371cf.18.1733321432290;
 Wed, 04 Dec 2024 06:10:32 -0800 (PST)
Date: Wed,  4 Dec 2024 14:10:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204141031.4030267-1-edumazet@google.com>
Subject: [PATCH net] net: lapb: increase LAPB_HEADER_LEN
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+fb99d1b0c0f81d94a5e2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

It is unclear if net/lapb code is supposed to be ready for 8021q.

We can at least avoid crashes like the following :

skbuff: skb_under_panic: text:ffffffff8aabe1f6 len:24 put:20 head:ffff88802824a400 data:ffff88802824a3fe tail:0x16 end:0x140 dev:nr0.2
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5508 Comm: dhcpcd Not tainted 6.12.0-rc7-syzkaller-00144-g66418447d27b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0d 8d 48 c7 c6 2e 9e 29 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 1a 6f 37 02 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90002ddf638 EFLAGS: 00010282
RAX: 0000000000000086 RBX: dffffc0000000000 RCX: 7a24750e538ff600
RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000000
RBP: ffff888034a86650 R08: ffffffff8174b13c R09: 1ffff920005bbe60
R10: dffffc0000000000 R11: fffff520005bbe61 R12: 0000000000000140
R13: ffff88802824a400 R14: ffff88802824a3fe R15: 0000000000000016
FS:  00007f2a5990d740(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2631fd CR3: 0000000029504000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  nr_header+0x36/0x320 net/netrom/nr_dev.c:69
  dev_hard_header include/linux/netdevice.h:3148 [inline]
  vlan_dev_hard_header+0x359/0x480 net/8021q/vlan_dev.c:83
  dev_hard_header include/linux/netdevice.h:3148 [inline]
  lapbeth_data_transmit+0x1f6/0x2a0 drivers/net/wan/lapbether.c:257
  lapb_data_transmit+0x91/0xb0 net/lapb/lapb_iface.c:447
  lapb_transmit_buffer+0x168/0x1f0 net/lapb/lapb_out.c:149
 lapb_establish_data_link+0x84/0xd0
 lapb_device_event+0x4e0/0x670
  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 __dev_notify_flags+0x207/0x400
  dev_change_flags+0xf0/0x1a0 net/core/dev.c:8922
  devinet_ioctl+0xa4e/0x1aa0 net/ipv4/devinet.c:1188
  inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1003
  sock_do_ioctl+0x158/0x460 net/socket.c:1227
  sock_ioctl+0x626/0x8e0 net/socket.c:1346
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+fb99d1b0c0f81d94a5e2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67506220.050a0220.17bd51.006c.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/lapb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/lapb.h b/include/net/lapb.h
index 124ee122f2c8f8e08f4b1a093673ab330996fe39..6c07420644e45aa3eec64dbd2cf520b14dc8b9e0 100644
--- a/include/net/lapb.h
+++ b/include/net/lapb.h
@@ -4,7 +4,7 @@
 #include <linux/lapb.h>
 #include <linux/refcount.h>
 
-#define	LAPB_HEADER_LEN	20		/* LAPB over Ethernet + a bit more */
+#define	LAPB_HEADER_LEN MAX_HEADER		/* LAPB over Ethernet + a bit more */
 
 #define	LAPB_ACK_PENDING_CONDITION	0x01
 #define	LAPB_REJECT_CONDITION		0x02
-- 
2.47.0.338.g60cca15819-goog


