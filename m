Return-Path: <netdev+bounces-198230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7948BADBAD8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA753B8B79
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21728A70A;
	Mon, 16 Jun 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIN+lqHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44328E5F3
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104939; cv=none; b=s5DtRLGEEnzUVhS3B9ccvL9+rSyQ+zzHg38TDPUny4NYZXdlBBZA+ncDnt0FoVKojeux1DSWGiRAKr7WxtRT1Dh9Ttmlzx0JiXdvXAQDtg6/VgfORSCD8JKRVu4379XbExYs7dWflSo844UDKyHpnkOM566e3muairB6uwpxvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104939; c=relaxed/simple;
	bh=FxmowEOxpcFkOJKOy3zoUNlCJ55LHjMJEDi32Q72eqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VN8UMi+UizjwIaxRg87YJnunBtoCtdw0+NmQISOSbibDwlPIYDuZtp8n58WpXoe8iozG6j0uKz9f4EGEaEK44g5slGEANWeIBU/OoQcYoGrLOkpbID1ViG5e6yZF0qSneOkQ72eZlDAXBzbze8kq1lScg+QmxGmmycDvN0YJSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIN+lqHu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c384b2945so3769542a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750104937; x=1750709737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVXcZxCzlon9dVVpKzVpNkMGRMkxdU1c8Z98pvBoY9U=;
        b=aIN+lqHuynuW5sBfy65Z0435NUSSye0CAAiPhOFu0YBK2OOMQLQL65iGnOnwBfX9Gt
         wrBvUjCv1XUHtSeFwiLwtha17pU6Ld5NsRihcbL3h8uMh2j5FLvnKogHULINBLpcLprm
         v6W3Ktol03qSv8XDyVo3kdXWs8D5EP8emLbAyUUKwgPIAgp6DOwfmAQb2e8Oh4y5NQOB
         glshfh9jwQE+d/k74FQ5NIpmjf7tnBDA5kA9MpwDOMvAvToVrB5Ow8Pndpvv2PF2C02o
         +kCwlRC37YdxT+eLXVWtpzgXKy8K2DQwrr+2cq7FWJ5faWRifVQpQrZ9E2QOKvic59by
         5qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750104937; x=1750709737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVXcZxCzlon9dVVpKzVpNkMGRMkxdU1c8Z98pvBoY9U=;
        b=geKSZOHWh61VX4fYEfwC0cqOxPCqprI37/MwlWyx83qurqfj5Xy82bgDne2nVQp5iy
         kr9r/2dENo5q64IzbjTIZmNXCe1f+mUjn0MFC5++tfAQ2o5nNE4Vkval2QbPdXQzJ94O
         qADjBSPSB/K6ifMRgjAgWjO1Ggb1n7VDDFvUH9/tUjUCtcbqZ7b5ATKkKOgLQhJSAkUJ
         fhUKquOXkIpywrX0QyitDrE30bxNc6N0TRSSOC3xUJ+ThLESf4bqAjwsB0YNw5Pq2NsE
         ZMEHcP/qsx1WJGjLSvn814zJVaXAvT0BmCvnuhjBfSijIe95F1DX5TN0tH4fbu9NUE1T
         f5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCViYmFMp3A6n2/zVfzNKgRXT/NWL7jqGr/52UVhwG8FqwaJdW1yVY6YcFsXFCauDpPmYphNdio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJ9UsZHORwFnXbEpEvtz5M6sH33GmpS1qNYEzNOgsyV2/Dtlq
	9c5GjNYSxt0Sbqxy0ZhL9G9sJtwLTPJ6Un7m98A0ISO9v8uIW3/DIps=
X-Gm-Gg: ASbGncsE42aGmb+NM/ekUZ1ExRy4U1pouGdFpgzJ/SAAptWdcCwWUvOjY32vr3YVSFv
	AKK9j+idAia5gUQjcVRjTm5fON31SMyxsZmvXkWgZJWQ6mfyuUvfJwG1IKEV3d6Hu544ugGocoa
	RlrrFrgSVAgjuYJuSap2p/b5Z8rdE+t0t+EgbWrsPtxRdck2MtBKqrwDb1hZitMdzxyeBoPJdXM
	AqDIMinEvzC4epq4kncIHaHgLMdUl9jQnh79rtb7p0p5Ymeu8nCVmXqepyQgKFUSQJNwnPZ7pM1
	dJN6s8034wzTTh9ZiYCliu9TytabCZcacrVku+M=
X-Google-Smtp-Source: AGHT+IEg+e89jnmD2bBUdQXi2cKQ4pL4s5N5gtFfQ8lHFzWrjfma8AE/SYMgbueUzlDPaMwb1JljwQ==
X-Received: by 2002:a05:6a20:6a0b:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-21fbd7ff8c7mr15422013637.39.1750104936890;
        Mon, 16 Jun 2025 13:15:36 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1643ebdsm7388708a12.26.2025.06.16.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:15:36 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	syzbot+8a583bdd1a5cc0b0e068@syzkaller.appspotmail.com
Subject: [PATCH v1 net] mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
Date: Mon, 16 Jun 2025 13:15:12 -0700
Message-ID: <20250616201532.1036568-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

As syzbot reported [0], mpls_route_input_rcu() can be called
from mpls_getroute(), where is under RTNL.

net->mpls.platform_label is only updated under RTNL.

Let's use rcu_dereference_rtnl() in mpls_route_input_rcu() to
silence the splat.

[0]:
WARNING: suspicious RCU usage
6.15.0-rc7-syzkaller-00082-g5cdb2c77c4c3 #0 Not tainted
 ----------------------------
net/mpls/af_mpls.c:84 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.2.4451/17730:
 #0: ffffffff9012a3e8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff9012a3e8 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x371/0xe90 net/core/rtnetlink.c:6961

stack backtrace:
CPU: 1 UID: 0 PID: 17730 Comm: syz.2.4451 Not tainted 6.15.0-rc7-syzkaller-00082-g5cdb2c77c4c3 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 mpls_route_input_rcu+0x1d4/0x200 net/mpls/af_mpls.c:84
 mpls_getroute+0x621/0x1ea0 net/mpls/af_mpls.c:2381
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6964
 netlink_rcv_skb+0x16d/0x440 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmmsg+0x200/0x420 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a2818e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0a28f52038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f0a283b5fa0 RCX: 00007f0a2818e969
RDX: 0000000000000003 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f0a28210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0a283b5fa0 R15: 00007ffce5e9f268
 </TASK>

Fixes: 0189197f4416 ("mpls: Basic routing support")
Reported-by: syzbot+8a583bdd1a5cc0b0e068@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68507981.a70a0220.395abc.01ef.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index d536c97144e9..47d7dfd9ad09 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -81,8 +81,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
 
 	if (index < net->mpls.platform_labels) {
 		struct mpls_route __rcu **platform_label =
-			rcu_dereference(net->mpls.platform_label);
-		rt = rcu_dereference(platform_label[index]);
+			rcu_dereference_rtnl(net->mpls.platform_label);
+		rt = rcu_dereference_rtnl(platform_label[index]);
 	}
 	return rt;
 }
-- 
2.49.0


