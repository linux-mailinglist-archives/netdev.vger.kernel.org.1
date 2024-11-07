Return-Path: <netdev+bounces-143020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92E9C0ECC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8831C25F12
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264BD212F06;
	Thu,  7 Nov 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeEDIYcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60815125D6
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007225; cv=none; b=QvFfD42RXxaGJQ3YMiJZUrB3hd1fOSFEYafj5vYLWJ2k+zlKg2kHkMRWIz9ExrDHJRG0gj/Tj585n0wnNVRtTDK5b9LwU+MEPh6i1Lp4ejSDq/4SnWVd3kg5GiXesOMTQAOXTCizVIz5DfjPEqR/2jTVgdW0qBSugFSVstFihv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007225; c=relaxed/simple;
	bh=JBhz9+1uyurCdClWp+VUqnIwmDBE2nI+l6K/7/ZYbCY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fslaTqXwuO7if7jyXhpJpOakVnoHciCYsb0IDnvriVuwqpagRNNVudynh402jBbgeTLgG2Yct31m3eKUf9uiMcuAShFxfjfKq7QKb/8aMlYOyt8ZU0I1lQ7adir9lYoAXal3Zd6LE5utKfr8k2ZLBwkxhY67MGcWXk7Ayu5QytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeEDIYcC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9d6636498so26459227b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731007222; x=1731612022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1J3twfkorfwpUBmVtrda8j5+TCmvF02e9OCKZWLR8Y=;
        b=LeEDIYcC50akneXl251Z8eSrAtl8M4JtIUEUqNLa/5jKOLzya2cRxbikK9hhKddL7V
         2HCYrRoWejtvHJNFg0PM1n2T/Nmhvnia6O+fdFxYYRHI6xsySw5yMe1+3Mf/LQYosBv7
         w6j2NmPFVYuP5+zq3wnlzLbBp2jl6GKrmKz1Iyf4ACfjEEq1TVYPyYhBxM5tlt8F69Lf
         s0L4SWkRrQzNe0WoPB9Vogv+s4RgnzD0jB8O88rtpKNvuuHm3wR7gDutZIAZK5XbZorX
         4ouCCnlPnQujPJWx1CeyA+gYs7fNKdtpWhHrF8Y6Bhx4Q9lZwTrUumMYIoyhQtxil+Ad
         WODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007222; x=1731612022;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1J3twfkorfwpUBmVtrda8j5+TCmvF02e9OCKZWLR8Y=;
        b=vCwCHNgSYRCbpz171bRlErTjFQtD4FTz7XN2WwNjecnjAcIL9o0QuHXC0YtK6WEAvx
         iSFECbI4/k94zD/Muwj7+MyvjjVn/Lkt1Do5eSIUizu5JSZtwEvhS8+YfD/nTMEh4Qwm
         1DqAIray9Dy6v6aWGutcZo7Vtld4CA9cJMVCjPUkHGktbinaqT5AG7NXegSjcw5HhgeB
         eix4IoJ3QptfMxqmRo6JErxbEu1GcKWCV7D/nqpxoqKPCgvl5RlJ9152CHK7PU7fTi3W
         gsnJhVHflWaSb9JI810ll53JYUchp2QPPJj121pJpgvw2OYiyNGJxSRSCU8pu9ZwPU9w
         XscA==
X-Gm-Message-State: AOJu0YxPIhfV6dhXVJDrD7Gcxp4eMk/W1aVhnGQgM9gXDG4MMmnbDJ+2
	kMgn3hBqShGUenEaNzPA5V3JPqDuvFaGEbYEcvWyHp6qjNv+mVZDGq1RAyukJIyOx4skR43xVKW
	mCGyf722o1Q==
X-Google-Smtp-Source: AGHT+IE4FeSKIAPhscv3iZyXQnxMcv9sVC0X5oel6JHkpLqsHe4uA69i0Lz3NZTk7zKjlYhT/8riAa5L3N9Vvw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:a208:0:b0:e30:c235:d79f with SMTP id
 3f1490d57ef6-e337f8d5415mr81276.8.1731007222321; Thu, 07 Nov 2024 11:20:22
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:20:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107192021.2579789-1-edumazet@google.com>
Subject: [PATCH net-next] sctp: fix possible UAF in sctp_v6_available()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A lockdep report [1] with CONFIG_PROVE_RCU_LIST=3Dy hints
that sctp_v6_available() is calling dev_get_by_index_rcu()
and ipv6_chk_addr() without holding rcu.

[1]
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 WARNING: suspicious RCU usage
 6.12.0-rc5-virtme #1216 Tainted: G        W
 -----------------------------
 net/core/dev.c:876 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active =3D 2, debug_locks =3D 1
 1 lock held by sctp_hello/31495:
 #0: ffff9f1ebbdb7418 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_bind (./arch=
/x86/include/asm/jump_label.h:27 net/sctp/socket.c:315) sctp

stack backtrace:
 CPU: 7 UID: 0 PID: 31495 Comm: sctp_hello Tainted: G        W          6.1=
