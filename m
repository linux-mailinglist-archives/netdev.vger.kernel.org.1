Return-Path: <netdev+bounces-232713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E359BC082F1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73C9E4FBF39
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D4305062;
	Fri, 24 Oct 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke9Tvx8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48577303CAF
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341360; cv=none; b=uyKNde464eXk9cL5odmsjz/Dlo3dRUpFSlbzMQpOYczliA7pYRLEVRiUZfNVcEGPmncLGqOvPBGURFp8fR9gRP0gbPYqsAd2k1tCWFS4BqpqPXZPjXO5X64skD4aEjFoWuNF9xges+YTDY4YgPnffpevTr/P6IVBdr5BG6Xb4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341360; c=relaxed/simple;
	bh=uC+M8gUGwfPCTFdJ9WVLu8+b7x4W4u3jVcBMibLah2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqz5n8vxIfWewols5VPBmjQJfiO6A+/coXTcvifXs8DDiHDFkpXnGMciEKbsSmmqzxnylgH07A1FtP0J5ewrVFDPZf7dP52tnvjqWiouK1aiNUkwZsgNw42HDjF+XMNrmU0doGI6D7JGl7c28g9KkJx6Tdz1K4eu9aM1LtIKDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke9Tvx8Z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1709365a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761341357; x=1761946157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPirc5bAyB4nG400oeAbIbKSxQdhGkSTpOkKrAO8wMw=;
        b=Ke9Tvx8ZWlmNyoWf4iC4zc5KIYT+B8dTdrChZgIQ9X4HUUaD2m4dnjUFvBR/+KKYCb
         bh2kEvCngHAu9trXnU3naREbNdNDeZZSHSNdqVH1Qz7+/OGGlNN4ItKUtJnZkwjieLNX
         O5alQXVWmONQIQDcvl2+iRZblB0mURwczTDHq/vhUrGw8dzBG9iQRauypZnSDKWzOBN7
         X96uPs9JZvdBSDRpPkfXraNfFbdpTnl1Fp6KphMkAWYE5gTbp99FpenN+bi53jHNLVdn
         UpcrwZqzp8w4dx+Mc4HMbxfhsIMZCVEiBQekhcJSvj96xpDTfGuMlcswwHQd43vdyY59
         qxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341357; x=1761946157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPirc5bAyB4nG400oeAbIbKSxQdhGkSTpOkKrAO8wMw=;
        b=W1DOGyoS+3EC+4a+y4ouBL/2lCi1IzpY4OEknXgwK8yA0DGEhTVlbAVyfzFaihGAg6
         a7Gypo4TFzeTlL1yQjnh+6DiVG70OM3hePPOZGss7+81MaPsMykIRXyerpqoAnNsI9gh
         CeHIH/fgN6agUt5K09YNQDfpgY1PrIrHAvjh6E8sS+PDl8ejYzy9j4m72mLwPMH9DDf7
         fW6daUN4GXa7PglbrOTlzztDl6Jo6H1ugFMWrCFzPSNUQJkxDSGKZCvLbHfrHSakbwEC
         vlzdzdTNpQEFQekRM0J9d56LgCYwTmMr05zcIKOGYWISxw1nSwkowcGIZ4cB3FYLTwT4
         zOVQ==
X-Gm-Message-State: AOJu0YwWEoQAgtY9jigB8GTgvWv6qyNO3f0sqBa1Jm9W1DskKm91E/MJ
	2m6006I8+RzqYFRHCQjhqPpLuDhalJ3UTAR+kENIfAgkGBF5y/OrIx7B
X-Gm-Gg: ASbGncvvV5HCtu63AmToyzmOzXuVo5Vmk8JIIuBEbXjqz7l6WgoopCKYU6RG6ZrLD2L
	oCIjUH64YlswE1iOdJEZtKF/TNmqZlvXSldY6M0Nd4nSdC/VvipMqLKLXUutGa/RoDX1clMcFGZ
	SUfPpXHNCJKHMfm/3qNd98Zr8RGI/9hIZ3fB+P3pvpj8Bx/jCUN4dPY+88E4MkOW/EqPTzk1QyP
	PfMrVxY8yv8oewlKgKqRJsNR6YCcmsSZ7LmPQqNvbHLj9G5pCTPScY98YdYMicR8COGflC1XMpC
	DLbvNn0XJZB/J3dSl/v5ZSECI+YGeDrvwBZWhivJxdBl3HHIXGCqKiiZfyx8qxvBaHbYAQ3CIfZ
	GoX8IXJ03lrX6WgLY3D5P3CnIBPA+0oBHM4dGkhLuCfHFKsNRUx0XHwxixHBFckUUwxvKoTfyt+
	jA
