Return-Path: <netdev+bounces-157410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B173AA0A3E9
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D85D188BB16
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FA199234;
	Sat, 11 Jan 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ydLpUMiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C224B22D
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736602001; cv=none; b=JpGgRNDzYylXCqMOTu7Sm2ik4IrCu+pK8Nm6vPK5WTHcX0RM+GMoFb5Iwl/qY3xH+p6Q6fZuMAh5r3jsd0nqmgClnJ6UqA0HwV6B7WUstheuz0Svtm7auD6UYuhE6zBmKqYWs6kP7k59gHElGlHJSI0POSoJ5NjG9A3Cl2FUrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736602001; c=relaxed/simple;
	bh=3QBimeCeVgP5Hvw3HzKQR31+qNZ20FXLePnczHGZyFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pmhZzYj4MRd5jW7tBh1cM/JJEUdD8xhJVnHXTQNhGp/f1rtt36hZNhpcGO+YaHS/70gjb3r7eWMUKUGRzqH2b5cGl1uEybvxgiFLsfYk0RoUFXf0LvXUm7OQUfxE8m2ZDVbYm/6CJ5m7At6ixeimwwMgt/kc5erQQtMFdOkzLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ydLpUMiZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6e9317a2aso334116185a.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 05:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736601999; x=1737206799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgSz7CZS7r+4ENro1yRT0+SgQczgHbwuQtQU7YnO8pc=;
        b=ydLpUMiZtOAIyONbsOtY97rMf+KomKjnt/wUHep+xRl47Pn3LcFxgZ2RSpJQt2Qo1B
         wDJmiCIYMDHl4boSczAnGMhAnuVApcx1oQuCv6wbHMo+m23sd5L4DAbQpPg14cXNbn/v
         Ai/AY9TwPjEGq+gjJEvaY+tHfdY8WI/92lUB/JXe90EdIGeS++/bwbmiAPsyTor9GzJS
         27DBG4DsEexdOHVf7LoQekS2F22aPS510liF+3KebDHmKf12riv5RSTOdy+8QTw2636F
         zVQdDQTPzlUnGjKm7Tl70lBHmr8gDkQ/ZYS6hCXLmisJZJ2mQa8UHtHkgqAAtPLOUhxn
         cKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736601999; x=1737206799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgSz7CZS7r+4ENro1yRT0+SgQczgHbwuQtQU7YnO8pc=;
        b=EOWm6gHccGOEqDXHpQR2XwJYUTIJt3mvJaQ3E/5VY0mqw3fKZCkogXkj8+vtkfFIFq
         mDHE2M2NXxTN3Dv8C3ySoGlz58Ei789xWaK0JdYlDWvxGi1K2XQZDlaXsbwrZEJDnpFn
         TQA8gSVDz6L1j+SKDeLa79g52tqLnXfYGGKcmKJo4Gzj6QVqBxf7xHBUHSQvPXTaJAda
         5PP4Fy2Ph152rT/evuO+tP+2cNHJjgRoM0A5/K825JaCSolNLGLzHIJ2jTlJnivMVlVv
         RpUQFC4FFFuXzNVnEaigWeuzIc4WO+h/7sHSguoX5IYPO+zab2vdH+3mC/NIrPTBWpjR
         Ejbw==
X-Gm-Message-State: AOJu0YyMJbvPEJVBQ52FcCuTDYSLZPZ15pVU4FOeOwVL/Go10ROnRlB/
	LTkzJH7L8HhEI9NueKQAbwZi47YT2LYRtVPLt4wuGgd2Ys2PC8lNgAT9O4Ep3zctzzy0oTWDLTQ
	=
X-Gm-Gg: ASbGncuMJbj6rhMOPEbifu1MJEM/O2p+AB8TP9M4Kx7eieFhnsAG+mjQCcTpEiCSiUU
	LxLkMdlDE1kG8B53oEv2Xyf+2CUenI/o4pmRVDR9IonfKXPuLvdeScOdIxBV0Be/SX7OQ8vzRdx
	HnWTM70JQkaAFfgTkEX8HMICDCa00oCCVciHfMYDsCvAvqYyzaZavPngdrpg7e8MREzBK7TwW1C
	bcTbr7wpZP8WljGnsMvuUAn5vgy9UsqDY6Q6eYU5i99spYR
X-Google-Smtp-Source: AGHT+IHpchNsWtIlu4snlRvIK3Mdz3bGsn3JT1br4YkY704DSFoXmmF6MZ2eKOdXE43FZTfq3SPU9g==
X-Received: by 2002:a05:620a:2548:b0:7b7:67d:b57e with SMTP id af79cd13be357-7bcf365d8bcmr325945085a.15.1736601998673;
        Sat, 11 Jan 2025 05:26:38 -0800 (PST)
