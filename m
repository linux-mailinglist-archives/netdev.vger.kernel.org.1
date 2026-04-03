Return-Path: <netdev+bounces-274932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TB4jI/Vyz2n1wQYAu9opvQ
	(envelope-from <netdev+bounces-274932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810DA391DD9
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 082A83026D14
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F416372EE9;
	Fri,  3 Apr 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gAEBdbx5";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gAEBdbx5"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9E329C57
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775202975; cv=none; b=YYIb3mZri4BwV7cHX2QAfdrKm/mxM9IJKjYq/SOlFr91yker4BYrOXKjwNGhVNd4mXY2MrOGGCO7VWr6eQZoTfNwJjptHQNXzYWPUF8l+jtyeZpFqaRKqFHF92LB0fkRSb24hjUzAD8WZjDVisZxMQ9jSmAA6N/XqiQ4AC5RoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775202975; c=relaxed/simple;
	bh=nZpgzqCvViOapjGglYQQYSub1vCtf7xX+dTnB9gteCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLTCido+9DpEzOXNN+KTfYJFfi6cM+OI6iWMO57qYgInpZwJA3t8xSP9OtUHyuIYn9GMMJ1ZzzZdDtYAqgMC+UA5ayo6pmUyJqBE0AVkMHMknINQZ8QRN8x6QZ98nVIi5bKlfCb8gHGeZJCaOvwTNeMYlmFN3JlPi+zDwFroxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gAEBdbx5; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gAEBdbx5; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1BZIZmQm1PROEmwq4VTtieKMcdMgEx9cgRGVsWbtxZY=;
	b=gAEBdbx5z9bEzDWTOnZUcPvSPYPrxkXVsQox0eIs+Aw8XBRzi0y4yqb0aZMpYZdE3gbU0cm3D
	ssOlwUV/cnn8lMgmaVEnLvwOcSwoVWEUhv3r6MuR3i40GPx8gpKCXLlKLbS3qurdbg90LO5VwGp
	NhPWO+qdyumhRjcmQC58/nM=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fn9yH3NRQz1BG15
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:55:51 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1BZIZmQm1PROEmwq4VTtieKMcdMgEx9cgRGVsWbtxZY=;
	b=gAEBdbx5z9bEzDWTOnZUcPvSPYPrxkXVsQox0eIs+Aw8XBRzi0y4yqb0aZMpYZdE3gbU0cm3D
	ssOlwUV/cnn8lMgmaVEnLvwOcSwoVWEUhv3r6MuR3i40GPx8gpKCXLlKLbS3qurdbg90LO5VwGp
	NhPWO+qdyumhRjcmQC58/nM=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fn9qN4gQFz1cyQK;
	Fri,  3 Apr 2026 15:49:52 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 82A1E4056E;
	Fri,  3 Apr 2026 15:56:02 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 15:56:02 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Apr
 2026 15:56:01 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <kernel@openeuler.org>
CC: <tanghui20@huawei.com>, <quzicheng@huawei.com>, <quzicheng315@163.com>,
	Kui-Feng Lee <thinker.li@gmail.com>, <netdev@vger.kernel.org>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, Luo Gengkun <luogengkun2@huawei.com>
Subject: [PATCH OLK-6.6 058/451] bpf, net: switch to dynamic registration
Date: Fri, 3 Apr 2026 07:26:53 +0000
Message-ID: <20260403073326.3096906-59-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403073326.3096906-1-quzicheng@huawei.com>
References: <20260403073326.3096906-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100012.china.huawei.com (7.202.195.195)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274932-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,163.com,gmail.com,vger.kernel.org,kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quzicheng@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 810DA391DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kui-Feng Lee <thinker.li@gmail.com>

mainline inclusion
from mainline-v6.9-rc1
commit f6be98d19985411ca1f3d53413d94d5b7f41c200
category: feature
bugzilla: https://atomgit.com/openeuler/kernel/issues/8335
CVE: NA

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6be98d19985411ca1f3d53413d94d5b7f41c200

----------------------------------------------------------------------

Replace the static list of struct_ops types with per-btf struct_ops_tab to
enable dynamic registration.

Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
instead of being listed in bpf_struct_ops_types.h.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Link: https://lore.kernel.org/r/20240119225005.668602-12-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
---
 include/linux/bpf.h               |  27 +++++---
 include/linux/btf.h               |  12 ++++
 kernel/bpf/bpf_struct_ops.c       | 100 ++++--------------------------
 kernel/bpf/bpf_struct_ops_types.h |  12 ----
 kernel/bpf/btf.c                  |  86 +++++++++++++++++++++++--
 net/bpf/bpf_dummy_struct_ops.c    |  11 +++-
 net/ipv4/bpf_tcp_ca.c             |  12 +++-
 7 files changed, 142 insertions(+), 118 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6eba14c2eb93..0624b33be7a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1827,9 +1827,20 @@ struct bpf_struct_ops_common_value {
 };
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
+/* This macro helps developer to register a struct_ops type and generate
+ * type information correctly. Developers should use this macro to register
+ * a struct_ops type instead of calling __register_bpf_struct_ops() directly.
+ */
+#define register_bpf_struct_ops(st_ops, type)				\
+	({								\
+		struct bpf_struct_ops_##type {				\
+			struct bpf_struct_ops_common_value common;	\
+			struct type data ____cacheline_aligned_in_smp;	\
+		};							\
+		BTF_TYPE_EMIT(struct bpf_struct_ops_##type);		\
+		__register_bpf_struct_ops(st_ops);			\
+	})
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
@@ -1871,16 +1882,12 @@ struct bpf_dummy_ops {
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
+int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+			     struct btf *btf,
+			     struct bpf_verifier_log *log);
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
-{
-	return NULL;
-}
-static inline void bpf_struct_ops_init(struct btf *btf,
-				       struct bpf_verifier_log *log)
-{
-}
+#define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	return try_module_get(owner);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1d852dad7473..79f34103ab5d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -497,6 +497,18 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
 
 struct bpf_verifier_log;
 
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
+struct bpf_struct_ops;
+int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find_value(struct btf *btf, u32 value_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
+#else
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 30ab34fab0f8..defc052e4622 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -62,35 +62,6 @@ static DEFINE_MUTEX(update_mutex);
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
 
-/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
- * the map's value exposed to the userspace and its btf-type-id is
- * stored at the map->btf_vmlinux_value_type_id.
- *
- */
-#define BPF_STRUCT_OPS_TYPE(_name)				\
-extern struct bpf_struct_ops bpf_##_name;			\
-								\
-struct bpf_struct_ops_##_name {					\
-	struct bpf_struct_ops_common_value common;		\
-	struct _name data ____cacheline_aligned_in_smp;		\
-};
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-
-enum {
-#define BPF_STRUCT_OPS_TYPE(_name) BPF_STRUCT_OPS_TYPE_##_name,
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-	__NR_BPF_STRUCT_OPS_TYPE,
-};
-
-static struct bpf_struct_ops_desc bpf_struct_ops[] = {
-#define BPF_STRUCT_OPS_TYPE(_name)				\
-	[BPF_STRUCT_OPS_TYPE_##_name] = { .st_ops = &bpf_##_name },
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-};
-
 const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
 
@@ -145,9 +116,9 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	return true;
 }
 
-static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
-				     struct btf *btf,
-				     struct bpf_verifier_log *log)
+int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+			     struct btf *btf,
+			     struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	const struct btf_member *member;
@@ -161,7 +132,7 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	    sizeof(value_name)) {
 		pr_warn("struct_ops name %s is too long\n",
 			st_ops->name);
-		return;
+		return -EINVAL;
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
@@ -170,13 +141,13 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (type_id < 0) {
 		pr_warn("Cannot find struct %s in %s\n",
 			st_ops->name, btf_get_name(btf));
-		return;
+		return -EINVAL;
 	}
 	t = btf_type_by_id(btf, type_id);
 	if (btf_type_vlen(t) > BPF_STRUCT_OPS_MAX_NR_MEMBERS) {
 		pr_warn("Cannot support #%u members in struct %s\n",
 			btf_type_vlen(t), st_ops->name);
-		return;
+		return -EINVAL;
 	}
 
 	value_id = btf_find_by_name_kind(btf, value_name,
@@ -184,10 +155,10 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (value_id < 0) {
 		pr_warn("Cannot find struct %s in %s\n",
 			value_name, btf_get_name(btf));
-		return;
+		return -EINVAL;
 	}
 	if (!is_valid_value_type(btf, value_id, t, value_name))
-		return;
+		return -EINVAL;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
@@ -196,13 +167,13 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!*mname) {
 			pr_warn("anon member in struct %s is not supported\n",
 				st_ops->name);
-			break;
+			return -EOPNOTSUPP;
 		}
 
 		if (__btf_member_bitfield_size(t, member)) {
 			pr_warn("bit field member %s in struct %s is not supported\n",
 				mname, st_ops->name);
-			break;
+			return -EOPNOTSUPP;
 		}
 
 		func_proto = btf_type_resolve_func_ptr(btf,
@@ -214,7 +185,7 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 					   &st_ops->func_models[i])) {
 			pr_warn("Error in parsing func ptr %s in struct %s\n",
 				mname, st_ops->name);
-			break;
+			return -EINVAL;
 		}
 	}
 
