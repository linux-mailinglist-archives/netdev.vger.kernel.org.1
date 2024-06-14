Return-Path: <netdev+bounces-103509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC890861E
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38251C2113C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995218C34C;
	Fri, 14 Jun 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bl9wfCzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EF188CD3
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353208; cv=none; b=ShhPZTNinqqW3bmqRUy86mukpEHTHhMcSRw4+6DX0RMrSzRYfhYvgXkb78sg2MBq2R9dHZ0FF+VZNceXw38ANj1GNSor5dzBCMnEEdf6NwI3h1+13doo3APyuD/xB5TdYHMvRqgj1ZnXaCvWkMgS33GQBcGTK6wvF7g7TT4Ushg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353208; c=relaxed/simple;
	bh=MoxYSvqNl15Vlopt5hFK+na5ka8vI4ViNcuaksEsFfw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qnxJRa2SDO05u8+OgRktiCtzAPhrqu2AsgnGioEveEAfJK4LNBFUmXKXY+zfwE+T4U5KYZAlLfTDIOH8UQflGNV+ZWQfaW/OHNKX9utbu4j8MOMH7OTh2el6lj15jX7h4I+57AScWXREYe0fygNBFtTzgMN8CCIHFzRP6qExJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bl9wfCzi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfb0e59ac7cso3513565276.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718353206; x=1718958006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wg8sLOFrIuyWj42mhJW5375xhZOMHM2F6rmZLddpiOk=;
        b=bl9wfCziAeteoVYYSZt/Yr1e5Hh6qXTUSlHRIDxd/DXaj6B+ODT/vPS1Rn5ZnynY06
         AeAHpSAnxUICpGnZrkUUYB33wcoEuIOcLTmkeID+i7u92xlEujHvfPHPoF5dpP7K5z8f
         WkF3tjEg/BjUq4DdyNKhdCWWOabKv/tC25yD338ej5PGgisDCIHgBD1nPmsqwCENLpJD
         I7SD1WbWK6Cj3f5W4JWk7QFXjuai5uOqVOyTOHMuUEHQAzcnViJBynV7RPSr+rkC3hfK
         CpOo8cVy4bJx6uo17tz0uOEJA2A4J5XTHibwNC86FICWWGOryeTV2zmEGwqW2RsJTxY1
         RlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353206; x=1718958006;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg8sLOFrIuyWj42mhJW5375xhZOMHM2F6rmZLddpiOk=;
        b=eT1qzCtqCjIxoPCTQBaqx+zqLnq7z9tC0PMKB57sxagq+y7zgtlOSYDqlj2SFNNhBV
         JA3/U3xUIIR8annS0O4rxYSbMbei60yX+MfaA8d9ywzBWtFkx5Qe3L2aJUYXi/gKK4qp
         veu7f/i1SM6MUHZ5tjt5mfb2FjZQcsEyXhKL1ygG/BV7XGThKwdeZgF3jPOteJPHQ6Dz
         wRZpDymDF8ZndZ0APmXoK2jt4A2VRz5BV6JGyjUREmRFopOT3GOfqDYc4PilFxgKmxay
         P5ym+3zOre7sCwOt0wDLhezamyfjs9yL6rE/384BBSE5E+AFjVUkDY6mNJiXVNuKz4lw
         ctPg==
X-Forwarded-Encrypted: i=1; AJvYcCXzVUYz+JUW9h8DbLW7H4BvdwDTpoRyUDiSUqL4/o8rXuqhaVmzJyOscJ0yKw4N+HjW8595YO7xFVysyXKJ7qV4v7yqvMGh
X-Gm-Message-State: AOJu0YyvoJn57xO4ERD+F8T+t6qyAwUIlQrZW5CowdhzTWw/ZLoXKHNe
	sva/IJ3zy/spPFP7rBFGFfOKqlB9vMpfa5IXnIjWFZop0xd+47hVvFV3tJ57C5RHr5OHW6VBbCo
	+A8u7kN8Tnw==
X-Google-Smtp-Source: AGHT+IHMJwzgKV8Es0/yMHAVlz4o+RzofNboKtd4TONGnuAE1OEVDovTTJl3ytA/4PA1y+UPDReNNIkvO506JA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:81cb:0:b0:dff:1943:52f9 with SMTP id
 3f1490d57ef6-dff19435760mr194156276.12.1718353205849; Fri, 14 Jun 2024
 01:20:05 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:20:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614082002.26407-1-edumazet@google.com>
Subject: [PATCH net] ipv6: prevent possible NULL deref in fib6_nh_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot reminds us that in6_dev_get() can return NULL.

fib6_nh_init()
    ip6_validate_gw(  &idev  )
        ip6_route_check_nh(  idev  )
            *idev = in6_dev_get(dev); // can be NULL

Oops: general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 PID: 11237 Comm: syz-executor.3 Not tainted 6.10.0-rc2-syzkaller-00249-gbe27b8965297 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
 RIP: 0010:fib6_nh_init+0x640/0x2160 net/ipv6/route.c:3606
Code: 00 00 fc ff df 4c 8b 64 24 58 48 8b 44 24 28 4c 8b 74 24 30 48 89 c1 48 89 44 24 28 48 8d 98 e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 b3 17 00 00 8b 1b 31 ff 89 de e8 b8 8b
RSP: 0018:ffffc900032775a0 EFLAGS: 00010202
RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000000000
RDX: 0000000000000010 RSI: ffffc90003277a54 RDI: ffff88802b3a08d8
RBP: ffffc900032778b0 R08: 00000000000002fc R09: 0000000000000000
R10: 00000000000002fc R11: 0000000000000000 R12: ffff88802b3a08b8
R13: 1ffff9200064eec8 R14: ffffc90003277a00 R15: dffffc0000000000
FS:  00007f940feb06c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000245e8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  ip6_route_info_create+0x99e/0x12b0 net/ipv6/route.c:3809
  ip6_route_add+0x28/0x160 net/ipv6/route.c:3853
  ipv6_route_ioctl+0x588/0x870 net/ipv6/route.c:4483
  inet6_ioctl+0x21a/0x280 net/ipv6/af_inet6.c:579
  sock_do_ioctl+0x158/0x460 net/socket.c:1222
  sock_ioctl+0x629/0x8e0 net/socket.c:1341
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f940f07cea9

Fixes: 428604fb118f ("ipv6: do not set routes if disable_ipv6 has been enabled")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 952c2bf1170942d411392b5bd5994cb057d3a983..28788ffde5854f7f3fa42f76b94ef76b87d2379b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3603,7 +3603,7 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	if (!dev)
 		goto out;
 
-	if (idev->cnf.disable_ipv6) {
+	if (!idev || idev->cnf.disable_ipv6) {
 		NL_SET_ERR_MSG(extack, "IPv6 is disabled on nexthop device");
 		err = -EACCES;
 		goto out;
-- 
2.45.2.627.g7a2c4fd464-goog


