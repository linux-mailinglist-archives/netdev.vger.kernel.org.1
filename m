Return-Path: <netdev+bounces-289622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMurNN7dDGrdpAUAu9opvQ
	(envelope-from <netdev+bounces-289622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:02:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D7585664
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C943308EB89
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5566D3EB81D;
	Tue, 19 May 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2lOC/3/"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65F3E8671
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227953; cv=none; b=cuIYVdQSuQPdnhOQIwECjgtHfL7EjlwvLofCuAf19b3UciVx7TGRbF1uRwBID+lKv/QFniPqhm4l0+OafLJ22buz+GEoSe7WPZxTD1ij1Lss/IMr7QccOtHeDQ5G1XEhjzvlZUHM6gwI5h81DPYRnk8qgJBzTcWXcTyDoeqKjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227953; c=relaxed/simple;
	bh=H5zf7hyY5jhHjLE/Um6PIp4ND2nSLp3EuddCQZIZAwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlm+UOXDlTZYtW+7z1gAK5RQUWWNV1edgsVq7tjHxIGXgrSsRB2O97mY+xt65rtlAKx57PtWhIKEmstzGKe/vhVxKZG0tBCAaI3eVqNHsK/dPOVF+M7wAsqqg4UFUJuyOdb6xi9K0EPKjg2CUcBQU88mvYsPKgprG4ixN7S7ZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2lOC/3/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/I6S8Kw28BAahmP437WtXsPWiDEg/SpJL4HlJOaL8M=;
	b=L2lOC/3/L8+LUVnPOV/TD7LY9UayHbWUq6pU7DrtaGzDgC2nnsccBjOZ9+2HhskbA23HCS
	PRX9ubEmN53EyK9VP0LSPs8sPLCtFV9tw2SmMvU4hC8ZQgNOhIYcBUFc94mmUNMNE3q0d+
	HGfZzy7jHqIXpVT/2h1M/LqHgZi9SPM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 03/12] bpf: Add bpf_struct_ops accessor helpers
Date: Tue, 19 May 2026 14:58:10 -0700
Message-ID: <20260519215841.2984970-4-martin.lau@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289622-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 361D7585664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

Add the helper functions bpf_struct_ops_map_kdata(),
bpf_struct_ops_kdata_map_id(), and bpf_struct_ops_map_cfi_stubs()
in bpf_struct_ops.c. They will be called from cgroup.c in the upcoming
patch to create a struct_ops to cgroup attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the caller
in cgroup.c in the upcoming patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h         | 28 +++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 63 ++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a276eada19c4..dbf98741f15b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2136,6 +2136,12 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
 void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
+void *bpf_struct_ops_map_kdata(struct bpf_map *map);
+u32 bpf_struct_ops_kdata_map_id(void *kdata);
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -2200,6 +2206,28 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
 static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 {
 }
+static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	return 0;
+}
+static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+{
+	return false;
+}
+static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+						   struct bpf_map *old_map,
+						   struct bpf_map *expected_old_map)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 28eab24ef0ed..8650a3b88bf6 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1199,7 +1199,33 @@ u32 bpf_struct_ops_id(const void *kdata)
 }
 EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
 
-static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->kvalue.data;
+}
+
+u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	struct bpf_struct_ops_value *kvalue =
+		container_of(kdata, struct bpf_struct_ops_value, data);
+	struct bpf_struct_ops_map *st_map =
+		container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	return st_map->map.id;
+}
+
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->st_ops_desc->st_ops->cfi_stubs;
+}
+
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 
@@ -1252,6 +1278,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	return 0;
 }
 
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+				     struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+
+	if (!old_map)
+		return -ENOLINK;
+	if (expected_old_map && old_map != expected_old_map)
+		return -EPERM;
+
+	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
+	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops_desc != old_st_map->st_ops_desc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map,
 					  struct bpf_map *expected_old_map)
 {
@@ -1270,23 +1316,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
-
 	old_map = st_link->map;
-	if (!old_map) {
-		err = -ENOLINK;
-		goto err_out;
-	}
-	if (expected_old_map && old_map != expected_old_map) {
-		err = -EPERM;
+	err = bpf_struct_ops_link_update_check(new_map, old_map, expected_old_map);
+	if (err)
 		goto err_out;
-	}
 
 	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
-	/* The new and old struct_ops must be the same type. */
-	if (st_map->st_ops_desc != old_st_map->st_ops_desc) {
-		err = -EINVAL;
-		goto err_out;
-	}
 
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
-- 
2.53.0-Meta


