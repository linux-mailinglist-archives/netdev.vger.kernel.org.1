Return-Path: <netdev+bounces-260644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIcaEAcLnmnkTAQAu9opvQ
	(envelope-from <netdev+bounces-260644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:33:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0818C665
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA81304DC8D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58F33A6FB;
	Tue, 24 Feb 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyrLqxwI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48A26A0C7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965031; cv=none; b=p7+QanveuI1vdd6SqqZI+VlOazfa7AEtngGPH1nm5gp9fE+kSfj/AcjbdLfurcUqaDyGeGBm+A7DducIs5IGwZurR0yansJkfqrYeW0zol3DcOmlUUHWfIgvjgzGqLQAjv8yDU3gaWnBP/3fHYiukknXAn2c5KbMfC7oZwHWU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965031; c=relaxed/simple;
	bh=YQA1mkKna0FlMuY/MmJNczhr1bRcCeOleL24M5PFzXY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ttJ3/J9NWi+9LDqCxMFNhXZyBz2hj0thD0y09WMWzZMt68NI0nPLTc5WMndDTCp9MH6I0VRr2AU0gQKq1TGnCciL3715h/3lefhpMV5idDIZ666B/lmGNgRTrVe5bj5BRDtNclVecRu5CfRuwBLosn4K425+GHlJ42t8PBJVMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyrLqxwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771965028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uu8uZj36aSMeKYdaF+VZ7z9MFqA8Pc5joGqJIks22DM=;
	b=dyrLqxwIl2Wqrrb+iMNg1CuIXhOqjGx6hThV/Oh5bz0jtBlRBo5tkDL3Td33/5wBCpdoA3
	XoZqFuWOd5DVCG9NMo7SoLxoVzR0R3o0JUjLHHOK6+jFGcT4UAkXu+TXGIg9pKoMW+5lQM
	jT08u/dhB0cBvM3qX8prCUywTB7M66Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-R8PpMFbwNdirup-ienxzAg-1; Tue,
 24 Feb 2026 15:30:25 -0500
X-MC-Unique: R8PpMFbwNdirup-ienxzAg-1
X-Mimecast-MFC-AGG-ID: R8PpMFbwNdirup-ienxzAg_1771965023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 733F21956096;
	Tue, 24 Feb 2026 20:30:23 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6F9F1955F43;
	Tue, 24 Feb 2026 20:30:19 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Petr Machata <petrm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net/sched: ets: fix divide by zero in the offload path
Date: Tue, 24 Feb 2026 21:28:32 +0100
Message-ID: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260644-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97C0818C665
X-Rspamd-Action: no action

Offloading ETS requires computing each class' WRR weight: this is done by
averaging over the sums of quanta as 'q_sum' and 'q_psum'. Using unsigned
int, the same integer size as the individual DRR quanta, can overflow and
even cause division by zero, like it happened in the following splat:

 Oops: divide error: 0000 [#1] SMP PTI
 CPU: 13 UID: 0 PID: 487 Comm: tc Tainted: G            E       6.19.0-virtme #45 PREEMPT(full)
 Tainted: [E]=UNSIGNED_MODULE
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 RIP: 0010:ets_offload_change+0x11f/0x290 [sch_ets]
 Code: e4 45 31 ff eb 03 41 89 c7 41 89 cb 89 ce 83 f9 0f 0f 87 b7 00 00 00 45 8b 08 31 c0 45 01 cc 45 85 c9 74 09 41 6b c4 64 31 d2 <41> f7 f2 89 c2 44 29 fa 45 89 df 41 83 fb 0f 0f 87 c7 00 00 00 44
 RSP: 0018:ffffd0a180d77588 EFLAGS: 00010246
 RAX: 00000000ffffff38 RBX: ffff8d3d482ca000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffd0a180d77660
 RBP: ffffd0a180d77690 R08: ffff8d3d482ca2d8 R09: 00000000fffffffe
 R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffe
 R13: ffff8d3d472f2000 R14: 0000000000000003 R15: 0000000000000000
 FS:  00007f440b6c2740(0000) GS:ffff8d3dc9803000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000003cdd2000 CR3: 0000000007b58002 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ets_qdisc_change+0x870/0xf40 [sch_ets]
  qdisc_create+0x12b/0x540
  tc_modify_qdisc+0x6d7/0xbd0
  rtnetlink_rcv_msg+0x168/0x6b0
  netlink_rcv_skb+0x5c/0x110
  netlink_unicast+0x1d6/0x2b0
  netlink_sendmsg+0x22e/0x470
  ____sys_sendmsg+0x38a/0x3c0
  ___sys_sendmsg+0x99/0xe0
  __sys_sendmsg+0x8a/0xf0
  do_syscall_64+0x111/0xf80
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7f440b81c77e
 Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
 RSP: 002b:00007fff951e4c10 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 0000000000481820 RCX: 00007f440b81c77e
 RDX: 0000000000000000 RSI: 00007fff951e4cd0 RDI: 0000000000000003
 RBP: 00007fff951e4c20 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff951f4fa8
 R13: 00000000699ddede R14: 00007f440bb01000 R15: 0000000000486980
  </TASK>
 Modules linked in: sch_ets(E) netdevsim(E)
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:ets_offload_change+0x11f/0x290 [sch_ets]
 Code: e4 45 31 ff eb 03 41 89 c7 41 89 cb 89 ce 83 f9 0f 0f 87 b7 00 00 00 45 8b 08 31 c0 45 01 cc 45 85 c9 74 09 41 6b c4 64 31 d2 <41> f7 f2 89 c2 44 29 fa 45 89 df 41 83 fb 0f 0f 87 c7 00 00 00 44
 RSP: 0018:ffffd0a180d77588 EFLAGS: 00010246
 RAX: 00000000ffffff38 RBX: ffff8d3d482ca000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffd0a180d77660
 RBP: ffffd0a180d77690 R08: ffff8d3d482ca2d8 R09: 00000000fffffffe
 R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffe
 R13: ffff8d3d472f2000 R14: 0000000000000003 R15: 0000000000000000
 FS:  00007f440b6c2740(0000) GS:ffff8d3dc9803000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000003cdd2000 CR3: 0000000007b58002 CR4: 0000000000172ef0
 Kernel panic - not syncing: Fatal exception
 Kernel Offset: 0x30000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: Fatal exception ]---

Fix this using 64-bit integers for 'q_sum' and 'q_psum'.

Cc: stable@vger.kernel.org
Fixes: d35eb52bd2ac ("net: sch_ets: Make the ETS qdisc offloadable")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/sch_ets.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 306e046276d4..a4b07b661b77 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -115,12 +115,12 @@ static void ets_offload_change(struct Qdisc *sch)
 	struct ets_sched *q = qdisc_priv(sch);
 	struct tc_ets_qopt_offload qopt;
 	unsigned int w_psum_prev = 0;
-	unsigned int q_psum = 0;
-	unsigned int q_sum = 0;
 	unsigned int quantum;
 	unsigned int w_psum;
 	unsigned int weight;
 	unsigned int i;
+	u64 q_psum = 0;
+	u64 q_sum = 0;
 
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
@@ -138,8 +138,12 @@ static void ets_offload_change(struct Qdisc *sch)
 
 	for (i = 0; i < q->nbands; i++) {
 		quantum = q->classes[i].quantum;
-		q_psum += quantum;
-		w_psum = quantum ? q_psum * 100 / q_sum : 0;
+		if (quantum) {
+			q_psum += quantum;
+			w_psum = div64_u64(q_psum * 100, q_sum);
+		} else {
+			w_psum = 0;
+		}
 		weight = w_psum - w_psum_prev;
 		w_psum_prev = w_psum;
 
-- 
2.52.0


