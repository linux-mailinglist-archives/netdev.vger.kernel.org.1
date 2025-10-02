Return-Path: <netdev+bounces-227694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F43BB592E
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8D419C7FA0
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C22C11CC;
	Thu,  2 Oct 2025 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNrNal9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2FD2C031E
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445648; cv=none; b=h5kw/TM1/UbOjbBflLpYokhVEwWMPcwXQ96iAWHGXanzzYq52fdFYZ/hV+6tDBRjg162zB2eYCoOz407PWi1w3p6ViUnaBVHOEh6a3L2v0271yUdIwOCOK6q+GCx1IKM9OvatL0D37S2gB4ssg70AHN5Yx5pegLxHXzcJBSwnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445648; c=relaxed/simple;
	bh=UlL8oZQzeYpieEW9kR3O2tWXV0IGuasLKuUjGh/FzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUoeZ0fQyA2vztvpN0+bF6ftpZTSvx5AC5rfR6zAwmImBa73SKW7LT8WFFdm4JUuXJ2CSnc6t/8aaPbQwPcNXkqQ20fhGJ10h6mo6DM0qNRlVFY/k53P1FZg2+h1Qa3SIXW+RiJW4erFeDKb24/J41L6j4sv4gwR19LHSJCdnIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNrNal9J; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so1405879a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445646; x=1760050446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=YNrNal9Ju9ATureZYzDx3Sexu3LUlhyA0W7YFG4TnMdDwwLR7tcOfKX9uL/GRaoQpu
         JFdxRobLgz0CWX6ztG4nmqSAesQnoBKvduF4ju9DzXEiii5sh2+Bz0+u2MxjyIQB5x0t
         fQNYTSmdW7Pk9cyGB7BpeWN2vf4F9digtEjQwitlGqbX49fkIyw7ijRNxCW7RfZly/AD
         gFXRt3AU5386p4M8ChkPtSz3bqTWDe2wioMfZqsv/zqb5pzcOuJPX2PEtqmpBGTZWEcq
         I91lHdgsLBDdmSlRgEK8qaAPlyAs5DcxxQ5LYcURkgvK2+vJebbVMSuLGrgFDnLevI0+
         umVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445646; x=1760050446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=JlU5FbHOlSbCq9YQEQ7Ty+48hgTU3j+ZgJiepZ1m7uxg0TUGVeIggcrQSz9LzYBHZ4
         P9LToxdCJbEp/GSlUphOvHafMiEQjHtocmnWBX0/u+8TPRhTTiW+CBAaSP4h1/oWteM9
         8GA8HSqRiaZPMnYpFo4ImTa8bZPsVfwnwUrl1qkiMBM6LAFEyaQ66DgZsknP+nOtTauT
         MFCa0iJJnprNQgxvPs4kAuVEmvDXLrlIZ2yVnQLErprkxOo/WhaqAEKJtXeAZVckgIw0
         Kbzjj0g4uqZHHVaaapAaFVYYjwRO/YYb0IPbkRBSsvnxXKbO2YD6+tRB/1E+k4ZMeNMA
         xSSA==
X-Gm-Message-State: AOJu0YxQ8I3eeSGBhigEqzYvjx1GR74+Vcwmvl5XtTqbHI3gkuOAe9OY
	FAi8zqQNDyTAs0QQYAOQUlsLVmVeoPNhDYTgiiqn6a9lAdu4I+yu2wO6
X-Gm-Gg: ASbGnctkbOKPKInMLFoU3I7ooaZTATEijPuCF3KX2oAbfFutV/7hONU126ksMC8S0gS
	CZXvv+nMeL2jpMizmBxXLQ6QuhGQBoEwW/mkh+Yvw2ocyq0GfqUbh4omUOTPbJGpV4k1da/NGJV
	oTSKaEiew8tCbkn+g9aJOJSBCRUNTIYB5JFhaniB4DFqKJkqEN+EplQp2E4Pk14YXChmIa7E8we
	TeJJYsNTl4oM+/1CGR4jo5EhycbH4bJoNqoqL2/GIk4DzcmwnoxT69tchvP/kcPQp9MPLlV+ZI2
	irWD/71D4DGhO9LKyrKwSsnJxigp1SC4VdNvo4hDWmwVnOey24crWHjPzKc0YT42/nJbPYgEM0P
	kdXcRe7DfPIuISzcTdcQJB+nDS+Ox7F3QPHD5