@@ -222,6 +193,7 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (st_ops->init(btf)) {
 			pr_warn("Error in init bpf_struct_ops %s\n",
 				st_ops->name);
+			return -EINVAL;
 		} else {
 			st_ops_desc->type_id = type_id;
 			st_ops_desc->type = t;
@@ -230,54 +202,8 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 								 value_id);
 		}
 	}
-}
 
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
-{
-	struct bpf_struct_ops_desc *st_ops_desc;
-	u32 i;
-
-	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
-#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops_desc = &bpf_struct_ops[i];
-		bpf_struct_ops_desc_init(st_ops_desc, btf, log);
-	}
-}
-
-static const struct bpf_struct_ops_desc *
-bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
-{
-	unsigned int i;
-
-	if (!value_id || !btf)
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i].value_id == value_id)
-			return &bpf_struct_ops[i];
-	}
-
-	return NULL;
-}
-
-const struct bpf_struct_ops_desc *
-bpf_struct_ops_find(struct btf *btf, u32 type_id)
-{
-	unsigned int i;
-
-	if (!type_id || !btf)
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i].type_id == type_id)
-			return &bpf_struct_ops[i];
-	}
-
-	return NULL;
+	return 0;
 }
 
 static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
deleted file mode 100644
index 5678a9ddf817..000000000000
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* internal file - do not include directly */
-
-#ifdef CONFIG_BPF_JIT
-#ifdef CONFIG_NET
-BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
-#endif
-#ifdef CONFIG_INET
-#include <net/tcp.h>
-BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
-#endif
-#endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ecdd08aec7f..1cd7e8fbcc57 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -19,6 +19,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
@@ -5801,8 +5802,6 @@ struct btf *btf_parse_vmlinux(void)
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
-	bpf_struct_ops_init(btf, log);
-
 	refcount_set(&btf->refcnt, 1);
 
 	err = btf_alloc_id(btf);
