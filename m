Return-Path: <netdev+bounces-262134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL2EDef5omkZ8gQAu9opvQ
	(envelope-from <netdev+bounces-262134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:21:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFBB1C3899
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F22AC30EFAAE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A141C2E6;
	Sat, 28 Feb 2026 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kdNYSrcW"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1A38736D
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772288446; cv=none; b=F6dSGcnUl2uEImIBkottvKrRn6EjHso8EV9lnJBUYP9m3aWNBMbTmIgPLmIzHvPQ/+WNSkspZjwiZLtxvqqbnkfBYSle1epsE7c2EGrxI/nGuU8f/TZWG3VsSU6G2ulMWxkT9ZIu0042FxLGlyR5/TaOKgE1igi+yiPHf8+J2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772288446; c=relaxed/simple;
	bh=7f5+r7ycTP2wUCbYBrRzzA6BhtcZIHqy7pWqX2qOIF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaBCMYEjLufmhZXzGxnjxrV0kd4V8O1HU4/vb3A0tRvjMlz2UnGqE0T+juQOZ856tj+7iwjZmaUjmVwwWjgLy+ZxhLH2htZLWnIJ10MgPLA+6+9c/1g0G6kRDi2NryhYwcSG49qEUsT5veL4z56Tcyts/me1CTj9FsIAaRDG+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kdNYSrcW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772288441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaHUxVaobjs+nvwAKL/h30L1BqLPqcHDSgP0kHDwdc8=;
	b=kdNYSrcWgsufXjWGjib/VZy2Bqp1osTgP3+loYpCfqscJwNdtD8HlbRAcQzfLKQE3q16mx
	PE7HXXkmhnUgu4h9+jVLjjRtKRB67xXlWuOuk1KmufEOndo3fpYmiPIvPrwImoBx5Bg9CM
	SUGNO9XzYlFARce+XpR8oDn2vTDJVjI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/3] cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
Date: Sat, 28 Feb 2026 06:20:16 -0800
Message-ID: <20260228142018.3178529-2-shakeel.butt@linux.dev>
In-Reply-To: <20260228142018.3178529-1-shakeel.butt@linux.dev>
References: <20260228142018.3178529-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262134-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAFBB1C3899
X-Rspamd-Action: no action

cgroup_file_notify() calls kernfs_notify() while holding the global
cgroup_file_kn_lock.  kernfs_notify() does non-trivial work including
wake_up_interruptible() and acquisition of a second global spinlock
(kernfs_notify_lock), inflating the hold time.

Take a kernfs_get() reference under the lock and call kernfs_notify()
after dropping it, following the pattern from cgroup_file_show().

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: Jakub Kicinski <kuba@kernel.org>
---
 kernel/cgroup/cgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index be1d71dda317..33282c7d71e4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4687,6 +4687,7 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 void cgroup_file_notify(struct cgroup_file *cfile)
 {
 	unsigned long flags;
+	struct kernfs_node *kn = NULL;
 
 	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
 	if (cfile->kn) {
@@ -4696,11 +4697,17 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 		if (time_in_range(jiffies, last, next)) {
 			timer_reduce(&cfile->notify_timer, next);
 		} else {
-			kernfs_notify(cfile->kn);
+			kn = cfile->kn;
+			kernfs_get(kn);
 			cfile->notified_at = jiffies;
 		}
 	}
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
+
+	if (kn) {
+		kernfs_notify(kn);
+		kernfs_put(kn);
+	}
 }
 EXPORT_SYMBOL_GPL(cgroup_file_notify);
 
-- 
2.47.3


