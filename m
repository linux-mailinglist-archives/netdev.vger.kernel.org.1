Return-Path: <netdev+bounces-52180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B637FDC2F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939CB2824DD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96563986F;
	Wed, 29 Nov 2023 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlwTvlCu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC82C4
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:06:32 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd2100f467so91257897b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701273992; x=1701878792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wGNa4cwvm+enE0ntthgPs3mllNdS7Zx3XIknrkJ/Dno=;
        b=GlwTvlCusNwojVoDG8Aat1E2W49nC3oHdet+yUGfbkIG+Wlid92jISqOD21Ya4Ea+5
         I0kTCnnUEKHHVMV57diFNpMJH9ABsPgSgPiJdK8aFgwG4yfuB3enqcfueVGnaJ8Nj+Bj
         dk0oKCyhGy7EHNqt3gFrWQm5FMVI2pZKdXAMcokacc69S+wWBBa7onr22z0HqK2qX7Sg
         UktUTCWWLtCHrRsiRBADyV013Fuv/f/uva71ru3v6PxFg15t20Cv1PU7Qbh+no2peLlZ
         UGqxrDzbj8ZvJ4gTrPQSWLLK34UqgMCQhl2A5BejBr5oIKgNC4y5Yh5vrlqGUnHl9mPL
         Tgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273992; x=1701878792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGNa4cwvm+enE0ntthgPs3mllNdS7Zx3XIknrkJ/Dno=;
        b=XvkuTv+h0JtipTRIMnLK0QSyLUNVSE6je5w3Vp0bF99LzCozw1OBb+C/EMxYTeLroK
         I39Dy0eK9A0E7/3jNbn7q6DOigpYCee8JI8AzOqJe5MSV8WCwvGv4+xsvs/8F8d+e4IG
         thByo+QFgLC/BAtKHLBPaBdNdxapgGw2S8xFtMvIK6LUCsfO/NmSSlHK/BfPWzuMXB9V
         rIUtMBSo4xytkR+ippv826qs+dGM/u/g3ItlK7ElpoDWsd3r18p+CzqPvLIaTSRrvs2A
         9tZqmFBMyX7l3C/Rvt/3ifTDMNVf1Bnr/M+ROGxjTmCtc2NDoK6SJAypr7INwsu07v+s
         202A==
X-Gm-Message-State: AOJu0YzRcbT3xlajHAKzMWy6Whw74fc6RYflEkS1p0M9FqPuQXwNjUlz
	jIzOP4VuMwx8YWb1vFxqMh/jFJ2omg0Q2A==
X-Google-Smtp-Source: AGHT+IHXbOg3rQU/mBR/ENii2xiy0I7jSxJ7OfLlh42fyjhKHWFaWF/FqiZaVZKFa4RjamQRRKVVJLptSoJEDw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:903:b0:59b:eb63:4beb with SMTP
 id cb3-20020a05690c090300b0059beb634bebmr621212ywb.7.1701273991909; Wed, 29
 Nov 2023 08:06:31 -0800 (PST)
Date: Wed, 29 Nov 2023 16:06:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129160630.3509216-1-edumazet@google.com>
Subject: [PATCH net] ipv6: fix potential NULL deref in fib6_add()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"

If fib6_find_prefix() returns NULL, we should silently fallback
using fib6_null_entry regardless of RT6_DEBUG value.

syzbot reported:

WARNING: CPU: 0 PID: 5477 at net/ipv6/ip6_fib.c:1516 fib6_add+0x310d/0x3fa0 net/ipv6/ip6_fib.c:1516
Modules linked in:
CPU: 0 PID: 5477 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:fib6_add+0x310d/0x3fa0 net/ipv6/ip6_fib.c:1516
Code: 00 48 8b 54 24 68 e8 42 22 00 00 48 85 c0 74 14 49 89 c6 e8 d5 d3 c2 f7 eb 5d e8 ce d3 c2 f7 e9 ca 00 00 00 e8 c4 d3 c2 f7 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 38 80 3c 01 00
RSP: 0018:ffffc90005067740 EFLAGS: 00010293
RAX: ffffffff89cba5bc RBX: ffffc90005067ab0 RCX: ffff88801a2e9dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90005067980 R08: ffffffff89cbca85 R09: 1ffff110040d4b85
R10: dffffc0000000000 R11: ffffed10040d4b86 R12: 00000000ffffffff
R13: 1ffff110051c3904 R14: ffff8880206a5c00 R15: ffff888028e1c820
FS: 00007f763783c6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f763783bff8 CR3: 000000007f74d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
__ip6_ins_rt net/ipv6/route.c:1303 [inline]
ip6_route_add+0x88/0x120 net/ipv6/route.c:3847
ipv6_route_ioctl+0x525/0x7b0 net/ipv6/route.c:4467
inet6_ioctl+0x21a/0x270 net/ipv6/af_inet6.c:575
sock_do_ioctl+0x152/0x460 net/socket.c:1220
sock_ioctl+0x615/0x8c0 net/socket.c:1339
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:871 [inline]
__se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82

Fixes: 7bbfe00e0252 ("ipv6: fix general protection fault in fib6_add()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weiwan@google.com>
---
 net/ipv6/ip6_fib.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 28b01a068412ab673415bfd9d15b0fd15b3bdb19..7772f42ff2b940da5f53ee1f0ff0dfcdb187cbf0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1511,13 +1511,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			if (!pn_leaf && !(pn->fn_flags & RTN_RTINFO)) {
 				pn_leaf = fib6_find_prefix(info->nl_net, table,
 							   pn);
-#if RT6_DEBUG >= 2
-				if (!pn_leaf) {
-					WARN_ON(!pn_leaf);
+				if (!pn_leaf)
 					pn_leaf =
 					    info->nl_net->ipv6.fib6_null_entry;
-				}
-#endif
 				fib6_info_hold(pn_leaf);
 				rcu_assign_pointer(pn->leaf, pn_leaf);
 			}
-- 
2.43.0.rc1.413.gea7ed67945-goog


