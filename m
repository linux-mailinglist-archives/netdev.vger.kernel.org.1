Return-Path: <netdev+bounces-257002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGg3BMpBhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:07:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B823EF476
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E1D03054239
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384635D61A;
	Thu,  5 Feb 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeyhKoay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B835D619
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274945; cv=none; b=XBqnlsdFl1tJjGxz3pZSboM/tZAnV5qq8GuZ3J0sSQqWCPcMHlHdkdhclYedr9SHnUCPyuPJTzRgFRkJZJ6GWMx1kXSnysvsQ32xYs1UTUfEDMJ3D+fIe/wzV47kV0bmKSbiz0hViXhDr0J6/07s0Km8HbFTQFTzdpF4IBEQSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274945; c=relaxed/simple;
	bh=TADLOMRKh4Q7PejR9tjfy5dVMNcv1vOqD5dk+oNJKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/ANDjurdoc80PnssMrd3W3rp8csZfZiUMp7LtT0F2MeyBuwfsBF4hK9wkJqwAMwmHa3DoKGV5RyOEqV5Xku3xOY55Bp4Zz8bThHWLBrlbxujrHzmmPlyDTkXTlOENHN9BoYPhe4Ny6axWc3aDFOq3RtzoVK3jPstmOqSIDyn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeyhKoay; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8230c2d3128so285612b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274944; x=1770879744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=XeyhKoayUxebKIvgNqOetd2eTgoABC9i0+f4tsPvzNGkluDDBADUtgLSfRsgItguQQ
         qCgNxzxvJtC3TlqO0nRx56a08QOa6Yci3vPUakDmWA3cd6eMaPc56/JLshMInrLkGPSq
         nLZhULJx4lQcxMNufjuYtgiFbU7NiR+IlAndsvN9KGUC8XGeXfRBeZJbZtlfQT0Ucvco
         5V02Awlw1iw8aUlOUURZzRwblu70QKRfFknZAoZJQILWq5piUkT85YXbNF2GpAzMleOQ
         fPWvbKtYZSVg9LMq5Oh4YYWmiwzXfHeoFFfkFCa28LWzxVTgClJcj8S+d2pEP7WHzmmO
         OHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274944; x=1770879744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=nwyJ+exzzqNgky2NMXZKMA1IGFbcV4pRRvXHnjD4Q0jgYA2fjJRC7+Q5VJ37Nc4tuN
         jSQe8U5oYT6p6/gDUK05p97UfPEj2k+cTHLvLqoMK0Jmow4FzE7INwqhC5nTjAAmxHQi
         E7oLowwstiGN6FzMW6DrcgYMowG2Jvj+ZpwsjQad5+0iPIyVc3Pf3/RlDem9wfEy7lWO
         f+UlWIJYmi9vwEbH8mdisoMWkcqk/3cnjIwMY5ga+Fk8NdKvNsMFdJQtQpgVuTlmkInH
         dGliYy3dQvVzvmpqPWNN7sY99qEaa+5iKqCy07HS/kTXbt89xhSUx4N6wu/qFDZOPBJB
         HAUA==
X-Gm-Message-State: AOJu0YwGaX/xMWehxjyJqCg1m25F9HGBnXbjHMR9WxwqnQljhJ+/so0z
	zTvOF22ihpQyVq4CwDDMzHMieTF3v5GtGo5XdkbCv2iORy4b3wRY44Kr
X-Gm-Gg: AZuq6aLrMbXTeB9lHsD6bfYrIagRYpzXDOmWD08YrEQD7Ud3sOo37B9WQ8HYHkxljns
	BGEW+0rtJYuEt/+bSX1NWHaK+Jj+dStjS973fcITkRAWOZWwtR4SN1a6ExPQZ3zb61kBUfWkmPD
	3wUs8mJo3ljH1cGT494G8bj0u1m2n5ZxKrlQmgFuOgTy/MU8Hh0JSjrc8Jbzk8k52tKYp5vwJpB
	1insSlmn3wcWNpIf1nvADV2ubTMr8ee0x6pQ//IEkUoG4coyHs7yIT7HKDZkt+GitIUuiu5qRw/
	KQOjBK+d0uuQChVd+qLEyT8JoQPIs2Qlk4/9pN1LDNlqcnARGAs98+ebYwgQkLm34VgsIS/LXYA
	L7NPtMiwPsvDzZrx92PTKFynRdWizQenDGqImmkCluBPQPYR6FWAN99l6AG+gLhb0+19Spg4K/e
	TooLhuaqGEAMI=
X-Received: by 2002:a05:6a21:e58d:b0:38b:ee34:24f4 with SMTP id adf61e73a8af0-3937205ff63mr5458024637.15.1770274944399;
        Wed, 04 Feb 2026 23:02:24 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8581fe1esm3883202a12.35.2026.02.04.23.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:23 -0800 (PST)
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
Subject: [PATCH bpf-next v6 13/17] selftests/bpf: Update task_local_storage/recursion test
Date: Wed,  4 Feb 2026 23:02:02 -0800
Message-ID: <20260205070208.186382-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257002-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B823EF476
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
 .../selftests/bpf/prog_tests/task_local_storage.c      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
-- 
2.47.3


