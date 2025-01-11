Return-Path: <netdev+bounces-157425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCBAA0A442
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C85188AE6F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEED1AF0C4;
	Sat, 11 Jan 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bGlql4oT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11D1494D9
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606824; cv=none; b=WHVsil7Bq6dFUspXeilFRp+oK4whD9bmFN8WT7WnXEGTrMpa1GE+BmLL7sJyVZv+tui2XhqOKQl96uXmKYfU1s9SI/0ZBUUSGs46apS/Pwopl9YAwxu6XZWuL3SPJiz9ktMWoN7m2A2iAj2fisVT7keyuJTVyE9N6f9+sQRNGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606824; c=relaxed/simple;
	bh=lLGerxZ67fDNm7t1X14bTP77kcKCT8tLlm8nq8FScgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTY4U9FN6ZC8BZHUKj6n5NzsihO5o8+DT7N4UdSeGGaTBzmg5z86a68z2t+sp+jE7K5p6l+/KH0AfUABasn1TembzzO7G+7r1ERG5/Ry4Yphsl+4O64R8Q2UPG2MxE026JYaWOYF53BTJ1E6N35iIcb7KBCl3wy9UHbiF9GU1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bGlql4oT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6ed0de64aso252794185a.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 06:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736606821; x=1737211621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T0d5jLYqZ5RFOYZmwFi9U14Tj3KoHVaPAJKed7n/Y4=;
        b=bGlql4oTap/C4uTkKKe+mRLkl9fGUeVICmhT5rxfZZQGeI0mpLo4ns4uM0XjGH2HJs
         ZY7WcyOxsxC3EB8EeGejDk1CXauJQ2Mzv45qAq1A4P58xkw4bI64ogtZEZ4OtRzACTcb
         VR5FSfsou+Uty/GiHRN5f20RNCADtcxtetdX0hvuZPeVh9xuuajDTRdn24NeX7df9IsT
         GifXD0zPNko2vzx8Pws6fetajuIku2kt0jQdqAr1yfPaotogdHr5S9/YB1krwk9SPmYF
         ISUmPtrsRj51z5hKSQ/RMyQQyk99SpJo8SD7VUg7I8e1TpXVxhSeXUGhR1FDHpfR56Hx
         5/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606821; x=1737211621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T0d5jLYqZ5RFOYZmwFi9U14Tj3KoHVaPAJKed7n/Y4=;
        b=e7u5cTtzJERyC4L3+AYIt0JSfU3NbOBTYIRqB/mhLcIsVoT44fMFoufJjLuRBQE0v+
         KNhVdyqXiqd5FHes7wa8DqEgg7Z6rJGZAMv+MSpzUC99F5vGqCFjZQ+3RA1ypgLnd8R7
         HNVc7u3uoSNGedEu0rorsTxwVLb7l7NbJkopToRLmPIeMp5Y2NBsEUVJp8gDrgXGKFxn
         qWtEzabNIzdsFO1ow/w+xcAToGGcB1bcyuAkGvq6MVYDNMVfk7rXERjUJmOyRV9KaYfV
         QFeSw+S1ajx8PqEhuNg23M+OhJF/OiyfvWqLQcskCcrw67agPJqOA6M6wFLGk0RfcJ3Z
         cz0g==
X-Gm-Message-State: AOJu0YwNOQYt2Wj2aSNOXIpd94cD6DYuE8hZTmQkCMJ4seRWNcJWyiDE
	CFL3FhGmKjloO0IREv9OsFE9MwGms5TlHDi+TUiNae8w0UYCexj3bZAb5yB885hdc2H++yk0mOU
	=
X-Gm-Gg: ASbGncvz8k/iARRyhcQY2zUUpLEY2yVOQWaEBDmhzXwJkvJMHeqjjFVXeJ76g9ockp8
	xmPVlSSZkErLtYi5GGt3jVr3aV4j6z7X1XkPlAihDYhalPRtNrT9edEaaWkK1zPo/8uMIWLlOsi
	5ZFJtL05T2xeZii8pe6SZxv8thKkF4c2UeflzxTnAC/fIRn7HrBQzV2KRHePE21HtoqNkK5ul4X
	tAFF7S0pqP5GlYlBq7mgWm65bLrCp6irnDFaZV8zMhgNmlA/im9l4xYw1o9qyRTNuirc1b3axiI
	eENfiNpMevzRDmjbN6PQwqL6kqfrAhCfuxE=
X-Google-Smtp-Source: AGHT+IFkc6MTxb/LozPfCR5O6wUN+FfYW30GkcLCC1rVgaYo/Xvz9v4jBxZumJ1Rf2jLDDdswsvlag==
X-Received: by 2002:a05:620a:801c:b0:7b6:f278:fa9b with SMTP id af79cd13be357-7bcf3655eddmr455482685a.12.1736606821359;
        Sat, 11 Jan 2025 06:47:01 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-03-76-64-65-230.dsl.bell.ca. [76.64.65.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3237f70sm289872285a.5.2025.01.11.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:47:00 -0800 (PST)
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
Subject: [PATCH net v3 1/1] net: sched: fix ets qdisc OOB Indexing
Date: Sat, 11 Jan 2025 09:46:57 -0500
Message-Id: <20250111144658.74249-1-jhs@mojatatu.com>
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
index f80bc05d4c5a..516038a44163 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
 {
 	struct ets_sched *q = qdisc_priv(sch);
 
+	if (arg == 0 || arg > q->nbands)
+		return NULL;
 	return &q->classes[arg - 1];
 }
 
-- 
2.34.1


