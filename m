Return-Path: <netdev+bounces-230612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9ABEBDD9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A85E2059
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B73328EC;
	Fri, 17 Oct 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMHQkHe0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD3311953
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738194; cv=none; b=WM/Bh+zTbaw4oVOvKrn9Chm2K5d8Bbs4oNA79kOSDFnoAOp223h/L/xKz+6st5LuFviH2YOR/cXA949APQKS/Xxf4Zk2Fc/1cZkqRhvsLFX6W1EZMDUX7JhD5x9WIBH1JyyFrGXMoe4y56jEoYOfXcLc25KfC4ApdXhZtT/QMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738194; c=relaxed/simple;
	bh=S5Gzkjv488/zqDjuIQgbuI3sfyK2bPsTljuP4qYvWPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRawkAZv0OIODfnJnEl5BPYLcOOH8Hb9jJeOoCeUdZP6xYckypeQSjoudJpXH74vWmXBzsyCF2HnL3rBVFcIbkRRnQAeBg5OnA+P9mjRU+rIPt8vDzynmI7hgS5KHgSW+kGeomdpaHw9kCIFM95fhnXxV+5sWBcFdkEnVagFovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMHQkHe0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33be037cf73so1144170a91.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738192; x=1761342992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkHFoq6KcBx33ONImwz70GoNCu2uqRDaYEwP8Pqmg4o=;
        b=FMHQkHe0tGLcNa6RnbL8+0H2H+wGdJBiUS0zxxpyIAZXiC6brbagVlttcBFgkLAJbi
         CVHI53qcy4PKfUb4oJJcWF5t38TkIX8krcoD+ZD7sbYI38rN5+r4tERc7VU9Ogu+9bXC
         2Rt2d8zFjCIz5Znd+POAdA+bSuzzwtn57FWbvnAkZIJgPrprzsrWyM3/eTMxuy2H8DlW
         dyGYeeoL0UQ/PLc5aOFwJsuycUFuxbL6V1ObH3tbCqBmutA+ZztcSH/pVjBY8BJfmegR
         NF/aXeg6YIgmraJDWH/ST9HHAT1tG0QVDklGDp1DsX5TYvGTTZejEKfBlEY2ORJCJimm
         KxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738192; x=1761342992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkHFoq6KcBx33ONImwz70GoNCu2uqRDaYEwP8Pqmg4o=;
        b=DJj/lI0G6XloPI58ZErOeHzkX4GAjxA/6YTD5jSRfyk1tjZbQ/FMwli8uGWDeQtSov
         McKrgQ6GXOwuMMZo6K8Ew7AzvWwfM4JzIrHzVxh0y+p3t79eBDATTguEOWIidQ3/Nd3S
         xa0MIdKSwZp4tVxOWuK5ScDLJwPtV1OGT8p10Tx3sbkKBYhUEymK5Aawo+McCiLgtJPH
         mgwZoUSlsfMSEx9S3WheC6Tna0lFyKg/k65XPOzq+QrUhBh9CLQ1QTkZwLT3gQWCsYJ8
         LDhwXwvpAY4oDEVGER+T9JHW3wZXkLKbQ53tkqvDLoAdo7rIuuVY0YenKYsNZMAgxvib
         4jFQ==
X-Gm-Message-State: AOJu0YzdCw5DqMcZzaPYuW/8ZE/SeRW4sdJqYFQ9vwFdXKr4/HNcRhvq
	oguMaQ9Fp+EAxP6q2EHLh/FM50L0M32Qsx/qjolu24iAxAdvW+Dkwy+A
X-Gm-Gg: ASbGncvRzMTLF5Ijtym1OZ8+QPC1wf4LumHTEg1kf4h5TTMFYO7RfIeOozf725md15P
	7iPomBPgpQ+siTgR3t5pwqxGCEvX7tsadggzUTJuGNivgQpjEjUPdF4ayrcKNvJ4TZg2bBMGe40
	ZjUGOI0vScDAEoz0ykvE4CJ8UyaDKsspRFHTglOou0JB79yd850knRR3egovoss9wEK8ryJiDxH
	nkbMo3PfD8S+r+41ys3GujgEBPVB7kVI2G0e0Oepc5bHIEXmpHvQkQkqMMsqAh2SJRfGtgF9AxY
	z89LVVGnn65B5vJxrcN1vtZRmFy8SSN194hH1jBaBkz4BqrT3O2zN6jzJ5p+2zIFL8M+R8CIQnb
	+Y1+eRwrEi93Ov6IudMuhDTUox8AA8GkiF3+t3l11siMh1l2RsuT8+Ce7JKv8XM6e9z0=
X-Google-Smtp-Source: AGHT+IF0teeU22IYon0tcSA1bUZbAk4AcHkg3Gt7Oid3RJyiIH2UNdgTMzm601LPKtMT33Rojmnipw==
X-Received: by 2002:a17:90b:3c0e:b0:33b:c5de:6a4e with SMTP id 98e67ed59e1d1-33bcf853711mr6362143a91.5.1760738192132;
        Fri, 17 Oct 2025 14:56:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b349b2sm771890a12.23.2025.10.17.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 14:56:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/4] libbpf: Add support for associating BPF program with struct_ops
Date: Fri, 17 Oct 2025 14:56:26 -0700
Message-ID: <20251017215627.722338-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017215627.722338-1-ameryhung@gmail.com>
References: <20251017215627.722338-1-ameryhung@gmail.com>
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
 tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 88 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..885b0f891443 100644
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
index f92083f51bdb..863372bfde23 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13895,6 +13895,36 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	return 0;
 }
 
+int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+				  struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	int prog_fd;
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
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
+		return -EINVAL;
+	}
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
+		return -EINVAL;
+	}
+
+	return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err = 0, n, len, start, end = -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..45720b7c2aaa 100644
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
+ * @return error code; or 0 if no error occurred.
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