@@ -8895,11 +8894,13 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
 
+#ifdef CONFIG_BPF_JIT
 static int
-btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
+btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
+		   struct bpf_verifier_log *log)
 {
 	struct btf_struct_ops_tab *tab, *new_tab;
-	int i;
+	int i, err;
 
 	tab = btf->struct_ops_tab;
 	if (!tab) {
@@ -8929,7 +8930,84 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
 
 	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
 
+	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
+	if (err)
+		return err;
+
 	btf->struct_ops_tab->cnt++;
 
 	return 0;
 }
+
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
+{
+	const struct bpf_struct_ops_desc *st_ops_list;
+	unsigned int i;
+	u32 cnt;
+
+	if (!value_id)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	cnt = btf->struct_ops_tab->cnt;
+	st_ops_list = btf->struct_ops_tab->ops;
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i].value_id == value_id)
+			return &st_ops_list[i];
+	}
+
+	return NULL;
+}
+
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find(struct btf *btf, u32 type_id)
+{
+	const struct bpf_struct_ops_desc *st_ops_list;
+	unsigned int i;
+	u32 cnt;
+
+	if (!type_id)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	cnt = btf->struct_ops_tab->cnt;
+	st_ops_list = btf->struct_ops_tab->ops;
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i].type_id == type_id)
+			return &st_ops_list[i];
+	}
+
+	return NULL;
+}
+
+int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct bpf_verifier_log *log;
+	struct btf *btf;
+	int err = 0;
+
+	btf = btf_get_module_btf(st_ops->owner);
+	if (!btf)
+		return -EINVAL;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
+	if (!log) {
+		err = -ENOMEM;
+		goto errout;
+	}
+
+	log->level = BPF_LOG_KERNEL;
+
+	err = btf_add_struct_ops(btf, st_ops, log);
+
+errout:
+	kfree(log);
+	btf_put(btf);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
+#endif
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index ba2c58dba2da..02de71719aed 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -7,7 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
-extern struct bpf_struct_ops bpf_bpf_dummy_ops;
+static struct bpf_struct_ops bpf_bpf_dummy_ops;
 
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
@@ -256,7 +256,7 @@ static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
 	.test_sleepable = bpf_dummy_test_sleepable,
 };
 
-struct bpf_struct_ops bpf_bpf_dummy_ops = {
+static struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
 	.check_member = bpf_dummy_ops_check_member,
@@ -265,4 +265,11 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.unreg = bpf_dummy_unreg,
 	.name = "bpf_dummy_ops",
 	.cfi_stubs = &__bpf_bpf_dummy_ops,
+	.owner = THIS_MODULE,
 };
+
+static int __init bpf_dummy_struct_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_bpf_dummy_ops, bpf_dummy_ops);
+}
+late_initcall(bpf_dummy_struct_ops_init);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index dffd8828079b..8e7716256d3c 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -12,7 +12,7 @@
 #include <net/bpf_sk_storage.h>
 
 /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
-extern struct bpf_struct_ops bpf_tcp_congestion_ops;
+static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static u32 unsupported_ops[] = {
 	offsetof(struct tcp_congestion_ops, get_info),
@@ -345,7 +345,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.release = __bpf_tcp_ca_release,
 };
 
-struct bpf_struct_ops bpf_tcp_congestion_ops = {
+static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.verifier_ops = &bpf_tcp_ca_verifier_ops,
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
@@ -356,10 +356,16 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
 	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
+	.owner = THIS_MODULE,
 };
 
 static int __init bpf_tcp_ca_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_congestion_ops, tcp_congestion_ops);
+
+	return ret;
 }
 late_initcall(bpf_tcp_ca_kfunc_init);
-- 
2.34.1


