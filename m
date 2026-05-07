Return-Path: <netdev+bounces-285430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCchJpO6/Gl2TAAAu9opvQ
	(envelope-from <netdev+bounces-285430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:15:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB94EC04A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 737AB3005A94
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14C37268B;
	Thu,  7 May 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdR6O75I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC22EC571
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170513; cv=none; b=gcVyq/8Oiub6gkS55rzL8yD0sWbGY2XdvJLiuRe3dHmmteDwWCaauDRE0jaAA1fAZLMViIMhIJvo2ygKhItX6lW6x5F/0oOK4Lmm4tgg4QvyNVp25JgN7y2txvYU6jIFTluNykCLNrMq3zO+rIUWI9JosmrlbiTxqgBwitXfoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170513; c=relaxed/simple;
	bh=1lg58qmFpF+kSN6JNvbxcvJqXwne0vEgzC4GRZZQXvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PeZxSJ+8ohJ8GPamIrm9MpqXutQXrhfQuvBbEve7CLgybnI+ONBPAncOx5F/qWwbeGMulHuMLSXCiSlpGF0XQ2U+lSXWxOR3CclG0SiJ7WidUqaS+snUH3dp/dOV5N22DJ2VXhhjgZaQp4GYuCli0LU4GIa++vIgGgMuOg6SQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdR6O75I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778170510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pz6cMtzSSg94cOdnzxQctNDQk5hNgCfAncL9FfAgrvc=;
	b=DdR6O75Ij576XUqA0ECX4vNaV5yy78XsSWMrPQef7ltKpmq3D7TsvNONsW9hWFUuVyWLvi
	tOqxZ5282XA3hi73O/h63MuGpazxY3ZXnqbH1KPohXKcFCGOmA8ogdBlM/vmSHQc6VbfwC
	kVWD0P6pbb44SNFJAydW9TdVJ6LlrSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-cwGTs_B4P16PhRHW9V8EKg-1; Thu,
 07 May 2026 12:15:06 -0400
X-MC-Unique: cwGTs_B4P16PhRHW9V8EKg-1
X-Mimecast-MFC-AGG-ID: cwGTs_B4P16PhRHW9V8EKg_1778170505
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADABB195608F;
	Thu,  7 May 2026 16:15:04 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.49.163])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC7E6300019F;
	Thu,  7 May 2026 16:15:01 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: dualpi2: initialize timer earlier in dualpi2_init()
Date: Thu,  7 May 2026 18:14:10 +0200
Message-ID: <54f091e66a0aadeaf7ed72e7d1cabde1273a5cc6.1778170196.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 33DB94EC04A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-285430-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

'pi2_timer' needs to be initialized in all error paths of dualpi2_init():
otherwise, a failure in qdisc_create_dflt() causes the following crash in
dualpi2_destroy():

  # tc qdisc add dev crash0 handle 1: root dualpi2
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP PTI
  CPU: 4 UID: 0 PID: 471 Comm: tc Tainted: G            E       7.1.0-rc1-virtme #2 PREEMPT(full)
  Tainted: [E]=UNSIGNED_MODULE
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  RIP: 0010:hrtimer_active+0x39/0x60
  Code: f9 eb 23 0f b6 41 38 3c 01 0f 87 87 64 c0 ff 83 e0 01 75 33 48 39 4a 50 74 28 44 3b 42 10 75 06 48 3b 51 30 74 21 48 8b 51 30 <44> 8b 42 10 41 f6 c0 01 74 cf f3 90 44 8b 42 10 41 f6 c0 01 74 c3
  RSP: 0018:ffffd0db80b93620 EFLAGS: 00010282
  RAX: ffffffffc0400320 RBX: ffff8cf24a4c86b8 RCX: ffff8cf24a4c86b8
  RDX: 0000000000000000 RSI: ffff8cf2429c2ab0 RDI: ffff8cf24a4c86b8
  RBP: 00000000fffffff4 R08: 0000000000000003 R09: 0000000000000000
  R10: 0000000000000001 R11: ffff8cf24a39c500 R12: ffff8cf24822c000
  R13: ffffd0db80b936c0 R14: ffffffffc02cf360 R15: 00000000ffffffff
  FS:  00007fbc01706580(0000) GS:ffff8cf2dc759000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000010 CR3: 0000000008e02003 CR4: 0000000000172ef0
  Call Trace:
   <TASK>
   hrtimer_cancel+0x15/0x40
   dualpi2_destroy+0x20/0x40 [sch_dualpi2]
   qdisc_create+0x230/0x570
   tc_modify_qdisc+0x716/0xc10
   rtnetlink_rcv_msg+0x188/0x780
   netlink_rcv_skb+0xcd/0x150
   netlink_unicast+0x1ba/0x290
   netlink_sendmsg+0x242/0x4d0
   ____sys_sendmsg+0x39e/0x3e0
   ___sys_sendmsg+0xe1/0x130
   __sys_sendmsg+0xad/0x110
   do_syscall_64+0x14f/0xf80
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fbc0188b08e
  Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
  RSP: 002b:00007fff593260e0 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc0188b08e
  RDX: 0000000000000000 RSI: 00007fff59326190 RDI: 0000000000000003
  RBP: 00007fff593260f0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 000055f06124f260
  R13: 0000000069fca043 R14: 000055f061255640 R15: 000055f06124d3f8
   </TASK>
  Modules linked in: sch_dualpi2(E)
  CR2: 0000000000000010

[1] https://lore.kernel.org/netdev/2e78e01c504c633ebdff18d041833cf2e079a3a4.1607020450.git.dcaratti@redhat.com/
[2] https://lore.kernel.org/netdev/20200725201707.16909-1-xiyou.wangcong@gmail.com/

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/sch_dualpi2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 6d7e6389758d..dbe4b99955ab 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -917,6 +917,9 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	int err;
 
+	hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_SOFT);
+
 	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				       TC_H_MAKE(sch->handle, 1), extack);
 	if (!q->l_queue)
@@ -928,8 +931,6 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->sch = sch;
 	dualpi2_reset_default(sch);
-	hrtimer_setup(&q->pi2_timer, dualpi2_timer, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_ABS_PINNED_SOFT);
 
 	if (opt && nla_len(opt)) {
 		err = dualpi2_change(sch, opt, extack);
-- 
2.52.0


