Return-Path: <netdev+bounces-257341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMx9MeMahWne8QMAu9opvQ
	(envelope-from <netdev+bounces-257341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:34:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D44F8205
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C08D307596E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5B33A716;
	Thu,  5 Feb 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m38ctGbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73263382C0
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330573; cv=none; b=ND9jof6RuN6SKe20HwiwYNnIQ/5M6Tm8RxtCAqXPbe/jcayuNl5ScQH1sEb9SYh0olTB1m/2LzDYsj0H9AlGQbxkiAcc8cwuprOQFJgvV0rbfyGXWxEdJNrUOrto5FgsrumrU9+MMav3cy8YZRTzms5l39dJMD9h8JMITGnt5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330573; c=relaxed/simple;
	bh=ufc9ipn4DgFd2tvof3LuGSXuZhXMYch1RwfgAmSLjx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5pQ5o6GgDPFj34k1Yd8gUctR1Dy0spejjcGWGFpYIHHvrPObe7vNZZAbPkRdRTnNBs30xhaei0cpYuqUyV2aopBfMlhQ6tGt+1L7vg0bNJ2ZKwCuXt1VGrZUZTfdhtS1I+/8zdaQ+eoNBXSuwSgKUSttcuDy5TE/2KATsNeUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m38ctGbB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a09757004cso12212905ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330572; x=1770935372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br86rIdDfNGQDBD6yTRQ/wFNopMbNYBc/rl4mxWqQjc=;
        b=m38ctGbBghzJo0wNUK4xs6IZdkVbc7ANOgEHNTl0ZEf6eYyXbKgfQ4JRfhkvrT2rND
         RU++XZ/AfOB3PQXIX6oJTqTq6yhfN3sttQqIucd7yDNguA7wCPem9yRBj5Hl3BE4OEyw
         6h8zIrIeOJ7BIf/klf7xhIc9uoEMl/j7EOZiMprFYtcIlIip4IsYSh5uGw8soclN76xQ
         LpJEukcNsyirzu3wuCXmmJuSa8+wlkPXslVdzR9uzPc0D2+oS2VOqoGarPQ6Lplmkp9N
         AIqnJ+6x/UwqRBkdxcQa1DkzTwkboe4XiIeZrF1h6EI2jPnc44w9YJkWbcrvzxFAo1Oq
         DpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330572; x=1770935372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br86rIdDfNGQDBD6yTRQ/wFNopMbNYBc/rl4mxWqQjc=;
        b=CbTvWujVnzNcJ4q/Q746i7SUabwZrc3MGXe3ZAu3LSW71DCqJnhx5WdJvAb3otGp6j
         kybPc7uGiLgwpoTVG2w160RLMTpa5vDvttyp5ZSiu9hVEvcHJtoB9B5hh4v7W5XEUDmy
         T1H78u1s9vvEUFkVo5o1HCz2PVgcJUjW9kQHG4deKYQWFZvGg0Afky7SQZ/6WOF915fk
         qlUeyWCTRFNDgmiUDqSjMlJ+UiLcFiaxcJYKHlHvzXK3XxP6/8MRt6EQjBryFPxPuckj
         nnXSoLpyoFwSEqJm6XmQkUWpAIFm483h9OW7SNaa/zHMOxa5jnuYkG9DBWq73/9scWnn
         r1ww==
X-Gm-Message-State: AOJu0YzPCVYsRCsg5hjzr9VG3ve9FoH4q0Vp6FNMhwcrCDWkUWpIimNM
	JrXY9AUyMiGEo+JjWTKeNxI1jMGjdk9X2Vs11Ir2zzflX/u2WIEy+UUV
X-Gm-Gg: AZuq6aLRWMCmcNKi3Q1Vjr+VzH4d6Sgmem9ifxANiJHZO4ludzooBJxQh5cYe0PDv4W
	IndH2d9gmCzrKDpuDCxYykGO2r3cm+9G1jIqt2bXt/J51B+4wmj7fj0i3V5wZv5LzP4x1d6Ybxp
	6WPLf5o87Vs+TjElTO3YEqnjiK0TyDeOmLHiu7OD+lTQpuoLOqpM5UkECDYZ5ymn97cEm8H61Bp
	uWTfF3uwn6gHKRY8WNtO9fs+zKI5X9IQ7hBYAeh8GgDyFRtkTBbECf6myxlEW/zJtm2+Mw7FfGB
	66JjJRXK6q1ixOwVE1Xq0IVbHlDYDG3McBsvuXfRy6b5RG58OxrcViM8D9ALFgm/251Yhgo800C
	1Lgp1FpCVJx37Gm6Lli+q9w4BkmEcpG6E9Q2Wc+apXTdxS7Q2e6sRiXsQH9/5lv0xuE87Zepy8Z
	36dA==
X-Received: by 2002:a17:903:2f08:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2a951700f29mr6682455ad.40.1770330572165;
        Thu, 05 Feb 2026 14:29:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a63686sm4193235ad.14.2026.02.05.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:31 -0800 (PST)
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
Subject: [PATCH bpf-next v7 13/17] selftests/bpf: Update task_local_storage/recursion test
Date: Thu,  5 Feb 2026 14:29:11 -0800
Message-ID: <20260205222916.1788211-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257341-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68D44F8205
X-Rspamd-Action: no action

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
 .../selftests/bpf/prog_tests/task_local_storage.c  | 10 +++++-----
 .../selftests/bpf/progs/task_ls_recursion.c        | 14 ++------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 42e822ea352f..7bee33797c71 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -112,24 +112,24 @@ static void test_recursion(void)
 	task_ls_recursion__detach(skel);
 
 	/* Refer to the comment in BPF_PROG(on_update) for
-	 * the explanation on the value 201 and 100.
+	 * the explanation on the value 200 and 1.
 	 */
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
diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
index f1853c38aada..b37359432692 100644
--- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
@@ -36,14 +36,9 @@ int BPF_PROG(on_update)
 	if (!test_pid || task->pid != test_pid)
 		return 0;
 
+	/* This will succeed as there is no real deadlock */
 	ptr = bpf_task_storage_get(&map_a, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	/* ptr will not be NULL when it is called from
-	 * the bpf_task_storage_get(&map_b,...F_CREATE) in
-	 * the BPF_PROG(on_enter) below.  It is because
-	 * the value can be found in map_a and the kernel
-	 * does not need to acquire any spin_lock.
-	 */
 	if (ptr) {
 		int err;
 
@@ -53,12 +48,7 @@ int BPF_PROG(on_update)
 			nr_del_errs++;
 	}
 
-	/* This will still fail because map_b is empty and
-	 * this BPF_PROG(on_update) has failed to acquire
-	 * the percpu busy lock => meaning potential
-	 * deadlock is detected and it will fail to create
-	 * new storage.
-	 */
+	/* This will succeed as there is no real deadlock */
 	ptr = bpf_task_storage_get(&map_b, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
-- 
2.47.3


