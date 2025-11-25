Return-Path: <netdev+bounces-241620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30846C86E2B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D9EE4E2132
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79A8339B3C;
	Tue, 25 Nov 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzKAHy/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C48284671
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100416; cv=none; b=Q8bdjv/fOpajJD37Sus0StlZyGm1gLWzCrjzks/HxatKi9aUMT6zRvbTXAqjNAdR4aND8buf0tJ1jrjmkiU8PXHRAvZQPZNp5hjkEvz5OibFxGjOduc1h4mm9RuO0rNY1CoGyhWzd/Nc3LG+nbJYjvJlO/tpL/lXljCg6313Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100416; c=relaxed/simple;
	bh=V9++8CfghHE9kXk52kab4IwT75PiD/CKu9voHAoMuSg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H7ZJhbssVNV/KRnvkdR8IOSxc+gTK7yM4iQmnZtMGvCAAtcG9t2BobDuALdg/pe5Y8WsuPIaKQABpGtQEPbuTyTqF+PERfF7z+aapdjkteeV41rpolIyCYJ49gn4f64eIT+0UH2xWf33qmMQkbCj7IwehEgAd+lncM3OsJr1r2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzKAHy/+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso16755167a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764100414; x=1764705214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SeA0yLyz4jPEUwkyb3aEK2NLzFMCnFcfVIGvyM4g0ZE=;
        b=FzKAHy/+03Wql9ahiaB5fHO+JH02GQDf1ynRH4ZgEV8L0TQFqYbjwEGMVEDYQZsALH
         loxP86/jSZwr3d+pD9r5XyT9fsCnwlNH51CerziU0qIjrwM0cQd95flKc9i2Y/ePT1DV
         l9sJuHzPjrXTWFKiwRh0eOyjGEiKf7tMDslOcnjTWtV4DEBT+D3sWcZjoYJ88QdLfLB6
         3Gc49a4WgEgCo1eTQ1FFx9m9coTQDTAJlTWiMtJFd9RB8wuqwza5hifWaVz0cayoZ5hB
         vBSnaUYVEKvCsFIdnQ6pgPpXODqLYUPahNzIOLKAT6CRUi+v1kaZtAqCSNLBbZg0b7nw
         3Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764100414; x=1764705214;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeA0yLyz4jPEUwkyb3aEK2NLzFMCnFcfVIGvyM4g0ZE=;
        b=D0F/VJf3fTlU7rs7IM4mfiM2Fhf0o0lFEPr4IjmN4xX8OehKZpJjfJrJgLSOS/I22X
         /hpzz09FBY3PYfA7fY+JAmzcmu8Hdg1fIgE6jU3KoMbu6rwjxMVehL0Lf0lfjMAwKMZx
         t4/2TKtYIGr7w24FENqapIT2VMbANI6hNaYJW2KlPBKnxOqtYq33Vj6bccoROG7wQuCD
         W2sSr+KWB7ntEfQlWy0bbgUXWmv88loGbr+tmBg4axTq0tbQYRy3pvhm5zf91Z4crVba
         M0DiB0hB/SsHfnJo0xQs2Pr0GqewECaKycHMfjpx35jQGHhiSMlhYmKgddRjNNyjSWl/
         9Gqw==
X-Forwarded-Encrypted: i=1; AJvYcCV9/OJcM9FODOimuZohD6Zi1GARwza8MFrsGF2pt5UX0+8ZABLkvxygyPw3gzjUKLARbnenXL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQRaT0UiOQRfC/HXWNgKGvzOCP3jXv/mbmTxu+CeDSVwrt/4c
	ZUcBSfXd8UblJc/E67r/Z3MV5bgrf+dcvqnYdh1rqEEFdINzqPPLHoKnVOJb0vPhWijPEp3IH5J
	RtGpwWA==
X-Google-Smtp-Source: AGHT+IGNsFB4xWN6CQWFAkhsE/ZD+qWTz8BqSj/qzGJXMau6bz9n6nTVtiXT2QPUf2NEIUdoaLnCsMNs04Q=
X-Received: from pjqv4.prod.google.com ([2002:a17:90a:af04:b0:340:bd8e:458f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2587:b0:341:8c8b:b8e6
 with SMTP id 98e67ed59e1d1-3475ebe8675mr3826868a91.16.1764100414170; Tue, 25
 Nov 2025 11:53:34 -0800 (PST)
Date: Tue, 25 Nov 2025 19:53:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251125195331.309558-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] mptcp: Initialise rcv_mss before calling
 tcp_send_active_reset() in mptcp_do_fastclose().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported divide-by-zero in __tcp_select_window() by
MPTCP socket. [0]

We had a similar issue for the bare TCP and fixed in commit
499350a5a6e7 ("tcp: initialize rcv_mss to TCP_MIN_MSS instead
of 0").

Let's apply the same fix to mptcp_do_fastclose().

[0]:
Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c 41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
RSP: 0018:ffffc90003017640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tcp_select_window net/ipv4/tcp_output.c:281 [inline]
 __tcp_transmit_skb+0xbc7/0x3aa0 net/ipv4/tcp_output.c:1568
 tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
 tcp_send_active_reset+0x2d1/0x5b0 net/ipv4/tcp_output.c:3836
 mptcp_do_fastclose+0x27e/0x380 net/mptcp/protocol.c:2793
 mptcp_disconnect+0x238/0x710 net/mptcp/protocol.c:3253
 mptcp_sendmsg_fastopen+0x2f8/0x580 net/mptcp/protocol.c:1776
 mptcp_sendmsg+0x1774/0x1980 net/mptcp/protocol.c:1855
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe5/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66e998f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff9acedb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f66e9be5fa0 RCX: 00007f66e998f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
 </TASK>

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Reported-by: syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69260882.a70a0220.d98e3.00b4.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 75bb1199bed9..40a8bdd5422a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2790,6 +2790,12 @@ static void mptcp_do_fastclose(struct sock *sk)
 			goto unlock;
 
 		subflow->send_fastclose = 1;
+
+		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
+		 * issue in __tcp_select_window(), see tcp_disconnect().
+		 */
+		inet_csk(ssk)->icsk_ack.rcv_mss = TCP_MIN_MSS;
+
 		tcp_send_active_reset(ssk, ssk->sk_allocation,
 				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 unlock:
-- 
2.52.0.107.ga0afd4fd5b-goog


