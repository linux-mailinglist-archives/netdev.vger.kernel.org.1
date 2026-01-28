Return-Path: <netdev+bounces-254122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGPbJhW1eWk0ygEAu9opvQ
	(envelope-from <netdev+bounces-254122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:04:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24339D93F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1FF30107DF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAC29A30E;
	Wed, 28 Jan 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hJfrQG84"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C2126BF7;
	Wed, 28 Jan 2026 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583846; cv=none; b=saNIzsjSnz/cIafcmp4RHaQdlXg8r5ZjD84B9/lk+EbVVHH7OiN1ALMnIQI1YKjQWaWPu24kzLtwD/6rCgaOhwIkPDOKieg5sRfgsLeG1z3hpGCFJzKHy/hZey+ghn2CeVDURP+WaUoBp3eNbWRPDAGAgHfbOGzQXGTmoBRAi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583846; c=relaxed/simple;
	bh=S7YYmuNjsRxMp9VgLETUX1LGfykzsX4LVW6Agk9A1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjvfgm+/rnL85EWBy7jg8C7nmAMNRDMATjvjGVVErvvvEiwsEBFmTxe7WYSPR8E1EdgFMZZqACF2OwjhHyV6ENuc6/gMyOTazUDczZTYbRY8lXq7Q3zg2FXlB6zpqUZh44dqeDpXQJRMu1LKzXEvo1NTRYZwUNREfDdHK7Kq0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hJfrQG84; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769583841; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+ODM/O7PFYYeg5W3jxjQDZCsYy5qNj5gMWZpfw+2/2k=;
	b=hJfrQG847pkNxSa9NUJ4lPMS71L1ISkyEkVfO9K1K+sSYMqtUvKwa55VeMHAYGmqHZYj79YdLQS3HjocvdQ+1Q44jl3ba7R/WlwbI/Eu2rbNoilX05hvedtjGrvs5LfPT160D1n6bEqL6prEtw+f6Rjsw4mZ17AvmASIBdUjMDI=
Received: from localhost(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0Wy2Y7Bk_1769583840 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 15:04:01 +0800
From: fengwei_yin@linux.alibaba.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: fengwei_yin@linux.alibaba.com
Subject: [PATCH] net: procfs: Fix RCU stall and soft lockup in ptype_seq_next()
Date: Wed, 28 Jan 2026 15:03:59 +0800
Message-ID: <20260128070359.6762-1-fengwei_yin@linux.alibaba.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[fengwei_yin@linux.alibaba.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-254122-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: F24339D93F
X-Rspamd-Action: no action

From: Yin Fengwei <fengwei_yin@linux.alibaba.com>

On an arm64 server platform, fuzz testing can trigger an RCU stall
followed by a soft lockup in ptype_seq_show(). The backtrace shows
the stall occurs in traverse.part.0(), which is called from
seq_read_iter() during /proc/net/ptype access:

[  295.799369] rcu: INFO: rcu_preempt self-detected stall on CPU
[  295.799937] rcu:     1-....: (60005 ticks this GP) idle=0f94/1/0x4000000000000000 softirq=5198/5199 fqs=29992
[  295.800708] rcu:     (t=60008 jiffies g=11197 q=1553 ncpus=2)
[  295.801152] CPU: 1 UID: 0 PID: 2695 Comm: test2 Tainted: G		L      6.19.0-rc7+ #19 PREEMPT(voluntary)
[  295.801961] Tainted: [L]=SOFTLOCKUP
[  295.802245] Hardware name: linux,dummy-virt (DT)
[  295.802616] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  295.803171] pc : traverse.part.0+0x80/0x190
[  295.803511] lr : traverse.part.0+0x4c/0x190
[  295.803850] sp : ffff800082dabb20
[  295.804117] x29: ffff800082dabb20 x28: ffff000004571280 x27: 0000000000000000
[  295.804680] x26: 0000000000000000 x25: ffff00000471fee0 x24: ffff00000471fed0
[  295.805245] x23: 00000000000080db x22: 0000000000000033 x21: 0000000000000000
[  295.805814] x20: ffff000003719160 x19: ffff00000471fea8 x18: 0000000000000000
[  295.806378] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  295.806941] x14: 0000000000000000 x13: 0a6e6f6974636e75 x12: 4620202020202065
[  295.807507] x11: 0000000000000000 x10: 0000000000000001 x9 : ffffc27ab28f881c
[  295.808081] x8 : 000000000000000a x7 : ffffc27ab3a8db42 x6 : 000000000000000a
[  295.808652] x5 : 0000000000000000 x4 : 0000000000001000 x3 : ffffc27ab328a7f8
[  295.809219] x2 : ffff00000471fed0 x1 : ffff000003719160 x0 : ffff00000471fea8
[  295.809785] Call trace:
[  295.809983]  traverse.part.0+0x80/0x190 (P)
[  295.810322]  seq_read_iter+0x2f8/0x4f8
[  295.810625]  seq_read+0xe4/0x120
[  295.810890]  proc_reg_read+0x9c/0xf8
[  295.811185]  do_loop_readv_writev.part.0+0xbc/0x118
[  295.811574]  vfs_readv+0x174/0x1d8
[  295.811848]  do_preadv+0x90/0xf8
[  295.812110]  __arm64_sys_preadv+0x24/0x38
[  295.812435]  invoke_syscall+0x4c/0x110
[  295.812737]  el0_svc_common.constprop.0+0x44/0xe8
[  295.813113]  do_el0_svc+0x20/0x30
[  295.813382]  el0_svc+0x38/0x178
[  295.813636]  el0t_64_sync_handler+0x98/0xe0
[  295.813969]  el0t_64_sync+0x184/0x188

The root cause is in ptype_seq_next(): when iterating over packet
types, it's possible that a packet type entry (pt) has been removed,
its dev set to NULL, and pt->af_packet_net is not initialized.
In that case, the function may return the same 'nxt' pointer indefinitely.
This results in an infinite loop under RCU read-side critical section,
causing an RCU stall and eventually a soft lockup.

Fix the issue by properly handling the case where 'nxt' points to
an empty list, ensuring forward progress in the iterator.

Signed-off-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
---
 net/core/net-procfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 70e0e9a3b650..eb8c34bb1f0a 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -231,7 +231,7 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	pt = v;
 	nxt = pt->list.next;
 	if (pt->dev) {
-		if (nxt != &pt->dev->ptype_all)
+		if (!list_empty(nxt) && nxt != &pt->dev->ptype_all)
 			goto found;
 
 		dev = pt->dev;
@@ -247,7 +247,7 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 	if (pt->af_packet_net) {
 net_ptype_all:
-		if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
+		if (!list_empty(nxt) && nxt != &net->ptype_all && nxt != &net->ptype_specific)
 			goto found;
 
 		if (nxt == &net->ptype_all) {
@@ -267,6 +267,9 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 			return NULL;
 		nxt = ptype_base[hash].next;
 	}
+
+	if (list_empty(nxt))
+		return NULL;
 found:
 	return list_entry(nxt, struct packet_type, list);
 }
-- 
2.43.5


