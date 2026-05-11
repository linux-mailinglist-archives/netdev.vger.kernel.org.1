Return-Path: <netdev+bounces-286790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMChOj4iAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:38:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4E5148A1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA80A3007B05
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520947AF75;
	Mon, 11 May 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="GTMC7q+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B247B410
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524282; cv=none; b=Ltiua4cw7oPzAX9V9UaRgznGRkdcmaqz1EG2RuRDeq2ZluBGn4L1uEKO6rUN7yFuJTE+P+oaf0ka5GhdFG/l7RIlxNjGFuo/SZfPQJdlNWTiPG5s3IMNJjM6gU/CzQoy9yY7YPIuMz2pjECrgmuMWdG+7QAkf/ccm+X37FVFPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524282; c=relaxed/simple;
	bh=awqIGIwt1fJQ8CGDMgnALhIKMg9W5Ci1Sevs7/hemGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aHCD32uvtovJIZtbnP2Nyj2L6xBUizyv2fhrDkN8kkVET7l8DGdfEk8hvP3BlHI7dQDxpjrV4JvyVzxr6w3f4Yia2J6TrY9ILr4+G5sjmp3XCGCDqgZMti401ElYSrgJOjwPyXHfVksqpkNMyaCzIOliTypNUAk+kbrmQZnnUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=GTMC7q+i; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5148cbdea08so26526491cf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778524279; x=1779129079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZEmSLjVFMq9uhmSAp5Y+Osx9YqeYz8SR2Y2yJPXePc=;
        b=GTMC7q+iKUtnjkRuGDCCzISIGR8Fq3rQJ5SsGRRrl7USqMx5jYiixDAVfWmkeonc5H
         JYlRZMZ9RFDNDB6SVQiSbn8ykDHyP+qgdp1bN6Tot/SYrav8ecMSqj06G9ciR6GSWA7g
         xQziu0Hzms7lSMqLUDAyv2FymF3XNODRwq50G3CFn/iibhgG51L7ynOkXOdpNX/6EUGW
         m6FpUrQemwtKTyeYZ9BE5P8X+szcFW3MGpKZDypZOBiogG62Z/ZI3MSVOBiKPK65mXuD
         hGWTN38BHlaSR8NsmNN6+iIfQbnc8IHZtlf3jskNyepVgDJwCJIXtNqCVGt/Lxm4isrF
         5iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524279; x=1779129079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZEmSLjVFMq9uhmSAp5Y+Osx9YqeYz8SR2Y2yJPXePc=;
        b=KcTeSM2Ftqp6eJn1UiUbKjDnx6dVCGwEWIbYZgnlojfvmkd6d8yi5vh5eHdxR4t04y
         PhnsCTDMNCxHxHO6jqZY/DHI92LA7Kitij7e/5OZVrDqhCbOOoVu7fGuYzjnf6I40WyV
         PVH2TdIhrimfyKDupidsz6yAlKDApA1hR6yD9RWojfAAP0inVVn6e/vVJHNOx1SAAYhR
         +nlJ266Ifg+QmLOvDjFS2gppaoydnJvKG8NcxMp6dyqCO9rP6eEZD+pVFbHobWrBII4d
         ILeH7SZQOJhKyREt1UE6XLCUDkkVbF+fqHSOW0ymwA2gpWVwPu5eLgW3WXqfd8/2fYRQ
         VFTA==
X-Gm-Message-State: AOJu0YzWngRX7Y8xKe6WrD1hx4HRv7U4btyeRwfU+6bm7hckOZ1t6cqZ
	+yT1P9DRSBtSram9ztD7S11R4JjpRNzgq9GDh4Yfu1+1prYuN4x0BYsNooN6yYdSTDCaXdhfcs0
	Vq/4=
X-Gm-Gg: Acq92OHvBDyyOzJIdHa5/LCZ+8KnSajsmOVgVKijkwM1tAppfh5d+8HbeQr533OvOk7
	Pg11+sJu4NlZSj8RRGcoutXxsmbHaSNTKjRTWJZr/kRflMOwZqf3JjOW5hprwqAt6t67l2+AW2t
	RBRHeOrXCRyOrl2kUjSczrUcRss93fOd7Efd1uEytAdcFAoobSe0cO2IqGAT8H2DmZ1ZVoqGRuc
	gVpNQsmg9NwNpra3sLg4b5YngmPi5YsZdtuweynEac5fFrihVk2LVFsT48xNuJ6D/X/SYJ84+Do
	ovj6ISm5s8AJU1+LceDFU7WQgvA0paegUI4AfimNoSCtgdPEY1JN9fOE/B0EObPlMgoxaYoug1f
	+u6g5PkVABtZeKH5VO4rVfSxpE7oO0GeheAqPbphzWxjvbeWiD5hT5PvMWFcCJ1eada7l078oon
	UBWb79Y0yLv1EIlsoAbzdC2f1+VhjqFgQffANHsQ==
X-Received: by 2002:a05:622a:1f93:b0:50f:783f:31a8 with SMTP id d75a77b69052e-514a0b245f1mr154518801cf.28.1778524278814;
        Mon, 11 May 2026 11:31:18 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e675b9csm94339741cf.11.2026.05.11.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:31:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: vinicius.gomes@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	graypanda.inzag@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/2] net/sched: sch_cbs: Call qdisc_reset for child qdisc
Date: Mon, 11 May 2026 14:30:57 -0400
Message-Id: <20260511183058.422998-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9D4E5148A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-286790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:email,mojatatu.com:mid,intel.com:email]
X-Rspamd-Action: no action

