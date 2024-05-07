Return-Path: <netdev+bounces-94183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205C8BE932
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1801E28F1E2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFAD155A47;
	Tue,  7 May 2024 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZP8ndCqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D616EC09
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099509; cv=none; b=kY/WbWGKcYX6rNha3xQarTe7WFLBc3+FKjqJjhljq2YlLe7HrEUKU5tS46dD/Vj9Ty1lVGCFRP9p1uE6AtdmqhubYZZ+CwRknedQcLEStp7XmrOVLicV8A9kgDw2RbiaieFVT/qybrLySMrfw8B1uisy2RyqTsfM4kgnfOFSYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099509; c=relaxed/simple;
	bh=HwZUZXeypnPYBeMj/E3xfG6X8qP8SUS3bIX8MXUll4E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T06yngOjwStSUCMK3HyK/IhBsltYTAVzN23QRw5gkUcT2Hr8Ei8WSAeVm2ixaA/h+ha35WNnrDwDg3YpyVP8frUb5u6BUhCzMlmZImKx/mY4N6fO2MzynM6nDYhcp+v/jHbJwGl6KX/KAMHWwD22gscQIw4EHp2wwlXS5e5ewQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZP8ndCqe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so7529092276.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715099507; x=1715704307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1DQ5cD8PJuVPkL1PRuifxyPqwG+BaGta7xm500qY5jk=;
        b=ZP8ndCqeOOEy5gnNHixWIrT4ywIa4FegEzdOMWo9GRKmhkE+JrVxLPHt3eoGzuWP8d
         IJRmZZLJP7RsDPibo6vN/plddqK6r5DTvfxxjtTf7GMTpUbHxmmnyUn6E6q8c9HO0rVo
         FNdcBi118WFC6lwZ2DiH/Nn/rXKayI+u5mMHTmSfkjWJnUMb3JRFpMUEXJsKPw3KQm09
         3wkGV+NT7Kz8bO46XJu6XfYXiK57MvR0vaGeWxGcIjP1ZFtoaW2IPEB06qALkgtHmSZ7
         y7v26U75I3nhoGxvesrw/voOkxbEOUzcUk+6d1HhBu4n/r2P3p38KuZqIA7FJFWfmrmF
         RmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099507; x=1715704307;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DQ5cD8PJuVPkL1PRuifxyPqwG+BaGta7xm500qY5jk=;
        b=oM06PNB2G6+O9VjJXiooZRUxBxkqbuHJNe2Q92+RgPWajvSkaUMPlRw8w+V6EjEYIL
         ii5xZOy7F59Q5t01DTGYWjp7LusXYtTuCWPMTyGWt97NSxdLUyvkpoE0JFT44gjKF0vM
         7sejt26S/iQgmKjFfmDO+u5v6tldqftKQ08qJn2bEE6y2Ahdnes9aJxOXdkr1UY0FRMv
         J2O/47swjSUdw8C+7eG0r+rtH7UdbULzPiU0Oo8tNBTreb6wUyDKLD66Ivju7a51QZxm
         6aOfwjaaB1H0Yt1eJEc/mZndyKTayR5IqnvPNtCSw4Hil2qwwd2OvBunwRVBlSpRuIEX
         xRtg==
X-Forwarded-Encrypted: i=1; AJvYcCUgUxlBicZfK19ukouARt1Z0Kn3wXPzI5yDhSNhqsrRBxZ5Xf5fG0MPijZB0yKIKb/laIamSgSliJisEts/YXy8wjg6iNRN
X-Gm-Message-State: AOJu0YwFuNw1DrEHyXEQSyprQKxtRLWzenKX/q17Q+mk8Eun3mv0kTC+
	nObAS4T1YPRzzjzsGzFpaoZZEn64qhKYaCy2nJ7PCTuBtibTPuTwwEV+3GVejnizYrPTjUIKo8H
	SJ1plI1/l2w==
