Return-Path: <netdev+bounces-142540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C060E9BF930
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33487B22A5C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90420CCE7;
	Wed,  6 Nov 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="En0Jt2sv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAD1DFE13
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931972; cv=none; b=iW3yLADp2vTM5Xot2TsHypeBcogx2ei4W1+8jwyVDTj75FhbDUlrnbEsRqVsGJzNOApbvPqYDYH1Cvu3ihwG2MHP6nP5Q1/D9lkej0KV7gCLmk6IILkmQCXJsdoivOzOm2gIYoCKyXZomrFpetS0zjaGnPJLVJywpuqFqivn/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931972; c=relaxed/simple;
	bh=aBzaZtXf4mNWyE2ff91L3zjcJqxmizoaLTC7A66Td/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/vZayfNWuS+aN2HbL6QEtRwEk7/fzjGxpv0Z+V4Itix3sxWcDiOe79P0Wr0WlQJnvVjquhj2tPbNAilNHlVr9w5MIrwwRGB2ADmdoshk7RiLi5Co2PRX0m9ooizfyViw2a4WhGrORoIpKHXOGw/cKCXZEbuZRE2rIWyxvP+Db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=En0Jt2sv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b14df8f821so21531885a.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931968; x=1731536768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyj1ZNcgRwOXsluqNrXT26K+za/Sz/ZFq8b64jlwILI=;
        b=En0Jt2sviOCu1qrum+8IiowetKbQR9oY7jHWpUW4bc8U7oxKQhWIkzNHzwR/AyUBjU
         uY8hV95CN0ijvaIpKBe0mJM1v3g2MIPPGQCSOrI0bNM25XpdiHnFpPWOgHJA1GQotODC
         L8EVxYgK/pyU4UlC3UFNWK9SCKIQjs2rHplnnQtR1Xbt1GfYgpGbYxhmQFsP73kkXHmO
         SyaZLucnJKpsHAHlbBqpInIpWMbersHG/MOhkAuwdUff7yLSRTg+DBnKdZVaPQtv+RD4
         ov2XaWo1aLL5j+oVhjjS2bLwVLOeHCtJk2rhc4U/9iltBeiDK8//d8Xi8JoSew7Ecntc
         Mzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931968; x=1731536768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyj1ZNcgRwOXsluqNrXT26K+za/Sz/ZFq8b64jlwILI=;
        b=ga8im0B3kGrosrj7w322/RaWeRmkCyUhl1BmWu6or75DXlrg8sBu1pJp79LTvRPoeu
         tPu5memo2wJaEnR5hEJr8/giEpxLrWbfJPtqGdk2RjPFZnyt31G6YQPqLDaNfBPx0EJB
         q20mdKElOIIUxtcd0tng3/ewI9mYGF7WQDY90HSFtlTUZToPAtItgEtkelDvx8Zr6VA/
         rYS9gXl7aTZbPd2Hvgl7pleL+pBQILuRD8qdpV8CrwCE7IBjGr/iw81vqxbKOGDIAXvm
         sCzQCl95VVutK17kqoA9L/D5LO92/T0i0jyd100TSm9TpbM7eVHaPhreAf3MefqQDDlF
         oIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV3YCxOEg4J+WdzIhtOuo+nyvhpeg4BbS4BwKWMMxE/BaCqrdcS3SqQHMUnPHHqaEXeaglmT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiZN81fI/1d8pWjx1cFa0otfWqXzmXGncULqfaJs2IJWM/XHu
	klgRJ0Z9YegctPJPvLHEOnEbd4bHYCj1UnBUDelLXSvYfIWifgVOR/cFkaLpgXA=
X-Google-Smtp-Source: AGHT+IHc/kYW0Q/OGHo359uvtjMVCgSdWB6E2qdRtHfBLzvGp7NFxdZuLEsKT6TDiMcpujKSVy0UHg==
X-Received: by 2002:a05:620a:461f:b0:7ac:bb36:5667 with SMTP id af79cd13be357-7b2fb9d87acmr3100743385a.59.1730931968439;
        Wed, 06 Nov 2024 14:26:08 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:07 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
Date: Wed,  6 Nov 2024 22:25:12 +0000
Message-Id: <20241106222520.527076-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Several fixes to test_sockmap and added push/pop logic for msg_verify_data
Before the fixes, some of the tests in test_sockmap are problematic,
resulting in pseudo-correct result.

