Return-Path: <netdev+bounces-154550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDF9FE8ED
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FE3188225F
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF44C1AA792;
	Mon, 30 Dec 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iy9deWyV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD919DFA2
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735575033; cv=none; b=Z6JCJnfoTvkDBPLjGNEX8iEGD+Mp6l43Q2srXBHdRH00W9741pYgVlAK53jdbenUTewndrkUIgrd7hsnVR/uWmhTQrnnsOQE6hgxHh6yt3jkn+34O7MYfeYxDD8h6/b1/bnHfptCDcT8wojzJYe/c4ZdYBkhHAMUZ18ymeFQ8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735575033; c=relaxed/simple;
	bh=PKJgp3d7Jnw5en//XTACX726L0f1YZL5WfNk7CNVKQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PhyMvicpHh0D3uj77eszAyc05np/nudBXzucqBRDfpTU+yETIPLLctfyrE83tDJvuCLasIQvQ288rRtYAZzcsGqO2Bjli/zZL6RPvX145Of45xwFhqfREJG1dzAQSmrtW4TmqABH6IW2xdH9JgwWrOzn+yes5BNJ294SqO8EjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iy9deWyV; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46909701869so200552111cf.0
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735575031; x=1736179831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4D8XtsjYUnC7b2lOwHNhuI8h46eoyKhDFtvIKugvVoc=;
        b=Iy9deWyVUDrH2hdYMI99lRz/gsZtAevIX25fLpAvl9woKP5NnkDIhIP4hZGeFqgqzj
         fcgjSmx5SQftl98PPvgHFHINoFfKLk4m1MDOmo8XiCtwxg6QT2Ts6Q86sAjzx5SG53IY
         xm0TMrRvnlICHCf26JRm66lUXay9k3SwKgDvsMHG7oxbTWahKwXb42bXcntAdp3ZwWDh
         W0kJMBeV4RzEyB0Y5EHbPd+I/5KnDj4WSv+r1YwHmgquRjsVkX/rtC/Iag0eXPjgo27J
         zKEnNXrGTD9Gyi0+7Tv3r21cM0mlqERwH8iYVnj6AAwboVDwU1z4wXjdbMfBSCppymTG
         rNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735575031; x=1736179831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4D8XtsjYUnC7b2lOwHNhuI8h46eoyKhDFtvIKugvVoc=;
        b=Df/vz9E/C3Ukr9ud/UKQd7GUlXQzchNjy34xIr4f1otcVregoYJdmqBkeCUyI/PmYi
         KU9ZmXpuBZmmIyZ140KdYuYMzBx96yAkfE4C8gnuP/aMO3RkcFGTcz+APzbmkQBDHZbC
         xqCQMKkNIakb6rUH1nP2fCQgT/ymXRMeZimka6ujPcb9mPY60SihxVwGlpLQAX72T7e1
         HgtO47yPdXkHkR2ocMzooxMFG/stKzmiaTO1D+wMT3IkbPd4XouclYKUKsL8kq9PpTzD
         FrwHGrXRAYIv3GIooG6hIcfd8+4Xijbjtp7LuAYxt8E0qrxSumUEhmbCO1ELMrpmodyM
         stVA==
X-Gm-Message-State: AOJu0YwLN/ePr158DeRffw3r/7VglPErinuFiKoLHpw5B/RQB9RmS03U
	VMLfmaARLxWA0gjZmTlyNbCdp0sDM5AaViNJzaIyEBRz9ssjZ2LWUCX18gm1ZCTSnEMbn94BE8E
	YizV/RgwrtQ==