X-Google-Smtp-Source: AGHT+IEKeUuXSLlxs+Qufc+5AAUWNAynyNDsdfEa+1mqdHlgXLN7b6nKdczjDpQ9nbzGbzdCFnGOHg==
X-Received: by 2002:a17:90b:1d05:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-339c27ba121mr922785a91.32.1759445646582;
        Thu, 02 Oct 2025 15:54:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm128017a91.11.2025.10.02.15.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 10/12] selftests/bpf: Update task_local_storage/recursion test
Date: Thu,  2 Oct 2025 15:53:49 -0700
Message-ID: <20251002225356.1505480-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the expected result of the selftest as recursion of task local
storage syscall and helpers have been relaxed. Now that the percpu
counter is removed, task local storage helpers, bpf_task_storage_get()
and bpf_task_storage_delete() can now run on the same CPU at the same
time unless they cause deadlock.

Note that since there is no percpu counter preventing recursion in
task local storage helpers, bpf_trampoline now catches the recursion
of on_update as reported by recursion_misses.

on_enter: tp_btf/sys_enter
on_update: fentry/bpf_local_storage_update

           Old behavior                         New behavior
           ____________                         ____________
on_enter                             on_enter
  bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
    bpf_task_storage_trylock succeed     bpf_local_storage_update(&map_a)
    bpf_local_storage_update(&map_a)

    on_update                            on_update
      bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail        on_update::misses++ (1)
        return NULL                        create and return map_a::ptr

                                           map_a::ptr += 1 (1)

                                           bpf_task_storage_delete(&map_a)
                                             return 0

      bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail        on_update::misses++ (2)
        return NULL                        create and return map_b::ptr

                                           map_b::ptr += 1 (1)

    create and return map_a::ptr         create and return map_a::ptr
  map_a::ptr = 200                     map_a::ptr = 200

  bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
    bpf_task_storage_trylock succeed     lockless lookup succeed
    bpf_local_storage_update(&map_b)     return map_b::ptr

    on_update
      bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail
        lockless lookup succeed
        return map_a::ptr

      map_a::ptr += 1 (201)

      bpf_task_storage_delete(&map_a)
        bpf_task_storage_trylock fail
        return -EBUSY
      nr_del_errs++ (1)

      bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail
        return NULL

    create and return ptr

  map_b::ptr = 100

Expected result:

map_a::ptr = 201                          map_a::ptr = 200
map_b::ptr = 100                          map_b::ptr = 1
nr_del_err = 1                            nr_del_err = 0
on_update::recursion_misses = 0           on_update::recursion_misses = 2
On_enter::recursion_misses = 0            on_enter::recursion_misses = 0

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/task_local_storage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 42e822ea352f..559727b05e08 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -117,19 +117,19 @@ static void test_recursion(void)
 	map_fd = bpf_map__fd(skel->maps.map_a);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_a");
-	ASSERT_EQ(value, 201, "map_a value");
-	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
+	ASSERT_EQ(value, 200, "map_a value");
+	ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete busy");
 
 	map_fd = bpf_map__fd(skel->maps.map_b);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_b");
-	ASSERT_EQ(value, 100, "map_b value");
+	ASSERT_EQ(value, 1, "map_b value");
 
 	prog_fd = bpf_program__fd(skel->progs.on_update);
 	memset(&info, 0, sizeof(info));
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
-	ASSERT_EQ(info.recursion_misses, 0, "on_update prog recursion");
+	ASSERT_EQ(info.recursion_misses, 2, "on_update prog recursion");
 
 	prog_fd = bpf_program__fd(skel->progs.on_enter);
 	memset(&info, 0, sizeof(info));
-- 
2.47.3


