Return-Path: <netdev+bounces-228558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14CFBCE27F
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 19:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C62582DA1
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046B2F5487;
	Fri, 10 Oct 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1ZEOlRK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EE2727F2
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118599; cv=none; b=A61uo6WN4UcYyojFmRoSKsHkIaYd6MH5Wt/xuR9oqvIP2NX1XPwCBVtHz/ZaY39kYzPXSIZ+Y5iaIoCL6IV8kOg7L7DXoq/GKbTwu0RSi/d1u1K0vH1HsiqGsE4118wrtDHPTFgeTI4eB+t9UDcEBz46FFOQHvrAS2cuACAEEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118599; c=relaxed/simple;
	bh=5dBOQFnQtODU4h0sM91kpcehMUzV/NFRwhDlYCmjt/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvlPnJQXl8fMlIlbZUXVxrFoWjFTSdrL/L29wnSnmdXusBC32RKy4Ulg9lN99qFY6WS4Q4D6ZZvcRt78of10w1Y+10ePpApXhnnUEksPAe49hUIhui8q+734NCNLm3mBhlNfXtQFd2rm9m5dgl+d4alNrw2Do3GrSdXIaqwT73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1ZEOlRK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811fa91774so2107462b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118597; x=1760723397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tn7ao2X5w+N7sqBpLk7Z5g+G/8b4Z5Zja/ynJOgVq4=;
        b=L1ZEOlRKRv+bBNUFuL2TRp6LFERXaix4y2Ijtu5r5Y2hYGrlcAw1PFAVMo4durn6Ti
         YNStYbktvhMrk1kurCkEbOq/hpGJGiF/8P6x1gq5oTP932hTJI+p8kN/lijYsGYUkET7
         yztqWroG6588Tl/ZgrAAKvwCTrkMzbKpGJMdTNW1wYVNBznvikIPZshTmC7BiA4IP6sc
         Bws7aNmfngPLf2yhTqBLl5xH6eTjo1J+PQGJfLAtMuNa6Te7eW1L5+rYIu69uTb7Lsib
         QZvOc+Z41rlcSReEjXrxEZBNSpUFqAO78keeI9wQYSUOw9Hgxo+ajLB6qR6UVKzyc6pL
         byVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118597; x=1760723397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tn7ao2X5w+N7sqBpLk7Z5g+G/8b4Z5Zja/ynJOgVq4=;
        b=m6nIFt+PRADmqizAD3oukVPK6GDa113dvLA4jdQ1cOBNXwHeqoaqYLt2x6jTvVT3sA
         sQMRrD82A6P1pLaU6yKwSrvObMWNUDSjL2u/BThWkxqvKSAPljJUI4Ko2DW7DJRBGOJ1
         fxFru3MRzaNUHBDjwVxZY+Tr0ZcXChiTPBVXiTwj9g0i8QBuBa4Gt1tGMZxihYBZhtWZ
         yvlbYW7DMSi+NGF9f2zbNGu9+SEwqNJzlQ+u2yWQ5tkG9i7teNlZXsexGsX+mS5/Pj8Q
         jeSqhIU36jF/kCmZVPEJeu4X7tG7Qakkqs4TyUUqmnLzilCexddlzNd/gHA5uVuy7Lja
         HFDQ==
X-Gm-Message-State: AOJu0YwJTk7t7AOnuHBJv6hiyvtOdUCIRQO9uqhPsH6WICaI6HZNslwg
	YljVz5XphpaRbqzYnKY4YsN32fO7zTpdNzXPcFM+jqzgYWFGCd2vgeYp
X-Gm-Gg: ASbGncuHkTsbGe9u8Xc8cfOwIkgC80d77qUO4kQIR8wPPsYg97EHtmuuXUrvwzPd1Ne
	I2UVz3CM12gvALniQ+ghbT1ZO+Wow1Nc708+x777rEIqQmOyU98xuHZWWM4qxjygT6vheHjOAev
	A3SSEqvCVM81INHFfCaAdfv1XOASViBAuSnISx3auKkdhbYhDMjPVepqjMS1sPngVmp/t3dkkWk
	PRfm0OqOoy9xNelYQiKOIgO8NKBZuOJyh/xW2ZxOtQGljpgO1Qn7SjjerNYIwHcpOZ82yAne/lO
	4AA+fwMrw/bYv+nwWqCPMg8/kh8r3Bnz414P/FoI0GM2BJ2oZd3CSq1v5PhWioR2Aduw4Xvy+R/
	MsjKRGeFiskFEVqMhsePEgmaU3dsh/jelC2m597Vp7w==
