Return-Path: <netdev+bounces-148777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8300D9E31CE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51B0B2A40B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6340855;
	Wed,  4 Dec 2024 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUN06uMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72D27715
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281574; cv=none; b=c+tp6zMEoRo6p2Ad6kTE7R9z+gCnKae2NCOAUSfIZHQH1OIR6vmaEvU5fQAHZG0cjLEdOZ8jYmNxCQS+1wMaELO3OZXt4ZnD4L443IiBh6O2G6+iz07g6ase7W9qG4XfUG5vVJsedfFb9SSHuUmcQMQjweaWhY7LF+HTbIOXJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281574; c=relaxed/simple;
	bh=/72QPAtHXwNfoWFlcUo0kHEx0RjssZ38jlfK3WHPrX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0UQHlM2kdsY1sKWbVzSauACsw1P+UbY9TWYWZv+0iUPP8450sXHhbDsJXmgTJ/C38+p3oaSs9ShaEHCHv6ioMKp44HgxLJ+YDXyX6a2tYVB785fM+guff+RMFgyFo2qfv1HWFooNaUmj7+xvE2AprdBEzzVWH5V5V8aakaoXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUN06uMU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fc2dc586eeso3743222a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733281572; x=1733886372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkwoBzqFZvMrNRpDpMTWoH6+REN7I6jgrSBPrtrZl2w=;
        b=dUN06uMUebiSDCFMQEn/+eC8AaeGJDD719r4oOPW6ryo6ntKVMrTjZhX1A92MuBKLk
         +SPg7d4WXn6iPzK9w/NasIWY2mBQgU3iOvq5UgEsT/5r7wHcOtHHNfZgST9Ein4wa9BI
         7y1c9dpYEOZPW/ZYFvADqHnJ0qsEIFZ3D0MrE+LRF8d8/lRBtKT85vGwQDCXDoge1QI2
         FhDUbNNbHpkH5M5idMy1qp6/BY1AuEu2+tNwEpTmaH1FYKwcU5lyhdzerrvEl0+8dKZe
         rRqzMX8f1vasdn9a/Z+LBg4c6kZV2ZCR0OdLhK9HsTSHAC8vzUweZh9trm0F/NkmND1P
         N79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281572; x=1733886372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkwoBzqFZvMrNRpDpMTWoH6+REN7I6jgrSBPrtrZl2w=;
        b=isu7e+euahhV3r0yItGs7uaFceq4ssfQPGxymZopUv/uyTKIfoOujB052FHbOGFu0t
         +FvOxRiHDP/TZgul6R7GFFtTSuUVAP5jdrcIfSE+G8vJrhgo7QYwEVOYsYgOUgM1s5Vx
         z7zHEs+wOwvFi+WCvBgEsOt89pimILPqDdcQ+2mmYD2VWeqw8szZHexPRG7iIf77E5XC
         4+URaMS3WAgpKlybt9V+2BKLph8reSWOJvtxwoymVOJiV2WugzXmYjJIlcotSIpCtz6x
         nOcoI+qfUue6KpeGhsUlDTDo8nmLRlrbojFMiqfWI6hydnvDjhWSXy8T3tub9BlWcuV4
         bJmg==
X-Forwarded-Encrypted: i=1; AJvYcCVccnpOJY489pP+37ipeu4VfYTqGZHxdnagi+FjbvHJ+2eR2a/DWpQ7TtYaHZ7cQW4xgM1rLl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9q0lKei0wC8OorS+1KAXurcupMctHiFyPh+6avgGGC2SFxXQ
	mQruc+qFIe53zO9Il1AsRHsxODyjLP7blKIrEobdHaU+GXr2UhiiPNprw9iEHoFqLSgLeHgffw=
	=
X-Google-Smtp-Source: AGHT+IF56nRif9zFpVfsWzCIkB+A9w43dJdzxwkoMMZISrrwpnp8OZ53gqPWSjPVYRcGawfwKVDv727tEw==
X-Received: from pfbjc12.prod.google.com ([2002:a05:6a00:6c8c:b0:725:90d5:99df])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d2:b0:1d9:aa1:23e3
 with SMTP id adf61e73a8af0-1e1653f2398mr7478119637.32.1733281571864; Tue, 03
 Dec 2024 19:06:11 -0800 (PST)
Date: Tue,  3 Dec 2024 19:05:19 -0800
In-Reply-To: <20241204030520.2084663-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204030520.2084663-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204030520.2084663-2-tavip@google.com>
Subject: [PATCH net-next 1/2] net_sched: sch_sfq: don't allow 1 packet limit
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

