Return-Path: <netdev+bounces-304337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S/8qEqxKR2o2VgAAu9opvQ
	(envelope-from <netdev+bounces-304337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:37:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055A6FEC5C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:37:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=noKq1kuz;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304337-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304337-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C20E8301E808
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508EE355F22;
	Fri,  3 Jul 2026 05:19:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBD3115BC
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:19:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055991; cv=none; b=uRn95X9gMmiI4ZVNNE/o54x7V4jOR8ptYu+XUA486RbzLsz6zzmu8x/aAzfvLtFI1UF8NrC6djMpMLBuwsGQ+72r32n6IuR8NphL+HjqAFMGqk78CABp1cL6GShMd8L8rBCeygQVi4Xjdq9TGZY/Uva6v/qYoVDWZWwaSg0Fg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055991; c=relaxed/simple;
	bh=fKOS1xr/IHI86JqXksu3q22pCsEkrYTylqI7Rg7A+iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkgR9SU2Ifw0MS/qc+WHaf08bJu/zOIf3lYEuSJycgotNTmttM1zNhnynL/4o8l7vwTycpMSWbywqMvnpBtO9fsDCC/0lM6d3FTVDu0DJsNuViMAKKNABQl4tpB1cY8BXvD+RLrhPSvjEvwY+5+kRy7/ptjQBEbQA6VpPjDkuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=noKq1kuz; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c999f162c9aso124786a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 22:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783055985; x=1783660785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuRWqicrIxhY5CxapHfSaRgauVoASoaTamVn1HrVEaE=;
        b=noKq1kuzyTLwcvOQc8GwzzL8t1I3myAo+x2UQ9C8DbTGC/LXqr4SIwJgsGv4jsPRKz
         NUQjaVm+QvbOarHiuQBU9R/TP6aEnmb/+K6fVuYZ8MwkfFgYk2hGiXgG6/tUsKeDnbWt
         cAf2C012VxK7I81xY1C6bnHYVP2OGhuaqFLsYPABzeNAP9fvQtdNWb/YiedoTCO0Q6J1
         z5aCKvD6nT6sOBHL07vLYWrxLxZKhjo9uDgwNuFenXmp70Ju3wqff55cG0Iyek019fb0
         oX7M9X0bdZxoyJruOPVLUbopxMy/9beaWANEPc1sYGKtEmzCt9YU79/fGJIFnqZCm88R
         93yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055985; x=1783660785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuRWqicrIxhY5CxapHfSaRgauVoASoaTamVn1HrVEaE=;
        b=tKwtJGdWeWKlXkmsdcWoMba8K3FgiiD7Fg/DplvkA4dIcncXVxQtHsKRqEc6bQRxhZ
         3ypPTuLozhrmN11E+jphvrthNh6vmBlSxppbPw5T1gZnMm/afquoKD5aEJUgpsFC32y2
         nC8vK9w2CDzuHfkKbLlY/MIfEGXXq2Co4YwAqenKilXzboQNVM2MxP887sACKffWDheu
         4I8Os+RlLZq1dKCFPT7bfSt8MD0V9wArfyYciw+sBPh70xx3btOQ9w8QO8/J7PUQgXje
         4M80236rofMuFmYgxQretQgdbaoH7vRj4tRw2+5wryFDhK4lEE4xmvpV6RchhM5Lj2lp
         f2Bg==
X-Forwarded-Encrypted: i=1; AFNElJ+L9yR2rg4BDlq1oINRgfZqRPtp58IopMGmUpYC4g+vGlrhyQbBCyLAaVjwTCjorGOXro5OnU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXI/DPLZdALIkTB84VFGDfjFw6TYgPVaTG4SwECmPz4xYZa5ks
	Bn3BUgz906BsHYrOa8MmrTzDkZwGw3ZHweIS3Fk5wrCHu6oWfqytDUITOJsI6rLC6A==
X-Gm-Gg: AfdE7cmA8IOM8O1uCtQ3XZNNnoGaeMbrhqGsk7uuzNynrzBlxOwlurM+/6JUrKmYUux
	jobbIBpYkWsRKlchR0CypwRYCfWzwz0tg07JCeOnDQUraDEFJIuiBICBmKBH6lr37PoxZqCFP9J
	I3aTfcUxEsSJr037Tnpv0wJshdvQMY+AUxiUW31/uGKVvhgY6wErbT6qxIivULk+s5U07P74JNA
	K31Chg/VKvBrxCVTkSaFLTy6UCg/DsIMTfsCwkXM2Y2McRDP1/durUGL30I28j6/MJZHOoJYQ8S
	1Pv+29g36wgQUQ/V2Xlt2BrQugyCmYUATM2DErIG7fcFaOEmwjJdi6UAl7oqwVyq9VYveA8HmVI
	5EVZPJ6Q3D0MrCjmQwDhoFLiNMrGzQIW5Aqj3aIanIZPgGEhf6aw0XRbMH1HcLlAn8mSNzRQNbS
	1HHEWhskd1mE9LbHG8nw==
X-Received: by 2002:a05:6a21:62cc:b0:3bf:a0e5:99a0 with SMTP id adf61e73a8af0-3bfed49e467mr11257508637.47.1783055985266;
        Thu, 02 Jul 2026 22:19:45 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef188sm15308002c88.2.2026.07.02.22.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:19:44 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: fw@strlen.de,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH ipsec v2] xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
Date: Fri,  3 Jul 2026 05:19:32 +0000
Message-ID: <20260703051932.966884-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5055A6FEC5C

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
---
v2: fix the inverted preallocation guard (root cause)
    instead of avoiding crash

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


