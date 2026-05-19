Return-Path: <netdev+bounces-289628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FDRK0DeDGrdpAUAu9opvQ
	(envelope-from <netdev+bounces-289628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:03:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 240835856BA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8144B30C0CD8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436903ECBD8;
	Tue, 19 May 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WBFnxxit"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547933EBF39
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227959; cv=none; b=nv0iYFpG3d7xnaE3CxrCRfJxkGtDr/pHcrpOO74dfyvmXM2BlBp4LGbbkS2ANQ0NXDBIImQu8OQ52jjivKV0WFXjTrwO+sLBSKWPQdz/T+kmlBDP0gORelgHR1mGmyk8lEWwP1rrr5Ju8rQSpC2UvLcd//qKUvdI7kX+FTzB70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227959; c=relaxed/simple;
	bh=aZZkWhSHX52yDw3XSL3msERIjCH6hTFfjbldsSXHwlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpO2lgVmRloomf7ZC9npfjB421jac7TNk8BxQL8OKrOINNAZuAaDARGcXuUGuumc2drYyIr5qWCXTk8x1GML+yiesYf0qNPikKn/v4gVNF6YdUIi4F9J2Tv4jmbLOAYlj/BxhUw6I6+y7gePlJVRKo+Nmm/1Znnb76kTGykQK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WBFnxxit; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/ZyR79Udwb5EOLYdvkdM+ndNI0CiUsePdopgrjluqw=;
	b=WBFnxxitLDcMWkDeGwkQ6lTpQ/mvqAw1+4fZB55QJV78Sf80unzBzXoe0mv3ealeK+AuuQ
	aw8Jts2Q0BA0jZTW/fgIj3rOAFwGiUV2fUgI/Dl1HwLtR4dI7xKUh0HKmkbuE0xp1LlNQE
	8KxmU2RvFAT4p/8GrRdUpb9pOmZSd5I=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 08/12] bpf: Add a few bpf_cgroup_array_* helper functions
Date: Tue, 19 May 2026 14:58:15 -0700
Message-ID: <20260519215841.2984970-9-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289628-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 240835856BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

In the upcoming patch, the array can store a struct_ops map.
The array could have a cfi_stubs acting as a dummy instead of
the dummy_bpf_prog. The array logic will need to skip the cfi_stubs
also in order to support storing struct_ops map in the array.

bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
bpf_cgroup_array_delete_safe_at() are added as a preparation work
to allow skipping the cfi_stubs in the upcoming patch. This patch
only skips the dummy_bpf_prog which is the same as the existing behavior.
The current bpf_prog_array_*() callers are changed to call the new
bpf_cgroup_array_*(). This is a no-op change.

Unlike bpf_prog_array_copy_to_user(), bpf_cgroup_array_copy_to_user()
does not need a temporary buffer. The cgroup caller already holds
cgroup_mutex and dereferences the effective array with
rcu_dereference_protected(), so it does not copy to userspace
from an RCU read-side critical section. Details in commit 0911287ce32b.

Another addition is the bpf_cgroup_array_free(). This prepares
the array to have a different rcu gp for the struct_ops use case,
for example, a struct_ops could have mix of sleepable ops and
non-sleepable ops. In this patch, bpf_cgroup_array_free() only
goes through the regular rcu gp. This is a no-op change also.

bpf_prog_dummy() is also added to return the global dummy_bpf_prog.

bpf_cgroup_array_dummy() is added to decide the sentinel based on atype.
It now always returns bpf_prog_dummy(). In the upcoming patch,
it can return a cfi_stubs if the atype belongs to a struct_ops.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/cgroup.c | 79 +++++++++++++++++++++++++++++++++++++++------
 kernel/bpf/core.c   |  5 +++
 3 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dbf98741f15b..26d641300f30 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2443,6 +2443,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *include_prog,
 			u64 bpf_cookie,
 			struct bpf_prog_array **new_array);
