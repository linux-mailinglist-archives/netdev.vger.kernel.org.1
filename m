Return-Path: <netdev+bounces-97686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB28CCB9B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE5B28381E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 05:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF013B5A4;
	Thu, 23 May 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKpFTI58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69A13B58E
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440650; cv=none; b=qBFVyyE0EM9+yIV1J5+UdchRRBLmImoo+sMdaeTiQslQQHRMoPLS4cH1tD+FGiK2NyeJTPtrI55iA0c/2lYuUUuYqQQE1liKYk5H5nflMYHRGFWPYuMeEoaC/2Y4B9Jqjul21kOSPwOro4+8JhutqAjsGrwPJTzmz/gC71+KGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440650; c=relaxed/simple;
	bh=RqMMosxZ4jrQisWXdkBtztzmKPktmShToNFTC4DekvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0qvig4g4+QpdN9tOY2S7wKeRCGioFGc2wB+zcfV9VDK0D0YtiHkj7CXJaTSg410tmQhdLR5MN2GfwUqsMmzCFZrUkv4LneRULcXRSG5eRs6S1VwmqrnS7uhE3m1APFZsXv2dfHGPFH98p7g0dK8B7unHF1uitaQgaxjUDEmztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKpFTI58; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f662252c7eso901680a34.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716440647; x=1717045447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VfpMd7AbvxJ4XwiBLpuMP+4j+H4FuxxoOhqthIMw4AQ=;
        b=nKpFTI58EvaXP9CWan1D5a5nf0IoDSJ3ykVc9yZuaV2NAOF/PMWHb1h1o5VvwoTHWt
         dM0mRGFoBjTu+xJwyKJwt90t64X2qGbeaAYRT3Ui2z48JG/Ago0UPAjfKR7SiqxKcRiA
         HbWi5e46kDIM62zssrCdUlSuRb4yJmyH+2Q/9tQltwi4CZXWuUX/8cTit+XbTItTG7Sy
         NYS9+V1A1CwtiLR6OrawCjp2eGGlG/td6WZ02FUUFOlehHlm62J3LyMOAMQcRDcioSLm
         /gHAtTY2gGLK2baz/zNMFuLhHmDXbi7ZG4248XQVUtAX7FR//mLTvDWywM2cevmXI+gR
         oB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716440647; x=1717045447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfpMd7AbvxJ4XwiBLpuMP+4j+H4FuxxoOhqthIMw4AQ=;
        b=mcZ7vdABm0HObyYIhkLnSLVF3jCzNTxcDztz+TRDFDnUE8hDCpS1llKK07IsHWKJPS
         4Mr+0vCwAbltxt39pbuHleS69ZJf+VKAkTmUZPeVasRI4SB67sXg3c1A59bOQjYaFr2I
         zfCRrhXAIHksUP1QrYMGs4q6zxR9v22w4q1Be3SgmKVTXqq0SWoE9hqPanHRAXib52YY
         2VKCksCHZxNQJNPc0h6OVl2t6q4/bc2uRbQbPE3ip90ZrdMt9x3BlmFNG0qPTmdweXCc
         YK6JF4XPC6imp1d3hIumrX7fztXxqOyXeqSWtHHBvME6sgDlKDnMxl5z6hbduVdoW+OU
         Vr5A==
X-Gm-Message-State: AOJu0Yycp35GTtdYT8Xso8OcI9eYREO5M+JSnsiydPdPpW3vzvb7V3oy
	nCVIHcb47DdLGBUY4pD3S0aidKWSzsN/SycKUnm8jhPqNrjk49Vl65tjyw==
X-Google-Smtp-Source: AGHT+IHobsZyhYPh8F+O5PZpH+A1+7c2w8CdQImCshhUUOd1O89lFHzLWh/WEckLHeu4cNMZuu3kQg==
X-Received: by 2002:a05:6870:3283:b0:24c:517d:f667 with SMTP id 586e51a60fabf-24c68d632f0mr4265452fac.31.1716440647425;
        Wed, 22 May 2024 22:04:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66590sm24289154b3a.1.2024.05.22.22.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:04:06 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Subject: [PATCH v2 net] tcp: fix a race when purging the netns and allocating tw socket
Date: Thu, 23 May 2024 13:03:57 +0800
Message-Id: <20240523050357.43941-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Syzbot[1] reported the drecrement of reference count hits leaking memory.

