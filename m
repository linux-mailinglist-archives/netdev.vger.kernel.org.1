Return-Path: <netdev+bounces-157195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED899A095D3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8E8166632
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A320E006;
	Fri, 10 Jan 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Gh8M9Oqi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611421146E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523362; cv=none; b=DebCq0n7o5m7gOvZ+8WSurtnqiPvjdcO76/W3DJ5FG0Alhvar5YNhpSVctmZrZfUVSZvYaDDNX8vff3+L5PVEgPfhedCH+cvLHYE1bR2kexPqFowJlHTO0WAU88jhNFZaIQ0sMBU1ApgTaR2kGHWXB4TY846+Zjh8b1hxDWa9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523362; c=relaxed/simple;
	bh=/nGLA/xxwyBAhL/5Pl78hYqr/PETIcG38br6sm2r8s4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfYwvUCI48PmpjreoLlhvMlwBQCnkjWu/lIquUdYzUm6O3WYlTkI97Yk5PrKYzbSb/0VsOtlURXEwisoMYHcq0MOlggSF1pVGw8N+5wtLwcvdQtCnrLk/UUNhXPTEf/UuneZ8MqZ3psYbHPWF3XqcURnQLBFhC0MG0fRey2cKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Gh8M9Oqi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d896be3992so13780996d6.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 07:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736523358; x=1737128158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0bX5Z8lyIXtDNposQw2YU4d384p/cMvkAnsqnVsZum0=;
        b=Gh8M9OqiHFeaIXAv1+CoSApw+nWuUhn3z00A1DgT5GM//5wwekF0S5w39dorL3JZVe
         Sh5myypY6iaWoh9airgPbx05JtDNUt1PTj/CdGePKIxmnnBPI9cAxfm0Nd2S+GfjAUry
         opZ5eekmTW6E22v1tPE01u2ghsCLQBo6V/yp4cCJcBQ/yYJ7flkiKVgOejFRNO6iAXva
         HNpYfFQCu9JtlBpxR0xWCx2Kqy8JXDpknoeGS/b9mcqik+bnP6tYL9Uz35WvmFRl1R9e
         6uBNU16NHV2bO+YDYbHgGJJOi3qpptgpEJ17KRjLEJ6ZZXByLH2516mJVtuT4w7Bbzoa
         HepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523358; x=1737128158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bX5Z8lyIXtDNposQw2YU4d384p/cMvkAnsqnVsZum0=;
        b=SvKLOEHI8Z5SuYE4OIvQL/OanAxVwFYHApxEK9MOWen1kAzxPmOsHGAPBjyV6p5nH8
         3JcIahi07k7RDQ/0bttmdKwu1jhE+YQLEiQCUC3agXj95xy4KIv7kJ2ZMzrNOXBW9q9v
         XJbMzbKGUElkBUg4hK42wSIGt6xwgqGykvoUplY2liuFikie5k2+AlpcHgB7770AMp2g
         zhULqGslkiLVFraZmKHC8czkKR1x7oxCQNO7KT/uMelJZE84eWYuVQdsmaeFOdgjjUsu
         /KDw7YeHachCwzFUprKqamRVnTk6RS9J64vXSdLMuL1tXJEdHX2AginUUo+8WSlZaIQx
         0c7w==
X-Gm-Message-State: AOJu0YwHO6pQgfM0wgMJSgWc+ldODi6+6M0WJt9IRjF7NcBWoAv5OVJH
	6Y/hrqn1XPYudbcYO3IB+fLPG8PNaGFX2sUXZr9oPJ6Ekn9In0M0OkbmnB/UcoUKR7NfAtE16TU
	=
X-Gm-Gg: ASbGncvXN5LdyD1iKnSeHN3HPuHgrmgtCjur8PPLz+gAQlUaqSoqM7F8ghY3vlJ4vMf
	IwLMWyCuJjMnpPU6fWe1C9g4pJGqaBC+YN+3jwya5GruTcQHrQuC1d8HUIpENocOhsdEX9/nWc9
	WfTODiGESErl0RjtZo6RKDRbsEE/GwFrEqyQxBnvSSDd9WvIaAep8OSkpc721j5qOm9gJ9uMjkI
	sRHU4YFg7cKSVu+Tv2PcU8LdIU6CHhhsJUmP+2R4dmZbHxy
X-Google-Smtp-Source: AGHT+IHYS9zMH1q3TJHx8iDhJpDqywGh0z2533eILcB5fwfVhigAfQTty/ZVVg2lHdfbznnRYDaPwg==
X-Received: by 2002:a05:6214:5290:b0:6d8:9dad:e167 with SMTP id 6a1803df08f44-6df9b1e400amr116616556d6.15.1736523358429;
        Fri, 10 Jan 2025 07:35:58 -0800 (PST)
Received: from majuu.waya ([76.64.65.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73223sm10133436d6.85.2025.01.10.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:35:57 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	petrm@mellanox.com,
	security@kernel.org
Subject: [PATCH net 1/1] net: sched: fix ets qdisc OOB Indexing
Date: Fri, 10 Jan 2025 10:35:46 -0500
Message-Id: <20250110153546.41344-1-jhs@mojatatu.com>
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
index f80bc05d4c5a..f27b50daae58 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
 {
 	struct ets_sched *q = qdisc_priv(sch);
 
+	if (arg == 0 || arg >= q->nbands)
+		return NULL;
 	return &q->classes[arg - 1];
 }
 
-- 
2.34.1


