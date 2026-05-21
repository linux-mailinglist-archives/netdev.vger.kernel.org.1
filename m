Return-Path: <netdev+bounces-290342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN0rNHzkDmrACwYAu9opvQ
	(envelope-from <netdev+bounces-290342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:54:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A85A3A5B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8CE31F7C11
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745539EF1C;
	Thu, 21 May 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gMlXua4u"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E739EF33
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359396; cv=none; b=EwIGtrihrRjXrF6itqGlXL5BapUyCNcgKtWJiKc+f43PtVKVyA+CbwvSymifY13lFWhn4jIyiJGAbHCfhFIRyFWNGaeUWCT5b8RzVnqUp/ED3P1BiojVXMXNLLwnB8gxFrMgJ00CKkb8MYNQ89R0q6YqbX7SE5JOgbWnKktwo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359396; c=relaxed/simple;
	bh=bFD/FzU8JWe1m1lLvQmn0Wa++ASfXu3tXMeg0uYiX94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTdE3V4D1XBp30O2NHFv4VDloiHRxd+JYpJNHk3lKG+wGUNRTYrl2bZlcbgLca1+5pi13vUVo2f6TC/3krMOd23DdP3VuXAYgRGJ0geQBCl8Dem3L2DdNvBrkB/EB/7zjwC2vON2ZISYH8IDFAr/KbP1ZcZ+ayJ2fC7qms4tyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMlXua4u; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779359391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uGT9xmUndSamd2/F1rfAsB2XvteTKagY47d8zlarwQc=;
	b=gMlXua4uTqDnYCdY4GTA1GdLUWR1i1CHe1GR+Txo8pacblfuEunOT5t9WDaYaGvR84Cfvd
	p3kDHZp2ybpZafJ2tJEGdtaij1Yg1aqkVn7j/UBiVyfkkrt1akDBkrUUVKVLjUmR/+mwpb
	MbUkpUfQG1Xh7zwlWFm+PFfymJm0S0Y=
From: Usama Arif <usama.arif@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	alexanderduyck@fb.com
Cc: enewton@meta.com,
	vlad.wing@gmail.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit
Date: Thu, 21 May 2026 03:29:26 -0700
Message-ID: <20260521102926.2613544-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[meta.com,gmail.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 563A85A3A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The struct pernet_operations docstring in include/net/net_namespace.h
explicitly warns against blocking RCU primitives in .exit handlers:

    Exit methods using blocking RCU primitives, such as
    synchronize_rcu(), should be implemented via exit_batch.
    [...]
    Please, avoid synchronize_rcu() at all, where it's possible.

    Note that a combination of pre_exit() and exit() can
    be used, since a synchronize_rcu() is guaranteed between
    the calls.

xfrm_policy_fini() violates this: it calls synchronize_rcu() before
freeing the policy_bydst hash tables (so no RCU reader is mid-
traversal at free time), but runs from xfrm_net_ops.exit -- once per
namespace -- so a cleanup_net() of N namespaces pays N full RCU
grace periods serially.

Use the documented pre_exit/exit split. Move the policy flush (and
the workqueue drains it depends on) into a new .pre_exit handler;
xfrm_policy_fini() then runs in .exit and frees the hash tables
after the synchronize_rcu_expedited() that cleanup_net() guarantees
between the two phases. Providing O(1) RCU grace periods per batch
instead of O(N).

Observed on Linux 6.18 with a workload doing unshare(CLONE_NEWNET)
at ~13/sec sustained: cleanup_net() and the netns_wq rescuer kthread
both stuck in xfrm_policy_fini()'s synchronize_rcu(), >300k struct
net accumulated in the cleanup queue, Percpu in /proc/meminfo climbed
to 130+ GB on 256-CPU hosts, and memcg OOMs followed. setup_net and
__put_net counts were balanced, ruling out a refcount leak.

Fixes: 069daad4f2ae ("xfrm: Wait for RCU readers during policy netns exit")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 net/xfrm/xfrm_policy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c944327ce66c..edc3b4d34119 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4276,21 +4276,21 @@ static int __net_init xfrm_policy_init(struct net *net)
 	return -ENOMEM;
 }
 
-static void xfrm_policy_fini(struct net *net)
+static void __net_exit xfrm_net_pre_exit(struct net *net)
 {
-	struct xfrm_pol_inexact_bin *b, *t;
-	unsigned int sz;
-	int dir;
-
 	disable_work_sync(&net->xfrm.policy_hthresh.work);
-
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
+}
 
-	synchronize_rcu();
+static void xfrm_policy_fini(struct net *net)
+{
+	struct xfrm_pol_inexact_bin *b, *t;
+	unsigned int sz;
+	int dir;
 
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
@@ -4368,6 +4368,7 @@ static void __net_exit xfrm_net_exit(struct net *net)
 
 static struct pernet_operations __net_initdata xfrm_net_ops = {
 	.init = xfrm_net_init,
+	.pre_exit = xfrm_net_pre_exit,
 	.exit = xfrm_net_exit,
 };
 
-- 
2.52.0


