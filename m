Return-Path: <netdev+bounces-230219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC0BE56C3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD31E545135
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1982E3B0D;
	Thu, 16 Oct 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivl6XtuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A2D2E228C
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647509; cv=none; b=tYeaNROeFuw2FoQWyEJadJwV/Y6odKF42PfQ5HqU69p4fL0LUqjx04OKva4uU6vsS1Rt5GyAyPypuaD6tiJmXn16PMFnnUYccTVQJdHGDNpw4KaggUTSqhVN4/wd0tAULNwWbzekIPKOXbKWgtGU+kq+6aoNYVkcge8L3CISEak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647509; c=relaxed/simple;
	bh=KOcdxzTTtq8Em9qroByJ8eMut+8WIyFvVQHqgJ/pWc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB8YDjkrgZpFPCMaWOcnRjgg3a+zoKNNK9QT3hLy7F4kanrBpJ8hHKvTf9uPPQ3flKBUJ5jF+/M5CQrPD7q2AkVJXp5J/wTF8PSXSa5tp9yatyyYIeUJKUF/ThOGwGbSkvt3/o3zTxjAViWvsM2d4xTYOwEwAQi/DqlEL1fffJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivl6XtuP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d3540a43fso12728145ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647507; x=1761252307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMrvzd50VbeEbuCp9cbDCbzIZmFB/ZT0z8NiVoSgkKQ=;
        b=Ivl6XtuPOTwwk6hwtuIGcQqZJzwftOQVIRG3UV8au0yAWYNGqyOzx6d3UMIRzp4dRe
         4IIGfuzRcBZRqVbQVCm2AL2hOXG0bd74ThZ5CdPEFG6iTNPsI3ciqzzCuiVFM8VAniOC
         GlOpDcTWleYkPpUG6BdqLpFmF2qmNMM+HUa5Q/izsbv6LAY+cZxjIKw00zxrX4HB/rEU
         cRI2wrN5yP2G5OeWhW/8QBUbDxbCgPMSohpQGwf1t1kexc30XPmpRpMNa+/8AfcDxjQE
         O+OREHfzAJ9lFjLQnYmaqY0rcaPc8jJt3k+oZbpyoYdDAhb8jEK1WZKWwL/ch5k1GYwC
         G/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647507; x=1761252307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMrvzd50VbeEbuCp9cbDCbzIZmFB/ZT0z8NiVoSgkKQ=;
        b=qgqv54u1nvYCaUF7Tp+LuJ4rhdkaPfFbxv8zyBrZpvyIVufQ5LZTBk9p0xd2BMvbVY
         qJJ0ix0H2AIQkv+pdublwgyayBweVJoiXz8DNm7J6jpha3cLZ+d/Gwbhr6PG4qCzxRLB
         NbUzQ5K6qgqbiTl3HYS9Ei+PpgzQSaER6pzrJLbj/mpshDvu7PiCWzqvnsovz0KOTnSh
         NeQFKKxHkRjG4NG9UwYDsT09QQB7iKG355qW3f6F1M9axNqmTcQX1uAv2hF7sD6jSyWo
         I3JP8WvrYN1FLF43vxuA1rpUDrEulovQCF57ThqzlrMSZBNlHna4kLcWuVOGVtWjEJkD
         plLQ==
X-Gm-Message-State: AOJu0YyM4kCYfsuBdkc7Yoaitr9y3dp2Bj20CXteTCchhCS0PwmPiIDg
	6//S4r76AaDsTxEhE7hga0Wu7NfXFS+arJb+//3/UUOwfn6YCyFABrbC
X-Gm-Gg: ASbGncsJLh8utqJFKY4xUxZ+C4cDUmhFZEZLz1JHM/Pq+V5OK8RUsjMJ/n0NeSfSIB6
	p8hMwXSJXIG+DzHpSuq8YiWEenGhR48dHJZ65rElm/Mkl9fFWoopfJUiTflFuLBXZ5fMjMcXvyp
	YSb8GfRdO/Ikk4ONGKDGGin/4n9jXHQK3UO3IFlhsgAxDlFzcWQS8o+pfNUMpF2Hs2mwR8ukM+w
	74Sd6qDIoZOIOVpNjpnd89mezMmExCUXk0RkJFojBA/EcXgtxqXeMVJvoIeEzRzim+Jpl59p8jW
	i2GvXNQPZ4yFNF3KJME3XIKDPpqUzyUNSDvXMADySAtin0Tz770V6dm7mSSwSCKuvXLfYsEwhIB
	qUlyHRYZKIkj/kk6Yt4w1t8iyrP31TDviYz2deXcm5tCZm/PqgwiH7Mnv7JSNNaVCpIHwCUqOV9
	ctiipIdnNdo0Ze
X-Google-Smtp-Source: AGHT+IHMDjd5z2okgXhxfefo8LVS6frNU+rzb6uzgl7Iz6OuCeVp4+LYtZTw+jv2tJptJQuVS4qCWQ==
X-Received: by 2002:a17:902:f550:b0:275:81ca:2c5 with SMTP id d9443c01a7336-290cba42439mr16470735ad.59.1760647506943;
        Thu, 16 Oct 2025 13:45:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aab735sm40135795ad.77.2025.10.16.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:45:06 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 3/4] libbpf: Add bpf_prog_assoc_struct_ops() API
Date: Thu, 16 Oct 2025 13:45:02 -0700
Message-ID: <20251016204503.3203690-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016204503.3203690-1-ameryhung@gmail.com>
References: <20251016204503.3203690-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper API for BPF_PROG_ASSOC_STRUCT_OPS command in the
bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 20 ++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 40 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..020149da30dd 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_prog_assoc_struct_ops(int map_fd, int prog_fd,
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
index e983a3e40d61..14687c08772d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,26 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_prog_assoc_struct_ops_opts {
+	size_t sz;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_prog_assoc_struct_ops_opts__last_field flags
+/**
+ * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param map_fd FD for the struct_ops map to be associated with a BPF program
+ * @param prog_fd FD for the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_assoc_struct_ops(int map_fd, int prog_fd,
+					 struct bpf_prog_assoc_struct_ops_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..e1602569426a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,5 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_prog_assoc_struct_ops;
 } LIBBPF_1.6.0;
-- 
2.47.3


