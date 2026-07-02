Return-Path: <netdev+bounces-304260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2U3fBkm2RmoOcAsAu9opvQ
	(envelope-from <netdev+bounces-304260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:04:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5156FC609
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=OKGKiCLl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304260-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304260-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFBA30014BA
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162B370D57;
	Thu,  2 Jul 2026 18:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AC370D52
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:58:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018692; cv=none; b=GKLGPYjJ1JtA0Q45OAKAosfLhYqWPGGiavVzlAV9zZxKknq1G4M7Sn8lZ5oUKpdYvIvAUhqF0MgUupBmx3WgVMpho5xpVYineLsifESI5RKOIWfLjz/bdf5Rbd4mBfh/5EAvlnesM2zxKcRBLnGwfaMB/bjTFSJDn0mCYy8luyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018692; c=relaxed/simple;
	bh=OJyysmG7XmShGOFzAKH2wqmeuwqDr6Dt6uQParIhfGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2Q1PnWZwu+QwK+SYS+N1216NsmoARNW86Cu1rwkoxgiBXCrzA3Ozj5cClKFQyC6i03SijrqeUhegiMiCKo0tnihcnIfUadJuwoSvIIXj1IXED99JI0yfbB7RfMcvGG5B6bpVpqX5CgvAxtPHEtiTucXQ6HvgRhYc970uGaY5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OKGKiCLl; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9e89fded0so19765785ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783018690; x=1783623490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EIgiOMWaI1ktE/tVFxHgxbR7D/Ac8iShTpnTllQOqS8=;
        b=OKGKiCLloZIJW41qHy6zpjlBLOGNf3vkd8o45f2GJw7HCYRFOx759ocuIGvboXmnxH
         vbxZUbL0SApHp7pXgPUjoa0a2VAeRKKGCR7C3UnQVHuRNc7DHnjgRkMmnAJr+rYYlip8
         PaTDpF/y6Bzx6EIzKNxQrSwgt2Qmt0ATXS4+Z97O2a9yVRpt+q5HzbvBNVaswDxhDkq2
         wuwYQJM4eZlAprajp2i4YkB8yTA27QzO3S1Vo5Xeagz97wDct2XJrcEfsB4zvebjz+Lw
         I8M3u1xyuABTqyz9JBv1itNtK1MFat7Eh07FXv0UOz90o3P5Yp4MfptWeFbg1DWZALf2
         BMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783018690; x=1783623490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIgiOMWaI1ktE/tVFxHgxbR7D/Ac8iShTpnTllQOqS8=;
        b=r84jDgCBF+1h0xV6CzsSCbiT6EXJ4iyU33Dzv92S3jWbQKHUFaB/+1wbvD/2eZkZaQ
         sgp8uBP6kCcqK7W9LSFepn3tScG+leSNRwF8CnxyiWqLlDp9/vrk+PrJpJtOU4j60bp8
         X9ziKJpZFbzJ8JhBOwUW+rViKlrn6CfwynV9AEjW/1X6QSEumWc9dppxEK+PFQOgwAtA
         t0It2lTkft7sg3c7qeV8U4/xWwsOPe0qcIZlc5EDGX8nOscUVnqQqMJ/dniRCjhevkrR
         IhZr7zsXcKV44aa25Y8dhj9FUf0jrPthZk5jtE6UDh8BSu25FWFJQ/K5CUA2z1FJYVUb
         PSSg==
X-Forwarded-Encrypted: i=1; AHgh+RqzATdQH/0N8OZnwfGgRwUWVOdICJzNA2cgYMWgVk0TKXCCo02bCeGsfzFnFuhXEMxDgWYV0K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYp7Z2UQzjBUR14+6QnyRolQStFURCOpJERKHrjiPItg8Vwa8p
	CGoZpchdV5cboV8DcMezQ+CLJRQcRuShvdjlMt7rEEhvlz9D2XXCwUUsVp/fpAVfsQ==
X-Gm-Gg: AfdE7cl4ZKHklQfot69kIrFt3Y7MqGWpDSQAUyesBfrBmu4e3ockDoFX2OvlhM0WOdh
	D83QZne9YIE6uT8BNW7g2h/zU5s9QGl7owq4qLiPgaw42GWFWe7suIBicFTFdkJC1t9K3tmow7w
	QI8l+20XQEkLO9YIMyz/XkPsUmtZ/5GhufdcJvfc1X4f3638KrrUnctMyIIO1WnBwLZwiaB0Aqs
	uY7ZpraMR4oYZlKBYtse/thOhu118OTniP4rUKfHmVmiR1mowI9jpdnLkVsZwBtDH1r/R4VyFSM
	RcPiKux1WL41PZnMvImJ5K84WzL1C+JWB4cJatzxI7dLrKSofcqUCKSgkTsZxUutuKHQAi1pcqt
	WOJaj4/zYz/n617u2y5xaWteAl5gdv2RPsdCOTYAWynrM8GGHdmAQxdNH7L3KH+FrqaK0Q2aqRI
	snA7AwvTKmEYjrHJdwK2/ct7M0JNLW
X-Received: by 2002:a17:903:2cb:b0:2c9:c5bf:2872 with SMTP id d9443c01a7336-2ca9112ca8cmr66982495ad.1.1783018689972;
        Thu, 02 Jul 2026 11:58:09 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b41c364d5sm5731076c88.14.2026.07.02.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:58:09 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fw@strlen.de,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in xfrm_hash_rebuild to avoid bydst poison
Date: Thu,  2 Jul 2026 18:58:05 +0000
Message-ID: <20260702185805.615241-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:fw@strlen.de,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A5156FC609

xfrm_hash_rebuild() unlinks each policy from its bydst chain with
hlist_del_rcu() and re-inserts it. For an inexact policy the re-insert goes
through xfrm_policy_inexact_insert(), which can fail on a GFP_ATOMIC
allocation; on failure the error path only WARN_ONCE()s and continues, so the
policy is left with a poisoned bydst node (LIST_POISON2). The next rebuild
calls hlist_del_rcu() on that node again, dereferences the poison, and takes a
general protection fault.

Use hlist_del_init_rcu() instead, so a failed-reinsert node is left unhashed
(pprev == NULL) rather than poisoned. The next rebuild's hlist_del_init_rcu()
is then a no-op for it, and the non-failing case is unchanged.

The reinsert allocation is GFP_ATOMIC (it runs under xfrm_policy_lock), so in
practice this is only reached under memory pressure; the crash below was
reproduced deterministically by forcing that allocation to fail with fault
injection (failslab).

Crash:
  Oops: general protection fault, probably for non-canonical address
  0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
  ...
  Workqueue: events xfrm_hash_rebuild
  RIP: 0010:xfrm_hash_rebuild+0x5b3/0x1190
  RAX: dead000000000122   (LIST_POISON2 + offset)
  ...
  Call Trace:
   hlist_del_rcu (include/linux/rculist.h:599)
   xfrm_hash_rebuild (net/xfrm/xfrm_policy.c:1365)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
   ...
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7ef861a0e823..2612a405542b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1362,7 +1362,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
 
-		hlist_del_rcu(&policy->bydst);
+		hlist_del_init_rcu(&policy->bydst);
 
 		newpos = NULL;
 		dir = xfrm_policy_id2dir(policy->index);
-- 
2.43.0


