Return-Path: <netdev+bounces-240904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 956CAC7BEE7
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E02F34EBC86
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B53115A2;
	Fri, 21 Nov 2025 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TooVriJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0330F544
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763766839; cv=none; b=JTY6oc8jHitHFEwMmG/CUjpRioVZ+FNlSGX9PuVm4XEUhL3KnyvZFTKkfok5VePLoVu/JilplWMcWhtsCNsbOOya5gWz6U7yavyiO+5verWqv2NgnO5uQDhlxzjDeqn+4/S9Z+F1jkAa8cg89htkiokznk0gDMSUqgWozcE/HHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763766839; c=relaxed/simple;
	bh=nuadBieIRqkX2X2xKigInlacOaV8KUksUNbusE6Cd0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZY+gjFnJYhkbV3c8V1SAaMkXZyqoxOFEd6x7qk2ulYs97VHe9wELXGGfwgum2yvx2H3cI1apRoa0VOD/xcVRTT/Rv8jgPQBVzPfu5uMiqleHiHr153kzRyNkci1+NEXRaawc3ShJWGeBE4IkZyXumaSmzh9U5CUAz1RNB1S24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TooVriJO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so3106075b3a.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763766837; x=1764371637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnoROxKfUGaKnMycvDbpiyKb0bwKma4edMq84tq9sMQ=;
        b=TooVriJO9C3Y2YLwV7xNPQLp27/07mc0Viw92eGZbezMZEVcDnZyuYiB1cUgQyh17W
         gPpJZdAU6+tnF+UUx+33nbZg9535nBYycdgo1Y7zdWaYY1v0XCWRjvch5oYemu1syySn
         IIN9qncMUZuo9GR+yxnTeVKItJmOx3OVt6jTLG9g1C8+HNMbcxfySPok/lfhZtbUiU7H
         32jT3UK894tdpXeuDnt3+lQsOI1B7NvLJyeSzrFTeR2FXvDvBtsegea0djLjiDU7R8cn
         Ear8RfqfCVTOOKSVKXo2ss4QdiH9IAQz4O4HZR4n2ggaigdqqim2ELTLNLRqTFOaRFRQ
         JzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763766837; x=1764371637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnoROxKfUGaKnMycvDbpiyKb0bwKma4edMq84tq9sMQ=;
        b=LSGQmKK9qjRKOgO0Ia9qclGdIK/WBxQ9EppCE81Ek/3pthZ/xZEg+UYYPcRL1tf1z4
         FAclHdQhotGNpshjn1cOmGgIxTiLILBV8BogT/drf48WR8Zl1blBMy8hQbBUQIq0u/Lm
         ON/NGS8CT+SKLlRoy9+Y1VZ6OCkqDAv1wVnM/tCYZe+5SleGPCErg9B6pkdoS8S50DD9
         rVe/gao8KmG+2rkXQIAUe4oxUiCLGQfb7UB3WR98CnaIkiAynSzaPqyhD+P5CCGj9/Gd
         bdAiTOqoC91FG0ynAo8EeH/p9BkZU3Bo2KoTNmnpxMyuuFbP8SVtYv4C/iv6Wc8in17l
         jkBA==
X-Gm-Message-State: AOJu0Yz9ZAa34tWiXdAi3fi6FmLV1GcHETbPEYFG2vDQwoj+LXtVTRep
	c8etvAmbxy/uVls0R86hNJDLBz021wzKKSNDCh+av93pklhVmM/Y8bqG
X-Gm-Gg: ASbGncsug3FPQu+RUwOyohgOEA19WFWqg25JtgUT+JfAc6xAaFJyXimDZDGlY5XPxSm
	jC9adY5lUWozFWxI3q2oDuG49KalVI6wdTuMHtC5JunqS2WQ3wWOzgjIM1TpVnPByK+nT8n8LXj
	BJPZw6ckeFd5CT2o0UvDvaCn/ZMDOxOOBl0VQkJiU0Y4gdzpMFU9TJTLx/OXCnkw4fgjjsXJYfM
	Pzl2kXoVuV82mbYELPfvHnvujF4TAV3hm/efCK9DJBE4SbSRPZQJgG74jtpfUzhZNcw4h3DKp6l
	rJfXgAfMr9/t/CwdVnm5UegnAYtFyvV9wbeAQNvrX4MVqQUFRh9A6XtLPomTXyDm2Jhsl06mczb
	1yx16O6fBVPlUhTydqe7M6dLga5OVqmIuyu4E2NgrQBZdTZ6yG5rOkJl7xu4zMeLhjSCzcwh6il
	KtpNb/iStcVZzV4umHeuoE7raH
X-Google-Smtp-Source: AGHT+IE4bNQtdSaRmfKsxwlEdULVL8SfzjIXFqHjwRZ4C/P7oP8bPeIjIRf0NZVSFqAf6+/0/PET6w==
X-Received: by 2002:a05:6a00:845:b0:7ab:4fce:fa1c with SMTP id d2e1a72fcca58-7c58c2ab130mr4199808b3a.1.1763766837265;
        Fri, 21 Nov 2025 15:13:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed076244sm7034583b3a.7.2025.11.21.15.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:13:56 -0800 (PST)
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
Subject: [PATCH bpf-next v7 3/6] libbpf: Add support for associating BPF program with struct_ops
Date: Fri, 21 Nov 2025 15:13:49 -0800
Message-ID: <20251121231352.4032020-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121231352.4032020-1-ameryhung@gmail.com>
References: <20251121231352.4032020-1-ameryhung@gmail.com>
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
index 706e7481bdf6..1d5424276d8b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14137,6 +14137,37 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
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


