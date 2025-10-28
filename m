Return-Path: <netdev+bounces-233421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB26C12D30
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 705054E8642
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58928A3EF;
	Tue, 28 Oct 2025 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzexRULe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0A288C25
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623944; cv=none; b=aMhsLOsEEZ5rOgsMf9CdSyfqmP/JlRfYof+3NCPBiw2AbTaaK2HhmIZ8pymBYqnb1BNr8ZCX56Gpq7e07nq46PO0NngEIv6WSzTIH0P4w3keL9byfxtUg2J3pfHlBeOv+5IZzSLDnkNmeOZafvAX8gjmNZigFbrr4e+XYZi76t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623944; c=relaxed/simple;
	bh=BcUm/QCC2rYngacBF9iqIh29KE6Quw9C1nhsDVm/4G4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lqXgCzlqGtb9OF8X8DUA2GJaR3PVVjhMfxi+yFKJvFqy9gMTb/xv6ocq1sXMKCVa5xUCSRsqouyacEIC16yA0l2V8inzkEIxxXO0ux1mcLRUlMnGB5dm7nqaVGuTnht46zr4HKZoQhrxzSIujFNBuT29Th0rcxES+kKNkXwu774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzexRULe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2930e6e2c03so57835845ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761623942; x=1762228742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tQVXsxIcydS1ZgYl1JP5iKZGTu67oZxKrTuZTxvulzA=;
        b=zzexRULe6MVUJlWrFf/XdHHX5IjaXuImJpMZ4b1lAjNuK14XWdSxrUH4GULfQGIsuE
         0ljwK1/sRIEu39E9HMgizn0qaanz+0/LXWCuuidsayqNfeUV1jJ2vKRb0I0khh4eQMMg
         fvG3S0owcQGtqiHDeNM+MJNb/pBK562zgvJuVH9sBCZhDaJpAYQ5Cb+sIM/nEJuzW0CR
         J+DHYKPVK/VM7nwF7WwbfzLJmWrLBsqXAor2WtPJs5qbpGckhXCavuSPoUhed+Xca0Lt
         Slr6DAkCCMNYlYcwnapo0/c3zsTHArt5NiHDElSOfZZQ8lwh4eDHVEZxUV1Cv6OzaXLq
         NkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761623942; x=1762228742;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQVXsxIcydS1ZgYl1JP5iKZGTu67oZxKrTuZTxvulzA=;
        b=TaYNf1adUpoV4/q88N4Ov3xO5HwkISF+S8fDJYwj7S1+aHjh2+wkWdbLO45lIxvAKZ
         o+odxskBbcqkrfxfc+CRK2R/ccjtylfc1UmyPmUjcvTy/9EZtCQLKuOhPD2apq8phM+o
         +LELorBhFvlgV/Um+qIuiPJ5o+wHBiRefq6crXtPYHxzrh3UaJI2bT6IwuJh5nxUKaNf
         rQIjLmb/G8gBoW6vjzqKNG5MGYICPvCmsX3LatK694fAl6bDU8sTUpc331NptfbTk03k
         rrIRBptZy84M0du3bJTDFfaC17rVipE37Y5C+Fz0WT/6FA4mOx/pfVJwsfOvaNWtYoTE
         vD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2f3QFrVx3KK851DGt/ywGbPLjxXJBxrwAwhhpPAsOk9tTSPgIDEKTTHFjZze/dYivvViJzmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvmB2fsv8MGFVsN5JIGc/gD1F3G+Nxg118jINui2pYor2p3NH
	IZqTpQedfr5nBhDHahn+R3c2n9a174ENt8VCX+/2EcGPiXXTcjd8fUEt2t3MxA5OMsZuJlNXsrb
	KMi2bcg==
X-Google-Smtp-Source: AGHT+IF7cXOdRvYwkCxG/idl4vVQUGElY7/FI9uy0MLxuDYetQ2I+rZJ23RUMcMQiPqta1w6GXc4FGpnKt0=
X-Received: from plda12.prod.google.com ([2002:a17:902:ee8c:b0:25e:8dce:6855])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8f:b0:26d:353c:75cd
 with SMTP id d9443c01a7336-294cb381901mr30640755ad.21.1761623942072; Mon, 27
 Oct 2025 20:59:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:58:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028035859.2067690-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] net: sched: Don't use WARN_ON_ONCE() for -ENOMEM
 in tcf_classify().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

As demonstrated by syzbot, WARN_ON_ONCE() in tcf_classify() can
be easily triggered by fault injection. [0]

We should not use WARN_ON_ONCE() for the simple -ENOMEM case.

Also, we provide SKB_DROP_REASON_NOMEM for the same error.

Let's remove WARN_ON_ONCE() there.

[0]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250
 should_fail_ex+0x414/0x560
 should_failslab+0xa8/0x100
 kmem_cache_alloc_noprof+0x74/0x6e0
 skb_ext_add+0x148/0x8f0
 tcf_classify+0xeba/0x1140
 multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
...
WARNING: CPU: 0 PID: 31392 at net/sched/cls_api.c:1869 tcf_classify+0xfd7/0x1140
Modules linked in:
CPU: 0 UID: 0 PID: 31392 Comm: syz.8.7081 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:tcf_classify+0xfd7/0x1140
Code: e8 03 42 0f b6 04 30 84 c0 0f 85 41 01 00 00 66 41 89 1f eb 05 e8 89 26 75 f8 bb ff ff ff ff e9 04 f9 ff ff e8 7a 26 75 f8 90 <0f> 0b 90 49 83 c5 44 4c 89 eb 49 c1 ed 03 43 0f b6 44 35 00 84 c0
RSP: 0018:ffffc9000b7671f0 EFLAGS: 00010293
RAX: ffffffff894addf6 RBX: 0000000000000002 RCX: ffff888025029e40
RDX: 0000000000000000 RSI: ffffffff8bbf05c0 RDI: ffffffff8bbf0580
RBP: 0000000000000000 R08: 00000000ffffffff R09: 1ffffffff1c0bfd6
R10: dffffc0000000000 R11: fffffbfff1c0bfd7 R12: ffff88805a90de5c
R13: ffff88805a90ddc0 R14: dffffc0000000000 R15: ffffc9000b7672c0
FS:  00007f20739f66c0(0000) GS:ffff88812613e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2d2a80 CR3: 0000000024e36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 multiq_classify net/sched/sch_multiq.c:39 [inline]
 multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
 dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
 __dev_xmit_skb net/core/dev.c:4214 [inline]
 __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f207578efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f20739f6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f20759e5fa0 RCX: 00007f207578efc9
RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000008
RBP: 00007f20739f6090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f20759e6038 R14: 00007f20759e5fa0 R15: 00007f2075b0fa28
 </TASK>

Reported-by: syzbot+87e1289a044fcd0c5f62@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69003e33.050a0220.32483.00e8.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
targetting net-next since there's no real bug.
---
 net/sched/cls_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index ecec0a1e1c1a..f751cd5eeac8 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1866,7 +1866,7 @@ int tcf_classify(struct sk_buff *skb,
 			struct tc_skb_cb *cb = tc_skb_cb(skb);
 
 			ext = tc_skb_ext_alloc(skb);
-			if (WARN_ON_ONCE(!ext)) {
+			if (!ext) {
 				tcf_set_drop_reason(skb, SKB_DROP_REASON_NOMEM);
 				return TC_ACT_SHOT;
 			}
-- 
2.51.1.838.g19442a804e-goog