The current implementation does not work correctly with a limit of
1. iproute2 actually checks for this and this patch adds the check in
kernel as well.

This fixes the following syzkaller reported crash:

UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:210:6
index 65535 is out of range for type 'struct sfq_head[128]'
CPU: 0 PID: 2569 Comm: syz-executor101 Not tainted 5.10.0-smp-DEV #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
  __dump_stack lib/dump_stack.c:79 [inline]
  dump_stack+0x125/0x19f lib/dump_stack.c:120
  ubsan_epilogue lib/ubsan.c:148 [inline]
  __ubsan_handle_out_of_bounds+0xed/0x120 lib/ubsan.c:347
  sfq_link net/sched/sch_sfq.c:210 [inline]
  sfq_dec+0x528/0x600 net/sched/sch_sfq.c:238
  sfq_dequeue+0x39b/0x9d0 net/sched/sch_sfq.c:500
  sfq_reset+0x13/0x50 net/sched/sch_sfq.c:525
  qdisc_reset+0xfe/0x510 net/sched/sch_generic.c:1026
  tbf_reset+0x3d/0x100 net/sched/sch_tbf.c:319
  qdisc_reset+0xfe/0x510 net/sched/sch_generic.c:1026
  dev_reset_queue+0x8c/0x140 net/sched/sch_generic.c:1296
  netdev_for_each_tx_queue include/linux/netdevice.h:2350 [inline]
  dev_deactivate_many+0x6dc/0xc20 net/sched/sch_generic.c:1362
  __dev_close_many+0x214/0x350 net/core/dev.c:1468
  dev_close_many+0x207/0x510 net/core/dev.c:1506
  unregister_netdevice_many+0x40f/0x16b0 net/core/dev.c:10738
  unregister_netdevice_queue+0x2be/0x310 net/core/dev.c:10695
  unregister_netdevice include/linux/netdevice.h:2893 [inline]
  __tun_detach+0x6b6/0x1600 drivers/net/tun.c:689
  tun_detach drivers/net/tun.c:705 [inline]
  tun_chr_close+0x104/0x1b0 drivers/net/tun.c:3640
  __fput+0x203/0x840 fs/file_table.c:280
  task_work_run+0x129/0x1b0 kernel/task_work.c:185
  exit_task_work include/linux/task_work.h:33 [inline]
  do_exit+0x5ce/0x2200 kernel/exit.c:931
  do_group_exit+0x144/0x310 kernel/exit.c:1046
  __do_sys_exit_group kernel/exit.c:1057 [inline]
  __se_sys_exit_group kernel/exit.c:1055 [inline]
  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1055
 do_syscall_64+0x6c/0xd0
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7fe5e7b52479
Code: Unable to access opcode bytes at RIP 0x7fe5e7b5244f.
RSP: 002b:00007ffd3c800398 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5e7b52479
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe5e7bcd2d0 R08: ffffffffffffffb8 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe5e7bcd2d0
R13: 0000000000000000 R14: 00007fe5e7bcdd20 R15: 00007fe5e7b24270

The crash can be also be reproduced with the following (with a tc
recompiled to allow for sfq limits of 1):

tc qdisc add dev dummy0 handle 1: root tbf rate 1Kbit burst 100b lat 1s
../iproute2-6.9.0/tc/tc qdisc add dev dummy0 handle 2: parent 1:10 sfq limit 1
ifconfig dummy0 up
ping -I dummy0 -f -c2 -W0.1 8.8.8.8
sleep 1

Scenario that triggers the crash:

* the first packet is sent and queued in TBF and SFQ; qdisc qlen is 1

* TBF dequeues: it peeks from SFQ which moves the packet to the
  gso_skb list and keeps qdisc qlen set to 1. TBF is out of tokens so
  it schedules itself for later.

* the second packet is sent and TBF tries to queues it to SFQ. qdisc
  qlen is now 2 and because the SFQ limit is 1 the packet is dropped
  by SFQ. At this point qlen is 1, and all of the SFQ slots are empty,
  however q->tail is not NULL.

At this point, assuming no more packets are queued, when sch_dequeue
runs again it will decrement the qlen for the current empty slot
causing an underflow and the subsequent out of bounds access.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/sched/sch_sfq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index a4b8296a2fa1..65d5b59da583 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -652,6 +652,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
+	if (ctl->limit == 1) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 	sch_tree_lock(sch);
 	if (ctl->quantum)
 		q->quantum = ctl->quantum;
-- 
2.47.0.338.g60cca15819-goog


