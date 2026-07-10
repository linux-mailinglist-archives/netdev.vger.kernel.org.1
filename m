Return-Path: <netdev+bounces-306473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kDNhOBm6UGpO4AIAu9opvQ
	(envelope-from <netdev+bounces-306473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B577738FEF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=X84zjXoh;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306473-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306473-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A9630A09FC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F93DA5DA;
	Fri, 10 Jul 2026 09:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B573D45E6
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674248; cv=none; b=qrxvUfykpVF5sQKzn4VcodZUDG7z/N405MAkx7VQL6GDMsBa7pbLw0iJcHfYGDIqCfxvcgt1GpJXoSfvenzKr/04spqxCwgxhwsK41t/3aXYk4A92VTAce8t375zfQ22VQRJQnunSvBSJWY6ol6Rywjh/quWuQuCBHpv8YAphqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674248; c=relaxed/simple;
	bh=N9n1555YeOw40UC7pQrTxvNbT79QleqU+o8qBgmZFh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oORvLfT9J+nHiI3nJrIXYqTFG5CO3POWTZmdy8Fk6RlEf7tPy+fCFXaQLCCW+35VKbTOUrZnNt9+yq74x4wDL0VNe9HW2EK34c16lb3M0tSw/oKvbWjsuQGB8PcDrt7M7ZI38MY57xY5XJaOgA+Eex+2lqt3x0wi3wQf0LHIDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=X84zjXoh; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 256D4207B2;
	Fri, 10 Jul 2026 11:03:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9iZwQwD1hbs; Fri, 10 Jul 2026 11:03:58 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7BB68205E5;
	Fri, 10 Jul 2026 11:03:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7BB68205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674238;
	bh=dyOkYOk+fRV+oDZCl85SmofEkWP9kV3gf8mFgdI0rnE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=X84zjXoh1UbNfAoUo9KZvrFKGF5DbdIZfy8rliqKIs0FEY2wj9ueX9fom6sgvtdgE
	 7/FDTH2Foj5Cgp9V0MQic8j5GLmyaffmQ+2kUolVN1m9rhGaFQM0Xv33uzXLts4F6W
	 6IoEQaH15ESGrg4AKTeELJmXeV5yJ/dSN00JhovlujJUbUyNr3MKcZpQkIfM6f2IL+
	 18j4wloi3lH64fbsoPQE9Y6IXUUW39f+euRaRkmlMtm8yus4li88nj8xr9M2TSM76n
	 xhOknnAeKvf+gBEeo8o/eOa8izmpoiryhjzRECE1nv5rL7vEeVkKqArkCsXuuUr5qS
	 215nSo8eYmyQA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:03:57 +0200
Received: (nullmailer pid 343863 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/10] xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
Date: Fri, 10 Jul 2026 11:03:23 +0200
Message-ID: <20260710090349.343389-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306473-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B577738FEF

From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>

xfrm_hash_rebuild()'s first loop preallocates the bins/chains the reinsert
loop needs, so the reinsert (after hlist_del_rcu()) cannot allocate or
fail. But its guard is inverted: it skips policies with prefixlen <
threshold and preallocates for the rest.

prefixlen < threshold is exactly when policy_hash_bysel() returns NULL and
the reinsert takes the allocating xfrm_policy_inexact_insert() path. So the
loop preallocates for the exact policies (which never allocate) and skips
the inexact ones, whose bin/node is then allocated GFP_ATOMIC during
reinsert. On failure the error path only WARN_ONCE()s and continues,
leaving a poisoned bydst node; the next rebuild's hlist_del_rcu()
dereferences LIST_POISON2 and takes a GPF. Reachable under memory pressure,
deterministic via failslab.

Invert the guard so preallocation covers exactly the reinserted policies;
the reinsert then allocates nothing and cannot fail.

Crash:
  Oops: general protection fault, probably for non-canonical address
  0xfbd59c0000000024: 0000 [#1] SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0xdead...]
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

Fixes: 24969facd704 ("xfrm: policy: store inexact policies in an rhashtable")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7ef861a0e823..932a313b9460 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1329,8 +1329,8 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 			}
 		}
 
-		if (policy->selector.prefixlen_d < dbits ||
-		    policy->selector.prefixlen_s < sbits)
+		if (policy->selector.prefixlen_d >= dbits &&
+		    policy->selector.prefixlen_s >= sbits)
 			continue;
 
 		bin = xfrm_policy_inexact_alloc_bin(policy, dir);
-- 
2.43.0