2.0-rc5-virtme #1216
 Tainted: [W]=3DWARN
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
 Call Trace:
  <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
 dev_get_by_index_rcu (net/core/dev.c:876 (discriminator 7))
 sctp_v6_available (net/sctp/ipv6.c:701) sctp
 sctp_do_bind (net/sctp/socket.c:400 (discriminator 1)) sctp
 sctp_bind (net/sctp/socket.c:320) sctp
 inet6_bind_sk (net/ipv6/af_inet6.c:465)
 ? security_socket_bind (security/security.c:4581 (discriminator 1))
 __sys_bind (net/socket.c:1848 net/socket.c:1869)
 ? do_user_addr_fault (./include/linux/rcupdate.h:347 ./include/linux/rcupd=
ate.h:880 ./include/linux/mm.h:729 arch/x86/mm/fault.c:1340)
 ? do_user_addr_fault (./arch/x86/include/asm/preempt.h:84 (discriminator 1=
3) ./include/linux/rcupdate.h:98 (discriminator 13) ./include/linux/rcupdat=
e.h:882 (discriminator 13) ./include/linux/mm.h:729 (discriminator 13) arch=
/x86/mm/fault.c:1340 (discriminator 13))
 __x64_sys_bind (net/socket.c:1877 (discriminator 1) net/socket.c:1875 (dis=
criminator 1) net/socket.c:1875 (discriminator 1))
 do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry=
/common.c:83 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 RIP: 0033:0x7f59b934a1e7
 Code: 44 00 00 48 8b 15 39 8c 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bd 66=
 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 31 00 00 00 0f 05 <48> 3d 01 f0 ff =
ff 73 01 c3 48 8b 0d 09 8c 0c 00 f7 d8 64 89 01 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	44 00 00             	add    %r8b,(%rax)
   3:	48 8b 15 39 8c 0c 00 	mov    0xc8c39(%rip),%rdx        # 0xc8c43
   a:	f7 d8                	neg    %eax
   c:	64 89 02             	mov    %eax,%fs:(%rdx)
   f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  14:	eb bd                	jmp    0xffffffffffffffd3
  16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1d:	00 00 00
  20:	0f 1f 00             	nopl   (%rax)
  23:	b8 31 00 00 00       	mov    $0x31,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping =
instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 09 8c 0c 00 	mov    0xc8c09(%rip),%rcx        # 0xc8c43
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 09 8c 0c 00 	mov    0xc8c09(%rip),%rcx        # 0xc8c19
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
 RSP: 002b:00007ffe2d0ad398 EFLAGS: 00000202 ORIG_RAX: 0000000000000031
 RAX: ffffffffffffffda RBX: 00007ffe2d0ad3d0 RCX: 00007f59b934a1e7
 RDX: 000000000000001c RSI: 00007ffe2d0ad3d0 RDI: 0000000000000005
 RBP: 0000000000000005 R08: 1999999999999999 R09: 0000000000000000
 R10: 00007f59b9253298 R11: 0000000000000202 R12: 00007ffe2d0ada61
 R13: 0000000000000000 R14: 0000562926516dd8 R15: 00007f59b9479000
  </TASK>

Fixes: 6fe1e52490a9 ("sctp: check ipv6 addr with sk_bound_dev if set")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 net/sctp/ipv6.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index f7b809c0d142c0e6c8e29c2badc4428648117f31..38e2fbdcbeac4bf3185d98f8aca=
e4aea531ca140 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -683,7 +683,7 @@ static int sctp_v6_available(union sctp_addr *addr, str=
uct sctp_sock *sp)
 	struct sock *sk =3D &sp->inet.sk;
 	struct net *net =3D sock_net(sk);
 	struct net_device *dev =3D NULL;
-	int type;
+	int type, res, bound_dev_if;
=20
 	type =3D ipv6_addr_type(in6);
 	if (IPV6_ADDR_ANY =3D=3D type)
@@ -697,14 +697,21 @@ static int sctp_v6_available(union sctp_addr *addr, s=
truct sctp_sock *sp)
 	if (!(type & IPV6_ADDR_UNICAST))
 		return 0;
=20
-	if (sk->sk_bound_dev_if) {
-		dev =3D dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
+	rcu_read_lock();
+	bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);
+	if (bound_dev_if) {
+		res =3D 0;
+		dev =3D dev_get_by_index_rcu(net, bound_dev_if);
 		if (!dev)
-			return 0;
+			goto out;
 	}
=20
-	return ipv6_can_nonlocal_bind(net, &sp->inet) ||
-	       ipv6_chk_addr(net, in6, dev, 0);
+	res =3D ipv6_can_nonlocal_bind(net, &sp->inet) ||
+	      ipv6_chk_addr(net, in6, dev, 0);
+
+out:
+	rcu_read_unlock();
+	return res;
 }
=20
 /* This function checks if the address is a valid address to be used for
--=20
2.47.0.277.g8800431eea-goog


