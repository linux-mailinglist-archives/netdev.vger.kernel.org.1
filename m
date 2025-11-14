Return-Path: <netdev+bounces-238794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC408C5F7F8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DAAF35E58B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F535C185;
	Fri, 14 Nov 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQZTGGBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5E3557F3
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158668; cv=none; b=o8U2rRIXfQZXlmJT0VyeNwlxVryP0K5QUhhr/I9Njx1KFdOpXG48CeOLXrHukSHmG9YHoBzNF/yvOgJCcOS1xKHNLVreH/06Y3W+SjjHzUx70SPXaXFl2zhE321elW4gqyobfy9eVDNnvxxfRf45cgySPLtvZSsGvbDctHbW9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158668; c=relaxed/simple;
	bh=yzJrqNCZ/MpnBnb7orY1dpf+O/uvDQZfucTvc/Z/5ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIw7kjiJ8o/RZRI5FvDLaoanUVWWEfpCVmpknnsJGOTgqckD4Gw0VknUcprX89GlJwNpCcK4qzGfNKl3xpzEXVHPnzELKzgPbRxLimaB/lSEhuLTH1anss2CoTOCYILimfMMeClzDS8qpdJeWRRlPNvjEYOOAonhf9d5ZYVXPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQZTGGBo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so2216795b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158666; x=1763763466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqP1Q40MR4KaZOzM1erW+/SW0PoCv0wYQPGCH2ksTEg=;
        b=WQZTGGBorXp5rF8HxHkgmNImHGJdx7O4X/ygeathiE0jHc0Tx3esd01YPcPfH9IDyf
         kox2l2uap6cf8b2uNATtei1m5pGh+MeLO5T5n0Sv6zmy8AwP0Ao8puOSa4X6RTJccVPJ
         rVfXb6P7CfK9R4EtWAqEi911RMNDJPRaX1elgfw/0drDFhfQFkWjxO8ZOSj67rpI8TOF
         OdDX9EbpEk5HkhIjXEG6qI7zi4Mj7EoC3tJt1zNcJEAg62RAKSHQcPEMPhKu+HCEbZ0r
         +AV3se7zFwVg4tlkn6b3cnE9c1q7NqKW2fqzA/9oQ9FYxcHkzbPogGWYOaweAkxUUlTJ
         mbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158666; x=1763763466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqP1Q40MR4KaZOzM1erW+/SW0PoCv0wYQPGCH2ksTEg=;
        b=aJCHHwaLOkSo4EwK8JMT+QGTSF+D2Noab7j4eAjATIZknnivU9vmvLZYBcTn+3ACA2
         iIMGyEVrebDhZlKYH+TF/ghybDoCz8UD1Z667z8voLpNB20R+MZMWcHSUFE9tPEbGwuy
         5miwTvsTrxO3Cw6zAErw+3rq9vQPhJovrGHWGA1Bzem8KUEC21MlifdkcMKqQJJ4yzRB
         HTBKEQfe3eloWVy8sjiyVPv4TVxi0vTUBFAkwdJoDR9Fx3MrqtAUugylincn3kMK0hqu
         b6ZoTzk1y3sb+/3CZuE8bDNHXF5PLLkgvAGQ8xFKu98DZIkeFipVKfiKE5czKp4Ih85Y
         FAnQ==
X-Gm-Message-State: AOJu0Yw77+2vSPLTvjC1ElG+BRL/+o5m64pNXiYBzGkm+Kwj9ut2zryK
	dbQrln6rpdw6p0/nvfiMy0xjPdDmHVm+90s9phXJbAyt/erieRvSNk6fbd0PwA==
X-Gm-Gg: ASbGnctsKViQP+J3L6ngjV4TeNCc47P7fpkNq9xuk0ek9S0ikO9RrFX2D0M7HxG5IWF
	TRhLChCvsir8c9fMltRnvhYrpZ1vc9Gbdt7efM4yE2dhN9V27EUJ/pnAiQCwGbESxSqKsjYmLAw
	tjftdVe6MOkF6jnKjAiY8Lqgdtjb7IcJ0XnyAg3/ywXDqueeWfxX8BegvsF1Z4MSCi4J88Fu8ec
	0cQZ1Pg8Ql9aKXYuknFzb5zNwtbc4e+Vlu0rhCv5VJrnWMs5zsCrO7lDX396lENdyjZClrBqxeu
	jGmBwy3dTNKOZAi0Vbt4sagnwyZLu5+u0GhNWihyee1FM5EeqYgNoJaC/ppJH2USDwuwrrg8g9F
	t0rUWlr9EgAlwjWCfCJ9mquqKfmC+SZX9jfKmzGE4fNNPEQgb+u0dWZaCVEwv245zjL5HK9bKVR
	9cKiWTYu/vYrlP
X-Google-Smtp-Source: AGHT+IFN1vf06Q353dejMCrQ4p7nuSvuqr/tW547HC7RnhlZEKBBU43F19046OTVGkVQ1RLJEA9QwQ==
X-Received: by 2002:a05:6a00:4fc5:b0:7b9:3031:7294 with SMTP id d2e1a72fcca58-7ba3b0a8afdmr5010575b3a.22.1763158666144;
        Fri, 14 Nov 2025 14:17:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251d31c8sm6063909b3a.30.2025.11.14.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:45 -0800 (PST)
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
Subject: [PATCH bpf-next v6 3/6] libbpf: Add support for associating BPF program with struct_ops
Date: Fri, 14 Nov 2025 14:17:38 -0800
Message-ID: <20251114221741.317631-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
command in the bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 89 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b66f5fbfbbb2..21b57a629916 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
+			      struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_assoc_struct_ops);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_assoc_struct_ops.map_fd = map_fd;
+	attr.prog_assoc_struct_ops.prog_fd = prog_fd;
+	attr.prog_assoc_struct_ops.flags = OPTS_GET(opts, flags, 0);
+
+	err = sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..1f9c28d27795 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,27 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_prog_assoc_struct_ops_opts {
+	size_t sz;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_prog_assoc_struct_ops_opts__last_field flags
+
+/**
+ * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param prog_fd FD for the BPF program
+ * @param map_fd FD for the struct_ops map to be associated with the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
+					 struct bpf_prog_assoc_struct_ops_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fbe74686c97d..98ec63947fc9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13891,6 +13891,37 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	return 0;
 }
 
+int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+				  struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	int prog_fd, map_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't associate BPF program without FD (was it loaded?)\n",
+			prog->name);
+		return -EINVAL;
+	}
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
+		return -EINVAL;
+	}
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0) {
+		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
+		return -EINVAL;
+	}
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
+		return -EINVAL;
+	}
+
+	return bpf_prog_assoc_struct_ops(prog_fd, map_fd, opts);
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err = 0, n, len, start, end = -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..8866e5bf7b0c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1003,6 +1003,22 @@ LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
 
+struct bpf_prog_assoc_struct_ops_opts; /* defined in bpf.h */
+
+/**
+ * @brief **bpf_program__assoc_struct_ops()** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param prog BPF program
+ * @param map struct_ops map to be associated with the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0, on success; negative error code, otherwise
+ */
+LIBBPF_API int
+bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+			      struct bpf_prog_assoc_struct_ops_opts *opts);
+
 /**
  * @brief **bpf_object__find_map_by_name()** returns BPF map of
  * the given name, if it exists within the passed BPF object
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..84fb90a016c9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,6 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_prog_assoc_struct_ops;
+		bpf_program__assoc_struct_ops;
 } LIBBPF_1.6.0;
-- 
2.47.3