X-Google-Smtp-Source: AGHT+IGShqb5QDetyprvRr6hj0ayb3dg2fSi8b0/qYblMxKUUw4WetwgKyldNJVZKode/TXRljYqGw==
X-Received: by 2002:a05:6a00:8d3:b0:78c:99a8:bc80 with SMTP id d2e1a72fcca58-79382b73ad3mr15730978b3a.0.1760118596378;
        Fri, 10 Oct 2025 10:49:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8135sm3519421b3a.68.2025.10.10.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:55 -0700 (PDT)
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
Subject: [RFC PATCH v1 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
Date: Fri, 10 Oct 2025 10:49:51 -0700
Message-ID: <20251010174953.2884682-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010174953.2884682-1-ameryhung@gmail.com>
References: <20251010174953.2884682-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to allow associating
a BPF program with a struct_ops. This command takes a file descriptor of
a struct_ops map and a BPF program and set prog->aux->st_ops_assoc to
the kdata of the struct_ops map.

The command does not accept a struct_ops program or a non-struct_ops
map. Programs of a struct_ops map is automatically associated with the
map during map update. If a program is shared between two struct_ops
maps, the first one will be the map associated with the program. The
associated struct_ops map, once set cannot be changed later. This
restriction may be lifted in the future if there is a use case.

Each associated programs except struct_ops programs of the map will take
a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set,
is always valid. However, it is not guaranteed whether the map members
are fully updated nor is it attached or not. For example, a BPF program
can be associated with a struct_ops map before map_update. The
struct_ops implementer will be responsible for maintaining and checking
the state of the associated struct_ops map before accessing it.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h            | 11 ++++++++++
 include/uapi/linux/bpf.h       | 16 ++++++++++++++
 kernel/bpf/bpf_struct_ops.c    | 32 ++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  6 ++++++
 kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
 6 files changed, 119 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..d5052745ffc6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	void *st_ops_assoc;
 };
 
 struct bpf_prog {
@@ -2010,6 +2012,8 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+int bpf_struct_ops_assoc_prog(struct bpf_map *map, struct bpf_prog *prog);
+void bpf_struct_ops_disassoc_prog(struct bpf_prog *prog);
 u32 bpf_struct_ops_id(const void *kdata);
 
 #ifdef CONFIG_NET
@@ -2057,6 +2061,13 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
 {
 	return -EOPNOTSUPP;
 }
+static inline void bpf_struct_ops_assoc_prog(struct bpf_map *map, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+static inline void bpf_struct_ops_disassoc_prog(struct bpf_prog *prog)
+{
+}
 static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ae83d8649ef1..1e76fa22dd61 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -918,6 +918,16 @@ union bpf_iter_link_info {
  *		Number of bytes read from the stream on success, or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_STRUCT_OPS_ASSOCIATE_PROG
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
+	BPF_STRUCT_OPS_ASSOCIATE_PROG,
 	__MAX_BPF_CMD,
 };
 
@@ -1890,6 +1901,11 @@ union bpf_attr {
 		__u32		prog_fd;
 	} prog_stream_read;
 
+	struct {
+		__u32		map_fd;
+		__u32		prog_fd;
+	} struct_ops_assoc_prog;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a41e6730edcf..e57428e1653b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	for (i = 0; i < st_map->funcs_cnt; i++) {
 		if (!st_map->links[i])
 			break;
+		bpf_struct_ops_disassoc_prog(st_map->links[i]->prog);
 		bpf_link_put(st_map->links[i]);
 		st_map->links[i] = NULL;
 	}
@@ -801,6 +802,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		/* Don't stop a program from being reused. prog->aux->st_ops_assoc
+		 * will point to the first struct_ops kdata.
+		 */
+		bpf_struct_ops_assoc_prog(&st_map->map, prog);
+
 		link = kzalloc(sizeof(*link), GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -1394,6 +1400,32 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_struct_ops_assoc_prog(struct bpf_map *map, struct bpf_prog *prog)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	void *kdata = &st_map->kvalue.data;
+	int ret = 0;
+
+	mutex_lock(&prog->aux->st_ops_assoc_mutex);
+
+	if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc != kdata) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	prog->aux->st_ops_assoc = kdata;
+out:
+	mutex_unlock(&prog->aux->st_ops_assoc_mutex);
+	return ret;
+}
+
+void bpf_struct_ops_disassoc_prog(struct bpf_prog *prog)
+{
+	mutex_lock(&prog->aux->st_ops_assoc_mutex);
+	prog->aux->st_ops_assoc = NULL;
+	mutex_unlock(&prog->aux->st_ops_assoc_mutex);
+}
+
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..bf9110a82962 100644
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
@@ -2875,6 +2877,10 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
+	if (aux->st_ops_assoc) {
+		bpf_struct_ops_put(aux->st_ops_assoc);
+		bpf_struct_ops_disassoc_prog(aux->prog);
+	}
 	if (bpf_prog_is_dev_bound(aux))
 		bpf_prog_dev_bound_destroy(aux->prog);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a48fa86f82a7..1d7946a8208c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6092,6 +6092,41 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_STRUCT_OPS_ASSOCIATE_PROG_LAST_FIELD struct_ops_assoc_prog.prog_fd
+
+static int struct_ops_assoc_prog(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	int ret;
+
+	if (CHECK_ATTR(BPF_STRUCT_OPS_ASSOCIATE_PROG))
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->struct_ops_assoc_prog.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	map = bpf_map_get(attr->struct_ops_assoc_prog.map_fd);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto out;
+	}
+
+	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
+	    prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = bpf_struct_ops_assoc_prog(map, prog);
+out:
+	if (ret && !IS_ERR(map))
+		bpf_map_put(map);
+	bpf_prog_put(prog);
+	return ret;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -6231,6 +6266,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_STREAM_READ_BY_FD:
 		err = prog_stream_read(&attr);
 		break;
+	case BPF_STRUCT_OPS_ASSOCIATE_PROG:
+		err = struct_ops_assoc_prog(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ae83d8649ef1..1e76fa22dd61 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -918,6 +918,16 @@ union bpf_iter_link_info {
  *		Number of bytes read from the stream on success, or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_STRUCT_OPS_ASSOCIATE_PROG
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
+	BPF_STRUCT_OPS_ASSOCIATE_PROG,
 	__MAX_BPF_CMD,
 };
 
@@ -1890,6 +1901,11 @@ union bpf_attr {
 		__u32		prog_fd;
 	} prog_stream_read;
 
+	struct {
+		__u32		map_fd;
+		__u32		prog_fd;
+	} struct_ops_assoc_prog;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.47.3