1. txmsg_pass is not set in some tests, as a result, no eBPF program is
attached to the sockmap.
2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
test skippings and failures.
3. The calculation of total_bytes in msg_loop_rx is wrong, which may cause
msg_loop_rx end early and skip some data tests.

Besides, for msg_verify_data, I added push/pop checking logic to function
msg_verify_data and added more tests for different cases.

After that, I found that there are some bugs in bpf_msg_push_data,
bpf_msg_pop_data and sk_msg_reset_curr, and fix them. I guess the reason
why they have not been exposed is that because of the above problems, they
will not be triggered.

With the fixes, we can pass the sockmap test with data integrity test now.
However, the fixes to test_sockmap expose more problems in sockhash test
with SENDPAGE and ktls with SENDPAGE.

v1 -> v2:
  - Rebased to the latest bpf-next net branch.

The problem I observed,
1. In sockhash test, a NULL pointer kernel BUG will be reported for nearly
every cork test. More inspections are needed for splice_to_socket.

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0 
Oops: Oops: 0000 [#3] PREEMPT SMP PTI
CPU: 3 UID: 0 PID: 2122 Comm: test_sockmap 6.12.0-rc2.bm.1-amd64+ #98
Tainted: [D]=DIE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:splice_to_socket+0x34a/0x480
Call Trace:
 <TASK>
 ? __die_body+0x1e/0x60
 ? page_fault_oops+0x159/0x4d0
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? splice_to_socket+0x34a/0x480
? __memcg_slab_post_alloc_hook+0x205/0x3c0
? alloc_pipe_info+0xd6/0x1f0
? __kmalloc_noprof+0x37f/0x3b0
direct_splice_actor+0x40/0x100
splice_direct_to_actor+0xfd/0x290
? __pfx_direct_splice_actor+0x10/0x10
do_splice_direct_actor+0x82/0xb0
? __pfx_direct_file_splice_eof+0x10/0x10
do_splice_direct+0x13/0x20
? __pfx_direct_splice_actor+0x10/0x10
do_sendfile+0x33c/0x3f0
__x64_sys_sendfile64+0xa7/0xc0
do_syscall_64+0x62/0x170
entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---

2. txmsg_pass are not set before, and some tests are skipped. Now after
the fixes, we have some failure cases now. More fixes are needed either
for the selftest or the ktls kernel code.

1/ 6 sockhash:ktls:txmsg test passthrough:OK
2/ 6 sockhash:ktls:txmsg test redirect:OK
3/ 1 sockhash:ktls:txmsg test redirect wait send mem:OK
4/ 6 sockhash:ktls:txmsg test drop:OK
5/ 6 sockhash:ktls:txmsg test ingress redirect:OK
6/ 7 sockhash:ktls:txmsg test skb:OK
7/12 sockhash:ktls:txmsg test apply:OK
8/12 sockhash:ktls:txmsg test cork:OK
9/ 3 sockhash:ktls:txmsg test hanging corks:OK
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
10/11 sockhash:ktls:txmsg test push_data:FAIL
detected data corruption @iov[0]:0 17 != 00, 00 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 00 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
11/17 sockhash:ktls:txmsg test pull-data:FAIL
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
12/ 9 sockhash:ktls:txmsg test pop-data:FAIL
recv failed(): Bad message
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
13/ 6 sockhash:ktls:txmsg test push/pop data:FAIL
14/ 1 sockhash:ktls:txmsg test ingress parser:OK
15/ 0 sockhash:ktls:txmsg test ingress parser2:OK
Pass: 11 Fail: 17

Zijian Zhang (8):
  selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
  selftests/bpf: Fix SENDPAGE data logic in test_sockmap
  selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
  selftests/bpf: Add push/pop checking for msg_verify_data in
    test_sockmap
  selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
  bpf, sockmap: Several fixes to bpf_msg_push_data
  bpf, sockmap: Several fixes to bpf_msg_pop_data
  bpf, sockmap: Fix sk_msg_reset_curr

 net/core/filter.c                          |  88 +++++-----
 tools/testing/selftests/bpf/test_sockmap.c | 180 +++++++++++++++++++--
 2 files changed, 214 insertions(+), 54 deletions(-)

-- 
2.20.1