Received: from majuu.waya ([76.64.65.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce327bedfsm282412885a.65.2025.01.11.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 05:26:37 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	petrm@mellanox.com,
	security@kernel.org,
	g1042620637@gmail.com
Subject: [PATCH net v2 1/1] net: sched: fix ets qdisc OOB Indexing
Date: Sat, 11 Jan 2025 08:26:26 -0500
Message-Id: <20250111132626.54018-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
0. The overflow may cause local privilege escalation.

 [   18.852298] ------------[ cut here ]------------
 [   18.853271] UBSAN: array-index-out-of-bounds in net/sched/sch_ets.c:93:20
 [   18.853743] index 18446744073709551615 is out of range for type 'ets_class [16]'
 [   18.854254] CPU: 0 UID: 0 PID: 1275 Comm: poc Not tainted 6.12.6-dirty #17
 [   18.854821] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
 [   18.856532] Call Trace:
 [   18.857441]  <TASK>
 [   18.858227]  dump_stack_lvl+0xc2/0xf0
 [   18.859607]  dump_stack+0x10/0x20
 [   18.860908]  __ubsan_handle_out_of_bounds+0xa7/0xf0
 [   18.864022]  ets_class_change+0x3d6/0x3f0
 [   18.864322]  tc_ctl_tclass+0x251/0x910
 [   18.864587]  ? lock_acquire+0x5e/0x140
 [   18.865113]  ? __mutex_lock+0x9c/0xe70
 [   18.866009]  ? __mutex_lock+0xa34/0xe70
 [   18.866401]  rtnetlink_rcv_msg+0x170/0x6f0
 [   18.866806]  ? __lock_acquire+0x578/0xc10
 [   18.867184]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 [   18.867503]  netlink_rcv_skb+0x59/0x110
 [   18.867776]  rtnetlink_rcv+0x15/0x30
 [   18.868159]  netlink_unicast+0x1c3/0x2b0
 [   18.868440]  netlink_sendmsg+0x239/0x4b0
 [   18.868721]  ____sys_sendmsg+0x3e2/0x410
 [   18.869012]  ___sys_sendmsg+0x88/0xe0
 [   18.869276]  ? rseq_ip_fixup+0x198/0x260
 [   18.869563]  ? rseq_update_cpu_node_id+0x10a/0x190
 [   18.869900]  ? trace_hardirqs_off+0x5a/0xd0
 [   18.870196]  ? syscall_exit_to_user_mode+0xcc/0x220
 [   18.870547]  ? do_syscall_64+0x93/0x150
 [   18.870821]  ? __memcg_slab_free_hook+0x69/0x290
 [   18.871157]  __sys_sendmsg+0x69/0xd0
 [   18.871416]  __x64_sys_sendmsg+0x1d/0x30
 [   18.871699]  x64_sys_call+0x9e2/0x2670
 [   18.871979]  do_syscall_64+0x87/0x150
 [   18.873280]  ? do_syscall_64+0x93/0x150
 [   18.874742]  ? lock_release+0x7b/0x160
 [   18.876157]  ? do_user_addr_fault+0x5ce/0x8f0
 [   18.877833]  ? irqentry_exit_to_user_mode+0xc2/0x210
 [   18.879608]  ? irqentry_exit+0x77/0xb0
 [   18.879808]  ? clear_bhb_loop+0x15/0x70
 [   18.880023]  ? clear_bhb_loop+0x15/0x70
 [   18.880223]  ? clear_bhb_loop+0x15/0x70
 [   18.880426]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 [   18.880683] RIP: 0033:0x44a957
 [   18.880851] Code: ff ff e8 fc 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 8974 24 10
 [   18.881766] RSP: 002b:00007ffcdd00fad8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 [   18.882149] RAX: ffffffffffffffda RBX: 00007ffcdd010db8 RCX: 000000000044a957
 [   18.882507] RDX: 0000000000000000 RSI: 00007ffcdd00fb70 RDI: 0000000000000003
 [   18.885037] RBP: 00007ffcdd010bc0 R08: 000000000703c770 R09: 000000000703c7c0
 [   18.887203] R10: 0000000000000080 R11: 0000000000000246 R12: 0000000000000001
 [   18.888026] R13: 00007ffcdd010da8 R14: 00000000004ca7d0 R15: 0000000000000001
 [   18.888395]  </TASK>
 [   18.888610] ---[ end trace ]---

Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
Reported-by: Haowei Yan <g1042620637@gmail.com>
Suggested-by: Haowei Yan <g1042620637@gmail.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_ets.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index f80bc05d4c5a..c640f915411f 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
 {
 	struct ets_sched *q = qdisc_priv(sch);
 
+	if (arg == 0 || arg >= TCQ_ETS_MAX_BANDS)
+		return NULL;
 	return &q->classes[arg - 1];
 }
 
-- 
2.34.1