X-Google-Smtp-Source: AGHT+IG6WV8RxdwR1JRL6xJ/EuVJgK3Jqnsw3qTtMBTkyFxY3FGowDZd2i2T9i4NaWdptvzJ5E7ToA==
X-Received: by 2002:a17:903:11ce:b0:290:9da8:f88c with SMTP id d9443c01a7336-290c9ca6b61mr352110335ad.17.1761341357297;
        Fri, 24 Oct 2025 14:29:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27345sm1983775ad.54.2025.10.24.14.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:29:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/6] bpf: Support associating BPF program with struct_ops
Date: Fri, 24 Oct 2025 14:29:10 -0700
Message-ID: <20251024212914.1474337-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024212914.1474337-1-ameryhung@gmail.com>
References: <20251024212914.1474337-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
a BPF program with a struct_ops map. This command takes a file
descriptor of a struct_ops map and a BPF program and set
prog->aux->st_ops_assoc to the kdata of the struct_ops map.

The command does not accept a struct_ops program nor a non-struct_ops
map. Programs of a struct_ops map is automatically associated with the
map during map update. If a program is shared between two struct_ops
maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
associated struct_ops is ambiguous. The pointer, once poisoned, cannot
be reset since we have lost track of associated struct_ops. For other
program types, the associated struct_ops map, once set, cannot be
changed later. This restriction may be lifted in the future if there is
a use case.

A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
the associated struct_ops pointer. The returned pointer, if not NULL, is
guaranteed to be valid and point to a fully updated struct_ops struct.
For struct_ops program reused in multiple struct_ops map, the return
will be NULL. The call must be paired with bpf_struct_ops_put() once the
caller is done with the struct_ops.

To make sure the returned pointer to be valid, the command increases the
refcount of the map for every associated non-struct_ops programs. For
struct_ops programs, since they do not increase the refcount of
struct_ops map, bpf_prog_get_assoc_struct_ops() has to bump the refcount
of the map to prevent a map from being freed while the program runs.
This can happen if a struct_ops program schedules a time callback that
runs after the struct_ops map is freed.

struct_ops implementers should note that the struct_ops returned may or
may not be attached. The struct_ops implementer will be responsible for
tracking and checking the state of the associated struct_ops map if the
use case requires an attached struct_ops.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h            | 16 ++++++
 include/uapi/linux/bpf.h       | 17 ++++++
 kernel/bpf/bpf_struct_ops.c    | 98 ++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  3 ++
 kernel/bpf/syscall.c           | 46 ++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 ++++++
 6 files changed, 197 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..adef02556e95 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	struct bpf_map __rcu *st_ops_assoc;
 };
 
 struct bpf_prog {
@@ -2010,6 +2012,9 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
 
 #ifdef CONFIG_NET
@@ -2057,6 +2062,17 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	return -EOPNOTSUPP;
+}
+static inline void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
+{
+}
+static inline void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	return NULL;
+}
 static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ae83d8649ef1..41cacdbd7bd5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -918,6 +918,16 @@ union bpf_iter_link_info {
  *		Number of bytes read from the stream on success, or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_PROG_ASSOC_STRUCT_OPS
+ * 	Description
+ * 		Associate a BPF program with a struct_ops map. The struct_ops
+ * 		map is identified by *map_fd* and the BPF program is
+ * 		identified by *prog_fd*.
+ *
+ * 	Return
+ * 		0 on success or -1 if an error occurred (in which case,
+ * 		*errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -974,6 +984,7 @@ enum bpf_cmd {
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
+	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
 };
 
@@ -1890,6 +1901,12 @@ union bpf_attr {
 		__u32		prog_fd;
 	} prog_stream_read;
 
+	struct {
+		__u32		map_fd;
+		__u32		prog_fd;
+		__u32		flags;
+	} prog_assoc_struct_ops;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a41e6730edcf..50ed675b4bfd 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -533,6 +533,17 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
+static void bpf_struct_ops_map_dissoc_progs(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->links[i])
+			break;
+		bpf_prog_disassoc_struct_ops(st_map->links[i]->prog);
+	}
+}
+
 static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
 {
 	int i;
@@ -801,6 +812,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		err = bpf_prog_assoc_struct_ops(prog, &st_map->map);
+		if (err) {
+			bpf_prog_put(prog);
+			goto reset_unlock;
+		}
+
 		link = kzalloc(sizeof(*link), GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -980,6 +997,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
+	bpf_struct_ops_map_dissoc_progs(st_map);
+
 	bpf_struct_ops_map_del_ksyms(st_map);
 
 	/* The struct_ops's function may switch to another struct_ops.
@@ -1173,6 +1192,7 @@ void bpf_struct_ops_put(const void *kdata)
 
 	bpf_map_put(&st_map->map);
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_put);
 
 u32 bpf_struct_ops_id(const void *kdata)
 {
@@ -1394,6 +1414,84 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	struct bpf_map *st_ops_assoc;
+
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	st_ops_assoc = rcu_access_pointer(prog->aux->st_ops_assoc);
+
+	if (st_ops_assoc && st_ops_assoc == map)
+		return 0;
+
+	if (st_ops_assoc) {
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			return -EBUSY;
+
+		rcu_assign_pointer(prog->aux->st_ops_assoc, BPF_PTR_POISON);
+	} else {
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			bpf_map_inc(map);
+
+		rcu_assign_pointer(prog->aux->st_ops_assoc, map);
+	}
+
+	return 0;
+}
+
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
+{
+	struct bpf_map *st_ops_assoc;
+
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	st_ops_assoc = rcu_access_pointer(prog->aux->st_ops_assoc);
+
+	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+		return;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		bpf_map_put(st_ops_assoc);
+
+	RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL);
+}
+
+/*
+ * Get a reference to the struct_ops struct (i.e., kdata) associated with a
+ * program. Must be paired with bpf_struct_ops_put().
+ *
+ * If the returned pointer is not NULL, it must points to a valid and
+ * initialized struct_ops. The struct_ops may or may not be attached.
+ * Kernel struct_ops implementers are responsible for tracking and checking
+ * the state of the struct_ops if the use case requires an attached struct_ops.
+ */
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+
+	scoped_guard(rcu) {
+		map = rcu_dereference(aux->st_ops_assoc);
+		if (!map || map == BPF_PTR_POISON)
+			return NULL;
+
+		map = bpf_map_inc_not_zero(map);
+		if (IS_ERR(map))
+			return NULL;
+	}
+
+	st_map = (struct bpf_struct_ops_map *)map;
+
+	if (smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_INIT) {
+		bpf_map_put(map);
+		return NULL;
+	}
+
+	return &st_map->kvalue.data;
+}
+EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
+
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..441bfeece377 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -136,6 +136,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->used_maps_mutex);
 	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
