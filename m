Return-Path: <netdev+bounces-83427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD789240C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB4328585E
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7941386B4;
	Fri, 29 Mar 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvYW/EB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810D1384A3
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740000; cv=none; b=P0wIUDff9ZLdzcUCzjqqrNEuVUiCsekZTtfK4BgL/Hc/FnTdl9Jw4KxYcaor7zVXueYTI+8/vMeAY4etV5ygbKAz3ub29B4h6L5L2MZprUKZZfE15FAmWonFPQi/KHaGXwqqBN7W3W+f9dR/Z9CATiSnnAiANftQOUfrTQ/NkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740000; c=relaxed/simple;
	bh=11J1oF1EtXV1qtgpaShlOiZNJHDVgqvSLoQIBQbUPeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cf7CFY+ghNyB6zbK8bzmgIpy1AM5FYHFzyEYH3d9coOEwpln2Nn5Cztv7U7LaRIab57G2q7LaIk6KImVxzKRsJ4If9phgSxS6JlqzhzlIwManLRg9TVeKtf214p+rlDwK+K2ZFrefNGZ8xEOv1bQ5PVKfJmGWfHPGt2UnNcnFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvYW/EB/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-613f563def5so35463937b3.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711739998; x=1712344798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRiul2graw1bxh54kq90mvx6bUbLW8gw8FgM2SMnjyw=;
        b=dvYW/EB/z+3f5U11Uf2GmwCYRX48BdiL4yzEQrxCWRm8e4WmsOZA4JA1wlAvT9GHBR
         OSCmOEeFkN1j+Jamb1NkmzP5cry4Ll6VOeDKEzB7i8iOjts0wyKLnQL5j0QpM4LxqiFX
         QR+N47qMiESW9nzJtmv713Smv3VyuuUtHgZZOcPLGzgmkXNWohmitoJM1E75Y1Bn4jAD
         ucH5kFk7AkM5HDoaMWa8P+df7Htel1CaAU9Hz9/f7zSnulwU2hE8Znf7jkOOOj1O+cGU
         HoEoeXWbOA7uEQp6Wb/ZqwKUpqFurU5vMfM6xz6pHtPMgqfQFANj2Xs2zpE8QjWeWRsh
         R83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739998; x=1712344798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRiul2graw1bxh54kq90mvx6bUbLW8gw8FgM2SMnjyw=;
        b=LHsubVzdGfSEjIAdyEp0MdKnTJ+d/1hiwmozdL5KInwqWh1z4kYjHV15LjIDz76DGJ
         yQ2SjD9YyEqEfZaEa+Ud3m+qPS5jMHPJJdi4WIB6BNV6hogyamFi7Uh5ZrB95jhyzdhr
         +aU3uuKaJtCsfGgQ15GrE5939XBAfOyHClrgIi05LUPXvBk4oSSwp08STo7u08Sh0FaR
         azyFIPK2R98AHshyoVK5QsNMssFeK2u1XwJGnblgkWuJI/xjLe0Qkqgda1+nVNeYIcv+
         42FUw+ohTkwZE0tJYcOdzvaii3MvM99l7nUEpccdOHvTGywhjQKlFe2cwrCLz1PsLgSF
         Mqwg==
X-Forwarded-Encrypted: i=1; AJvYcCXgOlAvXj5Ige4hG5kJfKKSBK+a7F893K4vmuKkmiUJYvek83WtLZDYKRDYMBK7gouiJ+rC24l3yz+bahaT0NqEZ2gLca0z
X-Gm-Message-State: AOJu0YyJN+utx4mQOsV1yGnDXCszMJy9mKjoJwIO/NjPWQcgbgklHh/N
	luufKCKeI/VSzYMFVIC5u9JhAF56Gid3tUdhXEwLFtpEYOrgYtBefRamalMYsx8GRG14VqauVw=
	=
X-Google-Smtp-Source: AGHT+IHRdLbvyHJnMHKtWdr+cFy6jSU0+diPw3ZFjoZcj2SJx21rEPQB79DhdlcNPoxtA68+qL8xQhArzw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a0d:d9c8:0:b0:613:eb1a:6407 with SMTP id
 b191-20020a0dd9c8000000b00613eb1a6407mr706881ywe.9.1711739997755; Fri, 29 Mar
 2024 12:19:57 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:47 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-3-jrife@google.com>
Subject: [PATCH v1 bpf-next 2/8] selftests/bpf: Add module load helpers
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch introduces a helpers used by the sock_addr_kern test program
that allow it to load and unload sock_addr_testmod.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/testing_helpers.c | 44 ++++++++++++++-----
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 28b6646662af6..16959a748d4b1 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -366,48 +366,68 @@ int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-int unload_bpf_testmod(bool verbose)
+static int unload_mod(char name[], bool verbose)
 {
 	if (kern_sync_rcu())
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
-	if (delete_module("bpf_testmod", 0)) {
+	if (delete_module(name, 0)) {
 		if (errno == ENOENT) {
 			if (verbose)
-				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
+				fprintf(stdout, "%s is already unloaded.\n", name);
 			return -1;
 		}
-		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload %so from kernel: %d\n", name, -errno);
 		return -1;
 	}
 	if (verbose)
-		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully unloaded %s.\n", name);
 	return 0;
 }
 
-int load_bpf_testmod(bool verbose)
+int unload_bpf_testmod(bool verbose)
+{
+	return unload_mod("bpf_testmod", verbose);
+}
+
+int unload_bpf_sock_addr_testmod(bool verbose)
+{
+	return unload_mod("sock_addr_testmod", verbose);
+}
+
+static int load_mod(const char *name, const char *param_values, bool verbose)
 {
 	int fd;
 
 	if (verbose)
-		fprintf(stdout, "Loading bpf_testmod.ko...\n");
+		fprintf(stdout, "Loading %s...\n", name);
 
-	fd = open("bpf_testmod.ko", O_RDONLY);
+	fd = open(name, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find %s kernel module: %d\n", name, -errno);
 		return -ENOENT;
 	}
-	if (finit_module(fd, "", 0)) {
-		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+	if (finit_module(fd, param_values, 0)) {
+		fprintf(stdout, "Failed to load %s into the kernel: %d\n", name, -errno);
 		close(fd);
 		return -EINVAL;
 	}
 	close(fd);
 
 	if (verbose)
-		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully loaded %s.\n", name);
 	return 0;
 }
 
+int load_bpf_testmod(bool verbose)
+{
+	return load_mod("bpf_testmod.ko", "", verbose);
+}
+
+int load_bpf_sock_addr_testmod(const char *param_values, bool verbose)
+{
+	return load_mod("sock_addr_testmod.ko", param_values, verbose);
+}
+
 /*
  * Trigger synchronize_rcu() in kernel.
  */
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d55f6ab124338..d553baa01d597 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -34,7 +34,9 @@ int parse_test_list_file(const char *path,
 
 __u64 read_perf_max_sample_freq(void);
 int load_bpf_testmod(bool verbose);
+int load_bpf_sock_addr_testmod(const char *param_values, bool verbose);
 int unload_bpf_testmod(bool verbose);
+int unload_bpf_sock_addr_testmod(bool verbose);
 int kern_sync_rcu(void);
 int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
-- 
2.44.0.478.gd926399ef9-goog


