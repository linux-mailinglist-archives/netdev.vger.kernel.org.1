Return-Path: <netdev+bounces-247301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD86CF69E2
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 04:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D08F13008195
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7526257844;
	Tue,  6 Jan 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="pIFUZRr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6A24E4A8
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670872; cv=none; b=OZFnr67rsnwI9gtpZ/CZV71XFvzRyRED9ZjF7Hc1kZnVOoPIMEHKvCAT7HEKXm3m3u89zR9KirG6W7MYZaRRM/hqOClsN8qlJJpFUF5qF1Gv18wfmBHJeJ5dFGAXfjiZBNcJHXTlZULt9r/8hrp16vPdogbvqOWA1pnXe8AnFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670872; c=relaxed/simple;
	bh=MbbX+Vliy+/3bunrnzk80unbOUh9lSwdwkpVMYhzBWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSrRQQhbbFAypGZFsrZM5k0Sk3ekn4rMEiU13Vbq34uL0GaaklYbWxXHPdL61iRsBmnemeYV/oFZ6V+pyLqRCQzfEsWVsStHuw2xTFOyns1TKD80PrXNtOAOYIJqc4+FsUSma82hZ00E8kH2j05zy0zcMaNWo7/pFwFvkhNfCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=pIFUZRr2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso429908a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 19:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1767670868; x=1768275668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKEnDdshTAqczyqtCjqtiDXZiPDIugGZ8wNG8THA6JQ=;
        b=pIFUZRr2a+qbNOJ3ogednhz6L/bDiZpHo75JaBTMIJSv0gdipGZbbeQLa6LZnaErbB
         OheeHcg2Cf22wrnG7bS7l6xe0PAdyFPI/jze6Yh/2sHVYSvkpe9ziw4diHol1XjuD9IU
         V76w2LS9XPJq9JXKfQkZDtVMiggYkyj29TilHvyyy/BvSEncma57ihv3jLJurwrwqvzU
         ejN3xg/heIY4P+jcfsNObxZuS1IsUHQGA2+awAltp5+X0f0Dkt0jbxf1NbX84hM7FEVt
         HUNsMXighcQ64rZUKu0yYJvNqiVBuvC/MSLX+sbK4Uc+CRpoicYs0AJLAquER3EOHIXs
         Qj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767670868; x=1768275668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKEnDdshTAqczyqtCjqtiDXZiPDIugGZ8wNG8THA6JQ=;
        b=p8urja2vpnJUiVvanwp8xYiVL6suGsPhXfrXDViOP4jeUs4zVrhx8KwP8nQSOEjA1r
         CPDCWTCjCG2xzknodY+6ZIkIfnqFtZxzDjQ3rOZl52AV51PCkRVw0TQ71dYKZvIKtsnt
         rIz+1pn6ri0RD4RfZ9bJe/hxBbsjUCbFlGAinmnEUXLu4V8rprWR5EFh1dwq+XUvnhKZ
         L7bm1PGsSwrq9QSrTycUoiUozThJDHGvzKHNwSQ8ytQbMpOG6gnwTffMwgzDXM+B9YfH
         eD6LKyXviJXGfhcgNoxHlNV8YaNjl5+i2sbSzs1EGr6/mNYbwUEXSn6nyLM2VrMbyKr3
         McMQ==
X-Gm-Message-State: AOJu0YwYHZu60AJ+tVyO01j7dpyIZlKxEj5E/XBjhEIku2U4aFVvP5kj
	9Isaoq8ncPXDFyE4TPdpmaNi9kDMA1K4MgYSIv6OWo/HPFoXd7d8k3k9zfbymoprrg==
X-Gm-Gg: AY/fxX51H8xizhqNHj9WqOkAhAAq7uhybxyUoLd2TEJaOVa1RJZX+7Z4/gM0S6moz8q
	T3LvVfvur3XJboMHiR+lLtBMkDonqBHexbtvF3rHvzb1hgshC7OipNXuLBlDnHRBIFBUE3rxTBc
	vHD0JAJn09aGZemU9v5RFYUOyM1bfxEKc4KrNSEkYYsSWHImWJ4YuRJXUJ6RQ8FdlgooWhiT3Bl
	ZVjeySom03s4VKYqbGkuYxnv4ivYswffDEgHJp17OS/qebsPlJ4yF6rgFA6oTDAHiPHEi8MrqRL
	k2jbqf6nS4j3lDoRninKv5q5Os1AMF4wenw/WmNb4aNb+TAUTzHk1Rb9mruFH4O6rwsZI+nyFUr
	z/Zmg8vC5GIsm3LNTs1jpAmMmAgM/tViOh8NQFt4ua0tx01LOjcEgopH5bxA/2Mf95GNTJdXlWB
	rwhsv4q39h4WxYtJaVCNLlv1omqIaszag6EZTLyU9k7D+/X6Y//IQ=
