Return-Path: <netdev+bounces-154549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381809FE8EC
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED391881EDB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502891AA1F1;
	Mon, 30 Dec 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Tf4hGz8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF919DFA2
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575011; cv=none; b=WTNayCZ51N2+efODiFvEn4+3OvWZU9uBzVjaOjsHtTe75oF3PsYwn87B92NjTJ7DskN4QqQWiBRwcdU2B0zJI+MQ3g7BlN/Dvcq5PngVhUQe9ZwuilcCzjoHghg2J1EJX5WsXHdh0EZ1jFdWwPRX9rE1aTpR+cORtVRBCZifhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575011; c=relaxed/simple;
	bh=rUX7Q54zeA6rQG4ndOOS3zkEOshSzxQvZoe9WYPXlRk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=huDctjRJLwjLkycgHFShFwMdqaNa5/BU1bt7ODy2BQbJi51TavqQel9PCwVTeNdOjZF9o5fe+ZBewg0DN931BxIB5SPezDg5Vzkhnaquq52WBNLXcHRAOO5ZCNmtSYuFiFyvci/SqJ6OgsggvSGPxysldgFqBJa6lTWDkby5wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Tf4hGz8; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b864496708so2917756085a.2
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735575007; x=1736179807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gYoJWg+05JTpt77YjEuxUFb3/RQzkDARd+N6UyAvxnk=;
        b=4Tf4hGz8riTaSEPQ9a87wPDO6Gsko31kI1YtV4fVF5NtuM6cDGfMgIEzAA2i9BG8eF
         6QSwra3sHTCo/AnS9nhBEshtdTgdThdpKXZWCjRMgnT0iDmp7M+Rm3Ho5k1h2dtH5DNV
         s2OnLIKbyoTv+Totlbeu4mfeTO7A2XhHUC8nFbd4ihGW2gQ9GiHp00g7GIINcYCUJPl0
         AJvcuis70oDJnJXpytKijVfoBNA/QPg3gQlG2KdSZzW+Xk7va9lT87ZHT4K0PYrl/7qp
         g/wHdKJkjBYbYpAae7XM/iP9sxzjpCCb+bYwJHl6A52MlAUEh0ufT0wpGhZiKKu1IZfL
         ZG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735575007; x=1736179807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYoJWg+05JTpt77YjEuxUFb3/RQzkDARd+N6UyAvxnk=;
        b=N9O0bvMc9H0bKpWjWwCsE3H2G9e4N4G/hLC2CC3snsqfJUG8M1d0dVF52P1U/dXMvk
         O+zAQAS1CTcXnFUeqN/wJvaAV56JEcW4gTCVjZM8NbJ+iwiq7DQyICZ3ZNA4Wap9xKxJ
         CVoVQ1CdBCxLZX+Jp7gyd5trJlP/NrF43tWRykk4jO7JvCwP6Xzuocb9E3xUWKj4oUx4
         l2iBhK2Ksiuzbtq0XCoNvKqMUvcKBwG52jvoTblAsj+AyS1vf1VRWMag4LFo4PoA+g7F
         OYofKv5Nm5cv0e/zF9Gjx48CoYRFxWcyTULj6nJcc6ewvV8wTjydKO0/G3x4sm3TxtcK
         NtMQ==
X-Gm-Message-State: AOJu0YxAkQ5IQIAaBpYNjaerD82LFlToxj7+od+npKgHCoBrh7bo8z6l
	Ac7iMl42/aVWJiBLtOCg4xOcqOI0IiCY2i49drSQfPWWtD1iiEta0fxHPXRyUrdCYI98xaIHeYI
	Lc7jidp1zUw==
X-Google-Smtp-Source: AGHT+IHGXw/9laewC3nvoMDZQIJ79RQHXnCHOy8tqUMd63JEPcF8JUOdHTUm8bTZVIk2T/5rEUPrLSu6W6XqPA==
X-Received: from qknuc25.prod.google.com ([2002:a05:620a:6a19:b0:7b6:d6df:c076])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:459f:b0:7b6:d4df:2890 with SMTP id af79cd13be357-7b9ba6efb22mr4946775485a.4.1735575007661;
 Mon, 30 Dec 2024 08:10:07 -0800 (PST)
Date: Mon, 30 Dec 2024 16:10:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241230161004.2681892-1-edumazet@google.com>
Subject: [PATCH net] af_packet: fix vlan_get_tci() vs MSG_PEEK
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com, 
	Chengen Du <chengen.du@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
by syzbot.

Rework vlan_get_tci() to not touch skb at all,
so that it can be used from many cpus on the same skb.

Add a const qualifier to skb argument.

[1]
skbuff: skb_under_panic: text:ffffffff8a8da482 len:32 put:14 head:ffff88807a1d5800 data:ffff88807a1d5810 tail:0x14 end:0x140 dev:<NULL>
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5880 Comm: syz-executor172 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 9e 6c 26 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 3a 5a 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90003baf5b8 EFLAGS: 00010286
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 8565c1eec37aa000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88802616fb50 R08: ffffffff817f0a4c R09: 1ffff92000775e50
R10: dffffc0000000000 R11: fffff52000775e51 R12: 0000000000000140
R13: ffff88807a1d5800 R14: ffff88807a1d5810 R15: 0000000000000014
FS:  00007fa03261f6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd65753000 CR3: 0000000031720000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  vlan_get_tci+0x272/0x550 net/packet/af_packet.c:565
  packet_recvmsg+0x13c9/0x1ef0 net/packet/af_packet.c:3616
  sock_recvmsg_nosec net/socket.c:1044 [inline]
  sock_recvmsg+0x22f/0x280 net/socket.c:1066
  ____sys_recvmsg+0x1c6/0x480 net/socket.c:2814
  ___sys_recvmsg net/socket.c:2856 [inline]
  do_recvmmsg+0x426/0xab0 net/socket.c:2951
  __sys_recvmmsg net/socket.c:3025 [inline]
  __do_sys_recvmmsg net/socket.c:3048 [inline]
  __se_sys_recvmmsg net/socket.c:3041 [inline]
  __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3041
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")
Reported-by: syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772c485.050a0220.2f3838.04c6.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chengen Du <chengen.du@canonical.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/packet/af_packet.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 886c0dd47b66210e4bbaf8e78f1778c2d25b896e..e2e34a49e98dedfed855ccb004ca57ef18626ddf 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,10 +538,8 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
-static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *skb_orig_data = skb->data;
-	int skb_orig_len = skb->len;
 	struct vlan_hdr vhdr, *vh;
 	unsigned int header_len;
 
@@ -562,12 +560,8 @@ static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
 	else
 		return 0;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
-	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
-	if (skb_orig_data != skb->data) {
-		skb->data = skb_orig_data;
-		skb->len = skb_orig_len;
-	}
+	vh = skb_header_pointer(skb, skb_mac_offset(skb) + header_len,
+				sizeof(vhdr), &vhdr);
 	if (unlikely(!vh))
 		return 0;
 
-- 
2.47.1.613.gc27f4b7a9f-goog