During a reset, CBS is not calling reset on its child qdisc, which
might cause qlen/backlog accounting issues. For example, if we have CBS
with a QFQ parent and a netem child with delay, we can create a scenario
where the parent's qlen underflows. QFQ, specifically, uses qlen to
check whether it should deference a pointer, so this scenario may cause
a null-ptr deref in QFQ:

[   43.875639][  T319] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN NOPTI
[   43.876124][  T319] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[   43.876417][  T319] CPU: 10 UID: 0 PID: 319 Comm: ping Not tainted 7.0.0-13039-ge728258debd5 #773 PREEMPT(full)
[   43.876751][  T319] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   43.876949][  T319] RIP: 0010:qfq_dequeue+0x35c/0x1650
[   43.877123][  T319] Code: 00 fc ff df 80 3c 02 00 0f 85 17 0e 00 00 4c 8d 73 48 48 89 9d b8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 76 0c 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
[   43.877648][  T319] RSP: 0018:ffff8881017ef4f0 EFLAGS: 00010216
[   43.877845][  T319] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: dffffc0000000000
[   43.878073][  T319] RDX: 0000000000000009 RSI: 0000000c40000000 RDI: ffff88810eef02b0
[   43.878306][  T319] RBP: ffff88810eef0000 R08: ffff88810eef0280 R09: 1ffff1102120fd63
[   43.878523][  T319] R10: 1ffff1102120fd66 R11: 1ffff1102120fd67 R12: 0000000c40000000
[   43.878742][  T319] R13: ffff88810eef02b8 R14: 0000000000000048 R15: 0000000020000000
[   43.878959][  T319] FS:  00007f9c51c47c40(0000) GS:ffff88817a0be000(0000) knlGS:0000000000000000
[   43.879214][  T319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.879403][  T319] CR2: 000055e69a2230a8 CR3: 000000010c07a000 CR4: 0000000000750ef0
[   43.879621][  T319] PKRU: 55555554
[   43.879735][  T319] Call Trace:
[   43.879844][  T319]  <TASK>
[   43.879924][  T319]  __qdisc_run+0x169/0x1900
[   43.880075][  T319]  ? dev_qdisc_enqueue+0x8b/0x210
[   43.880222][  T319]  __dev_queue_xmit+0x2346/0x37a0
[   43.880376][  T319]  ? register_lock_class+0x3f/0x800
[   43.880531][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.880684][  T319]  ? __pfx___dev_queue_xmit+0x10/0x10
[   43.880834][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.880977][  T319]  ? __lock_acquire+0x819/0x1df0
[   43.881124][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.881275][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.881418][  T319]  ? __asan_memcpy+0x3c/0x60
[   43.881563][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.881708][  T319]  ? eth_header+0x165/0x1a0
[   43.881853][  T319]  ? lockdep_hardirqs_on_prepare+0xdb/0x1a0
[   43.882031][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.882174][  T319]  ? neigh_resolve_output+0x3cc/0x7e0
[   43.882325][  T319]  ? srso_alias_return_thunk+0x5/0xfbef5
[   43.882471][  T319]  ip_finish_output2+0x6b6/0x1e10

Fix this by calling qdisc_reset for CBS' child qdisc.
Sashiko caught an issue which could result in a null ptr deref if
qdisc_create_dflt() is invoked on an unitialised cbs qdisc which is exposed
by this patch. We add an early return if the qdisc is null to address this.
This is a similar approach used by two other fixes[1][2].

The proper fix for this specific issue elucidated by sashiko is to remove
the call to qdisc_reset when qdisc_create_dflt fails. Since the dflt qdisc
isn't attached anywhere yet at that point, calling the reset callback doesn't
make much sense (and as stated has been a source of two other bugs).
We plan on  submitting this fix in a later patch.
[1] https://lore.kernel.org/netdev/20221018063201.306474-2-shaozhengchao@huawei.com/
[2] https://lore.kernel.org/netdev/20221018063201.306474-4-shaozhengchao@huawei.com/

Fixes: 585d763af09c ("net/sched: Introduce Credit Based Shaper (CBS) qdisc")
Reported-by: Junyoung Jang <graypanda.inzag@gmail.com>
Tested-by: Junyoung Jang <graypanda.inzag@gmail.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Abort cbs_reset early if cbs_init failed (address issue from Sashiko)
---
 net/sched/sch_cbs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c862..0f953bd46b58 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -243,6 +243,20 @@ static struct sk_buff *cbs_dequeue(struct Qdisc *sch)
 	return q->dequeue(sch);
 }
 
+static void cbs_reset(struct Qdisc *sch)
+{
+	struct cbs_sched_data *q = qdisc_priv(sch);
+
+	/* Nothing to do if we couldn't create the underlying qdisc */
+	if (!q->qdisc)
+		return;
+
+	qdisc_reset(q->qdisc);
+	qdisc_watchdog_cancel(&q->watchdog);
+	q->credits = 0;
+	q->last = 0;
+}
+
 static const struct nla_policy cbs_policy[TCA_CBS_MAX + 1] = {
 	[TCA_CBS_PARMS]	= { .len = sizeof(struct tc_cbs_qopt) },
 };
@@ -540,7 +554,7 @@ static struct Qdisc_ops cbs_qdisc_ops __read_mostly = {
 	.dequeue	=	cbs_dequeue,
 	.peek		=	qdisc_peek_dequeued,
 	.init		=	cbs_init,
-	.reset		=	qdisc_reset_queue,
+	.reset		=	cbs_reset,
 	.destroy	=	cbs_destroy,
 	.change		=	cbs_change,
 	.dump		=	cbs_dump,
-- 
2.54.0


