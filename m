Return-Path: <netdev+bounces-228559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BEBCE28E
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570FC3A3E06
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369326C3BE;
	Fri, 10 Oct 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtEqD895"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697E2F39BC
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118600; cv=none; b=mFNyIhjjYT5gsYaJK7PdcdglgGvsOrefav4iEQlF4QA8fXWmFOuvrUpdUV3oSHNFMDG67tTCaeadUxzUr8+IW6FVSJeh0IZAehZCncHf2VGx8RWVw/zSXls3dnn34ojnlF9zNs0aEDhB6jHDwcbzS3NL8t2AIRy5bUOGR/qjitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118600; c=relaxed/simple;
	bh=HkW2uhOCSv0da1DuuAqv9lQkotThUeSdBsL94afQqRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmJczEA8ckWc0A/rpW0PelX0iMIBm9rmi3fT4yooTdU2QmQB6NXqzo9qcYIZOAB++tji3KcjBfWnAyWAei8epHroi2utttI3wNmGF9mxMXJFFOblSx72jgcmaFtcijNyncYbWmxQU679YnDJXqOTsaOxkrWQQJMMYdq6ddve4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtEqD895; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7930132f59aso3322316b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118598; x=1760723398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHbpxQMFMOwT2AhBvB0I0iDBDiuT0DEM49ayAeHNaVQ=;
        b=UtEqD895vPJmR/8xDTga6SbaZR4IyENsRTCKcJZN1A/vdt5XUpfNrxmhclVf0imMBp
         /VH16yPZVacX+pI+ITDdPc4KSTzxzDlsUv7Z8MWdRb44GA6duQmLRe6uhC6xNOjbaJyg
         11+wC3+OG3VIquWOowMO4/tetOrzz5iYkRvf77NdQ33MKsSHqnAMV5wEiJpKQqmXF4h6
         Xqz+V8K4Eg4/X/QC2fz/s9FH/GjMid6uJotS5aCN7y2rhSE7hh0grVCSm8n7l83XVu2V
         o+obIMQ0k57EtbqbBBe1onSzD+dLCudo3pyX8fTY+H938gtGM+7XSFPcyyxjuu+PrGiA
         u/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118598; x=1760723398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHbpxQMFMOwT2AhBvB0I0iDBDiuT0DEM49ayAeHNaVQ=;
        b=GzC5ttD8+vEOSpag6HzgvpUvfPIacKXOVlUc3bzF66luBwbZzADNLiZLKU9KM5VPb1
         RPd7RWTcMK2N9U///ermQJabylXW12h3TTAMXNlgQlHNl6HYOHBQb+I9/vXe03lAgz7u
         V649bAglgJjAUPc/ACeq2vJvLFqxQL9T0gm+TyUzA9hZkolvqJoZzJcyiV8amQF/ziIH
         5TGm8tRyEdTjdBQ7OoaLoHKGw721KhZReG98ZZ1w7kVi9JuBsvnHo5JNASk+GGdb2tGX
         OVy8PfhmK75nqLax46nKnExmWKJ6rvZO//qoSyy75I7YQeUTcS6sYu1+M8s3tR09pHFZ
         Tu2g==
X-Gm-Message-State: AOJu0Yw3ckoOMJQ2JsCUNc7q4IS7lRAsZjk79PVjkg+ED1Dxqg0fqOar
	gth18OcNPU24ALN8cI7GdVn9gNhZf7F8KDYIgu9vKrjVfm5huh0kfuju
X-Gm-Gg: ASbGncs3q/rqXl0gm6irW5OPVFGVUO+BVPXzMMP3AyX7Tf6kVW17ccC400x/+ia05mC
	WZtRU11f9c8l9u5ZRWDgEOYxmkFMQ9Tts08T0Pg9yGUGEWO3T2ZVjXk74S97HFnSGp6zLilnTdW
	yUiVcxooiBQ4qtOGes+u4gV3rdNjG6ooLa3BVi+7hSgE03Cu/ZxrWuAoQEM6HsFyM2EG/H0u8wO
	QLgQMuqfbxJRF5eDSSopBVFZEgV9Q7+mphoeXbNkspSkZpqd2X9erEJUsgDta5YG1YcpIWckgOT
	Y9etjQF7gCUFfVrqRXHgMwuIXENtTuUjdMkNX3xx8bJJIs3BQG4e1Bz65Oio3WQLcZOfUX5rjge
	mtKsq47Maadl6YSMIUwK8CJ0+P7NDDKOWBR+Chxs8tMk=
X-Google-Smtp-Source: AGHT+IEJ9PDvkBIXSPW92jfBXGJpVfvGo5MLAgGKb7FyFsSC5gsr2SzxiEAUHfOzdCpnZd/5+/2E1w==
X-Received: by 2002:a05:6a00:80c:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-7938723daa6mr15091340b3a.21.1760118597383;
        Fri, 10 Oct 2025 10:49:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm3703948b3a.15.2025.10.10.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:57 -0700 (PDT)
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
Subject: [RFC PATCH v1 bpf-next 3/4] libbpf: Add bpf_struct_ops_associate_prog() API
Date: Fri, 10 Oct 2025 10:49:52 -0700
Message-ID: <20251010174953.2884682-4-ameryhung@gmail.com>
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

Add low-level wrapper API for BPF_STRUCT_OPS_ASSOCIATE_PROG command in
bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 18 ++++++++++++++++++
 tools/lib/bpf/bpf.h      | 19 +++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 38 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..230fc2fa98f9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,21 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_struct_ops_associate_prog(int map_fd, int prog_fd,
+				  struct bpf_struct_ops_associate_prog_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, struct_ops_assoc_prog);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_struct_ops_associate_prog_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.struct_ops_assoc_prog.map_fd = map_fd;
+	attr.struct_ops_assoc_prog.prog_fd = prog_fd;
+
+	err = sys_bpf(BPF_STRUCT_OPS_ASSOCIATE_PROG, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..99fe189ca7c6 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,25 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_struct_ops_associate_prog_opts {
+	size_t sz;
+	size_t :0;
+};
+#define bpf_struct_ops_associate_prog_opts__last_field sz
+/**
+ * @brief **bpf_struct_ops_associate_prog** associate a BPF program with a
+ * struct_ops map.
+ *
+ * @param map_fd FD for the struct_ops map to be associated with a BPF progam
+ * @param prog_fd FD for the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_struct_ops_associate_prog(int map_fd, int prog_fd,
+					     struct bpf_struct_ops_associate_prog_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..3a156a663210 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_struct_ops_associate_prog;
 } LIBBPF_1.6.0;
-- 
2.47.3