X-Google-Smtp-Source: AGHT+IEvL1ZXNMuXs/cApIacqXt0rkGoDAS2bosNLAW6ylk9QljMXjjqy2oNPZrnExCZeg5+afA+BlrtbsaYjQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:702:b0:dbe:d0a9:2be3 with SMTP
 id 3f1490d57ef6-debb95f21ecmr92623276.3.1715099506847; Tue, 07 May 2024
 09:31:46 -0700 (PDT)
Date: Tue,  7 May 2024 16:31:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507163145.835254-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot is able to trigger the following crash [1],
caused by unsafe ip6_dst_idev() use.

Indeed ip6_dst_idev() can return NULL, and must always be checked.

[1]

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 31648 Comm: syz-executor.0 Not tainted 6.9.0-rc4-next-20240417-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:__fib6_rule_action net/ipv6/fib6_rules.c:237 [inline]
 RIP: 0010:fib6_rule_action+0x241/0x7b0 net/ipv6/fib6_rules.c:267
Code: 02 00 00 49 8d 9f d8 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 f9 32 bf f7 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 e0 32 bf f7 4c 8b 03 48 89 ef 4c
RSP: 0018:ffffc9000fc1f2f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1a772f98c8186700
RDX: 0000000000000003 RSI: ffffffff8bcac4e0 RDI: ffffffff8c1f9760
RBP: ffff8880673fb980 R08: ffffffff8fac15ef R09: 1ffffffff1f582bd
R10: dffffc0000000000 R11: fffffbfff1f582be R12: dffffc0000000000
R13: 0000000000000080 R14: ffff888076509000 R15: ffff88807a029a00
FS:  00007f55e82ca6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31d23000 CR3: 0000000022b66000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  fib_rules_lookup+0x62c/0xdb0 net/core/fib_rules.c:317
  fib6_rule_lookup+0x1fd/0x790 net/ipv6/fib6_rules.c:108
  ip6_route_output_flags_noref net/ipv6/route.c:2637 [inline]
  ip6_route_output_flags+0x38e/0x610 net/ipv6/route.c:2649
  ip6_route_output include/net/ip6_route.h:93 [inline]
  ip6_dst_lookup_tail+0x189/0x11a0 net/ipv6/ip6_output.c:1120
  ip6_dst_lookup_flow+0xb9/0x180 net/ipv6/ip6_output.c:1250
  sctp_v6_get_dst+0x792/0x1e20 net/sctp/ipv6.c:326
  sctp_transport_route+0x12c/0x2e0 net/sctp/transport.c:455
  sctp_assoc_add_peer+0x614/0x15c0 net/sctp/associola.c:662
  sctp_connect_new_asoc+0x31d/0x6c0 net/sctp/socket.c:1099
  __sctp_connect+0x66d/0xe30 net/sctp/socket.c:1197
  sctp_connect net/sctp/socket.c:4819 [inline]
  sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
  __sys_connect_file net/socket.c:2048 [inline]
  __sys_connect+0x2df/0x310 net/socket.c:2065
  __do_sys_connect net/socket.c:2075 [inline]
  __se_sys_connect net/socket.c:2072 [inline]
  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 5e5f3f0f8013 ("[IPV6] ADDRCONF: Convert ipv6_get_saddr() to ipv6_dev_get_saddr().")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/fib6_rules.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 52c04f0ac498123becfdc30af5a90f1b2291934d..9e254de7462fb86bb053353dfaa2715a369a7994 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -233,8 +233,12 @@ static int __fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
 	rt = pol_lookup_func(lookup,
 			     net, table, flp6, arg->lookup_data, flags);
 	if (rt != net->ipv6.ip6_null_entry) {
+		struct inet6_dev *idev = ip6_dst_idev(&rt->dst);
+
+		if (!idev)
+			goto again;
 		err = fib6_rule_saddr(net, rule, flags, flp6,
-				      ip6_dst_idev(&rt->dst)->dev);
+				      idev->dev);
 
 		if (err == -EAGAIN)
 			goto again;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


