Return-Path: <netdev+bounces-137885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BF9AAFFD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605AC1F216ED
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DB19F10A;
	Tue, 22 Oct 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3wOuhxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9419D8AD
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604902; cv=none; b=Ijdol4qpL+QkgYqtX9wnqVOjWYtKFSM6gfmIa6GF04sWmUf+LVuwOIYP1lTyhAPDWc2Cu7dhS3XAzD+KpbxNO9LXOi/K/D0v1MT/5/tDyZrsEwVGpntvP/ildH+wGznE6KnPke/igZ+8WB8FJEkjytRSWTG9VILDuBGSjTsai+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604902; c=relaxed/simple;
	bh=7h+hzZ+zkBM9XrBrHnjxc6uBePWYeaKGyNatwPtHcP0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q1rCu02vpOHW0mqD9iSXSYwvkfFCbNmmDlr7ga0a0Zp4IBmHIWwTrQ+gy0qP+3n9gOv3Ej++nmF06MJYSwuFGcXf/Gi7+TxIvySP4bIWPKlqrMvSTgviYLZDzZhoezfe0zjBf8541LU4sc6X30MX7Y4PccHkN80DP3u8HgHKKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3wOuhxd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3204db795so84315937b3.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729604900; x=1730209700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=402J0r40GweoV66fZHDsoI3E3/YZ9h9D2jpaIEw7DG4=;
        b=D3wOuhxd5QUeLY6HAerVfc6rGsBb+MZeJRE7iOqINNljXo6urgixI/RhRU7b2jukxa
         RsVTEBudaVyUMU21fS/MHgBRtJUoUZWme08iYbVcSwhPjjRjBNJkr9Ea0KdHseI10fI3
         q8Dks9RUVywT27oAxdXc3kTqML1x0smTV8xGyo4rQ/Hucj+fExivxU/Hk9yygCcsNXmY
         ZoE1EiCEC9DjPD23kZ9Mk3UHeIM6FnGihCOuNU01w6z3o8i4rPpu3PAMaPmej+3c5qam
         DTQ6NScJ4aMfz+nLAzunbYqv73e7S637bd9XYWGmKs/XTq+00G4N5yohC/uaQlYamq70
         VIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604900; x=1730209700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=402J0r40GweoV66fZHDsoI3E3/YZ9h9D2jpaIEw7DG4=;
        b=nuPDWX+6+VjuNtMSYn3eBV3pKo9Ne3tsDrUV9wV0/3n/DJu3KoyGpMuFAweFDJyyB5
         JFKlzBV/D26hvUExxgiYEd57pqTzhYZZYbaPmBt/nwszwXfWo3XeE9udZMzJuMRfyg+C
         O6MlYCRdAAQI/ASY4f08IUxOkjFBQtLlD62BbD81D45dL9Zu2l8NLyBuQKhOjrk+FaJZ
         Dbu196ERahPiQXR44JDFJ/xgBoMbkkcHSk5mahNRk3dQK4LFBQE9SmYSNEGXJAugsVFN
         Zok+O6Fmb81I+BhYVgRGzC4vnOUrPOl4zuC/mjbzYqiDChFqap6o6QH+/YxN5aGS6Svd
         PrnA==
X-Gm-Message-State: AOJu0YwZzX73NyF/6oE+2+HDzaqAUt82Vf5sCSMsFhQFPzGWzeinyMmF
	6zr+X/UHc87bYmmQPdUTwYTBvadycimtpFUpUJap9mG3Xj0M1H3d6TPFGL0vqq/X2RI1ZcUDLp3
	kCFe8pdVy4Q==
X-Google-Smtp-Source: AGHT+IFeQNtHdf/BDKkK0ej1Gf4xDLw3HPfy6OP8NJrXzc8GwElPfEW7J1JtC6DzO6L9b9HsITXWPTPFqfhGxA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:4513:b0:6e2:371f:4aef with SMTP
 id 00721157ae682-6e5bfce75cemr1837267b3.3.1729604900070; Tue, 22 Oct 2024
 06:48:20 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:48:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022134819.1085254-1-edumazet@google.com>
Subject: [PATCH net-next] vsock: do not leave dangling sk pointer in vsock_create()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Ignat Korchagin <ignat@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

syzbot was able to trigger the following warning after recent
core network cleanup.

On error vsock_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object.

We must clear sock->sk to avoid possible use-after-free later.

WARNING: CPU: 0 PID: 5282 at net/socket.c:1581 __sock_create+0x897/0x950 net/socket.c:1581
Modules linked in:
CPU: 0 UID: 0 PID: 5282 Comm: syz.2.43 Not tainted 6.12.0-rc2-syzkaller-00667-g53bac8330865 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:__sock_create+0x897/0x950 net/socket.c:1581
Code: 7f 06 01 65 48 8b 34 25 00 d8 03 00 48 81 c6 b0 08 00 00 48 c7 c7 60 0b 0d 8d e8 d4 9a 3c 02 e9 11 f8 ff ff e8 0a ab 0d f8 90 <0f> 0b 90 e9 82 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c c7 f8 ff
RSP: 0018:ffffc9000394fda8 EFLAGS: 00010293
RAX: ffffffff89873c46 RBX: ffff888079f3c818 RCX: ffff8880314b9e00
RDX: 0000000000000000 RSI: 00000000ffffffed RDI: 0000000000000000
RBP: ffffffff8d3337f0 R08: ffffffff8987384e R09: ffffffff8989473a
R10: dffffc0000000000 R11: fffffbfff203a276 R12: 00000000ffffffed
R13: ffff888079f3c8c0 R14: ffffffff898736e7 R15: dffffc0000000000
FS:  00005555680ab500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22b11196d0 CR3: 00000000308c0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  sock_create net/socket.c:1632 [inline]
  __sys_socket_create net/socket.c:1669 [inline]
  __sys_socket+0x150/0x3c0 net/socket.c:1716
  __do_sys_socket net/socket.c:1730 [inline]
  __se_sys_socket net/socket.c:1728 [inline]
  __x64_sys_socket+0x7a/0x90 net/socket.c:1728
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22b117dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff56aec0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 00007f22b1335f80 RCX: 00007f22b117dff9
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000028
RBP: 00007f22b11f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f22b1335f80 R14: 00007f22b1335f80 R15: 00000000000012dd

Fixes: 48156296a08c ("net: warn, if pf->create does not clear sock->sk on error")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 35681adedd9aaec3565495158f5342b8aa76c9bc..109b7a0bd0714c9a2d5c9dd58421e7e9344a8474 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2417,6 +2417,7 @@ static int vsock_create(struct net *net, struct socket *sock,
 	if (sock->type == SOCK_DGRAM) {
 		ret = vsock_assign_transport(vsk, NULL);
 		if (ret < 0) {
+			sock->sk = NULL;
 			sock_put(sk);
 			return ret;
 		}
-- 
2.47.0.105.g07ac214952-goog