X-Google-Smtp-Source: AGHT+IFN4Jvn6uFy8OVhavAq9/cT99mkNJSWTgjTZlpnNj6vp873slwlGlN3yd0ZJe/Xs0mrJSdNo++vuMaKvQ==
X-Received: from qtbfg15.prod.google.com ([2002:a05:622a:580f:b0:462:bcd3:319d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f09:0:b0:467:866a:cc2a with SMTP id d75a77b69052e-46a4a8d0277mr647988251cf.16.1735575030896;
 Mon, 30 Dec 2024 08:10:30 -0800 (PST)
Date: Mon, 30 Dec 2024 16:10:04 +0000
In-Reply-To: <20241230161004.2681892-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241230161004.2681892-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241230161004.2681892-2-edumazet@google.com>
Subject: [PATCH net] af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com, 
	Chengen Du <chengen.du@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
by syzbot.

Rework vlan_get_protocol_dgram() to not touch skb at all,
so that it can be used from many cpus on the same skb.

Add a const qualifier to skb argument.

[1]
skbuff: skb_under_panic: text:ffffffff8a8ccd05 len:29 put:14 head:ffff88807fc8e400 data:ffff88807fc8e3f4 tail:0x11 end:0x140 dev:<NULL>
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5892 Comm: syz-executor883 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 86 d5 25 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 5a 69 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900038d7638 EFLAGS: 00010282
RAX: 0000000000000087 RBX: dffffc0000000000 RCX: 609ffd18ea660600
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff88802483c8d0 R08: ffffffff817f0a8c R09: 1ffff9200071ae60
R10: dffffc0000000000 R11: fffff5200071ae61 R12: 0000000000000140
R13: ffff88807fc8e400 R14: ffff88807fc8e3f4 R15: 0000000000000011
FS:  00007fbac5e006c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbac5e00d58 CR3: 000000001238e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  vlan_get_protocol_dgram+0x165/0x290 net/packet/af_packet.c:585
  packet_recvmsg+0x948/0x1ef0 net/packet/af_packet.c:3552
  sock_recvmsg_nosec net/socket.c:1033 [inline]
  sock_recvmsg+0x22f/0x280 net/socket.c:1055
  ____sys_recvmsg+0x1c6/0x480 net/socket.c:2803
  ___sys_recvmsg net/socket.c:2845 [inline]
  do_recvmmsg+0x426/0xab0 net/socket.c:2940
  __sys_recvmmsg net/socket.c:3014 [inline]
  __do_sys_recvmmsg net/socket.c:3037 [inline]
  __se_sys_recvmmsg net/socket.c:3030 [inline]
  __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3030
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")
Reported-by: syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6772c485.050a0220.2f3838.04c5.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Chengen Du <chengen.du@canonical.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 include/linux/if_vlan.h | 16 +++++++++++++---
 net/packet/af_packet.c  | 16 ++++------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index c1645c86eed9693454398f566a446b6dc6fa37f4..d65b5d71b93bf8e051d361ab4abc78d2a48d7904 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -585,13 +585,16 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
+ * @mac_offset: MAC offset
  * @depth: buffer to store length of eth and vlan tags in bytes
  *
  * Returns the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
-					 int *depth)
+static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
+						__be16 type,
+						int mac_offset,
+						int *depth)
 {
 	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
 
@@ -610,7 +613,8 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 		do {
 			struct vlan_hdr vhdr, *vh;
 
-			vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+			vh = skb_header_pointer(skb, mac_offset + vlan_depth,
+						sizeof(vhdr), &vhdr);
 			if (unlikely(!vh || !--parse_depth))
 				return 0;
 
@@ -625,6 +629,12 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 	return type;
 }
 
+static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
+					 int *depth)
+{
+	return __vlan_get_protocol_offset(skb, type, 0, depth);
+}
+
 /**
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e2e34a49e98dedfed855ccb004ca57ef18626ddf..2d73769d67f47c18db75cf43d67d8820350ffe74 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -568,21 +568,13 @@ static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 	return ntohs(vh->h_vlan_TCI);
 }
 
-static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 {
 	__be16 proto = skb->protocol;
 
-	if (unlikely(eth_type_vlan(proto))) {
-		u8 *skb_orig_data = skb->data;
-		int skb_orig_len = skb->len;
-
-		skb_push(skb, skb->data - skb_mac_header(skb));
-		proto = __vlan_get_protocol(skb, proto, NULL);
-		if (skb_orig_data != skb->data) {
-			skb->data = skb_orig_data;
-			skb->len = skb_orig_len;
-		}
-	}
+	if (unlikely(eth_type_vlan(proto)))
+		proto = __vlan_get_protocol_offset(skb, proto,
+						   skb_mac_offset(skb), NULL);
 
 	return proto;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


