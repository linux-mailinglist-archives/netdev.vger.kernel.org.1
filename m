Return-Path: <netdev+bounces-293064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHJeJ89cGWoLvwgAu9opvQ
	(envelope-from <netdev+bounces-293064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A985FFF69
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A63D13028352
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB33C1992;
	Fri, 29 May 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="p6WaYcWE"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45923403E4
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046828; cv=none; b=do9f3qejXiV17VmZXCN8jxt87pGwbdcUxkmBH4UfEAOOhww4wesFiJA2TFEgU9cD9Vzcc6IaCURbV6wHhXIekLHC7HC19O/5KLy8Mp0psp6mXPQRvLdkvLK3B/C1zO+adchwVY/rjH7Vv269uonmJ0GuPaoauPx5NVK46FuVwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046828; c=relaxed/simple;
	bh=9dhDMfEROxTjZNrBlGNCsh+iKL0HiWJECPUSQMm8kf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7XEn+1891vjnsPzRgNzw1iKcBygtktphXSpvepjPRDhe/04TQ8Zy6OANC5wNfIDUdYvR8MKNGSwc2j4ULEAMqD6/fX+JAGMnDc1ZVEkpAzF/lXBrQ0Dv1lkXGDG/P5O7vU05TXRvI+alwQKcw6f+Hryq2+vbLpQKrf2WMEi+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=p6WaYcWE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 20F16207B0;
	Fri, 29 May 2026 11:27:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ut5twp2myHfi; Fri, 29 May 2026 11:27:01 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4F542206D0;
	Fri, 29 May 2026 11:27:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4F542206D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780046821;
	bh=RY+ndBRW5bRN4I0j9i4rqRaM+kzkpQoVjhrjBLX+osE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=p6WaYcWEfiM3n1O8SxmFw0UNgDfnYFOBCnHGLRB9HATs/4GbNDneepqbxiEe70lgd
	 aNhXLFBRmjVd48GEHz2v0e9/8Dc7JBOh7NKFeQfInall5wfC8hjCLk1xd5kEfTVz7Y
	 RBt8VYZqNsci6AfSjBtLol7brXEHiUSLz1hOmQ+u/adgfz2x5X9/Fd2eNcW59F2+dq
	 aqqjf4gG/RFvYp4PUAOi9JpgqeSv2iQ6MUjdZmh0MdVUw+xAV5lnzQVZCnLRntPTf9
	 ZIPRK9KV2zlJumM81v3zyI5U+vokfjCAYYJXrEyS6e47QhWWdQSnIIodFY8P76ZcBG
	 MgSYex0P6rPow==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:27:00 +0200
Received: (nullmailer pid 3879711 invoked by uid 1000);
	Fri, 29 May 2026 09:26:51 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/10] xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit
Date: Fri, 29 May 2026 11:26:10 +0200
Message-ID: <20260529092648.3878973-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529092648.3878973-1-steffen.klassert@secunet.com>
References: <20260529092648.3878973-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,secunet.com:email,secunet.com:mid,secunet.com:dkim,linux.dev:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17A985FFF69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Usama Arif <usama.arif@linux.dev>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 59968dcbafe1..dd09d2063da2 100644
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
2.43.0


