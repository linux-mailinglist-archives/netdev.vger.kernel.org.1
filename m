Return-Path: <netdev+bounces-255661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULUkK3yTf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36796C6D50
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313C73044A57
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7E2264DC;
	Sun,  1 Feb 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgD3a3GM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386F285CA2
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968273; cv=none; b=QsmU9B5/RCUmI5649jYZ/yNQoDyM0o9Jvj7Z56ogxGe9GfVUc8RZtwwQ/ny0w76YjG9XshklK1l5AochrIVBL3ZmNCDJWNdFcxDy47zaVI2V2QtkrOZr//jFOu5nga3WwZRC/HImMlcesk+55NYhhxxSruti70eLsufg6zcY9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968273; c=relaxed/simple;
	bh=TADLOMRKh4Q7PejR9tjfy5dVMNcv1vOqD5dk+oNJKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cmiaii9PrWBlnx7eQTeysWK/p98+aJB6YYznSMB36AeeHwTwCwbKivhExa8MSere1kmXyenrd4ko8bVbIm8MQ8WE90B4Bwwz6vBZ5xdGArjgUbjbkmyyov5X23LpoKBc/I382+6ioJHpcnBkdyDCBht1IS3mQ56VxSAmQvCBUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgD3a3GM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so1721755a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968268; x=1770573068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=KgD3a3GMXpnsWPTJf7bDLd0ytX7nFM0ngn8IA5q75U2b+9M5DzsdrgAkmf6gXkhbzP
         VHLAoRfQ1eX6K4hB0XYj1hEZKtiBkm0uqi7H31lrT4lnBoq08hHBjBZqdAQO1UrIHtW5
         IeEMwUL2kf2JCN65XvukO1kPrsFEwKJg59bLzZ+NxgufMqVh/aJWYAXGlx53PTuEuALg
         4DS8PB8Cob8MsUJnrzSi1uz7hZc/dkTFEvrOnjvORHCbz1fJSkKk75LObycUsWDBj5be
         QBVsgpj0Pwm40K1fyxfX8lHBYGUSFh26pfw/HPO98OHFM0auzN+eY15fxSHnbUcWkbxb
         6CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968268; x=1770573068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=kDq4NJOxUNy0u53jOtCeil/H2EssH5ejxgLw9/HbLr4JkBfi6DlP/U4u/gcbghypMA
         /z4J5KWHeVWjAmW0WXK+v7nxPYhzHC71fIqDxSfDmv2qoL4x1vtRkSQ1bQ8CZpbCNRH0
         x7IZrPEpcVH/qBQj7suTt3tVSDlOCXP01NtA4CTmvnWJNigwHEpM8m1wgSawVGM7sOqe
         py/eFDTSxOloMUzyN1fv3j81RC9xbC4YTQVlFH0mvxnf5ylf2Yu6t9dAWQ2TdjOjqEiG
         9zZTZsAZZwnOVAMzt79p+s1SadPhq4sXHywdndMxE1TTN4Ik+pbD7P91maXx0AyXmZyf
         +0yw==
X-Gm-Message-State: AOJu0YwNjjas/5hPW6Aj+zIhG22cnOJO3WV4smYXbjkcsSvOiqRzAUoC
	WmZ2T8c+P6yIaPzCFPpdC0LdRtlf91qA+2Ow/yIARjiogknh8mfg39qn
X-Gm-Gg: AZuq6aKQgTV0H7QoJErprAlssJyKnQq4d70YdGkP5iJDWSnd45LdGKJjJi6S3OzMiKu
	OII8wzwWhZPIcTYB7Nva5MAXcQSR0aW0fijh91fcZt1wwKg2A6TRU7gfoBSLW/Qn8Oij9HCOQg1
	fcY4lfb7Yi/Q+JC5EZ4OnOi9OiCqxTv7zuCV6NW7lL4jNNBaBOZSY+2IvNz/392EcRALTaRFS43
	2xvotvBrKC2i1d1+YyD6hBXML1N0zMLEKAmSa+jDvGuMyh+KIPkc0bKNDXiEv3Xi/scjNxAQwjf
	pibXPWhtThr4ISpc8xiryoI16bEIpAOemdqzgfhrRxkT0x0DFfVy3IsqvvAh3rzrNcbN2AZER4A
	8BhRUbcmsOVcBnytNfe+tWWzcz4Kc7DACXt71Xm0I3/2kEi7C4vPZbdKfTfa6jlm4NMdy1eyLvQ
	zoqmEo5v5V2+0=
X-Received: by 2002:a17:90b:3b42:b0:353:6373:590b with SMTP id 98e67ed59e1d1-3543b3138ecmr10128847a91.7.1769968267672;
        Sun, 01 Feb 2026 09:51:07 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24aesm13228350a91.6.2026.02.01.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:06 -0800 (PST)
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
Subject: [PATCH bpf-next v5 13/16] selftests/bpf: Update task_local_storage/recursion test
Date: Sun,  1 Feb 2026 09:50:46 -0800
Message-ID: <20260201175050.468601-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255661-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 36796C6D50
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