+	mutex_init(&fp->aux->st_ops_assoc_mutex);
 
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_prog_stream_init(fp);
@@ -286,6 +287,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	if (fp->aux) {
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
+		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
@@ -2875,6 +2877,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
+	bpf_prog_disassoc_struct_ops(aux->prog);
 	if (bpf_prog_is_dev_bound(aux))
 		bpf_prog_dev_bound_destroy(aux->prog);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a48fa86f82a7..c40fc1e50934 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6092,6 +6092,49 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD prog_assoc_struct_ops.prog_fd
+
+static int prog_assoc_struct_ops(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	int ret;
+
+	if (CHECK_ATTR(BPF_PROG_ASSOC_STRUCT_OPS))
+		return -EINVAL;
+
+	if (attr->prog_assoc_struct_ops.flags)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_assoc_struct_ops.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		ret = -EINVAL;
+		goto put_prog;
+	}
+
+	map = bpf_map_get(attr->prog_assoc_struct_ops.map_fd);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto put_prog;
+	}
+
+	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
+		ret = -EINVAL;
+		goto put_map;
+	}
+
+	ret = bpf_prog_assoc_struct_ops(prog, map);
+
+put_map:
+	bpf_map_put(map);
+put_prog:
+	bpf_prog_put(prog);
+	return ret;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -6231,6 +6274,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_STREAM_READ_BY_FD:
 		err = prog_stream_read(&attr);
 		break;
+	case BPF_PROG_ASSOC_STRUCT_OPS:
+		err = prog_assoc_struct_ops(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ae83d8649ef1..41cacdbd7bd5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -918,6 +918,16 @@ union bpf_iter_link_info {
  *		Number of bytes read from the stream on success, or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_PROG_ASSOC_STRUCT_OPS
+ * 	Description
+ * 		Associate a BPF program with a struct_ops map. The struct_ops
+ * 		map is identified by *map_fd* and the BPF program is
+ * 		identified by *prog_fd*.
+ *
+ * 	Return
+ * 		0 on success or -1 if an error occurred (in which case,
+ * 		*errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -974,6 +984,7 @@ enum bpf_cmd {
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
+	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
 };
 
@@ -1890,6 +1901,12 @@ union bpf_attr {
 		__u32		prog_fd;
 	} prog_stream_read;
 
+	struct {
+		__u32		map_fd;
+		__u32		prog_fd;
+		__u32		flags;
+	} prog_assoc_struct_ops;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.47.3