X-Google-Smtp-Source: AGHT+IFKUkmlFg1sk6+q27Piuxl0swHGlhMJhyxlLMOFiJHzG2HVBRoHGwnGMYeSYKZwp41hD8EDYQ==
X-Received: by 2002:a05:7301:7007:b0:2ab:ca55:b762 with SMTP id 5a478bee46e88-2b16f9696e9mr961401eec.41.1767670867950;
        Mon, 05 Jan 2026 19:41:07 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d77f1sm1444310eec.32.2026.01.05.19.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:41:07 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3] net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset
Date: Mon,  5 Jan 2026 20:41:00 -0700
Message-ID: <20260106034100.1780779-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`qfq_class->leaf_qdisc->q.qlen > 0` does not imply that the class
itself is active.

Two qfq_class objects may point to the same leaf_qdisc. This happens
when:

1. one QFQ qdisc is attached to the dev as the root qdisc, and

2. another QFQ qdisc is temporarily referenced (e.g., via qdisc_get()
/ qdisc_put()) and is pending to be destroyed, as in function
tc_new_tfilter.

When packets are enqueued through the root QFQ qdisc, the shared
leaf_qdisc->q.qlen increases. At the same time, the second QFQ
qdisc triggers qdisc_put and qdisc_destroy: the qdisc enters
qfq_reset() with its own q->q.qlen == 0, but its class's leaf
qdisc->q.qlen > 0. Therefore, the qfq_reset would wrongly deactivate
an inactive aggregate and trigger a null-deref in qfq_deactivate_agg:

[    0.903172] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    0.903571] #PF: supervisor write access in kernel mode
[    0.903860] #PF: error_code(0x0002) - not-present page
[    0.904177] PGD 10299b067 P4D 10299b067 PUD 10299c067 PMD 0
[    0.904502] Oops: Oops: 0002 [#1] SMP NOPTI
[    0.904737] CPU: 0 UID: 0 PID: 135 Comm: exploit Not tainted 6.19.0-rc3+ #2 NONE
[    0.905157] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    0.905754] RIP: 0010:qfq_deactivate_agg (include/linux/list.h:992 (discriminator 2) include/linux/list.h:1006 (discriminator 2) net/sched/sch_qfq.c:1367 (discriminator 2) net/sched/sch_qfq.c:1393 (discriminator 2))
[    0.906046] Code: 0f 84 4d 01 00 00 48 89 70 18 8b 4b 10 48 c7 c2 ff ff ff ff 48 8b 78 08 48 d3 e2 48 21 f2 48 2b 13 48 8b 30 48 d3 ea 8b 4b 18 0

Code starting with the faulting instruction
===========================================
   0:	0f 84 4d 01 00 00    	je     0x153
   6:	48 89 70 18          	mov    %rsi,0x18(%rax)
   a:	8b 4b 10             	mov    0x10(%rbx),%ecx
   d:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  14:	48 8b 78 08          	mov    0x8(%rax),%rdi
  18:	48 d3 e2             	shl    %cl,%rdx
  1b:	48 21 f2             	and    %rsi,%rdx
  1e:	48 2b 13             	sub    (%rbx),%rdx
  21:	48 8b 30             	mov    (%rax),%rsi
  24:	48 d3 ea             	shr    %cl,%rdx
  27:	8b 4b 18             	mov    0x18(%rbx),%ecx
	...
[    0.907095] RSP: 0018:ffffc900004a39a0 EFLAGS: 00010246
[    0.907368] RAX: ffff8881043a0880 RBX: ffff888102953340 RCX: 0000000000000000
[    0.907723] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.908100] RBP: ffff888102952180 R08: 0000000000000000 R09: 0000000000000000
[    0.908451] R10: ffff8881043a0000 R11: 0000000000000000 R12: ffff888102952000
[    0.908804] R13: ffff888102952180 R14: ffff8881043a0ad8 R15: ffff8881043a0880
[    0.909179] FS:  000000002a1a0380(0000) GS:ffff888196d8d000(0000) knlGS:0000000000000000
[    0.909572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.909857] CR2: 0000000000000000 CR3: 0000000102993002 CR4: 0000000000772ef0
[    0.910247] PKRU: 55555554
[    0.910391] Call Trace:
[    0.910527]  <TASK>
[    0.910638]  qfq_reset_qdisc (net/sched/sch_qfq.c:357 net/sched/sch_qfq.c:1485)
[    0.910826]  qdisc_reset (include/linux/skbuff.h:2195 include/linux/skbuff.h:2501 include/linux/skbuff.h:3424 include/linux/skbuff.h:3430 net/sched/sch_generic.c:1036)
[    0.911040]  __qdisc_destroy (net/sched/sch_generic.c:1076)
[    0.911236]  tc_new_tfilter (net/sched/cls_api.c:2447)
[    0.911447]  rtnetlink_rcv_msg (net/core/rtnetlink.c:6958)
[    0.911663]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:6861)
[    0.911894]  netlink_rcv_skb (net/netlink/af_netlink.c:2550)
[    0.912100]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
[    0.912296]  ? __alloc_skb (net/core/skbuff.c:706)
[    0.912484]  netlink_sendmsg (net/netlink/af_netlink.c:1894)
[    0.912682]  sock_write_iter (net/socket.c:727 (discriminator 1) net/socket.c:742 (discriminator 1) net/socket.c:1195 (discriminator 1))
[    0.912880]  vfs_write (fs/read_write.c:593 fs/read_write.c:686)
[    0.913077]  ksys_write (fs/read_write.c:738)
[    0.913252]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[    0.913438]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:131)
[    0.913687] RIP: 0033:0x424c34
[    0.913844] Code: 89 02 48 c7 c0 ff ff ff ff eb bd 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 2d 44 09 00 00 74 13 b8 01 00 00 00 0f 05 9