Race condition:
   CPU 0                      CPU 1
   -----                      -----
inet_twsk_purge            tcp_time_wait
inet_twsk_deschedule_put   __inet_twsk_schedule
                           mod_timer(tw_timer...
del_timer_sync
inet_twsk_kill
refcount_dec(tw_refcount)[1]
                           refcount_inc(tw_refcount)[2]

Race case happens because [1] decrements refcount first before [2].

After we reorder the mod_timer() and refcount_inc() in the initialization
phase, we can use the status of timer as an indicator to test if we want
to destroy the tw socket in inet_twsk_purge() or postpone it to
tw_timer_handler().

After this patch applied, we get four possible cases:
1) if we can see the armed timer during the initialization phase
   CPU 0                      CPU 1
   -----                      -----
inet_twsk_purge            tcp_time_wait
inet_twsk_deschedule_put   __inet_twsk_schedule
                           refcount_inc(tw_refcount)
                           mod_timer(tw_timer...
test if the timer is queued
//timer is queued
del_timer_sync
inet_twsk_kill
refcount_dec(tw_refcount)
Note: we finish it up in the purge process.

2) if we fail to see the armed timer during the initialization phase
   CPU 0                      CPU 1
   -----                      -----
inet_twsk_purge            tcp_time_wait
inet_twsk_deschedule_put   __inet_twsk_schedule
                           refcount_inc(tw_refcount)
test if the timer is queued
//timer isn't queued
postpone
                           mod_timer(tw_timer...
Note: later, in another context, expired timer will finish up tw socket

3) if we're seeing a running timer after the initialization phase
   CPU 0                      CPU 1                    CPU 2
   -----                      -----                    -----
                           tcp_time_wait
                           __inet_twsk_schedule
                           refcount_inc(tw_refcount)
                           mod_timer(tw_timer...
                           ...(around 1 min)...
inet_twsk_purge
inet_twsk_deschedule_put
test if the timer is queued
// timer is running
skip                                              tw_timer_handler
Note: CPU 2 is destroying the timewait socket

4) if we're seeing a pending timer after the initialization phase
   CPU 0                      CPU 1
   -----                      -----
                           tcp_time_wait
                           __inet_twsk_schedule
                           refcount_inc(tw_refcount)
                           mod_timer(tw_timer...
                           ...(< 1 min)...
inet_twsk_purge
inet_twsk_deschedule_put
test if the timer is queued
// timer is queued
del_timer_sync
inet_twsk_kill

Therefore, only making sure that we either call inet_twsk_purge() or
call tw_timer_handler() to destroy the timewait socket, we can
handle all the cases as above.

[1]
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
 inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
 inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
 tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
 tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
 setup_net+0x714/0xb40 net/core/net_namespace.c:375
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x419/0x970 kernel/fork.c:3323
 __do_sys_unshare kernel/fork.c:3394 [inline]
 __se_sys_unshare kernel/fork.c:3392 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56d7c7cee9

Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqsk_timer_handler().")
Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2eca27bdcb48ed330251
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240521144930.23805-1-kerneljasonxing@gmail.com/
1. Use timer as a flag to test if we can safely destroy the timewait socket
based on top of the patch Eric wrote.
2. change the title and add more explanation into body message.
---
 net/ipv4/inet_timewait_sock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e28075f0006e..b890d1c280a1 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 
 		__NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILLED :
 						     LINUX_MIB_TIMEWAITED);
-		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
 		refcount_inc(&tw->tw_dr->tw_refcount);
+		BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
 	} else {
 		mod_timer_pending(&tw->tw_timer, jiffies + timeo);
 	}
@@ -301,7 +301,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 			rcu_read_unlock();
 			local_bh_disable();
 			if (state == TCP_TIME_WAIT) {
-				inet_twsk_deschedule_put(inet_twsk(sk));
+				struct inet_timewait_sock *tw = inet_twsk(sk);
+
+				/* If the timer is armed, we can safely destroy
+				 * it, or else we postpone the process of destruction
+				 * to tw_timer_handler().
+				 */
+				if (timer_pending(&tw->tw_timer))
+					inet_twsk_deschedule_put(tw);
 			} else {
 				struct request_sock *req = inet_reqsk(sk);
 
-- 
2.37.3


