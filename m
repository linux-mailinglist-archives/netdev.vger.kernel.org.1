Return-Path: <netdev+bounces-256017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCjREfkbgWm0EAMAu9opvQ
	(envelope-from <netdev+bounces-256017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:49:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B880FD1D44
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B8E30484F0
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6DE3164BB;
	Mon,  2 Feb 2026 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkT4ZDO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5F3112B7
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068902; cv=none; b=Fc4XhhS7h3uAnOcsRcG9aU4VuELkynoKhrx6643bhcKGEXVJmvgzmbW8I5aXYAS+wlaTC20517ok/32m/BjO4WMdrXFJ9h7R/ot/KZWXD0tcK/FKSUE17J66PJhEirDUXcC7LvuI8OyBYxvZ7XgZSE9AJYpfTk9myKlEzSYIJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068902; c=relaxed/simple;
	bh=HMRlS0Let/68w9OOEvba1qcpKrMuE75Li8eyGGAGkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aij71L6Z1AEf+LZzxJMf5bPaO7G5bSaz/L1Fy+pGbiNaqPk+VSQoMHv766y7ZbXL/BR9lNUMjuim6ZIUQBS3SnJpUO0L+WLLRaIOlJgplHmIXbiAIkae3OQkF0UofCss5ZYL7MWc6pCnYZ39L/aPJb4se4cnQwsDHAwKQlws9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkT4ZDO8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c56188aef06so2426963a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068900; x=1770673700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3bkWTyaLnMszPbw31nXzJPzmLRwndvqCUAVLWuq6DQ=;
        b=lkT4ZDO8wJz0VWoNu7qAZyr0mi7GxBfYV3++gKmQ7jcYTTJjDw5NAdKkms/iKqRgsa
         mybFyPXTaJnRR1gzLoVuxybmMQImK6kJwPsaBcc4nl/TAdLA2LkG8KN8rHSnkb5QHrLd
         PGVb4K28ahFchbuGanqozi6BxDzwTgxdyEXv37Shr1+A+6e4NFEtRe7kqd3OdF8cmbqo
         77zcxLYEkBWPtqV0nk75xaDKSgYT2wSkaA1QleUspt1sV4qXimMQ/jKqfT7qVHiMJ8KI
         SMIIjo2PqCkiHArzLF5cx7e0YhC8TpHwZfyVp0O3zx8sEfBWyZTHAHhK2kx1DXvYt1n/
         vXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068900; x=1770673700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3bkWTyaLnMszPbw31nXzJPzmLRwndvqCUAVLWuq6DQ=;
        b=wfc2y4kFh5dffMRdVHrHolKxbz1x504/rGJC23w808ZYP+wK9Pub5Wo+VCgdPbLPqE
         c1Ww5u7cSoiXmSIBiJRJOX2YrNdpu55IGZgULJWqTabDdUHish8PfK3f9YV/7uloyXIe
         vbda0S0o7Vp0fJv5ZdsxOt73ZENg92V/6A2DBUKC6M/Z1crI4+2DsO1lmDVbWSo4rPqi
         Sx8VXE85qo842ogUQqafCpL/yRH+MP+iewFP9Kl4Law8hqB4GtJJxh2aDI1j3h+t68Am
         JgPhBNh9RPPSRiIJuWv/duzQFw2zoeLKSO93+UEZktAmF6j6wc8kXUZKxmz1GkCS+yUY
         HaRw==
X-Gm-Message-State: AOJu0YxQegQZuzMofogrwdDocVTSF5/JbbgCnfgk3vnwmPK4GzYJPQjQ
	6KIvCAU73N8xYnAvRW51mu1/bxHBolbGqoeyU4eEm2JIgYCFlmV/hPtB
X-Gm-Gg: AZuq6aIWVndZAurwPDAihpAwivEBL1hcr0CnBz00Lvv8CuIpAPr1wMvAZseOnqCq+mu
	CEujof+ano97EkNn9nDtuo4MzPi3oCgySJRnDWXTxJZae62VaVUYRR/GrAIjP6iPwowFuVJrD+E
	kaBXKU3OC0sW+kKZBweY3YySA9l18orR6smjlTlSH/iROyzT+/Yy8EqolM6NYUKuZzHHUcgJEaO
	jKrEZk3hsnYld1zM0lkMiaU022V8gKoMNDbNLar4MKMP5n43M/czgdOojYV7sQYF8FKje9+aCWv
	aDslm4MPJ3Hkv7hSAV6l5zfZ4dg/NdoTNjDUFqA/aQEKlczpjr+AQ78wLScq/teh0EsYjkeDF7C
	iFI7hrunIDjbMYicDhUkLr3yH8soOxj136cn7WfdTREiIKNSZPwLAHeOzjXwBc2MLHR+WqpGsgI
	bPOw==
X-Received: by 2002:a17:903:24e:b0:2a7:aa9e:fb51 with SMTP id d9443c01a7336-2a8d9a5717cmr123752425ad.46.1770068900308;
        Mon, 02 Feb 2026 13:48:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef68sm163859815ad.16.2026.02.02.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:19 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 3/4] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Mon,  2 Feb 2026 13:48:16 -0800
Message-ID: <20260202214817.2853236-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
References: <20260202214817.2853236-1-ameryhung@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256017-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B880FD1D44
X-Rspamd-Action: no action

Make sure the verifier invalidates the dynptr and dynptr slice derived
from an skb after the skb is freed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 36 ++++++++++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 62 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 68 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 64 +++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..ec5b346138c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -8,6 +8,9 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 #include "bpf_qdisc_fail__incompl_ops.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -156,6 +159,33 @@ static void test_incompl_ops(void)
 	bpf_qdisc_fail__incompl_ops__destroy(skel);
 }
 
+static void test_invalid_dynptr(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr__destroy(skel);
+}
+
+static void test_invalid_dynptr_slice(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr_slice *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr_slice__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr_slice__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr_slice__destroy(skel);
+}
+
+static void test_invalid_dynptr_cross_frame(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr_cross_frame *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr_cross_frame__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr_cross_frame__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr_cross_frame__destroy(skel);
+}
+
 static int get_default_qdisc(char *qdisc_name)
 {
 	FILE *f;
@@ -223,6 +253,12 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	if (test__start_subtest("invalid_dynptr"))
+		test_invalid_dynptr();
+	if (test__start_subtest("invalid_dynptr_slice"))
+		test_invalid_dynptr_slice();
+	if (test__start_subtest("invalid_dynptr_cross_frame"))
+		test_invalid_dynptr_cross_frame();
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
new file mode 100644
index 000000000000..2e76470bc261
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	proto = hdr->h_proto;
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)bpf_qdisc_test_enqueue,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
new file mode 100644
index 000000000000..936bf4bc79bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+static int free_skb(struct sk_buff *skb)
+{
+	bpf_kfree_skb(skb);
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	free_skb(skb);
+
+	proto = hdr->h_proto;
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)bpf_qdisc_test_enqueue,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
new file mode 100644
index 000000000000..95e8c070a37d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	proto = hdr->h_proto;
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)bpf_qdisc_test_enqueue,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.47.3


