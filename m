Return-Path: <netdev+bounces-304942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dFKlOMKCS2qdSgEAu9opvQ
	(envelope-from <netdev+bounces-304942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:26:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4E70F228
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WhLvnx6C;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304942-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304942-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B77E730A454C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA843B6F3;
	Mon,  6 Jul 2026 09:35:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35943B6C2
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330554; cv=none; b=Vz3yrz+zmYyWtoDThpk76WJsSFydSUoWdTERkwe8WlH+mrGBlcXccItg4SFgEp9C/AcPRKHclhy3JbeAuRottS6+Q+nD0xvjd5vmbsP8Fl2QEcTJOm+ocOMspo+e+O3Zg9vUH5abcRUYJl7LTjKt2ldgOI9RyS0Ufxd3RrVd9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330554; c=relaxed/simple;
	bh=fmndcjanViGcYEADoEdhV6jm9+Kn08sQMnFyvTnMC8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mET0p6TqoMJSGmSyXzURUav6wHG2xx3HzkWyboY2qJVHBBo+ZTkpA0Pe+Sc6YwYfWSp+uVfjZmzc/QNbeXRawoDkz4wrvMsEft5nRRlyuH0GksPhUvQocBJxq8igAJTNCbTYOGagbNgkjJDhn5uyYjCOq+WsxRZqQvkdtv1/A7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhLvnx6C; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-471eeac43bfso3165476f8f.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330547; x=1783935347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXbm3wjsqVGwtNUtH3eqoaK9MP9AOKrO2JGwf5Teq3o=;
        b=WhLvnx6C/ARR+StkdzT1VHIyi8Gsd9WcT3TZ5BSxc4O0rktfzedQY4pJw7OluHx2z4
         A1lQGG/FXmK7sX5nLtunXErlLCfYDH7Cv7y8A1D4Hnk3o5gK+P4YzYn3NjPBBgZppVny
         ftqWWzqzVeP2rQEKuHUn/RaYL2XO+jvowwOD9msbcEoai0nX8jAWws7ubKvPaxHGhqu7
         K0uEt67uLNu6+nKtFxdlpQUtCkuerYVG0Y9N4zZqBU/VNA5jmb2Gqfp5kLf0cMinDUJz
         kkLLIKZYI9gm/OkUkJL4nzKBEPVu/0oAXdLjkv0O9t/q3cY4gGp4Hm8h7tM5KTmMGXly
         PT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330547; x=1783935347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXbm3wjsqVGwtNUtH3eqoaK9MP9AOKrO2JGwf5Teq3o=;
        b=s48BUfWyqPSj4e3n0lyV06gxsuqP19t6AUUvwHmgqsBRRnBSSRL3hKVbJ9G5s2GqES
         N97Qo5/lPU8BSBpyovoj6VGWGwIv6vDo1iVGO2oUURNUA+q/4PKVP/yB7Nvx2d1yrrMT
         eJv6rEG0nnwKQulkFoXffn1PClZHRCqmpMksf+S7P7igfy9Rsdnec3bYx2VIQJBquDez
         P0SNQA6t1iwPZzsBJlH1+Vm3BH5/sEUZPBxb5KIW2tERnnDb11vLB449PjhHYcbKu/de
         +v7PDRp7uhxVvbfgrrOIFPWApHeUcAFIquzECeqi2cydXPn9hg1XCuZHTNP962bn81vb
         Hy7A==
X-Forwarded-Encrypted: i=1; AHgh+RrgZ1K1WnPR0KJj9jVDBlBD7lLT7yUz4xlE2dbkj8dGkG0j860SbYw1Eil2cwvJi8snJ3pYw1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsm71+n0THlqgUgdVzwSftJNeNe4qKeDRiAGV6zU9JxanVTC+C
	/KIKLRMhofc97P+OPevgKhylqrVjv1JJJoPRHESuZfOGtLaf/0F+q4vc
X-Gm-Gg: AfdE7clY11+KOVXEQnPLXSqwud6YU/PWkEfQCqU8U8FW/MAEGn1w8gHHrKVA1coqKTA
	eQjegIWmdLbTuEHwpteyqjpK6q3h953Oy+OuPWR53h5niPFHCg/uAYiObwyQS7uFIKiOJdFT0pa
	haGsYX9hzDa3XZTzK6Rl+5T/Tte3Jvrwv+sO3JaDLCmLgpR1gi9+EcDyzSwEQUQ6627d4uY8fSH
	ro0yTv9qpYhqQ7+U9HdO6nocosUUnI8mCQlEhB/GcAHvmgHY5fkPXClPSn+X3T5UiyMb+07hY2y
	6fcnw9/8inwv8S8Zvad8HEHBZ78cOWj6LCN5+ONhOuZ6rOlFkZczsjsU7uOVQVNxNyIjmnsWEEn
	FMSvHmP2l3GoD5/PvHoHA029FpYRlwMMXYDXUP9uEu7YABDM58LJuhATVetqub/9vb24ncR7EDI
	5kqZ+YN9PlFD+UmEFsMeYEnJE3L4Q=
X-Received: by 2002:a05:6000:2086:b0:472:f8b5:aaca with SMTP id ffacd0b85a97d-47aaa60d3cemr11695895f8f.15.1783330546444;
        Mon, 06 Jul 2026 02:35:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:46 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Add ksock test for async callback guard
Date: Mon,  6 Jul 2026 09:35:25 +0000
Message-Id: <20260706093525.13030-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304942-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahe.tardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AA4E70F228

Because the kfuncs are going through LSM hooks, allowing their use via
workqueue callbacks would expose the wrong credentials. This test
ensures the kfunc are preventing any use from these contexts.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_wq.c       | 34 ++++++++++
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 62 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
new file mode 100644
index 000000000000..184b134f3823
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "ksock_wq.skel.h"
+
+void test_ksock_wq(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_wq *skel;
+	int err;
+
+	skel = ksock_wq__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
+				     &opts);
+	if (!ASSERT_OK(err, "run ksock_wq_start"))
+		goto out;
+	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
+		goto out;
+
+	while (!__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+		usleep(1000);
+
+	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
+		  "workqueue create rejected");
+
+out:
+	ksock_wq__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
new file mode 100644
index 000000000000..16a1873d132e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_tracing_net.h"
+#include "errno.h"
+#include "ksock_common.h"
+
+struct ksock_wq_value {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct ksock_wq_value);
+} work_map SEC(".maps");
+
+int create_err;
+u32 callback_done;
+
+static int ksock_wq_callback(void *map, int *key, void *value)
+{
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (ks)
+		bpf_ksock_release(ks);
+	create_err = err;
+	__sync_fetch_and_add(&callback_done, 1);
+	return 0;
+}
+
+SEC("syscall")
+int ksock_wq_start(void *ctx)
+{
+	struct ksock_wq_value *value;
+	u32 key = 0;
+	int err;
+
+	value = bpf_map_lookup_elem(&work_map, &key);
+	if (!value)
+		return -ENOENT;
+	err = bpf_wq_init(&value->work, &work_map, 0);
+	if (err)
+		return err;
+	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
+	if (err)
+		return err;
+	return bpf_wq_start(&value->work, 0);
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1