Code starting with the faulting instruction
===========================================
   0:	89 02                	mov    %eax,(%rdx)
   2:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   9:	eb bd                	jmp    0xffffffffffffffc8
   b:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  12:	00 00 00
  15:	90                   	nop
  16:	f3 0f 1e fa          	endbr64
  1a:	80 3d 2d 44 09 00 00 	cmpb   $0x0,0x9442d(%rip)        # 0x9444e
  21:	74 13                	je     0x36
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:	09                   	.byte 0x9
[    0.914807] RSP: 002b:00007ffea1938b78 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[    0.915197] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000424c34
[    0.915556] RDX: 000000000000003c RSI: 000000002af378c0 RDI: 0000000000000003
[    0.915912] RBP: 00007ffea1938bc0 R08: 00000000004b8820 R09: 0000000000000000
[    0.916297] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffea1938d28
[    0.916652] R13: 00007ffea1938d38 R14: 00000000004b3828 R15: 0000000000000001
[    0.917039]  </TASK>
[    0.917158] Modules linked in:
[    0.917316] CR2: 0000000000000000
[    0.917484] ---[ end trace 0000000000000000 ]---
[    0.917717] RIP: 0010:qfq_deactivate_agg (include/linux/list.h:992 (discriminator 2) include/linux/list.h:1006 (discriminator 2) net/sched/sch_qfq.c:1367 (discriminator 2) net/sched/sch_qfq.c:1393 (discriminator 2))
[    0.917978] Code: 0f 84 4d 01 00 00 48 89 70 18 8b 4b 10 48 c7 c2 ff ff ff ff 48 8b 78 08 48 d3 e2 48 21 f2 48 2b 13 48 8b 30 48 d3 ea 8b 4b 18 0

Code starting with the faulting instruction
===========================================
   0:	0f 84 4d 01 00 00    	je     0x153
   6:	48 89 70 18          	mov    %rsi,0x18(%rax)
   a:	8b 4b 10             	mov    0x10(%rbx),%ecx
   d:	48 c7 c2 ff ff ff ff 	mov    $0xffffffffffffffff,%rdx
  14:	48 8b 78 08          	mov    0x8(%rax),%rdi
  18:	48 d3 e2             	shl    %cl,%rdx
  1b:	48 21 f2             	and    %rsi,%rdx
  1e:	48 2b 13             	sub    (%rbx),%rdx
  21:	48 8b 30             	mov    (%rax),%rsi
  24:	48 d3 ea             	shr    %cl,%rdx
  27:	8b 4b 18             	mov    0x18(%rbx),%ecx
	...
[    0.918902] RSP: 0018:ffffc900004a39a0 EFLAGS: 00010246
[    0.919198] RAX: ffff8881043a0880 RBX: ffff888102953340 RCX: 0000000000000000
[    0.919559] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.919908] RBP: ffff888102952180 R08: 0000000000000000 R09: 0000000000000000
[    0.920289] R10: ffff8881043a0000 R11: 0000000000000000 R12: ffff888102952000
[    0.920648] R13: ffff888102952180 R14: ffff8881043a0ad8 R15: ffff8881043a0880
[    0.921014] FS:  000000002a1a0380(0000) GS:ffff888196d8d000(0000) knlGS:0000000000000000
[    0.921424] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.921710] CR2: 0000000000000000 CR3: 0000000102993002 CR4: 0000000000772ef0
[    0.922097] PKRU: 55555554
[    0.922240] Kernel panic - not syncing: Fatal exception
[    0.922590] Kernel Offset: disabled

Fixes: 0545a3037773 ("pkt_sched: QFQ - quick fair queue scheduler")
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: attach the crash information to the commit message
v3: add the line information to the crash log

 net/sched/sch_qfq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index d920f57dc6d7..f4013b547438 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1481,7 +1481,7 @@ static void qfq_reset_qdisc(struct Qdisc *sch)
 
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
-			if (cl->qdisc->q.qlen > 0)
+			if (cl_is_active(cl))
 				qfq_deactivate_class(q, cl);
 
 			qdisc_reset(cl->qdisc);
-- 
2.43.0


