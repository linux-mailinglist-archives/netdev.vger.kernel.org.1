Return-Path: <netdev+bounces-243262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C0C9C5CA
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A285D347BF0
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692592C0F69;
	Tue,  2 Dec 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc4+gSMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC62B270557
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695780; cv=none; b=VlAIiHRJ7V+zrQKo/zz1MC6g28QmZw57qQVFTXcIhJheASJi2KC3NosJ24+03/UCaDwFn58K/Te+R0nhoTpAmEFPQUfKcumCCzQMA2XbVgMEnFxkLYN0isVhE7qwrt2zN2MeBDxxokYXNWi0ruuIST39IzazBqjGeTvnW7Bk2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695780; c=relaxed/simple;
	bh=VPehTofaHvh3cXTP9lnZWP5l8y+SuaYG4kHiLDWATKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHUCriYraqBwE6mK+8WeggMwGKItlZn2+O6w9spygm63UAFZ2hl/k2XbgxENh02CZinIGJ+IdCascQHf259PyYhoIR0mzjIDp1+lRYro5fwJQHG7w+nh7m+s164fCPhqYm4wcSH3vQlcKrru+N0Oq43Z0V61D4wFk6R1UcUSQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc4+gSMc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29ba9249e9dso63963885ad.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695778; x=1765300578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+OVhB+VrD5Ironu4bY8K77UjFHID6B323MrlMlQqfU=;
        b=Xc4+gSMcg+UfmSz9x7Fr/OLzAoiXBrdqCmARA9+FJjRYqezHnspZwn89kiZaOYkpcX
         uxGk3fzLQz52OCeKkGb3jrOL/1YVVprDL5jTmD3jv27hACXU5AZnFeDXIJBtc8PVkdL9
         LECubVWrAnmgTucG9vAmHlgFkYGB3YV+g4UdUrcF+hTyedOpJ7/zWSMQr022d2XnF91C
         m0BnQgQ5sxcyrqJ6BasTuTOUhx2jPF7s5fpqXmVKjHedfobpdW2z2T7wejyLDq0W68+A
         KPF1OBvUsdYdtfsF/9nVJ+mRwMGuIf1JvV8KtMIYeYgoUdkemE/vBBXieTu8vPcdvpQT
         GTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695778; x=1765300578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+OVhB+VrD5Ironu4bY8K77UjFHID6B323MrlMlQqfU=;
        b=U61eBHEmFrPwweu7qy8WaRnVAmyO4TcpXiWo7eOQWFH6n8ISFwqKQpWmEBcGjHTJ9v
         dKee3xGN6PjEyvYrrW9yH+1sO9hnPs6zxJ6KdJQl7HstU4V9kYh3N4Qo5sFtB9ubIYAr
         vNBZATDxBwocb7XUPWMOIOC2hx6xyP3SxeP+HCI6X4qzQ9kYQdUnZemQyezhGyh8aNez
         Z5Oo9yhJGevoy6pBysH0FEtKZcm/FdlkbX5VXeUmUbK6RenjQTEhEEDxoPBI2ONUa7tB
         Fn105NEBl8Jrsk0WTHrspoW4S4okaNgYY+KVel50BF854I7zCBrUBgxSHfLXNP6BUM0Y
         eElg==
X-Gm-Message-State: AOJu0YybaWED/Fw6J+cKyy8r8dZekyTCp0XrVIi1/2ML41iKALyY6pQC
	YbOxo4jMzKfzo453aI06SDBFDwQ4GfpV19QrvdBl6bFrXrPc3iWJcnCs
X-Gm-Gg: ASbGncufk1QOceLSRRokv7K1NbzRdAIGWGisKorbHfd3+39oN3GfPMvHIOrzskEqDx3
	n3knlnnIhiMJWKxLhpNgXyOvvFKy0K9bZVpwsl8HuGTnOpBW8DxO7VlZ9Ocncqf+NSCESrjHFm2
	jML/3cRZUdvRLZuuhtp9B4McBvZK3NO7VReds+u6xQQ1dyT70E2gbZCWFetoYmujDGLB3dzMiTo
	vZSOWx9UAIEA0uLdvubivVweYzA2QeJr1GIyhVsUj0ybGy/bdWdXqGTUtpS1OEwXwK3n8Sdi1lM
	XaiDUIm56/++PBUpknD2Qgaf5kOrDnNMGXyhi3Vn3kvoQhVf06xsljf2D8Kef/gMdZlYz+4Q9h1
	GknaBGpeLdqmi/1xFAAaHNxUodiUzDdKjuw3OLsbeXCd8XN68Cebh3iiJ8kv4ZNFUbG+ELOtpD8
	Xacg6Ivr1IMgzjVA==
X-Google-Smtp-Source: AGHT+IFE0J86I8Uf7GW7nljnJGlohIYU2DJ9ovT7oeAFi49/q/FcGY1zsyQheeSrcZUxPYfHiHVXRQ==
X-Received: by 2002:a17:903:40d1:b0:296:3f23:b909 with SMTP id d9443c01a7336-29d65dd39b0mr199355ad.39.1764695778003;
        Tue, 02 Dec 2025 09:16:18 -0800 (PST)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb2765esm160661545ad.65.2025.12.02.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:16:17 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test using cgroup storage in a tail call callee program
Date: Tue,  2 Dec 2025 09:16:15 -0800
Message-ID: <20251202171615.1027536-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
References: <20251202171615.1027536-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that a BPF program that uses cgroup storage cannot be added to
a program array map.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 50 +++++++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         | 39 +++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage_owner.c   | 33 ++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 0ab36503c3b2..41090a413b09 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -8,6 +8,8 @@
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
+#include "tailcall_cgrp_storage_owner.skel.h"
+#include "tailcall_cgrp_storage.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1648,6 +1650,52 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+/*
+ * test_tail_call_cgrp_storage makes sure that callee programs cannot
+ * use cgroup storage
+ */
+static void test_tailcall_cgrp_storage(void)
+{
+	int err, prog_fd, prog_array_fd, storage_map_fd, key = 0;
+	struct tailcall_cgrp_storage_owner *owner_skel;
+	struct tailcall_cgrp_storage *skel;
+
+	/*
+	 * The first program loaded tailcalling into prog_array map becomes the
+	 * owner. This is needed to allow prog map compatibility check to pass
+	 * later during map_update.
+	 */
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+	storage_map_fd = bpf_map__fd(owner_skel->maps.storage_map);
+
+	skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open")) {
+		tailcall_cgrp_storage_owner__destroy(owner_skel);
+		return;
+	}
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
+
+	err = bpf_map__reuse_fd(skel->maps.storage_map, storage_map_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(storage_map)");
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_OK(err, "bpf_object__load");
+
+	prog_fd = bpf_program__fd(skel->progs.callee_prog);
+	prog_array_fd = bpf_map__fd(skel->maps.prog_array);
+
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "bpf_map_update_elem");
+
+	tailcall_cgrp_storage__destroy(skel);
+}
+
 static void test_tailcall_failure()
 {
 	RUN_TESTS(tailcall_fail);
@@ -1705,6 +1753,8 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_cgrp_storage"))
+		test_tailcall_cgrp_storage();
 	if (test__start_subtest("tailcall_failure"))
 		test_tailcall_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
new file mode 100644
index 000000000000..e4f277d2c4fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int caller_prog(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+SEC("cgroup_skb/egress")
+int callee_prog(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
new file mode 100644
index 000000000000..6ac195b800cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int prog_array_owner(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3


