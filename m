Return-Path: <netdev+bounces-89881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B553B8AC0C9
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 20:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10F41C2088D
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE533AC34;
	Sun, 21 Apr 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVLQGrh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04318637
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713725010; cv=none; b=CaNpXF6XMl2RVtcDMzhBh3ymIBTgwYbHapuuVzEmGoT/0FEi6DP5Ap03476d7cWciNCjACH4SrU4e95X8XmeIdoXXQD9n224YAYwUd+XO6JQC97COupUTdmslpi9wJPtApV8JTBIGxoshfsLEibPTlTfZIyiyNCrs/aPRawr2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713725010; c=relaxed/simple;
	bh=4IHl5Z8wu8MJewaPCLOKRQfCBbVuG1zlSKZtcOqJ2aM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l101x3cdn+rvNH4bOHReRvrCDfmdvDei0k9ZUHj3ZnlBafCMde9LfIGCbLnaa7rDT1tj4SoU/ULFS8p9wA0INIuB6MSXs+OrxHlS6fd5a7cnOYXKG/PMMbQw83uNv6txgxj3gJ9BJUk0WPf47x8bzN0Bl/ZShe6qj3HFaq+TpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVLQGrh7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45d36b049so6088245276.0
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713725008; x=1714329808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=htwPN/5KlehyK4g1ALKe2ImU5CeIXGbh9FZ3xfj3VUg=;
        b=hVLQGrh74aEo0Z5ngQ2q+yS9DCbbpcsNsuo5FpDMYyTHFHBY2939UcZ5OxUU7rTyM6
         DS286iB0KYkex1OMb217UQI9ijZqlmfCmUbphQd/TO/6CSZjg8z8sZat97JK0BhZG5gg
         Jpr2dV2RuzW4ut0tGJP0apK9ss+jcbF/5XKbNu+KFfwZCsDhiXJ6xbyZqJrnnOguz3w2
         30+EUCIS43wYzIXUhgWNLB14e5oUqNiMPrhNiacdslri6Cvm6CXC2K5iJEaZAQnHHytz
         ealufDqf1jKWKSSX/okAi/AWdA/2+j6Ol+b8GmSe+z68A14uEzEevl26GONgkI6M2o5x
         CXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713725008; x=1714329808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htwPN/5KlehyK4g1ALKe2ImU5CeIXGbh9FZ3xfj3VUg=;
        b=DH3DSuQ7BXp/L1WdyOtlKsfrCFpYtfas0Eaf0/3SsWXmguH4D8WdyCbV03Yjg2cB4W
         bbx/lr40EHvlQMZnZScAHjRM9bWwPg+d1Drqv+mIqW3UW8t14ZumTF9Uq70sfm9kfVye
         wwyoklEoZO8VOp6l/wvsuLKaV69sHYZFarRpai0pXgE/65HNCFB3spK1jUMoKCJm0zHg
         Lf76c729pp2wLdy3OlONz7KtRIGDDC7ktQd1LarEhExr/kEYPOrwnEEhlYp5jRP9DKC8
         tA1retgJaaNWlW6jvVLAdLfkEbUmicnkUy127DT5mUtNF+YiLqG9UTR+XW/yx44ftnfs
         j+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkBQIcs7EStXOw7izalbgmuaMUECSoAftHZWB0W+8NZam1ZPBFtRF03FoVGKXS78droWdm9ru4CkqfAyv8c7lJc/UY/7wl
X-Gm-Message-State: AOJu0YwP1b4JzQakHeBt+OPWNovgiwSWkHA03JNW1c1zYSvAXeos/BlP
	EZFbKm8wPwVNXjSrknJPyiw/cwhSBiJYnPI2qk5u8coOBRkAPumRtUoTtSZ1KPUI1vCjuWo7Ps2
	oWJFWnsc4gA==
X-Google-Smtp-Source: AGHT+IHfv3xvOMQ0abdf79QVdFxRydlWjRdPyE/2nN2Zdz5Hq1eJdhdJRS7+Qx/MH3O67E1TbsYQnjmR1sHhrQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aae3:0:b0:de4:fa0d:ab3e with SMTP id
 t90-20020a25aae3000000b00de4fa0dab3emr400144ybi.8.1713725008213; Sun, 21 Apr
 2024 11:43:28 -0700 (PDT)
Date: Sun, 21 Apr 2024 18:43:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240421184326.1704930-1-edumazet@google.com>
Subject: [PATCH net] ipv4: check for NULL idev in ip_route_use_hint()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot was able to trigger a NULL deref in fib_validate_source()
in an old tree [1].

It appears the bug exists in latest trees.

All calls to __in_dev_get_rcu() must be checked for a NULL result.

[1]
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 PID: 3257 Comm: syz-executor.3 Not tainted 5.10.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:fib_validate_source+0xbf/0x15a0 net/ipv4/fib_frontend.c:425
Code: 18 f2 f2 f2 f2 42 c7 44 20 23 f3 f3 f3 f3 48 89 44 24 78 42 c6 44 20 27 f3 e8 5d 88 48 fc 4c 89 e8 48 c1 e8 03 48 89 44 24 18 <42> 80 3c 20 00 74 08 4c 89 ef e8 d2 15 98 fc 48 89 5c 24 10 41 bf
RSP: 0018:ffffc900015fee40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800f7a4000 RCX: ffff88800f4f90c0
RDX: 0000000000000000 RSI: 0000000004001eac RDI: ffff8880160c64c0
RBP: ffffc900015ff060 R08: 0000000000000000 R09: ffff88800f7a4000
R10: 0000000000000002 R11: ffff88800f4f90c0 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800f7a4000
FS:  00007f938acfe6c0(0000) GS:ffff888058c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f938acddd58 CR3: 000000001248e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_route_use_hint+0x410/0x9b0 net/ipv4/route.c:2231
  ip_rcv_finish_core+0x2c4/0x1a30 net/ipv4/ip_input.c:327
  ip_list_rcv_finish net/ipv4/ip_input.c:612 [inline]
  ip_sublist_rcv+0x3ed/0xe50 net/ipv4/ip_input.c:638
  ip_list_rcv+0x422/0x470 net/ipv4/ip_input.c:673
  __netif_receive_skb_list_ptype net/core/dev.c:5572 [inline]
  __netif_receive_skb_list_core+0x6b1/0x890 net/core/dev.c:5620
  __netif_receive_skb_list net/core/dev.c:5672 [inline]
  netif_receive_skb_list_internal+0x9f9/0xdc0 net/core/dev.c:5764
  netif_receive_skb_list+0x55/0x3e0 net/core/dev.c:5816
  xdp_recv_frames net/bpf/test_run.c:257 [inline]
  xdp_test_run_batch net/bpf/test_run.c:335 [inline]
  bpf_test_run_xdp_live+0x1818/0x1d00 net/bpf/test_run.c:363
  bpf_prog_test_run_xdp+0x81f/0x1170 net/bpf/test_run.c:1376
  bpf_prog_test_run+0x349/0x3c0 kernel/bpf/syscall.c:3736
  __sys_bpf+0x45c/0x710 kernel/bpf/syscall.c:5115
  __do_sys_bpf kernel/bpf/syscall.c:5201 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5199 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5199

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d36ace160d426f6224f8e692f3b438ae863bb9b9..b814fdab19f710d066d323970be6ce57a3b583c5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2166,6 +2166,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	int err = -EINVAL;
 	u32 tag = 0;
 
+	if (!in_dev)
+		return -EINVAL;
+
 	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
 		goto martian_source;
 
-- 
2.44.0.769.g3c40516874-goog