+struct bpf_prog *bpf_prog_dummy(void);
 
 struct bpf_run_ctx {};
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b5769f5401e6..a033aa479ab6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -298,6 +298,67 @@ static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 	link->cgroup = NULL;
 }
 
+static void bpf_cgroup_array_free(struct bpf_prog_array *array)
+{
+	if (!array || array == &bpf_empty_prog_array)
+		return;
+	kfree_rcu(array, rcu);
+}
+
+static void *bpf_cgroup_array_dummy(enum cgroup_bpf_attach_type atype)
+{
+	return bpf_prog_dummy();
+}
+
+static int bpf_cgroup_array_length(struct bpf_prog_array *array,
+				   enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+	int cnt = 0;
+
+	for (item = array->items; item->prog; item++)
+		if (item->prog != bpf_cgroup_array_dummy(atype))
+			cnt++;
+
+	return cnt;
+}
+
+static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
+					 __u32 __user *prog_ids, int cnt,
+					 enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+	int i = 0;
+	u32 id;
+
+	for (item = array->items; item->prog && i < cnt; item++) {
+		if (item->prog == bpf_cgroup_array_dummy(atype))
+			continue;
+		id = item->prog->aux->id;
+		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
+			return -EFAULT;
+		i++;
+	}
+	return item->prog ? -ENOSPC : 0;
+}
+
+static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
+					   int index, enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_prog_array_item *item;
+
+	for (item = array->items; item->prog; item++) {
+		if (item->prog == bpf_cgroup_array_dummy(atype))
+			continue;
+		if (!index) {
+			WRITE_ONCE(item->prog, bpf_cgroup_array_dummy(atype));
+			return 0;
+		}
+		index--;
+	}
+	return -ENOENT;
+}
+
 /**
  * cgroup_bpf_release() - put references of all bpf programs and
  *                        release all cgroup bpf data
@@ -335,7 +396,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		bpf_prog_array_free(old_array);
+		bpf_cgroup_array_free(old_array);
 	}
 
 	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
@@ -509,7 +570,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_cgroup_array_free(old_array);
 }
 
 /**
@@ -549,7 +610,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_cgroup_array_free(arrays[i]);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -604,7 +665,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
 			if (unlikely(desc->bpf.inactive)) {
-				bpf_prog_array_free(desc->bpf.inactive);
+				bpf_cgroup_array_free(desc->bpf.inactive);
 				desc->bpf.inactive = NULL;
 			}
 			continue;
@@ -623,7 +684,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_cgroup_array_free(desc->bpf.inactive);
 		desc->bpf.inactive = NULL;
 	}
 
@@ -1124,7 +1185,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 				lockdep_is_held(&cgroup_mutex));
 
 		/* Remove the program from the array */
-		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
+		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
 			  "Failed to purge a prog from array at index %d", pos);
 	}
 }
@@ -1254,7 +1315,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			total_cnt += bpf_prog_array_length(effective);
+			total_cnt += bpf_cgroup_array_length(effective, atype);
 		} else {
 			total_cnt += prog_list_length(&cgrp->bpf.progs[atype], NULL);
 		}
@@ -1283,8 +1344,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		if (effective_query) {
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
-			cnt = min_t(int, bpf_prog_array_length(effective), total_cnt);
-			ret = bpf_prog_array_copy_to_user(effective, prog_ids, cnt);
+			cnt = min_t(int, bpf_cgroup_array_length(effective, atype), total_cnt);
+			ret = bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index cdbe9fdf474f..7afca37fa315 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2729,6 +2729,11 @@ void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
 	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
 }
 
+struct bpf_prog *bpf_prog_dummy(void)
+{
+	return &dummy_bpf_prog.prog;
+}
+
 int bpf_prog_array_length(struct bpf_prog_array *array)
 {
 	struct bpf_prog_array_item *item;
-- 
2.53.0-Meta


